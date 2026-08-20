Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F5443E076
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787228475; cv=none; b=P+0s6czJhNLJOJw52U9RNY7Prj02umWbOZo6nNDcgcwnNCPknuHV5kWLwo3Mz6/5SB8hiRnbSy97BfYBcH9wWz6PEZ6xwB3RfI/gZq5UhEwGjjZdZ5q5P/YHrJZ5TeU0cFoFZAeMcrkujLcV8ppD8MFnuVkf6BSV/n2DobLmhOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787228475; c=relaxed/simple;
	bh=KzQpZScLIGIAjmvsBiyPR3hNhm0W/xMBso9h2Z49aC0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciHxX1DMtgshxwxArd9FPTBu4kITslf4bvZXUysZW0OKGHC5Ahv2ji4bRdHRfSSGIlG8boJyKngU7L4Uuz5rjMY+8xkNWu3+UIRFlvy3PM/MT//dmsFFojGSRPWwMLnX4ZbGVDeIWJnM6Xnwbvl0U+mTCqAb3LPrRVNLMng6+60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x0SXNnes; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x0SXNnes"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E55F1F000E9;
	Thu, 20 Aug 2026 12:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787228474;
	bh=79UrSvjUu30ipOJbFRGGGpKjoqk+Gh0FUlxAdtpX/s4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=x0SXNnes0k0iGyKrDKMI1APj8kKtlVPYHKWu41u93KJ/2aFRlotV2S2tLGohIbNax
	 d1snCpFSJNXiTkLTZVY1/tDAA7m4JAaRMcBsySqWLNbGi2if1x1Po5Zd6aHJHJd8HF
	 7AKTG3PtCfvdTLyYDvFH9GBsrp0eDVKcIi2ucS5w=
Date: Thu, 20 Aug 2026 14:18:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthias Merz <linux@merz-ka.de>
Cc: stable@vger.kernel.org, Dong Chenchen <dongchenchen2@huawei.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [6.12.y] Please backport 8045c0df98d4 ("xfrm: Fix dev
 use-after-free in xfrm async resumption")
Message-ID: <2026082030-google-authentic-ad63@gregkh>
References: <anXqAxQBTgPtQSXT@C-25H12I214949.jacob.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anXqAxQBTgPtQSXT@C-25H12I214949.jacob.local>

On Fri, Aug 07, 2026 at 04:21:55PM +0200, Matthias Merz wrote:
> Hello,
> 
> Please apply upstream commit 8045c0df98d4 ("xfrm: Fix dev use-after-free
> in xfrm async resumption") also to 6.12.y. Stable 7.1.5 contains this in
> 63a300151999.
> 
> It fixes 1c428b038400 ("xfrm: hold dev ref until after transport_finish
> NF_HOOK"), which is present in 6.12.y since 6.12.94. On our IPsec
> gateways using xfrm interfaces this issue underflows the interface
> refcount and hangs unregister_netdevice() on tunnel teardown, rekey or
> system shutdown:
> 
>   unregister_netdevice: waiting for xfrm-<ifname> to become free. Usage count = -381
> 
> This leads to a complete drop of our VPN links after some hours, and
> stalls the reboot for a couple of minutes waiting for devices to become
> free (I remember waiting 10-15 minutes for the shutdown when remote
> rebooting a gateway without physical access)
> 
> known affected: 6.12.96 and 6.12.96, known unaffected 6.12.90
> Fixed in 7.1.5 via 63a300151999.
> 
> Maybe you could also consider having a look at the other longterm
> releases, but I have no insight where it might apply.

Please provide a working version of the backport for 6.12.y and 6.18.y
and we will be glad to apply it as it does not apply cleanly as-is.

thanks,
greg k-h
