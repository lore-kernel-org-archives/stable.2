Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBAB1D9A5F
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 12:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636573; cv=none; b=AJTDE0Y+SQZXbTAqd9zAcfk4ZUNQNprqBIjtnj23ttGtRaLc0OdvH5X+mO+jUuZfgY7uIX0IH4CtJl1sXJHrIl+8eyfSbPutQF6EtTWxyNPKZXtdK85YJBzA8sOpno9aAd7Bk0PlWC/TQFRRAnyTgWD7JETD5BRvr11XsyBomZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636573; c=relaxed/simple;
	bh=Yvvbk1gu+fJikSak7L2EL2dw7CjYVT2ADYFEwXW0q40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abK8yNMnOzNh1D32jDZNQjgQ/4gvibnXLbCqRdrPXPOEGviiPTFkxP0GSmaUCHapCtl6akRGFfbcC+ahyXXuLSRbmJ+mW18ojZSogJUiRhUdKnrInkf9QDSKtncdvRpdw7ChBonYHrauiJBIfUkfCzf/WCg4RZtDCBTeKChis3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzgalKmY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzgalKmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7451F000E9;
	Tue, 21 Jul 2026 12:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784636572;
	bh=7f5mK1Im+kTSi5Q6s6XJdinJrHgb2m/AJCoVkWh0Rac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KzgalKmYS4paX7Q6O1HYGL5wG6tLNXtUrl2BhtND9h7aPsc/fk9UrStzk6Npc9OuY
	 iiqjkoYDWfIoU/FB555LcgKLdnJqn2PXI0eya2EWIUGCehfPVcLjK+Mkc0XEJyBkjM
	 76QMgPJFocgInojUWBh9TYzx/VmMZsfWmBr19e2Hl+fqWFgRSJgAN6mUdwO1T9HctQ
	 3yru3A6baNlxfdoap/pxhlqTIacMBVXLD8/zZ7W4sUFsDReJYPQnLUNMIm3G52McoF
	 DN8qEGsD1ZJ+Qyz3Qomx8GRMpo2v3WS/DvRTEuih/NKUqkhaTJBUmXa23M+jk1keg5
	 sFMkPaCc4zt1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] iommufd: Propagate allocation failure in iommufd_veventq_deliver_fetch()
Date: Tue, 21 Jul 2026 08:22:50 -0400
Message-ID: <20260721122250.3827936-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071652-safeguard-secluding-f2b1@gregkh>
References: <2026071652-safeguard-secluding-f2b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

[ Upstream commit 489e63dd120bad52eba63f5506c214750cd5bc75 ]

When the kzalloc_obj() fails in iommufd_veventq_deliver_fetch(), it returns
NULL, falsely advertising to userspace that the queue is empty.

Propagate the -ENOMEM properly to the caller.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Link: https://patch.msgid.link/r/25d29feac909e36f78c145fa99ef2d4cb7a415da.1780343944.git.nicolinc@nvidia.com
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/eventq.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/eventq.c b/drivers/iommu/iommufd/eventq.c
index 617e20b67bf2a0..a934f02528b0ba 100644
--- a/drivers/iommu/iommufd/eventq.c
+++ b/drivers/iommu/iommufd/eventq.c
@@ -272,8 +272,10 @@ iommufd_veventq_deliver_fetch(struct iommufd_veventq *veventq)
 		/* Make a copy of the lost_events_header for copy_to_user */
 		if (next == &veventq->lost_events_header) {
 			vevent = kzalloc(sizeof(*vevent), GFP_ATOMIC);
-			if (!vevent)
+			if (!vevent) {
+				vevent = ERR_PTR(-ENOMEM);
 				goto out_unlock;
+			}
 		}
 		list_del(&next->node);
 		if (vevent)
@@ -323,6 +325,12 @@ static ssize_t iommufd_veventq_fops_read(struct file *filep, char __user *buf,
 		return -EINVAL;
 
 	while ((cur = iommufd_veventq_deliver_fetch(veventq))) {
+		if (IS_ERR(cur)) {
+			if (done == 0)
+				rc = PTR_ERR(cur);
+			break;
+		}
+
 		/* Validate the remaining bytes against the header size */
 		if (done >= count || sizeof(*hdr) > count - done) {
 			iommufd_veventq_deliver_restore(veventq, cur);
-- 
2.53.0

