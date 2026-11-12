Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794496125;
	b=xP/bNgfgA6KMo5rP7v1nt6WAdpcVnD77LpEGWkPRwQbWbmAiGAIRuCSMQH2EVXUW3wVL
	 J/qdzjkJIn5pWUPqXwwyth1YClel1GBSt1YjdXhtX+paRVw2fq+5vEDMaZwYVWBcg/9dD
	 K9u86nbPhS8HwTh1RogBtG7p/b18v3HgIBPw9jcSweaKGmpyBJf+v91cohk1TtdSGdEzA
	 QnLoQ5wxokIrl3oYzFBLQU+Y/jhEfxP/IEqh/sk671+gnJ5AOJqISIIHKCdtslXTDcO5i
	 GoywupmsLokSIyvfG7VXUg6LSBgwukZTod+35svx+GRXaBER+fbsF8Emyv44QfcCu2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794496125;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=RSbxfdw4v9ONuz5hQAdsCH+xZO9A8kXMkc1Zh6tgqw8=;
	b=mSKgjgl5DgC1x7GfBSEwuYGAgWikS/il5Npem07ZxKlZE/Hy29OCH7wANUsb5El+fwCe
	 EJ2KZWr3+kjYxJaOVDKPP7XCdEMtvjaOYP1oWjCu+xWG+yD7v2f2iLlnJwUyE+vDti8/0
	 0RUhLRJKXUMp1iwb0hu7RQaUbQ2RoWzpEvnoM/5FsWavE0Df5N9FlSO2l38lxtc1cJBbA
	 K//gFvdwkg5mAw+dzBIsW7ickasv4jjOR17zpYxuFGztRWE4OPJCEp4U8Dr4q8jpBfjcz
	 Jt4mufNpYaHo37m2iEUdI8qrNA4nwqWpxCjIRiThewmRKvjZ3bXGjP58kmltEwP9FwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fpvGRSS0;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D16606A31C;
	Thu, 12 Nov 2026 15:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29D16606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fpvGRSS0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794496125; x=1826032125;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WyvL7tt4VSpx2MEBZmZ7xSN6XV0byPk9a70v+R9M7LM=;
  b=fpvGRSS0T1FKsqA0SRewwMj+WlxiAWAzDCjsRHmAcyoTP/sHOLTg9of5
   uNDI35aPrnyWRoSe6BG2FgD36IMxwwfgJXZ6PSrWUwaKqrN0cty88EWy/
   foWQoBPS2tHBCVEosq95cu6bgMNGww/GDT3QUYtOG3KzJf7Xf+2Bhf115
   R9hlKrVNCs5uZ9+wxVj+4TkKA4lnsEvZussC2NDIz3VJVETSsM6vsNBib
   IR50S3dwAJa4vm6ZXxk1eclCvlwCeO6Zja24rOtrIO5Cx4IICWPKbK23b
   oSQlPeC0B6pVoo6PC750hvolflQd2x035H+MiVPdC6yeUDFx3Z3pZrcd0
   w==;
X-CSE-ConnectionGUID: DzooUMDQQTyBrOV3uWJz8g==
X-CSE-MsgGUID: KcuyEn+7SaWXY7OOucnXmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3284323"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3284323"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 07:06:49 -0800
X-CSE-ConnectionGUID: 8kVlfxHTSV2CePMG7JbIsg==
X-CSE-MsgGUID: 7K1eu0qlTNaWx+NUj6PEWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="9019338"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.111.173]) ([10.125.111.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 07:06:47 -0800
Message-ID: <cd038bd1-c293-4eef-af55-b4c885c3d5bf@intel.com>
Date: Thu, 12 Nov 2026 08:06:46 -0700
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
Subject: Re: [PATCH] dmaengine: idxd: Avoid destroying the device workqueue
 twice
To: Yao Kai <yaokai34@huawei.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, liuyongqiang13@huawei.com, stable@vger.kernel.org
References: <20261111021026.3354620-1-yaokai34@huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261111021026.3354620-1-yaokai34@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/10/26 7:10 PM, Yao Kai wrote:
> If idxd_probe() fails after idxd_setup_internals() succeeds,
> idxd_cleanup_internals() destroys idxd->wq. The PCI probe error path
> then calls idxd_free(), whose put_device() invokes
> idxd_conf_device_release() and destroys the same workqueue again.
> The err_evl path in idxd_setup_internals() has the same problem.
> This can corrupt the workqueue list or access freed memory.
> 
> Clear idxd->wq after both error-path destroy_workqueue() calls and
> only destroy a non-NULL workqueue in the release callback. The NULL
> check also handles failures before the workqueue is created, while
> preserving its destruction on normal device removal.
> 
> Fixes: 3d33de353b1f ("dmaengine: idxd: Fix not releasing workqueue on .release()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yao Kai <yaokai34@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/dma/idxd/init.c  | 2 ++
>  drivers/dma/idxd/sysfs.c | 3 ++-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 4b827a329756..ffbc5a74be6e 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -389,6 +389,7 @@ static void idxd_cleanup_internals(struct idxd_device *idxd)
>  	idxd_clean_engines(idxd);
>  	idxd_clean_wqs(idxd);
>  	destroy_workqueue(idxd->wq);
> +	idxd->wq = NULL;
>  }
>  
>  static int idxd_init_evl(struct idxd_device *idxd)
> @@ -460,6 +461,7 @@ static int idxd_setup_internals(struct idxd_device *idxd)
>  
>   err_evl:
>  	destroy_workqueue(idxd->wq);
> +	idxd->wq = NULL;
>   err_wkq_create:
>  	idxd_clean_groups(idxd);
>   err_group:
> diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
> index 6d251095c350..d5ffc641c856 100644
> --- a/drivers/dma/idxd/sysfs.c
> +++ b/drivers/dma/idxd/sysfs.c
> @@ -1836,7 +1836,8 @@ static void idxd_conf_device_release(struct device *dev)
>  {
>  	struct idxd_device *idxd = confdev_to_idxd(dev);
>  
> -	destroy_workqueue(idxd->wq);
> +	if (idxd->wq)
> +		destroy_workqueue(idxd->wq);
>  	kfree(idxd->groups);
>  	bitmap_free(idxd->wq_enable_map);
>  	kfree(idxd->wqs);

