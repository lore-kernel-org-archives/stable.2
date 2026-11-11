Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362875;
	b=OaMrcRwwwBYhtr3ZXw77l+I/N9epwvIPIV5cf+YirnZATbBPOFY7Rlg9coudbQ2JdJT7
	 ffxRsULo2ZF32SFIymDyfH4UuMIFQveAaCn6eY9IncuVzAwcHDGmRRQxEB4oUnREzPGu8
	 ElDw2CaSLLXVoItNgVR3Xuvfx/a+kdYsaARbhebWuiY5yXXb6S4rzNVdo7wHxWBr5IK8l
	 sCjXnQqI7yKCml0mDVAFQRpZeD426hvTn3ECpyqpbKMlxNYpJh6FPBUC7Lzq65mrAEZdn
	 1YJp3h58pZiEiXH9oK8PMI50evuky0RQAijbApwNI1lS610+i2Pi6tG5ydWo8iJYJQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362875;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EQnxXiLJSaGBuehV5g3jLOh0vg7FsSp7kbqitemc1ww=;
	b=XzdKGsF1Am38uunHDJP3l1JOgdqJQeCicb2LPLKqW15BLZ8oOPKUll+unjR/ohDzv/r/
	 1NA6USGzcSrEb9N59E1vSCgrx97CjI3GsWkZPcI9wH3PgajTXtKnLisfW8Vr5ZvXMM6GL
	 WK0d4K0U24dGzFDgExttUTWys5PxR9lNdci8qq7+s2KgizeZSm81P5Cp8rvWjy2U4p9If
	 IL6CEcojWYOwBYCC136Dx0CoChO4FypExYjk9/O/fOamqzPDAXn8CBiZmG4hKk8PWTiy9
	 aw9MUBf26r4cWWjM4t3wKNqEyYjEeOXH8NzoaK5fz0iAwJiCCwKTx3HfFI/YdQuSTWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cV4rIIKE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF345606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cV4rIIKE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E31D1F0089F;
	Wed, 11 Nov 2026 02:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362874;
	bh=EQnxXiLJSaGBuehV5g3jLOh0vg7FsSp7kbqitemc1ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cV4rIIKEYTd66FXAzTeEeOB9xFtONJiKFLsQOO2t8Rujt5FRy+CPHgaFgzIkvZxMP
	 ba4QSpLavJ2z0vneZXXS7JkYgJiZZAytvWjOX9byVghPfuw+/OBcddlYmWJ8EEXex4
	 aSDVj2tFVw81I/dmxPPj2gxQ7E5Yi/y+yn4whpmqls86zwOHMV4qD5jVqiEISyKrqb
	 aDlVaJl1ueGb8v28krrS9v5HKndDSvxLEkY3N/rakBjGI5LViIGoq0ZQk9JepBGwq6
	 lluA0LoRexLyFHGXXbuLSLe3Jz3ChG+lWp1XvRsiWenXGaQufE/T5ihu3yrx3b6fVG
	 qyG3pm1MbKoTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] media: microchip-isc: do not touch WB registers when not streaming
Date: Tue, 10 Nov 2026 21:07:51 -0500
Message-ID: <20261111020626.487609-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111020626.487609-1-sashal@kernel.org>
References: <20261107055759-failed-5.15-d8983c47d4d9@kernel.org>
 <20261111020626.487609-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/atmel/atmel-isc-base.c | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/atmel/atmel-isc-base.c b/drivers/media/platform/atmel/atmel-isc-base.c
index 565719fda13c3..dc12424965f3e 100644
--- a/drivers/media/platform/atmel/atmel-isc-base.c
+++ b/drivers/media/platform/atmel/atmel-isc-base.c
@@ -1843,20 +1843,24 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
 		if (ctrl->cluster[ISC_CTRL_GB_OFF]->is_new)
 			ctrls->offset[ISC_HIS_CFG_MODE_GB] = isc->gb_off_ctrl->val;
 
-		isc_update_awb_ctrls(isc);
-
 		mutex_lock(&isc->awb_mutex);
-		if (vb2_is_streaming(&isc->vb2_vidq)) {
+		if (vb2_is_streaming(&isc->vb2_vidq) && !isc->stop) {
+			unsigned long flags;
+
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

