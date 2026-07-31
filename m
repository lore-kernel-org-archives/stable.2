Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E06E399019
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513020; cv=none; b=l9FHihqnm01JP/6XJqS4ioc7etqBQIZYvMlm+leExQxGlihdMxI1iboJOI/HRGFbALs1OeUXuYi+Zpgwn06/VqDCvBYrlJUxIG/ZetKmoMpfHoMF9iiSLG3Lv7UXhfO1BPhS8WKmOjEhSYMwCOhkf2HF6KZs5TyVsjf0FJTAqEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513020; c=relaxed/simple;
	bh=pKdOujhcXqU+//yl7c9Ki9edFSmVipMUP/iPmRowndE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A8+FdSclFvOYiKmRhVN7q1ktsXF8264fNmPoYCnmR4Yf0IjNiiYW9zIHUIWeflxFOAbtOy/GJpnGj2rRULN3IDPI+e6zjM1gUdJhHI5kq1rnfamb1ZcAS6Wbf8sX9nntHYVlflPTcYLJpSUs+ix5+ALQgwAv4imAzuzWuKdu8Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGN1VLZg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGN1VLZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0D71F000E9;
	Fri, 31 Jul 2026 15:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785513017;
	bh=vsLoc4SA1WQHwunv/YXiBsltCj0VSCB30mupSh5Aiw0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lGN1VLZgos345MK8LCE6n+ejBcI/sliiuw7kDjXCoYXCSsXdLUyJEyiod9rS1fAY0
	 sCp2P95OHrcXPt48uDbtWfoW97RbVaKUgZy7FFL1Lr9SQTLyfNLWZ3vMR4z5Hs+z7l
	 NcxjwZ0T6w1vRj5bmSi77ff0qgENwQjpHG8X2tddfujLoroVo5FrNkECVhA7Tjn29U
	 HLpCFpyqQnIfc4S6/FQeY7mWlTtglTK6mXHkSAvtQLH2gGlQUU2HbBmSLsIgL5ewBC
	 w/1iSs0YTLMHg1ol/oO5lhrKGpzeIR1wAZX6YVs2AA6rLxdMDM6df2SxpS+5cPSprj
	 dzUYopKrP5wiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] drm/xe/xe3p_lpg: flush shrinker bo cachelines manually
Date: Fri, 31 Jul 2026 11:50:13 -0400
Message-ID: <20260731155015.604147-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026051515-treble-unwieldy-f489@gregkh>
References: <2026051515-treble-unwieldy-f489@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tejas Upadhyay <tejas.upadhyay@intel.com>

[ Upstream commit 4e7ebff69aed345f65f590a17b3119c0cb5eadde ]

XA, new pat_index introduced post xe3p_lpg, is memory shared between the
CPU and GPU is treated differently from other GPU memory when the Media
engine is power-gated.

XA is *always* flushed, like at the end-of-submssion (and maybe other
places), just that internally as an optimisation hw doesn't need to make
that a full flush (which will also include XA) when Media is
off/powergated, since it doesn't need to worry about GT caches vs Media
coherency, and only CPU vs GPU coherency, so can make that flush a
targeted XA flush, since stuff tagged with XA now means it's shared with
the CPU. The main implication is that we now need to somehow flush non-XA
before freeing system memory pages, otherwise dirty cachelines could be
flushed after the free (like if Media suddenly turns on and does a full
flush)

V4: Add comments for L2 flush path
V3(Thomas/MattA/MattR): Restrict userptr with non-xa, then no need to
                        flush manually
V2(MattA): Expand commit description

Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patch.msgid.link/20260305121902.1892593-7-tejas.upadhyay@intel.com
Signed-off-by: Tejas Upadhyay <tejas.upadhyay@intel.com>
Stable-dep-of: 662f9ddc8077 ("drm/xe/uapi: Reject coh_none PAT index for CPU_ADDR_MIRROR")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_bo.c     |  7 ++++++-
 drivers/gpu/drm/xe/xe_device.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_device.h |  1 +
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 0dabe8535139..116e6ae61a83 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -643,7 +643,12 @@ static int xe_bo_trigger_rebind(struct xe_device *xe, struct xe_bo *bo,
 
 		if (!xe_vm_in_fault_mode(vm)) {
 			drm_gpuvm_bo_evict(vm_bo, true);
-			continue;
+			/*
+			 * L2 cache may not be flushed, so ensure that is done in
+			 * xe_vm_invalidate_vma() below
+			 */
+			if (!xe_device_is_l2_flush_optimized(xe))
+				continue;
 		}
 
 		if (!idle) {
diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
index 0d69cd0e4e79..ee2da75d6290 100644
--- a/drivers/gpu/drm/xe/xe_device.c
+++ b/drivers/gpu/drm/xe/xe_device.c
@@ -1052,6 +1052,29 @@ static void tdf_request_sync(struct xe_device *xe)
 	}
 }
 
+/**
+ * xe_device_is_l2_flush_optimized - if L2 flush is optimized by HW
+ * @xe: The device to check.
+ *
+ * Return: true if the HW device optimizing L2 flush, false otherwise.
+ */
+bool xe_device_is_l2_flush_optimized(struct xe_device *xe)
+{
+	/* XA is *always* flushed, like at the end-of-submssion (and maybe other
+	 * places), just that internally as an optimisation hw doesn't need to make
+	 * that a full flush (which will also include XA) when Media is
+	 * off/powergated, since it doesn't need to worry about GT caches vs Media
+	 * coherency, and only CPU vs GPU coherency, so can make that flush a
+	 * targeted XA flush, since stuff tagged with XA now means it's shared with
+	 * the CPU. The main implication is that we now need to somehow flush non-XA before
+	 * freeing system memory pages, otherwise dirty cachelines could be flushed after the free
+	 * (like if Media suddenly turns on and does a full flush)
+	 */
+	if (GRAPHICS_VER(xe) >= 35 && !IS_DGFX(xe))
+		return true;
+	return false;
+}
+
 void xe_device_l2_flush(struct xe_device *xe)
 {
 	struct xe_gt *gt;
diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
index 32cc6323b7f6..0cdab55a1890 100644
--- a/drivers/gpu/drm/xe/xe_device.h
+++ b/drivers/gpu/drm/xe/xe_device.h
@@ -179,6 +179,7 @@ void xe_device_snapshot_print(struct xe_device *xe, struct drm_printer *p);
 u64 xe_device_canonicalize_addr(struct xe_device *xe, u64 address);
 u64 xe_device_uncanonicalize_addr(struct xe_device *xe, u64 address);
 
+bool xe_device_is_l2_flush_optimized(struct xe_device *xe);
 void xe_device_td_flush(struct xe_device *xe);
 void xe_device_l2_flush(struct xe_device *xe);
 
-- 
2.53.0

