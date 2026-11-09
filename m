Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208355;
	b=JCyAjvrbUHza+Xa1hho7k0O+tmXs8WCRAOo0FaT/A7eV4OKZhwL1QAXa3q75m2x+hu4v
	 irCuOkZDRbI/sgPSRAwS60mkLiJNtSjATQxUjS6Wa+7q9k6uJUILXVWfFoSQLwidpGmOG
	 ma5YXFU/LitlskaGCrRj1kanYoAg0VgrGwHKhuVRGjsCYDgj0Ff0qA+BuGwcSCN7fDTbN
	 gAkZ/jGAX6dYOFujKnQF3p/GImbRgVOadvBb3T6ULTlxLp7I2MCWgT9BM4fCaD/QoMBPJ
	 vOSSr9l+5jgqkT+G+ZVj2+jHNYspYxJ8eP4E/Inno1u3AvaM1CXhTm6ZfkEBHELMKug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208355;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=jm9engSfdWPrS9dt7pF9UwSBMVA4d9S2cMVwCkkiwKQ=;
	b=RDNTrXvH4XloAmRKUT0uM+dpvmVmY9D7BNoJU1SouQq0Wa40vyHgSN+TtE1Un9J6lc6C
	 HEtT2pftqeRUf0FjO57HbgdLCY1XOEm/qAv2jugdH4Xpcr4okc6Tf1tgWZXwlQe1iW1Yw
	 Cg2WlJr+OQWOY671gr4Ma2nsqJrGFgU4KNiG/ps/pPY9q4sEE50F8LPPJUgsDrDeW70QJ
	 p86X1RvWKG/V72eWaZd3I3R9j9QyCMBS0C7XZo7ttvkXWOdVvPEOWyDrJ2CAx83pOewUS
	 kyY2bcJTHbm2nm7JycuadUEZXQnKVEvQL/fj9pEp3BIPdmJWspxRVwAYmzb2wWCOuFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dSSbULsB;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7B0606A31C;
	Mon,  9 Nov 2026 07:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD7B0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dSSbULsB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794208355; x=1825744355;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vuCWaIlGUKXXEN2eAbbUtujZ8yy68AEkaUI0O7EyVNs=;
  b=dSSbULsBQWCmEu9/95U1Mh1FqxcjVetyqt9c9pDguXhXBVppDtdrL4I0
   y0hmTSvgILu8k84g43Myvphs5Phpq6qN8fqBDatf/qeCSi4uCrnmA69b+
   MJdOzWK8Z0jwmx+bF0F+PDOss5zE6hcRK8rkcCY2Zpf5w1Nni7FzT+6hj
   nZcp+1vVYpSM4of5IxzjzrXb7wMOZ8s3cj+hIRm+5r0/Q3E/esqI7s2R9
   HUSXx+Od07yfAaoONLZp6fEZcPhOjHOCnxhnHr1l70TdUx7L7tTVusYwM
   1FiNOmnhJk4G+L1nqxz4KDekYc7jHlAgz/BYYbS32xmriHh5Dj+601Mrb
   w==;
X-CSE-ConnectionGUID: 5CM3MMqxTbSt9bwF+nXnKg==
X-CSE-MsgGUID: usgmnsTeTsm5t/DUaZjeVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2953950"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2953950"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 23:12:34 -0800
X-CSE-ConnectionGUID: cg/ksszfRaWB7nuvOkH03w==
X-CSE-MsgGUID: jS8vn2vhQOqV6LVelN0C4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8370954"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO [10.245.244.60]) ([10.245.244.60])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 23:12:31 -0800
Message-ID: <3fabe6b3-1285-4edb-abaa-bedf406b4926@linux.intel.com>
Date: Mon, 9 Nov 2026 09:13:10 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ASoC: SOF: ipc4-topology: Fix pin format leak in
 process widget setup
To: Baoli Zhang <baoli.zhang@linux.intel.com>,
 andriy.shevchenko@linux.intel.com, Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS"
 <sound-open-firmware@alsa-project.org>,
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
 <linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: stable@vger.kernel.org
References: <20261109005604.1004362-1-baoli.zhang@linux.intel.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20261109005604.1004362-1-baoli.zhang@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 09/11/2026 02:56, Baoli Zhang wrote:
> sof_ipc4_widget_setup_comp_process() allocates the input and output pin
> format arrays via sof_ipc4_get_audio_fmt(). When the following
> sof_ipc4_widget_setup_msg() fails, e.g. because the firmware does not
> provide a module matching the widget UUID, the error path jumps to the
> 'err' label, which frees the process struct and clears swidget->private
> but skips sof_ipc4_free_audio_fmt(). The arrays are then unreachable and
> are reported by kmemleak:
> 
>     sof_ipc4_get_audio_fmt+0xc9/0x420 [snd_sof]
>     sof_ipc4_widget_setup_comp_process+0x8e/0x200 [snd_sof]
>     snd_sof_load_topology+0x71a/0x840 [snd_sof]
>     sof_pcm_probe+0x77/0x120 [snd_sof]
>     snd_soc_component_probe+0x21/0x60 [snd_soc_core]
>     ...
> 
> Jump to 'free_available_fmt' instead, as the other process widget error
> paths after sof_ipc4_get_audio_fmt() already do.
> 
> The other IPC4 widget setup functions (pga, mixer, src, asrc) free the
> audio formats in their common error label and are not affected.
> 
> Fixes: f9efae954905 ("ASoC: SOF: ipc4-topology: Add support for base config extension")
> Cc: stable@vger.kernel.org
> Signed-off-by: Baoli Zhang <baoli.zhang@linux.intel.com>

Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.linte.com>

> ---
> Changes in v2:
> - Drop the Assisted-by tag.
> - v1: https://lore.kernel.org/linux-sound/20261103021710.3647599-1-baoli.zhang@linux.intel.com/
> 
>  sound/soc/sof/ipc4-topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
> index 8b13c97b34804..de03dc58021a1 100644
> --- a/sound/soc/sof/ipc4-topology.c
> +++ b/sound/soc/sof/ipc4-topology.c
> @@ -1313,7 +1313,7 @@ static int sof_ipc4_widget_setup_comp_process(struct snd_sof_widget *swidget)
>  
>  	ret = sof_ipc4_widget_setup_msg(swidget, &process->msg);
>  	if (ret)
> -		goto err;
> +		goto free_available_fmt;
>  
>  	/* parse process init module payload config type from module info */
>  	fw_module = swidget->module_info;
> 
> base-commit: 3ecd14f81434da3b5ff5c44d243715f96d52303d

-- 
Péter

