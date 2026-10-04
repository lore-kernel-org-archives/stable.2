Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4C9476040
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 21:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791149050; cv=none; b=TjBT82SxIUYRys5ozssAFpgW6pcXNKZUhuxQTGIu8zlIyt4kh9VGx2BkSQslbCIguWZu4SlH05FC5SeGJa9ZM4HKuywvO+svfCw5IESEbwdlLyZEqoJlQ1XvrsqbwzqK0neywSObe6wnAEPa/Shkhq5aCm7tQPsDkfswWUXNGyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791149050; c=relaxed/simple;
	bh=81+67JwUaP4tF2NJFrH6GPZDTpfDl8PzuP97pVLfUGI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwBlTW/B7fJ4Cws0R4mH04YnGGcZta44ciTZTtgHQ2kPmgSlofyYmOLr78AhL/n/7zgHaFQkwgUY0Wefm+CAijCj420Kif8tIKCY/EU6bI7g/Vkmz3FGTSs8R+ABfA/OVYujxqRNPyHsyDrXUuAjUKlfM6UMd2soMZvnZ0TaRk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReqFQ1G3; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReqFQ1G3"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5351d76e1baso7024511cf.1
        for <stable@vger.kernel.org>; Sun, 04 Oct 2026 14:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791149048; x=1791753848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4FDDBOjHId45sAPhEMEOKQ193Q3Lv9uy6bGqIfQK4UI=;
        b=ReqFQ1G340eCPcoRTkmKmtONlVd3M9Zg2cqmFMOBRv725a51mtlrI5kDsJM9MYhJos
         2OCR8bhQcH4ciofVcek15fHvvQKZW04Jz3CuNMlbZpkTHG8B0jaou93+lEC8MMyLc1JE
         dND0mWmf4Qw6lnIrg2OrFfncUWrYCTOx2hZu4ND6P6Dqz0vz5rsOCPoTObghwUWmPY0k
         DtkGScHh4dZdPeunGVp6UoQUiERbD5k8uG0xMzsXorkjsEWpCt/8qREO4QEDelCnd9eu
         o/QjZAC+peyRubcrRle3XKTJ9WPYWhNL/ErWHy+/O4jN7o6iupg6V3iEtkGmsQJp+dLY
         y3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791149048; x=1791753848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4FDDBOjHId45sAPhEMEOKQ193Q3Lv9uy6bGqIfQK4UI=;
        b=y8nIr1o1TIEgwP7NKfzyf4DIXB0r4kW1VOoNVePs4lZNicEN9aeoOoPxnkUI/ZfFHU
         FK+Igw+40157mGeNjZzX6eDftmL+sXAEbXEXdiXmMiSXoExzhYxT3uYLsmJcMxcTy8dA
         S6p2ghMgFQZRqpkxg7WJrAb8ZRYBKZztojGzwG8kD9FTThvTnMiOHHsf9h3+ExV4P/qg
         CFk7HBR3g50WN32WQr8p0nQly3231lkO/FfdK9b1vkqGNsoFxB0A/8HEXMNIT1KmMu6z
         vc571FD6xaEPsaYA+VWgAedHiMXRfWMsc9WmRbgWKMVdapmP+PdBd32UC4JDZY/2XeiR
         jysw==
X-Forwarded-Encrypted: i=1; AKwUvBxjNc9k4mchdYbDhA9Lc7tLzSkMsHRbsuhhpBKPK7Q4BXPfM5Eq+toywk4POUvg1TjWUHdZr8Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lomnoIqeMu5TFTz0f1Bl0/Fw1hhcKGHFR4x6qVMhBlFoz5b9gP
	5ZIzCy87K4rh1Ae2CCQli68Z4j9Q0RYVsbPEZNcypMfZXwa8JfOO3KBm
X-Gm-Gg: AYBFou2JzkAPc9iqAK1zvr3tcC4A4X46b6jXkcNu5VQxvaOgHXbyz+T1BQd6Mo02TjS
	MlhbtzZMZZjpVJ9utc61DS3UZJhrV/oPh5ZizIOmv6IpEgzFU3teQ2UOh4csZJZGc3k3P/itxJv
	scZi7HeBfPK8Mp3ZTLH4+OW+SGAS7dmNtTSayGWqoXzM65hR4kFxxuWzCnz7LzAw+d9i2iBtynz
	YPbuuulmuD3oczI34H7wzJ1/H1x9NsWWfsS2ceT0qwIuwtQtWJ8khy3rdAXmeCL7cw0P+w/ULsn
	0sIsnDLhoa48eL7UytVgdTnGwxPsFcgzMgINSkiZHui/cyvHcLkJk+ozp2Gcpp1mWKghPJgUQ/A
	m/v0Mr4Uw/HrTShImzxGYlgcQUtQt9z2aGwc60Javk25yvFVoGVhNSSJ79peeVUvumoJhc0RBFY
	z6x77Z20PuHchjmXsmEOiVj2XcdnlKZ1MA5grWtGQbZVPqEp92v9PRFDsIMMfniIP6G91zpVJ/y
	XZuxsIPs9QZRHEH7bi68w==
X-Received: by 2002:a05:622a:653:b0:535:1924:d211 with SMTP id d75a77b69052e-5351924d301mr81314081cf.1.1791149047944;
        Sun, 04 Oct 2026 14:24:07 -0700 (PDT)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5339883034csm81689241cf.3.2026.10.04.14.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 14:24:07 -0700 (PDT)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Zhenyu Wang <zhenyuw.linux@gmail.com>,
	Zhi Wang <zhi.wang.linux@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Xiaolin Zhang <xiaolin.zhang@intel.com>,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v1] drm/i915/gvt: Don't replace a DMA mapping that is still in use
Date: Sun,  4 Oct 2026 17:22:39 -0400
Message-ID: <20261004212403.208681-1-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_gvt_dma_map_guest_page() unmaps and frees the cache entry of a
gfn when it is requested with a different size, and maps the page again.
The entry is still referenced: shadow GTT entries and dma-bufs keep
using its DMA address after the page is unpinned and the DMA mapping is
torn down. When the new mapping gets the same DMA address, their later
intel_gvt_dma_unmap_guest_page() calls also drop the references of the
new entry.

Keep the existing entry instead. A 2M mapping covers a 4K request for
its first page, so take a reference on it. If the entry is smaller than
the request, fail and let the caller split the 2M entry into 4K pages,
as it already does when a 2M mapping cannot be set up.

Fixes: 7366aeb77cd8 ("drm/i915/gvt: fix incorrect cache entry for guest page mapping")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
Compile-tested only (x86_64 defconfig + DRM_I915_GVT_KVMGT, W=1, sparse).

 drivers/gpu/drm/i915/gvt/kvmgt.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index ec62db5cc3675..9a3e305253469 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1626,19 +1626,15 @@ int intel_gvt_dma_map_guest_page(struct intel_vgpu *vgpu, unsigned long gfn,
 		ret = __gvt_cache_add(vgpu, gfn, *dma_addr, size);
 		if (ret)
 			goto err_unmap;
-	} else if (entry->size != size) {
-		/* the same gfn with different size: unmap and re-map */
-		gvt_dma_unmap_page(vgpu, gfn, entry->dma_addr, entry->size);
-		__gvt_cache_remove_entry(vgpu, entry);
-
-		ret = gvt_dma_map_page(vgpu, gfn, dma_addr, size);
-		if (ret)
-			goto err_unlock;
-
-		ret = __gvt_cache_add(vgpu, gfn, *dma_addr, size);
-		if (ret)
-			goto err_unmap;
+	} else if (entry->size < size) {
+		/*
+		 * The smaller mapping may still be in use, so don't replace
+		 * it. Fail and let the caller map the range in smaller pages.
+		 */
+		ret = -EBUSY;
+		goto err_unlock;
 	} else {
+		/* A mapping of the same or a larger size covers the request */
 		kref_get(&entry->ref);
 		*dma_addr = entry->dma_addr;
 	}

base-commit: 7704c4c5bb127673b4f0ead839919db573559e38
-- 
2.43.0

