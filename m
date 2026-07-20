Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF78406803;
	Mon, 20 Jul 2026 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548400; cv=none; b=mbLHHjNQtGmuYKNnGbDGJ96+Pt/9b6Gt7IzINsm79k6H8Jw/Wv3rBhooEVkvrrT5qlq3f/1xe1wInTQ+84wb2aY5rpQyqTv9ywhAXk4G0xFnm/01mqcTNjlAzbVUKgot1UJscr9NaJ6Tj1rAQwZ60KJBuMXmWa38SKHyT5YKFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548400; c=relaxed/simple;
	bh=Xq5hJ/LcLYMU3BVfykiyVhoSdE8B+eXO5UdCPug2zfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzKr3ezupIk+NWAm2G3e2mdQPf05i7gL1q+AlpkuFHPOCqruMMIbu0Ke6sxnoI0lNpOZtXTcnds6MDe6OoUWiQpyzGuJHcSfHdhqOq727vrurdHeggLBheQ0BmPNfB43mArOyNECnFPIgctKLTfbKPxKOvW0jItY9Cjfeq8msh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iV3CfCkf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iV3CfCkf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938281F000E9;
	Mon, 20 Jul 2026 11:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784548399;
	bh=gBnFxppqySBfjs+Yu8Bn669JHSlUb2xCcGpXBfWqu3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iV3CfCkfO7yrsVL8wboRWdP7kqjLv/TjXz9iX87TumvPVceScjB74UwRsW5XjdOKd
	 fF37wlRke42HkShcIE5gJpuvmPFrbc8w7+qE4VB4wjLOtESBL6ewsMb7fJpfN3URZG
	 gxCSzA57jRbeWwb91c0ioc+Y7P6GzmiH0oI8MSIM=
Date: Mon, 20 Jul 2026 13:53:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, sj@kernel.org,
	stable@vger.kernel.org, yikai@z1k.dev
Subject: Re: [PATCH] mm/damon/reclaim: fix typo in damon_reclaim_timer_fn()
Message-ID: <2026072053-silliness-slacked-8997@gregkh>
References: <2026072041-rearview-unselect-3f92@gregkh>
 <20260720110232.312053-1-aethernet65535@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720110232.312053-1-aethernet65535@gmail.com>

On Mon, Jul 20, 2026 at 07:02:32PM +0800, Liew Rui Yan wrote:
> Hi Greg,
> 
> On Mon, 20 Jul 2026 11:59:03 +0200, Greg KH wrote:
> 
> > Why is this a stable-only patch?  Did something go wrong with the
> > backport of this commit that is not in the upstream version?
> 
> Sorry for the confusion!
> 
> This is a stable-only patch because this specific function was removed
> in mainline starting from v6.2.
> 
> Therefore, this bug only affects v6.1.176 and v6.1.177 stable branches.
> Mainline does not have this function anymore.
> 
>     $ git tag --contains 2f54908fae21
>     v6.1.176
>     v6.1.177
> 
> Let me know if you want me to resend with this explanation
> explicitly noted in the commit message.

Why can't we just take the same commits that are upstream that prevent
this issue from happening?

thanks,

greg k-h
