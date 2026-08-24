Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8991C3909A5
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787609168; cv=none; b=D2/EIpN3WWz5ZaqQT1rxDhNjEB4R4LAvh56MfcIkSzuHRNgOz78QsA+Y4puvVmrqmjt4QtPuupwo9i5qFafaf05wJ2ZYh0keiI2cGk9fBEC8XhJLGLC9175ZFeAmj2ampgAA5fGx2SmYIQMAxX7Sx6sG+XVPecItPutxWuXohjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787609168; c=relaxed/simple;
	bh=d9VcmYB7dh5lDE7xZ1Slk6k2MqXH9iS8ZGWEy9/3Cfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=soMh98oIlw48siP3A6mRw4SgTaO7wWrnsu7p0Ee7Gz8x+OdKQZpOmWRFszrMol9Zo/npTnJcOTPsT32kmgmSPBYR6vVU2CxWxKCJueDkInMYTASX5VJf9P7kKTrhDnO0p6dEnWN4qlnnOrX0qFoPevGP4v6X/xUURQXfZ9ePnrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/FKP4AY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c/FKP4AY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCCE01F00AC4;
	Mon, 24 Aug 2026 22:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787609167;
	bh=MCC34HIFrrrCXYd0ICL+q7+sR11qLX2X+GPP8A0v2VI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c/FKP4AYJ4rn+xXmbPm/nOpO4s56pOMO0U6wYgLDka24c0JnRcnTj65h61g168OfX
	 uKz6GpceOFioSgPc4mknOQL0UVj6eWPdv+OZrxvtJVIUWrMymcFNGGB1WxCOX+xBu1
	 MYycmYS1LtvadMpQMynEayTPBOkv3AlSBKgRC/l5n3tbmo2oa8GREpCTb4Nm0feKaQ
	 tuIhTcyNcesXUcX0Cnorz3LTUpczg2dE2A4WNMtmObAxTEM04PstfIjs8Y+i4w3Woe
	 PXLwRiGDo2JSP0eSLgq1hriZL1wu5yzPmkq+uiav+TzgQ9DpsZtKC1+z18JE5lEvIf
	 l4YKcukrCVoLw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 5/5] ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in case of IPC timeout
Date: Mon, 24 Aug 2026 18:06:01 -0400
Message-ID: <20260824220601.440874-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824220601.440874-1-sashal@kernel.org>
References: <2026082057-slush-president-f8ca@gregkh>
 <20260824220601.440874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 17661c67b206612cb3ba65d5ae726cd2015d0a53 ]

Ignore IPC errors for pipeline state change if the firmware state is
crashed or the IPC has timed out.

If the firmware has crashed the kernel still needs to go through the state
changes to reset its internal to be able to correctly work the next time
the DSP is booted up.

The case with IPC timeout is a bit more problematic, but it has been
rootcaused to be the result of system scheduling blockage and the firmware
did actually received and handled the message, but the reply handling got
blocked by issues outside of the SOF stack.
So far the best way to handle this is to continue with setting the state.

Fixes: c40aad7c81e5 ("ASoC: SOF: ipc4-pcm: Workaround for crashed firmware on system suspend")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://patch.msgid.link/20260730112343.26687-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-pcm.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 75ba227cd4404..9547437103e5d 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -359,7 +359,19 @@ static int sof_ipc4_trigger_pipelines(struct snd_soc_component *component,
 	ret = sof_ipc4_set_multi_pipeline_state(sdev, SOF_IPC4_PIPE_PAUSED, trigger_list);
 	if (ret < 0) {
 		spcm_err(spcm, substream->stream, "failed to pause all pipelines\n");
-		goto free;
+		/*
+		 * workaround: if the firmware is crashed or the IPC timed out
+		 * while setting the pipeline state we must ignore the error
+		 * code and proceed to set adjust the local pipeline states.
+		 *
+		 * If the firmware is crashed we will not send IPC messages
+		 * and we are going to see errors printed, but the state of the
+		 * widgets will be correct for the next boot.
+		 */
+		if (sdev->fw_state != SOF_FW_CRASHED && ret != -ETIMEDOUT)
+			goto free;
+
+		ret = 0;
 	}
 
 	/* update PAUSED state for all pipelines just triggered */
@@ -380,14 +392,15 @@ static int sof_ipc4_trigger_pipelines(struct snd_soc_component *component,
 			 "failed to set final state %d for all pipelines\n",
 			 state);
 		/*
-		 * workaround: if the firmware is crashed while setting the
-		 * pipelines to reset state we must ignore the error code and
-		 * reset it to 0.
-		 * Since the firmware is crashed we will not send IPC messages
+		 * workaround: if the firmware is crashed or the IPC timed out
+		 * while setting the pipeline state we must ignore the error
+		 * code and proceed to set adjust the local pipeline states.
+		 *
+		 * If the firmware is crashed we will not send IPC messages
 		 * and we are going to see errors printed, but the state of the
 		 * widgets will be correct for the next boot.
 		 */
-		if (sdev->fw_state != SOF_FW_CRASHED || state != SOF_IPC4_PIPE_RESET)
+		if (sdev->fw_state != SOF_FW_CRASHED && ret != -ETIMEDOUT)
 			goto free;
 
 		ret = 0;
-- 
2.53.0

