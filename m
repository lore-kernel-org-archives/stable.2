Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FFC1531E8
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786283651; cv=none; b=lJ2Zz9z916CpJ/03X6M2zJ/hraIdDE5cRWWSEkJ5gPIR8FvDBoAxIXX6RbD3Zi33qDP/7N4tDBJST5cSAsMd0bIpZvZFkkdkcyp71l510WogdxQWvWQLHfB5Uw2rkX4XwXVt4Ondwz6C48C5QBaXnPDmolzA17iUrycqgrcg8I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786283651; c=relaxed/simple;
	bh=7eKX+KD93xOu8o9gu+Wsds0EoyHQEsFQESFKEozKUYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gALz3F1Rru214yeKl8YjFUkou7fmjmRhOx/kV3cL+yZTGQZwhWcYHSxJHrab5E+qCMGg0cvmYmhxnK2UMaYygYmvel3NMCLwJRZEUCXCZWPJ09j08AFbiUKSRbmUIcr5fpP8mJc8kiIWHYInkDvRQc0ZekSFkPHTRsElZIVPJWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwhUi0rl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwhUi0rl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3632C1F000E9;
	Sun,  9 Aug 2026 13:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786283649;
	bh=pbRdhBYWfhrQKnoAuu3RE5LJCTGvnPn/akpuu9xgijY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FwhUi0rlW5FivSIwHrrdezHTDTRHhX7reHPhFY3YPkC1OSQ17AtzsAIGg0exGNudi
	 K8ofxbtejTlmGyqRs4k5IJBGc1G6u1ZFZurI7XA1fezx+yPxfYK7vwPtmAqjhdw/4s
	 MYYByBGrRgwQqmqonsWuN1vVgT3+eiJ74N0R49dzGE10tYvsxnWr6A8Ihg5lbqpwDU
	 lioQ5sFy9mIl4hsLgRXv7ZT/m1CLNto4XepYDYxJnRt+DfGQJIql1mrGwP/mbpgR2B
	 xQzxGzoW9jZ4Ow0rZiLgOQuXlH4/7HMK9bX3rIyj3VEauid2031+Ylru31MXP2VvYL
	 jUSCWm1TvK2OA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peiyang He <peiyang_he@smail.nju.edu.cn>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iommufd: Fix wrong hwpt passed to iommufd_auto_response_faults on replace
Date: Sun,  9 Aug 2026 09:54:07 -0400
Message-ID: <20260809135407.1505720-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080517-fiscally-lily-170a@gregkh>
References: <2026080517-fiscally-lily-170a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peiyang He <peiyang_he@smail.nju.edu.cn>

[ Upstream commit ba5c0f28a26e7d9be1e0997f8920dd638e2782fd ]

iommufd_hwpt_replace_device() calls:

	iommufd_auto_response_faults(hwpt, old_handle);

passing the *new* hwpt together with the handle of
the device's *old* domain. This should be a parameter mismatch:

1. Semantically, iommufd_auto_response_faults(x, handle) scans
   x->fault's deliver list and response xarray for groups matching
   "handle". A group is queued under the hwpt that was attached at
   fault-delivery time. old_handle is fetched *before* the domain switch,
   so its group lives on old->fault, not on the new hwpt->fault.

2. Historically, the first argument was "old". The routine was
   introduced by commit b7d8833677ba ("iommufd: Fault-capable hwpt
   attach/detach/replace") as __fault_domain_replace_dev() in
   fault.c, correctly calling iommufd_auto_response_faults(old, curr).
   Commit fb21b1568ada ("iommufd: Make attach_handle generic than
   fault specific") moved this into iommufd_hwpt_replace_device() in
   device.c and swapped it to "hwpt". This should be a refactor regression,
   not an intentional change.

Fix this by passing "old" instead.

Link: https://patch.msgid.link/r/9D652384339C69D5+20260710122952.885325-1-peiyang_he@smail.nju.edu.cn
Fixes: fb21b1568ada ("iommufd: Make attach_handle generic than fault specific")
Cc: stable@vger.kernel.org
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
index 74480ae6bfc0b..494976d13bf4d 100644
--- a/drivers/iommu/iommufd/device.c
+++ b/drivers/iommu/iommufd/device.c
@@ -453,7 +453,7 @@ static int iommufd_hwpt_replace_device(struct iommufd_device *idev,
 		goto out_disable_iopf;
 
 	if (old->fault) {
-		iommufd_auto_response_faults(hwpt, old_handle);
+		iommufd_auto_response_faults(old, old_handle);
 		if (!hwpt->fault)
 			iommufd_fault_iopf_disable(idev);
 	}
-- 
2.53.0

