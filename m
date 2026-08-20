Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368E5446C18
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 13:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787231501; cv=none; b=kALb5QhmKHMhCe+0uvycZ9TKqwxNHDNGOj58wTn/tQwXrYXcvH3zEYqvtW2lP1ugnbujpUyhOlIZW/DNV1Nox7VqwlTa04trpHMc6OTqnxCHiaLHN68+nfWSMrBoWTKtCEu07NMM6QhqlLpGhKAS+chkZv/j4AhhNbpvLLk7Keg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787231501; c=relaxed/simple;
	bh=TQMec3z/O0R8XyFKraa2sKKSDzakq+vuL8zZy5ijA7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NH5p3HrQM5a8fIu0k6aadbsEGzogS/O5CMNHIPfblL/gtCZR9tkk0gbqh72/lR4bfmON8FmPFT57t6L4KErx50vLJQzG1XRNrvPLpKkI6ckblOo8BhZQXDCPyJec7zCEI5xJ2v88d1FpTV3U9FL3ArAgnJZkfTX99kUYqXIGPkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MUxLZJF/; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MUxLZJF/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787231497; x=1818767497;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQMec3z/O0R8XyFKraa2sKKSDzakq+vuL8zZy5ijA7s=;
  b=MUxLZJF/J8H073PTob14D2GRQ8yO4HZyddUz88yV0UFhEylePEgyiJKD
   +3onO7+sCnggvYwu7DzQ0grjebW+gT8qSnITgpQqF8lzTH5WWm428k60l
   rHjfP53jMriKJXiOqnubkvORby7V4iTLdji2C4Pcypp0VFHyRfeL8Hfnv
   DNv5gf2QGJ1+ckMwxTwkY2BBQ4AbwgeAH3I3ABI0EIG5rcA4sfNnrSQjI
   4/ukKHWQ2qFsgv74YvmN+SUTbj2emAhTZyfc6yrqIpFqgzFP4RafwJ3TM
   L9/x0tZqar2XAwWznHmcizzDvxLtTr7XSJjiYMf5T2dGayioC4KOKCdlj
   A==;
X-CSE-ConnectionGUID: swYrpe7WSS2P+s2ZQeVm2Q==
X-CSE-MsgGUID: 9VUCVJ7RTLCybsucinGR6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="105146516"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="105146516"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 06:11:35 -0700
X-CSE-ConnectionGUID: gK7jZfKqQIyg/fLfxxksBQ==
X-CSE-MsgGUID: Vhqmftn4RZ6ma21x6uT5CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="289523391"
Received: from szadworn-mobl.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.124])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 06:11:33 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	peter.ujfalusi@linux.intel.com,
	broonie@kernel.org,
	kai.vehmanen@linux.intel.com,
	liam.r.girdwood@intel.com
Subject: [PATCH 6.18.y] ASoC: SOF: ipc4-topology: Refresh copier IPC payload before widget setup
Date: Thu, 20 Aug 2026 16:11:31 +0300
Message-ID: <20260820131131.24981-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082017-slum-regalia-c26e@gregkh>
References: <2026082017-slum-regalia-c26e@gregkh>
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
index d74567d6afc4..5701e4d1ac13 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -3007,6 +3007,15 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
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
@@ -3015,6 +3024,9 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
 	{
 		struct snd_sof_dai *dai = swidget->private;
 		struct sof_ipc4_copier *ipc4_copier = dai->private;
+		struct sof_ipc4_copier_data *copier_data;
+		u32 gtw_cfg_config_length;
+		u32 tlv_size;
 
 		pipeline = pipe_widget->private;
 		if (pipeline->use_chain_dma)
@@ -3023,6 +3035,27 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
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

