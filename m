Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F3C313E00
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089194; cv=none; b=Eu3k7GjukP3HeyJKoYP6kOwdi/c7ChYzyGMyJAWwh00xHuRPTMVKTcWu4k+Sho+FoHhpmdB/UnlqluRCD2vnQiF1s4gPwFZWJ50N+fWEgseBog0BIbNFGl4kBPHpzE5v2u3VFEWIVKeZD1clPHBxTYmwpKV5yet4lZTolcilYLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089194; c=relaxed/simple;
	bh=Tbt8STLCAJjcQqg0zqzxYh5Oi6+UEhJJ/P7S6H3+1xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyESNfSQXmtO6Ej8F1zPx7o7TMtEBxCCC4egUdcNhDhUgxB5rgXMhjw6GDNKJ4HC+CDRp/sPotAeh9QzfV5VVelDPqt7LbJXrtSpGdv6MXflloUbuHcESq/+CKaiRfrUKk8ZhSi9iAddayKy8tY9xurzIASUc4fZCSekPO4UDVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wn579xY9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wn579xY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D551F00893;
	Fri, 11 Sep 2026 01:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089192;
	bh=BUrqOFNM2ZQUFpuI3gL4iNb91h04D1nVYShtKHa4wEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wn579xY9ml+DOKftnPp6K0nKj4yY9GJ7Yfqpa7nW030SeZ1ih3kME9nOPpUg/Vgm2
	 5qimOYx29rLY/SmhzdMulgNvX5sOqcMAyDIy1ituD17DCRTyOhMOiaEjcIrAESgZmD
	 VeGvQQCJKV18YWsE9VWmMbZebemFu1/NnoyOOhTZFoM7ojvQvGFqf/6+3Nwk5/qjmB
	 gMYByC3M7tdjp5Il0bT3oIeBuHMlJHIgVFxa3HaZ3qevLRtYdEiwtk6ZY+dzFao+MS
	 5u53xYThPWmXNYRmaAlO2vptiMuVx/qzCj4upTPnBeJbDddq13A+Lpr3cDzeZiyJ+Z
	 R5bkT+6BbxtVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anthony Krowiak <akrowiak@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL
Date: Thu, 10 Sep 2026 21:13:09 -0400
Message-ID: <20260911011309.4033327-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911011309.4033327-1-sashal@kernel.org>
References: <2026090900-unwanted-unlatch-cac4@gregkh>
 <20260911011309.4033327-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anthony Krowiak <akrowiak@linux.ibm.com>

[ Upstream commit d50346801b4f144e42b49cd4f1496010498ab114 ]

The ap_driver structure has two fields which are function pointers to
callbacks:

* .on_config_changed: called at the start of the AP bus scan function to
                      notify the device driver that the host AP
                      configuration has changed and the associated AP
                      devices will be added or removed accordingly. This
                      gives the implementor a chance to evaluate the
                      configuration changes and respond to them before
                      the associated devices are added or removed.

* .on_scan_complete:  Called at the end of the AP bus scan function to
                      notify the device driver that the host AP
                      configuration has changed and the AP devices have
                      been added or removed accordingly. This gives the
                      implementor the opportunity to respond to the
                      changes after the associated devices are added or
                      removed.

These two callbacks are implemented in the vfio_ap device driver via the
vfio_ap_on_cfg_changed and vfio_ap_on_scan_complete functions respectively.

Within the call stack of these two callback functions the
matrix_mdev->kvm->lock mutex is taken without checking whether
matrix_mdev->kvm is NULL or not. If matrix_mdev->kvm has never been set,
trying to take the lock will trigger a NULL pointer dereference. This patch
adds checks for matrix_mdev->kvm == NULL before taking the
matrix_mdev->kvm->lock mutex.

Note that the matrix_mdev->kvm->lock mutex taken in the
vfio_ap_mdev_hot_plug_config function is moved to the calling function
along with the matrix_dev->mdevs_lock which is needed there to access
the fields of the matrix_mdev. It makes little sense to make the change
the check for matrix_mdev->kvm there before taking the kvm->lock
mutex only to have to move it out via another patch, so it is done in
this patch.

It is important to make note of the following:
1. The matrix_dev->guests_lock is acquired at the start of both callback
   functions. This ensures that matrix_mdev will not be removed via the
   vfio_ap_mdev_remove function because it too takes matrix_dev_guests_lock
   before removing the object; so, matrix_mdev will be available for the
   duration of the callback functions.

2. The matrix_dev->mdevs_lock mutex must be taken in order to access
   fields within the matrix_mdev structure

3. matrix_mdev->kvm->lock mutex must be taken before the
   matrix_dev->mdevs_lock to prevent a lockdep splat.

4: The kvm->lock must be held while plugging the guest's AP configuration
   into its SIE state description via the vfio_ap_mdev_update_guest_apcb
   function.

5. The vfio_ap_mdev_update_guest_apcb checks matrix_mdev->kvm to verify it
   is not NULL before doing the hot plug of the guest's AP configuration.

Fixes: eeb386aeb5b7c ("s390/vfio-ap: handle config changed and scan complete notification")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 39 ++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index a5785bb6b013b..3ebcf42541cca 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2109,8 +2109,20 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
 	DECLARE_BITMAP(cdrem, AP_DOMAINS);
 	int do_remove = 0;
 
+	/*
+	 * It is safe to traverse this list here because the
+	 * required guard - matrix_dev->guests_lock - is taken in the
+	 * vfio_ap_on_cfg_changed function prior to this function getting
+	 * called.
+	 */
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
-		mutex_lock(&matrix_mdev->kvm->lock);
+		/*
+		 * The mdevs_lock must be held to access fields within matrix_mdev,
+		 * and kvm->lock must be taken before mdevs_lock to satisfy the lock
+		 * ordering requirement and prevent a lockdep splat.
+		 */
+		if (matrix_mdev->kvm)
+			mutex_lock(&matrix_mdev->kvm->lock);
 		mutex_lock(&matrix_dev->mdevs_lock);
 
 		do_remove |= bitmap_and(aprem, ap_remove,
@@ -2128,7 +2140,8 @@ static void vfio_ap_mdev_cfg_remove(unsigned long *ap_remove,
 						    cdrem);
 
 		mutex_unlock(&matrix_dev->mdevs_lock);
-		mutex_unlock(&matrix_mdev->kvm->lock);
+		if (matrix_mdev->kvm)
+			mutex_unlock(&matrix_mdev->kvm->lock);
 	}
 }
 
@@ -2327,9 +2340,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 	DECLARE_BITMAP(apm_filtered, AP_DEVICES) = { 0 };
 	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
 
-	mutex_lock(&matrix_mdev->kvm->lock);
-	mutex_lock(&matrix_dev->mdevs_lock);
-
 	filter_adapters = bitmap_intersects(matrix_mdev->matrix.apm,
 					    matrix_mdev->apm_add, AP_DEVICES);
 	filter_domains = bitmap_intersects(matrix_mdev->matrix.aqm,
@@ -2347,9 +2357,6 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 
 	reset_queues_for_apids(matrix_mdev, apm_filtered);
-
-	mutex_unlock(&matrix_dev->mdevs_lock);
-	mutex_unlock(&matrix_mdev->kvm->lock);
 }
 
 void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
@@ -2360,15 +2367,29 @@ void vfio_ap_on_scan_complete(struct ap_config_info *new_config_info,
 	mutex_lock(&matrix_dev->guests_lock);
 
 	list_for_each_entry(matrix_mdev, &matrix_dev->mdev_list, node) {
+		/*
+		 * The mdevs_lock must be held to access fields within matrix_mdev,
+		 * and kvm->lock must be taken before mdevs_lock to satisfy the lock
+		 * ordering requirement and prevent a lockdep splat.
+		 */
+		if (matrix_mdev->kvm)
+			mutex_lock(&matrix_mdev->kvm->lock);
+		mutex_lock(&matrix_dev->mdevs_lock);
+
 		if (bitmap_empty(matrix_mdev->apm_add, AP_DEVICES) &&
 		    bitmap_empty(matrix_mdev->aqm_add, AP_DOMAINS) &&
 		    bitmap_empty(matrix_mdev->adm_add, AP_DOMAINS))
-			continue;
+			goto do_unlock;
 
 		vfio_ap_mdev_hot_plug_cfg(matrix_mdev);
 		bitmap_clear(matrix_mdev->apm_add, 0, AP_DEVICES);
 		bitmap_clear(matrix_mdev->aqm_add, 0, AP_DOMAINS);
 		bitmap_clear(matrix_mdev->adm_add, 0, AP_DOMAINS);
+
+do_unlock:
+		mutex_unlock(&matrix_dev->mdevs_lock);
+		if (matrix_mdev->kvm)
+			mutex_unlock(&matrix_mdev->kvm->lock);
 	}
 
 	mutex_unlock(&matrix_dev->guests_lock);
-- 
2.53.0

