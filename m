Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593169;
	b=sY8B1OEG369hBiEXfTbfEErFpI39NtB7ZH3H+da4MOlorLvxCeNSI3C7XnfW9QmSqA4c
	 5tuUEPYHVI1Ewyz+ibChEQr+VyYXEBq4U7Egeuo88R3itVpNNnWcZUVI9SZmw/o3sV3lu
	 Cyn2UT7iAAHEbheHVoKwq4synA/eQAnUwiQYzQdTh4xScOZUMarYOmibfhzWU7myNVS2w
	 ZkMkIjm5nXSRus2EH+XQT1P9nUjcad2e9pApgpm25bZrooXY/Kr/afv7ZJoJVv4nT3nrm
	 BqwvO8kGi0bWsbdCirYJntOyHewFYK3b1dSXXAWnZh8KtFRkaCDX6cqyP29OD515grA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593169;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pXDq34cOsmlgeBNN90p6HFHEks2biEctWRbMB+K/ok0=;
	b=l9uqiGOTlmm8kj2fH4j62NizzdCIfXQJpVhT9p6Niv6nBqIffc+tJxPexWOBOnI0mvru
	 WkjWzaQ6uXHf6cX603r5G5I3fAh4iSkVsEAmSBF4ZF8Ep3mfg3gjoCEo5ykaaPWVZG2Eo
	 fpA+bhjYANwHJcB//wNZtdX1dvDgb1ufdAZqoObxPho+FnP/HEGTMay/hM39Y7jQSMCrf
	 wlEdRqMRTOO0mn/5ICkbP6A4kC1UPIc+VaX448AZxRi+SinBY2ESiuxvS58dnreACcGmI
	 OBuCpdPQCfUa8DIlFVHylRPpD8yrW1fLGy2PnG9DmtqYrxsE+vtuY20eJy/WD+gCO1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YgEhFz9E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E50606A325
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YgEhFz9E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D901F000C4;
	Wed, 21 Oct 2026 14:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792593168;
	bh=pXDq34cOsmlgeBNN90p6HFHEks2biEctWRbMB+K/ok0=;
	h=Subject:To:Cc:From:Date;
	b=YgEhFz9EEbEdGgjXfDj4JTxlor4IA2sOapDQfhwQAWh/YBQDcOgrHhed7rFytYxNU
	 WTQjTvNb7MPpIe+J1V67QR3nPLNIhghmA7bgaEj6tjEBFRZlD17Dozvp/9SZckssTp
	 fBKaAR4Me8TBaMsdSK6986Ofq5M6DcjlC6/QLWGY=
Subject: FAILED: patch "[PATCH] ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for" failed to apply to 6.12-stable tree
To: peter.ujfalusi@linux.intel.com,broonie@kernel.org,yung-chuan.liao@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:32:25 +0200
Message-ID: <2026102125-trapeze-unfailing-89cd@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x 746de48c3a250f0c264105dcbfcdf0c5001e970b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102125-trapeze-unfailing-89cd@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 746de48c3a250f0c264105dcbfcdf0c5001e970b Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Date: Thu, 8 Oct 2026 12:01:30 +0300
Subject: [PATCH] ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for
 aggregated ALH capture

When ch_count is smaller than blob->alh_cfg.device_count (e.g. a mono
capture stream, such as a SmartMic, aggregated across multiple SDW
links), step = ch_count / blob->alh_cfg.device_count truncates to 0.
The subsequent GENMASK(step - 1, 0) then underflows step - 1 (u32) to
UINT_MAX, causing GENMASK()'s internal shift to use an out-of-bounds
exponent:

  UBSAN: shift-out-of-bounds in sound/soc/sof/ipc4-topology.c:2363:13
  shift exponent 18446744069414584384 is too large for 64-bit type 'long unsigned int'

Treat ch_count < device_count the same way as the existing "channels
equal to output reference channels" case: apply the same ch_mask to
every aggregated device instead of trying to split channels that
can't be evenly divided.

Fixes: 0390a102cc18 ("ASoC: SOF: ipc4-topology: use different channel mask for each sdw amp feedback")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20261008090130.15135-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 24a1175dd690..22c15fbb93f2 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2458,11 +2458,14 @@ _sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 				ch_map >>= 4;
 			}
 
-			if (swidget->id == snd_soc_dapm_dai_in && ch_count == out_ref_channels) {
+			if ((swidget->id == snd_soc_dapm_dai_in && ch_count == out_ref_channels) ||
+			    ch_count < blob->alh_cfg.device_count) {
 				/*
 				 * For playback DAI widgets where the channel number is equal to
-				 * the output reference channels, set the step = 0 to ensure all
-				 * the ch_mask is applied to all alh mappings.
+				 * the output reference channels, or when there are fewer
+				 * channels than aggregated devices (e.g. a mono capture
+				 * stream split across multiple links), set step = 0 to
+				 * ensure all the ch_mask is applied to all alh mappings.
 				 */
 				mask = ch_mask;
 				step = 0;

