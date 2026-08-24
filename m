Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDCA437861
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580361; cv=none; b=YJW3oPkWz/DWCJ0izcxt0if+1yv9VXsRDZKnmdqgVfgAzN/HsTSsIdkAjipBDZywiP9vW7HFs2MDvuTsUXk+Oq8HRD2ftXaBFecqUB1THt946+bOxzMj4rYez4KtsRb522n5caqpjh1tFdNKCOSItti/1KBeZxX72bxICP+mSAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580361; c=relaxed/simple;
	bh=McKRACwLYrpYpoRqnh60u0hIVPQgSvB0rKtjwzgexHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UMPSMPCoIHN1rEGoodu6rF9EcEuRhAueDXKPSrFvqakNaD+j9dJSCjQ842db+DAdSFbVRz2LusnZT9CVKowloQkWIO5wccDbKL+iYYP120x1H/abDPYaphOWmKgRpI36PJf7jSIZ388O+p4zXms3g/Z1VYP2GHmeQaT5a0eLNPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5Mnh+d2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5Mnh+d2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498FC1F00A3E;
	Mon, 24 Aug 2026 14:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787580359;
	bh=nzyjPqKErgyuIaSebJECzd9EPIfFhsvUmDjNb6uGtzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J5Mnh+d2YZfj/QJmyjakNt9agH4W/eosXEKwDImA1sbbCJr/nAJd45Ar1ZdeFbB9c
	 jHH2VUN5PH3WkDaa8aqfxdmRCBL5YVjQ+GTRY7GKZrabG04mLA6nkkNqrmyu68TiAQ
	 7FR+YCJXcYnz8F1ZZu+TLF5aNJpWWk8tB2v8YLr/nVkcUQ/7ot5qyMUOq5k/wGsChZ
	 8AWRWjxCaLKEb0nDJTb/hQi8LK/VfDicjPjds9r7Os5QVLWvHSnnVbpeBsJx4mktoE
	 +uPkFj3bhj+Q+al/JhlAs6NaVKotNz+tHtFdoBvD6f0Z2OQz3P++i6JJg6ljth0Y/4
	 Tz0mtpC++IRiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] s390/vfio_ccw: Implement a crw lock
Date: Mon, 24 Aug 2026 10:05:55 -0400
Message-ID: <20260824140555.3097579-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824140555.3097579-1-sashal@kernel.org>
References: <2026082011-underarm-plywood-1b0f@gregkh>
 <20260824140555.3097579-1-sashal@kernel.org>
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
[ relocated crw_lock init and CRW drain from vfio_ccw_ops.c's mdev_init_dev()/mdev_release_dev() into vfio_ccw_drv.c's sch_probe()/sch_remove(), and kept the two-argument eventfd_signal() calls ]
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
index 3678c3eed19b8..735d9493b6874 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -119,11 +119,14 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
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
 
 /*
@@ -207,6 +210,7 @@ static int vfio_ccw_sch_probe(struct subchannel *sch)
 	INIT_LIST_HEAD(&private->crw);
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
+	spin_lock_init(&private->crw_lock);
 	atomic_set(&private->avail, 1);
 	private->state = VFIO_CCW_STATE_STANDBY;
 
@@ -238,13 +242,16 @@ static void vfio_ccw_sch_remove(struct subchannel *sch)
 {
 	struct vfio_ccw_private *private = dev_get_drvdata(&sch->dev);
 	struct vfio_ccw_crw *crw, *temp;
+	unsigned long flags;
 
 	vfio_ccw_sch_quiesce(sch);
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	list_for_each_entry_safe(crw, temp, &private->crw, next) {
 		list_del(&crw->next);
 		kfree(crw);
 	}
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 
 	vfio_ccw_mdev_unreg(sch);
 
@@ -304,6 +311,7 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
 			       unsigned int rsid)
 {
 	struct vfio_ccw_crw *crw;
+	unsigned long flags;
 
 	/*
 	 * If unable to allocate a CRW, just drop the event and
@@ -321,7 +329,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
 	crw->crw.erc = erc;
 	crw->crw.rsid = rsid;
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	list_add_tail(&crw->next, &private->crw);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 	queue_work(vfio_ccw_work_q, &private->crw_work);
 }
 
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 9b13b41e3a9cb..67bc16f8c11ce 100644
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
@@ -108,6 +110,8 @@ struct vfio_ccw_private {
 	struct channel_program	cp;
 	struct irb		irb;
 	union scsw		scsw;
+
+	spinlock_t		crw_lock;
 	struct list_head	crw;
 
 	struct eventfd_ctx	*io_trigger;
-- 
2.53.0

