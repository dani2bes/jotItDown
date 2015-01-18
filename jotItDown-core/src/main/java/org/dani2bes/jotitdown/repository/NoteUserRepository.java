package org.dani2bes.jotitdown.repository;
import org.dani2bes.jotitdown.domain.NoteUser;
import org.springframework.roo.addon.layers.repository.jpa.RooJpaRepository;

@RooJpaRepository(domainType = NoteUser.class)
public interface NoteUserRepository {
}
