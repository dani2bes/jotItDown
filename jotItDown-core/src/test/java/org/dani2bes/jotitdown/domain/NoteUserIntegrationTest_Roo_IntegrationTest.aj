// WARNING: DO NOT EDIT THIS FILE. THIS FILE IS MANAGED BY SPRING ROO.
// You may push code into the target .java compilation unit if you wish to edit any member(s).

package org.dani2bes.jotitdown.domain;

import java.util.Iterator;
import java.util.List;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import org.dani2bes.jotitdown.domain.NoteUserDataOnDemand;
import org.dani2bes.jotitdown.domain.NoteUserIntegrationTest;
import org.dani2bes.jotitdown.repository.NoteUserRepository;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

privileged aspect NoteUserIntegrationTest_Roo_IntegrationTest {
    
    declare @type: NoteUserIntegrationTest: @RunWith(SpringJUnit4ClassRunner.class);
    
    declare @type: NoteUserIntegrationTest: @ContextConfiguration(locations = "classpath*:/META-INF/spring/applicationContext*.xml");
    
    declare @type: NoteUserIntegrationTest: @Transactional;
    
    @Autowired
    NoteUserDataOnDemand NoteUserIntegrationTest.dod;
    
    @Autowired
    NoteUserRepository NoteUserIntegrationTest.noteUserRepository;
    
    @Test
    public void NoteUserIntegrationTest.testCount() {
        Assert.assertNotNull("Data on demand for 'NoteUser' failed to initialize correctly", dod.getRandomNoteUser());
        long count = noteUserRepository.count();
        Assert.assertTrue("Counter for 'NoteUser' incorrectly reported there were no entries", count > 0);
    }
    
    @Test
    public void NoteUserIntegrationTest.testFind() {
        NoteUser obj = dod.getRandomNoteUser();
        Assert.assertNotNull("Data on demand for 'NoteUser' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'NoteUser' failed to provide an identifier", id);
        obj = noteUserRepository.findOne(id);
        Assert.assertNotNull("Find method for 'NoteUser' illegally returned null for id '" + id + "'", obj);
        Assert.assertEquals("Find method for 'NoteUser' returned the incorrect identifier", id, obj.getId());
    }
    
    @Test
    public void NoteUserIntegrationTest.testFindAll() {
        Assert.assertNotNull("Data on demand for 'NoteUser' failed to initialize correctly", dod.getRandomNoteUser());
        long count = noteUserRepository.count();
        Assert.assertTrue("Too expensive to perform a find all test for 'NoteUser', as there are " + count + " entries; set the findAllMaximum to exceed this value or set findAll=false on the integration test annotation to disable the test", count < 250);
        List<NoteUser> result = noteUserRepository.findAll();
        Assert.assertNotNull("Find all method for 'NoteUser' illegally returned null", result);
        Assert.assertTrue("Find all method for 'NoteUser' failed to return any data", result.size() > 0);
    }
    
    @Test
    public void NoteUserIntegrationTest.testFindEntries() {
        Assert.assertNotNull("Data on demand for 'NoteUser' failed to initialize correctly", dod.getRandomNoteUser());
        long count = noteUserRepository.count();
        if (count > 20) count = 20;
        int firstResult = 0;
        int maxResults = (int) count;
        List<NoteUser> result = noteUserRepository.findAll(new org.springframework.data.domain.PageRequest(firstResult / maxResults, maxResults)).getContent();
        Assert.assertNotNull("Find entries method for 'NoteUser' illegally returned null", result);
        Assert.assertEquals("Find entries method for 'NoteUser' returned an incorrect number of entries", count, result.size());
    }
    
    @Test
    public void NoteUserIntegrationTest.testFlush() {
        NoteUser obj = dod.getRandomNoteUser();
        Assert.assertNotNull("Data on demand for 'NoteUser' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'NoteUser' failed to provide an identifier", id);
        obj = noteUserRepository.findOne(id);
        Assert.assertNotNull("Find method for 'NoteUser' illegally returned null for id '" + id + "'", obj);
        boolean modified =  dod.modifyNoteUser(obj);
        Integer currentVersion = obj.getVersion();
        noteUserRepository.flush();
        Assert.assertTrue("Version for 'NoteUser' failed to increment on flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void NoteUserIntegrationTest.testSaveUpdate() {
        NoteUser obj = dod.getRandomNoteUser();
        Assert.assertNotNull("Data on demand for 'NoteUser' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'NoteUser' failed to provide an identifier", id);
        obj = noteUserRepository.findOne(id);
        boolean modified =  dod.modifyNoteUser(obj);
        Integer currentVersion = obj.getVersion();
        NoteUser merged = noteUserRepository.save(obj);
        noteUserRepository.flush();
        Assert.assertEquals("Identifier of merged object not the same as identifier of original object", merged.getId(), id);
        Assert.assertTrue("Version for 'NoteUser' failed to increment on merge and flush directive", (currentVersion != null && obj.getVersion() > currentVersion) || !modified);
    }
    
    @Test
    public void NoteUserIntegrationTest.testSave() {
        Assert.assertNotNull("Data on demand for 'NoteUser' failed to initialize correctly", dod.getRandomNoteUser());
        NoteUser obj = dod.getNewTransientNoteUser(Integer.MAX_VALUE);
        Assert.assertNotNull("Data on demand for 'NoteUser' failed to provide a new transient entity", obj);
        Assert.assertNull("Expected 'NoteUser' identifier to be null", obj.getId());
        try {
            noteUserRepository.save(obj);
        } catch (final ConstraintViolationException e) {
            final StringBuilder msg = new StringBuilder();
            for (Iterator<ConstraintViolation<?>> iter = e.getConstraintViolations().iterator(); iter.hasNext();) {
                final ConstraintViolation<?> cv = iter.next();
                msg.append("[").append(cv.getRootBean().getClass().getName()).append(".").append(cv.getPropertyPath()).append(": ").append(cv.getMessage()).append(" (invalid value = ").append(cv.getInvalidValue()).append(")").append("]");
            }
            throw new IllegalStateException(msg.toString(), e);
        }
        noteUserRepository.flush();
        Assert.assertNotNull("Expected 'NoteUser' identifier to no longer be null", obj.getId());
    }
    
    @Test
    public void NoteUserIntegrationTest.testDelete() {
        NoteUser obj = dod.getRandomNoteUser();
        Assert.assertNotNull("Data on demand for 'NoteUser' failed to initialize correctly", obj);
        Long id = obj.getId();
        Assert.assertNotNull("Data on demand for 'NoteUser' failed to provide an identifier", id);
        obj = noteUserRepository.findOne(id);
        noteUserRepository.delete(obj);
        noteUserRepository.flush();
        Assert.assertNull("Failed to remove 'NoteUser' with identifier '" + id + "'", noteUserRepository.findOne(id));
    }
    
}
