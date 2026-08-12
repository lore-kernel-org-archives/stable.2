Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6FA46983E
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546850; cv=none; b=RRomckg/HtbYEJwl40y3r/+cmm/WjRe9THQ3ZQNQ8fXG+OPh8g4AV/lqhBbg8eeZBklFDf9vdS1io8riObERx5u+OGzz5TnO+aNtl+zJLCnL252CD1kAhrSegM7WRrKWQdsLpXHXhowHELB+3gg53BTBNWUvxPf/pXzByduTc84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546850; c=relaxed/simple;
	bh=U4T7yVA0PCbP5g0s2yLY6Rg/fJ0eJtWweG0p/5LOj4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OFTMSD3eilJlY3hTkdQiRH/iZlgGlWAxDSlejGx1V19YqS/esfpaWgjESIzQCW2TSE21KCjfkkK5tPFbPGAxRPpR/Z8YzNm9fubXw2r4pcFJ2+9NlZR3BCmc1WC595cNdFp/o/kIEq0Wt2BGeuwppzy+Vfueh58jEzC0qQfFxW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hNEueG9B; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNEueG9B"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3811f512167so1299756a91.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 08:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786546837; x=1787151637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q5RKCcCs+aO4MrLdOnYHMwBF2RezT4AlJ4Gp/mR+XLo=;
        b=hNEueG9BFf8R/eAZqHfqgecpRryS5yzK8+vl4IT9oBQQnry0vjEILRIXuA3C1W4G6K
         4LiuVFrZdyIJuf/KwFhDNlT+eYjHbUp+CpIiLr8DZW9c9KcImfAkjVepNblyRmhaFTqd
         L3miW0fvYxpGx8sxVZ1ShK2gtCtdCzxJew19YbCVpM0vLujvvToeUwBzWZM0M0DvOX3b
         IM7b4ht6kqxF4i/PkzORK6T9TnxUVD1vEjgK+Wo28QtiuFr6Qu1mII8LDUfmsqusf9DP
         FWeBZ2ext6Ri0gtE7GD+FaSnVEJX0+V6PLrGlqJFiKbJYgVwkuevx0MuAK5I/FOiMYWO
         w2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786546837; x=1787151637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q5RKCcCs+aO4MrLdOnYHMwBF2RezT4AlJ4Gp/mR+XLo=;
        b=QdudPvIEbvjRQ/cufno1TFC55knvbiJnJ+LLDayz51f0R6PSz83ElDptXslOQNddAA
         0tgob9yHmOOfJRl+uSx0sfK7c4bfNPZ2tWfM4xaFa6aJX/+eWB1voKxukYR7BhbsOF0a
         Kt4oS31btue60Mmkd5GYvF6QDVdQSjd7Muxk6Lpj7wYB4mTV3JVFud/Jsu/+DT3HXWlz
         tIrr1dZRvyZ9P40DQakXXdPUEzQ1niPBfQYyMCNjRJazrAcBV4EEi10Gy9cLpaOnNrK1
         F6SttWRQApeDI0zqf/ykRy/x/i01c483N3HBtZMbcYVBkNdSOA0TnWGxVKWuSLSlQrCg
         oqIA==
X-Forwarded-Encrypted: i=1; AHgh+RpLN6qJCb/D8B5Af/GnIY9dsjRN4S10Bd2Ae+KbqIZRI8LwsZSjgVWuKG4VB7Xtmqlen+C9mj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynrb8Wl4iUa76NAeMkazOl3Me86yQ/cnZY1l+AGmFANI8jRKpj
	o7Ovygiz59Jt+V1P5FjjK8+Qppuj0L/vm0mKVlpgWjkTuk1KCHLv1wh6
X-Gm-Gg: AR+sD12WlkAngsWWH7tbCDGK4EeOaCqY2P7T8TnUXmJ0YdvcO6aTnXhGTgdCY7sxjFY
	4ZIzSuZi45ZOPq2KcHtBUlTnyme9YgBHH1/+9ts64UgTJD9D/8bDdwLViA+h957sCnCPVi7ihxL
	zXa4WCaj5FDI6yuPzX/LuzqNxNr4wXV/L0Z8gYWFebvrrPgQgVrpTy1PoyLQZ+dniLtZGlqw87M
	t03uSQzqtWqc5MSh3ie1RvNP00H+eQuz4wFWgqg7Hr9HfEt5aeElMUdYcfm+1aCVaa+fWkAhVef
	pgDVVgmdwButXPM5ge0LQiv+V/mIDCTe1tyBcYEkiGsvfhLy/yFJukPU9gbU8Vw8ZfGcpNgmOq0
	Qm1HEVJ2zXeUcv96vrMydEZJmhRqDHnpMRpo1BsbIfyPcKW7CnlE4NVMJxYOkE+KUzi+OQ+z9TB
	LbXTYxTu5rwn1n3A8TSucQ73Bb1bGusnqUmZZoa4W1yDjhIUO3diWGx86pemJo
X-Received: by 2002:a17:90b:2d87:b0:38e:1497:af5b with SMTP id 98e67ed59e1d1-393013c41e8mr6639072a91.1.1786546836771;
        Wed, 12 Aug 2026 08:00:36 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f935f73csm3896491a91.6.2026.08.12.08.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:00:36 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Wed, 12 Aug 2026 23:00:04 +0800
Subject: [PATCH 1/2] drm/nouveau/sw: prevent NULL deref of disp in vblank
 methods
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-1-7e057f6aeba0@gmail.com>
References: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
In-Reply-To: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786546828; l=2686;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=U4T7yVA0PCbP5g0s2yLY6Rg/fJ0eJtWweG0p/5LOj4Q=;
 b=zuoq23EqGDpiTQ22kZ6ODTRR2vhXOyPyC1C+c7ujp9yvu7qEc12Nu3mhBQN/oi2bH0Mkqjldp
 cfH5yZjZk6/CGDGFIQxyquHlnS8uQjUtZ8Pu9QRDOQ4/mxFg8b8kqGN
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

The NV50 and GF100 software-class vblank methods nv50_sw_chan_mthd()
and gf100_sw_chan_mthd() evaluate "data < device->disp->vblank.index_nr"
to validate the requested vblank head before allowing its notifier.

On a headless card the display subdevice is absent: nvkm_subdev_disable()
(strap-driven from devinit) and the -ENODEV path of the NVKM_LAYOUT_ONCE
device constructor both leave device->disp == NULL while the device
continues to probe and still registers a render node (DRIVER_RENDER). An
unprivileged client holding a /dev/dri/renderD* fd can then create a
software channel and push method 0x0408 (NV50) / 0x040c (GF100), which
dereferences the NULL device->disp and oopses the kernel.

The channel constructors nv50_sw_chan_new() and gf100_sw_chan_new()
already tolerate an absent display ("for (i = 0; disp && ...)"), so no
vblank notifier is ever registered on such a card and the method handlers
are the only path that assumes disp is present. Guard the dereference
with the same disp NULL test the constructors already use.

Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
---
 drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c b/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
index 0171cdf6f639..4cf8cd120c76 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c
@@ -72,7 +72,7 @@ gf100_sw_chan_mthd(struct nvkm_sw_chan *base, int subc, u32 mthd, u32 data)
 		chan->vblank.value = data;
 		return true;
 	case 0x040c:
-		if (data < device->disp->vblank.index_nr) {
+		if (device->disp && data < device->disp->vblank.index_nr) {
 			nvkm_event_ntfy_allow(&chan->vblank.notify[data]);
 			return true;
 		}
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c b/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
index 0cfb1eaae6de..b202e11238a5 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c
@@ -69,7 +69,7 @@ nv50_sw_chan_mthd(struct nvkm_sw_chan *base, int subc, u32 mthd, u32 data)
 	case 0x0400: chan->vblank.offset = data; return true;
 	case 0x0404: chan->vblank.value  = data; return true;
 	case 0x0408:
-		if (data < device->disp->vblank.index_nr) {
+		if (device->disp && data < device->disp->vblank.index_nr) {
 			nvkm_event_ntfy_allow(&chan->vblank.notify[data]);
 			return true;
 		}

-- 
2.34.1

