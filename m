Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549F842CB0D;
	Fri, 18 Sep 2026 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789725788; cv=none; b=n2giGdhq383tcG0+HPtUlMiCZOohCKZtY5KifwYTbsKpct3De4SxzxNsBdnl4jvFhQUkfp+wlCBlUN/JKZQ89cfExsBe0RNP9JkhpWcJdqJjSpUYw6JYAX584sDQB3ZuZh88uGeMtmGtQvveywE5uwbp9QMrYik+iWLw9QJ9Q1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789725788; c=relaxed/simple;
	bh=uElSAhyH1PpeEPWtCcp7Howb3i9y6eQxOdUHga4bW1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CE1KYpNHI91j3ju6t0OaoCyy6teb2RnlsQ/vhVYFvXSRjqIdJqyh4i52O0KQ3tAoGR2CfsRUfkwBcW1Rebxdf9e6veDDbPZgK+44M8cJdqD99erfaJHcZob28kcreeIZdNBhnbVRZz5PXYQvDlJJCZotNBhz1py2vEdFU9vTo8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIq7xTBX; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIq7xTBX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789725787; x=1821261787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uElSAhyH1PpeEPWtCcp7Howb3i9y6eQxOdUHga4bW1E=;
  b=nIq7xTBXrEcTQdHBcOjiOAjGu7vdrTgXkTvC4eQM/MGMzfXJiDUmH+ql
   duvPj5ShbQYGn4y+nSF0NewIdRte6XBkJMkw5s5HlT90OtfMD0pWya3j1
   NhwiXcWZiKUjI8cIsapZDI5ITgs266TFbVZglpsu3kWSFn43bisN6/r4H
   ZtcdVhANDdDj9+HG/SALNesMO4spzpYUG2VesNRNwMZyfZiwTO6oT3SYj
   BdJySY0WCaY78Qd0UXS77OOklzPtH7bfX9nEmmtSuVwKOPFrzfbHjnMov
   vPaQLx1Zx1NIq4GJs9p+F+2hBcrLrKCqSMHm0tv2h2iqOMBAM2eRHP7f9
   Q==;
X-CSE-ConnectionGUID: KKO9JKqSThOkbwrKHn9MLg==
X-CSE-MsgGUID: +5jBdrO0TceaRLWIGh3M2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="728799"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="728799"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 03:03:06 -0700
X-CSE-ConnectionGUID: Fzk0+0vuSaGiYihkFXoX7g==
X-CSE-MsgGUID: JJFCgwzZRAm1B0qK2MGLwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="270024013"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 18 Sep 2026 03:03:03 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id 0041099; Fri, 18 Sep 2026 12:03:01 +0200 (CEST)
Date: Fri, 18 Sep 2026 12:03:01 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/6] usb: typec: ucsi: ccg: add missing
 pm_runtime_dont_use_autosuspend() call
Message-ID: <aq0MVewexVIdq_qs@black.igk.intel.com>
References: <20260915090223.1346-1-joshua.crofts1@gmail.com>
 <20260915090223.1346-5-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915090223.1346-5-joshua.crofts1@gmail.com>

On Tue, Sep 15, 2026 at 09:02:21AM +0000, Joshua Crofts wrote:
> ucsi_ccg_remove() disables PM runtime on teardown, but doesn't call
> pm_runtime_dont_use_autosuspend(), causing resource leaks.
> 
> Add the missing pm_runtime_dont_use_autosuspend() call.
> 
> Found using Coccinelle.
> 
> Fixes: a94ecde41f7e ("usb: typec: ucsi: ccg: enable runtime pm support")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index 91c2958a708c..9d3ebb255de7 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -1519,6 +1519,7 @@ static void ucsi_ccg_remove(struct i2c_client *client)
>  
>  	cancel_work_sync(&uc->pm_work);
>  	cancel_work_sync(&uc->work);
> +	pm_runtime_dont_use_autosuspend(uc->dev);
>  	pm_runtime_disable(uc->dev);
>  	ucsi_unregister(uc->ucsi);
>  	free_irq(uc->irq, uc);
> -- 
> 2.47.3

-- 
heikki
