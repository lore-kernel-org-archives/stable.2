Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=146.20.161.86
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504813;
	b=MzkY83CpcB/ne2xCpiAezjMieecoK55+cPYl4PBQBXaf2ANEtQfvIuz5ucGCAPY5gEJs
	 cuq/wXE1PS/uKwpVRbOlYzXiEaPhahdId6zy/e3TXrVfLdQJP7qPq/YpiOZ6gHb++e0vr
	 LTsYa7IS17Bmcz9j+/6I+TGOAlWlLtnLIw4FGdUj77hULGd3CRZ+4bITE5ew3/J76OHTn
	 o8Y22JukAeG6nuqnGhGFzouuLzqsVtHH296Z7KQHuvRiiXEo+H2MxGNgYlgqw+zgpHAPX
	 xzE0OiMGXyXg4RQ37AYUzy8RESYGvTCFO2g/XJsHQ5eyMWcl637rGTzHbCHRHUfWEWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504813;
	h=DMARC-Filter:DKIM-Signature:X-Auth-ID:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Classification-ID;
	bh=L/oYB+JT/KtB7c1nfTYh19/iMevVNz+00g+BT8ptenQ=;
	b=ShxUcQCge/CKa5du11iUJjFs/VoV0gAW5BQmgREW5+3TMSxmE/6XmUqrTw1rwCBo+bnS
	 cA5lfe0EZ2daelImYvt1jouhOUhJXP77ZmU8EUfJVLs3l8Nnla2pt8llNKPEjT6ufadpZ
	 24HNVBd18EXd66wWFXf59DnOr7D1Ixz4itm2aY/GDUxNtE1/qMRFASCUTdTQxT11+dm34
	 z+w06selvX8ZjHv3n8JcLGB73FvnVog1ndxZ1wYDs9zFOxOA0MVRD+Z+nPj4dHorfBL4A
	 Ozav0htNak2nAnA1xSmkrwlg+We0lpbvlDMNBs3XsZ14sYvO8aEYkSQngz6c9ZCHX2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mev.co.uk;
	spf=pass smtp.mailfrom=mev.co.uk;
	dkim=pass header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=QvsjVsQ9;
	arc=none smtp.remote-ip=146.20.161.86
Received: from smtp86.iad3b.emailsrvr.com (smtp86.iad3b.emailsrvr.com [146.20.161.86])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F5606A8B8
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 17:33:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C51F5606A8B8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.a=rsa-sha256 header.s=20221208-6x11dpa4 header.b=QvsjVsQ9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1794504805;
	bh=nGTfKS/3xRm1S3N2otPrhgtKNSK+HZHF4OsBjyuC6PY=;
	h=From:To:Subject:Date:From;
	b=QvsjVsQ9Cv0630M94mqb5HcjhGkKa+Io+MXpRmY7oazVzwoyBoKYFcRyABuwDsHq6
	 fjlkRx7CKnbj+ckAob2UCXQrKvVRU6ejVo1IPVGJlM+1av+0SJkXIjY6KC6Oc84jSL
	 vJr8+Q+uTrEHNhNAVkUyXIx3bRETm3Sc44PD5H1Q=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp11.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 1DD5940312;
	Thu, 12 Nov 2026 12:33:25 -0500 (EST)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	stable@vger.kernel.org
Subject: [PATCH] comedi: fix another race between polling and detaching
Date: Thu, 12 Nov 2026 17:33:14 +0000
Message-ID: <20261112173314.118594-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: f5525a93-3ac4-4702-89ae-099d7d99a9c6-1-1

Commit 35b6fc51c666 ("comedi: fix race between polling and detaching")
fixed a race between the polling file operation and a "detachment" of
the comedi device (unlinking it from the low-level comedi driver) that
is performed via the COMEDI_DEVCONFIG ioctl command.  It did that by
refusing to detach the comedi device if there are any tasks sleeping on
any of its wait queues.

That commit did not address a similar problem of having to detach the
comedi device when the low-level hardware device is being removed from
its bus.  The actual detachment is handled by
comedi_device_detach_locked() that is called with the comedi device's
main mutex locked and its `attach_lock` rw_semaphore write-locked.  It
calls comedi_device_cancel_all() which will wake up any tasks on the
wait queues, marks the device as no longer attached, and calls
comedi_detach_cleanup() to do further cleaning up.  The problem is that
cleaning up frees the storage that contains the wait_queue_head_t
objects that tasks may have been sleeping on.  Although those tasks have
been woken up, they are probably stuck trying to read-lock the
`attach_lock` rw_semaphore.

To address the problem of woken up tasks stuck trying to read-lock the
`attach_lock` rw_semaphore, call new function
comedi_device_has_sleeper() to check if any tasks are on any of the wait
queues.  If that returns true, temporarily unlock the `attach_lock`
rw_semaphore and call schedule() until the wait queues are all clear.
Repeat that as necessary after write-locking the `attach_lock`
rw_semaphore again, although that shouldn't really be necessary.  It is
now safe to free the storage containing the wait_queue_head_t objects.

Also change the poll() file operation handler to return non filtered-out
events when the comedi device is marked as not attached, otherwise the
polling task will not get removed from the wait queues that the "detach"
handling task is waiting to become empty.

Apart from poll(), the read() and write() file operation handlers also
sleep on the wait queues, but currently they go to sleep while the
`attach_lock` rw_semaphore is still read-locked.  This will block the
"detaching" task indefinitely when it is trying to write-lock the
rw_semaphore, so there is no race.  That problem is not dealt with by
this patch.

The change introduced by commit 35b6fc51c666 ("comedi: fix race between
polling and detaching") no longer needs to refuse to detach the comedi
device if any tasks are queued on the wait queues, so remove that check.
Those tasks will have already been woken up by other code (because the
comedi device has no data acquisition commands active) and should remove
themselves from the wait queues (now that the poll() file operation
handler will return non filtered-out event), so the modified clean-up
code in this patch will now deal with the non-empty wait queues during
detachment.

Cc: <stable@vger.kernel.org> # 6.19+
Fixes: ed9eccbe8970 ("Staging: add comedi core")
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
Patch needs backporting to 6.18.y and earlier.
---
 drivers/comedi/comedi_fops.c | 26 +++++++++--------------
 drivers/comedi/drivers.c     | 40 +++++++++++++++++++++++++++++++++++-
 2 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/drivers/comedi/comedi_fops.c b/drivers/comedi/comedi_fops.c
index 6d71ceeff6fc4..461d4e8d7ad4a 100644
--- a/drivers/comedi/comedi_fops.c
+++ b/drivers/comedi/comedi_fops.c
@@ -859,13 +859,6 @@ static int is_device_busy(struct comedi_device *dev)
 			continue;
 		if (comedi_buf_is_mmapped(s))
 			return 1;
-		/*
-		 * There may be tasks still waiting on the subdevice's wait
-		 * queue, although they should already be about to be removed
-		 * from it since the subdevice has no active async command.
-		 */
-		if (wq_has_sleeper(&s->async->wait_head))
-			return 1;
 	}
 
 	return 0;
@@ -2608,7 +2601,7 @@ static int comedi_mmap(struct file *file, struct vm_area_struct *vma)
 
 static __poll_t comedi_poll(struct file *file, poll_table *wait)
 {
-	__poll_t mask = 0;
+	__poll_t mask = DEFAULT_POLLMASK;
 	struct comedi_file *cfp = file->private_data;
 	struct comedi_device *dev = cfp->dev;
 	struct comedi_subdevice *s, *s_read;
@@ -2617,6 +2610,7 @@ static __poll_t comedi_poll(struct file *file, poll_table *wait)
 
 	if (!dev->attached) {
 		dev_dbg(dev->class_dev, "no driver attached\n");
+		mask |= EPOLLERR | EPOLLPRI;
 		goto done;
 	}
 
@@ -2624,10 +2618,10 @@ static __poll_t comedi_poll(struct file *file, poll_table *wait)
 	s_read = s;
 	if (s && s->async) {
 		poll_wait(file, &s->async->wait_head, wait);
-		if (s->busy != file || !comedi_is_subdevice_running(s) ||
-		    (s->async->cmd.flags & CMDF_WRITE) ||
-		    _comedi_buf_read_n_available(s) > 0)
-			mask |= EPOLLIN | EPOLLRDNORM;
+		if (s->busy == file && comedi_is_subdevice_running(s) &&
+		    !(s->async->cmd.flags & CMDF_WRITE) &&
+		    !_comedi_buf_read_n_available(s))
+			mask &= ~(EPOLLIN | EPOLLRDNORM);
 	}
 
 	s = comedi_file_write_subdevice(file);
@@ -2636,10 +2630,10 @@ static __poll_t comedi_poll(struct file *file, poll_table *wait)
 
 		if (s != s_read)
 			poll_wait(file, &s->async->wait_head, wait);
-		if (s->busy != file || !comedi_is_subdevice_running(s) ||
-		    !(s->async->cmd.flags & CMDF_WRITE) ||
-		    comedi_buf_write_n_available(s) >= bps)
-			mask |= EPOLLOUT | EPOLLWRNORM;
+		if (s->busy == file && comedi_is_subdevice_running(s) &&
+		    (s->async->cmd.flags & CMDF_WRITE) &&
+		    comedi_buf_write_n_available(s) < bps)
+			mask &= ~(EPOLLOUT | EPOLLWRNORM);
 	}
 
 done:
diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
index 3f75485338a10..a9acf98138c92 100644
--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -153,6 +153,21 @@ int comedi_alloc_subdev_readback(struct comedi_subdevice *s)
 }
 EXPORT_SYMBOL_GPL(comedi_alloc_subdev_readback);
 
+/* Check if any task is sleeping on any subdevice wait queue. */
+static bool comedi_device_has_sleeper(struct comedi_device *dev)
+{
+	int i;
+	struct comedi_subdevice *s;
+
+	lockdep_assert_held(&dev->mutex);
+	for (i = 0; i < dev->n_subdevices; i++) {
+		s = &dev->subdevices[i];
+		if (s->async && wq_has_sleeper(&s->async->wait_head))
+			return true;
+	}
+	return false;
+}
+
 static void comedi_device_detach_cleanup(struct comedi_device *dev)
 {
 	int i;
@@ -161,11 +176,34 @@ static void comedi_device_detach_cleanup(struct comedi_device *dev)
 	lockdep_assert_held_write(&dev->attach_lock);
 	lockdep_assert_held(&dev->mutex);
 	if (dev->subdevices) {
+		for (i = 0; i < dev->n_subdevices; i++) {
+			s = &dev->subdevices[i];
+			comedi_free_subdevice_minor(s);
+		}
+		while (comedi_device_has_sleeper(dev)) {
+			/*
+			 * Temporarily unlock the attach_lock to allow sleeping
+			 * tasks to remove themselves from the subdevice wait
+			 * queues.
+			 *
+			 * This relies on the poll file operation handler
+			 * returning an unfiltered event.
+			 */
+			up_write(&dev->attach_lock);
+			dev_dbg(dev->class_dev,
+				"detach: waiting for wait queues to empty...\n");
+			do {
+				schedule();
+			} while (comedi_device_has_sleeper(dev));
+			dev_dbg(dev->class_dev,
+				"detach: wait queues should now be empty\n");
+			/* Lock the attach_lock again. */
+			down_write(&dev->attach_lock);
+		}
 		for (i = 0; i < dev->n_subdevices; i++) {
 			s = &dev->subdevices[i];
 			if (comedi_can_auto_free_spriv(s))
 				kfree(s->private);
-			comedi_free_subdevice_minor(s);
 			if (s->async) {
 				comedi_buf_alloc(dev, s, 0);
 				kfree(s->async);
-- 
2.53.0

