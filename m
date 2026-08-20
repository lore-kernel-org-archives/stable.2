Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C9A4248C1
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225879; cv=none; b=F3Vam8f0HN7e/WHhCenKSlFXWjdHP59t1MYTeBEbXvjnnCFE/km12NJWW8s3h7iS+WNaKgco8bGWUVtNI0Gc7ofeiz73ecOikmL2rmnOCfaNzaL3x5mD+p5DOYCb22rMHoGe8/Wn1YphhLcjFLqCwM8zu68PJ34zTnucUvcK6/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225879; c=relaxed/simple;
	bh=cWS4R+QjwQH8FQKneSLYYosC1wgP3Dhv/YcNx63tZg0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=K4pQzNrM2OrPAd2OARkDAFUUUh5np4LOsushANfKuAH6N4UuOlEod5Mpnc0i16tng61tofElrR59jWUTZpgV/oki/ZYC/fzFcs29i1mcFkBQbf0cBC30bAwQ/NG+WULC8f0dYhoTWA5ySq189sK1StSmogh+5MVK0rwfYwpt7xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oHXTW+Jz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oHXTW+Jz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FA91F000E9;
	Thu, 20 Aug 2026 11:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787225878;
	bh=5GNKsS+9aBml0xQ93XyQCNpXIfH5w0MRXFbUTLGQKQY=;
	h=Subject:To:Cc:From:Date;
	b=oHXTW+JzFjtPtfaPVV0l0NceXuZ4RKk5rIOPlix0d0c2355GZEOv7NbPZzrBEJQlM
	 oQc8fpVjmt2FFbco5jEzHSCLKvRdehfX/5eqm4ZqfASy2YgevMJ8OVfZjFAIt+uyEP
	 uI6nZXNi4PscGHynwaV52KC0QlU9bdmSUFtWUehU=
Subject: FAILED: patch "[PATCH] s390/vfio_ccw: Selectively expand io_mutex" failed to apply to 6.1-stable tree
To: farman@linux.ibm.com,borntraeger@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:23:48 +0200
Message-ID: <2026082048-avenue-roundness-d375@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 34f4feff3e90bd09308fad0974e97113b23b812a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082048-avenue-roundness-d375@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 34f4feff3e90bd09308fad0974e97113b23b812a Mon Sep 17 00:00:00 2001
From: Eric Farman <farman@linux.ibm.com>
Date: Tue, 28 Jul 2026 05:30:21 +0200
Subject: [PATCH] s390/vfio_ccw: Selectively expand io_mutex

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

diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
index f3015132d4b5..9269b54f5cfd 100644
--- a/drivers/s390/cio/vfio_ccw_chp.c
+++ b/drivers/s390/cio/vfio_ccw_chp.c
@@ -98,13 +98,13 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
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
index 5ef082b8289a..58722c4baa25 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -977,17 +977,23 @@ void cp_update_scsw(struct channel_program *cp, union scsw *scsw)
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
-			if (page_array_iova_pinned(&chain->ch_pa[i], iova, length))
+			if (page_array_iova_pinned(&chain->ch_pa[i], iova, length)) {
+				mutex_unlock(&private->io_mutex);
 				return true;
+			}
 	}
+	mutex_unlock(&private->io_mutex);
 
 	return false;
 }
diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index c197ad5ab580..757ff5b2556e 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -91,6 +91,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
 
 	is_final = !(scsw_actl(&irb->scsw) &
 		     (SCSW_ACTL_DEVACT | SCSW_ACTL_SCHACT));
+	mutex_lock(&private->io_mutex);
 	if (scsw_is_solicited(&irb->scsw)) {
 		cp_update_scsw(&private->cp, &irb->scsw);
 		if (is_final && private->state == VFIO_CCW_STATE_CP_PENDING) {
@@ -98,9 +99,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
 			cp_is_finished = true;
 		}
 	}
-	mutex_lock(&private->io_mutex);
 	memcpy(private->io_region->irb_area, irb, sizeof(*irb));
-	mutex_unlock(&private->io_mutex);
 
 	/*
 	 * Reset to IDLE only if processing of a channel program
@@ -110,6 +109,7 @@ void vfio_ccw_sch_io_todo(struct work_struct *work)
 	 */
 	if (cp_is_finished)
 		private->state = VFIO_CCW_STATE_IDLE;
+	mutex_unlock(&private->io_mutex);
 
 	if (private->io_trigger)
 		eventfd_signal(private->io_trigger);
@@ -131,7 +131,9 @@ void vfio_ccw_notoper_todo(struct work_struct *work)
 
 	private = container_of(work, struct vfio_ccw_private, notoper_work);
 
+	mutex_lock(&private->io_mutex);
 	cp_free(&private->cp);
+	mutex_unlock(&private->io_mutex);
 }
 
 /*
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 4d47a3c7b9a0..5fd94e9d5c61 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -170,6 +170,7 @@ static void fsm_notoper(struct vfio_ccw_private *private,
 	css_sched_sch_todo(sch, SCH_TODO_UNREG);
 	private->state = VFIO_CCW_STATE_NOT_OPER;
 
+	/* This routine could be called from IRQ context, so defer */
 	queue_work(vfio_ccw_work_q, &private->notoper_work);
 }
 
@@ -409,7 +410,11 @@ static void fsm_close(struct vfio_ccw_private *private,
 
 	private->state = VFIO_CCW_STATE_STANDBY;
 	spin_unlock_irq(&sch->lock);
+
+	mutex_lock(&private->io_mutex);
 	cp_free(&private->cp);
+	mutex_unlock(&private->io_mutex);
+
 	return;
 
 err_unlock:
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index e2256402b089..739121116ab6 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -88,7 +88,8 @@ struct vfio_ccw_parent {
  * @state: internal state of the device
  * @completion: synchronization helper of the I/O completion
  * @io_region: MMIO region to input/output I/O arguments/results
- * @io_mutex: protect against concurrent update of I/O regions
+ * @io_mutex: protect against concurrent update of I/O resources
+ *            and @cp lifecycle
  * @region: additional regions for other subchannel operations
  * @cmd_region: MMIO region for asynchronous I/O commands other than START
  * @schib_region: MMIO region for SCHIB information

