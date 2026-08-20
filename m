Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2994195C9
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787226335; cv=none; b=TseMkk/je0xzij/IpUQL5dvxOcKVxhH2GCHC3WF9ZvvVezj/Wy2qOU/gTPpXWRcsDR5O8A43djNb5IiBmMWwhwjuEqY3yBQTlcRM5OWopsTJjMGKxypD05qdHAiYzoasQ1dV4zY4kG6Ybky67zJoNt9JjndyRdY2XLgjKOvsSKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787226335; c=relaxed/simple;
	bh=WSPw81TP3jwSIjpF6zWmYtpfRj59td85NDh6y1IZxZ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k9kFi/gT5crZWxIA9a/Ow0iz9hm4JrG210OjmqYgLsq7SMkQ5+cudDmqKS2qhzJ6ZJiQSYncEOail+VHrvJw+TW34aFwtUQ2iohh0JNUBG1qIKMRoc+WA1Eort1JfQBYU3CMYqTqbfDwJzCiBd+useF8w2yaR/AeTAdcoj41eaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h4pj0sg0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h4pj0sg0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787226333; x=1818762333;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WSPw81TP3jwSIjpF6zWmYtpfRj59td85NDh6y1IZxZ4=;
  b=h4pj0sg0R3DtbewbvZWNQKd0sMrMcTxBFMGStTT36QfFDzWbJmQrRKDE
   A7DyApILITHItBjYEgUA3s5qAa8mYue1dE6OLA/8CqssmwLeUfhT5Cuah
   DEHEzfYBMuV+V1FmEtgXbolnlQxPcQDDzIwwiSFT8TJyCgKk8ONBtjL/J
   Sv1bqSynFUB8ulx1wSXyvgnhOA9DcYjpVpW0Y1mhzW3ao5Vpqf5cjok59
   0R/speb9yyLZaq/VjFzXBUxMVawQrBDqrfpzvUZqDSIYRzpFyoGjC9QC/
   ysjhBRS892k9XJ4qTP4G8l6NntJ/fAcUshzgwME100fvjf6hHS4sjH+Og
   Q==;
X-CSE-ConnectionGUID: cD7sJf+BS0m3Ey3jwu4zmg==
X-CSE-MsgGUID: s/chSES7RumGf06Nc8DxeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87879596"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="87879596"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 04:45:32 -0700
X-CSE-ConnectionGUID: Aiz0D79vQcCXMX9fQdHynw==
X-CSE-MsgGUID: alj3cQi0T5Wxp0AS9Nrccw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="271209123"
Received: from szadworn-mobl.ger.corp.intel.com (HELO [10.245.246.124]) ([10.245.246.124])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 04:45:31 -0700
Message-ID: <1142f719-4f26-4a2f-be99-af4822cd78b1@linux.intel.com>
Date: Thu, 20 Aug 2026 14:45:30 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] ASoC: SOF: ipc4-topology: Refresh copier
 IPC payload before" failed to apply to 7.1-stable tree
To: gregkh@linuxfoundation.org, broonie@kernel.org,
 kai.vehmanen@linux.intel.com, liam.r.girdwood@intel.com
Cc: stable@vger.kernel.org
References: <2026082016-frisk-riches-3e59@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <2026082016-frisk-riches-3e59@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 20/08/2026 14:06, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 7.1-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
> git checkout FETCH_HEAD
> git cherry-pick -x 0c0e418dbcf0582bf80d8dbfd9b306607c065992
> # <resolve conflicts, build, test, etc.>

I'm not sure what might be the issue, but it is clean here:
HEAD ffc82ed66531 tag: v7.1.9, Linux 7.1.9

git cherry-pick -x 0c0e418dbcf0582bf80d8dbfd9b306607c065992
Auto-merging sound/soc/sof/ipc4-topology.c
[peter/upstream/host-copier-refresh-7.1 ffe9d6156740] ASoC: SOF: ipc4-topology: Refresh copier IPC payload before widget setup
 Date: Thu Jul 30 08:48:22 2026 +0300
 1 file changed, 33 insertions(+)

> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082016-frisk-riches-3e59@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Since there are no conflicts to resolve, should I still send the patch?

-- 
Péter

> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 0c0e418dbcf0582bf80d8dbfd9b306607c065992 Mon Sep 17 00:00:00 2001
> From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Date: Thu, 30 Jul 2026 08:48:22 +0300
> Subject: [PATCH] ASoC: SOF: ipc4-topology: Refresh copier IPC payload before
>  widget setup
> 
> The ipc_config_data buffer for copier widgets is built once during
> ipc_prepare (called from sof_pcm_setup_connected_widgets) and cached
> for reuse. For host copiers this buffer contains the copier_data with
> gtw_cfg.node_id (host DMA ID). For DAI copiers it additionally includes
> a dma_config_tlv trailer with stream_id and dma_channel_id for HDA link
> DMA.
> 
> On suspend/resume, both host and link DMA streams are released and
> re-allocated with potentially different stream tags. The underlying
> copier_data and dma_config_tlv structures are correctly updated by
> host_config and sdw_hda_dai_hw_params respectively. However, since the
> widget list (spcm->stream[].list) persists across suspend,
> sof_pcm_hw_params skips sof_pcm_setup_connected_widgets and ipc_prepare
> never runs again to rebuild ipc_config_data. The stale cached payload
> is then sent to firmware with boot-time DMA channel assignments, causing
> DMA channel conflicts that lead to firmware errors and crashes.
> 
> Fix this by refreshing copier_data and dma_config_tlv portions of
> ipc_config_data in sof_ipc4_widget_setup right before the IPC message
> is sent. This ensures the payload always reflects the current DMA state
> regardless of whether ipc_prepare ran.
> 
> For DAI copiers, the gtw_cfg.config_length in copier_data is temporarily
> inflated to include the TLV size (matching the ipc_config_data layout)
> before copying, then restored, mirroring what
> sof_ipc4_prepare_copier_module does when first building the buffer.
> 
> Fixes: e9c6b118de1a ("ASoC: SOF: make dma_config_tlv be an array")
> Cc: stable@vger.kernel.org
> Link: https://github.com/thesofproject/sof/issues/10700
> Link: https://github.com/thesofproject/sof/issues/10955
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
> Link: https://patch.msgid.link/20260730054822.5913-1-peter.ujfalusi@linux.intel.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
> index 95ad5266b0c6..6fdfb667cce8 100644
> --- a/sound/soc/sof/ipc4-topology.c
> +++ b/sound/soc/sof/ipc4-topology.c
> @@ -3204,6 +3204,15 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
>  		ipc_size = ipc4_copier->ipc_config_size;
>  		ipc_data = ipc4_copier->ipc_config_data;
>  
> +		/*
> +		 * Refresh copier_data in ipc_config_data for host copiers.
> +		 * The node_id may have been updated by host_config after
> +		 * ipc_prepare, e.g. when host stream tags change after a
> +		 * suspend/resume cycle.
> +		 */
> +		if (swidget->id != snd_soc_dapm_buffer)
> +			memcpy(ipc_data, &ipc4_copier->data, sizeof(ipc4_copier->data));
> +
>  		msg = &ipc4_copier->msg;
>  		break;
>  	}
> @@ -3212,6 +3221,9 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
>  	{
>  		struct snd_sof_dai *dai = swidget->private;
>  		struct sof_ipc4_copier *ipc4_copier = dai->private;
> +		struct sof_ipc4_copier_data *copier_data;
> +		u32 gtw_cfg_config_length;
> +		u32 tlv_size;
>  
>  		pipeline = pipe_widget->private;
>  		if (pipeline->use_chain_dma)
> @@ -3220,6 +3232,27 @@ static int sof_ipc4_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget
>  		ipc_size = ipc4_copier->ipc_config_size;
>  		ipc_data = ipc4_copier->ipc_config_data;
>  
> +		/*
> +		 * Refresh copier_data and dma_config_tlv in ipc_config_data.
> +		 * These may have been updated after ipc_prepare, e.g. when
> +		 * link DMA stream tags change after a suspend/resume cycle.
> +		 *
> +		 * copier_data->gtw_cfg.config_length does not include the
> +		 * TLV size (it was restored after sof_ipc4_prepare_copier_module),
> +		 * so temporarily inflate it to match the ipc_config_data layout.
> +		 */
> +		copier_data = &ipc4_copier->data;
> +		gtw_cfg_config_length = copier_data->gtw_cfg.config_length * 4;
> +		tlv_size = ipc_size - sizeof(*copier_data) - gtw_cfg_config_length;
> +
> +		copier_data->gtw_cfg.config_length += tlv_size / 4;
> +		memcpy(ipc_data, copier_data, sizeof(*copier_data));
> +		copier_data->gtw_cfg.config_length = gtw_cfg_config_length / 4;
> +
> +		if (tlv_size)
> +			memcpy(ipc_data + sizeof(*copier_data) + gtw_cfg_config_length,
> +			       &ipc4_copier->dma_config_tlv, tlv_size);
> +
>  		msg = &ipc4_copier->msg;
>  		break;
>  	}
> 


