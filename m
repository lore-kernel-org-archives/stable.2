Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BFB309EF2
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789223068; cv=none; b=H03LTRTUsmBnB9aPvcXG62abPJ8sXtmsqDCrkfsmFAaWiq5OQkHUEyyafB40pU4u4K2t6wHBLQTp8xvYU5M+ICqzm+vOhhkGCOO59l7duEVcKO8ErxJOUckbyzf5/3YZUxuTPKlZLW4aFq9pPWIZNMAZcZgWdvTokz/SseBD5Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789223068; c=relaxed/simple;
	bh=cp4spMfo8ki2DWWRNH6mj183l3M54RRGPnxV9QFGzjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaTY6TlaHK9AwODSVshzV7AEMlXnDw283QrHFaMtOTKz6PQ6YnGQpMIwGgzQVfo9VZBF0G3ZDaxmwM0LPwWWj/7bEpVukBLZcfzikqYdGpC9OzNrhmr11+UkBV42XPv7p8CDUd1fh0cXOsIj2vAiRRBj/mVrnFS3+p8INqCeLiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ig1wkTS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ig1wkTS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4896D1F000FF;
	Sat, 12 Sep 2026 14:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789223066;
	bh=AYrhTrg41o14N5pXcDM4tTv+Bt6BIy7YQEDVaDrmMmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ig1wkTS3XQi9yavS3Hx9MNOk8WZHDfqbRZaOQIWiv7J0GP5RRfjKjSnOhi95tpF0v
	 lixxpnsLgHLwwkq3pA5TXbS2DUUXE89X8pXDqDlcimloAiLFAbprIQs8Aszkh/njc1
	 +COki9YOFKZj+9dnbl4vlkdx0LYz/qnpXta3eXNweyDqIb7SaZ0SNYHf6h6njCJ0tN
	 jybis8aohOhtNO2lozLK5KAY+kq2W1cdHH+tpawO1qFj/prGDuiaeCbnBUjAKZAt0i
	 7hwCyvIC0PBFISkbmSJCoyeoW9it3I1IJ7O9q6vvm+JdSTkxO4i5s7ZI++aFU2c991
	 NI0EpWV4XFcwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>,
	Ben Skeggs <bskeggs@redhat.com>,
	Dave Airlie <airlied@redhat.com>,
	Timur Tabi <ttabi@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	James Jones <jajones@nvidia.com>,
	Faith Ekstrand <faith.ekstrand@collabora.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Aaron Kling <webgeek1234@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Zhang Enpei <zhang.enpei@zte.com.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/nouveau/disp/r535: Add scanline position support + head state support
Date: Sat, 12 Sep 2026 10:24:23 -0400
Message-ID: <20260912142423.2930179-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090922-celibate-moisten-846b@gregkh>
References: <2026090922-celibate-moisten-846b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lyude Paul <lyude@redhat.com>

[ Upstream commit 804cb093b245c752f15d17186e0d404f10303593 ]

That's right! It looks like this never actually got finished, something
which I just noticed today when I saw this fun message spamming one of my
test machine's kernel logs when enabling display debug output for nouveau:

  [drm:drm_crtc_vblank_helper_get_vblank_timestamp_internal] crtc 0 : scanoutpos query failed.

So it looks like we've been falling back to DRM's core fallback for a while
now, whoops.

So, while it seems that we do have the option of doing this through GSP -
that doesn't seem like a great idea. Mainly because reading this from GSP
would involve a lot more latency then we should have for vblank handling
due to the RPC communication. So instead of implementing that, just use
gv100_head_state and gv100_head_rgpos for implementing .state and .rgpos.
It seems to work perfectly fine!

Fixes: 9e9944449023 ("drm/nouveau/disp/r535: initial support")
Cc: Ben Skeggs <bskeggs@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Timur Tabi <ttabi@nvidia.com>
Cc: Ben Skeggs <bskeggs@nvidia.com>
Cc: James Jones <jajones@nvidia.com>
Cc: Faith Ekstrand <faith.ekstrand@collabora.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: Lyude Paul <lyude@redhat.com>
Cc: Aaron Kling <webgeek1234@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Zhang Enpei <zhang.enpei@zte.com.cn>
Cc: <stable@vger.kernel.org> # v6.7+
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patch.msgid.link/20260429030348.3930866-1-lyude@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c | 4 ++--
 drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h  | 2 ++
 drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c  | 8 ++------
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
index cfa3698d3a2fd..0aee9967d1d34 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gv100.c
@@ -253,7 +253,7 @@ gv100_head_vblank_get(struct nvkm_head *head)
 	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000004, 0x00000004);
 }
 
-static void
+void
 gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline)
 {
 	struct nvkm_device *device = head->disp->engine.subdev.device;
@@ -263,7 +263,7 @@ gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline)
 	*hline = nvkm_rd32(device, 0x616334 + hoff) & 0x0000ffff;
 }
 
-static void
+void
 gv100_head_state(struct nvkm_head *head, struct nvkm_head_state *state)
 {
 	struct nvkm_device *device = head->disp->engine.subdev.device;
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
index 856252bf559a4..b642729c254fe 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/head.h
@@ -53,6 +53,8 @@ void gf119_head_rgclk(struct nvkm_head *, int);
 
 int gv100_head_cnt(struct nvkm_disp *, unsigned long *);
 int gv100_head_new(struct nvkm_disp *, int id);
+void gv100_head_state(struct nvkm_head *head, struct nvkm_head_state *state);
+void gv100_head_rgpos(struct nvkm_head *head, u16 *hline, u16 *vline);
 
 #define HEAD_MSG(h,l,f,a...) do {                                              \
 	struct nvkm_head *_h = (h);                                            \
diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c
index 99110ab2f44dc..f80f9c0f85a71 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/r535.c
@@ -623,14 +623,10 @@ r535_head_vblank_get(struct nvkm_head *head)
 	nvkm_mask(device, 0x611d80 + (head->id * 4), 0x00000002, 0x00000002);
 }
 
-static void
-r535_head_state(struct nvkm_head *head, struct nvkm_head_state *state)
-{
-}
-
 static const struct nvkm_head_func
 r535_head = {
-	.state = r535_head_state,
+	.state = gv100_head_state,
+	.rgpos = gv100_head_rgpos,
 	.vblank_get = r535_head_vblank_get,
 	.vblank_put = r535_head_vblank_put,
 };
-- 
2.53.0

