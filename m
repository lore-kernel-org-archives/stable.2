Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4CC32B113;
	Thu, 30 Jul 2026 05:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785390469; cv=none; b=fO9ywhzxkMbRCaLSM9942Hxs/2zRvuoRkoIYZgjp2FKlev4mMWfU3m8SGIDRzJDOdxBBTNrWYiFtet0uyrn2zryCXdq2tQQWVRkZulrQ94wmAJy+NZ28U8ewtNxyteiT9VROZIQtovW5kZUrKCpP+WNbdQpq9YSNh6D59dVXW6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785390469; c=relaxed/simple;
	bh=PUW1uWxLBbmvm6gjyjj2ziH/bz6UoJOK/g7JXPmMW/o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQUMRflWl9NvFNV8K8PwsV/FwcVTQV+py63sI1Jo0BZKuwzfbNITV/tf2YS4s0nSZaTWJnYFy/bSWTus832EBspwLR4FfeDbZWNueHKv7NwjAAD3b8rtXKQWnx8flfZoJmd9Wfqjq+rGq4J7DQJaVhE+iVbe/+6jBIHyq1c13P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fM8QZX2W; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fM8QZX2W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785390469; x=1816926469;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PUW1uWxLBbmvm6gjyjj2ziH/bz6UoJOK/g7JXPmMW/o=;
  b=fM8QZX2WNy5yUlv5q/4T+7tJVr8Z/wh/8DsgbDKSTOhkERvVAeNyZK4v
   XJnM7hM0whN//Eq0cFny3hdLj1veCsXJFZGxHPbVjDWr65mDiZ5uu+Py0
   /pW9TX9dOyVpiiwTPjT7EA6KWPRQsNXlMUvDl3JN9OhMGT040v+ur+4Ml
   gX7iSlGOaYKODlysuDMeRlHTyP8AzttEbE3Mg2fdOz7ttIR38iyHWshZu
   +UDHYcgrkOeHUAnVCcjl1ABrBqTVOD1fe67CsTPeZMzh5HVS2OhFEl1iW
   UXzPEpvIKArzHNOkm8jzuT6LyObCt9NX0NkCgzoyO/fzszOO3qHVcV6vv
   g==;
X-CSE-ConnectionGUID: lEwDEgGeQfW2gF3Cei/NEQ==
X-CSE-MsgGUID: jOQchTBhTNe7Za456AVusQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="103406732"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="103406732"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 22:47:48 -0700
X-CSE-ConnectionGUID: lqPsYQVJRaOqrAEekO6E/w==
X-CSE-MsgGUID: JEsvEc67RKKtHfGOidwcJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="255897998"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.79])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 22:47:45 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	liam.r.girdwood@intel.com,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: SOF: ipc4-topology: Refresh copier IPC payload before widget setup
Date: Thu, 30 Jul 2026 08:48:22 +0300
Message-ID: <20260730054822.5913-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 sound/soc/sof/ipc4-topology.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 1aba13a90973..fabd364d3316 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2654,6 +2654,15 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
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
@@ -2662,6 +2671,9 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
 	{
 		struct snd_sof_dai *dai = swidget->private;
 		struct sof_ipc4_copier *ipc4_copier = dai->private;
+		struct sof_ipc4_copier_data *copier_data;
+		u32 gtw_cfg_config_length;
+		u32 tlv_size;
 
 		pipeline = pipe_widget->private;
 		if (pipeline->use_chain_dma)
@@ -2670,6 +2682,27 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
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
-- 
2.55.0

