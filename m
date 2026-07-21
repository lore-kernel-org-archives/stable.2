Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F089A46D2B9
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784654037; cv=none; b=MSQaUzmw0ITRY/W8QLqh5w7MKVokv7SvQ6pFKFdNPIH/prDnxB7GOSXWHtOF0L9u2zAXRqJR5upfL98RrsJLimGPDnnvh32I4+rhj1ouXOCB0v9W6FAF/a79UHPwAIMjrz1cWHycBtPINq1rj9JWimrROkdjp40gVjvIwuLpW3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784654037; c=relaxed/simple;
	bh=/LVutYw7OZVzvpXOMS82SzBIgA831AlAuQnj3jEml74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHAKq0Zll8LD4pzH2yZtf5aqBQCUgv/ZRHXjFrtp1w5DASd3pO827hjoqkivZ59ayogS7wzXM4W91Exh/P8W9xAaUQv/Q5DwcBa/yvXmUxPyW6fuHpDOHxpOg0LtnmM+RX/3Ii2CIiSSTyIqPJyw2cLOxCFWWmz7atPViMw+OMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+0NmKMv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+0NmKMv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F3E1F000E9;
	Tue, 21 Jul 2026 17:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784654035;
	bh=un6NB/ztRrc9En4iItIouTNBY6LWlhMcXy4di5Xyx+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i+0NmKMvdjitjQj0puK0VhGF8oKKFNHvpcVvr+/ILjqbQWiiI4gKpFyyvU/BgfOIP
	 sE26nqJ/ut3xwhFvkSm0zN+4lRfg9XNlDC9rCURv/lNFRqu01RVzFsdZRmM0IxCZFm
	 SsImb7ZxLyPHJ+YK+rbV/HLceXYH/QGUuHaOx5yCQSKbUjJrMXtQhE6p0CqFVks6gI
	 vnO7LNP3bu/biu0FFOkaj65SV9DopjSrfs6XHLkhGSJ5ZuVhgsrQhRujC7h+znhqQ6
	 sF1AkMLGYIC0EcjPzFz4R0+6HFlkFR2c0hISgSpclbOI3k+bKhtje1EITc0s6ubech
	 sJHZE21UKE9IQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] iommufd: Reject invalid read count in iommufd_fault_fops_read()
Date: Tue, 21 Jul 2026 13:13:51 -0400
Message-ID: <20260721171353.111431-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071619-canning-snowdrop-2a4d@gregkh>
References: <2026071619-canning-snowdrop-2a4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nicolin Chen <nicolinc@nvidia.com>

[ Upstream commit 47916a54eeb2a9e654512ee609f71bd5b29db702 ]

The read count must be large enough to hold one fault or a group's faults.

iommufd_fault_fops_read() does not validate the count, but returns 0 as if
the read had succeeded while leaving the pending fault in the queue.

Return -EINVAL in the undersize cases.

Fixes: 07838f7fd529 ("iommufd: Add iommufd fault object")
Link: https://patch.msgid.link/r/85c118a606fbedc5c132a1f5ec223a5ba23b92d2.1780343944.git.nicolinc@nvidia.com
Cc: stable@vger.kernel.org
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
[ sashal: applied to fault.c as 6.12 lacks the eventq.c split ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/iommufd/fault.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/iommufd/fault.c b/drivers/iommu/iommufd/fault.c
index 8226e28d79a510..6048d8a1c8380e 100644
--- a/drivers/iommu/iommufd/fault.c
+++ b/drivers/iommu/iommufd/fault.c
@@ -273,6 +273,9 @@ static ssize_t iommufd_fault_fops_read(struct file *filep, char __user *buf,
 		if (done >= count ||
 		    group->fault_count * fault_size > count - done) {
 			iommufd_fault_deliver_restore(fault, group);
+			/* Read count doesn't fit the first fault group */
+			if (done == 0)
+				rc = -EINVAL;
 			break;
 		}
 
-- 
2.53.0

