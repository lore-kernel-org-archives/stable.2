Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAD1478E51
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330048; cv=none; b=Fu7OqhjNTKRK4v6X6bE2Aa68gU0OVoaI3ws8HvjNAfF6v40jkB7zqYLc9QwUwliklE0tF5zAAbSMjLbLm0cEB2PTLEX6H3u/uL8FUSJ+oeARNHwmnxEA5555tbDR8ho4NJUCKx7T7Vs2S8MjX8Z7dAO+seHSn0i0S+fdNym46t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330048; c=relaxed/simple;
	bh=rlVE9YWQPh36iqr67g1bGTaonjgcgQ48S78TGYsExfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHHOXiOY79sgOztJzdvOWLghuN2U957yrbfDdXsMa/A63fO3YkTwQpwrkb19ZeTfTvYmt712FCws+Jx1mDsEMgIAe4jzk3LZGvnnAZeIzCE1ta0WifhC4+YsYc/k6adAzacPH2vFKBsGboVXHDs54YlOQxCVAfk+UEBEbn24js0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D8nxjzQp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D8nxjzQp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CCD71F000E9;
	Mon,  6 Jul 2026 09:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783330044;
	bh=xf+RPcaEtEZGSlMseuJMWcV/tNux9CLmNcr0O8HzctU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D8nxjzQpi65fd1TPMI6r62VTL862a79Tbcv/IOt+YkM4b90BUe1EBcMlWfK4h0qD3
	 hfxUEPAHlK25lM/giHcUcLBqJ9vWjwKJ88uzWhl76q0uELY1MXEcdjjKJo5n0gWQs7
	 ugkerIsTAMIwLSHasXNkZOLymovfouiFLAlnGLFc=
Date: Mon, 6 Jul 2026 11:27:33 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: stable@vger.kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
	Jon Humphreys <j-humphreys@ti.com>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH v6.18 0/3] ARM: PREEMPT_RT backports
Message-ID: <2026070604-washday-tightrope-dcee@gregkh>
References: <20260629144131.788576-1-bigeasy@linutronix.de>
 <2026070229-rendering-plus-be9d@gregkh>
 <20260706085940.3lUHUu8z@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706085940.3lUHUu8z@linutronix.de>

On Mon, Jul 06, 2026 at 10:59:40AM +0200, Sebastian Andrzej Siewior wrote:
> On 2026-07-02 16:06:48 [+0200], Greg KH wrote:
> > On Mon, Jun 29, 2026 at 04:41:28PM +0200, Sebastian Andrzej Siewior wrote:
> > > Hi,
> > > 
> > > ARM missed the PREEMPT_RT window for v6.18. The following three patches
> > > have been merged as of v7.1-rc1 and are the missing pieces.
> > > 
> > > I've been asked by people if it would be possible to include them in the
> > > stable tree as it would make their life easier.
> > 
> > Why can't the -rt patchset just include these?  Why put the burden on
> > us?
> 
> It is part of the -rt patchset. I've been asked if it would be possible
> to include it (ARM support) as part of -stable tree. I've been looking
> at what is missing and it included two Kconfig changes and one code
> change. This looked small so I thought maybe, why not let's ask. I'm
> sorry if it looked other than asking.
> 
> If this puts burden on you and it does not qualify for a stable change
> then it can't be included.

Please let's have new features stick to feature-patchsets like the -rt
kernel is, and not put that burden on us stable maintainers for
something that we don't use :)

thanks,

greg k-h
