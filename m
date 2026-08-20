Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F43D401A06
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223982; cv=none; b=AmvgO9QgJNKX5LxHYdzM8Py9LruDfM9Q6EiLxiuT78SexyaOLcrG3M8LcEEcHyXfLeyYASuSbSeZrbb9YOqmjXl3yGJ5reVCyvXsFmMlX/KIDWOQpvqYkls7C5VKxhCM9EooF++RgGEkCglsD/pHe2cfI6yh0zA+otwarNEZ5RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223982; c=relaxed/simple;
	bh=jU3bdQiUISEANuyH/z8UXvzz01vtbkS61UDHF0eOfQ4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AUfx/XrlNcTVQzEH5lP+5Rfri9vW48MwBn3q1YX/1QeLqP3SsachjXLLpD3DeUScz+YJtWizaacqmm0aMs9Ymbv4XlBL3Vv+07YiPVcWDdNTyXxAHAQX4U/7J4BonQLyg/4xZhqGEe7MLdo09BJn2xe9XSnc1rW3G6ejoEbzenE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vhIHjjWI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vhIHjjWI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E622D1F000E9;
	Thu, 20 Aug 2026 11:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787223980;
	bh=+1bSi+peRd5GFzknIZuCGA02G2HIN5SnHSONW3miVXQ=;
	h=Subject:To:Cc:From:Date;
	b=vhIHjjWIcDcrz/lDLafiGWX85vBtCWD4z0pA4oGTD1tucjkyNHfg6IqFEuvbELTqR
	 VfpO6/By74b5YFYD9RlDLYiay6OsVed8YMj7D1/uVWqT1JA52v6bQwOHJf3044xZ3h
	 jwyUcaebmYkem2gbH/NsSbzyCqW+hen1NqUqQgKA=
Subject: FAILED: patch "[PATCH] ASoC: SOF: ipc4-topology: Refresh copier IPC payload before" failed to apply to 7.1-stable tree
To: peter.ujfalusi@linux.intel.com,broonie@kernel.org,kai.vehmanen@linux.intel.com,liam.r.girdwood@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:06:16 +0200
Message-ID: <2026082016-frisk-riches-3e59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0c0e418dbcf0582bf80d8dbfd9b306607c065992
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082016-frisk-riches-3e59@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c0e418dbcf0582bf80d8dbfd9b306607c065992 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Date: Thu, 30 Jul 2026 08:48:22 +0300
Subject: [PATCH] ASoC: SOF: ipc4-topology: Refresh copier IPC payload before
 widget setup

The ipc_config_data buffer for copier widgets is built once during
ipc_prepare (called from sof_pcm_setup_connected_widgets) and cached
for reuse. For host copiers this buffer contains the copier_data with
gtw_cfg.node_id (host DMA ID). For DAI copiers it additionally includes
a dma_config_tlv trailer with stream_id and dma_channel_id for HDA link
DMA.

On suspend/resume, both host and link DMA streams are released and
re-allocated with potentially different stream tags. The underlying
copier_data and dma_config_tlv structures are correctly updated by
host_config and sdw_hda_dai_hw_params respectively. However, since the
widget list (spcm->stream[].list) persists across suspend,
sof_pcm_hw_params skips sof_pcm_setup_connected_widgets and ipc_prepare
never runs again to rebuild ipc_config_data. The stale cached payload
is then sent to firmware with boot-time DMA channel assignments, causing
DMA channel conflicts that lead to firmware errors and crashes.

Fix this by refreshing copier_data and dma_config_tlv portions of
ipc_config_data in sof_ipc4_widget_setup right before the IPC message
is sent. This ensures the payload always reflects the current DMA state
regardless of whether ipc_prepare ran.

For DAI copiers, the gtw_cfg.config_length in copier_data is temporarily
inflated to include the TLV size (matching the ipc_config_data layout)
before copying, then restored, mirroring what
sof_ipc4_prepare_copier_module does when first building the buffer.

Fixes: e9c6b118de1a ("ASoC: SOF: make dma_config_tlv be an array")
Cc: stable@vger.kernel.org
Link: https://github.com/thesofproject/sof/issues/10700
Link: https://github.com/thesofproject/sof/issues/10955
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Link: https://patch.msgid.link/20260730054822.5913-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 95ad5266b0c6..6fdfb667cce8 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -3204,6 +3204,15 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
 		ipc_size = ipc4_copier->ipc_config_size;
 		ipc_data = ipc4_copier->ipc_config_data;
 
+		/*
+		 * Refresh copier_data in ipc_config_data for host copiers.
+		 * The node_id may have been updated by host_config after
+		 * ipc_prepare, e.g. when host stream tags change after a
+		 * suspend/resume cycle.
+		 */
+		if (swidget->id != snd_soc_dapm_buffer)
+			memcpy(ipc_data, &ipc4_copier->data, sizeof(ipc4_copier->data));
+
 		msg = &ipc4_copier->msg;
 		break;
 	}
@@ -3212,6 +3221,9 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
 	{
 		struct snd_sof_dai *dai = swidget->private;
 		struct sof_ipc4_copier *ipc4_copier = dai->private;
+		struct sof_ipc4_copier_data *copier_data;
+		u32 gtw_cfg_config_length;
+		u32 tlv_size;
 
 		pipeline = pipe_widget->private;
 		if (pipeline->use_chain_dma)
@@ -3220,6 +3232,27 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
 		ipc_size = ipc4_copier->ipc_config_size;
 		ipc_data = ipc4_copier->ipc_config_data;
 
+		/*
+		 * Refresh copier_data and dma_config_tlv in ipc_config_data.
+		 * These may have been updated after ipc_prepare, e.g. when
+		 * link DMA stream tags change after a suspend/resume cycle.
+		 *
+		 * copier_data->gtw_cfg.config_length does not include the
+		 * TLV size (it was restored after sof_ipc4_prepare_copier_module),
+		 * so temporarily inflate it to match the ipc_config_data layout.
+		 */
+		copier_data = &ipc4_copier->data;
+		gtw_cfg_config_length = copier_data->gtw_cfg.config_length * 4;
+		tlv_size = ipc_size - sizeof(*copier_data) - gtw_cfg_config_length;
+
+		copier_data->gtw_cfg.config_length += tlv_size / 4;
+		memcpy(ipc_data, copier_data, sizeof(*copier_data));
+		copier_data->gtw_cfg.config_length = gtw_cfg_config_length / 4;
+
+		if (tlv_size)
+			memcpy(ipc_data + sizeof(*copier_data) + gtw_cfg_config_length,
+			       &ipc4_copier->dma_config_tlv, tlv_size);
+
 		msg = &ipc4_copier->msg;
 		break;
 	}

