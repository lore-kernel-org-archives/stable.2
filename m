Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDB41F4631
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788829268; cv=none; b=ITSgAD2yxSWA/3PuUPidBopCSOp/KLfefIunc54NcWEF7/sgCRjEb6t2z2ZvrBIMIyRFB2I+VBagNJH0nBRVdqAMPuu8OoboCUpeHKJMMXz/X0/dUObAMiWh+/nprDkUAXF8UAsCZBl3qnz0pb7daPHfTEhqgsN+Nf5Oq0pvb4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788829268; c=relaxed/simple;
	bh=t6CwNAnxj68VGFTZfEbqQoNtConxWJwIC1+yWO3BKtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9sWqN1P1MrJIWrMxvsk5EWdQx9VLHkBWNATZLmkLfPCIuJyOPHBHGVFchtCyLhc9sjVITJtUq348w+aEsT/F6z/ub7d0jePb35X8GOuRx2xuy0lEJdHC+J+xLhbXlh9Hr80dRPAE9MQ0uHvgRgbL3ViougNNI0KTKSEdisWk9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cp17wM73; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cp17wM73"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED701F00A3A;
	Tue,  8 Sep 2026 01:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788829267;
	bh=aIp5s87D/aisFWvNuz3iGMZ+R/mIDqDSwZ8oLx8FTI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cp17wM73ID2hqYLyn/rEVCaOf8aDiU3s8jvhLJK4ijT2lfib8l9y0f+vezPEtqnG7
	 8wL7Xzb9v6k0CxG5OPL0r5zmvaT272WIgG/EjaqKeL6MzQFbiRcNWpcxXuwFsyyHrW
	 Mq/Z0UvqCSJ/AEF62PvndfbqodNW93ihMtX+ALMlXRVZZC+hjOvYm/2s+cl8U3pNwn
	 dD70myZEOGw3bhAvuFqAR9pOSIpz1amt6JYSSCFgCQLuzqoI8zXgvZG2hxI0gby37N
	 GQjuBfWfUnYbS5LDUMYrSMWnfBbsB4DAPbpEMnscdbOlBxC7bAMht2mH7GLHUbDkLt
	 WhgS9MSfCivEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>,
	Gao Xiang <xiang@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] erofs: skip sufficiently large global buffers when resizing
Date: Mon,  7 Sep 2026 21:01:03 -0400
Message-ID: <20260908010103.1665516-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090345-used-spearfish-a45c@gregkh>
References: <2026090345-used-spearfish-a45c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>

[ Upstream commit a7d097cf01301c5da37927c8f26123d006f0fd8a ]

z_erofs_gbuf_nrpages is advanced only after every global buffer has been
grown. If a resize fails after some buffers were enlarged, a retry
revisits those enlarged buffers.

Retrying the same size then returns -ENOMEM because alloc_pages_bulk()
has no pages to add and the unchanged return value is treated as a
failure. Retrying an intermediate size allocates a temporary pointer
array smaller than gbuf->nrpages and copies more existing pointers than
the array can hold.

Skip buffers that already satisfy the request. Once all remaining
buffers have caught up, advancing z_erofs_gbuf_nrpages again describes
the guaranteed minimum size across the pool.

Fixes: d6db47e571dc ("erofs: do not use pagepool in z_erofs_gbuf_growsize()")
Cc: stable@vger.kernel.org # 6.10+
Signed-off-by: Nikhil Gurudasani <nikhilgurudasani314@gmail.com>
Reviewed-by: Gao Xiang <xiang@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <xiang@kernel.org>
[ preserved the existing kcalloc() allocation instead of upstream kzalloc_objs() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zutil.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 55ff2ab5128e0..54ce492e897f3 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -79,6 +79,8 @@ int z_erofs_gbuf_growsize(unsigned int nrpages)
 
 	for (i = 0; i < z_erofs_gbuf_count; ++i) {
 		gbuf = &z_erofs_gbufpool[i];
+		if (gbuf->nrpages >= nrpages)
+			continue;
 		tmp_pages = kcalloc(nrpages, sizeof(*tmp_pages), GFP_KERNEL);
 		if (!tmp_pages)
 			goto out;
-- 
2.53.0

