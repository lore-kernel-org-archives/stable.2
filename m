Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F39C3242BA
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089205; cv=none; b=YsEG0tonLFvztzvDUuTdQBUOGA5O6PgF3TGXWK4j7uE2SqLpIQwHn43UUCc+nkwE+zgYEYPqnW9ySPwaIic39hbd2MyvuXkMsg2Sb1mDMDvfVOutZc8SmLuHnSg4SIqy2MBMt5K+y9I8ofgsIYf/f+FTq8BBhlESlF1rFer8DsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089205; c=relaxed/simple;
	bh=W4iKbohOFMKndN9gJhR7aTQUCH8WPX0lQdyWqZHDwws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WONxgTFzIbvZIt/bux98fsB3t3hbi/qPKgiE7lrhvs+YVMsWVvmvQRn9dK1QIK72N2rQqq+YMA3c5xWJkfuclyVMPznAwmSwYt/0cbNBjL6d5GbYnKjfGCdt62ioadV6OakSpKlJSEV4ASKIrTxtZIvpDIZkaiRL4AE7s9f/pXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SM/infUh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SM/infUh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39CD1F0089D;
	Fri, 11 Sep 2026 01:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089200;
	bh=VisMz8FHKRP5dTAvhsQ6+tBmaH3QNzCDw9l/qFZ+HvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SM/infUhS3s3+Kj4V7T3HyFtXdo85iqsws39KsCJ1LiSgJusiI8IVracPOXx6tHpr
	 /AlzKBQ6G+apvYXfNUKhlrkRtP4z5AJ23Ez0qJRraWw/MWL1Xhe1VweAdcxd6uu2q2
	 T78Z2VYeHzfP6ePAwueoPKzGrpLxBt2gZwFPHfW5brW28yHfPX3VcihkI2Rspke0cU
	 i2R0J4OYf0SZqrfWCG7qwr3Na19+YuMkhTePNzc1NVin6anqim0mtiav5IAf5GgheS
	 E91vElx15ohHpaHnk1K/Dw3+5/0mFXS0h6qnSo7UwlxsRo4ma+po3snEfEh+dD45Q2
	 CccoB7wsyd2PQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anthony Krowiak <akrowiak@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] s390/vfio-ap: Fix NULL deref in status_show() during queue probe
Date: Thu, 10 Sep 2026 21:13:17 -0400
Message-ID: <20260911011317.4035178-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090930-overcrowd-probiotic-71cb@gregkh>
References: <2026090930-overcrowd-probiotic-71cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Anthony Krowiak <akrowiak@linux.ibm.com>

[ Upstream commit dd6f4ef6f8a37412909ad787c837332fb070159c ]

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
[ Adjusted queue-initialization context because Linux 6.1 lacks the newer reset fields. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 33 +++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 11fe917fbd9d4..3eb6cd604bed6 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1768,6 +1768,23 @@ static ssize_t status_show(struct device *dev,
 
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
@@ -1795,6 +1812,7 @@ static ssize_t status_show(struct device *dev,
 				   AP_QUEUE_UNASSIGNED);
 	}
 
+done:
 	mutex_unlock(&matrix_dev->mdevs_lock);
 
 	return nchars;
@@ -1864,13 +1882,16 @@ void vfio_ap_mdev_unregister(void)
 
 int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 {
-	int ret;
+	int ret, apqn;
 	struct vfio_ap_queue *q;
 	struct ap_matrix_mdev *matrix_mdev;
 
+	apqn = to_ap_queue(&apdev->device)->qid;
+	matrix_mdev = get_update_locks_by_apqn(apqn);
+
 	ret = sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
 	if (ret)
-		return ret;
+		goto err_release_locks;
 
 	q = kzalloc(sizeof(*q), GFP_KERNEL);
 	if (!q) {
@@ -1878,9 +1899,8 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 		goto err_remove_group;
 	}
 
-	q->apqn = to_ap_queue(&apdev->device)->qid;
+	q->apqn = apqn;
 	q->saved_isc = VFIO_AP_ISC_INVALID;
-	matrix_mdev = get_update_locks_by_apqn(q->apqn);
 
 	if (matrix_mdev) {
 		vfio_ap_mdev_link_queue(matrix_mdev, q);
@@ -1907,8 +1927,13 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 	return 0;
 
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
-- 
2.53.0

