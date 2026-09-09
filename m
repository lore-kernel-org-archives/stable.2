Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D4D38BF67
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947924; cv=none; b=RAjHh2kKwDGA1MuymHZTa29mDONdRtcezME3myWK49EBcHyHrj5OninXUTnKeIhnaF6J6PcSqULzzxM8JErep+82rDjqpkrUPAKFX9S3e9RrK4Sz5j7PZ/ib6Q80rVFT4L74C2SBaje7D09N3G3VfCuhMD0T0TKnP5WKYBWfDqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947924; c=relaxed/simple;
	bh=30ShRDRaxdVAtnVbEFF+5v3Ba5+WRQGTuAHL/W6cDkw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dyjO0nAZDKJyx/AEDBmgbXQavuw52N6Ig5n27cf6426fmPDOzCpRFiwMkIbqfOMYko1wHn1RvkbYEP/LEl+ifSuilTXMXT+6ITaxisgiZB7m5H3AaaPdQe530uETKpK3a+UDRCzw3Oj9I+y5n2h/GMv7u4wnUuDIVOohfY1KMkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jKg/JkwG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jKg/JkwG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFBD31F00A3A;
	Wed,  9 Sep 2026 09:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947923;
	bh=0zK3QuWyvN3xMz4VLS722QNZ91v2VKlj2ieo0mdOOcc=;
	h=Subject:To:Cc:From:Date;
	b=jKg/JkwGrPfOMuPk7GtIY/c1U27WHcSuezkC6lb5vXWzgLQ22D+B6eso918wR9MRx
	 BymTz0awnxGL8rFCJWmNsj4ZuGvSu4Twd8Vh7bjXLfxiBoxHqt1stVentpGlu0VvRd
	 pZbCYc7cDKCPHqg3Qbs02PbIRZfbBtVzfsS3QKNE=
Subject: FAILED: patch "[PATCH] s390/vfio-ap: Fix missing lock required to access list of" failed to apply to 6.1-stable tree
To: akrowiak@linux.ibm.com,borntraeger@linux.ibm.com,mjrosato@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:54:19 +0200
Message-ID: <2026090919-shelve-unknotted-cb50@gregkh>
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
git cherry-pick -x 7fa61c29850d05e40ca9ed41bfdf57673023f581
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090919-shelve-unknotted-cb50@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7fa61c29850d05e40ca9ed41bfdf57673023f581 Mon Sep 17 00:00:00 2001
From: Anthony Krowiak <akrowiak@linux.ibm.com>
Date: Wed, 12 Aug 2026 16:02:34 -0400
Subject: [PATCH] s390/vfio-ap: Fix missing lock required to access list of
 ap_matrix_mdev objects

In order to traverse or add/remove ap_matrix_mdev objects in the
matrix_dev->mdev_list, the matrix_dev->guests_lock mutex must be held.
There are two functions that access the list without holding the mutex:

vfio_ap_mdev_probe function
~~~~~~~~~~~~~~~~~~~~~~~~~~~
The vfio_ap_mdev_probe function uses the matrix_dev->mdevs_lock
mutex to guard the add of a newly created ap_matrix_mdev object to the
matrix_dev->mdev_list. This mutex does not protect list access; its purpose
is to guard against concurrent access to fields contained in an
ap_matrix_mdev object. This could lead to kernel memory corruption or
use-after-free if another mdev is created or removed concurrently.

The adding of an ap_matrix_mdev object to matrix_dev->mdev_list
is now guarded by the matrix_dev->guests_lock which is the correct
way to protect against concurrent mdev_list access.

Also removed the following two lines of code because the matrix_mdev is
allocated via vfio_alloc_device macro which uses kzalloc, so req_trigger
and cfg_chg_trigger are already zero-initialised when the struct is
allocated before the call to vfio_register_emulated_iommu_dev. This
prevents a window whereby these triggers are set to NULL after
the device is exposed to userspace.

matrix_mdev->req_trigger = NULL;
matrix_mdev->cfg_chg_trigger = NULL;

vfio_ap_mdev_for_queue function
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
The status_show function that supports display of the status attribute of
the devices in /sys/bus/ap/devices calls the vfio_ap_mdev_for_queue
function which iterates the matrix_dev->mdev_list to find the object
representing the queue device whose status is to be displayed. In order to
traverse this list, the matrix_dev->guests_lock mutex must be held.

To fix this, the guests_lock mutex is taken prior to taking the
matrix_dev->mdevs_lock mutex in the status_show function. It is taken
there rather than the vfio_ap_mdev_for_queue function - where it is
needed - because it must be taken prior to the mdevs_lock mutex in order to
adhere to the proper locking order and prevent a lockdep splat; also
because the mdevs_lock is needed there to access fields within
the matrix_mdev object in that function.

See the vfio-ap-locking.rst in the linux kernel tree.

Fixes: 2c1ee8983aa3 ("s390/vfio-ap: prepare for dynamic update of guest's APCB on queue probe/remove")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 1076a9982923..a403d0f59122 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -807,12 +807,17 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 	ret = vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);
 	if (ret)
 		goto err_put_vdev;
-	matrix_mdev->req_trigger = NULL;
-	matrix_mdev->cfg_chg_trigger = NULL;
+
+	/*
+	 * Take the matrix_dev->guests_lock mutex before adding the matrix_mdev
+	 * to the mdev_list. All functions that traverse the list must also hold
+	 * this lock to guard against additions to or removals from the list
+	 * while it is being traversed.
+	 */
+	mutex_lock(&matrix_dev->guests_lock);
 	dev_set_drvdata(&mdev->dev, matrix_mdev);
-	mutex_lock(&matrix_dev->mdevs_lock);
 	list_add(&matrix_mdev->node, &matrix_dev->mdev_list);
-	mutex_unlock(&matrix_dev->mdevs_lock);
+	mutex_unlock(&matrix_dev->guests_lock);
 	return 0;
 
 err_put_vdev:
@@ -2292,6 +2297,8 @@ static struct ap_matrix_mdev *vfio_ap_mdev_for_queue(struct vfio_ap_queue *q)
 	unsigned long apid = AP_QID_CARD(q->apqn);
 	unsigned long apqi = AP_QID_QUEUE(q->apqn);
 
+	lockdep_assert_held(&matrix_dev->guests_lock);
+
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
 		if (test_bit_inv(apid, matrix_mdev->matrix.apm) &&
 		    test_bit_inv(apqi, matrix_mdev->matrix.aqm))
@@ -2311,6 +2318,7 @@ static ssize_t status_show(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev;
 	struct ap_device *apdev = to_ap_dev(dev);
 
+	mutex_lock(&matrix_dev->guests_lock);
 	mutex_lock(&matrix_dev->mdevs_lock);
 	q = dev_get_drvdata(&apdev->device);
 	matrix_mdev = vfio_ap_mdev_for_queue(q);
@@ -2338,6 +2346,7 @@ static ssize_t status_show(struct device *dev,
 	}
 
 	mutex_unlock(&matrix_dev->mdevs_lock);
+	mutex_unlock(&matrix_dev->guests_lock);
 
 	return nchars;
 }
@@ -2756,6 +2765,12 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 
 	vfio_ap_filter_apid_by_qtype(apm_add, aqm_add);
 
+	/*
+	 * It is safe to traverse this list here because the
+	 * required guard - matrix_dev->guests_lock - is taken in the
+	 * vfio_ap_on_cfg_changed function prior to this function getting
+	 * called.
+	 */
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
 		bitmap_and(matrix_mdev->apm_add,
 			   matrix_mdev->matrix.apm, apm_add, AP_DEVICES);
@@ -2815,6 +2830,10 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *cur_cfg_info,
 	if (!cur_cfg_info || !prev_cfg_info)
 		return;
 
+	/*
+	 * Take the guests_lock mutex here to guard access to the
+	 * matrix_dev->mdev_list in the two functions called below.
+	 */
 	mutex_lock(&matrix_dev->guests_lock);
 
 	vfio_ap_mdev_on_cfg_remove(cur_cfg_info, prev_cfg_info);

