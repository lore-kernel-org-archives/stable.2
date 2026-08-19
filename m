Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0583433BC5
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 09:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131067; cv=none; b=cpU70hyWtOWb0cH6RQEUtvJkwnTk1Wew3grHqdIaBI08NMsRFFjECzwdTNmqxemYzcVd5OCsdikJTdWg3aZczum7wpZ1/fbOvb2Fd8x9KaIaGd3Ifv43PCm5gmjSAN0UtSRbIjOEikJ9Ln7HeWJb5wHWmnw6+z15hBruth7N1xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131067; c=relaxed/simple;
	bh=yKd0NOqvnUZEXHXx+SmVyZErpDxsdELkJs/BqkIVgrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uVia7eZGcOkKNMOUlJBeytxafM0F/Hfh3ok27+WgnZe4KcLf4qqabHZzwdk86aS7pz5wti2uaFxRX+olE4hPBH2MG+2UvpjOINHiLvCN/hsFmm9kRQ4hX5RmlSIYHu0P52M/9CayuPLCvtkfbw41mP4gPP6PQEn6Q/RgI71mCyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+gB9ZnF; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+gB9ZnF"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1242379a91.0
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787131054; x=1787735854; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HgKYKxxGawS+Y3KPMd3fgnzXO0x1m/t52oc7d3V1CPs=;
        b=L+gB9ZnFoXS0/HCnNFT17L0WiEnrwIAi8khyS7y9WUSNAeEy984NjxfoA5SMjZGE6+
         6W6f2Xz75ZQYtIvplI5aG9/+gt4WqgJr7KDT/ffIJ4YSSGTh3PkP3drvYecrYZABq/Yh
         5pP2j6Cu/gXiTXuT9PfzGFPR9ytSCbs6UnhriUgaJucjT6du7OoffFLqUk5WFgKhE1XW
         nCAHq1W7Df/9GsZOgSvZyiiYi2kfRmrKRTV5bBqnabVhVI3IdwkVasW6Hv2rJW6EcC0u
         3il21KtVyycnVXIHKYikx6f9ohBdzBrlPS9UtUX4mhz++hPAO+gEPu1X+a3VRHMJ0Glq
         Ob3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787131054; x=1787735854;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=HgKYKxxGawS+Y3KPMd3fgnzXO0x1m/t52oc7d3V1CPs=;
        b=sGOYgnY4W+/UnfA8IByTNlk+eYMu3C0Z3sP5fjQZEJk7NR9jhBzytSFVCTAsris+/a
         4MQPJjcj5z+n+XLukGoCNp/RL+Z7Q3uiw1b5k9tSQxLOpR1dZK3emhc+nQAzPbjJ1TmV
         xfXqVHBgS3VI+BXRrtDqxrFFQANsA2GnQOwndaS/sfWU14aVQlcD22jjVv8B/mgnjxYA
         kEjZCXW135NAuD8QubHzZWZ1a20Jbx5FVjSfwHNhLW8Mcv3i8OyOr1E0mwyXWfVfsPxC
         0wCzG31Vyarc198gshkAcPqardAYnTcJHKpDmQTl3R8m8QwlQtOwWbKQJ6icaFtqyAxF
         AGTw==
X-Forwarded-Encrypted: i=1; AHgh+RqTP1PSwciQZs1LSvn+SDiei5GXgGIcbut7ap2h75Iq0UaMjty9L6k1n50GUOuQHd2CcXjAAzg=@vger.kernel.org
X-Gm-Message-State: AFuF++nGzU3jfIevTDFAcSSfeRrqnBXj+yyndv9dBWFGdt/oNpctSbeH
	EIkkpa3Bs9yWZFXFBHdF4kdhaEC1zF63MwyHrIM1/7VIFMM/aaCB3Clf
X-Gm-Gg: AR+sD11Zn6yBBd2KtxPV1ws+oqZkvHul3jIQguneSVeeNUIEVw0u8X1JRGzcU9/jArL
	1d3iSyEi7dx0OKW0XVgsKzI4/0EXVOnQ/IeBpoI7P0yYCi2dQ0jAaYeBAZLqVi3j6d6iwCuVg7b
	xNzNCyqHa0MbuocXCFEl4He5Axhu7aHiedemuj9Iymf0XxUvSMvYUUbrbw4sLJLh/HUc1dhfviq
	5nceSlzwNzDBtbWhLQEI9ykUH8/GKVcpPeWflyTUQC8SWDc7vM9eqvSK8Om27iFYMVE1tCFC3jM
	ciUlCPPu3VemdeikvbXxXkPHhf1yRBB56e0Y9BZh1J9LkdwG9fXPA3Nu2mHy+XNU3C7FNOHowRc
	1v0TCE/oEuKM35ZAeGvTqqpAULwbaYzitB/ya60Vc34nShAqAzd4r/P+nXB2oeT2GMgYgD3EPfV
	bXND/QpCNZG7bkFD5q+r++hLSxRalv/890b8m+B5dNG2IrgaDtHKtGZCr7C5n+1134nU2vpA==
X-Received: by 2002:a17:90b:4e8f:b0:392:ca3b:370a with SMTP id 98e67ed59e1d1-39580a50d67mr6579598a91.2.1787131054307;
        Wed, 19 Aug 2026 02:17:34 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.101.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb30541sm1875737a91.13.2026.08.19.02.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 02:17:33 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Wed, 19 Aug 2026 17:17:01 +0800
Subject: [PATCH v2] drm/nouveau/nv04: check cursor buffer object size
 before upload
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-nouveau-nv04-cursor-oob-v2-1-63eb8d0c847f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIx0hWoC/4WNSw6CMBRFt0I69pl+DBpH7sMw6OcBz0hrWtpoS
 Pcu4AIcnuTccxeWMBImdm0WFrFQouBXkIeG2VH7AYHcykxy2fKLUOBDLqgz+MJPYHNMIUIIBrS
 TpuVcOFSOretXxJ7ee/ne/Thl80A7b7nNGCnNIX726yI27/9LESBA9QqNOjsplLsNk6bn0YaJd
 bXWL7GoJb3QAAAA
X-Change-ID: 20260813-nouveau-nv04-cursor-oob-ad2b6001de3d
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787131049; l=2269;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=yKd0NOqvnUZEXHXx+SmVyZErpDxsdELkJs/BqkIVgrQ=;
 b=3C4upJJdGASxXPTYB5K57J6xhcml4PoXkh2TeciUednabbD7qnhs5S1jUJs0UdydjzTeemBIR
 b9h0HYcOlVFCXGw7fZOCKq5rljXg9qF9dLGLhCHUbCGf4C2W8UCaqMt
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

nv04_crtc_cursor_set() validates only the 64x64 cursor geometry, not the
size of the backing GEM object, before nv11_cursor_upload() /
nv04_cursor_upload() read up to 64 * 64 * 4 = 16384 bytes from it via
nouveau_bo_rd32() at hardware-fixed offsets.

nv04 uses a legacy cursor_set callback with a NULL cursor plane, so
drm_mode_cursor_common() passes the raw handle to the driver without
building a drm_framebuffer; the framebuffer path's size check never runs.

A client with DRM master can thus supply an undersized GEM object and
trigger an out-of-bounds read, as nouveau_bo_map() only kmaps
PFN_UP(size) pages.

Reject undersized buffers before mapping, as gma500's
gma_crtc_cursor_set() does. The bound is computed with array3_size() so
the width * height * 4 product saturates to SIZE_MAX instead of
overflowing. The check precedes nouveau_bo_map(), so the error path only
drops the GEM reference via the existing 'out:' label.

Fixes: 6ee738610f41 ("drm/nouveau: Add DRM driver for NVIDIA GPUs")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Suggested-by: Lyude Paul <lyude@redhat.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
Changes in v2:
- Compute the size bound with array3_size() so the width * height * 4 product cannot overflow (Lyude Paul).
- Link to v1: https://patch.msgid.link/20260813-nouveau-nv04-cursor-oob-v1-1-3f3eb37d213d@gmail.com
---
 drivers/gpu/drm/nouveau/dispnv04/crtc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index 500fd77b87d1..07251cf83df9 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -1000,6 +1000,11 @@ nv04_crtc_cursor_set(struct drm_crtc *crtc, struct drm_file *file_priv,
 		return -ENOENT;
 	cursor = nouveau_gem_object(gem);
 
+	if (gem->size < array3_size(width, height, 4)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	ret = nouveau_bo_map(cursor);
 	if (ret)
 		goto out;

---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260813-nouveau-nv04-cursor-oob-ad2b6001de3d

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

