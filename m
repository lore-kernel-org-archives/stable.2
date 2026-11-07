Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050101;
	b=QT08ilGrIRNSnafzBGLwN2xlWTzKfRjKJ3gpknuh8wN+gONMiGL95DDOtUa4IU6GkDz+
	 TfeWN6PpIhPApjYDOG/d2Rak6Hk15V2Goj9LHcPw4FSl/BcGwbBAZj9+1wvrCKv2/hlQb
	 BHiY9BJ6OviQT7FP4asUELuPAQ/Ug46PxgrXGMT87Uuz2B0bHUy+Svv55b0OjN//ab3I3
	 mh2F6RvEtElpdHBAKS4kDYu8LPtmS3BlaU//2BT3ZT22MM+esEjwf8p6gtUBiFJZL7TC4
	 t8g2fEINccfSeAkeHxdKcLlBtZxcVDLGSK8yxpSx6n9tOtZlpZgwAnpNCwvXiQ9DtUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050101;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KGtaHWdvEK2nUy7BGV1y0TU5uZ+wosBBYMNao82IpGw=;
	b=yuYUAcgfFYAW2EHvhWxHjf4QDMwOGwqFAxakrJkkFI0YXvI0L783QNrzO3Q+zlQPB095
	 CzpAOedOmOwXsyWqoQf9Bh5fcNYzIbt+XwAFC3I573xPhifM3REq2fjlmRmVGMc6DRmnc
	 7NTFBWxluHXxoretbQogeYkgv9csTpWTIA5lIBGwEw9ZavGAjB/ywDazBwm9bOG8g4ZAT
	 fwU/NB2gmRZiBE7tVAusNZliF6GSju4Hkv4VQY4YSbyprn0fDWcl/KkQDwz0VveCIoLgp
	 uHjSiLW8SkiAbDaGBJMPHJ8XyYfwvWcyfLq7a4CyfD/wCU1CSC4GShgZ3J5htGKMkLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcuzJP2t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BE2606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcuzJP2t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EE41F0089F;
	Sat,  7 Nov 2026 11:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050101;
	bh=KGtaHWdvEK2nUy7BGV1y0TU5uZ+wosBBYMNao82IpGw=;
	h=From:To:Cc:Subject:Date;
	b=bcuzJP2tB2wourtJl2FO4ssjC/h80iH+wW+cmdw9p33i8msgeXN2Qz1bugag8k4xS
	 6eQXnZlq+Jh8EREDPShR/OCJ7wPaQocreiXBGjXPBIc6jSIYxTDs4LYaLPlzf8hYOM
	 YvepqwdDw9Kzm7f+K1a5MzHeXq3yRbUCpwNqAf1XixnhPHxtATst+D7SSeEGPIIySR
	 KEq77B0bmDppd4PcX6yibb44K6MlsCOvm2RDrTFl1s69Z2k4sFTNw2bHey3qqQKu2O
	 Y0TOO6xe8IQaj6ykzrBGUspqyjD6dYonuDVICLnpzK3XnaILm4AeX2EHWw4LTWmzrG
	 GfO4/fSIxsroQ==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: do not touch WB registers when not streaming" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:14:58 -0500
Message-ID: <20261107061458-failed-5.10-d8983c47d4d9@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d8983c47d4d95eb1ed889dbb7516d3738fa854d8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061458-failed-5.10-d8983c47d4d9@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d8983c47d4d95eb1ed889dbb7516d3738fa854d8 Mon Sep 17 00:00:00 2001
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 17 Aug 2026 12:22:02 +0530
Subject: [PATCH] media: microchip-isc: do not touch WB registers when not
 streaming

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
---
 .../platform/microchip/microchip-isc-base.c   | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-isc-base.c b/drivers/media/platform/microchip/microchip-isc-base.c
index 0f486dd5bd82c..cf4611443fd13 100644
--- a/drivers/media/platform/microchip/microchip-isc-base.c
+++ b/drivers/media/platform/microchip/microchip-isc-base.c
@@ -1511,20 +1511,24 @@ static int isc_s_awb_ctrl(struct v4l2_ctrl *ctrl)
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




