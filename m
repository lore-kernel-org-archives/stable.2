Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12553F86E7
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565396; cv=none; b=idQKKjof7PA7XfOLFz5eEiWmOSJlvtWukH8kaj0GhY2xhkhgIwQdpc7NE6OXwpex4EpLG3dAOkIhQYJR0pQiUhIcg0PaPzAIfftr/4KkEBuL/aiZiSWqfbfIJxt6ZKXBDx5npUjvuYPAGGSEheeSZky/PQ+bdhX0HJrkE2Gmm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565396; c=relaxed/simple;
	bh=gFPCQsa6RUV/wv/ny1Cyb9T7FrZTw8OlxPEhzbLmTXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVZt1r75fTYkFaUrhueKM99CYSO0asMxqyuyExjXrrn+LWPHXFjkeQqsX0lOrcnAQfLLYvlyWVursbwN4XzVftIYfig2bjA7+jryYSN8Q1IniqxnTOoxdkd3voOlaWkC/mhzJi8S+qQLER9ZgWgrCNS4YbYEkKuuVza9NqOrOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXnvcVdK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXnvcVdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 065831F00A3D;
	Mon, 24 Aug 2026 09:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787565394;
	bh=te1NWrgFkbyGyhHGuVX7Bp8f/2Ni1rlhhenziPPPc2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mXnvcVdKM821qck57n76lgQW5ujDiYXSUdoxQoohSYJl4aXao0Yz8ldkeOUBpaEJP
	 z46hXWDhQaeCHw7/tb+myYobXIgT6rke1HRgFUO99JuY3ic9BsNDtR/eKCu38NQnRI
	 9wgthtEg0bpRp5w32j4mt1dcCl4f6Sn5QDGE7JUN+9OJlA9UP6UoNGKODRPKZQn0w8
	 IVZD27u7eXqieKYvPtDxD3gDMIHdUABHEZB89+NYLLHkMzowUuwclNYnIzfsZlij1I
	 T8wpVof85o2s/WJ9bOUNPT5WDiwjO7FSEXCXurgS69Ap2GLfgt0YlJ99FcNSEIpcGk
	 3tcVNhG5aOwbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] s390/vfio_ccw: Selectively expand io_mutex
Date: Mon, 24 Aug 2026 05:56:29 -0400
Message-ID: <20260824095630.4066777-3-sashal@kernel.org>
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

[ Upstream commit 34f4feff3e90bd09308fad0974e97113b23b812a ]

The io_mutex was defined to serialize the io_regions, but then has
also sort of been associated with the I/O themselves because of
the close relationship they share.

With the handful of races that are possible, the choices are either to:
 A) expand the scope of io_mutex to close these remaining windows, or
 B) reduce the scope of io_mutex to just io_region, and introduce a new
    lock mechanism for the remaining I/O resources

This patch implements A, since B brings with it a lot more interactions
that would need to be tracked and kept in a correct hierarchy. It also
takes advantage of the workqueue element for cp_free() that now gets
called out of fsm_notoper(), which could be invoked out of an interrupt
context and thus cannot acquire a mutex itself.

Fixes: 4f76617378ee ("vfio-ccw: protect the I/O region")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Stable-dep-of: 16b0798024c0 ("s390/vfio_ccw: Implement a crw lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/vfio_ccw_chp.c     | 2 +-
 drivers/s390/cio/vfio_ccw_cp.c      | 8 +++++++-
 drivers/s390/cio/vfio_ccw_drv.c     | 6 ++++--
 drivers/s390/cio/vfio_ccw_fsm.c     | 5 +++++
 drivers/s390/cio/vfio_ccw_private.h | 3 ++-
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index 11264e2adffcb..ee9688738a950 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -97,13 +97,13 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
 	if (pos + count > sizeof(*region))
 		return -EINVAL;
 
+	mutex_lock(&private->io_mutex);
 	crw = list_first_entry_or_null(&private->crw,
 				       struct vfio_ccw_crw, next);
 
 	if (crw)
 		list_del(&crw->next);
 
-	mutex_lock(&private->io_mutex);
 	if (i >= private->num_regions) {
 		ret = -EINVAL;
 		goto out;
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 8b0fbfd856235..06f1d34095367 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -904,17 +904,23 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
  */
 bool cp_iova_pinned(struct channel_program *cp, u64 iova, u64 length)
 {
+	struct vfio_ccw_private *private =
+		container_of(cp, struct vfio_ccw_private, cp);
 	struct ccwchain *chain;
 	int i;
 
 	if (!cp->initialized)
 		return false;
 
+	mutex_lock(&private->io_mutex);
 	list_for_each_entry(chain, &cp->ccwchain_list, next) {
 		for (i = 0; i < chain->ch_len; i++)
-			if (page_array_iova_pinned(chain->ch_pa + i, iova, length))
+			if (page_array_iova_pinned(chain->ch_pa + i, iova, length)) {
+				mutex_unlock(&private->io_mutex);
 				return true;
+			}
 	}
+	mutex_unlock(&private->io_mutex);
 
 	return false;
 }
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index dd181752e11a5..ead4c9ea8796c 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -82,6 +82,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 
 	is_final = !(scsw_actl(&irb->scsw) &
 		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
+	mutex_lock(&private->io_mutex);
 	if (scsw_is_solicited(&irb->scsw)) {
 		cp_update_scsw(&private->cp, &irb->scsw);
 		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING) {
@@ -89,9 +90,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 			cp_is_finished = true;
 		}
 	}
-	mutex_lock(&private->io_mutex);
 	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
-	mutex_unlock(&private->io_mutex);
 
 	/*
 	 * Reset to IDLE only if processing of a channel program
@@ -101,6 +100,7 @@ static void vfio_ccw_sch_io_todo(struct work_struct *work)
 	 */
 	if (cp_is_finished)
 		private->state = VFIO_CCW_STATE_IDLE;
+	mutex_unlock(&private->io_mutex);
 
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger, 1);
@@ -122,7 +122,9 @@ static void vfio_ccw_notoper_todo(struct work_struct *work)
 
 	private = container_of(work, struct vfio_ccw_private, notoper_work);
 
+	mutex_lock(&private->io_mutex);
 	cp_free(&private->cp);
+	mutex_unlock(&private->io_mutex);
 }
 
 /*
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index d2a27f50631fa..aefc4ebf40474 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -176,6 +176,7 @@ static void fsm_notoper(struct vfio_ccw_private *private,
 	css_sched_sch_todo(sch, SCH_TODO_UNREG);
 	private->state = VFIO_CCW_STATE_NOT_OPER;
 
+	/* This routine could be called from IRQ context, so defer */
 	queue_work(vfio_ccw_work_q, &private->notoper_work);
 }
 
@@ -412,7 +413,11 @@ static void fsm_close(struct vfio_ccw_private *private,
 
 	private->state = VFIO_CCW_STATE_STANDBY;
 	spin_unlock_irq(sch->lock);
+
+	mutex_lock(&private->io_mutex);
 	cp_free(&private->cp);
+	mutex_unlock(&private->io_mutex);
+
 	return;
 
 err_unlock:
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index a9e1dd9089306..0d78da9597c0c 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -74,7 +74,8 @@ struct vfio_ccw_crw {
  * @state: internal state of the device
  * @completion: synchronization helper of the I/O completion
  * @io_region: MMIO region to input/output I/O arguments/results
- * @io_mutex: protect against concurrent update of I/O regions
+ * @io_mutex: protect against concurrent update of I/O resources
+ *            and @cp lifecycle
  * @region: additional regions for other subchannel operations
  * @cmd_region: MMIO region for asynchronous I/O commands other than START
  * @schib_region: MMIO region for SCHIB information
-- 
2.53.0

