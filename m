Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290903EA962
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785921887; cv=none; b=VR51q/f1bccqkd6JjAe6GE/anA0pxCsmYpqjWg6avIk4fuuVW4r1OKQOutlp2NwrUU1BnR3F4gZdBG2Now3Oy2oaRRcwKDnAiVjQmHYs/0pQD04IyLt0r5XlWvrMYh4fo3jpG9BTbQnOwibMkH3BF7Gxk5sgVsmo4O56xw8tIMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785921887; c=relaxed/simple;
	bh=D/4TjOj/D4HE2zZ8odEbpqDrYXmkSWInFuvVptSkfMo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PdzKycQKapTEUWw35N3O2U/zvhAMbKeHhJBNE5ksHlNwOgyqLw5edID62jOj5Q95JFn1I5AZBU1KkzhkGSieUhR6CC8BbmN4DAq6N4bPZNdJx1/U6O6fbpaizfx0RFdMZZO78BHTcLQeYTz50yao2VLZgLKZ1AKptC2sv0QNA8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c5DDvu2J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c5DDvu2J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118701F000E9;
	Wed,  5 Aug 2026 09:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785921884;
	bh=HBxHBCI2WjWKvOCuBCHWAw44yR1n5j1r3W9t5Wv/8VU=;
	h=Subject:To:Cc:From:Date;
	b=c5DDvu2JUYRIEV9SFBTiRvefGC7NCzdB63ZUOeKCulcL98WSTcmvTmmNcWpaFPMii
	 Qj6Mg9B6nwdOsq9S9LytLcezw3vikSZmMExsBYOqEvrDrcVhSGps5/LUZ3mO3pq+LM
	 kDt8X8iwPLyPCBRf60Yr6dSMjuqm5B3wzwTXWMvU=
Subject: FAILED: patch "[PATCH] iommu/iommufd: Fix IOPF group ownership UAF" failed to apply to 6.12-stable tree
To: peiyang_he@smail.nju.edu.cn,jgg@nvidia.com,kevin.tian@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:24:27 +0200
Message-ID: <2026080527-calculate-twentieth-9868@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 738e6f32e61d80b554e37015ecb7bc620b88001c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080527-calculate-twentieth-9868@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 738e6f32e61d80b554e37015ecb7bc620b88001c Mon Sep 17 00:00:00 2001
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
Date: Mon, 20 Jul 2026 16:50:16 +0800
Subject: [PATCH] iommu/iommufd: Fix IOPF group ownership UAF

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
before IOMMUFD queues it for userspace response.
Make iopf_group_response() send a response regardless of pending-list
membership, so the dequeued group can still be completed by IOMMUFD.

Link: https://patch.msgid.link/r/3CFD314D0FE4D7EC+20260720085017.3998878-2-peiyang_he@smail.nju.edu.cn
Closes: https://lore.kernel.org/all/B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn/
Fixes: 34765cbc679c ("iommufd: Associate fault object with iommufd_hw_pgtable")
Cc: stable@vger.kernel.org
Tested-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index cca52a34d0ed..c16ff1fc4b95 100644
--- a/drivers/iommu/io-pgfault.c
+++ b/drivers/iommu/io-pgfault.c
@@ -332,16 +332,30 @@ void iopf_group_response(struct iopf_group *group,
 		.code = status,
 	};
 
-	/* Only send response if there is a fault report pending */
 	mutex_lock(&fault_param->lock);
-	if (!list_empty(&group->pending_node)) {
-		ops->page_response(dev, &group->last_fault, &resp);
-		list_del_init(&group->pending_node);
-	}
+	ops->page_response(dev, &group->last_fault, &resp);
+	list_del_init(&group->pending_node);
 	mutex_unlock(&fault_param->lock);
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
diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 5129e3bf5461..747dd5155121 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -484,6 +484,8 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 	hwpt = group->attach_handle->domain->iommufd_hwpt;
 	fault = hwpt->fault;
 
+	iopf_group_dequeue(group);
+
 	spin_lock(&fault->common.lock);
 	list_add_tail(&group->node, &fault->common.deliver);
 	spin_unlock(&fault->common.lock);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d20aa6f6863a..ac43b8b93f14 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1704,6 +1704,7 @@ void iopf_free_group(struct iopf_group *group);
 int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
 void iopf_group_response(struct iopf_group *group,
 			 enum iommu_page_response_code status);
+void iopf_group_dequeue(struct iopf_group *group);
 #else
 static inline int
 iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
@@ -1749,5 +1750,9 @@ static inline void iopf_group_response(struct iopf_group *group,
 				       enum iommu_page_response_code status)
 {
 }
+
+static inline void iopf_group_dequeue(struct iopf_group *group)
+{
+}
 #endif /* CONFIG_IOMMU_IOPF */
 #endif /* __LINUX_IOMMU_H */

