Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363508;
	b=1JNtzW4gyoKbyUuglDK+k/HrGx68zNEzgryTPOyq8D9LFv7fwG0VH5oSGCyHRwa0EFtu
	 Li2WDRFzWB3nk/rycJZfEovPaPbFxTLFulzp72sdXfTqA2/7ewDtw5vV/fZ4AC1wvC90f
	 gkNMB5kTD5X1QMHLIaIbXKOQzXz30nLn8Oad7FJr96L4oJywkKD2BD6k0nmbZ07xHam5r
	 Fcz1cq9hFayZ0dongry45csT9pTmbnfyVCpvtSLJqhZeHXppr/88VbLILNXzBuuji8u4T
	 45VSAmQF45cFxwvDbxkTiyac90Yr4xelWAP49QxaFuEeyPz/uv1e7riKrc9jqWXloKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363508;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Lv14CP/XLu6kXXLcgzHtdonvLMnL3WVdUyMkbCPaSLI=;
	b=h9RKPrpTHWfvYzhUAnRUsUJh01UEqT070OJf2297oBw3gzkGnobes3u0rqguY1CDiDuk
	 +AKLThWtGCUnkuFgHnbi5hp/TF4Y9oyfsMKOylLrhk9TK/Bewc6wxCZ3OJGHTvAI6PfOX
	 ox3sgGZGzyqZCBWRcL1OkgrNVUmc2JCx4iGC9jK3n8DfxHs1hgPi3GCCP5lAdXMHAWCN/
	 SMMdRH9qlSFDftBQuK5drDeCoEUC1eXExYRdCmPpwtUJ6gNYfHybQz2DWvx9d62zdPox+
	 luhKP8R5vfhZSK/YYV2J8VVJMpHnOVCadVbCw8s9o2LxtfetWi4gt/QyRvH7IqAHseg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eeWNLMEn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FF5606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eeWNLMEn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3BF1F0089F;
	Wed, 11 Nov 2026 02:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363508;
	bh=Lv14CP/XLu6kXXLcgzHtdonvLMnL3WVdUyMkbCPaSLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eeWNLMEnkyJvbyKjoqMkjeT2sRsUJS5GTVAP14yRhXew+wpJQGhiqrbh/+W1Ec6m+
	 tLylq4C2hzdYF9Xb8YhR1InkC/ijTxS3vtMuoL3kiqExYnoATgFvoDk+vbUTxmRWS0
	 4RUejbq0fAwxO29MNcZFtwxjEyY/Q7VafiJnT+2DKE9ojgqDG0w5+4bM9wh0D6CPXV
	 ocrEHDCIj2q6n4oxa3xGaaaztPTwSYOoKjNHFdzAJnPO/id4HKJrLt62dB3asi9zeX
	 8rTU8xkP67HkG1pxXZ8rOazkZAtdcxgiDjuCVOuqQmQQ8HiJDm1P9sd+APQekBdHQ4
	 viaWzfxBRQ6aA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] media: microchip-isc: do not touch WB registers when not streaming
Date: Tue, 10 Nov 2026 21:18:26 -0500
Message-ID: <20261111021754.581704-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061458-failed-5.10-d8983c47d4d9@kernel.org>
References: <20261107061458-failed-5.10-d8983c47d4d9@kernel.org>
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

From: Balakrishnan Sambath <balakrishnan.s@microchip.com>

[ Upstream commit d8983c47d4d95eb1ed889dbb7516d3738fa854d8 ]

isc_s_awb_ctrl() called isc_update_awb_ctrls() unconditionally, writing
the white balance registers even when the device is runtime suspended;
on many ARM platforms accessing the unclocked registers is an external
abort. The write was also done without awb_lock, racing isc_awb_work(),
which holds it so the DMA done IRQ cannot latch a half-updated pipeline.

Write the registers only while streaming and not stopping, under
awb_lock, and update the profile there. The isc->stop check covers the
window where isc_stop_streaming() has gated the clocks but vb2 still
reports streaming. Otherwise the new values stay cached and
isc_configure() programs them at the next stream start.

Fixes: 4e52889f48fe ("media: atmel: atmel-isc-base: expose white balance as v4l2 controls")
Cc: stable@vger.kernel.org
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: adjusted isc_s_awb_ctrl() context to accommodate the missing awb_mutex operations ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index fe3ec8d0eaee3..173d46dabc4e2 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -1938,19 +1938,23 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
 		if (ctrl->cluster[ISC_CTRL_GB_OFF]->is_new)
 			ctrls->offset[ISC_HIS_CFG_MODE_GB] = isc->gb_off_ctrl->val;
 
-		isc_update_awb_ctrls(isc);
+		if (vb2_is_streaming(&isc->vb2_vidq) && !isc->stop) {
+			unsigned long flags;
 
-		if (vb2_is_streaming(&isc->vb2_vidq)) {
 			/*
-			 * If we are streaming, we can update profile to
-			 * have the new settings in place.
+			 * awb_lock keeps the DMA done IRQ from latching a
+			 * partially written WB pipeline.
 			 */
+			spin_lock_irqsave(&isc->awb_lock, flags);
+			isc_update_awb_ctrls(isc);
+			spin_unlock_irqrestore(&isc->awb_lock, flags);
+
 			isc_update_profile(isc);
 		} else {
 			/*
-			 * The auto cluster will activate automatically this
-			 * control. This has to be deactivated when not
-			 * streaming.
+			 * Not streaming: keep the cached values for the next
+			 * stream start and deactivate the cluster-activated
+			 * do_white_balance button.
 			 */
 			v4l2_ctrl_activate(isc->do_wb_ctrl, false);
 		}
-- 
2.53.0

