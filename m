Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795825920;
	b=F7jc6bA+C3OZ2GaJNAmYTnM9ARt/w6GWjVgz5HsyngmDofbkBtxufGGCL6T8UO2b0qX3
	 2af0AF/g73LAqsyFER3vC9Lg5wEfFyUUKRMO/wWn/4O8uC0QBj2qgrBe1T+kBif9gvl5C
	 buG7MLXHtOhfmUphPfO6NZoNJCWgyIXoeBQccBujiAyQZzE/n08IpSTjZBawHLZA2o5E3
	 KbvSiVwJ//G1YxhbFEiA0l4vlZFaq2DWx/iCpKgZ5q0SfZv0Gn9JJ4FpK7x9QFeuLTu1Y
	 5Ao3iL3cX0hvOOQvxCtVa86Fv0pzWvWNGO70tMoJ7+drIT5l0x6Jq2IBhq7DaXduheg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795825920;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=A4LVjkTnpkyF5klIB/NNrOOh7DHYEeRfyp9lDj+74Og=;
	b=qFcLuZGMX/4lGGG6g532uDy47S+lS9f6NBoSiMVubmlw5pnO94W0KwFyNnZN/7o88zZE
	 zXTlSZPkrJ9WRUd5NR6MZg07era6sGYOwzHO9ExAGkpHhq6rd13oS34HX/U+EBaNovrYi
	 nSvm4UdxLAgs0Pfyui0jskbtw23CBmrDWERIEvLJAmKNytY8YrpiG266K/uYfZgGouIpX
	 OPQtl751WF+p92VphzFJ1UQwef7wgNZNGILdWdoC5aPAwqcZG8GJYLfRSQJh5svBw/kfA
	 zq+LW52OPQuPFSdexZwGmOddHAcyADCSb7fsp4zoAQncacNknINqD07EoRq3S8Ke+IA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AsPetNWL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD3A606A31C;
	Sat, 28 Nov 2026 00:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AsPetNWL
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795825919;
	b=e7gkghA+LqbaSmAKZBuYsiiYPnHncXNAKJ5tTERESuI260PIBHsqQTKQZbVQj75MSKIi
	 uD6shptzXVMGgdBsdFMrmCDv8CdF80ZfG0yRN30dHwp1N8He6Eb/DIxsChtTBlybn0Od4
	 YesS6KnhTRdftY000ot+8BAq5Fo1o5D/bwp4dUMfn+4Ie5nA9UFDYyhg1U7KzwKxYKX4B
	 4yJC+H/KqQuzuXixOfQXJJs7KNkqD7gV0NZ5Koqd4CDObn8ZhpTA3mUgsEBOfRee+5koq
	 Ii1utOoBaTCyguNBdz15H+XIUdOWPDt+SmD571RAsKfu+uXEYxzcsHIhkIP0uAz9rtA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795825919;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=A4LVjkTnpkyF5klIB/NNrOOh7DHYEeRfyp9lDj+74Og=;
	b=i+yMb09Ez7r5musSFH6tE9B6AoQov1Ko+VlfshWJTSs89GyRvvmE++lah2xCq/dEXu1C
	 ZKsufdi+NLoO0QmUXK+1HPPX/Y0B/JOm++63oDd9aUiyORFJ1DfHQR7D+3Nnqh1oW8Ifo
	 c/Kg6kzuStFEnmBSNCU5JCtoMhAxgWsZ1UhIL2YF6MBt/rq0hheyR7a1JSRLimypuQewa
	 14ylwpJHCKTX9Ejo3XhAaEkSyySjfuA/Oj1GiJVKDX7VKpTloHaFVOWPxF9GKzcuw1zx+
	 KTVfUVJcIQ1H+GxgwQWUaCBTIFz5mlRlKw+bHTHcs8uXZ8suc3mCG5UvMIqRQbUD0QQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5B21C1F000C1;
	Sat, 28 Nov 2026 00:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795825919;
	bh=A4LVjkTnpkyF5klIB/NNrOOh7DHYEeRfyp9lDj+74Og=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=AsPetNWLG14jQKA0/tSWWM2jnBVzQE+uUyDzygTgZ+nn0UL3+0o5CRo0FoI3/ZhOi
	 CMOwky4/Qxf7svJ3k4n8z7qsywTVx2jZMFJ+xNOnMR8PnzBTOMSarNW3+GXgm8+xko
	 9CuUl4nV0gOTn9R3/ejZEf38QDl5j8oKNIcriq3DfezXaQfssXWpAx4DUSj+GU9ENI
	 xGfSdCtxGOEpe/PVRYCEyrlVrktmVOnmHShEwTJmZPUc5hiW2o9uGNqirDDe59+u2S
	 85bz0Ja8SiZkWuaBEh/4TRGd/8j6GV+7ecY2fszZMLzvI0SH2KMoTlwOkMiBLSMpSf
	 k5i393u91GHuA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D0F4C4DEB5;
	Sat, 28 Nov 2026 00:31:58 +0000 (UTC)
From: =?utf-8?q?Petr_Krac=C3=ADk_via_B4_Relay?= <devnull+petrkr.petrkr.net@kernel.org>
Date: Sat, 28 Nov 2026 01:31:53 +0100
Subject: [PATCH] media: i2c: imx415: Use the new VBLANK value for SHR0
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
Message-Id: <20261128-imx415-vblank-fix-v1-1-0878e9928fd6@petrkr.net>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQyML3czcChNDU92ypJzEvGzdtMwKXWOjFAvjRBPjlEQTMyWgvoKiVKA
 w2MzoWAi/uDQpKzW5BGSQUm0tAKoNT511AAAA
X-Change-ID: 20261128-imx415-vblank-fix-32d83a43da46
To: Michael Riesch <michael.riesch@collabora.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, =?utf-8?q?Petr_Krac=C3=ADk?= <petrkr@petrkr.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2315; i=petrkr@petrkr.net;
 h=from:subject:message-id;
 bh=YzHOjfOlYrYJXjwaPQuJDeigg1JsB6+2ebe+BLz+vpg=;
 b=owGbwMvMwCGcmL3AsYG1kZfxtFoSQzaXwl8hq411cRNXLw24ceZYpLh6g9ul/kfChrwHDjwOu
 /TVMUmgo5SFQZiDQVZMkWXbDs1pu7qc58++XmMEM4eVCWQIAxenAEykPYXhr/yTvP4PSUdXCTxw
 cyh5U5eTGLn999OX5tF+gTMqs1L0fjH8r3zx/gGT2rI3pj/EEg8JsV3xD9ugm6owzXD1xHsfw3b
 eFgUA
X-Developer-Key: i=petrkr@petrkr.net; a=openpgp;
 fpr=B6B82996BA8A439F9BD77C32616BA0418005810D
X-Endpoint-Received: by B4 Relay for petrkr@petrkr.net/default with
 auth_id=1672
X-Original-From: =?utf-8?q?Petr_Krac=C3=ADk?= <petrkr@petrkr.net>
Reply-To: petrkr@petrkr.net
Content-Transfer-Encoding: 8bit

From: Petr Kracík <petrkr@petrkr.net>

When V4L2_CID_VBLANK is set, imx415_s_ctrl() writes the new VMAX and then
falls through to the exposure case to program SHR0 = VMAX - exposure.
The exposure case computes VMAX from sensor->vblank->cur.val, which still
holds the old value at this point, because the control core updates
cur.val only after s_ctrl() has returned. SHR0 is therefore calculated
for the previous frame length. If the exposure control is not written
afterwards, SHR0 stays wrong and the actual exposure differs from the
requested one (for example when the frame rate is changed).

Take the VBLANK value from the control being set instead.

Fixes: 3bcae55ab96a ("media: i2c: imx415: Add read/write control of VBLANK")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Petr Kracík <petrkr@petrkr.net>
---
 drivers/media/i2c/imx415.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/imx415.c b/drivers/media/i2c/imx415.c
index 7bb27bdf1446..282dc0c3e021 100644
--- a/drivers/media/i2c/imx415.c
+++ b/drivers/media/i2c/imx415.c
@@ -697,6 +697,7 @@ static int imx415_s_ctrl(struct v4l2_ctrl *ctrl)
 	struct v4l2_subdev_state *state;
 	u32 exposure_max;
 	unsigned int vmax;
+	unsigned int vblank;
 	unsigned int flip;
 	int ret;
 
@@ -715,10 +716,14 @@ static int imx415_s_ctrl(struct v4l2_ctrl *ctrl)
 	if (!pm_runtime_get_if_in_use(sensor->dev))
 		return 0;
 
+	vblank = sensor->vblank->cur.val;
+
 	switch (ctrl->id) {
 	case V4L2_CID_VBLANK:
+		/* cur.val is updated only after s_ctrl returns */
+		vblank = ctrl->val;
 		ret = cci_write(sensor->regmap, IMX415_VMAX,
-				format->height + ctrl->val, NULL);
+				format->height + vblank, NULL);
 		if (ret)
 			break;
 		/*
@@ -729,7 +734,7 @@ static int imx415_s_ctrl(struct v4l2_ctrl *ctrl)
 		fallthrough;
 	case V4L2_CID_EXPOSURE:
 		/* clamp the exposure value to VMAX. */
-		vmax = format->height + sensor->vblank->cur.val;
+		vmax = format->height + vblank;
 		ctrl->val = min_t(int, ctrl->val, vmax);
 		ret = cci_write(sensor->regmap, IMX415_SHR0,
 				vmax - ctrl->val, NULL);

---
base-commit: 97d73c8251226cf27cc6656b4c542869bb8c69fa
change-id: 20261128-imx415-vblank-fix-32d83a43da46

Best regards,
--  
Petr Kracík <petrkr@petrkr.net>


