Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D444D2E6CB8
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089185; cv=none; b=TeYN7Du0HzDwIKnTDtsewj0Ul4hwvoHqrXlsTVDCyUg5Ze6MTCOjNsqt/6uJtukNFVMv41v70Coj7vhPhMblsft2FtGp3Fao7tJI7uipq+AnaqezcaOnaveuGUOImSN6E9qsLonF1niVLhInvI7KP3uqawUekECvPA6JpcuNHPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089185; c=relaxed/simple;
	bh=oOBz3ufeb7CA6uUKDDTFyGW3JNNiisUsB3OWNwAOZ3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uv8HTI4ARTSwzESFSgNWdwNzaSwhT8HAbDYUzGk5SaEh4u4NaT5OU39R6II48TVTb/enehEJG56RjwCUZJW7ssRXwh5QGqO1M4FnhAqD5QDrck7uhXdZKq+Wh0XAQU8eML0hDrYUU6xrLK6rtaV9lW8mjZTnXzgPomTv2n2VArs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/+tM09W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/+tM09W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A2F1F00893;
	Fri, 11 Sep 2026 01:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089183;
	bh=l8lHQIF/Pp55oqPekgCRqu8p2/r7YAOFAP6FLfLDtYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E/+tM09W2lDUesT5+Ka1nnlkyUfmNUOfdtEGO0MlphrxL4wWqsoMyiL1gUxMOEksf
	 FdEY/tyBhBRfkFkXVBDKwlzlKVzH+xMtdAt9Hq6cQtBQYYjxLJ3T0HeTvdT4/LFnCL
	 EJ/j42BlhwAG6Z/8PDhvIHHsRmf3xWQlQWP10GcXR4jOfguKhG7Jof5zZez3oZnxO5
	 2ErTCjh1wFUxSmOlOAZp5rsOHacxc5Y3pWvfcl7GvMaisGXKrdOvk78VLJ6dVdAy5y
	 rtMWeHap8gmo1DQvWzO8wh3YDUX2slbglDjiWjsEsiYhkn4cL1nKOjm+Cj6TuUbtji
	 UNR3mGZpGG01A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anthony Krowiak <akrowiak@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
Date: Thu, 10 Sep 2026 21:13:00 -0400
Message-ID: <20260911011300.4032478-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911011300.4032478-1-sashal@kernel.org>
References: <2026090928-anguished-delighted-2103@gregkh>
 <20260911011300.4032478-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anthony Krowiak <akrowiak@linux.ibm.com>

[ Upstream commit 4400270ec0348d05dc0439d8f0130853ce7f9e20 ]

In vfio_ap_mdev_set_kvm(), kvm->arch.crypto.pqap_hook is set to
&matrix_mdev->pqap_hook before the update locks are acquired and the
mdev list is checked for a conflicting assignment. If another mdev is
already attached to the same KVM instance, the function returns -EPERM
without restoring the hook pointer, leaving kvm->arch.crypto.pqap_hook
pointing at the failing matrix_mdev instead of the mdev that legitimately
owns the KVM.

Since matrix_mdev->kvm is never set on this error path,
vfio_ap_mdev_unset_kvm() will not clean up the hook when matrix_mdev
is later closed. If matrix_mdev is subsequently freed, any PQAP
instruction executed by the guest will dereference the stale pointer
through pqap_hook_rwsem, resulting in a use-after-free.

Since kvm->arch.crypto.pqap_hook is only set in the vfio_ap_mdev_set_kvm()
function and is cleared in the vfio_ap_mdev_unset_kvm() function, a check
for 'kvm->arch.crypto.pqap_hook != NULL' is all that is needed to determine
whether it belongs to another mdev. This will alleviate the need to iterate
the matrix_dev->mdev_list list to see if the kvm object is assigned to
another mdev.This was introduced in v3 to alleviate the need to take the
mdevs_lock while iterating the list; however, this did not prevent a
potential race condition.

The pqap_hook_rwsem(write) is now performed inside
get_update_locks_for_kvm(), which is updated to acquire
pqap_hook_rwsem(write) between kvm->lock and mdevs_lock. This ordering
is consistent with the PQAP intercept path, which acquires pqap_hook_rwsem
in read mode while srcu is held under vcpu->mutex, establishing the
dependency: kvm->lock -> vcpu->mutex -> srcu -> pqap_hook_rwsem(read).

The pqap_hook_rwsem is now released inside the
release_update_locks_for_kvm(), which is updated to release
pqap_hook_rwsem(write) between mdevs_lock and kvm->lock.

Additionally, kvm_put_kvm() in vfio_ap_mdev_unset_kvm() is moved
after release_update_locks_for_kvm(). Previously it was called while
kvm->lock was held; if it were ever the last reference, kvm_destroy_vm()
would run under kvm->lock, which would deadlock.

Fixes: 86956e70761b3 ("s390/vfio-ap: replace open coded locks for VFIO_GROUP_NOTIFY_SET_KVM notification")
Cc: stable@vger.kernel.org
Co-developed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260806173435.105044-1-akrowiak@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 45 ++++++++++++++-----------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 5016c157a3010..93464f9034e23 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -45,15 +45,19 @@ static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q, unsigned int retry)
  * 1. matrix_dev->guests_lock: required to use the KVM pointer to update a KVM
  *			       guest's APCB.
  * 2. kvm->lock:	       required to update a guest's APCB
- * 3. matrix_dev->mdevs_lock:  required to access data stored in a matrix_mdev
+ * 3. kvm->arch.crypto.pqap_hook_rwsem: required to update pqap_hook and
+ *					serialize against PQAP intercepts
+ * 4. matrix_dev->mdevs_lock:  required to access data stored in a matrix_mdev
  *
- * Note: If @kvm is NULL, the KVM lock will not be taken.
+ * Note: If @kvm is NULL, the KVM lock and pqap_hook_rwsem will not be taken.
  */
 static inline void get_update_locks_for_kvm(struct kvm *kvm)
 {
 	mutex_lock(&matrix_dev->guests_lock);
-	if (kvm)
+	if (kvm) {
 		mutex_lock(&kvm->lock);
+		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
+	}
 	mutex_lock(&matrix_dev->mdevs_lock);
 }
 
@@ -65,16 +69,19 @@ static inline void get_update_locks_for_kvm(struct kvm *kvm)
  *
  * The proper unlocking order is:
  * 1. matrix_dev->mdevs_lock
- * 2. kvm->lock
- * 3. matrix_dev->guests_lock
+ * 2. kvm->arch.crypto.pqap_hook_rwsem
+ * 3. kvm->lock
+ * 4. matrix_dev->guests_lock
  *
- * Note: If @kvm is NULL, the KVM lock will not be released.
+ * Note: If @kvm is NULL, the KVM lock and pqap_hook_rwsem will not be released.
  */
 static inline void release_update_locks_for_kvm(struct kvm *kvm)
 {
 	mutex_unlock(&matrix_dev->mdevs_lock);
-	if (kvm)
+	if (kvm) {
+		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
 		mutex_unlock(&kvm->lock);
+	}
 	mutex_unlock(&matrix_dev->guests_lock);
 }
 
@@ -1526,26 +1533,17 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
 static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 				struct kvm *kvm)
 {
-	struct ap_matrix_mdev *m;
-
 	if (kvm->arch.crypto.crycbd) {
-		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
-		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
-		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
-
 		get_update_locks_for_kvm(kvm);
-
-		list_for_each_entry(m, &matrix_dev->mdev_list, node) {
-			if (m != matrix_mdev && m->kvm == kvm) {
-				release_update_locks_for_kvm(kvm);
-				return -EPERM;
-			}
+		if (kvm->arch.crypto.pqap_hook) {
+			release_update_locks_for_kvm(kvm);
+			return -EPERM;
 		}
+		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
 
 		kvm_get_kvm(kvm);
 		matrix_mdev->kvm = kvm;
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
-
 		release_update_locks_for_kvm(kvm);
 	}
 
@@ -1572,18 +1570,15 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 	struct kvm *kvm = matrix_mdev->kvm;
 
 	if (kvm && kvm->arch.crypto.crycbd) {
-		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
-		kvm->arch.crypto.pqap_hook = NULL;
-		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
-
 		get_update_locks_for_kvm(kvm);
+		kvm->arch.crypto.pqap_hook = NULL;
 
 		kvm_arch_crypto_clear_masks(kvm);
 		vfio_ap_mdev_reset_queues(matrix_mdev);
-		kvm_put_kvm(kvm);
 		matrix_mdev->kvm = NULL;
 
 		release_update_locks_for_kvm(kvm);
+		kvm_put_kvm(kvm);
 	}
 }
 
-- 
2.53.0

