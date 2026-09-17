Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FF23644CB;
	Thu, 17 Sep 2026 02:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613993; cv=none; b=oVppAygRQkfbh7sv9AImMYlGDYOeCCOcul7KpigzNOiSApCQYKWEQB246Xyiy95to/+2KEsbXbVTcO8JuXS9pwtZOkzKJHzVjJopb/8CQXJJutBfUgqPWIOkiAiUTdTYCxBXGaEd/9Tohy/2t8s75ZqjMbci4LtDW7eOu+v0IBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613993; c=relaxed/simple;
	bh=fTOEXFZ7EJ+AGIfuqI3Ur198sXO09pHRz++K+qksWDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=McHUAzkeAimaQPYgkWCyAuOAkIDJSgCb2oTMmrOnBcD7ei4gRu9YclbI0Cp9ex08B/ANffuny9cIcpGa5wDxUpOb0GhgvnvtSV7kUKelinY6/WgCe4nyRizvE81cOw1763PFp+h/SBfJdHLljGGtexFVfh15dPNi/gdGkG2mU9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXSonEq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXSonEq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E7741F000FF;
	Thu, 17 Sep 2026 02:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613989;
	bh=jPoOuYGWx7K1GomsVw6CFTdH68LEamv+uBoPeqNG5/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mXSonEq3aVapyCr+gGzljf7u/nC+qfmEK0hGhZyn9HNu8o5WiWQzHvYb1Xy8ogJFN
	 X7KJcSsgjsNliViqPKyrGciWep5qPFn8rTWwzs21sbpIHkTF7eAcQGIVCrVC9VyjTJ
	 Jf8ajb/Vg6Q/cGh/LdotaW6UeJ3jjq+RpXC09uMJoQsldLkJYW2fWjqeKw0X0fuNGX
	 mbcuKs8/NlPVLnoYY7ElNiUbT7xsniimRjFduooFtN5ITYW75R4ZPX8lWN1QhytatL
	 mTk+09OnJ+p1MgeDC3f7lWOqs22QlvWN2AaktgnO5eMmczVcPjAT/qS9ASJEFi+57i
	 jGZWJcpwMUlew==
Date: Wed, 16 Sep 2026 19:59:48 -0700
From: Peter Chen <peter.chen@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Pawel Laszczak <pawell@cadence.com>, Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH 6/6] usb: cdns3: add missing
 pm_runtime_dont_use_autosuspend() call
Message-ID: <aqtXpPBsR-KQBOIP@hu-petche-lv.qualcomm.com>
References: <20260915090223.1346-1-joshua.crofts1@gmail.com>
 <20260915090223.1346-7-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915090223.1346-7-joshua.crofts1@gmail.com>

On 26-09-15 09:02:23, Joshua Crofts wrote:
> cdns3_plat_remove() calls pm_runtime_disable() on device teardown, but
> doesn't call pm_runtime_dont_use_autosuspend(), causing resource leaks.

Not a resource leak.

> 
> Add the missing pm_runtime_dont_use_autosuspend() call.
> 
> Found using Coccinelle.
> 
> Fixes: f738957277ba ("usb: cdns3: Split core.c into cdns3-plat and core.c file")
> Cc: <stable@vger.kernel.org>

Not a big issue, it is not necessary to backport.

Peter

> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  drivers/usb/cdns3/cdns3-plat.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
> index e3f32c3e9535..b85d5d1c48fd 100644
> --- a/drivers/usb/cdns3/cdns3-plat.c
> +++ b/drivers/usb/cdns3/cdns3-plat.c
> @@ -219,6 +219,7 @@ static void cdns3_plat_remove(struct platform_device *pdev)
>  	if (!(cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW)))
>  		pm_runtime_allow(dev);
>  
> +	pm_runtime_dont_use_autosuspend(dev);
>  	pm_runtime_disable(dev);
>  	pm_runtime_put_noidle(dev);
>  	cdns_remove(cdns);
> -- 
> 2.47.3
> 

-- 

Thanks,
Peter Chen
