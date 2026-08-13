Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B526447CA94
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 13:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626862; cv=none; b=Ep9HUNEgF4LhVR3wV0dI2+4PxCZhSkRFF/T5QHuFRUIrtmGxXrQzQWZ5nCB2xKq6FLslODwYe+JyHe/BKmmJ4I3DNJColUQhqhUyPYMo1L6yJyonawN/Hm48u++ngz0xcGDhdn9bdQSHr9rMeEO9DVxwsZERrE5p8tx9WjNK9DA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626862; c=relaxed/simple;
	bh=f/7hmALYx1pUavsqR9dX4xDKx4SJ9Gehp6aIWoZk6lE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EFKbbZNXSQf9Kbt0QOiPzqtT7sm2dZoscyBUSsW0jBFtcW9FGduA81Xc4qI9hg5j10K1d1ga/9FTawBl6JuyboKa7MupqhHqV5RSrNhB04XrJ56HmTFGoY3RO0micDb8/rpSVxZ8p9ZHtesJbVgeRfUijkJf+qDokBr/IonW1Bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwzLHAXA; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwzLHAXA"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8485ef63b68so2569808b3a.1
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 06:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786626861; x=1787231661; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lMjx6F1TSzytJZWqY2HUhhf0vDBC3SrSTqRCJ5oQEAA=;
        b=WwzLHAXAr6YmM8AXF6Mt2kEGyyUFwR/TKLPO49cVUPGiqUgY30qy0pJ+lwh7sV31cj
         vjTQkEMkkGX86TYLqAMvFyq4S0x29uh3Ffa++PXfE/HzJLSq/ooQ1drzVmLw/Q1QMGgY
         g6PUIatO7rVVM+gUpAn2B0bpN+lfkPd+QEHCdtPWzfXLdVqdKkUx/rf9CdgNFS8KqGiM
         e7ZT1s+5/TIr1k3PDFrXJyHriHRAovIrjZrg4Mifp8SDY7wBHqrB17uIGmFgK+dkOLWg
         /2fNu5q7Nlt712g808AVsHs/kbCyz5tDP34Lj+L6HOCCovCcNl0gak8Rqt92pYDbtBIN
         1+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786626861; x=1787231661;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lMjx6F1TSzytJZWqY2HUhhf0vDBC3SrSTqRCJ5oQEAA=;
        b=sT+bP9+JYZaXKZFroOdTBBbh2/AWMITD2QxKKAzMxSvucpZdZzCC1Y+fBWK2arz8HI
         rkalR7W5wL2VFjJ66oa1lF2p4bkz+vTrIVbOCFVgCz/6QflNLbV9MQRYJ5u2LD5iY9mq
         CYNraNPwcSc8kLoDXVOKIIe7FjPxiCrAKcEGWHXYyTjDEfU3EacTlbc9WmsNVGqptMaO
         /iAN98pSeQxfaX9W7JfHJkF+Uk2KvIlNQScJovtN2LWFgyC0RyrpWowlc1/gPItL4zFk
         T4buzCV72JuGoFaAUmcaV04/zim9RtNlVIT8gQ8LkN4yrDpKLdogHO/j+682hCGz5uSb
         TsNA==
X-Forwarded-Encrypted: i=1; AHgh+Rq5yn+k43RHK0/h2+FHnLbc78qSh7rkDaYvJjcAbxd66zcTBCx9ak8mwcCWdoWyg9fqbP7f7Jk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx449eb7IgR8/KppfHGw9wh+CIbB3I6qhZ0NlqzOKWHNrtMFRtT
	dcIYxYH08vRp8lndvDG78TIkvMXe1Le/A71myFDptttGOgHZW7rscomm
X-Gm-Gg: AR+sD11ct5PDdkDFNdizthnKsLHI6hDKcw27apLxNWQUN2MXYfjAFRBm1rXtQnbbCzf
	eZEBar3HVWo4+cea7UjK3nW8NcS8eLmg6v3k0c1b/M4iBtAt4MZordxz34iYX3PvRNY7AD7RqeD
	wwNvDRwJ/59mv7M4jSFoUI8lc8NHW68ImLlxNazsiyBjkkYx88EiO/M0pFOcRXg/pG1gSshYjxT
	6+EuFhsMB7uKqePE4Mq/N7tKilWqp6iiR8s+xsJBODNljNQHJ1X1Ax8sEmYauSxqiVOzSjbRO5B
	q6n2KzTq+tI2JQ50LZSdTL39Rb4Yw3Ji+ufnIp+Rqlzw71UwVwSrS3IYDFKMKgBPh+JFBwhF3K3
	Z/zAroSH8rSRWcFgQdGh+B9S7mG4aA+YUmu3BypMAkNRSqDNxgoplpbX6TYK/uJN6ioUTQ59Rg0
	5gtpiBg7//Io3lBf0lcn/SL7VbiosAeLmvltj8Cu24NQ3vMmAII/1u80ihis4=
X-Received: by 2002:a05:6a00:124e:b0:84a:2fff:ced2 with SMTP id d2e1a72fcca58-84fc7694568mr5608723b3a.35.1786626860773;
        Thu, 13 Aug 2026 06:14:20 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbef6a4a4f5sm1084669a12.9.2026.08.13.06.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 06:14:20 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Thu, 13 Aug 2026 21:14:08 +0800
Subject: [PATCH] drm/nouveau: reject zero-size notifier object allocation
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-nouveau-abi16-notifierobj-zero-size-v1-1-20dee38077cb@gmail.com>
X-B4-Tracking: v=1; b=H4sIAB/DfWoC/yXNQQ6DIBCF4auYWXcSkUhJr9J0ATLacQENiDEa7
 95pXb18m/8dUCgzFXg0B2RauXCKAnVrYHi7OBFyEEPXdqa1SmNMdSVX0XlWRrTwyJSTn3GXwcI
 7YR+0tTZo4/s7SOmTaeTt//J8XS7VzzQsvzSc5xcN0nxlhwAAAA==
X-Change-ID: 20260813-nouveau-abi16-notifierobj-zero-size-5d3888d36b57
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ben Skeggs <bskeggs@redhat.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786626855; l=1998;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=f/7hmALYx1pUavsqR9dX4xDKx4SJ9Gehp6aIWoZk6lE=;
 b=JzBvG33pFgsgUZm3gcV+sluPbY85ddmYsDyvCdNM9M42adhFWTnHbKTyJhu8MgcNPFlyRhplW
 /1cni1BqMUkAfpVfdotWiTvDnbpRubL+xOM++Kx3OqwfdikGFXjDL70
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

nouveau_abi16_ioctl_notifierobj_alloc() passes the userspace-controlled
info->size to nvkm_mm_head() as both size_max and size_min without a lower
bound.  A zero size satisfies the allocator's "e - s < size_min" gate
(size_min == 0 makes the unsigned comparison inert) and yields a
zero-length node, after which

	args.limit = ntfy->node->offset + ntfy->node->length - 1;

underflows (offset 0, length 0 -> 0xffffffff) into an oversized ~4 GiB DMA
window.  The dma object constructor only rejects start > limit, so the
validly ordered [base, base + 0xffffffff] range passes and is programmed
into the GPU DMA context.  The ioctl is DRM_RENDER_ALLOW, so any render
node client can trigger this on pre-Fermi hardware.

Reject a zero-size request before allocating anything.

Fixes: ebb945a94bba ("drm/nouveau: port all engines to new engine module format")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_abi16.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nouveau_abi16.c b/drivers/gpu/drm/nouveau/nouveau_abi16.c
index 291203121f0c..8d139bbb2934 100644
--- a/drivers/gpu/drm/nouveau/nouveau_abi16.c
+++ b/drivers/gpu/drm/nouveau/nouveau_abi16.c
@@ -660,6 +660,10 @@ nouveau_abi16_ioctl_notifierobj_alloc(ABI16_IOCTL_ARGS)
 	if (unlikely(device->info.family >= NV_DEVICE_INFO_V0_FERMI))
 		return nouveau_abi16_put(abi16, -EINVAL);
 
+	/* zero size yields a zero-length node, underflowing args.limit */
+	if (unlikely(!info->size))
+		return nouveau_abi16_put(abi16, -EINVAL);
+
 	chan = nouveau_abi16_chan(abi16, info->channel);
 	if (!chan)
 		return nouveau_abi16_put(abi16, -ENOENT);

---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260813-nouveau-abi16-notifierobj-zero-size-5d3888d36b57

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

