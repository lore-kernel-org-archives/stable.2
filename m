Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C22F4CC63E
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770153; cv=none; b=bhuzo9taOW+AujMImCfPTpdnb8/E4IhdlILvw0EQrqlrHgEjPVj6lXNj4hv0pSccvTdHtmz1/u2pz5OpLZK+9DyXrY5oQmqKLs3T8cytnBh+rDsj5n7DXuPYSGYo+4t94fnCTQxVK4d023UvnFEDlREzpI+Q0RVq05yMuNI4l50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770153; c=relaxed/simple;
	bh=FxSlLuOL9KCfWyLyJLylmSmbfZSt+pkR4Lpq2jsa8NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/zBtLN2GSh4T7bU8tYm3Ru7rlhNa/gZzqC9Eubx1UfbUGvVMnpPSNyOj8mm+wgZmI72TZETEnyiZKFqjblTvjltN2bLp/ktx/8rb9U0vyqlLOGeS/uUp2bJ3JMAH3v3qmrgyS6d1ittjVybHwEQJCEpmM6zDiXuw9pFt+bRsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UyzhT3CS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UyzhT3CS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FFD1F000FF;
	Wed, 30 Sep 2026 12:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790770151;
	bh=DtaP4e5Bd5UkQTyLRH2B0IvbCskIjF3jo9ILUkOQAkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UyzhT3CS+Z7PGdmGFM104sxY8tGF2Ai82WigQHNJzRrTnJgFLBsYLJ2b9aVOKTbVQ
	 zS6fAXIPTqO2XfmSpdEWt619SjpsKno0OUzxCHc1ZKW4QBa/d7P2HpLk7BYSsdpkkR
	 twOY6woIeKTTyg/+phvXRxwFK1O60N4E1Oj4PfrE=
Date: Wed, 30 Sep 2026 14:09:05 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: imv4bel@gmail.com, mingo@kernel.org, peterz@infradead.org,
	stable@kernel.org, yu.c.chen@intel.com, zenghui.yu@linux.dev,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] sched/cache: Introduce
 task_struct->sched_cache_grp to fix" failed to apply to 7.2-stable tree
Message-ID: <2026093035-icy-record-89af@gregkh>
References: <2026092927-ageless-staple-093f@gregkh>
 <c7d8a3ec020497a7b15ae3080b8de4f7363ebe0a.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7d8a3ec020497a7b15ae3080b8de4f7363ebe0a.camel@linux.intel.com>

On Tue, Sep 29, 2026 at 03:06:00PM -0700, Tim Chen wrote:
> On Tue, 2026-09-29 at 13:43 +0200, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 7.2-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x b636fef85bda7d1bab9c0a45067ab1508d79d946
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092927-ageless-staple-093f@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'
> > 
> > Possible dependencies:
> > 
> 
> These patches in upstream needs to be applied first before this patch:
> f0d243a96f268 sched/fair: Avoid creating misfits during cache-aware balancing (should be included in stable)

This one does not apply :(

> 28f9c0e0a0b94 sched/cache: Decouple sched_cache_group from mm to fix UAF  (just merged in stable)

Already queued up.

Can you send a patch series for all of these that properly applies and
builds so we can apply them correctly?

thanks,

greg k-h
