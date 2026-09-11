Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A7D3E1D17
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 02:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789093856; cv=none; b=OOpUIdoSUu6WNBVpfKD4SB3e/tSO9MDxoGtgtBgqC2RdiBeIguO/pWvE1UaaBkXtdhwnuQhFtQg96oS+0sXEr2bq+EW6OuZyyZ/pKGLqyViiSczCA8RRNi4Ra8Og8gjAgVRC/RAnEAnY9kleQs+/E3KfvmhDhKPg/Rj+I2UzM4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789093856; c=relaxed/simple;
	bh=5jl+3sQmP02DQLaG5wxiOFA482uL87uSQHLecHJ8KcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agvJdzLkkni1+QU12HWIUMfNOskaE262smVkOHOJz1VAOh/G1ufXb0WdYM1yK8RTuc6HH36OPloKtAzslv7vcedkWhBJrIlzZ9KK1We8NU+KMFdXmKFC+ngxMcgn08bgyzFrrm2UwCIfIbRxoggj3aAnlR37MEg5aXsM96RHqUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XE7cdfGh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XE7cdfGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B24E1F000FF;
	Fri, 11 Sep 2026 02:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789093855;
	bh=ZgxQhMqHupNHFPYvBFPZ0bkk9yJjxVlfjjDSvxbb9to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XE7cdfGhvfxg0S0Yt6gxhMbrJN95MbwuEKCRyzwc5POhR3oa/C37+s2xp8GtWe1jD
	 UvpOEscDyU/+9rezb9MMARyeeqLQxgPWY83vx5saEvhfCpqfC1U3Qig60Ck+tHaigK
	 yimyuGTeDDkXYjj9m7VV+3vMHk8koemWq6AsycC+luC61j8MoL69x8tKqpfzG8iosG
	 gLhZ19u32SHlrZ+msDTYqpfTb7HWZO1/6ieJU7EqLMvTWN1yJd+IUduCd71gY+h+7n
	 yH47eJUVeSefdOsVUI76sgVdm06oYsfxN5mnrU55LYDzAKjgsTy6FRGdUWrVpecsvj
	 IMVPywhWL+UtQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anthony Krowiak <akrowiak@linux.ibm.com>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()
Date: Thu, 10 Sep 2026 22:30:52 -0400
Message-ID: <20260911023052.75404-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090929-rubbed-ransack-ead1@gregkh>
References: <2026090929-rubbed-ransack-ead1@gregkh>
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
[ replaced unavailable locking helpers with explicit locking using matrix_dev->lock. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 33 +++++++++++++------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 623d5269a52ce..6d82a137c011e 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1075,23 +1075,18 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
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
 		mutex_lock(&kvm->lock);
+		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
 		mutex_lock(&matrix_dev->lock);
 
-		list_for_each_entry(m, &matrix_dev->mdev_list, node) {
-			if (m != matrix_mdev && m->kvm == kvm) {
-				mutex_unlock(&kvm->lock);
-				mutex_unlock(&matrix_dev->lock);
-				return -EPERM;
-			}
+		if (kvm->arch.crypto.pqap_hook) {
+			mutex_unlock(&matrix_dev->lock);
+			up_write(&kvm->arch.crypto.pqap_hook_rwsem);
+			mutex_unlock(&kvm->lock);
+			return -EPERM;
 		}
+		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
 
 		kvm_get_kvm(kvm);
 		matrix_mdev->kvm = kvm;
@@ -1100,8 +1095,9 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 					  matrix_mdev->matrix.aqm,
 					  matrix_mdev->matrix.adm);
 
-		mutex_unlock(&kvm->lock);
 		mutex_unlock(&matrix_dev->lock);
+		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
+		mutex_unlock(&kvm->lock);
 	}
 
 	return 0;
@@ -1154,20 +1150,19 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev,
 				   struct kvm *kvm)
 {
 	if (kvm && kvm->arch.crypto.crycbd) {
-		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
-		kvm->arch.crypto.pqap_hook = NULL;
-		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
-
 		mutex_lock(&kvm->lock);
+		down_write(&kvm->arch.crypto.pqap_hook_rwsem);
 		mutex_lock(&matrix_dev->lock);
+		kvm->arch.crypto.pqap_hook = NULL;
 
 		kvm_arch_crypto_clear_masks(kvm);
 		vfio_ap_mdev_reset_queues(matrix_mdev);
-		kvm_put_kvm(kvm);
 		matrix_mdev->kvm = NULL;
 
-		mutex_unlock(&kvm->lock);
 		mutex_unlock(&matrix_dev->lock);
+		up_write(&kvm->arch.crypto.pqap_hook_rwsem);
+		mutex_unlock(&kvm->lock);
+		kvm_put_kvm(kvm);
 	}
 }
 
-- 
2.53.0

