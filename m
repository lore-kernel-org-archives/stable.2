Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3E2383C86
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786117815; cv=none; b=KPi2q1OLqCZe3pr1m9PnjI+VFM7+zNzdPegPDFMUu0LJYFwBvKYBkhUAInEoAKA0ev9MfvJvkB+w9Yd6epZGZCY+z6bGCL2wo75IITZHhwjNJ8JqgpMlppJdwNSLhukjVF6CQExgkG9o7lqc99Yt8BA1ESUR7Kyi0WMAYbnIISo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786117815; c=relaxed/simple;
	bh=QbUtojPTD4aOQBSKBcz+wFCj5ZOdJ8/PhlgtI72Yvsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LadaoUu+8dnMm8tX6p4A7b5ygqjcXyQP+gwt1lW1TsCxJbsAHNDZ04Fj9D+jgONkEc/h3vOUEp/34xDuSt0ecdrJkWd4TEvVbykuqRcoVKzBEzB73d37IM3AehWYFhq+cPG3t0Ei9/LLGWnOgNz3NhDOljzcyyM6BAZkfIMuBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e4qDJR37; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e4qDJR37"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E0B1F000E9;
	Fri,  7 Aug 2026 15:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786117814;
	bh=cPSJpOWrP7qK8P7Gd6UkMQyChHqasekhOMlXz1EYIW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e4qDJR37FZpPaqKAGA7cNDxGnxuCUmMPsTH+vDtdeVN1Uaic/2+AqPs7XgHPi4oqC
	 FF6sCg0SydhIw3IbFWHVhPskUUW3nEGB3Dk1vV4+XH8Vn5tA3FFFgl2N1mmZq1+vpq
	 IToBLE02tkROQgSbxkrHkI1h1nzggjVx3xgfRe3E=
Date: Fri, 7 Aug 2026 16:44:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthias Merz <linux@merz-ka.de>
Cc: stable@vger.kernel.org, Dong Chenchen <dongchenchen2@huawei.com>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [6.12.y] Please backport 8045c0df98d4 ("xfrm: Fix dev
 use-after-free in xfrm async resumption")
Message-ID: <2026080738-eastward-nimbly-e78d@gregkh>
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

It does not apply cleanly to those trees, please provide a working
backport that you have tested and we will be glad to apply it.

thanks,

greg k-h
