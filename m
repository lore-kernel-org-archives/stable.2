Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ACA3CC315;
	Mon, 20 Jul 2026 08:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537608; cv=none; b=Li47oJULEvOEdZJmHDVS/zJeVWraGJhEXT6z1wj2SRgQF7xntepSQuDnEqzbB4nyScaMcG91C6pX6LJvtpA2xHNqCIaLhiJp99oyNUFgVHlsPPEhGh4mruJO66xXjTNWCxywYtmriyXiPEwhoDoHmk00l9TZjn7uq9KmPreZ0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537608; c=relaxed/simple;
	bh=CLOPHEOYhQ9ZQK8q0011TY3NsfB17OqHVBZSVFgqyj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gvdIF/HS5VXfNNbvwhJ5lWrhXCXor1WHnNv8SChQkeT2UhfP71kNgGyI96fomg0LKyLdhgEYuSMGdMiXTq9Bg3YEdj3O4ph1dL4ATe1CpdXNokcRuKzSewszcO+Pp2yE8sTkpjtTu1L2BV8/Xap3n6g3/4XG6vRdSpRdMxgLWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=eJG1nxvT; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="eJG1nxvT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1784537529;
	bh=ZkxlG5xUb66go4eqGyAWnPWtJz4FD+VtWMuc7oVRlkk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=eJG1nxvTAb9hmLbhzzwGGDBYA1GRhBnG2VAuz/oJk1o4VQ2X6KdKtAsh8ZC3ohudw
	 VyDsT5V+vM0eSkpf0q9/V70v+PZp+Vaarn0W+f2X/97bQVzbc2i9jH+yUcUNCxYb/J
	 kDQXvIHcCxB4rJA8wJfdo3699rOLuih/OsuqKa1U=
X-QQ-mid: zesmtpsz6t1784537521ta2d06a96
X-QQ-Originating-IP: 9FBRQ0SQJJ4iyJlSWNBOCrAN5QZN8wBACrZCwaJ383M=
Received: from hepeiyang-vm.wu.lxd ( [218.94.142.195])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 20 Jul 2026 16:51:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2933556675057705989
EX-QQ-RecipientCnt: 10
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: joro@8bytes.org,
	will@kernel.org,
	jgg@ziepe.ca,
	kevin.tian@intel.com
Cc: robin.murphy@arm.com,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	baolu.lu@linux.intel.com,
	Peiyang He <peiyang_he@smail.nju.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] iommu/iommufd: Fix IOPF group ownership UAF
Date: Mon, 20 Jul 2026 16:50:16 +0800
Message-ID: <3CFD314D0FE4D7EC+20260720085017.3998878-2-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720085017.3998878-1-peiyang_he@smail.nju.edu.cn>
References: <B474F106872C2E5C+20260718043239.3898247-1-peiyang_he@smail.nju.edu.cn>
 <20260720085017.3998878-1-peiyang_he@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MZlmA8MJ65ob98oPAkd5lRgOfs1LDlOpiK7MagkmH8D/mlPItfugah5u
	3oEBk6GPyZnkee8NyauWI1ZGm+8T/1NVmGr4Zq4QzYXLA25OFwESvlsj/IUWdVil8Hohijr
	kach57ip4Z7UTgkr7VhIhBx5r4FhFUjpl1jKY61tGHSXEVY3LWDWGroiigYfAQ8z+Anid8H
	fkoMsU8TaYoW6yaqQOVvDoyAWPZi11lLuhbAjdOA4gtskFXMIzORiHO4iIzYHj/dIDK62EZ
	fwCLIbSm+iCBsYbM7mAlfisBVNe3eZp+OOI6PjylHyS1je0fpf7t3Z5h6bsvLVc7yQVJ2c/
	E1zM+zss+LME2KitFRzJweHZJ+E/8DpCJhzzjHWKotimqK4UxRXCVdedDAVm59mX7gMy36D
	r0Oxi7Fcb2Souc03gI4Ot0+ZVUMgogXJp5/9990qUR8GzbkjMUtHUGm+bTIhcyi2mG1LLq7
	0reyTZuy2tmYazgKtgu7cVv4VenZOYRNgeExZRHYWfTU6KOeIXL3sZFSm6koYm9ANPxQT1g
	qggyd0xB2V6HYbIATQQhKLgs+3wOE0uREKTgUzUA+KfnV6Bu405TTTwxNOEG5fJUyFMyWIG
	ifjrEm8iudbsfi7263jV2Ayzf1vYN8xUOxeY20ze6A78vhECdB5RsyM4IEzUfkc0HdgLBzV
	GANA5DV5N0omNeCfeMDOzw9V1WL4BI5WMEygo2QKOW6aAS65adlS5dila5+wrDf5yNoYjfp
	u4HcnESMaqmMXqQfWOZykGkXj5fPyWu+uALaYtd6dukIUSLbmuOLXRG/MvfSBCYto6KaIVY
	2EyZAabied3hetNm5+5sma6sj6r9OPuV7GHsvmc2gGHdtZf7opa8g25+b5Q3ypkFnkBzxUs
	NlHuAzmm06Swnst1tU7L6OZzMXOUq9BbVcMPGUibNH10VRv/SjtkFa/eHTj06EUbIDRoFBu
	zvdpoIZRV37YenRg2H6PEkkJXljusIPeiGZkwAEsQOTll6eMVkInJeta3oqUvXaJH4hwPzX
	UEOJ9YQdxdXfFCSYvj7QcGYA6m+UZQzxTi18aQWwGO8UcS9ckom4+ObpG7Jx5tF6ET5sFji
	LXynxUwiyfWEA07N/obyNjXV10LKl+pZw==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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
before IOMMUFD queues it for userspace response.
Make iopf_group_response() send a response regardless of pending-list
membership, so the dequeued group can still be completed by IOMMUFD.

Closes: https://lore.kernel.org/all/B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn/
Fixes: 34765cbc679c ("iommufd: Associate fault object with iommufd_hw_pgtable")
Cc: stable@vger.kernel.org
Tested-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
---
 drivers/iommu/io-pgfault.c     | 24 +++++++++++++++++++-----
 drivers/iommu/iommufd/eventq.c |  2 ++
 include/linux/iommu.h          |  5 +++++
 3 files changed, 26 insertions(+), 5 deletions(-)

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
-- 
2.43.0

