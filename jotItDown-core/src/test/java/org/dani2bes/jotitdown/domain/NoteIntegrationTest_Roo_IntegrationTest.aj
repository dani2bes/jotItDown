// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.dani2bes.jotitdown.domain;

import java.util.Iterator;
import java.util.List;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.dani2bes.jotitdown.domain.NoteDataOnDemand;
import org.dani2bes.jotitdown.domain.NoteIntegrationTest;
import org.dani2bes.jotitdown.repository.NoteRepository;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect NoteIntegrationTest_Roo_IntegrationTest {
    
    declare @type: NoteIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: NoteIntegrationTest: @ContextConfiguration(locations = "classpath*:/META-INF/spring/applicationContext*.xml");
    
    declare @type: NoteIntegrationTest: @Transactional;
    
    @Autowired
    NoteDataOnDemand NoteIntegrationTest.dod;
    
    @Autowired
    NoteRepository NoteIntegrationTest.noteRepository;
    
    @Test
    public void NoteIntegrationTest.testCount() {
        Assert.assertNotNull("Data on demand for 'Note' failed to initialize correctly", dod.getRandomNote());
        long count = noteRepository.count();
        Assert.assertTrue("Counter for 'Note' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void NoteIntegrationTest.testFind() {
        Note obj = dod.getRandomNote();
        Assert.assertNotNull("Data on demand for 'Note' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Note' failed to provide an identifier", id);
        obj = noteRepository.findOne(id);
        Assert.assertNotNull("Find method for 'Note' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'Note' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void NoteIntegrationTest.testFindAll() {
        Assert.assertNotNull("Data on demand for 'Note' failed to initialize correctly", dod.getRandomNote());
        long count = noteRepository.count();
        Assert.assertTrue("Too expensive to perform a find all test for 'Note', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<Note> result = noteRepository.findAll();
        Assert.assertNotNull("Find all method for 'Note' illegally returned null", result);
        Assert.assertTrue("Find all method for 'Note' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void NoteIntegrationTest.testFindEntries() {
        Assert.assertNotNull("Data on demand for 'Note' failed to initialize correctly", dod.getRandomNote());
        long count = noteRepository.count();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<Note> result = noteRepository.findAll(new org.springframework.data.domain.PageRequest(firstResult / maxResults, maxResults)).getContent();
        Assert.assertNotNull("Find entries method for 'Note' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'Note' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void NoteIntegrationTest.testFlush() {
        Note obj = dod.getRandomNote();
        Assert.assertNotNull("Data on demand for 'Note' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Note' failed to provide an identifier", id);
        obj = noteRepository.findOne(id);
        Assert.assertNotNull("Find method for 'Note' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyNote(obj);
        Integer currentVersion = obj.getVersion();
        noteRepository.flush();
        Assert.assertTrue("Version for 'Note' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void NoteIntegrationTest.testSaveUpdate() {
        Note obj = dod.getRandomNote();
        Assert.assertNotNull("Data on demand for 'Note' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Note' failed to provide an identifier", id);
        obj = noteRepository.findOne(id);
        boolean modified =  dod.modifyNote(obj);
        Integer currentVersion = obj.getVersion();
        Note merged = noteRepository.save(obj);
        noteRepository.flush();
        Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        Assert.assertTrue("Version for 'Note' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void NoteIntegrationTest.testSave() {
        Assert.assertNotNull("Data on demand for 'Note' failed to initialize correctly", dod.getRandomNote());
        Note obj = dod.getNewTransientNote(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'Note' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'Note' identifier to be null", obj.getId());
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
        Assert.assertNotNull("Expected 'Note' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void NoteIntegrationTest.testDelete() {
        Note obj = dod.getRandomNote();
        Assert.assertNotNull("Data on demand for 'Note' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'Note' failed to provide an identifier", id);
        obj = noteRepository.findOne(id);
        noteRepository.delete(obj);
        noteRepository.flush();
        Assert.assertNull("Failed to remove 'Note' with identifier '" + id + "'", noteRepository.findOne(id));
    }
    
}
