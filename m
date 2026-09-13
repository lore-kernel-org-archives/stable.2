Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABA1334C39
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 22:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338622; cv=none; b=WC4xbC8GNNKOyRciDW6sPMwmllKXF+CGK41Z7ezGkL2aYV/EstDfM76fVGW0f/CuNHsw2xMmhbthhQKFamqDbWMcrgtK9AbqcSFECbCvcCuTsMHDU/tFMpm0EfteVZvfZgAsch9X6NNZ5ehSAf+xJuR6JBcqpKZATLGZWoJQWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338622; c=relaxed/simple;
	bh=la+8zENuHhQW32J/DB4qpF5gtk5kX5TQ3jT3X4houb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PS8+hyNBnKzgyeIfsJ6Ub31Yoib4g+JnBoyXvkpa3dDH+dYWgcXyg++GXxv8RYyqwfcxmeRMhGLmdkriRGyW4+uQQKCikSJoEoeFO3R13LSXgpbT4XoByny/FfQbw+5q2PAmRsYPs0/Y7S4w4pjSFgfQ+mRJHt5GJxSlwtE85Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cp0kGWBn; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cp0kGWBn"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c29667ed561so323585966b.2
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 15:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789338619; x=1789943419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sqTwf+tfdmvg8JXeAPO0sWL+0ffOQu+hzmUICqT8dEs=;
        b=cp0kGWBni8hmdOW3xHU9/DNxeU5jljz3YDgRoPia49VrdGX2B2feKl3m+JBEqn3xG3
         y/GqbVSQdk+YQ2hrE6RyNS4LvmmnomEWTG3H22THZoZLuW8GgymDZZLJnHP+qFEYbPBl
         vceJZcrQXTwn+SHzjA8kB8HAkUtQR9D3rj3WuYH855iRpYwYA5bzZC2oonlf+83leY6D
         vJSP8GPsA7LC74eev4ZqFMsBcqG4KF0NE8ux9OPUTPmK0pQyHT1aETX+rmrltSv1kPZz
         OOOj74FexRGQwkrmJamIHMCE/scyQwEJho+rC0fYYix6yV7Qq50d9ANv9YPI7yEiT3+2
         56zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789338619; x=1789943419;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sqTwf+tfdmvg8JXeAPO0sWL+0ffOQu+hzmUICqT8dEs=;
        b=MnGWmpbtMxaNBN17rQGGLofoyJe18W/4veYjc+5T5LghLHwTTXvEUSibI9ECr46Ts0
         1+tKWvF77hTWvFxEEhzXCCdcBYe18hJcISF5NqtKnUCJH6GLaSCgINUbpy22f26GGC2r
         4MtwOlifPXvBWXNwtYZUkdoGE5oKbtmY7LyMyhrkeSZLtT/x+zCMzRHEyfXAH6qUI5zX
         fOlbmCDqZIbn6DGnQVZ6W+DZguq+Bvz0PcG61lVRWGUIFzpccQ32DGnW8euHQiHq0L2X
         YOHDbsO4WNU/0jW+aogheNJ8nefmzgUrrjDoTcg8YgZySZ0br1Vt+N6wzfB/FEIn+J90
         oKbQ==
X-Forwarded-Encrypted: i=1; AKwUvByY7JBcSrX3VSfU9EdsxS/RUDT5doHJ+XvSyCW3AkPHp/ZfWBVvyTlwbZtY1nOKhcoco9GzeZ8=@vger.kernel.org
X-Gm-Message-State: AFuF++kWiNPPuumAAJvPCLERFGezXE33ChIzk11YQ+iCRvnbvvJMZ9Ol
	dPxrLOyq5P1CL8UoJM8lYH2Sdtj3/g/Yqaarz9mFGFMleRHUaoL+982d
X-Gm-Gg: AYBFou0X2rpojhREicUrWnGm7NQ138anDpiaRk25kEkhYHoVNj9+Wn0RcFHoLlJDSzM
	A8TnbrHbY7RiR3koOWG1Hds6Lvux3LtMyX2bAJUcTgK3H4xfzMaB7dQg2M9lM6DRH+ltaL57exz
	vCnKKHi0OxRZ+FaM8UvDVaB97cCi/1HUNhUhwt6lGWvskiZtlC3/Pw7L8ka5wd/lpIvcPzEj4lJ
	u0Cth0Pm1L17XDRRBFOHe5fJwqpnF0OME1ZoqYKDVOYIRp5xuRnP54QybpOvV7laSj90kDZJHtH
	bQgYFI1L3iGeSYTGmQ9MU1Gvj75phxSEL+7n7FUrKOc+3/yEzseWH4zJ+RH4PjXWj6mgKciSYrN
	dsLlF3JywSeiICuejlgde/w8vusCdjR6rscfN7L8SUTRedhyj8srCQtkUbZ+NjdIRjOupO/eedS
	Ogz0FYSfu6bQ/b2+EGPHXKun5ukO9CWOfW1z12hVvHNggQYRtv5TFmnREzE3iPCzDS
X-Received: by 2002:a17:907:1c92:b0:c1f:e9d9:64d4 with SMTP id a640c23a62f3a-c29b862f42cmr4848666b.11.1789338619195;
        Sun, 13 Sep 2026 15:30:19 -0700 (PDT)
Received: from beelink.. ([186.247.78.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c29ad3e033asm48063066b.47.2026.09.13.15.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 15:30:17 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: airlied@redhat.com,
	kraxel@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH v2 0/4] drm/qxl: fix multiple missing bounds checks in execbuffer relocations
Date: Sun, 13 Sep 2026 19:29:56 -0300
Message-ID: <20260913223000.695299-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The qxl execbuffer ioctl processes user-supplied relocation entries
without adequate validation, enabling several memory-safety violations
reachable from any DRM_AUTH render client.

Patch 1 is a v2 of a previously submitted single patch.  The v1 had two
gaps identified by sashiko-bot review: the upper bound for dst_handle==0
relocations did not account for the write width, and the general BO
bounds check could overflow on ILP32.  Both are fixed in this revision.

Patches 2-4 fix pre-existing issues in the same code path that were
surfaced during the v1 review:

  - Patch 2: The release sub-allocator ignores the requested size and
    always uses 256-byte slots, but the ioctl allows commands up to
    ~4088 bytes, overflowing into adjacent slots.

  - Patch 3: Relocations with page-unaligned offsets can write past a
    single-page kmap mapping.

  - Patch 4: src_offset is silently truncated from __u64 to int and
    never validated, generating out-of-bounds physical addresses.

Aldo Ariel Panzardo (4):
  drm/qxl: validate relocation dst_offset against destination BO
  drm/qxl: reject command sizes that exceed the release slot
  drm/qxl: reject relocations whose writes cross a page boundary
  drm/qxl: validate relocation src_offset and fix type truncation

 drivers/gpu/drm/qxl/qxl_ioctl.c   | 28 +++++++++++++++++++++++++++-
 drivers/gpu/drm/qxl/qxl_release.c |  3 +++
 2 files changed, 30 insertions(+), 1 deletion(-)

-- 
2.43.0

