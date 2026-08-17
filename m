Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5473B0ACD;
	Mon, 17 Aug 2026 06:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949443; cv=none; b=qR11IwpjLcwvuS39YN0OtW97wPGPHVbh8XgfyFOEwP7JCgJPWMcZTF1o7kObrrEb5MmAZaLC7txrwCzKdgK43LyHuteCmnaKBxbpu2kKZHVwbr4RMWRyQ5gs+C0Iy0Hg2BQnv21YE8rfBgrffJCGmdt1tQ6pmaxGHvgWbejrHiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949443; c=relaxed/simple;
	bh=0jIfKSzAE+75ToUwYrMLODJzLMibfWw9F/XdnV6FoW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZqGjsj4p/Nn5FEwQIX3yEFysplenSjry4Xla68Z9Q7yFe/8EeHmsCpBznZUJAWJNL/mbvLx7Y7Px1Bl86cNGS9tmGo14f62JBJGdjH65uDrCz/23GW9gwhoPM0PNiMZ9NDH3hVHLpGNLNAHdafNN36VqebWACmXuF2ib9cPTqXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSK3E7cu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSK3E7cu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 024CAC2BCF7;
	Mon, 17 Aug 2026 06:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786949443;
	bh=0jIfKSzAE+75ToUwYrMLODJzLMibfWw9F/XdnV6FoW0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jSK3E7cu+VAaOG+FFC8ni1vvHjR4yd2XjVUhz131j6+wuv7uTpasKuavN9O0gtGYj
	 QNvu2tSfZzsi/ggaPb5cCCzzeaU00PEfCGE6jyn0IwVkfTi1poF7XNqrOpunkZM2he
	 wjKbVlikUy9H+g3S6khgSxLKqXvWqeAlO7rkq2qu1V5AJaorrZ3hjPv80Bk4oxpC4V
	 p2FP+ZTAO+BRC7frxgcACl5zlHtXs5LFmxh7Achp/FH0opeKjifcOAYMcx3BTr/Yz9
	 I2s7RiJA7g7xv34fZB+7QYvX5xk3eMnKQXubitlLP+BDkb4DPxrILzFj81HQYxDY3+
	 GuxDKsYNSyhmQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1AB3C5B572;
	Mon, 17 Aug 2026 06:50:42 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Mon, 17 Aug 2026 14:50:40 +0800
Subject: [PATCH 1/2] drm/nouveau/dmem: pin VRAM for the whole registered
 range
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-nouveau-fixes-v1-1-f518d0c735f3@outlook.com>
References: <20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com>
In-Reply-To: <20260817-nouveau-fixes-v1-0-f518d0c735f3@outlook.com>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Balbir Singh <balbirs@nvidia.com>, Mary Guillemard <mary@mary.zone>, 
 Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>, 
 James Jones <jajones@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1569;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=JWyT9l1BGNNzUOMeazwU1aUewzuACkAELT3y3ijb100=;
 b=kA0DAAoWceg4UIuO8EAByyZiAGqCr0Gia1eSm2iWLYigw1j3zlknOQqpGbukRHCvB7tZSeHHK
 4h1BAAWCgAdFiEEx3DS9jhNtC20TLRjceg4UIuO8EAFAmqCr0EACgkQceg4UIuO8EBu7wEAvphn
 +7tRZx/3bKNUMnkzJnovZ17334oxd+Xun10yN7gA+wY0GrtObNtbcC+rhjGswyHDmreHedTP47s
 SD0tqP8QB
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
Reply-To: moonafterrain@outlook.com

From: Junrui Luo <moonafterrain@outlook.com>

Commit c32287471077 ("gpu/drm/nouveau: enable THP support for GPU memory
migration") grew the device-private region that
nouveau_dmem_chunk_alloc() registers from DMEM_CHUNK_SIZE to
DMEM_CHUNK_SIZE * NR_CHUNKS, but left the VRAM buffer object backing that
region at DMEM_CHUNK_SIZE.

nouveau_dmem_page_addr() returns chunk->bo->offset plus the page's offset
within the registered region, so every page past the first chunk resolves
to VRAM outside the buffer object.

Size the buffer object to the region it backs.

Fixes: c32287471077 ("gpu/drm/nouveau: enable THP support for GPU memory migration")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 9442ec6e1f6c..356ff8f3c1b8 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -325,8 +325,8 @@ nouveau_dmem_chunk_alloc(struct nouveau_drm *drm, struct page **ppage,
 	chunk->pagemap.ops = &nouveau_dmem_pagemap_ops;
 	chunk->pagemap.owner = drm->dev;
 
-	ret = nouveau_bo_new_pin(&drm->client, NOUVEAU_GEM_DOMAIN_VRAM, DMEM_CHUNK_SIZE,
-				 &chunk->bo);
+	ret = nouveau_bo_new_pin(&drm->client, NOUVEAU_GEM_DOMAIN_VRAM,
+				 DMEM_CHUNK_SIZE * NR_CHUNKS, &chunk->bo);
 	if (ret)
 		goto out_release;
 

-- 
2.51.2


