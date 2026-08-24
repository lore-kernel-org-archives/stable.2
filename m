Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A7D3A6B6F
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565397; cv=none; b=Gg33FMOPOZMpOm7irR/DyGVOuzApBN1nsx+spfNuyJYr6TBUQz4Rq68fT/3ef5sRXcuzSMIXWkJIMtts3yx55FZCPix2FAGGQeYBV6aptnqiyS9AzZKfMOkDCM4BIJp+igec+gRBfMznJO0SJk08jtBEZlCHVehh/IQWoTrL4y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565397; c=relaxed/simple;
	bh=6LE06kM9X8kYWphVuj9EP5Dz8K65cvHsTYXFp60VU3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TqXxIyQYy06ctd2S6yZuR5ufxJOGcriC7gVH+XiTB+963EUHZMbo6OTisfsCly9hAXKXHo5p/dUKzZV7UApyyciBfkpYyByi50uIxlPAS4rgTBfqCB2Sa+PyrdTHA/vlSLM7uYqvcwEfz6A3+x9QXShj/8rhcsaf3Olmqqps8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3Y6nAwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3Y6nAwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF221F00ACA;
	Mon, 24 Aug 2026 09:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787565395;
	bh=Cvm5dfqaFoJMnzKo4RYIzCAyJwfLf6fCCV7D00QDM+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W3Y6nAwGdoKK8AuN90GXwqSTG7XvAU8XpdaBEs+/L6MsEwHHgEu39IhPPZ1+CR9sA
	 zQIrzO+H9Wgh5alQxZU6xAz3LBhY7ODb+6TwnvJlZ8fwhnaC15fWAQZLFNZfwa5IXJ
	 IDeb0CyovE4Sfyfhiya0H2wYP9G/NYNctD1h4plb6aVjRFSGGJbAtEHar74aG5WuF4
	 AxBN8JY0lHf0zkxmMLT3cNsdLW5eX198Igc3zvIdPEmFbS2MN0yc02cdP7EFKYt5+T
	 kIwYE0XTAFaqTZBbAfrWhYB497RR9ueg6T8swMqg0xENqkfwIs2m/mCcsGp/EWpYPz
	 S7Fs5zDL1lDkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] s390/vfio_ccw: Implement a crw lock
Date: Mon, 24 Aug 2026 05:56:30 -0400
Message-ID: <20260824095630.4066777-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824095630.4066777-1-sashal@kernel.org>
References: <2026082011-january-overcook-6d98@gregkh>
 <20260824095630.4066777-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Farman <farman@linux.ibm.com>

[ Upstream commit 16b0798024c0e9117e395829ddbbe70981c79d9c ]

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
[ Relocated the `spin_lock_init()` and CRW drain loop from `vfio_ccw_mdev_init_dev()`/`release_dev()` in ops.c to `vfio_ccw_alloc_private()`/`vfio_ccw_free_private()` in drv.c, and kept the 2-argument `eventfd_signal()` form. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/vfio_ccw_chp.c     | 26 ++++++++++++++++----------
 drivers/s390/cio/vfio_ccw_drv.c     | 10 ++++++++++
 drivers/s390/cio/vfio_ccw_private.h |  4 ++++
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index ee9688738a950..3ee2444f3d902 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -92,18 +92,13 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
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
@@ -112,6 +107,16 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
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
 
@@ -121,15 +126,16 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
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
 		eventfd_signal(private->crw_trigger, 1);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
+
+out:
+	mutex_unlock(&private->io_mutex);
 
 	return ret;
 }
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index ead4c9ea8796c..a8340a69a7c84 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -109,11 +109,14 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 static void vfio_ccw_crw_todo(struct work_struct *work)
 {
 	struct vfio_ccw_private *private;
+	unsigned long flags;
 
 	private = container_of(work, struct vfio_ccw_private, crw_work);
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	if (!list_empty(&private->crw) && private->crw_trigger)
 		eventfd_signal(private->crw_trigger, 1);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 }
 
 static void vfio_ccw_notoper_todo(struct work_struct *work)
@@ -153,6 +156,7 @@ static struct vfio_ccw_private *vfio_ccw_alloc_private(struct subchannel *sch)
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
 	INIT_WORK(&private->notoper_work, vfio_ccw_notoper_todo);
+	spin_lock_init(&private->crw_lock);
 
 	private->cp.guest_cp = kcalloc(CCWCHAIN_LEN_MAX, sizeof(struct ccw1),
 				       GFP_KERNEL);
@@ -199,11 +203,14 @@ static struct vfio_ccw_private *vfio_ccw_alloc_private(struct subchannel *sch)
 static void vfio_ccw_free_private(struct vfio_ccw_private *private)
 {
 	struct vfio_ccw_crw *crw, *temp;
+	unsigned long flags;
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	list_for_each_entry_safe(crw, temp, &private->crw, next) {
 		list_del(&crw->next);
 		kfree(crw);
 	}
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 
 	kmem_cache_free(vfio_ccw_crw_region, private->crw_region);
 	kmem_cache_free(vfio_ccw_schib_region, private->schib_region);
@@ -314,6 +321,7 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
 			       unsigned int rsid)
 {
 	struct vfio_ccw_crw *crw;
+	unsigned long flags;
 
 	/*
 	 * If unable to allocate a CRW, just drop the event and
@@ -331,7 +339,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
 	crw->crw.erc = erc;
 	crw->crw.rsid = rsid;
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	list_add_tail(&crw->next, &private->crw);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 	queue_work(vfio_ccw_work_q, &private->crw_work);
 }
 
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 0d78da9597c0c..5294910e64cc2 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -84,6 +84,8 @@ struct vfio_ccw_crw {
  * @cp: channel program for the current I/O operation
  * @irb: irb info received from interrupt
  * @scsw: scsw info
+ * @crw_lock: serialization of CRW list information
+ * @crw: list of Channel Report Word elements
  * @io_trigger: eventfd ctx for signaling userspace I/O results
  * @crw_trigger: eventfd ctx for signaling userspace CRW information
  * @req_trigger: eventfd ctx for signaling userspace to return device
@@ -109,6 +111,8 @@ struct vfio_ccw_private {
 	struct channel_program	cp;
 	struct irb		irb;
 	union scsw		scsw;
+
+	spinlock_t		crw_lock;
 	struct list_head	crw;
 
 	struct eventfd_ctx	*io_trigger;
-- 
2.53.0

