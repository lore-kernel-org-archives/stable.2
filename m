Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794669807;
	b=N7NpQb3gB17MdOPtOa9JBY9sLBg1f1Ws9oEsXqSZObFpgdlgls5ctbG++dwTiA2/SZF3
	 NF4RPiTmxWNE13vHFRu1JMqXzcpWTVh0R4RzlosVfJgx4BsOUh1IAhJVsNyo++U81DpaG
	 X/smzajIrVbRKEJQ1aMiho5ykOQhG5a1ENrTx1y0G3gavZqqOrAu3E1VbeFqF5KVgQ8Z1
	 cOlt1eRp/8yjCFSCKaV0m+jWNeYEe3gnMLZH+kZndxp08hMWrlOVw2FK0EBJSU7azfa9A
	 BqtT/WCU3ljVuBxcAKAGepq/Ux6VbLLzU6ss54Ro5gLWYyGLDrst9NOov2K89p65uaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794669807;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=3JMhWfUcU7fxNCU/ri2y5UyMUFxhaJHLZo8Ai7ubS5A=;
	b=WLZFikepj5La6Jmf4rge4jNAFGhiQer5VBIjhZ84kEMTu3f2I0FiFHLAxL8xz2DDfdFv
	 nW09FkeZHdhVtizZRIhnGqyP27zQ5rqZC7EfQzffNDch5lQyNIkvx8pjmh2SrRYbpez3T
	 PaCrPtafpe1oESE6CPzK7/Mxt7M9+Ce7moCqi1I6LO50505i17F6tQ6a+GAjiQhuiLVkl
	 X2+0lYLKZt443uBonYojwBG+B9681wcJskijWZqwmlxf3xerexks3y7O247XEwn97UpwY
	 tuKgKeNNGH6WqInRNyohz4C1VMeOFoFd8z1Iu5AQmS4UERuKNUr+Wlq+An2WfC2jmVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZFJUXHnJ;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10813606A332;
	Sat, 14 Nov 2026 15:23:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10813606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZFJUXHnJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794669806; x=1826205806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kZGVpg2F7/HHNo/fRGXO4LMnPCizNrXdzI6fin2ZWoc=;
  b=ZFJUXHnJ+ovNMLXwKFIXiLmXbcBnIfj1DwS9k30EgsmWsuyAmQVFBkvs
   Sjw9qnevB9BwmQMtlY2Fd30bFrfcXmaEfDBjfFzBzpZBYeXRGvFUEj7lM
   qPqMV0taozMeo8eVupJzjm9z4NwGrBDtVBxuyWgbWL6fyuxiS1ZoQHDHf
   XoE5joiPH2EVyE+3/tPMD4QVziZAkQkYOrTQF2n90NzZioovI07OZE+AJ
   DGzcoOcCemd2QAUyGa04RqbRU0moJGsNffV58zoxCE3KHjEZy6WL88r8l
   fIeKYdx3JwwP3m/kTwi3qMOQaMb6OFdYvLEWpYlZx7UAwdWKO8abQvLc0
   Q==;
X-CSE-ConnectionGUID: gcvubHj9RHuOZkhvrxU56A==
X-CSE-MsgGUID: PSD0OrMvTVSkJmNGkn/jKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11966"; a="3365436"
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="3365436"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2026 07:23:25 -0800
X-CSE-ConnectionGUID: RUehccmiT2+4igswWMrX0g==
X-CSE-MsgGUID: etcpffj8QLSD5YY8McYSaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="11066525"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.47.46])
  by fmviesa013.fm.intel.com with ESMTP; 14 Nov 2026 07:23:23 -0800
Date: Sat, 14 Nov 2026 23:14:58 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
Cc: mdf@kernel.org, yilun.xu@intel.com, trix@redhat.com,
	linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] fpga: altera-hps2fpga: Fix reset control leak
Message-ID: <avh68lVmIG6MwMby@yilunxu-OptiPlex-7050>
References: <20261107150747.1152-1-laixiangwu@cmss.chinamobile.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107150747.1152-1-laixiangwu@cmss.chinamobile.com>

On Sat, Nov 07, 2026 at 11:07:47PM +0800, Xiangwu Lai wrote:
> From: laixiangwu <laixiangwu@cmss.chinamobile.com>
> 
> alt_fpga_bridge_probe() acquires the bridge reset control with
> of_reset_control_get_exclusive_by_index(), which is not
> device-managed. None of the probe error paths release it, and
> alt_fpga_bridge_remove() does not call reset_control_put() either,
> so the reset control reference leaks both on a failed probe and on
> every bind/unbind cycle.
> 
> Since the leaked exclusive reset remains acquired, rebinding the
> driver afterwards also fails with -EBUSY.
> 
> Use devm_reset_control_get_exclusive_by_index() so the reset control
> is released automatically when the driver is unbound or the probe
> fails.
> 
> Fixes: e5f8efa5c8bf ("ARM: socfpga: fpga bridge driver support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>

Reviewed-by: Xu Yilun <yilun.xu@intel.com>

Applied to for-next, thanks

> ---
> Changes in v2:
> - Drop the enumeration of probe error path examples from the commit
>   message, as suggested by Xu Yilun.
> - Add Cc: stable@vger.kernel.org for backporting.
> 
> Link: https://lore.kernel.org/r/20261103014240.1194-1-laixiangwu@cmss.chinamobile.com
>  drivers/fpga/altera-hps2fpga.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
> index f2f125068..6d9798bb9 100644
> --- a/drivers/fpga/altera-hps2fpga.c
> +++ b/drivers/fpga/altera-hps2fpga.c
> @@ -134,8 +134,7 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
>  
>  	priv = (struct altera_hps2fpga_data *)device_get_match_data(dev);
>  
> -	priv->bridge_reset = of_reset_control_get_exclusive_by_index(dev->of_node,
> -								     0);
> +	priv->bridge_reset = devm_reset_control_get_exclusive_by_index(dev, 0);
>  	if (IS_ERR(priv->bridge_reset)) {
>  		dev_err(dev, "Could not get %s reset control\n", priv->name);
>  		return PTR_ERR(priv->bridge_reset);
> -- 
> 2.50.1.windows.1
> 
> 
> 
> 
