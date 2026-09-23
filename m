Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873BF331EA8;
	Wed, 23 Sep 2026 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155956; cv=none; b=odoFXQz3X4AkOI3LBCeayq6JKXzJQrN2271gGgT+iLsnmMg2hZI1dI7S3m55zyD6IkN5n3DoBv7ntdVOeTNe8FkY8KinYfqaZXH7mDUMeh/u4+HRlMXql57L3MVpcz7LEod7SeFdoCbHJ3frF2TJqm+ZT/r6vuA/+uv3P3+HZC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155956; c=relaxed/simple;
	bh=/fGhebiIle0VPPpn50TZh6ODmCVw+eIKhoz1LRhYUNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D70O/3H5z5PS4heAAFufqf7z07Cdr+/Xt2H8arkK6SpMhBvjMJWyLff4Kr7m0YQHPWrKE1XvS9MUxtIqj00SZRqh0Efq81+Md4+9gPS3kVYTAZKXt/i+428MM/lWlzSuaS/0wJFzgQ/rc8Z/ofN/z90NyIDOynyAZASE4/zKSs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I4litci7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I4litci7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822141F000FF;
	Wed, 23 Sep 2026 09:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790155955;
	bh=sNt5KnxJRZD+grNAr4ot3j9mvRIp1u7YUOTcjGAqqbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I4litci7C6wdQCykj+8mXCTqldq1Afp9OdLmRwdFKwytSQ9XSggIy47wkFCbVt2LB
	 0EysbFeEW8pDYNw2zD0hSDmSDjJXt8ssb/j/eHkDVaQRTYxSZLyZanEyQi17d7gfim
	 jDCMD+yfeZIFMerIGb9ccNdVW5IEYDm2kr6HMyHE=
Date: Wed, 23 Sep 2026 11:31:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kusuma DS <kusuma.ds@alkira.net>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org,
	Chakradhar Kar <chakradhar.kar@alkira.net>,
	Ramakanth Gunuganti <ramakanth@alkira.net>,
	Sripathy Ramaswamy <sripathy@alkira.net>,
	steffen.klassert@secunet.com, sashal@kernel.org,
	dongchenchen2@huawei.com
Subject: Re: [6.12.y] Please backport 8045c0df98d4 ("xfrm: Fix dev
 use-after-free in xfrm async resumption")
Message-ID: <2026092316-mouse-scallion-6eb2@gregkh>
References: <CAMcJb7NLooAw=6Vyzbq-7JnE9L=gfTbLL0Y=L1pTFMTg3Vf76A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMcJb7NLooAw=6Vyzbq-7JnE9L=gfTbLL0Y=L1pTFMTg3Vf76A@mail.gmail.com>

On Wed, Sep 23, 2026 at 01:23:01PM +0530, Kusuma DS wrote:
> Hi,
> 
> 6.12.y picked up a bug without its fix. Details below; the request is to queue
> 8045c0df98d4 for linux-6.12.y.
> 
> The issue: on every packet whose ESP decrypt goes async, dev_hold() is taken on
> the ingress device but dev_put() lands on the VTI, because vti_rcv_cb reassigns
> skb->dev without taking a reference. The VTI refcount is driven negative during
> normal traffic, and a later `ip tunnel del` then hangs forever in
> netdev_wait_allrefs_any(). The process is stuck in D state, unkillable, and the
> netdev is pinned for the rest of the boot.
> 
> Introduced in 6.12.y by:
> 
>     4236c30b437b ("xfrm: hold dev ref until after transport_finish NF_HOOK")
>     = mainline 1c428b038400, backported 2026-06-19, first in v6.12.94,
>     together with its dependency af4b8c5e9d6d
> 
> Fixed upstream by:
> 
>     8045c0df98d4 ("xfrm: Fix dev use-after-free in xfrm async resumption")
>     Fixes: 1c428b038400
>     mainline v7.2-rc1; in 7.1.y as 63a300151999
> 
> The fix was not queued alongside the commit it fixes, and is still absent from
> 6.12.y as of v6.12.111. So every 6.12.94+ kernel carries the bug.
> 
> Confirmed on 6.12.96+deb13-cloud-amd64 with a strongSwan tunnel-mode IPsec VTI
> under inbound load; kernels up to 6.12.93 do not contain the code and are
> unaffected.
> 
> The fix touches only net/xfrm/xfrm_input.c, net/ipv4/xfrm4_input.c and
> net/ipv6/xfrm6_input.c, against code 6.12.y already has, so it should apply
> cleanly. I can test a 6.12.y-rc against the reproducer if useful.

It does not apply cleanly.  Please send a working and tested version if
you wish to have this applied.

thanks,

greg k-h
