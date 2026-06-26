Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39526376A05;
	Fri, 26 Jun 2026 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489021; cv=none; b=qNJkqI2UcIyydb2QU1lEuqT0+EWliDWRbE9nf56wF7J9YyE3MBzuVgHQpb5Ma8K+cs42eEfjZPIvPh3xBIIBQApJ7BFE74p/L+hDFrA1DHzBbfe+KkhBbSI2NlscHErgynz+6oDPkMJl/Ln3hi9qU825rO1oXlhTBaah6JnCBOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489021; c=relaxed/simple;
	bh=fqs8hHe0in5+SYdBlxAxKz8L7hYtr6SZCrZKJUOFjJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tmgQ6llgywazLt7B5PvqRnnpT4kLOio8tyWnobH4BVgPQIzL6Mg3JHF0O4gQ6ixYoJ/9wR/x8iO5o7B7AFd7ClJWPAybdCK/sQgqFIqE4qJcnZ9w95XUp/KB1E75+W+oOllhdzBBx7N55lzdSKFrd2xvqRU9ZBqYd/mdLbyjjSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kkYlveQ2; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kkYlveQ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782489020; x=1814025020;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fqs8hHe0in5+SYdBlxAxKz8L7hYtr6SZCrZKJUOFjJw=;
  b=kkYlveQ2IWUYhHMDYf5GVY7uc97JbLcXhzrAFC2m+YgYsQj/OD/aGEim
   xe/d2NGzDyquV7hIB8l7JMFVG1dOrcA2mxd6Iz0eXB5zaw8KFVpxhKBDM
   Sf3YedBBPu+33u/0z783ybZW6ed2NsO+ACtqgegs3koB1XZIA114aKqyg
   kifmdODOKhZbrVYw5bjHhsd1RS10Mu9AN7exSqvE6UJg90ulnHF0FJCus
   SohzuTHk1ZOVeClHyWZAV2F4EwF9zyHZybN9Uxmcw7uptnwzg955cR3X+
   Sf72u1meTVktatYUhu5Kimihb9nLIRg1UJFu2aGho/KKhDL8E6F4xHYxn
   g==;
X-CSE-ConnectionGUID: CgcLNqRUSNimhe5JKeKTyA==
X-CSE-MsgGUID: QPGa82r5SfCcMO7n5pw1LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11829"; a="86962547"
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="86962547"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 08:50:20 -0700
X-CSE-ConnectionGUID: Vp2P8PFBQKCvvC1izPTadA==
X-CSE-MsgGUID: cvk4aAn+SMaemhK6RNWe4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,226,1774335600"; 
   d="scan'208";a="251512607"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.96]) ([10.125.109.96])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2026 08:50:19 -0700
Message-ID: <25123e05-bb24-40d3-9008-8f086af47881@intel.com>
Date: Fri, 26 Jun 2026 08:50:18 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix: ntb: ntb_async_rx_submit: fix tx descriptor leak on
 dmaengine_submit failure
To: WenTao Liang <vulab@iscas.ac.cn>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260626153829.53045-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260626153829.53045-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/26 8:38 AM, WenTao Liang wrote:
> When dmaengine_submit fails after dma_set_unmap has been called, the
>   error path err_set_unmap only calls dmaengine_unmap_put once, but the
>   unmap object has two references (one from dmaengine_get_unmap_data and
>   one from dma_set_unmap held by the tx descriptor). The tx descriptor
>   itself is never freed, so its reference to unmap is never released,
>   causing a kref leak and a dangling pointer in the freed descriptor.
> 
> Replace dmaengine_unmap_put with dmaengine_desc_put(txd) in the
>   err_set_unmap path to properly release the tx descriptor, which will also
>   drop the unmap reference it holds.
> 
> Cc: stable@vger.kernel.org
> Fixes: 282a2feeb9bf ("NTB: Use DMA Engine to Transmit and Receive")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Can you please resend this to ntb@lists.linux.dev? The googlegroups email has not been valid for a long time

DJ

> ---
>  drivers/ntb/ntb_transport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 7cabc82305d6..28091ec5a74e 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1572,7 +1572,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  	return 0;
>  
>  err_set_unmap:
> -	dmaengine_unmap_put(unmap);
> +	dmaengine_desc_put(txd);
>  err_get_unmap:
>  	dmaengine_unmap_put(unmap);
>  err:
> @@ -1896,7 +1896,7 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>  
>  	return 0;
>  err_set_unmap:
> -	dmaengine_unmap_put(unmap);
> +	dmaengine_desc_put(txd);
>  err_get_unmap:
>  	dmaengine_unmap_put(unmap);
>  err:

