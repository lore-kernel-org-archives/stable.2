Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794286208;
	b=0oxThBg8d+eL0VxVCG740vLeylIOO+Ye8XOi2XFpUqDksMeKR3JlMytid6SrHE4+kZlL
	 c5BM2xgbiyrFMtA1+MKHf9+LBE17PpbnxMbcIyR8uIYE9/M8L5zCM+XKTplsQP+2Ky0SL
	 NdIgNyatliBkBg/uMQEdQTSTxzbrg2i4aC332Aqm3G8wnI2JGAa/2o/hnXudnubxCLhTv
	 8yxDOPWmgsMHIQmA0BJFdH0PN5x/7jeRsZTrDMK8++GEj/pqbxlNzPFrlBoYu9InkBK0+
	 gyYm6XAgi8Njatu7r1+zSWcB/4kVmzeBfRTfZOUgo2nuJayy92ul0CUAcVmMuQ7KDkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794286208;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6wLtuvSIpNUTm3DHIGBI0dzUv9bTvxWO66xfpE+Xaw8=;
	b=e6BV3oUv9jn6exASN6vKnduJlBQBdHK3dDDbyzunue4CTDugkOzsiaQmcisZ4tNhvy13
	 6ICvJs8IzM+iKVmP2CtOgnjJl4r78eYuJN/km3W68dSsQogeFXv8puWoOWrlo4wuNnwBs
	 17w7MIzaw1OXRaUeDJDKTj8WZmty9AXJRWt/bVKbYoDlg5WXc/hdZYav8EzyzV00C9MR6
	 rHbIBhkIroZDv9buvtEdCnWPYcqu2Tt95JHDeOY4SGNiF6e4yK48PxDdzj1zYBHzLCFs7
	 xUwhvi2+FbPpfnbzzG69YoJJeEQvEXcen4CM0cVFjMStsYdehqpwpV6GxwKMjdyea8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hazX3kq9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2222E606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hazX3kq9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E71A1F0089F;
	Tue, 10 Nov 2026 04:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794286207;
	bh=6wLtuvSIpNUTm3DHIGBI0dzUv9bTvxWO66xfpE+Xaw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hazX3kq9+tH0F1zBXEvZlSHlE3EUFgx45xrB++UEk2LYLkE2iVJOmAJ321Zji3QQc
	 pKeUNq1FgZbypRcNxxp5CKmzpe6hAijGp3pfMLDqM4oIaEeCeAVLan3B4idLCeA7t3
	 FauSx2Fd1VrGB28IrVscJd8Gw4fNGFjduSW/DEZTRyDxiYSjadbhCQY5VjNeSHFvEO
	 OPHsytGE/Z9g46F1f315/LvyP+W7Y0WJM74PtsUpxJ5TliYSQ31YxhcigkRAefg9YG
	 l6g0GV+BOAMOALA6k03A52PojjeVmuNDZZMIUiiaz74165PHy0iGvvn8+8ujWlNEjS
	 Hr23d+yoWVrlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: redrat3: Error path leaves device in transmitting state
Date: Mon,  9 Nov 2026 23:50:05 -0500
Message-ID: <20261110044954.245975-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061421-failed-5.10-8024d5e84531@kernel.org>
References: <20261107061421-failed-5.10-8024d5e84531@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sean Young <sean@mess.org>

[ Upstream commit 8024d5e84531d828535365718278f1cf0ce67db0 ]

In the allocation failure error path, the transmitting boolean is not
cleared. If this error path is followed the transmitter cannot be
used again until the device is replugged or the module reloaded.

Fix the error path by moving the assignment statement.

Remove the check for the transmitting state in transmit, since rc-core
ensures there is never a reentrant call to the driver transmit function;
the transmit function is always called with dev->lock held.

The transmitting boolean is only used for interpretting firmware errors.

Fixes: fac59136bc22 ("[media] RedRat3: Return directly after a failed kcalloc() in redrat3_transmit_ir()")"
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
Reviewed-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: adjusted allocation context for kcalloc() instead of kzalloc_objs() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/redrat3.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/media/rc/redrat3.c b/drivers/media/rc/redrat3.c
index 81dd6b9a938b7..4a1189676e551 100644
--- a/drivers/media/rc/redrat3.c
+++ b/drivers/media/rc/redrat3.c
@@ -773,17 +773,9 @@ static int redrat3_transmit_ir(struct rc_dev *rcdev, unsigned *txbuf,
 	u8 curlencheck = 0;
 	unsigned i, sendbuf_len;
 
-	if (rr3->transmitting) {
-		dev_warn(dev, "%s: transmitter already in use\n", __func__);
-		return -EAGAIN;
-	}
-
 	if (count > RR3_MAX_SIG_SIZE - RR3_TX_TRAILER_LEN)
 		return -EINVAL;
 
-	/* rr3 will disable rc detector on transmit */
-	rr3->transmitting = true;
-
 	sample_lens = kcalloc(RR3_DRIVER_MAXLENS,
 			      sizeof(*sample_lens),
 			      GFP_KERNEL);
@@ -796,6 +788,9 @@ static int redrat3_transmit_ir(struct rc_dev *rcdev, unsigned *txbuf,
 		goto out;
 	}
 
+	/* rr3 will disable rc detector on transmit */
+	rr3->transmitting = true;
+
 	for (i = 0; i < count; i++) {
 		cur_sample_len = redrat3_us_to_len(txbuf[i]);
 		if (cur_sample_len > 0xffff) {
-- 
2.53.0

