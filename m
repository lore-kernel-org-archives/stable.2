Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29ED43B6E0
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226422; cv=none; b=jpSE0WrnRhLRrKQIRZzfyHJzTbcBova1tw7ak5neJlO2JqX9Y69DME7pUhNTf+OayiUgJ3yKnT3kXJOeXdmLMnmBfT6BZQnyVQXkmMmBeM1to5y9lyRBIEK0o/okwSLEZVdIpSXdeSwJCuhRNAfuMkrHO/LxoP39gggBoXGc9NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226422; c=relaxed/simple;
	bh=8/aY/3rK9fx3YqVfX5/gQfgQ1kKX4DF5qDZ7NuWVvJM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ReqnVOjMU2imOGjuLmJC8Si1nJYXkwGo2bGp8Dr4fndY0TQKPNAl/U2jqNQAqYg7TtyXPEYrtzQClTUduLZ9G9zLssGHPBG6vhAk0ABS/8/uF7BfPhqEgd8VhdWX38Hk6Vbshubnm2XSOGQhf0dVu5O5rBzmqVXGSEeI6OE4UFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mGpidbIg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mGpidbIg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B891F1F00A3E;
	Thu, 20 Aug 2026 11:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787225832;
	bh=3wfRBSqHdLDSwyRkcSD+vpmngA4gLOoBI8zGShLcMPA=;
	h=Subject:To:Cc:From:Date;
	b=mGpidbIgr6HSsgVRa7iG/hdGNxvVFA7QiAeaVoi6t9TV4gaDQKyRgVafhmkIAaSbs
	 qIuln29S0YFyBvs0erKLJfAq7reJ4lbXrdMiqa0ltucwmBcmrrdJmGg/i+Z1u3wo06
	 ShDLfi5Oz6ewsDJhyMudgYRAbpSQha/6+p4/LsyE=
Subject: FAILED: patch "[PATCH] s390/vfio_ccw: Cancel existing workqueues" failed to apply to 5.10-stable tree
To: farman@linux.ibm.com,borntraeger@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:22:41 +0200
Message-ID: <2026082041-cheek-expert-0782@gregkh>
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
git cherry-pick -x 79c60b2c61105368dcc8444eb45847e21734f7c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082041-cheek-expert-0782@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 79c60b2c61105368dcc8444eb45847e21734f7c4 Mon Sep 17 00:00:00 2001
From: Eric Farman <farman@linux.ibm.com>
Date: Tue, 28 Jul 2026 05:30:19 +0200
Subject: [PATCH] s390/vfio_ccw: Cancel existing workqueues

The initialization of the io_work and crw_work workqueues begs the
question of whether they should be un-initialized. Add the corresponding
cleanup tags in _release_dev to ensure work isn't dispatched after
the private struct is free'd.

Suggested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Fixes: e5f84dbaea59 ("vfio: ccw: return I/O results asynchronously")
Fixes: 3f02cb2fd9d2 ("vfio-ccw: Wire up the CRW irq and CRW region")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
index 032a1cdf4df7..d361d1fde3a0 100644
--- a/drivers/s390/cio/vfio_ccw_ops.c
+++ b/drivers/s390/cio/vfio_ccw_ops.c
@@ -131,6 +131,13 @@ static void vfio_ccw_mdev_release_dev(struct vfio_device *vdev)
 		container_of(vdev, struct vfio_ccw_private, vdev);
 	struct vfio_ccw_crw *crw, *temp;
 
+	/*
+	 * Ensure these work items are fully drained, so none can
+	 * fire after being released.
+	 */
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	list_for_each_entry_safe(crw, temp, &private->crw, next) {
 		list_del(&crw->next);
 		kfree(crw);
@@ -202,6 +209,14 @@ static void vfio_ccw_mdev_close_device(struct vfio_device *vdev)
 		container_of(vdev, struct vfio_ccw_private, vdev);
 
 	vfio_ccw_fsm_event(private, VFIO_CCW_EVENT_CLOSE);
+
+	/*
+	 * Ensure these work items are drained, in the event the
+	 * device is re-opened instead of released.
+	 */
+	cancel_work_sync(&private->io_work);
+	cancel_work_sync(&private->crw_work);
+
 	vfio_ccw_unregister_dev_regions(private);
 }
 

