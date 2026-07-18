Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29131427A;
	Sat, 18 Jul 2026 04:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784349274; cv=none; b=tZ8/cYhBoV6uO7wmUAHKDPEpTE+Bd8hlMPtGvp26nQMuARmHXYk55+UlN/NK0rfVo9CCTg4dMZSY8j/bw3TiI6ab9A8aY+kr7VX+5/klyNukK9x7ce6TyYc0gx8ZSmfWmnfMMNk2SNLZdx+juBF+p677UeLxPmVs2n7fxahn14Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784349274; c=relaxed/simple;
	bh=XlZDNOoihjnhHSkoTh8oZ95o077tOQyiT1ck5T+SFJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MMHL3alADUFHTUsqF4KngMz3eDPOxf4QIb1no+Ru8qAewZo25tDB78nlgZZ91iFKvHd7FVR8TBsCFZggeISla8K10ZJbH24dK//U3lnH0ia4VyoYN7H2jmpKS76zvd4ly9xMu0baB5zr8juyfM2tG0q0/fbtt1wJznzEc35ETL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=yNj2hSF1; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="yNj2hSF1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1784349190;
	bh=Ocy0nXdCryk+JKcRXg93dEP/KwQND5rPw7dygrrAKss=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=yNj2hSF1USZ7prPpGgfuAE+DujTAPjXBAav3gAa53eJvmHXAh1KrMQhiEtIDtk0BO
	 maLZmONfqMB6/iGlcPqjv7kDAJZtLJeyEzWvbFXeaD4hsshSZGJlOkct8I9fmSurvP
	 MTh9GDOalruW6kI4QI2Dzllh+qh1xIIeUdA0b3yU=
X-QQ-mid: zesmtpsz3t1784349183t6f825507
X-QQ-Originating-IP: ckwN0mNVgOPRi+1oaTZGzfuRKBkyIDLz8RoLByK5AJQ=
Received: from hepeiyang-vm.wu.lxd ( [218.94.142.195])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 18 Jul 2026 12:33:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 54948482259443969
EX-QQ-RecipientCnt: 10
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: joro@8bytes.org,
	will@kernel.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baolu.lu@linux.intel.com,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH v2] iommu/iommufd: Fix IOPF group ownership UAF
Date: Sat, 18 Jul 2026 12:32:39 +0800
Message-ID: <B474F106872C2E5C+20260718043239.3898247-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn>
References: <B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MD5XEDocxEOL6EhkXljgviKVH+Sv+d7EoMjBkOLUzobLnM/zLZiaG9/m
	zAe4t0D0aegYDlbd4m7KOkDAyZTCctfIJdXTqay5xpmLndwkIwKmb6pPnEzeQNTJ7WBupuR
	dRQX9w5GKA9wvZ1bsE2M/sW4MZmajeqL68nP3xb2TfIX91IBauSz06GL+4etybwnfe1D6fr
	W2ohHewHoiZ5VrpZvcYNIPlYbTrKUoZtEgpHlMCAZYhdeSposIBvFFjIkMmsAsUWv2GH8uG
	mjp+JmeTS2uBnlKVZaDMVdeXpSfvI66aKbSEcnRzUSKEGCrMWy1azwteKZagFm8oYplS0Lc
	TTHS/T2WCO1245Nl81nKI0y07RGlp3/XgNidgSYLABVl2r8g2O98VhSzAimWBMMWss0Gf3F
	S8YZU6TcM2jLm6xDtHZP+sq7mSZfrI07xI2AaT0s+N0v5bHLsR5l+UNA8zZyVcXRv3xZkGV
	T1d4x2C/QxxVdglJ5mJCW8h7KF8N1SB+Qjn8ZOIG7FskCvBiLBhZoKRjCMB7349oN2yObR0
	nYKeN3S4jJUW36B1/kqQxkA269S8OlhzVumtBgftlFanvomLboIAjy1geebmBV0edhBrq8R
	zgjetD0FOycczNplGkEBBcNJb+19koWyH6rI4lmeEKRyYQTddQRNNqlP0z9gxG+djbKy+Ub
	u8gNQ1CutUVYY2jZ9afesLa4d+1/2x6vfs0CBrEK/kMeApiiXCdfbIi7Gvg1Qr/cI5OwalQ
	AO8YZu94pBp+uZkkUXPG3+TnnH13LRxlRJUf45fDnx7FodIsO+XWly/zHDBWmVjBTE6vtSU
	gmy/GO9IMpySo14QnLwj6EwZzFpfP5qc5KJVv1t3bWv8EvlmMyCHsxK79oASFr35txBLlI2
	8HoVf1e5DWhZtPuqQnbThsal5jpjG7pfGm8tZWG+oP0xwxr+hIqyL8L9NrJ8xXQVaE+/6jf
	H8tryYy3V4FCLM0F0UXAANv1n3ecZfYvOnG+H7nYJ3BAqd3pxU7QjNzTR9nqytiCpVjtASQ
	1LrsKoyPaVlGVAmQHyC/r+JV/mfcGQH02q87RP07a+TVWWL6Xd
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

iopf_group_alloc() links each last-page IOPF group into the generic IOPF
pending list before invoking the domain fault handler.
iommufd_fault_iopf_handler() also queued an accepted group in the
IOMMUFD deliver list without removing it from the generic pending list.

When detach or HWPT replacement drops the device's IOPF reference count
to zero, an IOMMU driver may call iopf_queue_remove_device(). That
function responds to and frees groups through the generic pending list
without removing the same groups from IOMMUFD's deliver list or response
xarray. A later read, response, or cleanup can then access the freed
group and cause a UAF.

Fix this by dequeuing an accepted group from the generic pending list
before IOMMUFD queues it for userspace response, and by making
iopf_group_response() free the group as well after sending the response.
The abort_group cleanup in iommu_report_device_fault() keeps
using the locked helper, since abort_group is stack-allocated
and must not be freed by iopf_group_response().

Closes: https://lore.kernel.org/all/B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn/
Fixes: 34765cbc679c ("iommufd: Associate fault object with iommufd_hw_pgtable")
Cc: stable@vger.kernel.org
Tested-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.6-sol
---
Changes in v2:
  - simplify the fix by moving group freeing into iopf_group_response()
    (suggested by Kevin)
  - rename iopf_group_take_ownership() to iopf_group_dequeue()
    (suggested by Kevin)
  - drop changes in iommufd_hwpt_replace_device (suggested by Kevin)
  - rebase to 12f16a37f298

 drivers/iommu/io-pgfault.c     | 84 +++++++++++++++++++++-------------
 drivers/iommu/iommu-sva.c      |  1 -
 drivers/iommu/iommufd/eventq.c |  7 +--
 include/linux/iommu.h          | 10 ++--
 4 files changed, 58 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index cca52a34d0ed69273f23d9ce7793f7065388273f..e5d3a32fc2a6c02acc120e7f7a95972ae658a223 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -52,12 +52,11 @@ static void __iopf_free_group(struct iopf_group *group)
 	iopf_put_dev_fault_param(group->fault_param);
 }
 
-void iopf_free_group(struct iopf_group *group)
+static void iopf_free_group(struct iopf_group *group)
 {
 	__iopf_free_group(group);
 	kfree(group);
 }
-EXPORT_SYMBOL_GPL(iopf_free_group);
 
 /* Non-last request of a group. Postpone until the last one. */
 static int report_partial_fault(struct iommu_fault_param *fault_param,
@@ -168,6 +167,25 @@ static void iopf_error_response(struct device *dev, struct iopf_fault *evt)
 	ops->page_response(dev, evt, &resp);
 }
 
+static void iopf_group_response_locked(struct iopf_group *group,
+				       enum iommu_page_response_code status)
+{
+	struct iommu_fault_param *fault_param = group->fault_param;
+	struct iopf_fault *iopf = &group->last_fault;
+	struct device *dev = fault_param->dev;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	struct iommu_page_response resp = {
+		.pasid = iopf->fault.prm.pasid,
+		.grpid = iopf->fault.prm.grpid,
+		.code = status,
+	};
+
+	lockdep_assert_held(&fault_param->lock);
+
+	ops->page_response(dev, &group->last_fault, &resp);
+	list_del_init(&group->pending_node);
+}
+
 /**
  * iommu_report_device_fault() - Report fault event to device driver
  * @dev: the device
@@ -255,10 +273,7 @@ int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 
 	group->attach_handle = attach_handle;
 
-	/*
-	 * On success iopf_handler must call iopf_group_response() and
-	 * iopf_free_group()
-	 */
+	/* On success iopf_handler must call iopf_group_response(). */
 	if (group->attach_handle->domain->iopf_handler(group))
 		goto err_abort;
 
@@ -267,11 +282,14 @@ int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 err_abort:
 	dev_warn_ratelimited(dev, "iopf with pasid %d aborted\n",
 			     fault->prm.pasid);
-	iopf_group_response(group, IOMMU_PAGE_RESP_FAILURE);
-	if (group == &abort_group)
+	if (group == &abort_group) {
+		mutex_lock(&group->fault_param->lock);
+		iopf_group_response_locked(group, IOMMU_PAGE_RESP_FAILURE);
+		mutex_unlock(&group->fault_param->lock);
 		__iopf_free_group(group);
-	else
-		iopf_free_group(group);
+	} else {
+		iopf_group_response(group, IOMMU_PAGE_RESP_FAILURE);
+	}
 
 	return 0;
 
@@ -318,30 +336,39 @@ EXPORT_SYMBOL_GPL(iopf_queue_flush_dev);
  * iopf_group_response - Respond a group of page faults
  * @group: the group of faults with the same group id
  * @status: the response code
+ *
+ * The group will be freed as well and must not be accessed after
+ * this function returns.
  */
 void iopf_group_response(struct iopf_group *group,
 			 enum iommu_page_response_code status)
 {
 	struct iommu_fault_param *fault_param = group->fault_param;
-	struct iopf_fault *iopf = &group->last_fault;
-	struct device *dev = group->fault_param->dev;
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
-	struct iommu_page_response resp = {
-		.pasid = iopf->fault.prm.pasid,
-		.grpid = iopf->fault.prm.grpid,
-		.code = status,
-	};
 
-	/* Only send response if there is a fault report pending */
 	mutex_lock(&fault_param->lock);
-	if (!list_empty(&group->pending_node)) {
-		ops->page_response(dev, &group->last_fault, &resp);
-		list_del_init(&group->pending_node);
-	}
+	iopf_group_response_locked(group, status);
 	mutex_unlock(&fault_param->lock);
+	iopf_free_group(group);
 }
 EXPORT_SYMBOL_GPL(iopf_group_response);
 
+/**
+ * iopf_group_dequeue - Dequeue a page fault group from the pending list
+ * @group: the group to dequeue
+ *
+ * The fault handler is responsible for responding to the group after
+ * this function returns.
+ */
+void iopf_group_dequeue(struct iopf_group *group)
+{
+	struct iommu_fault_param *fault_param = group->fault_param;
+
+	mutex_lock(&fault_param->lock);
+	list_del_init(&group->pending_node);
+	mutex_unlock(&fault_param->lock);
+}
+EXPORT_SYMBOL_GPL(iopf_group_dequeue);
+
 /**
  * iopf_queue_discard_partial - Remove all pending partial fault
  * @queue: the queue whose partial faults need to be discarded
@@ -454,7 +481,6 @@ void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 	struct iopf_group *group, *temp;
 	struct dev_iommu *param = dev->iommu;
 	struct iommu_fault_param *fault_param;
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	mutex_lock(&queue->lock);
 	mutex_lock(&param->lock);
@@ -469,15 +495,7 @@ void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 		kfree(partial_iopf);
 
 	list_for_each_entry_safe(group, temp, &fault_param->faults, pending_node) {
-		struct iopf_fault *iopf = &group->last_fault;
-		struct iommu_page_response resp = {
-			.pasid = iopf->fault.prm.pasid,
-			.grpid = iopf->fault.prm.grpid,
-			.code = IOMMU_PAGE_RESP_INVALID
-		};
-
-		ops->page_response(dev, iopf, &resp);
-		list_del_init(&group->pending_node);
+		iopf_group_response_locked(group, IOMMU_PAGE_RESP_INVALID);
 		iopf_free_group(group);
 	}
 	mutex_unlock(&fault_param->lock);
diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index bc7c7232a43e2d5edde679b953e85380413a7f2b..caccaa315461c6d18ca936e84dfa1cefa5e33e4a 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -292,7 +292,6 @@ static void iommu_sva_handle_iopf(struct work_struct *work)
 	}
 
 	iopf_group_response(group, status);
-	iopf_free_group(group);
 }
 
 static int iommu_sva_iopf_handler(struct iopf_group *group)
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 5129e3bf5461cb1ef85c550369c9d1b2aa771829..62110fe8f78f511c96be4fa4c2bf8fb552083f38 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -40,7 +40,6 @@ void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 	list_for_each_entry_safe(group, next, &free_list, node) {
 		list_del(&group->node);
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
-		iopf_free_group(group);
 	}
 
 	xa_for_each(&fault->response, index, group) {
@@ -48,7 +47,6 @@ void iommufd_auto_response_faults(struct iommufd_hw_pagetable *hwpt,
 			continue;
 		xa_erase(&fault->response, index);
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
-		iopf_free_group(group);
 	}
 	mutex_unlock(&fault->mutex);
 }
@@ -70,12 +68,10 @@ void iommufd_fault_destroy(struct iommufd_object *obj)
 	list_for_each_entry_safe(group, next, &fault->common.deliver, node) {
 		list_del(&group->node);
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
-		iopf_free_group(group);
 	}
 	xa_for_each(&fault->response, index, group) {
 		xa_erase(&fault->response, index);
 		iopf_group_response(group, IOMMU_PAGE_RESP_INVALID);
-		iopf_free_group(group);
 	}
 	xa_destroy(&fault->response);
 	mutex_destroy(&fault->mutex);
@@ -217,7 +213,6 @@ static ssize_t iommufd_fault_fops_write(struct file *filep, const char __user *b
 		}
 
 		iopf_group_response(group, response.code);
-		iopf_free_group(group);
 		done += response_size;
 	}
 	mutex_unlock(&fault->mutex);
@@ -484,6 +479,8 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 	hwpt = group->attach_handle->domain->iommufd_hwpt;
 	fault = hwpt->fault;
 
+	iopf_group_dequeue(group);
+
 	spin_lock(&fault->common.lock);
 	list_add_tail(&group->node, &fault->common.deliver);
 	spin_unlock(&fault->common.lock);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d20aa6f6863ab35a5932911219705f2ffd0e3352..f16c88d9266180df79b4da515f5e3094ac61f9df 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1700,10 +1700,10 @@ int iopf_queue_flush_dev(struct device *dev);
 struct iopf_queue *iopf_queue_alloc(const char *name);
 void iopf_queue_free(struct iopf_queue *queue);
 int iopf_queue_discard_partial(struct iopf_queue *queue);
-void iopf_free_group(struct iopf_group *group);
 int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
 void iopf_group_response(struct iopf_group *group,
 			 enum iommu_page_response_code status);
+void iopf_group_dequeue(struct iopf_group *group);
 #else
 static inline int
 iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
@@ -1735,10 +1735,6 @@ static inline int iopf_queue_discard_partial(struct iopf_queue *queue)
 	return -ENODEV;
 }
 
-static inline void iopf_free_group(struct iopf_group *group)
-{
-}
-
 static inline int
 iommu_report_device_fault(struct device *dev, struct iopf_fault *evt)
 {
@@ -1749,5 +1745,9 @@ static inline void iopf_group_response(struct iopf_group *group,
 				       enum iommu_page_response_code status)
 {
 }
+
+static inline void iopf_group_dequeue(struct iopf_group *group)
+{
+}
 #endif /* CONFIG_IOMMU_IOPF */
 #endif /* __LINUX_IOMMU_H */

base-commit: 12f16a37f2982028e21919466401179647f603c7
-- 
2.43.0
