Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564AD3161A1
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786617370; cv=none; b=cPEB+b7KX5zz8QWs0KfRprMgL0f5fLsYNdQiMFRe9qR09lJpMjfcLw4x7YOS6SLh9sGZBlH7qfUZtSz3q+R+jmx1Ney6NTQkJ8phKRvH5M/d7S/E1QDy38D/KgmAW8joguNKFVWXwkxuO69BQ7WGtrvBNt+rclFUlpr41BSVSkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786617370; c=relaxed/simple;
	bh=meyb6Y2dzI5h7FZCiO0Odzp0AHqH1igJ4/zqrayN1Nc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bAhSGQvUp+7eBD2CVJhYe1t1AsS7BqBMi223nwHL34whpXpWCL4L60iP8ZJMuHcdpyzaK6Ol8tAV5q9a0Q1YqHdbD0m7ovabdndSO2cPOTqcy3q3K5T/daNx6v2rHeadVJrriF1M/nXD4DEpSFIVprH5I6rQhL0ZGkbB8K3kA2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fwdiP6mT; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwdiP6mT"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1856356a91.3
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 03:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786617363; x=1787222163; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z3AY/Bs9FDrd8H3tGAAndoQ/dkrF/oypF8YiYah5nNY=;
        b=fwdiP6mTFJwXtCcN7Ewc2KSVfzubuJ+E0cwKHiaa8aeRYBx8fQOKcLT58u1LoqsxV4
         79obt/LD7IzfHST6sUi9FJUuo93u80ZkIDYk5cdPnnHUI7qXD1rB0wkflfhn8yvk7QcV
         rMruIeKNq00Ae7pRfyH52Sw5Z41fED7gz+aDV8dbFv4BmMS97h2LDlfFMkE9G/rj/nVZ
         yB+qEhtm/5DtBei+jywtfhFce6ilNKn+tztsF3N4QePbZYAtlrl5NIn4JVj8Li2eIGlW
         K/PE7jVKMNxZ91hF151C3UTLrCkg3dq3PNuGyk2KbP/q+4jaNeY4QdH/pR6pCgZ2X089
         X09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786617363; x=1787222163;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Z3AY/Bs9FDrd8H3tGAAndoQ/dkrF/oypF8YiYah5nNY=;
        b=jBY8HXh8+0kHY+UFXQeLT2cYIoIQsU3tIyWyw9SIGnG0BZS7pZDKQaS+Vwuvmp7ppD
         KTj6MLsiFUBo0y5TvxUZcwjMXr6E+i5rWeTUxZV8Z5u4OTehPP0pDyZC8SNf1e9YUtIF
         zFxMnmUOgh5v3wCAogMYX8tPjOTrad8JgewBQ1o9QqTBi/u8xmjecHZ7rtMG3rJ42E+1
         kwCxygTY26Wqh3r8kDzA8Fd55Aiy+A2jCRLt4G6vzjcRCGR6yGw9J4DMw6Ug3Ac683w2
         EeZlPe7pJUNn2oe3j5hxdtLctbQLJGA4txZ3jS0NhBgvGrjiFiNWL8j+r3Ega1SYMLtS
         SIpw==
X-Forwarded-Encrypted: i=1; AHgh+RqkkgbjGtpH6SzfczGp1+3fInitbty1uAIhjiR0oemFIZithQ+tixyzB6v/D6LKZEmpnokBoOU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw70YudYaD1DzYS66qLsZ01rhlXQluh2//G4sF7mS2/6eBeUaE0
	ON1jcK3rdD0NRZtW7quj2kwH/X2vBLuVxUBqXFdV3GZLcgzMDr99GDHE
X-Gm-Gg: AR+sD11b1fn/BRekHLEWWXsum43b4CsFHwP3rpMFRvmPPneMBBgx3HBFrtdxaYoGVAP
	KCZ/b/e9ITVqnknG4AiyKKvANipqNUsTiVDOxLS36t4+ln9sItZlEooGrcwUS5jx4eln1WexJWN
	Hoh2/XTbD8MAGrPhfD7gz9zvjszqILOSiOmsIR3UdhQpylQ8eLi4DcfnreO7GBFPDpWxxfyU1A7
	SPtfW2k2yjcEVkY6aCQBkgobnZn2/dX8I6bW2FKVuqS3pKOTxRnI3IcGYt2UFElB7tF/kkpPZHC
	04/hdBXoQIZLs4WINAUF917fPQQyYKs6+d1+hA8z0xrxfmtoAzmoC0urNkhxGCyPN2JTvzNhSeg
	d07jH82Q6V+cQzY8KD5qpIBYJSsZNIhAjmLHcDE3wzT3l8OWppzvwEeRn5U0XxzEjuHgZmeKsEs
	HHSw1+YroZqZDdpnlewZv5QcT5eB2HXaAJs6otf/xGT9weEFZTPdDaHHAo0dI=
X-Received: by 2002:a17:90b:278e:b0:381:25ce:bcc2 with SMTP id 98e67ed59e1d1-3931e0242f8mr6100351a91.6.1786617363370;
        Thu, 13 Aug 2026 03:36:03 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931f41ce3fsm2381426a91.10.2026.08.13.03.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 03:36:02 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Thu, 13 Aug 2026 18:35:47 +0800
Subject: [PATCH] drm/nouveau/nv04: check cursor buffer object size before
 upload
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-nouveau-nv04-cursor-oob-v1-1-3f3eb37d213d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAKefWoC/yXMTQoCMQxA4asMWRtIOzKIVxEX/YkaF400tgwMc
 3erLr/FexsYV2GD87RB5S4mWgbcYYL0COXOKHkYPPmFTm7Goq1zaFg6HTG1alpRNWLIPi5ELvO
 cYdSvyjdZf+fL9W9r8cnp/d3Bvn8AMrGehnsAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786617357; l=1859;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=meyb6Y2dzI5h7FZCiO0Odzp0AHqH1igJ4/zqrayN1Nc=;
 b=RNFf4wcl5LftIPZXfs3V3e6M/RvnsKRYFDr2Klg/361+meLcH5wFsHmX27P4vcahMHwYigsCm
 x9MU0ukgwrABPcno3tUpRryRAvmlcH+Rkiw0czCAWwMQsBzK44PWa6V
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
gma_crtc_cursor_set() does. The check precedes nouveau_bo_map(), so the
error path only drops the GEM reference via the existing 'out:' label.

Fixes: 6ee738610f41 ("drm/nouveau: Add DRM driver for NVIDIA GPUs")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv04/crtc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/crtc.c b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
index 500fd77b87d1..0393025baa64 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/crtc.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/crtc.c
@@ -1000,6 +1000,11 @@ nv04_crtc_cursor_set(struct drm_crtc *crtc, struct drm_file *file_priv,
 		return -ENOENT;
 	cursor = nouveau_gem_object(gem);
 
+	if (gem->size < width * height * 4) {
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

