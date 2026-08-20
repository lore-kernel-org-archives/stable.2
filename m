Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE8042B31F
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225933; cv=none; b=c+TZh+Y4qmoWAMxpgve6CvCywrmEmiArYNv/moqEPEb0rfwL11ejqisj+cd5J2l75RmL6YEkXUmhiSAZ8WF5DM4mOcMTWLSA3PT16hQ4s/QbnaJBZe5nxNe6l8k7+pkqogFPgahtSgmse0l8lAi6uL8kTAl/FDI+M9nkweWDELM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225933; c=relaxed/simple;
	bh=L9Md4sbY6lFEeB3BPICXpN0JREVkp3/LQT4Db9UAJaM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RZlElmlMLGvtY3Srfmo6iv4FdIyAFMk1SBmCOCSH1ydexxFy1aNZ1pD49Opn3KEHrjQKzNkPaoDm9FRMwyCtVRwzYx0Lwy0hhkFqF5JbgEjlyqrocMck7KMO9mpKbBe+08f0uYbUMBdCaCXZplTulbQ2Z5UT1KTHBlUIckfZbuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ktwI1F5b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ktwI1F5b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5151F000E9;
	Thu, 20 Aug 2026 11:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787225931;
	bh=SYNZ/km2m+4aACNbgM93NkVwv57CvZVT4eGzm2A8KVI=;
	h=Subject:To:Cc:From:Date;
	b=ktwI1F5bcdZCv/MeqVqGHqL8HuDm9E3OdpHCBCPaQZOybdc69MlLEJQv6EBnnR0fP
	 D1/UYnR3XTbxF4hCq84U3xkXKocbLSY6qOCMdGbpQxnxBDy2LU7peAOtd4qZxOs/Gh
	 0cddVbBtL45+btY3nNr4c1IvcpaSM5mucV+jeqKo=
Subject: FAILED: patch "[PATCH] s390/vfio_ccw: Implement a crw lock" failed to apply to 5.10-stable tree
To: farman@linux.ibm.com,alifm@linux.ibm.com,borntraeger@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:24:12 +0200
Message-ID: <2026082012-jam-hardly-84ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 16b0798024c0e9117e395829ddbbe70981c79d9c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082012-jam-hardly-84ee@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 16b0798024c0e9117e395829ddbbe70981c79d9c Mon Sep 17 00:00:00 2001
From: Eric Farman <farman@linux.ibm.com>
Date: Tue, 28 Jul 2026 05:30:22 +0200
Subject: [PATCH] s390/vfio_ccw: Implement a crw lock

Unlike the channel_program struct, which covers synchronous I/O
submissions and asynchronous interrupts, the CRW region relies
exclusively on asynchronous events coming from hardware.

Implement a lock to manage the list of those payloads, to ensure
they are read cohesively.

Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index 9269b54f5cfd..7708eb4d6de0 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -93,18 +93,13 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
 	struct ccw_crw_region *region;
 	struct vfio_ccw_crw *crw;
+	unsigned long flags;
 	int ret;
 
 	if (pos + count > sizeof(*region))
 		return -EINVAL;
 
 	mutex_lock(&private->io_mutex);
-	crw = list_first_entry_or_null(&private->crw,
-				       struct vfio_ccw_crw, next);
-
-	if (crw)
-		list_del(&crw->next);
-
 	if (i >= private->num_regions) {
 		ret = -EINVAL;
 		goto out;
@@ -113,6 +108,16 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 	i = array_index_nospec(i, private->num_regions);
 	region = private->region[i].data;
 
+	spin_lock_irqsave(&private->crw_lock, flags);
+	crw = list_first_entry_or_null(&private->crw,
+				       struct vfio_ccw_crw, next);
+
+	if (crw)
+		list_del(&crw->next);
+
+	/* Drop CRW lock while copying to userspace */
+	spin_unlock_irqrestore(&private->crw_lock, flags);
+
 	if (crw)
 		memcpy(&region->crw, &crw->crw, sizeof(region->crw));
 
@@ -122,15 +127,16 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 		ret = count;
 
 	region->crw = 0;
-
-out:
-	mutex_unlock(&private->io_mutex);
-
 	kfree(crw);
 
 	/* Notify the guest if more CRWs are on our queue */
+	spin_lock_irqsave(&private->crw_lock, flags);
 	if (!list_empty(&private->crw) && private->crw_trigger)
 		eventfd_signal(private->crw_trigger);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
+
+out:
+	mutex_unlock(&private->io_mutex);
 
 	return ret;
 }
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 757ff5b2556e..ab6b518cc353 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -118,11 +118,14 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
 void vfio_ccw_crw_todo(struct work_struct *work)
 {
 	struct vfio_ccw_private *private;
+	unsigned long flags;
 
 	private = container_of(work, struct vfio_ccw_private, crw_work);
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	if (!list_empty(&private->crw) && private->crw_trigger)
 		eventfd_signal(private->crw_trigger);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 }
 
 void vfio_ccw_notoper_todo(struct work_struct *work)
@@ -286,6 +289,7 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
 			       unsigned int rsid)
 {
 	struct vfio_ccw_crw *crw;
+	unsigned long flags;
 
 	/*
 	 * If unable to allocate a CRW, just drop the event and
@@ -303,7 +307,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
 	crw->crw.erc = erc;
 	crw->crw.rsid = rsid;
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	list_add_tail(&crw->next, &private->crw);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 	queue_work(vfio_ccw_work_q, &private->crw_work);
 }
 
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 1df6d649565b..5ce91285c7d5 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -55,6 +55,7 @@ static int vfio_ccw_mdev_init_dev(struct vfio_device *vdev)
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
 	INIT_WORK(&private->notoper_work, vfio_ccw_notoper_todo);
+	spin_lock_init(&private->crw_lock);
 
 	private->cp.guest_cp = kzalloc_objs(struct ccw1, CCWCHAIN_LEN_MAX);
 	if (!private->cp.guest_cp)
@@ -131,6 +132,7 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
 	struct vfio_ccw_private *private =
 		container_of(vdev, struct vfio_ccw_private, vdev);
 	struct vfio_ccw_crw *crw, *temp;
+	unsigned long flags;
 
 	/*
 	 * Ensure these work items are fully drained, so none can
@@ -146,10 +148,12 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
 	cancel_work_sync(&private->crw_work);
 	flush_work(&private->notoper_work);
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	list_for_each_entry_safe(crw, temp, &private->crw, next) {
 		list_del(&crw->next);
 		kfree(crw);
 	}
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 
 	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
 	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 739121116ab6..3bd0171d38d0 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -98,6 +98,8 @@ struct vfio_ccw_parent {
  * @cp: channel program for the current I/O operation
  * @irb: irb info received from interrupt
  * @scsw: scsw info
+ * @crw_lock: serialization of CRW list information
+ * @crw: list of Channel Report Word elements
  * @io_trigger: eventfd ctx for signaling userspace I/O results
  * @crw_trigger: eventfd ctx for signaling userspace CRW information
  * @req_trigger: eventfd ctx for signaling userspace to return device
@@ -120,6 +122,8 @@ struct vfio_ccw_private {
 	struct channel_program	cp;
 	struct irb		irb;
 	union scsw		scsw;
+
+	spinlock_t		crw_lock;
 	struct list_head	crw;
 
 	struct eventfd_ctx	*io_trigger;

