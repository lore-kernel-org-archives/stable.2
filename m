Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61AA446848
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 13:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231595; cv=none; b=egoMQWRjmS5CGiDQs6wO4qCKnKft9OLAPeJIw1Ee2/NVPL+8O0uuT+b886FfpV6ONr9PQdXMz7Oodq+OorSFn+2n2S965GqS5BxSeOQyrXvFkkC3crbq1ryZoajhAWMq5iPhFsSqyg9tJxrOEwvHpGAwXyHQL/fuDf2IFltZ80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231595; c=relaxed/simple;
	bh=b+G+qb83KAdGhxn2xQVfnTvhCFpyFg/MzkkP8sWrDE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRm7lv2Jek+FzHWvz8cG/FW/QfsZ6QgmvwFndF0x+rTijbLs5XZWbcLwfjprtu3rPS4aS8FkvebqiooEdmfb09aP6Vf6gNrA8PiBQDj71K7mg2bhbN6u9MhJa1F5otsqYvM0eO+aoMFLypIzHfFT4ntz/1uufPOv6JaN3a1GU2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MhbMgkBF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MhbMgkBF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787231594; x=1818767594;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b+G+qb83KAdGhxn2xQVfnTvhCFpyFg/MzkkP8sWrDE0=;
  b=MhbMgkBFLgW8HfZzozB8GIaGzJ0YbbQMue/TkcM+tX+wrvh4N9uOMCu4
   1eAezNkrWjSuQULgLvKIyrSxTeGGzRcWPL/WICfipNqxPaFgU1fwbtZZa
   ovegj2QARy7/Um6lpOpJo5HgnG+YD5Tr6RbwjGeI6npiOOZigJxCqxe/k
   W/Id8GDZzmPcuyYyHPy6vgClzEZjDcaaeKVvUaoWAcJJIBQCBfTrMjWiu
   cyqTGTphA2Zfa/uGyqiNGitlNmTplRbTI96Wbearq/i5VNIpWmlok5YHZ
   6vp+reJF8dx/ONCzVr6CIYTeCjAoTQIisO+M+rBxi8rEIq9lZtOrPU9L6
   w==;
X-CSE-ConnectionGUID: 0pOuhxQIRoqXslzAmc2iOQ==
X-CSE-MsgGUID: IZIylTTAQsaK5OxQkbJKEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="98098301"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="98098301"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 06:13:13 -0700
X-CSE-ConnectionGUID: o8Lsoex5QzuAMtJMsm3A2Q==
X-CSE-MsgGUID: gmyqMPrKQVmUqud38As9Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="262712683"
Received: from szadworn-mobl.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.124])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 06:13:10 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	peter.ujfalusi@linux.intel.com,
	broonie@kernel.org,
	kai.vehmanen@linux.intel.com,
	liam.r.girdwood@intel.com
Subject: [PATCH 6.12.y] ASoC: SOF: ipc4-topology: Refresh copier IPC payload before widget setup
Date: Thu, 20 Aug 2026 16:13:10 +0300
Message-ID: <20260820131310.25431-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082017-backspace-rectify-6ec7@gregkh>
References: <2026082017-backspace-rectify-6ec7@gregkh>
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
Link: https://patch.msgid.link/20260730054822.5913-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit 0c0e418dbcf0582bf80d8dbfd9b306607c065992)
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

