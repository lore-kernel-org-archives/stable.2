Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5FE48821D
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352157; cv=none; b=gv3BG+JiuQW7tdNSP0vkWRpPLcrjMaxkngq9mMbap7xaOlwLdR4DiH7H65Nebpq9bD8w1L2wcRGQGgxwevMPMP4eDpcYua/4Y9EgcYDkYXB5FvnyL7aF7QGBf/OHy4liPKjrhidLBv3zS+oMtZWUxlrda1J+bFdoSHOL9Qu3ql4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352157; c=relaxed/simple;
	bh=p/V1AbwpqTcbOr6E67iKq4k/gI8GHbt2e0Eoz+/coFc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J2LbYfaW5Kuuum/b3CBf9UupF8nexdg2UB23vR7/OkDgC7u/VozLjvDANCc04O5J6D28L9erVtTV1VaIoXdfUDQc5tMk+bobT+9+nl7ZPYDZRriVxxLj+h7tNFJAtWqTsXsZl++/jV+Y/agOxAolFW7dH2R2rFvoUWEnrsE9eZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHjdmXSX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHjdmXSX"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8556ec44e9aso979080b3a.3
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 05:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788352155; x=1788956955; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JjSLQKBgLLYQIi/C+rXjtu2+hrtewX0LNh0mFPYrFIw=;
        b=NHjdmXSXm9Oke57TvNwppsKNWtju5s1A87NlZl8W9XxVGiIKjo/sHu0K7kKQEXvrkT
         XpGI78RTQ2keK0gfJtQMitBOVijOvkBiMSwCeMXFoSRIVuMdTQg0Qfde7XkDqBnxQLdb
         Ojnsp+jlAyLZlySf25iCm7055ME5oI+ZUhg6qXTy27sm3RDDg0XPrx/UPRjNYLnEj0oD
         tGFFzxN+OfqIFOt2oVLlgtKMg1oe2SDC4E0IYq1XkK5SxmbJzB17jcUJRFUOYEC9EVim
         8HIFkhFNEc3HJpsUiyLi1BitT5vLnsnfGALdW+xF1HUdrPyENkoYHvmMAog/Mr0OsjmX
         QA3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788352155; x=1788956955;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JjSLQKBgLLYQIi/C+rXjtu2+hrtewX0LNh0mFPYrFIw=;
        b=Xk4QdSKWDiMOAnHyUN13VJzxXUwHLk1EHdS461O/0gTsW+b/OX5l8KZCl02l2R+v44
         5nRxNnCgzAMS3eFAgNsnVhD99cWz5VzqX1u9IPNIEIfNfhBpDsIwEtr39rOJMsKNUZwE
         3rU/wIQvHTv7y9yCYrHGm+5NtPoYeLqlTkoE987rEumYrATivrsER3AZwDBj3Fvj0hQD
         y/fGQmNrcM8jnUFKad/EOYKSAvchtN1B5jskgCIB9DGL7jAHlyi5xGFhxcr7TaYUP0x8
         MjUiHT+OQiIjSUvH36frf9QuQyi3tkAagYdnqQG273JydaKlX5xhZoB6+h0V5qvepZ26
         X9gA==
X-Forwarded-Encrypted: i=1; AHgh+Rq2r2RsAUFLA+MwMEd0l44TM+2nXV2egRtMooDSnIcUjWDTMyOvjDceh3VyuHTVR5ZbWdKKHCA=@vger.kernel.org
X-Gm-Message-State: AFuF++nJqT6xM73zzSOnLV87UBQ+lPcLn/bd+Kxak3wl4lgPor1oNiWA
	OOrlLYA9FvACdGXzAPf32w8TYEojRpyeEChtxg0LewJ/rwNWotOv6F5S
X-Gm-Gg: AR+sD11Qk5BX1ITPIfVauSCy7FKYUFLvbS2i7q2n/QYc40QpiftDDugRmtojHyuiYCO
	cmYVqrIRVsXh/ZRHm7WBwS90fWrkFXq2nB4I1PCmhI7RcbdjB9LM1D/KI+fz32RcTg05rTp8iOS
	3S5u6In8kegjHoQxdyUYiW41EGa7Eu6XzYpLlEuLhFOFQoFsTJp7ep9LZ2vcWptmiCFbxetLSHj
	2Tb7F1nxLjE31W3oYd8fd8xyoyIyCoJbhOsPpuSYcTh+hPclfkucQMhw4gU4jYqIzo/1M588kjp
	vpBB0vG6L/eFg/Jy10d2JpmrJ0Df/FAu2+BfJ9n6HJ2vOVn2GRLpkaHlt6k4fIUPHeeypJzyG2V
	kOCGxLpaOVcIWMVnj8GnTUKVX5/QffkfzI1u7OHuvH+RsKG3Kyo34jxBUa1s7Tk9dm6lkwaD7M3
	sYd651+fjBcBNafCFD33TMnqGTpFhX1qvmEzkJANl9h7lm+RtKTyw7w63L7kg=
X-Received: by 2002:a05:6a20:431a:b0:3d3:adad:f172 with SMTP id adf61e73a8af0-3d9af0f8f96mr6795606637.20.1788352155062;
        Wed, 02 Sep 2026 05:29:15 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.37])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc34d03b5a8sm944767a12.26.2026.09.02.05.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:29:14 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Wed, 02 Sep 2026 20:28:43 +0800
Subject: [PATCH v2 2/2] drm/gpuvm: reject zero-length range in
 drm_gpuvm_range_valid()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-drm-gpuvm-zerorange-v2-v2-2-da63269c6ec4@gmail.com>
References: <20260902-drm-gpuvm-zerorange-v2-v2-0-da63269c6ec4@gmail.com>
In-Reply-To: <20260902-drm-gpuvm-zerorange-v2-v2-0-da63269c6ec4@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>, 
 Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org, 
 Dave Airlie <airlied@redhat.com>, Zhenhao Wan <whi4ed0g@gmail.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788352136; l=2951;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=p/V1AbwpqTcbOr6E67iKq4k/gI8GHbt2e0Eoz+/coFc=;
 b=vi/JETsoNsWUA5ztPyQT1Va9wqQSTg+1zn+8ro4xEvkjuHiIGNbMmkkJEMzOsbmzvS0Z+Teb0
 HFMW+KuWNOCDhgCUIsdE5zmQkvsguAOi6mEepd4sNaEPzysYjOdu4At
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

drm_gpuvm_range_valid() is the common gate every GPUVM map/unmap path
funnels through: drm_gpuva_insert(), __drm_gpuvm_sm_map() and
__drm_gpuvm_sm_unmap() all reject a request unless it passes. It checks
for overflow, the managed-range bounds and kernel-node overlap, but it
never rejects a zero-length range. A range of 0 is page-aligned and
addr + 0 does not overflow, so a zero-length VM_BIND request from
userspace passes validation.

The GPUVA interval tree derives a node's last key as addr + range - 1
(GPUVA_LAST()). With range == 0 this underflows to addr - 1, producing
an interval whose end lies below its start (and, for addr == 0, wraps to
U64_MAX). __drm_gpuva_insert() then issues its overlap query with that
inverted interval, so the -EEXIST guard matches nothing and a malformed
zero-length node is inserted, corrupting the augmented interval tree's
subtree-last invariant and misleading the overlap checks of later
map/unmap operations on the same VM.

Because the shared helper's own kerneldoc promises to validate "the
range" yet silently accepts range == 0, drivers have papered over this
individually and inconsistently: imagination and xe reject a zero range
at/near the ioctl boundary, while nouveau and msm do not. Fix it once at
the common gate so every current and future caller is covered.

The only in-tree user that legitimately accepts a zero range,
xe's DRM_XE_VM_BIND_OP_UNMAP_ALL, interprets it at its ioctl layer and
never passes range == 0 into the GPUVM core, so it is unaffected. The
in-core lookups drm_gpuva_find_prev()/drm_gpuva_find_next() pass
range == 1 and are likewise unaffected.

Fixes: e6303f323b1a ("drm: manager to keep track of GPUs VA mappings")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/drm_gpuvm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpuvm.c b/drivers/gpu/drm/drm_gpuvm.c
index c422c5af1f4b..b73ad6988171 100644
--- a/drivers/gpu/drm/drm_gpuvm.c
+++ b/drivers/gpu/drm/drm_gpuvm.c
@@ -1021,7 +1021,8 @@ drm_gpuvm_in_kernel_node(struct drm_gpuvm *gpuvm, u64 addr, u64 range)
  * @addr: the base address
  * @range: the range starting from the base address
  *
- * Checks whether the range is within the GPUVM's managed boundaries.
+ * Checks whether the range is non-zero and within the GPUVM's managed
+ * boundaries.
  *
  * Returns: true for a valid range, false otherwise
  */
@@ -1029,7 +1030,8 @@ bool
 drm_gpuvm_range_valid(struct drm_gpuvm *gpuvm,
 		      u64 addr, u64 range)
 {
-	return !drm_gpuvm_check_overflow(addr, range) &&
+	return range != 0 &&
+	       !drm_gpuvm_check_overflow(addr, range) &&
 	       drm_gpuvm_in_mm_range(gpuvm, addr, range) &&
 	       !drm_gpuvm_in_kernel_node(gpuvm, addr, range);
 }

-- 
2.34.1

