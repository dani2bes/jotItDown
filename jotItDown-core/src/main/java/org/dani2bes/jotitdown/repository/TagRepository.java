package org.dani2bes.jotitdown.repository;
import org.dani2bes.jotitdown.domain.Tag;
import org.springframework.roo.addon.layers.repository.jpa.RooJpaRepository;

@RooJpaRepository(domainType = Tag.class)
public interface TagRepository {
}
