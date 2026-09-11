Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CBF309EE2
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089184; cv=none; b=oH7TFGmLgSwX+wXW1uqa+OY4vEaU2Cb/A45X/OH6BhRpOlZBIZ3a7YUeU/8qnaBCMHR5BlYxzdW5TYnv+n55LHmil/e0NC09dqyOOFEVTyd4ZdiwPf8KH9WRvXaeAa6kymEwH4ak0To2WJtkU/i7kQZpCh5S3xDDfuYF9lmBxys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089184; c=relaxed/simple;
	bh=93X3xbDnExRnar/vW5hQiD1hYPtuAjmAQMIJr1Roy4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuMzQLiRqhIseEWi8iJx80UOqGFYpe7VjgruqTqtNhNlwhR88hf9uI1cnYiTEvzm4lIDbIcpV6y1ABqvp5v3Z5Dw9Te1qDdKtdtwKbTsaZFBfPod00tvAACwvjKZoDPMhbFjARtbtC7b0+2Re5lb+S0xYhM6pfct+bahCCDP7IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HfX4bnyz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HfX4bnyz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08DA1F000FF;
	Fri, 11 Sep 2026 01:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089182;
	bh=lsANd1rv7DRiikxcmqtpmfvPj6Jp5z3fqsRXZ6ZEHOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HfX4bnyzClVJLb3qwxIb7/bVVfJ/i8dVkM62Tzb6w87I3h38rbc5b89jGOHS8YAJX
	 ScuFkrEjeSwS3ymppMLfcEwecGHIagoezi6+H0eygo8JZrjof+Uvigw7Oi0Co+UkGe
	 qEpxu+6vLVx0T58gRIdojEhVV5CiOZU5pJrDS6UFYF7U6a6u/EvbGD4zb6gzVx6746
	 B3eK1Po+fXJEEauxCH0Pq9frN4h2ChdKNYgN63cZ8Klz/tNUUXxKK61ZcfW981Mnlh
	 6kwhoXifOYHr9HwTjIJ5Nx6CbP1DYC6W2yZt5bYJj6etKRusnBpV6Zm54AzXnCvLCy
	 qQdSfSjuTzrEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Viktor Mihajlovski <mihajlov@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] s390/vfio-ap: wait for response code 05 to clear on queue reset
Date: Thu, 10 Sep 2026 21:12:59 -0400
Message-ID: <20260911011300.4032478-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090928-anguished-delighted-2103@gregkh>
References: <2026090928-anguished-delighted-2103@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Krowiak <akrowiak@linux.ibm.com>

[ Upstream commit 411b0109daa52d1cc5be39635631e22a5590c5d8 ]

Response code 05, AP busy, is a valid response code for a ZAPQ or TAPQ.
Instead of returning error -EIO when a ZAPQ fails with response code 05,
let's wait until the queue is no longer busy and try the ZAPQ again.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Janosch Frank <frankja@linux.ibm.com>
Tested-by: Viktor Mihajlovski <mihajlov@linux.ibm.com>
Link: https://lore.kernel.org/r/20230815184333.6554-4-akrowiak@linux.ibm.com
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

[Backport to 6.1: keep the existing bounded queue-reset implementation
and handle AP_RESPONSE_BUSY through its reset-in-progress retry path.
Drop the apq_status_check() hunk because that helper is absent here; do
not introduce the newer reset helpers or their prerequisite refactors.

Prepare for 4400270ec034 ("s390/vfio-ap: fix stale pqap_hook pointer on
error in vfio_ap_mdev_set_kvm()") by changing the existing
vfio_ap_mdev_reset_queues() argument from a queue table to its matrix
mdev. Keep the same table traversal and error propagation. The adapter
and domain hot-unplug paths reset their detached queue tables directly
with the existing single-queue helper before unlinking, preserving the
reset order, retry count, and ignored aggregate return value. No new
functions are introduced.]

Stable-dep-of: 4400270ec034 ("s390/vfio-ap: fix stale pqap_hook pointer on error in vfio_ap_mdev_set_kvm()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 11fe917fbd9d4..5016c157a3010 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -30,7 +30,7 @@
 #define AP_QUEUE_UNASSIGNED "unassigned"
 #define AP_QUEUE_IN_USE "in use"
 
-static int vfio_ap_mdev_reset_queues(struct ap_queue_table *qtable);
+static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
 static struct vfio_ap_queue *vfio_ap_find_queue(int apqn);
 static const struct vfio_device_ops vfio_ap_matrix_dev_ops;
 static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q, unsigned int retry);
@@ -781,7 +781,7 @@ static void vfio_ap_mdev_remove(struct mdev_device *mdev)
 
 	mutex_lock(&matrix_dev->guests_lock);
 	mutex_lock(&matrix_dev->mdevs_lock);
-	vfio_ap_mdev_reset_queues(&matrix_mdev->qtable);
+	vfio_ap_mdev_reset_queues(matrix_mdev);
 	vfio_ap_mdev_unlink_fr_queues(matrix_mdev);
 	list_del(&matrix_mdev->node);
 	mutex_unlock(&matrix_dev->mdevs_lock);
@@ -1048,7 +1048,8 @@ static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 	}
 
-	vfio_ap_mdev_reset_queues(qtable);
+	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode)
+		vfio_ap_mdev_reset_queue(q, 1);
 
 	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
 		vfio_ap_unlink_mdev_fr_queue(q);
@@ -1231,7 +1232,8 @@ static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 	}
 
-	vfio_ap_mdev_reset_queues(qtable);
+	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode)
+		vfio_ap_mdev_reset_queue(q, 1);
 
 	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
 		vfio_ap_unlink_mdev_fr_queue(q);
@@ -1577,7 +1579,7 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 		get_update_locks_for_kvm(kvm);
 
 		kvm_arch_crypto_clear_masks(kvm);
-		vfio_ap_mdev_reset_queues(&matrix_mdev->qtable);
+		vfio_ap_mdev_reset_queues(matrix_mdev);
 		kvm_put_kvm(kvm);
 		matrix_mdev->kvm = NULL;
 
@@ -1619,6 +1621,7 @@ static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q,
 		ret = 0;
 		break;
 	case AP_RESPONSE_RESET_IN_PROGRESS:
+	case AP_RESPONSE_BUSY:
 		if (retry--) {
 			msleep(20);
 			goto retry_zapq;
@@ -1659,8 +1662,9 @@ static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q,
 	return ret;
 }
 
-static int vfio_ap_mdev_reset_queues(struct ap_queue_table *qtable)
+static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev)
 {
+	struct ap_queue_table *qtable = &matrix_mdev->qtable;
 	int ret, loop_cursor, rc = 0;
 	struct vfio_ap_queue *q;
 
@@ -1730,7 +1734,7 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
 		ret = vfio_ap_mdev_get_device_info(arg);
 		break;
 	case VFIO_DEVICE_RESET:
-		ret = vfio_ap_mdev_reset_queues(&matrix_mdev->qtable);
+		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
-- 
2.53.0

