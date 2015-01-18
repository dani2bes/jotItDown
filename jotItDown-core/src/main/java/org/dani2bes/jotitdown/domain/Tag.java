package org.dani2bes.jotitdown.domain;
import org.springframework.roo.addon.javabean.RooJavaBean;
import org.springframework.roo.addon.jpa.entity.RooJpaEntity;
import org.springframework.roo.addon.tostring.RooToString;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.ManyToMany;
import javax.validation.constraints.NotNull;

@RooJavaBean
@RooToString
@RooJpaEntity
public class Tag {

    /**
     */
    @NotNull
    private String name;

    /**
     */
    @ManyToMany(cascade = CascadeType.ALL, mappedBy = "tags")
    private Set<Note> notes = new HashSet<Note>();
}
