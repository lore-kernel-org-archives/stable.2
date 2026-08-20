Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099DD438486
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787225844; cv=none; b=TaiUtgiBphdbsAfBCOhAypaCqxZhY33whs920XaHlykGkRe+037pEDp1n2sJUeo0NnfsIZjcTAfW9MI70nxRE52b+fVfRUW/CNzf3DrUs3HGbfw9D/qD4iFcpOXapBG5/SHe7Yc81WkdsDwpcKWMt3pQWvHwxOa5q5CJHAPOndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787225844; c=relaxed/simple;
	bh=gfoSv9PQKUIL8mQ/7SQLORplmYZo1UH4+NEChrMgSjY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ORnrZ7zNe+qWdJtsIThStZpxY4AYARXBGYqOM6BAuaVyMQar3AviLSqzE1O0MxbiGwo1HAn0XnF/vkDuz7Tk6g+bmzFMJU4hYNJd6eygfkH7+2WGQ6QzT1dHeR1/+aPSfy78K6t2U0N6xuuIsMBG4Md/V9GSwlJl/vDvKR1z/nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GWkk9BqJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GWkk9BqJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC8581F00A3D;
	Thu, 20 Aug 2026 11:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787225827;
	bh=HP4VDmXrNjLviDcQ3rZNN+mbmy1lQT35tKyBm2JEqUM=;
	h=Subject:To:Cc:From:Date;
	b=GWkk9BqJARHPse3ndKq3bnN95FfL+7RgJB5gSECt4/v6aRoMgjDnXw3sbRQDr7cu5
	 vv58URmTyrjGqIF9XCn9CMaiEtmDTsNWR1IF4PKIMzIiqGejjPfm5RiPARAgvvZO80
	 KeYxvSvUXdeWsVqpjjeXwKDsSg3OKITcEdtGdE7o=
Subject: FAILED: patch "[PATCH] s390/vfio_ccw: Cancel existing workqueues" failed to apply to 6.1-stable tree
To: farman@linux.ibm.com,borntraeger@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:22:40 +0200
Message-ID: <2026082040-refried-cilantro-b696@gregkh>
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
git cherry-pick -x 79c60b2c61105368dcc8444eb45847e21734f7c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082040-refried-cilantro-b696@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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
 

