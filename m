Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3933B5301;
	Fri, 28 Aug 2026 05:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787895889; cv=none; b=gvwU53jI+PpBIDAPnKFeCQJurt1NnacaNKSvYe8vMifXb7ARUWtLyagHGU5CeHB5XlytIb7RxLVdINkKXu+cDwQxGjpxIuo6sZfqHKBlQ3Gu2aLbCdgGY6PDg1QCTKcnlxBxWXL5ouCdlivhUAh7bzYQ8a0TQ8kmTlANd5vPstM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787895889; c=relaxed/simple;
	bh=gKB11iauUYqAFuZdmCa0SgKfhqnT4MjvPDo1r6eRrIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+8lwsahq0ZObdmAvrB+LC1XjbxaC9akErmWKZHb2g7xgJaLLkr8qcaeZ6jZPGzdN0ccVZlxiv87fTrLdgAGa14bKTYQWXSfkuIU4Pu6Qlsj0zCWBAbolOuJgzWlrpgK53yspUyNPpwR+REUDZLNwY6tYt1/RuLE3vFbE0dp5Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N8+uxbg2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N8+uxbg2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81041F000E9;
	Fri, 28 Aug 2026 05:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787895887;
	bh=JZ8jkENwhXSI17hcjxLdU7YO7IQjlwVthIoqDgQePP8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N8+uxbg2iVPFHvllbLKHUnWT5PT9AiI3kkwQKtwzlyhFPH+gYXTCVQ7SXN73RQbwS
	 /B/YQ2m4nD0QSIH5yIkuRaY6k5GOxwjuHrx8EAmschXAZ7RRHzZCtTDJx+szg2Z4Vb
	 e/rNbkM9TR9p5ZcKkOQsS+lK1GfRw71dmZbjgRgI=
Date: Fri, 28 Aug 2026 07:44:44 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ralf Lici <ralf@mandelbit.com>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev,
	Ran Wang <ran.wang_1@nxp.com>, Duoming Zhou <duoming@zju.edu.cn>,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [REGRESSION] 6.1.y/6.6.y: fsl-usb fails to build
Message-ID: <2026082858-footing-calorie-a196@gregkh>
References: <20260827154302.706689-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827154302.706689-1-ralf@mandelbit.com>

On Thu, Aug 27, 2026 at 05:43:00PM +0200, Ralf Lici wrote:
> Hi,
> 
> While working on some backport patches for an out-of-tree module and
> looking for the exact versions containing the disable_delayed_work_sync
> symbol, I stumbled upon occurrences of that function on longterm v6.1
> and v6.6 in drivers/usb/phy/phy-fsl-usb.c despite not being declared or
> defined anywhere. In fact, disable_delayed_work_sync was introduced by
> upstream commit 86898fa6b8cd ("workqueue: Implement disable/enable for
> (delayed) work items") and is only available since v6.10. Neither 6.1.y
> nor 6.6.y defines it.
> 
> Consequently, kernels built with CONFIG_FSL_USB2_OTG fail with:
> 
> drivers/usb/phy/phy-fsl-usb.c:990:2: error: call to undeclared function 'disable_delayed_work_sync'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
>   990 |         disable_delayed_work_sync(&fsl_otg_dev->otg_event);
>       |         ^
> drivers/usb/phy/phy-fsl-usb.c:990:2: note: did you mean 'cancel_delayed_work_sync'?
> include/linux/workqueue.h:470:13: note: 'cancel_delayed_work_sync' declared here
>   470 | extern bool cancel_delayed_work_sync(struct delayed_work *dwork);
>       |             ^
> 
> I reproduced the failure on PowerPC using corenet64_smp_defconfig with
> CONFIG_FSL_USB2_OTG=m, building drivers/usb/phy/phy-fsl-usb.o with
> Clang.
> 
> AFAICT, in 6.1.y, the regression was introduced in v6.1.160 by commit
> 4476c73bbbb0 ("usb: phy: fsl-usb: Fix use-after-free in delayed work
> during device removal") and remains present in v6.1.185.
> 
> In 6.6.y, it was introduced in v6.6.120 by commit 319f7a85b3c4 ("usb:
> phy: fsl-usb: Fix use-after-free in delayed work during device removal")
> and remains present in v6.6.154.
> 
> Note that the same problem was pointed out by Ben Hutchings during the
> 5.10.y review:
> https://lore.kernel.org/all/d147f0eb71f9cefbfb7605e95d98564d7f0ed346.camel@decadent.org.uk/
> 
> The corresponding patches were dropped from 5.10.y and 5.15.y, but
> appear to have been retained in 6.1.y and 6.6.y.
> 
> Simply replacing disable_delayed_work_sync with cancel_delayed_work_sync
> at its current location may not be sufficient: it looks like the delayed
> work can also be scheduled from fsl_otg_set_host and from the IRQ
> handler but I'm not familiar with this part of the kernel.

Can you just send patches to revert the offending commits?  Or we can
just ignore it as it's been this way for a while and no one has noticed
which implies to me that no one builds these modules for these arches on
these very old kernel trees :)

thanks,

greg k-h
