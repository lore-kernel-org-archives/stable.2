Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363074;
	b=28zFWBo+4U9+d8n/+2mtl7Xo85jrLU8wo7BLxE38aRMcjE5TyZDmwrZeeVQenIVeaX/U
	 T2crBv1YndYgvfmDOGELXVKLqfQkZS/HrCB7Qr3aKDEqRrWGlE9mlP+cX5dmNnhf/HtbA
	 NyTbdBGiM+FqcV4SMo6F2rDd4mIE80G02y8IYodMDYl5uMIWZm2MOJBInQSneHNilDvu5
	 EURDK983wZExq6wltAY8wClQgGnCMWSQtDhNRn92Zp5jrsr3bRsTW8eBKHuV7XfjWdUxs
	 7vF292CYtUsz5c8iIVdcMOubX6HU+MGoE8W1UggQjkLJSUEruPqdJLoIf2npswn5GtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363074;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=/MXVaTgY+OR2LvT2eXa5bdJi/4faMVw3UstafV7VsU0=;
	b=c5fCLZkEufzVSdLbAIGX5Oaq4T/1DnfZsZQZCrwdgf3TcB94WBhNCyvltXLWlUqp6XM/
	 nVP0U8M8FW3RYLcc7o8b5IFHykIyQ/FQ64NLvoJX1OpyTGkIYhIaHFH3PYKkY6dDvOEpk
	 vwygwWJuKIwamS/nWV32vVJ/1W+gP9Ms8LDtNaU/tf8m1o1+/Az19iEYajT8IDz6GeE+w
	 lUjyWSj07+Y7V6BiStfon9ipWlS8VpRGCMchumLLxyh7KfoOtH4Ux6NGo/NCLxnzPFfud
	 W8TAYKcAj27z/bQTTAnNb0VK6F28Myvse7jY50GC11lHeJ5uSCqvxnTfnrNtnN1DhFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f0oVWitw;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D06606A323;
	Fri, 30 Oct 2026 12:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3D06606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=f0oVWitw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793363074; x=1824899074;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2Xg0v6nWvINBmo9px4PhZ7L6GRxGud0XGYXsRIPPo8w=;
  b=f0oVWitwyQUWit4Ncs+eaxW/DB/ZBsDJmi9+n97dQA6+RdsHxM8EPuHU
   9t3WIaq/gi1Br+aEV+mGV/acdQfSdayB61/nBt34dUeiRw4vun9JZQuFL
   nvPHBHw1dVenIUspaQaG20Dmzs8bZNsmni1mxEJzVKGWRdfQ93svxTqX8
   LqQiynSgfhemBaqNL8DT+UZk9OD21PmAk1EKFcqoay/8fa9H9DKjF7RiQ
   qzTTmHiyKkHMmurwC+k9eWRUuVldXLoKxwzDkYvCZov7mFf3cig8RECuN
   8l7QRPUEvcx4R30l+En04tQ41mz7EUI6eoFCJQxA5K2g7qp/m6N216h6y
   Q==;
X-CSE-ConnectionGUID: Lyq5IQP7Q9y6yIRXjZaU6A==
X-CSE-MsgGUID: OK5berg7ThODyQKDwdV8NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2008390"
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="2008390"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 05:24:34 -0700
X-CSE-ConnectionGUID: KA7TjK6zT7+r9k3zzz9msQ==
X-CSE-MsgGUID: Vg8pKREISQyKO8uSRBTOVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="5825649"
Received: from abityuts-desk1.ger.corp.intel.com (HELO [10.245.245.230]) ([10.245.245.230])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 05:24:30 -0700
Message-ID: <b8d821ee-9208-4429-a459-6270b31db191@linux.intel.com>
Date: Fri, 30 Oct 2026 14:25:04 +0200
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
Subject: Re: [PATCH 05/21] ASoC: SOF: Intel: hda-sdw-bpt: Stop active DMA
 before closing BPT streams
To: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 sound-open-firmware@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-6-lee@kernel.org>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20261030104840.3361217-6-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 30/10/2026 12:46, Lee Jones wrote:
> When sdw_enable_stream() fails in intel_ace2x_bpt_send_async() after
> hda_sdw_bpt_send_async() has already started the TX and RX DMA streams,
> intel_ace2x_bpt_close_stream() invokes hda_sdw_bpt_close() directly
> without calling hda_sdw_bpt_wait().  As a result,
> hda_sdw_bpt_dma_deprepare() tears down the DMA buffers and BDL while
> the DMA hardware is still running.
> 
> Disable any running TX or RX BPT DMA stream at the start of
> hda_sdw_bpt_close() before unmapping channels and depreparing DMA
> resources.
> 
> Fixes: 4c1ce9f37d8a ("soundwire: intel_ace2x: add BPT send_async/wait callbacks")
> Closes: https://sashiko.dev/#/bug/linux-ff0012de-abdd-4796-875e-b1fbbf47235f
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Acked-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> ---
>  sound/soc/sof/intel/hda-sdw-bpt.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/sound/soc/sof/intel/hda-sdw-bpt.c b/sound/soc/sof/intel/hda-sdw-bpt.c
> index ba9fbd662b85..9d97d8676251 100644
> --- a/sound/soc/sof/intel/hda-sdw-bpt.c
> +++ b/sound/soc/sof/intel/hda-sdw-bpt.c
> @@ -456,6 +456,12 @@ int hda_sdw_bpt_close(struct device *dev, int link_id, struct hdac_ext_stream *b
>  	int ret;
>  	int ret1;
>  
> +	if (bpt_rx_stream && hdac_stream(bpt_rx_stream)->running)
> +		hda_sdw_bpt_dma_disable(dev, bpt_rx_stream);
> +
> +	if (bpt_tx_stream && hdac_stream(bpt_tx_stream)->running)
> +		hda_sdw_bpt_dma_disable(dev, bpt_tx_stream);
> +
>  	/*
>  	 * In the case of SoundWire we need to reset the PCMSyCM registers.
>  	 * Need to continue depreparing the DMA buffers even if this fails.

-- 
Péter

