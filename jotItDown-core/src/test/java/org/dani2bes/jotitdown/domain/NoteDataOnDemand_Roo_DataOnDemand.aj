// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.dani2bes.jotitdown.domain;

import java.security.SecureRandom;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;
import java.util.Random;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.dani2bes.jotitdown.domain.Note;
import org.dani2bes.jotitdown.domain.NoteDataOnDemand;
import org.dani2bes.jotitdown.domain.NoteUser;
import org.dani2bes.jotitdown.repository.NoteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

privileged aspect NoteDataOnDemand_Roo_DataOnDemand {
    
    declare @type: NoteDataOnDemand: @Component;
    
    private Random NoteDataOnDemand.rnd = new SecureRandom();
    
    private List<Note> NoteDataOnDemand.data;
    
    @Autowired
    NoteRepository NoteDataOnDemand.noteRepository;
    
    public Note NoteDataOnDemand.getNewTransientNote(int index) {
        Note obj = new Note();
        setLastModified(obj, index);
        setNoteUser(obj, index);
        setText(obj, index);
        setTitle(obj, index);
        return obj;
    }
    
    public void NoteDataOnDemand.setLastModified(Note obj, int index) {
        Date lastModified = new GregorianCalendar(Calendar.getInstance().get(Calendar.YEAR), Calendar.getInstance().get(Calendar.MONTH), Calendar.getInstance().get(Calendar.DAY_OF_MONTH), Calendar.getInstance().get(Calendar.HOUR_OF_DAY), Calendar.getInstance().get(Calendar.MINUTE), Calendar.getInstance().get(Calendar.SECOND) + new Double(Math.random() * 1000).intValue()).getTime();
        obj.setLastModified(lastModified);
    }
    
    public void NoteDataOnDemand.setNoteUser(Note obj, int index) {
        NoteUser noteUser = null;
        obj.setNoteUser(noteUser);
    }
    
    public void NoteDataOnDemand.setText(Note obj, int index) {
        String text = "text_" + index;
        obj.setText(text);
    }
    
    public void NoteDataOnDemand.setTitle(Note obj, int index) {
        String title = "title_" + index;
        obj.setTitle(title);
    }
    
    public Note NoteDataOnDemand.getSpecificNote(int index) {
        init();
        if (index < 0) {
            index = 0;
        }
        if (index > (data.size() - 1)) {
            index = data.size() - 1;
        }
        Note obj = data.get(index);
        Long id = obj.getId();
        return noteRepository.findOne(id);
    }
    
    public Note NoteDataOnDemand.getRandomNote() {
        init();
        Note obj = data.get(rnd.nextInt(data.size()));
        Long id = obj.getId();
        return noteRepository.findOne(id);
    }
    
    public boolean NoteDataOnDemand.modifyNote(Note obj) {
        return false;
    }
    
    public void NoteDataOnDemand.init() {
        int from = 0;
        int to = 10;
        data = noteRepository.findAll(new org.springframework.data.domain.PageRequest(from / to, to)).getContent();
        if (data == null) {
            throw new IllegalStateException("Find entries implementation for 'Note' illegally returned null");
        }
        if (!data.isEmpty()) {
            return;
        }
        
        data = new ArrayList<Note>();
        for (int i = 0; i < 10; i++) {
            Note obj = getNewTransientNote(i);
            try {
                noteRepository.save(obj);
            } catch (final ConstraintViolationException e) {
                final StringBuilder msg = new StringBuilder();
                for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                    final ConstraintViolation<?> cv = iter.next();
                    msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
                }
                throw new IllegalStateException(msg.toString(), e);
            }
            noteRepository.flush();
            data.add(obj);
        }
    }
    
}
