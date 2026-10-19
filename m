Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1146D5AAA52
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421311; cv=none; b=ew5qkFjVBQDIHVTmvUVig9s7cA4mF89G/SqZ0Z1iG1oFxeOsdu6i7MYJDL7EHTfTJmFcyPAIfEQwzyzDAGDwNISwwnDGCTyuJ3X4uQoKYNJGHOMAMbtHhEvfQUU1Ay5QP9uZZd9VupxGCJugQPMuvNsLTLngxbAMO88xlfKFqQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421311; c=relaxed/simple;
	bh=aBZgvx5AFZwCf03Ahi68/awnQnooEp8Mjw/w0sZnVnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nVawO75bZt4M7txF/M7TgoU1rIYyGeHJvGNAZ9LYkqwihIU/P4l4rAtJ8s7hmthuUT0h/MVB8xFLZhWoBpW76+PqnT6CkRS2+hUkG1m3XQRuGMUcaiKk6GZn9KmaBd14yETCl4C4HqXQSUIBpVIZG+VzbiNpti9iaEiYV5zESlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ne8V/SaG; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ne8V/SaG"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6446A4E4120B;
	Mon, 19 Oct 2026 14:48:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2034760582;
	Mon, 19 Oct 2026 14:48:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7ED0B10328429;
	Mon, 19 Oct 2026 16:48:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792421306; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=JR4IHDSRgQJ3VIRoS2/YpjwalKLaNm4asJn6D5gPeQI=;
	b=ne8V/SaGA7Ak8N3LTCA/IMZyl1I+o4rLjc3Gnl26S4Fo+94G0/+ZF8ozihG8MwOYIHWxx9
	JnSRfHvZbKxw75BE0w2cLgChdtlQ+YuI0GuOGOtwzpk1ksqlR3X5D8mfyCptEsF53T7e3z
	MGTmIJnet45dKuoTkio3dQeKpcJMf6RcaLwx9kTmZBXsgCAt1s35isCB7tXHblSGELQcDY
	ehzSjaJs0gv/ieFK7C0eZSMltCu+TSg4XP32UZOZcG79muaF/hk9l1BGhwnFYCorFJdnsy
	z2EpEKs7lWZaW1q5a6J91KC7gkgJNhcI/szQUSqW4TpqSBpYEg/Jgqn5TQcjsQ==
From: "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>
Date: Mon, 19 Oct 2026 16:48:09 +0200
Subject: [PATCH 6.12.y] iommu/iommufd: Fix IOPF group ownership UAF
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-cve-2026-74520-v1-1-d023191fcf1d@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQ6CMBCE4Vchc3ZJW2qLvorhgHWB5YCmVQIhv
 LtFj98k829IHIUTrsWGyLMkeU4Z+lQgDO3UM8kjG0YZp5W+UJiZDpC3Z6Oos86zr+o2eIt8ekX
 uZPkFb3ClNuWK5r+nz33k8D5q2PcvLnA/8HoAAAA=
X-Change-ID: 20261019-cve-2026-74520-f467e738ac74
To: stable@vger.kernel.org
Cc: Benjamin Robin <benjamin.robin@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Peiyang He <peiyang_he@smail.nju.edu.cn>, Kevin Tian <kevin.tian@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Miguel Gazquez (Schneider Electric)" <miguel.gazquez@bootlin.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792421299; l=4889;
 i=miguel.gazquez@bootlin.com; s=20250708; h=from:subject:message-id;
 bh=qGcBWjym7W3iX6rze+WhDI3UzM+W/cGqEN3DLbCS0pI=;
 b=IlNhgFkQJ7MaiG+STcZ2t0nWRxWFyPBhDQLdQ1bSUtm6TYIrOXWc1r4s9d0qJA+kLkjdVO++z
 Tmuvq5AMy1oAzw/6eb5X3HK/Tl8NPBuLgAFb2suJSqFeWrZZrb7i/sW
X-Developer-Key: i=miguel.gazquez@bootlin.com; a=ed25519;
 pk=k/2KI9jkmayaF0ghZ8QYUH9Wm/kFHDhl8QoZ0RHbr4w=
X-Last-TLS-Session-Version: TLSv1.3

From: Peiyang He <peiyang_he@smail.nju.edu.cn>

commit 738e6f32e61d80b554e37015ecb7bc620b88001c upstream.

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

[Moved the changes to iommufd_fault_iopf_handler from eventq.c to
fault.c, as the function was there in 6.12]

Link: https://patch.msgid.link/r/3CFD314D0FE4D7EC+20260720085017.3998878-2-peiyang_he@smail.nju.edu.cn
Closes: https://lore.kernel.org/all/B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn/
Fixes: 34765cbc679c ("iommufd: Associate fault object with iommufd_hw_pgtable")
Cc: stable@vger.kernel.org
Tested-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>
---
 drivers/iommu/io-pgfault.c    | 24 +++++++++++++++++++-----
 drivers/iommu/iommufd/fault.c |  2 ++
 include/linux/iommu.h         |  5 +++++
 3 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/io-pgfault.c b/drivers/iommu/io-pgfault.c
index 8b5926c1452e..afe977235d72 100644
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
diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 74e3c93bce6e..bdaecb6e1f7a 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -454,6 +454,8 @@ int iommufd_fault_iopf_handler(struct iopf_group *group)
 	hwpt = group->attach_handle->domain->fault_data;
 	fault = hwpt->fault;
 
+	iopf_group_dequeue(group);
+
 	spin_lock(&fault->lock);
 	list_add_tail(&group->node, &fault->deliver);
 	spin_unlock(&fault->lock);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index dc7ceb9406ed..929b9d0d90cd 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1566,6 +1566,7 @@ void iopf_free_group(struct iopf_group *group);
 int iommu_report_device_fault(struct device *dev, struct iopf_fault *evt);
 void iopf_group_response(struct iopf_group *group,
 			 enum iommu_page_response_code status);
+void iopf_group_dequeue(struct iopf_group *group);
 #else
 static inline int
 iopf_queue_add_device(struct iopf_queue *queue, struct device *dev)
@@ -1611,5 +1612,9 @@ static inline void iopf_group_response(struct iopf_group *group,
 				       enum iommu_page_response_code status)
 {
 }
+
+static inline void iopf_group_dequeue(struct iopf_group *group)
+{
+}
 #endif /* CONFIG_IOMMU_IOPF */
 #endif /* __LINUX_IOMMU_H */

---
base-commit: 7fdb7c1824a1f9979d648d7ae28ac446bcee9c6e
change-id: 20261019-cve-2026-74520-f467e738ac74

Best regards,
--  
Miguel Gazquez (Schneider Electric) <miguel.gazquez@bootlin.com>

