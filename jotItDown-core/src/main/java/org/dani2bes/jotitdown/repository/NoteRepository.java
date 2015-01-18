package org.dani2bes.jotitdown.repository;
import org.dani2bes.jotitdown.domain.Note;
import org.springframework.roo.addon.layers.repository.jpa.RooJpaRepository;

@RooJpaRepository(domainType = Note.class)
public interface NoteRepository {
}
