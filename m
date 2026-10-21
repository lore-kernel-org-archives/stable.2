Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593172;
	b=QuQJ26BMblPUT+SnEbDcmGMTcbyWKqxMNmlmg8rNG6p5iEVH7rV0UWVp8mTzf0f0yYOV
	 qNuWRBXjNw3oDr2d/f4p8bmTKf0uMbN1LZGO8gUEp+81Ez2Sf/Ras/S+fm1Q3b3fBq2Xk
	 Ovdd4hx78HuY+p6nCwcg7Z4tC9V7E1D354kJbxOsGELyRJ0m5yJKqHtmcxCR5708aReZn
	 w+K30Tx/+jR8uWH0Zo8ey1BOEW8xye3H2nPGabUERgN3KFOgOfxdHt95e5v8FbTM+BRRO
	 zb9OqRAhquotG93u3GOqmxs8CkCvO5EltH4Tfoa+nsJFq2CqwDauEsHpNvWH36RbIhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593172;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=K8KxEj+5VC7eE/qNwbnMETj/0dj4LGxJD4TQcB0vuGA=;
	b=LHdr+tsf/jgV73h7mg96E5UZtQJoAsRaTEBuQh2UeW6qh3tZRX5y5lb9b/2TPZiEbgFr
	 ZU47bYnQnVjnBvbCzAOiseeLC1lJOQMaktpSggNUyFa3XCaoTkHuIvEer8fUiBfDP0a+r
	 2h5yCkp+Xu5tLpCp0hrPXCfYl05RjjX726eWZVIppnCb1NX/fGPTBsQEyA78Y7LE/2RET
	 04jobhH068YXnObLIay89RXPGlqyH38M5zLFJzF1oAb6y2B29puacZAUNlkJzzG4uY+Bk
	 zrM9f7uQNrlLBi3tylphtPZltgiNIzqplaih7ERhxlCl9YIZYksKGuwwciDOMM9t34Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KGbWGbfC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C05606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 14:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KGbWGbfC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A211F000C4;
	Wed, 21 Oct 2026 14:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792593171;
	bh=K8KxEj+5VC7eE/qNwbnMETj/0dj4LGxJD4TQcB0vuGA=;
	h=Subject:To:Cc:From:Date;
	b=KGbWGbfCMPpqT7fOomzdo4yYcR65Cd3X6xiG+iz8/16IAZz/CicgbbE8fLCkBUj+c
	 JOI/CZBBSfwubGNAuJrBtmWhLmN9/LKDNZrMA7EkYA2tBk0zlqSInJLcVwB4SoW3JZ
	 DMpNccoT6MLcZWa0NF+Msn8LztEv7J61a2ZJvWZY=
Subject: FAILED: patch "[PATCH] ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for" failed to apply to 6.6-stable tree
To: peter.ujfalusi@linux.intel.com,broonie@kernel.org,yung-chuan.liao@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 21 Oct 2026 16:32:25 +0200
Message-ID: <2026102125-stole-applied-92e5@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 746de48c3a250f0c264105dcbfcdf0c5001e970b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026102125-stole-applied-92e5@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

