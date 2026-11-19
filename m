Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795049302;
	b=hNDB3962G99fHF5mT9aswAwJhKb3dIR7rlaIVvh9LqAWXMi5FnOpUdQSgtKNrmBzDzbl
	 HL69ArHmWHtv95PCkXskA2UoYTbf+gAD36SDuhEfPLIq+HyUYEzSV+m54QIkPhwjQIiXp
	 2Fr1f7tXM3FcORxOa8WEnDNRDnmbDuTEkxopZPxOENier66QN+RVs5t57EVzLRG9sqImA
	 pO8+cFsU8nQXpi6F5jjC6y2rtCfnsxG9ppVake6VXfrqwNcjxG7Og4NF/I7tNmKrfb5Uq
	 XZMmr611oG2PA6IxCjbbKG/ATLPyHS6q4T5EH/lUESdBVzEC6St6/dorT03vQ/s/zZA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049302;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5Xh8yKRlhBfEpQNEhsMcynrEiq1Ep9eqggMSvfIFRus=;
	b=xS/DoBr+O6UsSuF0MP8ccqNjYw+TJSve7ThaK0BBuryvRFJ5YTtVZE3gklkx5fHo/e+S
	 d62bz6dNO2NTYAtYv27swd+bboJwgwvkWvS9yqUzVNS8wCRSChmim103QFutl0L/BNYoR
	 R2GYZECIUO4+wE2pn6yX/sTRFKa6Zbhiyp1I7oHCP4g5gOAvrASKVmgVtiWRpiLQvpVhR
	 jMJSMgOfqmCbKUkhai48udb0nSSIpBzQbICFqf+JewGYCXLz9tVkg6z5BfxVrhnaqfQb8
	 CzA5dmkqoL0JUS4i4AcMK8WbMEiQnu7PQ6SSmBX3XCxQHbkCO1RkYTrlIU2pW1C3cJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gupwqcAW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F6C606A33F;
	Thu, 19 Nov 2026 00:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gupwqcAW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795049302;
	b=zetupSLD8QCv2gM+YTgKRONi4DmoX0edZgXeQah7sgVBvigSbC1+JpDMe7hSkPlBBsCp
	 4WhkM/Um0V2P/4Df+5atr7NLrSHfPwEpbGDS4eRBB7/MvBmjHy2Is3oR5H2BhwWW2t5t+
	 PKEDFZsgzqH99Yl2c6Ti++AVyKfCMrejeJX6kXQ31jIzcFEHTlr6KG2L1GiaH4w7hXbG3
	 nN7w011FrHfX17Lydivu9lIOUJ0RHYq0wOu+8aLSR34vtcBWGyV+4r3jstNURiJd5EMGT
	 VIiE821vU9X5HpFee9fakvE3oA5pVKfPhexCn2h2TLXoJMbAahcrKjL57RXb1VqXvjg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795049302;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=5Xh8yKRlhBfEpQNEhsMcynrEiq1Ep9eqggMSvfIFRus=;
	b=HyFCGVXLiik0vt3odBsW+Kk1pue0INbX4TJAJVXNVEha+kuY6xt5K87dwZ3YLRY5i3b9
	 s/nAzzLunDPAFS+OEZi9y9gU8zQhhEFeutQPci8lJQQYnrBaY+P1ROI3VkQ3zk3W+8QIv
	 1cjjfNr9TPktnO6ytEJVgzsvhbKxecJAaWbB/7L9N8XqzUN8qxDU0uEReAFPFjhmHTlpj
	 G2Im3a93bbq6mxOlcEQE5jCEyiCQeU8Txzt11rOMbKVuP+gQjwN36gykbO2HGXJ1l4HzC
	 pL5gq0rDDIVevFtTn2lgnlr/qCnTIiaxx23p8PcTSV6stxi0r+wpPvMczH3GCfTxVKQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id AA6631F000C4;
	Thu, 19 Nov 2026 00:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795049302;
	bh=5Xh8yKRlhBfEpQNEhsMcynrEiq1Ep9eqggMSvfIFRus=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=gupwqcAWgdG4vpYWnZotfPHnC7siDyWnGUbiT/Ptt0Yj4WpkA7/ytlmq1r1gqJi9f
	 wrRCJXpHHtRmqrX3rldB+jFtBJFIvE6gY9HQgiMXEyLv1ij5FHzQ6Ho2YybUgfA424
	 j1e2A18z+4FzB713/IJw0o6ADWtBioYapfesJY2kJWdMXM+NHZNq+rpEn+J6JsFHYp
	 OZHK7EdayteJSUEfhx0sb67rueYqz9A/yQPbpNn20aXhp5QM4FoS4WN6aOCISOOMxi
	 GQHusZU17TToPuLQL68Gp1uMg3DYlF2ovOGGRzDCnJEfTu4wjD2wtiLfOen7bvqVF/
	 9UtmikDewnUtg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0B0454B053;
	Thu, 19 Nov 2026 00:48:21 +0000 (UTC)
From: =?utf-8?q?Alexandru_Andrie=C8=99_via_B4_Relay?= <devnull+alex.andries.aa.gmail.com@kernel.org>
Date: Thu, 19 Nov 2026 01:47:58 +0100
Subject: [PATCH] drm/msm/dpu: use single DSC encoder when slice_count is 1
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
Message-Id: <20261119-upstream-drm-msm-dpu-dsc-single-slice-v1-v1-1-4744ad5b9747@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQrCMBCF4auUWTtgirXWq4iLOBnrSBPDTFOE0
 rsbdfX4Nv9bwViFDc7NCsqLmLxShds1QA+fRkYJ1dDu26NzbsCSbVb2EYNGjFY3FwxGaJLGidE
 mIcbFYdf1RL6n4XQgqLmsfJf37+py/dvK7ck0f/uwbR/+4X6DjAAAAA==
X-Change-ID: 20261119-upstream-drm-msm-dpu-dsc-single-slice-v1-557cca7c984c
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, 
 =?utf-8?q?Alexandru_Andrie=C8=99?= <alex.andries.aa@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795049300; l=2415;
 i=alex.andries.aa@gmail.com; s=20261118; h=from:subject:message-id;
 bh=f5QJmSYrdCgoJ98DDgeJ718yQzeQFrq5DX9OKNMAinQ=;
 b=rXC2vTGceRQp0u2V8QoFCw7XfnzFKhnBDOn2ug/aufs/tPdEbAjHloh/v8jz8fV6yqUYOOnsT
 ZnHYpjgXT73D+qJA46bwgRoo3hvneMu/5Zh6S3+xMEJw2zW2w+qLN80
X-Developer-Key: i=alex.andries.aa@gmail.com; a=ed25519;
 pk=kNAqgavfB7uUd1mA8o8TszhGxzyqBwY71PGO/oK4v84=
X-Endpoint-Received: by B4 Relay for alex.andries.aa@gmail.com/20261118
 with auth_id=1564
X-Original-From: =?utf-8?q?Alexandru_Andrie=C8=99?= <alex.andries.aa@gmail.com>
Reply-To: alex.andries.aa@gmail.com
Content-Transfer-Encoding: 8bit

From: Alexandru Andrieș <alex.andries.aa@gmail.com>

dpu_encoder_update_topology() currently selects 2 DSC encoders whenever
catalog->dsc_count >= 2, even when the panel only uses a single DSC
slice (dsc->slice_count == 1).

A single slice cannot be split across two DSC encoders: merge mode
halves the per-encoder input width below slice_width and, on DPU 7.0+,
computes num_active_slice_per_enc = dsc->slice_count / 2 = 0 in
dpu_hw_dsc_config_1_2(), dividing by zero in
_dsc_calc_output_buf_max_addr().

Require dsc->slice_count >= 2 before selecting 2 DSC encoders on a
single interface so single-slice panels use 1 DSC encoder.

Fixes: b6090ffb30f3 ("drm/msm/dpu: Fall back to a single DSC encoder (1:1:1) on small SoCs")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Andrieș <alex.andries.aa@gmail.com>
---
Testing:
- Tested on a Xiaomi MIX 4 (SM8350, DPU 7.0) with a 1080x2400@120Hz
  single-DSI single-slice DSC panel; dual-DSI topologies were not
  hardware-tested.

AI disclosure:
- Debugged and drafted with assistance from Gemini 4 Carbon
  (Antigravity), and reviewed and tested on hardware by the submitter.
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 0a6be69a3e83..ffccee6b41f1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -680,13 +680,14 @@ void dpu_encoder_update_topology(struct drm_encoder *drm_enc,
 		/*
 		 * Use 2 DSC encoders, 2 layer mixers and 1 or 2 interfaces
 		 * when Display Stream Compression (DSC) is enabled,
-		 * and when enough DSC blocks are available.
+		 * and when enough DSC blocks and slices are available.
 		 * This is power-optimal and can drive up to (including) 4k
 		 * screens.
 		 */
 		WARN(topology->num_intf > 2,
 		     "DSC topology cannot support more than 2 interfaces\n");
-		if (topology->num_intf >= 2 || dpu_kms->catalog->dsc_count >= 2)
+		if (topology->num_intf >= 2 ||
+		    (dpu_kms->catalog->dsc_count >= 2 && dsc->slice_count >= 2))
 			topology->num_dsc = 2;
 		else
 			topology->num_dsc = 1;

---
base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
change-id: 20261119-upstream-drm-msm-dpu-dsc-single-slice-v1-557cca7c984c

Best regards,
--  
Alexandru Andrieș <alex.andries.aa@gmail.com>


