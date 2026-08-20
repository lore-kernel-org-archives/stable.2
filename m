Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DE93B9D95
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787222651; cv=none; b=izH8W91G7gUvPjRmUrEKH3CYOP9MNkFbVOS2GJpEhXeO0Bl0KWr8ChQJ68QhFpuel9tRYFInkY4r8yDHCROiB4atnLeVypmblRL4l0Jwqj9iWzKXIdXvI95Lc4Z9nRutduYMirYJJMACAHSCd6NX6I8SWDigO4DTL3QIE7x8xPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787222651; c=relaxed/simple;
	bh=Ja2HNoK7jw21fu6UXNi4rToX1F2eX88q1KXn21l5svk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ocgb8lYXKdCOQF8zaYH8Z+2Z1tsYEJoNFa5HEFDxrZIB+jUAPtLoqTJFBD4XhiO1otv6yrlGTyANoDpDytHRFTON2AgCIjmkh7zb/UZKMezI/5/hb8Vz3vG/RRQtFWRqbijCEJTcxaR0USvS7eF+znVfbDNzVYVScNwrJ4tTEec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XHrYZDo/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XHrYZDo/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248531F000E9;
	Thu, 20 Aug 2026 10:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787222650;
	bh=QRBfZNLjlDWz2Mnkofz2IlMO6T9RXZ26m7q/qqnFGg4=;
	h=Subject:To:Cc:From:Date;
	b=XHrYZDo/ujzV2mj4bofel9nssfdWSmUPXFb3eMb8G8/4gVXoav2GV8BAjZZ5IGP7A
	 96GzL6tTRUgen16VdzDu/t4KIqmDg4RxwxF9XJsaGqOIJ2oMceHJspcLO0AiKdkFfS
	 xqRaK9UoKF6s3Pzvni5AGU27sSeDWKwx5dcP/wHo=
Subject: FAILED: patch "[PATCH] ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in case of" failed to apply to 6.12-stable tree
To: peter.ujfalusi@linux.intel.com,broonie@kernel.org,kai.vehmanen@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 12:43:56 +0200
Message-ID: <2026082056-unfair-disdain-7c1c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 17661c67b206612cb3ba65d5ae726cd2015d0a53
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082056-unfair-disdain-7c1c@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 17661c67b206612cb3ba65d5ae726cd2015d0a53 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Date: Thu, 30 Jul 2026 14:23:43 +0300
Subject: [PATCH] ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in case of
 IPC timeout

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

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index fc3ead77e5ea..5929ecf6642e 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -528,7 +528,19 @@ static int sof_ipc4_trigger_pipelines(struct snd_soc_component *component,
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
@@ -560,14 +572,15 @@ static int sof_ipc4_trigger_pipelines(struct snd_soc_component *component,
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

