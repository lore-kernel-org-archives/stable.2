Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3448C1F
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636570; cv=none; b=Zp9PNWr27Lf9QHCTtiIqh3VylyGmKtlTq+7EKYV/ylLcuGqg0SPDgzcgGJOrqjagph6XPpJN9vYXzyWHVKgosjinVRuCas8feCW5eMRK1U3vfio9EvHzqzszxCPMsEgWHXgBdRVzfExkXbaDIIcPm83K4Q5xaeClNWvAILltENo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636570; c=relaxed/simple;
	bh=jJ+I0iLFUi+6W64RpN2giUq0JL7ydKYRR8U7S9JqAfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3XvI73OZntq6cRn+m8xbewn/hikhnCnC96uIW7vhpydklxaA9Y/85FOwwHyUSgjyZ147pA0ICcfWlaPmQMZtWrND8SfzAgLfiFB4hbgRxNK0KaSPCoavWIt6sEihA5q9kMm4bkyKIa//ziMwW90dkKN3d8HN6AjRMfbf69Wa/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOIXiz/u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOIXiz/u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A631F000E9;
	Tue, 21 Jul 2026 12:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784636568;
	bh=hG6I4qf+YZLwDArnvgvoQm54NTX5+52sUEhKOiE8m2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NOIXiz/uL/9zuKqCyZZOYYTUPnrPbKOwoxILW1OlLl/ewwIkFSA9GzSXnhe/GC968
	 eK47M6P6/QpIhRXz8OlONVROpDrtxN8dyYdlbFKJXrDWvQYzb/xV9xTdXsxNB7mUzK
	 RcbFNsQkC+zP94JvnKoMSMwgR5kgQJYpJ85HgPvVk7bT8Xtm17dAIV4u6i+p0yAvGj
	 pqnnjW2M+lxAUxIZkNIg2M6l3yvtBizSc8s7TKp7DswDKRD8QxiH7zPlNrhaJPT+UO
	 qylMi6MVxxaHJ9NGsDwYvggUQQpRMmI6Adsusv77S/YpjQkNrKv6eFAbmnnymDosIU
	 eA2rcDtkYOJqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] iommufd: Move vevent memory allocation outside spinlock
Date: Tue, 21 Jul 2026 08:22:46 -0400
Message-ID: <20260721122246.3827754-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071621-gentleman-famine-b64d@gregkh>
References: <2026071621-gentleman-famine-b64d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

[ Upstream commit 47443565d10c51366c9382dbc8597cd6c460b8a2 ]

The veventq memory allocation happens inside the spinlock. Given its depth
is decided by the user space, this leaves a vulnerability, where userspace
can allocate large queues to exhaust atomic memory reserves.

Move the allocation outside the spinlock and use GFP_NOWAIT, which can fail
fast under memory pressure without dipping into the GFP_ATOMIC reserves or
direct-reclaiming from the threaded IRQ handler. On allocation failure,
queue the lost_events_header (so userspace learns of the drop) and return
-ENOMEM so the caller learns of the kernel-side memory pressure.

This is intentionally distinct from the queue-overflow path, which also
queues the lost_events_header but returns 0: a full queue is an expected
userspace-pacing condition rather than a kernel error.

A subsequent change will cap the upper bound of the veventq_depth.

Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and IOMMUFD_CMD_VEVENTQ_ALLOC")
Link: https://patch.msgid.link/r/5ff36b5d80f7f6299f851be532a5195c1d2f1dae.1779408671.git.nicolinc@nvidia.com
Cc: stable@vger.kernel.org
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/driver.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommufd/driver.c b/drivers/iommu/iommufd/driver.c
index 21d4a35538f6a5..37961409c6ac0c 100644
--- a/drivers/iommu/iommufd/driver.c
+++ b/drivers/iommu/iommufd/driver.c
@@ -149,15 +149,18 @@ int iommufd_viommu_report_event(struct iommufd_viommu *viommu,
 		goto out_unlock_veventqs;
 	}
 
-	spin_lock(&veventq->common.lock);
-	if (veventq->num_events == veventq->depth) {
+	/* Pre-allocate to avoid GFP_ATOMIC; use GFP_NOWAIT to avoid sleeping */
+	vevent = kzalloc_flex(*vevent, event_data, data_len, GFP_NOWAIT);
+	if (!vevent) {
+		spin_lock(&veventq->common.lock);
 		vevent = &veventq->lost_events_header;
+		rc = -ENOMEM;
 		goto out_set_header;
 	}
 
-	vevent = kzalloc(struct_size(vevent, event_data, data_len), GFP_ATOMIC);
-	if (!vevent) {
-		rc = -ENOMEM;
+	spin_lock(&veventq->common.lock);
+	if (veventq->num_events == veventq->depth) {
+		kfree(vevent);
 		vevent = &veventq->lost_events_header;
 		goto out_set_header;
 	}
-- 
2.53.0

