Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9E5377A8B
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947927; cv=none; b=lnZVqe5vn9pEntDTAEPGFEnR8Hl7CyK7l+4VlFvODYrgZSWcfBHbuHY3LswmgvpTEOdHBkocE0sAv9+Za3YLN0nI9sbS9ypbvQSwbAHxBr793/3xKPKMn+LQBiAsejqrpS2ME1T+sBPMljoT1k453+zGZPnXsx80PRWYOyEsYZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947927; c=relaxed/simple;
	bh=bu/md5adLWFBGWOxnXi0PZig5NxQI4nen36r7yRpVuc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cWpryk7NUarUh36YSKiellZK0V+eOCdzNpej+lyur5UlvQxv0Px+bwyfc8BSYwlQzoFS5oZAZwt5GP+HDjD1b3Zn3IEH8n/suOUCSWNDnykA3XE8I0a2ITOUuuodCctdOusF/wv2KamG60aH3vVVOBET8PoIHOFUvUNYj1jFJBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gQib+NmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gQib+NmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6781F00A3A;
	Wed,  9 Sep 2026 09:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947926;
	bh=y5XhxNdcj66C8XyxAL5k/zdncuJzwp3706WldA2mS6c=;
	h=Subject:To:Cc:From:Date;
	b=gQib+NmDOyR/IQ2eNl01PMAWANTRb0lOBhWE8Egw4iROggRWU736tTHjMIrIAuaj3
	 QF0XmXkBuRKjsVrHEnpibvJmqScrQiKhmPAImPrNO3aclo/3WYIDcKoUpolSIt3jU3
	 PB6X2eZgtJMqcqVagnl20PcKSW1y18oPLYZE1dkM=
Subject: FAILED: patch "[PATCH] s390/vfio-ap: Fix NULL deref in status_show() during queue" failed to apply to 6.1-stable tree
To: akrowiak@linux.ibm.com,borntraeger@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:54:30 +0200
Message-ID: <2026090930-overcrowd-probiotic-71cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x dd6f4ef6f8a37412909ad787c837332fb070159c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090930-overcrowd-probiotic-71cb@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dd6f4ef6f8a37412909ad787c837332fb070159c Mon Sep 17 00:00:00 2001
From: Anthony Krowiak <akrowiak@linux.ibm.com>
Date: Wed, 12 Aug 2026 16:02:39 -0400
Subject: [PATCH] s390/vfio-ap: Fix NULL deref in status_show() during queue
 probe
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When vfio_ap_mdev_probe_queue() creates the sysfs attribute group,
the queue's driver data has not yet been set. A concurrent read of
the 'status' attribute can therefore call dev_get_drvdata() and
get NULL, which is then passed directly to
vfio_ap_mdev_for_queue() where q->apqn is unconditionally
dereferenced, causing a NULL pointer dereference.

Fix this by acquiring the update locks before calling
sysfs_create_group(). The status_show() function acquires
guests_lock before reading the driver data, so any concurrent
read will block until after dev_set_drvdata() has been called
and the update locks are released.

As a bonus, the APQN no longer needs to be read from the queue
struct after allocation — it can be read directly from apdev
before allocation and stored in a local variable, which is then
assigned to q->apqn once the allocation succeeds.

Fixes: 260f3ea141382 ("s390/vfio-ap: move probe and remove callbacks to vfio_ap_ops.c")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 1546a216295b..940c0ff668be 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2321,6 +2321,23 @@ static ssize_t status_show(struct device *dev,
 	mutex_lock(&matrix_dev->guests_lock);
 	mutex_lock(&matrix_dev->mdevs_lock);
 	q = dev_get_drvdata(&apdev->device);
+
+	/*
+	 * Make sure the drvdata has been set before proceeding. There is a
+	 * possibility that the drvdata was not set if the vfio_ap_queue object
+	 * could not be allocated when the queue device was probed. In that case,
+	 * the locks used in vfio_ap_mdev_probe_queue() are released prior to
+	 * removing the sysfs status attribute to avoid a lockdep
+	 * splat. That opens a very small window where the status attribute is
+	 * still available without the vfio_ap_queue object having been
+	 * stored in the device drvdata. In that case, indicate the queue is not
+	 * assigned.
+	 */
+	if (!q) {
+		nchars = sysfs_emit(buf, "%s\n", AP_QUEUE_UNASSIGNED);
+		goto done;
+	}
+
 	matrix_mdev = vfio_ap_mdev_for_queue(q);
 
 	/* If the queue is assigned to the matrix mediated device, then
@@ -2345,6 +2362,7 @@ static ssize_t status_show(struct device *dev,
 		nchars = sysfs_emit(buf, "%s\n", AP_QUEUE_UNASSIGNED);
 	}
 
+done:
 	mutex_unlock(&matrix_dev->mdevs_lock);
 	mutex_unlock(&matrix_dev->guests_lock);
 
@@ -2419,14 +2437,17 @@ void vfio_ap_mdev_unregister(void)
 
 int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 {
-	int ret;
+	int ret, apqn;
 	struct vfio_ap_queue *q;
 	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev;
 
+	apqn = to_ap_queue(&apdev->device)->qid;
+	matrix_mdev = get_update_locks_by_apqn(apqn);
+
 	ret = sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
 	if (ret)
-		return ret;
+		goto err_release_locks;
 
 	q = kzalloc_obj(*q);
 	if (!q) {
@@ -2434,11 +2455,10 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 		goto err_remove_group;
 	}
 
-	q->apqn = to_ap_queue(&apdev->device)->qid;
+	q->apqn = apqn;
 	q->saved_isc = VFIO_AP_ISC_INVALID;
 	memset(&q->reset_status, 0, sizeof(q->reset_status));
 	INIT_WORK(&q->reset_work, apq_reset_check);
-	matrix_mdev = get_update_locks_by_apqn(q->apqn);
 
 	if (matrix_mdev) {
 		vfio_ap_mdev_link_queue(matrix_mdev, q);
@@ -2467,8 +2487,13 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	return ret;
 
 err_remove_group:
+	release_update_locks_for_mdev(matrix_mdev);
 	sysfs_remove_group(&apdev->device.kobj, &vfio_queue_attr_group);
 	return ret;
+
+err_release_locks:
+	release_update_locks_for_mdev(matrix_mdev);
+	return ret;
 }
 
 void vfio_ap_mdev_remove_queue(struct ap_device *apdev)

