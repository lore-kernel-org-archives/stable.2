Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EB539DBE0
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501233; cv=none; b=Rrz9MteJLBY73LsoLo4o5D2POMeV/uw9CvaUus+++GdCeh3SEJLc2NeEKJJehvmPGdkeUHl73x1Wvf6hCeEKyWtGrg2BpcpEh+/RAfqFW1ZhfQSpOCR9mzpONaNDjP2T3SMhsJ4f+5Q1+gyOS2A7mLwWoy752imjXkyL5QuiQnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501233; c=relaxed/simple;
	bh=ajg4Nsba04ee04fLh3WFBCK4NGYixkmq1qRWqM+yo2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVTucOGXt1MNNFk31SOVRa1BFfNNkQ/b4JxprJIJrP7dKZoK2YPA5gIU+wQ57aj9uE761MVdJgKLMvpI+qlhKjiOxQs+l0+BydN+PBLjkU15jJsHUMz/cZXwy5XPn7Isa3JeUPJ8/XtCDD8hIPJI7Opsu0wnZvWpNscS9is/JII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=ckyCH6Bl; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="ckyCH6Bl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1780501232;
	bh=hG1lWNbeUjBtC1lSP2ZjSpLTXw35ebgcjZMiyjrD1GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckyCH6BlsvCcKUl5sLJd6LRAqnWvLpCS+3RuX6yUreHZcSN1XUPS/gwV2M76ulTZt
	 o55R5GRxd+lmYEOGEHnuXPdJk5vnTMS2dMSOjibZQwQtCk6KY5YQLC8oD3TdHQEzso
	 ODAW+MuhWUt8lgyt6sFDstGIR3kJCcRzb1v3payY=
Received: from stargazer (unknown [IPv6:2408:824e:307:6541:546a:40ae:5851:c0ef])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id D0B8E65EBE;
	Wed,  3 Jun 2026 11:40:26 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	Roman Li <roman.li@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Rafal Ostrowski <rafal.ostrowski@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v7.0.y v2 6/8] drm/amd/display: Fix dc_is_fp_enabled name mismatch
Date: Wed,  3 Jun 2026 23:39:18 +0800
Message-ID: <20260603153920.249671-7-xry111@xry111.site>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603153920.249671-1-xry111@xry111.site>
References: <20260603153920.249671-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 57ce498faa1e4d358bf44b5df575874c22922786 ]

Fix incorrect function name in comment to match dc_is_fp_enabled.

This function checks if FPU is currently active by reading a counter.
The FPU helpers manage safe usage of FPU in the kernel by tracking when
it starts and stops, avoiding misuse or crashes.

Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC - Part 1")
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dillon Varone <dillon.varone@amd.com>
Cc: Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index 8ba9b4f56f87..172999cc84e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -59,7 +59,7 @@ inline void dc_assert_fp_enabled(void)
 }
 
 /**
- * dc_assert_fp_enabled - Check if FPU protection is enabled
+ * dc_is_fp_enabled - Check if FPU protection is enabled
  *
  * This function tells if the code is already under FPU protection or not. A
  * function that works as an API for a set of FPU operations can use this
-- 
2.54.0

