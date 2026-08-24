Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D733B401A0B
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 09:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565395; cv=none; b=EA8BojqsEltMVADmyB6uvebWBAdWA5s4WXBFSZiFg85SxUuUtk0L0T+1OIK3xVBox69QO4eRN8VW2JUf7JAwAwrpcEOV6czPn+OM4Nex+PRP1V7HqGRYeh5OV9jbmFCXR9Fz+76qwGrlK6aT9TBV1aOyE8EHuC/vUSleafA8bsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565395; c=relaxed/simple;
	bh=QuwANmABuaedxnX68hM6e6aEc4OC7RQeMapxHqUJfd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDu4nSorjjeTuJu1x4VeeP06B5SBzIXEjx6Db4ghH7CwIzyNd3HUQa9PZys8NzTbRSlFZ4MLrxBVGWDvcWZy7+0egUwqa4K9b0zYrchrrRwzpIs9clq5yi2cUEIqFTC93HaQjr192l7rrR0OBtXhcB1fjNZDGDo146BBAFVDs7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jI2jXQ7y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jI2jXQ7y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 366091F00A3A;
	Mon, 24 Aug 2026 09:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787565393;
	bh=JjXiXuMzKj/lXjTD5a0icVg9iq4zqf+3+NTb42P6q3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jI2jXQ7yMBPHi3yNCwJmHM10DpBTizNp7EsWW4fYU+6yeH+mKPnTNio0JzE2XALvP
	 oyfJw/dQOMG+YF4k0I+6Exi2UpuVZEbLN6J4h+Xi4f6DRhH1jXiZn5EfvPFqvlSQWu
	 iWgG/2bNewm3ZGFLp347DZUTlMJd7TNTjZt7h69dhpFut0cRsdhntKU+2lTaeF4sYS
	 Mii9+teDrMfnM/TxIpftr4Z+XcEpHTwKFVGG9EXZHuaA3dBO//zbwopNMp4LTTaIwF
	 nJzHOZeya+WPOZTK+tFGk3lNSYa+Rr0mmMPoDoefrlDZ6KFmbIGijvojhfInylRQad
	 BekW7bMa7VA2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] s390/vfio_ccw: Move cp cleanup out of not operational
Date: Mon, 24 Aug 2026 05:56:28 -0400
Message-ID: <20260824095630.4066777-2-sashal@kernel.org>
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

[ Upstream commit 0c11f61a876ed6fcca53d442ed3f33ea8362a0f9 ]

The fsm_notoper() routine is called when the device has been
lost, and is (by definition) no longer operational. Since this
can happen asynchronously from the normal behavior of the
driver, the cleanup may happen when holding other locks
in the calling sequence (notably, the cio subchannel lock).

Push the cleanup of the private->cp resources to a workqueue,
where it can be done out from under that lock sequence and
a future patch can safely manage the locking requirements.

Fixes: 204b394a23ad ("vfio/ccw: Move FSM open/close to MDEV open/close")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Stable-dep-of: 16b0798024c0 ("s390/vfio_ccw: Implement a crw lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/cio/vfio_ccw_drv.c     | 10 ++++++++++
 drivers/s390/cio/vfio_ccw_fsm.c     |  3 +--
 drivers/s390/cio/vfio_ccw_ops.c     | 12 ++++++++++++
 drivers/s390/cio/vfio_ccw_private.h |  2 ++
 4 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_drv.c b/drivers/s390/cio/vfio_ccw_drv.c
index 7f5402fe857a2..dd181752e11a5 100644
--- a/drivers/s390/cio/vfio_ccw_drv.c
+++ b/drivers/s390/cio/vfio_ccw_drv.c
@@ -116,6 +116,15 @@ static void vfio_ccw_crw_todo(struct work_struct *work)
 		eventfd_signal(private->crw_trigger, 1);
 }
 
+static void vfio_ccw_notoper_todo(struct work_struct *work)
+{
+	struct vfio_ccw_private *private;
+
+	private = container_of(work, struct vfio_ccw_private, notoper_work);
+
+	cp_free(&private->cp);
+}
+
 /*
  * Css driver callbacks
  */
@@ -141,6 +150,7 @@ static struct vfio_ccw_private *vfio_ccw_alloc_private(struct subchannel *sch)
 	INIT_LIST_HEAD(&private->crw);
 	INIT_WORK(&private->io_work, vfio_ccw_sch_io_todo);
 	INIT_WORK(&private->crw_work, vfio_ccw_crw_todo);
+	INIT_WORK(&private->notoper_work, vfio_ccw_notoper_todo);
 
 	private->cp.guest_cp = kcalloc(CCWCHAIN_LEN_MAX, sizeof(struct ccw1),
 				       GFP_KERNEL);
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index a59c758869f8f..d2a27f50631fa 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -176,8 +176,7 @@ static void fsm_notoper(struct vfio_ccw_private *private,
 	css_sched_sch_todo(sch, SCH_TODO_UNREG);
 	private->state = VFIO_CCW_STATE_NOT_OPER;
 
-	/* This is usually handled during CLOSE event */
-	cp_free(&private->cp);
+	queue_work(vfio_ccw_work_q, &private->notoper_work);
 }
 
 /*
diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index c73f675ae29a1..46615f5e2f482 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -89,9 +89,16 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
 	/*
 	 * Ensure these work items are fully drained, so none can
 	 * fire after being released.
+	 *
+	 * notoper_work should have nothing to do here, because only
+	 * open devices could have channel_program resources in use
+	 * and those would be released during close. Nevertheless,
+	 * call flush here as well to be certain anything that was
+	 * allocated is freed.
 	 */
 	cancel_work_sync(&private->io_work);
 	cancel_work_sync(&private->crw_work);
+	flush_work(&private->notoper_work);
 
 	/*
 	 * We cannot free vfio_ccw_private here because it includes
@@ -173,9 +180,14 @@ static void vfio_ccw_mdev_close_device(struct vfio_device *vdev)
 	/*
 	 * Ensure these work items are drained, in the event the
 	 * device is re-opened instead of released.
+	 *
+	 * notoper_work needs to be given a chance to run if it
+	 * is queued, so any memory associated with the channel
+	 * program can be returned.
 	 */
 	cancel_work_sync(&private->io_work);
 	cancel_work_sync(&private->crw_work);
+	flush_work(&private->notoper_work);
 
 	vfio_ccw_unregister_dev_regions(private);
 }
diff --git a/drivers/s390/cio/vfio_ccw_private.h b/drivers/s390/cio/vfio_ccw_private.h
index bd5fb81456af8..a9e1dd9089306 100644
--- a/drivers/s390/cio/vfio_ccw_private.h
+++ b/drivers/s390/cio/vfio_ccw_private.h
@@ -88,6 +88,7 @@ struct vfio_ccw_crw {
  * @req_trigger: eventfd ctx for signaling userspace to return device
  * @io_work: work for deferral process of I/O handling
  * @crw_work: work for deferral process of CRW handling
+ * @notoper_work: work for deferred processing in not-operational state
  * @release_comp: synchronization helper for vfio device release
  * @parent: parent data structures for mdevs created
  */
@@ -114,6 +115,7 @@ struct vfio_ccw_private {
 	struct eventfd_ctx	*req_trigger;
 	struct work_struct	io_work;
 	struct work_struct	crw_work;
+	struct work_struct	notoper_work;
 
 	struct completion	release_comp;
 
-- 
2.53.0

