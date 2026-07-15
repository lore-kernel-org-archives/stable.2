Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD881A8F7B;
	Wed, 15 Jul 2026 04:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784089683; cv=none; b=TtULY1AR7hTnm4BVj8zvqeUUpQq8dpeqiKpDnzDXWVPohlb1y+Wam7bJfniv3PwBvIqmC+v6B74oYYjh6Y2IHJBUqObtKyxMWP5GAGa1mtSoRi1wYDe5O4q9GGnNIZnlqWnIeApD7TNMRkGTWn5MEiMRzn6f31N2oHrHmBEoBRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784089683; c=relaxed/simple;
	bh=373DrC1YOBPI6BMrnWNYq92CGThNVRPeHXqgFedPuWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XeYM2PI0vkPe5nYOpj1+4qUkFvfDViy4UAuaURa5E9WhJ3Uk2ewHISrEHCmddrhQ/pU30Go7V5RoG0OscZ0RxajZQf2b7mZhqfT1QhX4A+1ArbLkoUc7EvnJctxqK16rCrwBEQQS6N0VKGbbvVQtlBv2OpAeSnBSL+AEU5XbYsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=aMM3QsOa; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="aMM3QsOa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1784089609;
	bh=lHxidtjdAo7GwmpR0PhZAD/LbldvKjYzf6Qy9HMkSJU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=aMM3QsOaRtfcbeYY2V30p2uCx1xolLLjSskm6V73ss/a38GVsV8YpltXr+w3y3f9a
	 MVG0zNEz6n4A2MM7Rjc0ALOgAI2/jFvgdRrEn6woniRAt+97HkQAr+br6v273xWTgh
	 hyu0GPBW7Bvl6ZKea47veA65zDoEn8VfDuuD3HV0=
X-QQ-mid: zesmtpgz1t1784089601t5282b16e
X-QQ-Originating-IP: nDK6nTZV82Ov3yA9IieSUS5sTE9mA5SijtXfOCcnbb4=
Received: from hepeiyang-vm.wu.lxd ( [218.94.142.72])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Jul 2026 12:26:39 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3352090239258274162
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
Subject: [PATCH] iommu/iommufd: Fix IOPF group ownership UAF
Date: Wed, 15 Jul 2026 12:24:21 +0800
Message-ID: <9BE255A7A4AB5AAA+20260715042421.3148159-1-peiyang_he@smail.nju.edu.cn>
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
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OQ0f9NOPxbniyW7Gd/h3Is1IGnTEDrSt2ZdY+CNLZEqL9L/Y3/YItkbb
	LGe9eJva17PDGqX8cBfJ9VP8w8MRhU5nMdA59Cp7Zr3Zh5wcJBXJ+UAKzQCVcK9KOt/fOZN
	IUagK+OBeEYWMPdmh3garP9TAXq/nlh7HRGnR7ybAyeQbCHevMODR0/CzBq6nfqiR7vwS1I
	oSRP3Q3qRvR6UDX96YPrFrD0zBf22Ky1czf7QQ9XLDAoxBFfnWHf3ktT20L5EbvuavlsEv/
	K2rvB/kgAHjbgjNRtNgEqfJ4Tuabibzen+tsUDnJP3SYWAgigNNcd69GIVwKeP06Gp+N3g4
	tzsWyw8h9HY/GYpvCuniXBIJDfQs0sIUYGqkoL20A5DpOtf0fm4TG9dPc5H7mn+MxssjvVH
	hR9IBbK0KVaBNfDjm5vL+GTqV2Gh3AuksqJcBeblOSRtGIdnOimIxVdWaK8qksSaNcmuq2s
	/bPX4IE3r0QExcszRkc7LSZgjBhAmC3L4LJZ7SzfvUlgIaM27vbLOX4FjRRreuNkxxkiF92
	7SyDFgRVNXJCYVUXSIRoS8WJ0op6qjGpn33mOLLV1Hs1gAWHEMFHgWVd5XgOcUU+3YdyeUs
	axcuanq7ppflGi7hfs+neBk8hG96v/nm/rD6duUSgao0JvuT8ZLdWfDS1KtEAnleozdBkca
	t9Kjvr0qek0VbWENcOXdhzGGNKDLQFuU0IUhnn/cgAvJqO5DUAQD4IXKpQtsywE4f+ALmNI
	aWYgce8nEumyQHdeIADMMSnhs/t1MLsLcefBvjKQJNRwLegHAJRcfYrvNpeFBOQubwhdcSr
	cNXIuC2YmrC3jX7buyysx4syORk8Bm3OiQILyQgKaqc0Fk3sxOKiVY0IW9/Jx58zpPYtYvN
	2Zz04PBPqUP/Raoh+kTZgslfHdFGc+ddGNALUpKfWTPadwnPMOYfveWtp1Vgrj6+G17oRhE
	sv47WInPUJvahxbggHkqRj1R6OQxlOIq/V4lVSn4WXIygUP0GXCwcnbAmWvr/9F1AZV5ioz
	TVOvv/2z+nJTKwKbarlQmKb8UGKePPx1qk1vUrbTg2T00BkIpyNgETa0ZSNr7vFkBlQ9C6H
	Bq3+V7tvtex
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

Fix this by separating response state from generic ownership.
Add iopf_group::response_pending to track whether a device response
is still owed, independently of generic pending-list membership,
and update that state under iommu_fault_param::lock in a helper.
Before publishing an accepted group to the IOMMUFD deliver list, call
iopf_group_take_ownership() to remove it from the generic pending list.
IOMMUFD then becomes the sole owner responsible for responding to and
freeing the group.

Closes: https://lore.kernel.org/all/B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn/
Fixes: 34765cbc679c ("iommufd: Associate fault object with iommufd_hw_pgtable")
Cc: stable@vger.kernel.org
Tested-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.6-sol
---
I have tested this patch agaist my PoC which can stably trigger the UAF,
and the UAF is gone after applying this patch.

I also ran the iommufd selftest. Some testcases already fail before
this patch, and this patch does not make more testcases fail.

 drivers/iommu/io-pgfault.c     | 64 +++++++++++++++++++++++-----------
 drivers/iommu/iommufd/device.c |  2 +-
 drivers/iommu/iommufd/eventq.c |  2 ++
 include/linux/iommu.h          |  7 ++++
 4 files changed, 53 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index cca52a34d0ed..b873aef8d97d 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -98,6 +98,7 @@ static struct iopf_group *iopf_group_alloc(struct iommu_fault_param *iopf_param,
 	group->last_fault.fault = evt->fault;
 	INIT_LIST_HEAD(&group->faults);
 	INIT_LIST_HEAD(&group->pending_node);
+	group->response_pending = true;
 	list_add(&group->last_fault.list, &group->faults);
 
 	/* See if we have partial faults for this group */
@@ -314,13 +315,8 @@ int iopf_queue_flush_dev(struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iopf_queue_flush_dev);
 
-/**
- * iopf_group_response - Respond a group of page faults
- * @group: the group of faults with the same group id
- * @status: the response code
- */
-void iopf_group_response(struct iopf_group *group,
-			 enum iommu_page_response_code status)
+static void iopf_group_response_locked(struct iopf_group *group,
+				       enum iommu_page_response_code status)
 {
 	struct iommu_fault_param *fault_param = group->fault_param;
 	struct iopf_fault *iopf = &group->last_fault;
@@ -332,16 +328,51 @@ void iopf_group_response(struct iopf_group *group,
 		.code = status,
 	};
 
+	lockdep_assert_held(&fault_param->lock);
+
 	/* Only send response if there is a fault report pending */
-	mutex_lock(&fault_param->lock);
-	if (!list_empty(&group->pending_node)) {
-		ops->page_response(dev, &group->last_fault, &resp);
+	if (!group->response_pending)
+		return;
+
+	ops->page_response(dev, &group->last_fault, &resp);
+	group->response_pending = false;
+	if (!list_empty(&group->pending_node))
 		list_del_init(&group->pending_node);
-	}
+}
+
+/**
+ * iopf_group_response - Respond a group of page faults
+ * @group: the group of faults with the same group id
+ * @status: the response code
+ */
+void iopf_group_response(struct iopf_group *group,
+			 enum iommu_page_response_code status)
+{
+	struct iommu_fault_param *fault_param = group->fault_param;
+
+	mutex_lock(&fault_param->lock);
+	iopf_group_response_locked(group, status);
 	mutex_unlock(&fault_param->lock);
 }
 EXPORT_SYMBOL_GPL(iopf_group_response);
 
+/**
+ * iopf_group_take_ownership - Take ownership of a group of page faults
+ * @group: the group of faults whose ownership is transferred to the fault handler
+ *
+ * Remove the group from the generic IOPF pending list. The fault handler is
+ * responsible for responding to and freeing the group after this returns.
+ */
+void iopf_group_take_ownership(struct iopf_group *group)
+{
+	struct iommu_fault_param *fault_param = group->fault_param;
+
+	mutex_lock(&fault_param->lock);
+	list_del_init(&group->pending_node);
+	mutex_unlock(&fault_param->lock);
+}
+EXPORT_SYMBOL_GPL(iopf_group_take_ownership);
+
 /**
  * iopf_queue_discard_partial - Remove all pending partial fault
  * @queue: the queue whose partial faults need to be discarded
@@ -454,7 +485,6 @@ void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
 	struct iopf_group *group, *temp;
 	struct dev_iommu *param = dev->iommu;
 	struct iommu_fault_param *fault_param;
-	const struct iommu_ops *ops = dev_iommu_ops(dev);
 
 	mutex_lock(&queue->lock);
 	mutex_lock(&param->lock);
@@ -469,15 +499,7 @@ void iopf_queue_remove_device(struct iopf_queue *queue, struct device *dev)
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
diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 7deb3346cb78..d244a97a6325 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -582,7 +582,7 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 	if (rc)
 		goto out_free_handle;
 
-	iommufd_auto_response_faults(hwpt, old_handle);
+	iommufd_auto_response_faults(old, old_handle);
 	kfree(old_handle);
 
 	return 0;
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 5129e3bf5461..70fd245356a4 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -484,6 +484,8 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 	hwpt = group->attach_handle->domain->iommufd_hwpt;
 	fault = hwpt->fault;
 
+	iopf_group_take_ownership(group);
+
 	spin_lock(&fault->common.lock);
 	list_add_tail(&group->node, &fault->common.deliver);
 	spin_unlock(&fault->common.lock);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d20aa6f6863a..c2180a505ac0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -133,6 +133,8 @@ struct iopf_group {
 	size_t fault_count;
 	/* list node for iommu_fault_param::faults */
 	struct list_head pending_node;
+	/* True if the device still needs a response for this group. */
+	bool response_pending;
 	struct work_struct work;
 	struct iommu_attach_handle *attach_handle;
 	/* The device's fault data parameter. */
@@ -1704,6 +1706,7 @@ void iopf_free_group(struct iopf_group *group);
 int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
 void iopf_group_response(struct iopf_group *group,
 			 enum iommu_page_response_code status);
+void iopf_group_take_ownership(struct iopf_group *group);
 #else
 static inline int
 iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
@@ -1749,5 +1752,9 @@ static inline void iopf_group_response(struct iopf_group *group,
 				       enum iommu_page_response_code status)
 {
 }
+
+static inline void iopf_group_take_ownership(struct iopf_group *group)
+{
+}
 #endif /* CONFIG_IOMMU_IOPF */
 #endif /* __LINUX_IOMMU_H */

base-commit: 8062148046e1a6417d44e2ed86c04e66c2f4f2a1
-- 
2.43.0
