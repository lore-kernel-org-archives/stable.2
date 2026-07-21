Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344A33ACA5D
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784653974; cv=none; b=neii+OJVFpEZJdyCEMHCP3a1+LqAAp6ZjIrKdED4lI+6K+rZjhezQV3HHuwr69W64XKCDooUDqC9wEW4cDs7mGKifATn8Wx5NHXEB18w0rc4mdekQqoHA649PixwRjMNfLWPJPM12Tw3aYGJBhPfnLkTtG4Qtwe8sHj7wylKz08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784653974; c=relaxed/simple;
	bh=q9loNUDxcWZI1oUmEy7pb5foQQLOwAPHX/FEtOGX6Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIuCbOVyiGg7iI9K0bX1TTbOV9s6OnlHvjWYGyp7AuMsbAAbABIKxdrckb0Cj4O8/a4qThLT8gIuC2hcFWQ7EMuFdwUpwKpBlDuBQ3XpXu2klsUpiE/UsiiExOiIxWvq8KWHsy2HwBj4q09+JzQGceFBihVQeG2+Q2ChmwUStLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bk4MuhW2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bk4MuhW2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DAD1F000E9;
	Tue, 21 Jul 2026 17:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784653973;
	bh=O5rA5V/Nf4o0sX+fbziaVhxucuZ5cEr/z3l4cBh0jVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bk4MuhW2OlAo969WVXZhTJaijksXGa2Gq5rW70RzZodhNEx34rBFGr9vQ2T0VjaRq
	 jnp8egieRqQDAUMrYY73Jt+Kmu8DfM0NDiyA5Ddu0nU+SD0qysW9s/Fujz48ky8JJJ
	 /WHDSFg8/qqV31S8s+tAKj/AREIc1M/pF1wEGJZzB5G+NYa1Mp6PXFt1E6iki9rrEy
	 78YVgmYp+tFIw7qGt+73gdcev0DsO4iSV0Uk2vX8wgMReOYhR3TyMtf3sWqC6SNexP
	 keZ4GCwHfcsDQJgMbsG21wf0Pb+96jGbKTenZWrqJCRKj/OOe6xyJDdiPiENyMdmX8
	 NbPBfmBZH3rSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iommufd: Reject invalid read count in iommufd_fault_fops_read()
Date: Tue, 21 Jul 2026 13:12:50 -0400
Message-ID: <20260721171250.107567-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071602-java-pointing-40af@gregkh>
References: <2026071602-java-pointing-40af@gregkh>
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

