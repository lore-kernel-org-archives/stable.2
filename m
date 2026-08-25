Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC06E78C9C
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 00:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787616930; cv=none; b=nnKYSu0InD8Ly5mrX4K8ToIvLe8BUGHJHJ8V5krJz8fYq5UM1L30ATQJpJwT4im/j5C7zMfox+xXRkKWuUS+3Ii9W7UQ3FSx/WHxQOWdboBkSfglipkZFJkSgA9b35cAZiKKezGes3clXcP2Ub65cEeAQaVx1fOkMN+2+eNfWKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787616930; c=relaxed/simple;
	bh=DloJqVrrRTqx5pI3JmrxhU/jcdEShwIa0NWx9Pp+Gl0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WL0dbM5X9QQZjd/BlHGtqoctrZcM7KSF0bj7X4tFVlblk2kDZkK5gRyAgiXMrRX7TPQBY6GhU00teObK0rcffixQJi613OM27CLlCTxrsVCxXXcq2AwFjT1TbmnH/0vbBTnf0zj82nKd7ntk0K7m9DnUpKeYGNxOt94sv09PxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tAEt64O+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAEt64O+"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47ddf7b09e5so3514048f8f.1
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 17:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787616927; x=1788221727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+P/vDouc9UoeUwar0MlBIfz+YKIXPqdUfu9owZSH9I=;
        b=tAEt64O+8CMIGKkLevQvDt9MrTOQYoM9dtNU88I7XmL1cSosQZifUa/dgi5+fPDJ7W
         YAFCoRSkpLmGmQm+WK85yysEr1trHueCK25R2FIEZf1lAFFa2GmtN8BfzC0z2GqjbWwc
         ZjiBhFjjf65VV/OajmlyA2IPjxs+EZgSEigB306QTBsuSDLB6lUeIwMuuOZ+e6LDX7Iw
         q+NilrFH3BgpbEgXfnu8OviJVuVeJ0pRK1W3LdV98CiKvthOmOXpqmzRKDo1upadm1DF
         HnvGnkRY9PS47noF1lyx3LHWcuw61UUYE5NtVKhclVp7PW+d6le7gxWbtmm7YH8YmTtC
         axmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787616927; x=1788221727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2+P/vDouc9UoeUwar0MlBIfz+YKIXPqdUfu9owZSH9I=;
        b=W4Hd2gADMAm/kHeouRwyn21CnyqsTA+1MXP99AQVugvlTKK9hSQM0E8KYoLwfzvfjv
         XKoWTS01dsRVsjRvNGK3qXhOG4o+5ZGUMDtLTSHT6ph/AFWKCNPmATpkCvgRkvPixAq2
         ZjQOEpSF1CuiP2mWkjymHkGmiXa6n0QR8t81hBPnZx/+oi2BgQ+cYaPJ3mpDnLpp1Fbp
         INaVUpyGNi1LGDCdDMDfk2ii8C6Ol5n7vkjflPVKO09MsuXxgvCbHC832b0mhe0WBaXp
         kIzjkNaOAYlC3V2SMerrjLr2NNY7foyRfebyTTdTVRLZgCUIb952oZpJwEL4x3h2VL7+
         +aFQ==
X-Forwarded-Encrypted: i=1; AHgh+RqoIXIMZqlSFGhG8oEES7kJKPpLCC31htICX9c0vz5zZxVSiAML1pqyFCIjqfNRBAJDGXLJ+4M=@vger.kernel.org
X-Gm-Message-State: AFuF++liVKWoJnTPk8zY/m23Owv+MkpZq5dXw8qeKOoQKzrjFvSsuIaN
	Hmv6zAl+3T9h+lQbPwCiCnGSeBJQ/KAaCmNFkiG0Kuujyo6QzyQaQdQl
X-Gm-Gg: AR+sD10pRKzKxv5Tha2rp5G1oOozficZs2bpyoapAgD7bdARVf1qH0abpdG1CSbiSwo
	6sxRGaht0MZUTDVYfIAI/kz1qi9tWM7e1tvf216Z3F9KNGBk0ll6Zziv0RFWrQ3d0AyzF1BmouL
	ZeqZ8e1weEGvrSn2gdW4ead59Um55X7ouVcv00Zvc/1Qrgyo7Jl6znYW+IUK0q/oxb0FX+oEJB9
	WwQMtUPq8agf8FjCNxm0xUmdtGP/xE8Gn9JjErBAEmxB6hQXz6aHw/8Ou3h3LRxxy4lDcw9AoXi
	NRbmzi/2Rs7st3qM7+BDaFscxU1LCHUCHRDsRXh1uaJFB9bKCFCz8+ZhA1QQmDfIK5PUHumQi6f
	tIT1OT6hT2bcetXUv7c7wXBN140IlvgA5X6z3gOEuDI4XfAtu6W9sf03ikMlDDRWkqEsaUYqB3h
	24xSKZAxn3iaxoKruZ4EdrxyHb35NP5CnMLqhNEt33DGmMQ+lHi3ab1uRugAYmTutyuCQ=
X-Received: by 2002:a05:6000:2204:b0:481:5167:d526 with SMTP id ffacd0b85a97d-482d9ee1e7cmr2945347f8f.6.1787616927138;
        Mon, 24 Aug 2026 17:15:27 -0700 (PDT)
Received: from fedora ([5.31.134.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9b78ebfsm9770676f8f.12.2026.08.24.17.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 17:15:25 -0700 (PDT)
From: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Mary Guillemard <mary@mary.zone>,
	nouveau@lists.freedesktop.org,
	Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 07/10] drm/nouveau/disp: fix head state readback on GB20x
Date: Tue, 25 Aug 2026 04:14:05 +0400
Message-ID: <20260825001408.14219-8-mohamedahmedegypt2001@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825001408.14219-1-mohamedahmedegypt2001@gmail.com>
References: <20260825001408.14219-1-mohamedahmedegypt2001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GSP path reads armed head state and the RG scanout position through
gv100_head_state() and gv100_head_rgpos() on every generation.
gv100_head_state() reads the core channel's state mirror at a 0x400
per-head stride, which NVD5.0 (GB20x) doubled. Per NVIDIA's published
CA7D class header every HEAD_SET method sits at 0x2000 + head * 0x800,
while the mirror bases are unchanged (assembly at 0x680000, armed at
+0x8000, per OpenRM's v03_00 channel-user-base HAL which is still used on
DISPv0502).

Add gb202_head_state(), the same readback at the 0x800 stride, and a
gb202_gsp_head table to supply it.
gv100_head_rgpos() is kept. The RG registers keep their per-head 0x800
stride on NVD5.0, and OpenRM's kdispReadRgLineCountAndFrameCount_v03_00
still reads NV_PDISP_RG_DPCA on DISPv0502.

Fixes: 6cc6e08d4542 ("drm/nouveau/kms: add support for GB20x")
Cc: stable@vger.kernel.org
Signed-off-by: Mohamed Ahmed <mohamedahmedegypt2001@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
---
 .../gpu/drm/nouveau/nvkm/engine/disp/gb202.c  | 51 ++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
index face801af080..765c42039a47 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/disp/gb202.c
@@ -83,6 +83,55 @@ gb202_sor_hdmi_gcp(struct nvkm_ior *sor, int head, bool enable)
 	nvkm_mask(device, 0x6f0040 + hdmi, 0x00000001, 0x00000001);
 }
 
+/* Same core-channel state mirror as gv100_head_state() (assembly at 0x680000,
+ * armed at +0x8000, per-head method offsets unchanged), but NVD5.0 spaces
+ * heads 0x800 apart (see NVCA7D_HEAD_SET_*(a) in clca7d.h).
+ */
+static void
+gb202_head_state(struct nvkm_head *head, struct nvkm_head_state *state)
+{
+	struct nvkm_device *device = head->disp->engine.subdev.device;
+	const u32 hoff = (state == &head->arm) * 0x8000 + head->id * 0x800;
+	u32 data;
+
+	data = nvkm_rd32(device, 0x682064 + hoff);
+	state->vtotal = (data & 0xffff0000) >> 16;
+	state->htotal = (data & 0x0000ffff);
+	data = nvkm_rd32(device, 0x682068 + hoff);
+	state->vsynce = (data & 0xffff0000) >> 16;
+	state->hsynce = (data & 0x0000ffff);
+	data = nvkm_rd32(device, 0x68206c + hoff);
+	state->vblanke = (data & 0xffff0000) >> 16;
+	state->hblanke = (data & 0x0000ffff);
+	data = nvkm_rd32(device, 0x682070 + hoff);
+	state->vblanks = (data & 0xffff0000) >> 16;
+	state->hblanks = (data & 0x0000ffff);
+	/* Bit 31 is ADJ1000DIV1001, not a HERTZ bit. We don't have enough bits
+	 * to add the full clock in hz on Blackwell (35 bits), but state->hz
+	 * is unused and obsolete under GSP so this is fine.
+	 */
+	state->hz = nvkm_rd32(device, 0x68200c + hoff) & 0x7fffffff;
+
+	data = nvkm_rd32(device, 0x682004 + hoff);
+	switch ((data & 0x000000f0) >> 4) {
+	case 5: state->or.depth = 30; break;
+	case 4: state->or.depth = 24; break;
+	case 1: state->or.depth = 18; break;
+	default:
+		state->or.depth = 18;
+		WARN_ON(1);
+		break;
+	}
+}
+
+static const struct nvkm_head_func
+gb202_gsp_head = {
+	.state = gb202_head_state,
+	.rgpos = gv100_head_rgpos,
+	.vblank_get = tu102_head_vblank_get,
+	.vblank_put = tu102_head_vblank_put,
+};
+
 /* GB20x is GSP-only. This table supplies the register programming the
  * GSP-RM display path needs from the chip.
  */
@@ -91,7 +140,7 @@ gb202_gsp_disp = {
 	.uevent = &gv100_disp_chan_uevent,
 	.ramht_size = 0x2000,
 	.gsp.intr = tu102_disp_intr,
-	.gsp.head = &tu102_gsp_head,
+	.gsp.head = &gb202_gsp_head,
 	.gsp.hdmi_gcp = gb202_sor_hdmi_gcp,
 	/* The legacy AVI unit is unchanged on GB20x. */
 	.gsp.hdmi_infoframe_avi = gv100_sor_hdmi_infoframe_avi,
-- 
2.55.0

