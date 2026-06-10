Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6602D8795;
	Wed, 10 Jun 2026 06:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781074689; cv=none; b=C94OwsYwgoRt86pk6spamNNme8o4yB6v9TcQYkWm8H8eqr1bF/dcvdfxRqrpqCKXcwDZx12ow+777YpbcMzXPGPGcl+DHipdCdpKlZOayCLuJOu/9W1E+faS2vpUazB0eMxSpSXtzLlpFdxV0ohOmrZNRvBhBCtIX/yVbXC7SDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781074689; c=relaxed/simple;
	bh=IVRwCBNjPlQUYB6sKF+F7jGl7xu+8jb6UBF2X9IQU9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e8RMFPcLZcA0svlsUahEOBjOaFvB1GSYy3DesM1eVIkGA72H2Ej1Zcz2gv5cUmIMV4XnPXmY4dk5twSVpcBkHKsYxVqS/vVhAptDwt25jINvIMa22y9kZLZVeVMjIUHnaIJHSL2qbDNZykIj9cBbYgWcaPI9TFeyxFJJf//ay/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GTYjuxTQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GTYjuxTQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781074688; x=1812610688;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IVRwCBNjPlQUYB6sKF+F7jGl7xu+8jb6UBF2X9IQU9U=;
  b=GTYjuxTQwmIhTCgRuaB43aXIQumaEoZwIhICyZIvoUxLUhFr/So+UOqe
   3IJy+iWMorSiaw6rCdoDPnmlWW0blEsErmw9euz6c92bOJzE0ABDC/jme
   ERXRA5mgyFVc9/dWU8dIjTQxaS5B1lKs9IdAxYhSJFqvTbqzxoxwSEqwb
   19xrKTNifraAYwdDu6qZ3tAA+snhRIj40b2aH3NuBr9Q1SehqtmiEvphA
   EvucDQpZVlHQoEiTlj6Lf1iEUUgbp75Nz9JoyHulXALGNcDpkyyBBdkkL
   2O5TkzP4ZAA/J/DlErT/p7kdunrj8g6wt9YLc0mP9M819MY+PveqJzoE9
   Q==;
X-CSE-ConnectionGUID: BpllVnauR9mAeb66EXBAew==
X-CSE-MsgGUID: QyuowD2yQeK1TbX+TF2p3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="93246975"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="93246975"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 23:58:07 -0700
X-CSE-ConnectionGUID: VQrlg1apRX2dAxbXAhiMkA==
X-CSE-MsgGUID: yUrdc/hsT6GLiQv7gyvWMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="251159983"
Received: from krybak-mobl1.ger.corp.intel.com (HELO [10.245.246.32]) ([10.245.246.32])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 23:58:05 -0700
Message-ID: <d4059b90-ba44-4c51-bdd0-0b791f1a5fd4@linux.intel.com>
Date: Wed, 10 Jun 2026 09:58:13 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: SOF: topology: fix memory leak in
 snd_sof_load_topology
To: Zhao Dongdong <winter91@foxmail.com>, lgirdwood@gmail.com,
 daniel.baluta@nxp.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 sound-open-firmware@alsa-project.org, Zhao Dongdong
 <zhaodongdong@kylinos.cn>, stable@vger.kernel.org
References: <tencent_D87B6446BC0B517BEF9D4731C6CD8B288206@qq.com>
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Content-Language: en-US
In-Reply-To: <tencent_D87B6446BC0B517BEF9D4731C6CD8B288206@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/06/2026 06:11, Zhao Dongdong wrote:
> From: Zhao Dongdong <zhaodongdong@kylinos.cn>
> 
> When the topology filename contains "dummy" and tplg_cnt is 0, the
> function returns -EINVAL directly without freeing the tplg_files
> allocated by kcalloc() at line 2497. This leaks memory on every
> such topology load attempt.
> 
> Fix this by setting ret = -EINVAL and jumping to the out: label,
> which already handles the kfree(tplg_files) cleanup.
> 
> Fixes: 99c159279c6d ("ASoC: SOF: don't check the existence of dummy topology")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
> ---
>  sound/soc/sof/topology.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
> index 63d582c65891..09d6dc01814c 100644
> --- a/sound/soc/sof/topology.c
> +++ b/sound/soc/sof/topology.c
> @@ -2534,7 +2534,8 @@ int snd_sof_load_topology(struct snd_soc_component *scomp, const char *file)
>  		if (strstr(file, "dummy")) {
>  			dev_err(scomp->dev,
>  				"Function topology is required, please upgrade sof-firmware\n");
> -			return -EINVAL;
> +			ret = -EINVAL;
> +			goto out;

I think adding
kfree(tplg_files);
before the return would look better and align better with the code, here
we are sure that led controls have not been created.

>  		}
>  		tplg_files[0] = file;
>  		tplg_cnt = 1;

-- 
Péter

