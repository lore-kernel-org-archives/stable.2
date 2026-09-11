Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554D549E13E
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086879; cv=none; b=OSa+ZCKYq/RzsqvNfyZnbC1ATNK0fHeRdP/VbEwlj66JIJr5JayejXU0mijVlZUVUyyChy0ViPfvzrlfcGSDEBj1u/CkGt2MKaIwNpbQRgRFOHJacJHjFxVLD8TbQkhHLJ3GU0L4dtkTZLEggy4hkMRdhoRGngTf7npDnzVxw6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086879; c=relaxed/simple;
	bh=Hp+eeFFT9EAZWI4pfhiN5T+Oz+m4V9oHZTwg5M7dy3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UN9E9H5EIqt6Ky5tV5OU1dFzwre0Xw/VnhL0uJIkIbgWaaSuP8ixpKFxOuhowjGt5gElXGosJgJWxCBGd/nr5Qlh/A9BZXJxH+TVC+9S1kpMSHgUnXXXG0t8SzkIilf/pH7un5dj/4Kh46eiLl77NBLb3Go0XWmTly4qf3OflOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLgezaf8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLgezaf8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F6B1F000FF;
	Fri, 11 Sep 2026 00:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789086878;
	bh=5JaFcRakUiYOHSMkLqKdGaTC600xSu6EKIrD9bYcmnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jLgezaf8uzwg/S92IGKcnt/OtgR9rj188unti0/kcU+UGvb4nkX7UATEmIYILpNJU
	 09qkwaPA2BMvx+lOMq8ZVYnnQ5jdNc1cyzowf5yYlSDmasL1230PQHnB0C7b/YBPhG
	 xmUFX9fbv47ySMzeHF2vrd5K3i9PeNOgD5PCS+j5qU+katXuV3No7JP3gAWcTt86mK
	 TUhcapqarjHi6tPnnvzh4xoOGtbH+qnp9UIuRuYJzi66jtpBaZVH0kUVnBGW88S2HK
	 cHIfSSCetXH/bK9y77Ht/DLULRPeXejkN+VPAcOw6PybhHbDtVnMui54Zga+SoS/Db
	 qzc4mhJh/R4VQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anthony Krowiak <akrowiak@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] s390/vfio-ap: Fix missing lock required to access list of ap_matrix_mdev objects
Date: Thu, 10 Sep 2026 20:34:35 -0400
Message-ID: <20260911003435.3490809-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090917-landmass-partridge-4557@gregkh>
References: <2026090917-landmass-partridge-4557@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anthony Krowiak <akrowiak@linux.ibm.com>

[ Upstream commit 7fa61c29850d05e40ca9ed41bfdf57673023f581 ]

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
[ Omitted deletion of cfg_chg_trigger initialization because the field is absent in Linux 6.12. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 3bac163057d89..1f10dc332f70b 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -779,11 +779,17 @@ static int vfio_ap_mdev_probe(struct mdev_device *mdev)
 	ret = vfio_register_emulated_iommu_dev(&matrix_mdev->vdev);
 	if (ret)
 		goto err_put_vdev;
-	matrix_mdev->req_trigger = NULL;
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
@@ -2245,6 +2251,8 @@ static struct ap_matrix_mdev *vfio_ap_mdev_for_queue(struct vfio_ap_queue *q)
 	unsigned long apid = AP_QID_CARD(q->apqn);
 	unsigned long apqi = AP_QID_QUEUE(q->apqn);
 
+	lockdep_assert_held(&matrix_dev->guests_lock);
+
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
 		if (test_bit_inv(apid, matrix_mdev->matrix.apm) &&
 		    test_bit_inv(apqi, matrix_mdev->matrix.aqm))
@@ -2264,6 +2272,7 @@ static ssize_t status_show(struct device *dev,
 	struct ap_matrix_mdev *matrix_mdev;
 	struct ap_device *apdev = to_ap_dev(dev);
 
+	mutex_lock(&matrix_dev->guests_lock);
 	mutex_lock(&matrix_dev->mdevs_lock);
 	q = dev_get_drvdata(&apdev->device);
 	matrix_mdev = vfio_ap_mdev_for_queue(q);
@@ -2294,6 +2303,7 @@ static ssize_t status_show(struct device *dev,
 	}
 
 	mutex_unlock(&matrix_dev->mdevs_lock);
+	mutex_unlock(&matrix_dev->guests_lock);
 
 	return nchars;
 }
@@ -2699,6 +2709,12 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
 
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
@@ -2758,6 +2774,10 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *cur_cfg_info,
 	if (!cur_cfg_info || !prev_cfg_info)
 		return;
 
+	/*
+	 * Take the guests_lock mutex here to guard access to the
+	 * matrix_dev->mdev_list in the two functions called below.
+	 */
 	mutex_lock(&matrix_dev->guests_lock);
 
 	vfio_ap_mdev_on_cfg_remove(cur_cfg_info, prev_cfg_info);
-- 
2.53.0

