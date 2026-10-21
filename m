Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792601716;
	b=HBMYTscCfEXeGOUsVAYoRWvxhBZs89VXzvSzYXBSZK+OzbC4o8ylz87b9wWNFtwiy2IU
	 c6h+C+7fGxXy7ZB+Mz1+OTAYANJfUZeE2YnyWnpAR/g0AQomC724BTXMGDCeujBGGv0A6
	 AQslj2lHVyAr6IJ2V39GquvbHduxihs6pKJMHyDqhcyUV7eOPMFJP+z3JReMY2d4Vtp6j
	 dVf/livCHgtqgIEw36fmwiZGwiUc96OjaQCN+4WFVlCiV/cPK0rCcSTO5HIKgNtUYT0Pt
	 FrNkPK/22L00XN9tL7nDrI/EMGBX1h4jB/nRYejo3h+Hq1PHkI3VN8uPDb4ghZuYQtg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601716;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C4QyRnGrdWyZezn3sJE3V8gSx7WRk2zAitUEcSJ86rs=;
	b=1+Mo7gnnjFU3ldBj8Fg+xnq+Q0WQcy2/M2xGmAQYLEg/Frgq21BHDqeVxfRBSZcwLEZv
	 YPiKX8KozDubEVmdEYKssIV74TkkmCsVyC3PQZ9HGfvhtf26vinZpTegCYK/jOnk1yrTG
	 5ti+BFFKwUrBSC3JjziJJcOEa52bnR6vTnx5pNhXphJKl20ze53dBmzEOEzm+/1/Af2iW
	 6FEi2KLNJhAPhMJ+aBxdPi08kPtNvMsMUcB6COoqQG2slJ0ujGTIB0bDQb1VwcycSbY+l
	 E0v5xFYpLCfwbW+N/bJ3LSDcnRjROELkYVhnXJYpB2AHOrMYC+0Y04z8bQxjN9JVx3g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGQ9n7zR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0996606A31B;
	Wed, 21 Oct 2026 16:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DGQ9n7zR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792601715;
	b=Z8TDklyvD3dqXjQZkuyMlq8T0vTsPlJr4stVJXIHiRwivOl3SG76HrxhKuSER1JR+TxV
	 VUMDeWHGecsu11DB3EH5VwUQbeLeRLkrH+lr5Ptpt8lMaCNJt5QQ3oUQ+MTPC4+7gwCrk
	 l0432H7FGUHhcLAWSx1fsgZuVLSW3nKonFnfguMaMuEjgPm2ovM2gUPFmWYroxFUmxPyM
	 TZ/PAqxnsbkDOGrwXPKEdUPXpDemx1S6BjW8vtJpXB19NS43dWkYOPBuvXWRRYnQpM6Vh
	 Zu9uqYfLgSv6vsLTl+ht1ttecANRYykSIuJc+wxWP3lvzOaaWYetkRF8dXqBkgydHZw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792601715;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=C4QyRnGrdWyZezn3sJE3V8gSx7WRk2zAitUEcSJ86rs=;
	b=p8srcuw4IPzuyKU/ZxAiooQJEh91Zua21RMdWryUpAPwM8kjG5OM3BWEylpjswTVBkt0
	 jBy7GtOrqLbR88393wdKTVka74lCQ4OPJnsj+mmPX2IXhUghZVSrEmSuuwqVjngXkZSSc
	 8U85Em8EK2Saj3oKAyWzaVD2mZMVlMoKnZTLJNKkMMNDSDKhIjbLQaPCiY0ko1ttnu/he
	 qCCmGBAkDUE7IvcSErSfOIPy1Vcz/W/utGjEUJ6MCTiJC7HFRAKojux+HZGMZgKdj4aiR
	 A72LFKDmfjNnzfJgHkGDeeGZUwgOvD4V0UpG2gRDiiwIgKhEcuflN1xur02BE1N0sWg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id C4F9F1F000C4;
	Wed, 21 Oct 2026 16:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792601715;
	bh=C4QyRnGrdWyZezn3sJE3V8gSx7WRk2zAitUEcSJ86rs=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=DGQ9n7zR5pO1CvUnp7ZwfrYzXsuz3l+1IOW+IYKpGJh2ivevmtd14AJNm2Q1KRq8O
	 vnMzaTLrfb5IlxxjSMbPpkLG6LvYXNzL539SbFBD8Se/5LSOEPHx/XlvCT6zc1/skX
	 /vjqmIN2dbel537K/fOe9hcXhIdSl6/hprEaf9Bd7459DCSyUgR/JgHQO/7NOD5/Yp
	 cQ+PoSVJddEUn1bjhRwX0Kq1Wx2fBEkx99euUe+uXNhQDmGFT/JwVxejCMu+bQFDxJ
	 NtX/pE7+VLWozfrHCk1Ydpn2x2fMgDrrvS/TqfQ/3uaWOJke+ouQH5wC0xeHGkbnKs
	 YWE8knpbVKgsw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 271EA4315A;
	Wed, 21 Oct 2026 16:55:14 +0000 (UTC)
From: Joe Finzel via B4 Relay <devnull+joe.sudmix.de@kernel.org>
Date: Wed, 21 Oct 2026 18:55:02 +0200
Subject: [PATCH] drm/nouveau/gsp: skip address-only I2C starts with MOT on
 GSP-RM
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261021-nouveau-edid-segment-v1-1-101dd5aa3ecd@sudmix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MOwqAMBBF0a3I1A4kEb9bEQsxT53CKIkGQdy7w
 fIU9z4U4AWBuuwhjyhBdpeg84ymdXQLWGwyGWUqrYxmt18R48WwYjlg2eBOLsq6UeWkW9SglB4
 es9z/th/e9wNCX9yIZgAAAA==
X-Change-ID: 20261021-nouveau-edid-segment-357805c19e7e
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Airlie <airlied@redhat.com>, Ben Skeggs <bskeggs@nvidia.com>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Joe Finzel <joe@sudmix.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792601713; l=3093;
 i=joe@sudmix.de; s=default; h=from:subject:message-id;
 bh=oM+HRdxOHZSWOEGviI42/1A3BImx/Py3uHcns0asV/U=;
 b=jMHvMxK6yddba4p7Pt0fqga8L7DwN8eEuQoeEyw0ST+chY2TqJwgejk6gvqPWkuOMF7j+dIhd
 kwv35tkNSMiDaPEHzJvz4Xx4CmSGsIwK430y+hVswUKYGkUoWQ8e2w7
X-Developer-Key: i=joe@sudmix.de; a=ed25519;
 pk=vaX11uVm57me/1N8otNmzMMnsE+f0U3/Hi9TCPbnvZM=
X-Endpoint-Received: by B4 Relay for joe@sudmix.de/default with
 auth_id=1151
X-Original-From: Joe Finzel <joe@sudmix.de>
Reply-To: joe@sudmix.de
Content-Transfer-Encoding: 7bit

From: Joe Finzel <joe@sudmix.de>

The DRM I2C-over-AUX helper starts each I2C message with an
address-only request with MOT set. r535_dp_aux_xfer() forwards it to
GSP-RM with MOT cleared, which issues a stop on the DDC bus.

E-DDC resets the segment pointer (I2C address 0x30) on a stop. The
segment write is thus lost when the next message (offset write at 0x50)
starts, and the sink returns segment 0 again: EDID blocks 2 and 3 read
back as blocks 0 and 1. On a Dell AW2723DF connected to an RTX 3070 Ti,
block 2 is its DisplayID extension with the only 2560x1440@240Hz
timing; the kernel saw a second copy of the base block instead, and the
highest mode offered was 2560x1440@144Hz. Windows reads the correct
block from the same monitor.

Forwarding the start with MOT set instead left the display without a
signal on the same system. NVIDIA's own DisplayPort library never sends
GSP-RM an address-only request with MOT: it writes the segment and the
offset as data requests with MOT and ends with a read without it. Do
the same and skip the start; the data requests carry the address and
MOT themselves, and the address-only stop that ends a transfer is still
sent as before.

Tested on an RTX 3070 Ti (GA104, GSP-RM 570.144) with the AW2723DF over
DisplayPort: the EDID read back now matches the one Windows reads byte
for byte, and 2560x1440@240Hz is among the probed modes.

Fixes: 9e9944449023 ("drm/nouveau/disp/r535: initial support")
Cc: stable@vger.kernel.org
Signed-off-by: Joe Finzel <joe@sudmix.de>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
index f5f22173fc2..13a27476875 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/disp.c
@@ -1072,6 +1072,20 @@ r535_dp_aux_xfer(struct nvkm_outp *outp, u8 type, u32 addr, u8 *data, u8 *psize)
 	int ret;
 	int retries;
 
+	/*
+	 * The DRM I2C-over-AUX helper starts each I2C message with an
+	 * address-only request with MOT set. GSP-RM is only ever given complete
+	 * requests (NVIDIA's DisplayPort library sends none of these), and
+	 * forwarding it as below, with MOT cleared, issues a stop: the sink then
+	 * resets the E-DDC segment pointer written just before, and EDID blocks
+	 * 2 and 3 read back as blocks 0 and 1. The data requests that follow
+	 * carry the address and MOT themselves, so the start can be skipped.
+	 */
+	if (!size &&
+	    NVDEF_TEST(type, NV0073_CTRL, DP_AUXCH_CMD, TYPE, ==, I2C) &&
+	    NVDEF_TEST(type, NV0073_CTRL, DP_AUXCH_CMD, I2C_MOT, ==, TRUE))
+		return 0; /* ACK */
+
 	for (retries = 0; retries < 3; ++retries) {
 		ctrl = nvkm_gsp_rm_ctrl_get(&disp->rm.objcom, NV0073_CTRL_CMD_DP_AUXCH_CTRL, sizeof(*ctrl));
 		if (IS_ERR(ctrl))

---
base-commit: fb26cf4f1df40a462ea65552a3fbcc8cfafab523
change-id: 20261021-nouveau-edid-segment-357805c19e7e

Best regards,
-- 
Joe Finzel <joe@sudmix.de>


