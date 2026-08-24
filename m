Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88C0463B88
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588781; cv=none; b=rKqfFnWeIh6nUlK7lWZs4ld7jIhTX5hATy8zg7aaVk1UW+KRip3eopTl3UUejTL7SbhJAx2MRn4sEBJvHX8IRRzHjJKT6D8bVS6Z2GRtfjRDsonXMXtsV2qBkfFnEnCCq9E1htR/WNW1q/aY7mv3/Ha6svh4RTIma3Z40KwF8pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588781; c=relaxed/simple;
	bh=01gMP7keWusJXvxtoHlC4WQB53e2HOWtViVdgGg9tYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxcAhbANxhPqBl6cIp5UyD1uj+L7umYelE4ll0TG5C+KECaxQnzMdh6LqJd3Gb0JWaGn0au6IgAHo3m+dm+cQAE2UoWZnEdeC8PVA/5DETfOMKn0VDa+v2Xl/6K0yEb0j++iWo1buCOfxxV3fT3qnmI9Q9omDLQcnGKdC/PS+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=beLytAC/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="beLytAC/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB071F000E9;
	Mon, 24 Aug 2026 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787588777;
	bh=LqoeFbRYMBcTw0ymVOksVfNjqH0zUdMn/8Djf6eBTEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=beLytAC/oJy1OwdmoeBhPf9EbQInLcqPSAk27ZUstaHPQUnoJsIfC+w9Ab/shk1Xg
	 Ve0IcR0QCcxBLIlbgaR7eTUETSu2mBXLrEeG3G5Zy7xmMK7P0pWEp5I+VSYjwGrdpZ
	 XmRbjZGj4HoiUmKiJfj/140bALBTvCYpknl6x4IrWVUyoOy2XeuQAK124u+/9dvg5R
	 +RcS+QIEpxmzC3pHmbvOjpBkdXoNiDG6Ov68X+bqbz7WUkOrG4Tmv0ZxCYBPmFkPM6
	 GQA7GIE2UYzv55m0JTSVjgycyCJQ9Y8GFCz6LG2B9uX9L5O4EdTbg73jynKbQLrsAS
	 SLjND324to33w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] s390/vfio_ccw: Implement a crw lock
Date: Mon, 24 Aug 2026 12:26:15 -0400
Message-ID: <20260824162615.4144738-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082012-jam-hardly-84ee@gregkh>
References: <2026082012-jam-hardly-84ee@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/vfio_ccw_chp.c     | 16 +++++++++++-----
 drivers/s390/cio/vfio_ccw_drv.c     | 10 ++++++++++
 drivers/s390/cio/vfio_ccw_private.h |  4 ++++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index 13b26a1c79886..4fc493584a1e2 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -84,19 +84,24 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
 	struct ccw_crw_region *region;
 	struct vfio_ccw_crw *crw;
+	unsigned long flags;
 	int ret;
 
 	if (pos + count > sizeof(*region))
 		return -EINVAL;
 
+	mutex_lock(&private->io_mutex);
+	region = private->region[i].data;
+
+	spin_lock_irqsave(&private->crw_lock, flags);
 	crw = list_first_entry_or_null(&private->crw,
 				       struct vfio_ccw_crw, next);
 
 	if (crw)
 		list_del(&crw->next);
 
-	mutex_lock(&private->io_mutex);
-	region = private->region[i].data;
+	/* Drop CRW lock while copying to userspace */
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 
 	if (crw)
 		memcpy(&region->crw, &crw->crw, sizeof(region->crw));
@@ -107,14 +112,15 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 		ret = count;
 
 	region->crw = 0;
-
-	mutex_unlock(&private->io_mutex);
-
 	kfree(crw);
 
 	/* Notify the guest if more CRWs are on our queue */
+	spin_lock_irqsave(&private->crw_lock, flags);
 	if (!list_empty(&private->crw) && private->crw_trigger)
 		eventfd_signal(private->crw_trigger, 1);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
+
+	mutex_unlock(&private->io_mutex);
 
 	return ret;
 }
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index e3c1060b6056c..83993a1423d00 100644
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
 
@@ -238,13 +242,16 @@ static int vfio_ccw_sch_remove(struct subchannel *sch)
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
 
@@ -305,6 +312,7 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
 			       unsigned int rsid)
 {
 	struct vfio_ccw_crw *crw;
+	unsigned long flags;
 
 	/*
 	 * If unable to allocate a CRW, just drop the event and
@@ -322,7 +330,9 @@ static void vfio_ccw_queue_crw(struct vfio_ccw_private *private,
 	crw->crw.erc = erc;
 	crw->crw.rsid = rsid;
 
+	spin_lock_irqsave(&private->crw_lock, flags);
 	list_add_tail(&crw->next, &private->crw);
+	spin_unlock_irqrestore(&private->crw_lock, flags);
 	queue_work(vfio_ccw_work_q, &private->crw_work);
 }
 
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index 8723156b29eac..38f470c2d26c3 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -83,6 +83,8 @@ struct vfio_ccw_crw {
  * @cp: channel program for the current I/O operation
  * @irb: irb info received from interrupt
  * @scsw: scsw info
+ * @crw_lock: serialization of CRW list information
+ * @crw: list of Channel Report Word elements
  * @io_trigger: eventfd ctx for signaling userspace I/O results
  * @io_work: work for deferral process of I/O handling
  */
@@ -104,6 +106,8 @@ struct vfio_ccw_private {
 	struct channel_program	cp;
 	struct irb		irb;
 	union scsw		scsw;
+
+	spinlock_t		crw_lock;
 	struct list_head	crw;
 
 	struct eventfd_ctx	*io_trigger;
-- 
2.53.0

