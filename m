Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550DE30DD1B
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089195; cv=none; b=e707dTd3ysxmaBn/9ozNdqDScPWI/6ztJVEOlDqdLLBnFPiguENQuyTtF5OihWp621Pd5mP8iQ2Wiyl4+aeLlNMpgTDM39efnwnGUKUDlJuCTEMY6bst4XrOFc6yMObelCBEiNxcmIyZbzeJV/bZ/5QGOQtFitt/TEoBYHO3EB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089195; c=relaxed/simple;
	bh=bM3O6uIyt1itwpV9lTIFTgImURjf00KXiq4ynv0fDr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dc8QvrLOFQ25GZXTEz2MbbiPvOWGTzTTojbjlcOywk6lfvtKpeiQG/4cayzAM1GTqju095G3NnSnQaPulWehHAcuYjHU28rltLPSvniIC6oU+WIMrNFEidZDJca+Gl0rLsxiSL0y8CzqSP6R69HCm4jF/e3/lR6rT1Tyrpj0NU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivCS2+Yk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivCS2+Yk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420311F000FF;
	Fri, 11 Sep 2026 01:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089191;
	bh=obMJSuKn9oqbwkRaPaLOE9DxkVsJjhtx70g1dAx/ASo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ivCS2+YkHoS2EOf9fi45dvFRcdJu5PpxFN6rsVOBNiicUo+Sfy4DS0j6VXsAU8Xfv
	 SmTTcOa+2XXk8PWywWuR1VElnOnigC4WGTmSxsdhO2ijNcpX0J/9PWRY3GI9xPAYMS
	 PIpILVe5ZlY+/Gk6xMc41eReuUI2rXBfNHs+wkT6DM/4YEz++t54L29NQYD5ZDe40z
	 EMqa4sPMICynYgmqceAZ72+zihewqC6bxGrR1tfjpvDiZ3jys3/ZZmFqoXjL9xREdH
	 3nRB4wGYF3sn9rdxSvt/mfiqxF6a8rIx53HsYs2YCyVQydEV8Gkkd4Sbzfay9jabyu
	 vEOk8eUDqLgmA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] s390/vfio-ap: reset queues filtered from the guest's AP config
Date: Thu, 10 Sep 2026 21:13:08 -0400
Message-ID: <20260911011309.4033327-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090900-unwanted-unlatch-cac4@gregkh>
References: <2026090900-unwanted-unlatch-cac4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Krowiak <akrowiak@linux.ibm.com>

[ Upstream commit f848cba767e59f8d5c54984b1d45451aae040d50 ]

When filtering the adapters from the configuration profile for a guest to
create or update a guest's AP configuration, if the APID of an adapter and
the APQI of a domain identify a queue device that is not bound to the
vfio_ap device driver, the APID of the adapter will be filtered because an
individual APQN can not be filtered due to the fact the APQNs are assigned
to an AP configuration as a matrix of APIDs and APQIs. Consequently, a
guest will not have access to all of the queues associated with the
filtered adapter. If the queues are subsequently made available again to
the guest, they should re-appear in a reset state; so, let's make sure all
queues associated with an adapter unplugged from the guest are reset.

In order to identify the set of queues that need to be reset, let's allow a
vfio_ap_queue object to be simultaneously stored in both a hashtable and a
list: A hashtable used to store all of the queues assigned
to a matrix mdev; and/or, a list used to store a subset of the queues that
need to be reset. For example, when an adapter is hot unplugged from a
guest, all guest queues associated with that adapter must be reset. Since
that may be a subset of those assigned to the matrix mdev, they can be
stored in a list that can be passed to the vfio_ap_mdev_reset_queues
function.

Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Fixes: 48cae940c31d ("s390/vfio-ap: refresh guest's APCB by filtering AP resources assigned to mdev")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240115185441.31526-5-akrowiak@linux.ibm.com
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

Backport to 6.1: keep the synchronous vfio_ap_mdev_reset_queue(q, 1)
interface and reset_rc field. Adapt the dependency's list reset helper to
continue through all queues and retain reset errors, without importing
the workqueue reset implementation or adding further functions.

Initialize apm_filtered in vfio_ap_mdev_hot_plug_cfg because a scan that
only changes control domains does not call vfio_ap_mdev_filter_matrix.
This prevents the unconditional reset call from using an uninitialized
bitmap. Retain the filtering and list changes so d50346801b4f can be
cherry-picked without conflicts.

Stable-dep-of: d50346801b4f ("s390/vfio-ap: Fix dereference matrix_mdev->kvm without checking for NULL")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 166 +++++++++++++++++++-------
 drivers/s390/crypto/vfio_ap_private.h |   3 +
 2 files changed, 125 insertions(+), 44 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 11fe917fbd9d4..a5785bb6b013b 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -30,7 +30,8 @@
 #define AP_QUEUE_UNASSIGNED "unassigned"
 #define AP_QUEUE_IN_USE "in use"
 
-static int vfio_ap_mdev_reset_queues(struct ap_queue_table *qtable);
+static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev);
+static int vfio_ap_mdev_reset_qlist(struct list_head *qlist);
 static struct vfio_ap_queue *vfio_ap_find_queue(int apqn);
 static const struct vfio_device_ops vfio_ap_matrix_dev_ops;
 static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q, unsigned int retry);
@@ -630,16 +631,23 @@ static bool vfio_ap_mdev_filter_cdoms(struct ap_matrix_mdev *matrix_mdev)
  *				device driver.
  *
  * @matrix_mdev: the matrix mdev whose matrix is to be filtered.
+ * @apm_filtered: a 256-bit bitmap for storing the APIDs filtered from the
+ *		  guest's AP configuration that are still in the host's AP
+ *		  configuration.
  *
  * Note: If an APQN referencing a queue device that is not bound to the vfio_ap
  *	 driver, its APID will be filtered from the guest's APCB. The matrix
  *	 structure precludes filtering an individual APQN, so its APID will be
- *	 filtered.
+ *	 filtered. Consequently, all queues associated with the adapter that
+ *	 are in the host's AP configuration must be reset. If queues are
+ *	 subsequently made available again to the guest, they should re-appear
+ *	 in a reset state
  *
  * Return: a boolean value indicating whether the KVM guest's APCB was changed
  *	   by the filtering or not.
  */
-static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
+static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev,
+				       unsigned long *apm_filtered)
 {
 	unsigned long apid, apqi, apqn;
 	DECLARE_BITMAP(prev_shadow_apm, AP_DEVICES);
@@ -649,6 +657,7 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
 	bitmap_copy(prev_shadow_apm, matrix_mdev->shadow_apcb.apm, AP_DEVICES);
 	bitmap_copy(prev_shadow_aqm, matrix_mdev->shadow_apcb.aqm, AP_DOMAINS);
 	vfio_ap_matrix_init(&matrix_dev->info, &matrix_mdev->shadow_apcb);
+	bitmap_clear(apm_filtered, 0, AP_DEVICES);
 
 	/*
 	 * Copy the adapters, domains and control domains to the shadow_apcb
@@ -674,8 +683,16 @@ static bool vfio_ap_mdev_filter_matrix(struct ap_matrix_mdev *matrix_mdev)
 			apqn = AP_MKQID(apid, apqi);
 			q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
 			if (!q || q->reset_rc) {
-				clear_bit_inv(apid,
-					      matrix_mdev->shadow_apcb.apm);
+				clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
+
+				/*
+				 * If the adapter was previously plugged into
+				 * the guest, let's let the caller know that
+				 * the APID was filtered.
+				 */
+				if (test_bit_inv(apid, prev_shadow_apm))
+					set_bit_inv(apid, apm_filtered);
+
 				break;
 			}
 		}
@@ -781,7 +798,7 @@ static void vfio_ap_mdev_remove(struct mdev_device *mdev)
 
 	mutex_lock(&matrix_dev->guests_lock);
 	mutex_lock(&matrix_dev->mdevs_lock);
-	vfio_ap_mdev_reset_queues(&matrix_mdev->qtable);
+	vfio_ap_mdev_reset_queues(matrix_mdev);
 	vfio_ap_mdev_unlink_fr_queues(matrix_mdev);
 	list_del(&matrix_mdev->node);
 	mutex_unlock(&matrix_dev->mdevs_lock);
@@ -911,6 +928,47 @@ static void vfio_ap_mdev_link_adapter(struct ap_matrix_mdev *matrix_mdev,
 				       AP_MKQID(apid, apqi));
 }
 
+static int reset_queues_for_apids(struct ap_matrix_mdev *matrix_mdev,
+				  unsigned long *apm_reset)
+{
+	struct vfio_ap_queue *q, *tmpq;
+	struct list_head qlist;
+	unsigned long apid, apqi;
+	int apqn, ret = 0;
+
+	if (bitmap_empty(apm_reset, AP_DEVICES))
+		return 0;
+
+	INIT_LIST_HEAD(&qlist);
+
+	for_each_set_bit_inv(apid, apm_reset, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm,
+				     AP_DOMAINS) {
+			/*
+			 * If the domain is not in the host's AP configuration,
+			 * then resetting it will fail with response code 01
+			 * (APQN not valid).
+			 */
+			if (!test_bit_inv(apqi,
+					  (unsigned long *)matrix_dev->info.aqm))
+				continue;
+
+			apqn = AP_MKQID(apid, apqi);
+			q = vfio_ap_mdev_get_queue(matrix_mdev, apqn);
+
+			if (q)
+				list_add_tail(&q->reset_qnode, &qlist);
+		}
+	}
+
+	ret = vfio_ap_mdev_reset_qlist(&qlist);
+
+	list_for_each_entry_safe(q, tmpq, &qlist, reset_qnode)
+		list_del(&q->reset_qnode);
+
+	return ret;
+}
+
 /**
  * assign_adapter_store - parses the APID from @buf and sets the
  * corresponding bit in the mediated matrix device's APM
@@ -951,6 +1009,7 @@ static ssize_t assign_adapter_store(struct device *dev,
 {
 	int ret;
 	unsigned long apid;
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	mutex_lock(&ap_perms_mutex);
@@ -980,8 +1039,10 @@ static ssize_t assign_adapter_store(struct device *dev,
 
 	vfio_ap_mdev_link_adapter(matrix_mdev, apid);
 
-	if (vfio_ap_mdev_filter_matrix(matrix_mdev))
+	if (vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered)) {
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+		reset_queues_for_apids(matrix_mdev, apm_filtered);
+	}
 
 	ret = count;
 done:
@@ -1012,11 +1073,12 @@ static struct vfio_ap_queue
  *				 adapter was assigned.
  * @matrix_mdev: the matrix mediated device to which the adapter was assigned.
  * @apid: the APID of the unassigned adapter.
- * @qtable: table for storing queues associated with unassigned adapter.
+ * @qlist: list for storing queues associated with unassigned adapter that
+ *	   need to be reset.
  */
 static void vfio_ap_mdev_unlink_adapter(struct ap_matrix_mdev *matrix_mdev,
 					unsigned long apid,
-					struct ap_queue_table *qtable)
+					struct list_head *qlist)
 {
 	unsigned long apqi;
 	struct vfio_ap_queue *q;
@@ -1024,11 +1086,10 @@ static void vfio_ap_mdev_unlink_adapter(struct ap_matrix_mdev *matrix_mdev,
 	for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
 		q = vfio_ap_unlink_apqn_fr_mdev(matrix_mdev, apid, apqi);
 
-		if (q && qtable) {
+		if (q && qlist) {
 			if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
 			    test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
-				hash_add(qtable->queues, &q->mdev_qnode,
-					 q->apqn);
+				list_add_tail(&q->reset_qnode, qlist);
 		}
 	}
 }
@@ -1036,26 +1097,23 @@ static void vfio_ap_mdev_unlink_adapter(struct ap_matrix_mdev *matrix_mdev,
 static void vfio_ap_mdev_hot_unplug_adapter(struct ap_matrix_mdev *matrix_mdev,
 					    unsigned long apid)
 {
-	int loop_cursor;
-	struct vfio_ap_queue *q;
-	struct ap_queue_table *qtable = kzalloc(sizeof(*qtable), GFP_KERNEL);
+	struct vfio_ap_queue *q, *tmpq;
+	struct list_head qlist;
 
-	hash_init(qtable->queues);
-	vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, qtable);
+	INIT_LIST_HEAD(&qlist);
+	vfio_ap_mdev_unlink_adapter(matrix_mdev, apid, &qlist);
 
 	if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm)) {
 		clear_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 	}
 
-	vfio_ap_mdev_reset_queues(qtable);
+	vfio_ap_mdev_reset_qlist(&qlist);
 
-	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
+	list_for_each_entry_safe(q, tmpq, &qlist, reset_qnode) {
 		vfio_ap_unlink_mdev_fr_queue(q);
-		hash_del(&q->mdev_qnode);
+		list_del(&q->reset_qnode);
 	}
-
-	kfree(qtable);
 }
 
 /**
@@ -1156,6 +1214,7 @@ static ssize_t assign_domain_store(struct device *dev,
 {
 	int ret;
 	unsigned long apqi;
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev = dev_get_drvdata(dev);
 
 	mutex_lock(&ap_perms_mutex);
@@ -1185,8 +1244,10 @@ static ssize_t assign_domain_store(struct device *dev,
 
 	vfio_ap_mdev_link_domain(matrix_mdev, apqi);
 
-	if (vfio_ap_mdev_filter_matrix(matrix_mdev))
+	if (vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered)) {
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+		reset_queues_for_apids(matrix_mdev, apm_filtered);
+	}
 
 	ret = count;
 done:
@@ -1199,7 +1260,7 @@ static DEVICE_ATTR_WO(assign_domain);
 
 static void vfio_ap_mdev_unlink_domain(struct ap_matrix_mdev *matrix_mdev,
 				       unsigned long apqi,
-				       struct ap_queue_table *qtable)
+				       struct list_head *qlist)
 {
 	unsigned long apid;
 	struct vfio_ap_queue *q;
@@ -1207,11 +1268,10 @@ static void vfio_ap_mdev_unlink_domain(struct ap_matrix_mdev *matrix_mdev,
 	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
 		q = vfio_ap_unlink_apqn_fr_mdev(matrix_mdev, apid, apqi);
 
-		if (q && qtable) {
+		if (q && qlist) {
 			if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm) &&
 			    test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm))
-				hash_add(qtable->queues, &q->mdev_qnode,
-					 q->apqn);
+				list_add_tail(&q->reset_qnode, qlist);
 		}
 	}
 }
@@ -1219,26 +1279,23 @@ static void vfio_ap_mdev_unlink_domain(struct ap_matrix_mdev *matrix_mdev,
 static void vfio_ap_mdev_hot_unplug_domain(struct ap_matrix_mdev *matrix_mdev,
 					   unsigned long apqi)
 {
-	int loop_cursor;
-	struct vfio_ap_queue *q;
-	struct ap_queue_table *qtable = kzalloc(sizeof(*qtable), GFP_KERNEL);
+	struct vfio_ap_queue *q, *tmpq;
+	struct list_head qlist;
 
-	hash_init(qtable->queues);
-	vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, qtable);
+	INIT_LIST_HEAD(&qlist);
+	vfio_ap_mdev_unlink_domain(matrix_mdev, apqi, &qlist);
 
 	if (test_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm)) {
 		clear_bit_inv(apqi, matrix_mdev->shadow_apcb.aqm);
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 	}
 
-	vfio_ap_mdev_reset_queues(qtable);
+	vfio_ap_mdev_reset_qlist(&qlist);
 
-	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
+	list_for_each_entry_safe(q, tmpq, &qlist, reset_qnode) {
 		vfio_ap_unlink_mdev_fr_queue(q);
-		hash_del(&q->mdev_qnode);
+		list_del(&q->reset_qnode);
 	}
-
-	kfree(qtable);
 }
 
 /**
@@ -1577,7 +1634,7 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 		get_update_locks_for_kvm(kvm);
 
 		kvm_arch_crypto_clear_masks(kvm);
-		vfio_ap_mdev_reset_queues(&matrix_mdev->qtable);
+		vfio_ap_mdev_reset_queues(matrix_mdev);
 		kvm_put_kvm(kvm);
 		matrix_mdev->kvm = NULL;
 
@@ -1659,12 +1716,12 @@ static int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q,
 	return ret;
 }
 
-static int vfio_ap_mdev_reset_queues(struct ap_queue_table *qtable)
+static int vfio_ap_mdev_reset_queues(struct ap_matrix_mdev *matrix_mdev)
 {
 	int ret, loop_cursor, rc = 0;
 	struct vfio_ap_queue *q;
 
-	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
+	hash_for_each(matrix_mdev->qtable.queues, loop_cursor, q, mdev_qnode) {
 		ret = vfio_ap_mdev_reset_queue(q, 1);
 		/*
 		 * Regardless whether a queue turns out to be busy, or
@@ -1678,6 +1735,21 @@ static int vfio_ap_mdev_reset_queues(struct ap_queue_table *qtable)
 	return rc;
 }
 
+static int vfio_ap_mdev_reset_qlist(struct list_head *qlist)
+{
+	int ret, rc = 0;
+	struct vfio_ap_queue *q;
+
+	list_for_each_entry(q, qlist, reset_qnode) {
+		ret = vfio_ap_mdev_reset_queue(q, 1);
+		/* Continue resetting the remaining queues after an error. */
+		if (ret)
+			rc = ret;
+	}
+
+	return rc;
+}
+
 static int vfio_ap_mdev_open_device(struct vfio_device *vdev)
 {
 	struct ap_matrix_mdev *matrix_mdev =
@@ -1730,7 +1802,7 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
 		ret = vfio_ap_mdev_get_device_info(arg);
 		break;
 	case VFIO_DEVICE_RESET:
-		ret = vfio_ap_mdev_reset_queues(&matrix_mdev->qtable);
+		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
 		break;
 	default:
 		ret = -EOPNOTSUPP;
@@ -1866,6 +1938,7 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 {
 	int ret;
 	struct vfio_ap_queue *q;
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
 	struct ap_matrix_mdev *matrix_mdev;
 
 	ret = sysfs_create_group(&apdev->device.kobj, &vfio_queue_attr_group);
@@ -1896,15 +1969,17 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 		    !bitmap_empty(matrix_mdev->aqm_add, AP_DOMAINS))
 			goto done;
 
-		if (vfio_ap_mdev_filter_matrix(matrix_mdev))
+		if (vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered)) {
 			vfio_ap_mdev_update_guest_apcb(matrix_mdev);
+			reset_queues_for_apids(matrix_mdev, apm_filtered);
+		}
 	}
 
 done:
 	dev_set_drvdata(&apdev->device, q);
 	release_update_locks_for_mdev(matrix_mdev);
 
-	return 0;
+	return ret;
 
 err_remove_group:
 	sysfs_remove_group(&apdev->device.kobj, &vfio_queue_attr_group);
@@ -2249,6 +2324,7 @@ void vfio_ap_on_cfg_changed(struct ap_config_info *cur_cfg_info,
 
 static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 {
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES) = { 0 };
 	bool filter_domains, filter_adapters, filter_cdoms, do_hotplug = false;
 
 	mutex_lock(&matrix_mdev->kvm->lock);
@@ -2262,7 +2338,7 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 					 matrix_mdev->adm_add, AP_DOMAINS);
 
 	if (filter_adapters || filter_domains)
-		do_hotplug = vfio_ap_mdev_filter_matrix(matrix_mdev);
+		do_hotplug = vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered);
 
 	if (filter_cdoms)
 		do_hotplug |= vfio_ap_mdev_filter_cdoms(matrix_mdev);
@@ -2270,6 +2346,8 @@ static void vfio_ap_mdev_hot_plug_cfg(struct ap_matrix_mdev *matrix_mdev)
 	if (do_hotplug)
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 
+	reset_queues_for_apids(matrix_mdev, apm_filtered);
+
 	mutex_unlock(&matrix_dev->mdevs_lock);
 	mutex_unlock(&matrix_mdev->kvm->lock);
 }
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 976a65f32e7d1..5ff7732607b7d 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -130,6 +130,8 @@ struct ap_matrix_mdev {
  * @apqn: the APQN of the AP queue device
  * @saved_isc: the guest ISC registered with the GIB interface
  * @mdev_qnode: allows the vfio_ap_queue struct to be added to a hashtable
+ * @reset_qnode: allows the vfio_ap_queue struct to be added to a list of queues
+ *		 that need to be reset
  * @reset_rc: the status response code from the last reset of the queue
  */
 struct vfio_ap_queue {
@@ -139,6 +141,7 @@ struct vfio_ap_queue {
 #define VFIO_AP_ISC_INVALID 0xff
 	unsigned char saved_isc;
 	struct hlist_node mdev_qnode;
+	struct list_head reset_qnode;
 	unsigned int reset_rc;
 };
 
-- 
2.53.0

