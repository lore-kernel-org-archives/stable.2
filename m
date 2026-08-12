Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0F4756C2
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546841; cv=none; b=O0d0gI7vnDRtgFu8DtbVT2sdgmWEdVLS8+reKfXfMA/LfABZ0tTP5EJIPlZPyyAqmakQibFIn5rAoK1y38EYmpubsQUgRnUwo36cRCRnu75+FAAE/XqDmzBu22meRK0f7fHGVpk41v3duAjwbQEI14OzLo1rR6m9GFvo67sRzvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546841; c=relaxed/simple;
	bh=9ZuFZsbGjnuxi4gxJ6gdaTdFRQu5GUSAhJ89zKR0YI4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FOZHR4YMZqWH1llJa5M3a95Ht8+ilccX4+2aAOjX7RJXkFs2nt004wkPI3NOIs2UsWGHZyJOMKiHEowaeFi575t3uGMkYA55TFK173Wr1l6EItedLfZa1g1Qxb2zSLIbpQF4HUShAt4FKhZNHbS+nPSp+2pk8AN/FQSXbC4R6mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CgzJ8PH/; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgzJ8PH/"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e7109321dso938466a91.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 08:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786546833; x=1787151633; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bsSNRPwXgz4YmhClD9/CFwQgfHi8L4hudE3tc+zdeok=;
        b=CgzJ8PH/l3cBYyMG5JZN3OE2WN0DaGP+PX3HXygPFcWCxpnbUFbUAJ1elAdib5YF+T
         BQyo8viJha4KqWXaMmHtGmpVIiN3EwytzIisfuzsgFtLWFyoyxhK3bOwnKg9PX5ivBnJ
         8mZC6wdypiXVKeiDScNyo5V/TzGJ+Tbfm4sqsuRjDh5tmbkRdtkDrA2JAmhNFMdx2DKN
         VuZgq+TVJVhcXfKdccjj4gAnY49xgl5Gi5M0l7eSnYus9VK6d0mplcdUiK/4NNawQQk/
         pOatcXK1GHQsBqJyjheoFXNZooLk74cnClFJ0X3CBbKpxz5QwEaAZGKtQFfGXaG6BD/r
         6+Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786546833; x=1787151633;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bsSNRPwXgz4YmhClD9/CFwQgfHi8L4hudE3tc+zdeok=;
        b=dTt8qPL6hF/sntFzdz/zyJadiEMFU/km+UIn2WXzLOIb4lAXz6iJUqzU5tegIPH3Jb
         b3yOi1wHTqkBPcQI4ElH4tmjQr5S2T94sfITJMG34DL/bDML/QeJFnqN3f/raHtzxSGv
         l+RBTBAmNXjzCloFo6tybxhcGzoIH7K2sLMWijZZlVx00fHKiyBJP3/8XsR6gkUhlZZS
         Qz3LLi9bnHIejMZF1643Rnj9DOjTXqOBd5hnPCG6eF6JVDP4VWp2nWrNbMVxntmFrHJi
         rYklkgPgfT0HI86lu1vDveU+KXMUbTnSjUL75EdLml5DMpRg6UgtU7JtiCUz9f5wOqh3
         EQzg==
X-Forwarded-Encrypted: i=1; AHgh+RoyiQnodNjWkfRE87BPjEZhbS7V0P+zUEoc6zYIzgtl2wCi6SQXN/wuCEJdok5njsmen48CCLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YydTXt7LuUUnFaBXy/8bPYsQBQS8lWOUmI5VVhMgCJ3qNFxrX6t
	qZwG5QHjszIuQFMCL6aTKVPw3zTec1a54MdDnsyGyG7hPFcbbRXQoezA
X-Gm-Gg: AR+sD10/ovSI+2kr4nmaZdrPtkCGIELlgjAs+nX5zGWje3Jl6gN60+oAYCHWryDIxWl
	dj+2qFmXiq/a8KnwQIW+w5xZta1bFXrCH1Rj83vcisVIgenMX4S2yCCnIuz2H/UkoKJjHAF4gME
	UvEk0MhfzkUhjVBkeNz1tz9YY4khpIcfvxDIMXqf3lZGn+Bwf8XkxnNP48hfwj6jV+EZMWJ/e2M
	5cWMuswI/8F+MWskaT30P40k5fNumAIDbZW8XjdEwnZK4tM507OV86D3BOwke/0IwVq45kGBcvF
	m5GhYh3F1ndkj6fhpmoJubEL09gbEQAiYnwgtSqyNpQF7Vd7r8+8uzFWn2XNUZooTsls7lsozbW
	Yz8mLuxKgUp8XT2boz99j4eWCS4vJIqd7Cp0og+laHXoemkIgLqXCF0bWyigDA3PSzNystIFHNg
	k8HuOmmFjweT819m5Zjg==
X-Received: by 2002:a17:90b:528a:b0:37f:e1b6:4c7d with SMTP id 98e67ed59e1d1-39301287f66mr6968430a91.6.1786546832312;
        Wed, 12 Aug 2026 08:00:32 -0700 (PDT)
Received: from LAPTOP-N3B6U5LC.localdomain ([117.147.100.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f935f73csm3896491a91.6.2026.08.12.08.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 08:00:31 -0700 (PDT)
From: Zhenhao Wan <whi4ed0g@gmail.com>
Subject: [PATCH 0/2] drm/nouveau: guard two render-node NULL derefs of
 absent NVKM subdevices
Date: Wed, 12 Aug 2026 23:00:03 +0800
Message-Id: <20260812-nouveau-nvkm-absent-subdev-null-deref-v1-0-7e057f6aeba0@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHOKfGoC/yWNywrCMBBFf6XM2oE0tFL8FXGRx1RH61SSJgil/
 +7ULs+Be+4KmRJThkuzQqLKmWdRaE8NhIeTOyFHZbDGns3QWpS5VHIFpb7e6HwmWTAXH6milGn
 CSIlGHHsbfR9s15kBtPVRyd//z/V2sI6eFJY9Dtv2AyjbMc+JAAAA
X-Change-ID: 20260812-nouveau-nvkm-absent-subdev-null-deref-f52db5c24408
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Zhenhao Wan <whi4ed0g@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786546828; l=1909;
 i=whi4ed0g@gmail.com; h=from:subject:message-id;
 bh=9ZuFZsbGjnuxi4gxJ6gdaTdFRQu5GUSAhJ89zKR0YI4=;
 b=ElzEuFopoAhqiGv9INlGlqScomht2xFPIi93NufKAn1DNkZgTULNfaJV8/oZt+WbKtSpDl6Sw
 eDE++5uEgHRAeL36Y9JM6kVgJxmbBIj+FxNbkntO4u8h5M94nPrFYqu
X-Developer-Key: i=whi4ed0g@gmail.com; a=ed25519;
 pk=zRTKlstE0LmilshGwJsFYEVjiT6RiXMBXK8Og6VmuVQ=

Two NULL-pointer dereferences are reachable by an unprivileged local user
holding a /dev/dri/renderD* fd when an optional NVKM component is legitimately
absent after probe.

When a subdevice/engine constructor returns -ENODEV, the NVKM device
constructor (NVKM_LAYOUT_ONCE) treats it as an optional absent component: it
deletes the subdevice, leaves the device-> pointer NULL, and continues probing.
disp can also be NULLed by nvkm_subdev_disable() (strap-driven) on a headless
card. nouveau still completes init and unconditionally registers a render node,
so two method sinks that assume the subdevice is present become reachable:

  - the NV50/GF100 sw-class vblank methods load device->disp->vblank.index_nr
    (disp == NULL on a headless card);
  - GETPARAM_GRAPH_UNITS calls nvkm_gr_units(gr), which reads gr->func
    (gr == NULL when GR construction returned -ENODEV).

Either yields a NULL read -> kernel oops -> panic-class local DoS.

Both fixes extend tolerance that neighbouring code already proves is expected:
the sw channel constructors already guard disp, and nvkm_gr_units() already
returns 0 when the engine exposes no units callback. No new control-flow paths
are added.

There is no Fixes: tag: these are long-standing bugs predating the nvkm
reorg, so they are sent to stable without one.

---
Zhenhao Wan (2):
      drm/nouveau/sw: prevent NULL deref of disp in vblank methods
      drm/nouveau: prevent NULL deref of gr in GETPARAM_GRAPH_UNITS

 drivers/gpu/drm/nouveau/nouveau_abi16.c        | 2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/gf100.c | 2 +-
 drivers/gpu/drm/nouveau/nvkm/engine/sw/nv50.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: db2ddb87143519e20a95aa36c60b36107b736a58
change-id: 20260812-nouveau-nvkm-absent-subdev-null-deref-f52db5c24408

Best regards,
--  
Zhenhao Wan <whi4ed0g@gmail.com>

