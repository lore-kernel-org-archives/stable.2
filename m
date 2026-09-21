Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DD849159B;
	Mon, 21 Sep 2026 11:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991177; cv=none; b=E27eFbg0gCxRiwsfe6rdxfjgg9GcP55c1OM4m3ZNvsjnqyr0F3BJgOlYPIPYjwW1X9BvHD5OXe32vVi55sRDTLc+DihfiAJIzu5JJ4xZLEUGLmxqwJJ/5fT9L5KTGBXp1ftmIW505maiLohyIbsIbi6r2leoA7PRKGV/w33fdq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991177; c=relaxed/simple;
	bh=aGolHchF69pSgYYi/IrKtjjJxe6CCoPdbFiSHyQOrOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OpCKNAyECtlx+Z3GldHTquJAKgGLPyrh7/nIVNKVNogMl3CcEs63iDoMdJMIXv+u9QUjpfM/geu959l+iRMgjij0YCD2a3XXCLiBkbDw+/AKTRj95ZLbiz9iJMAIK5tcKXKV7YUr3Q+fpjBcnOI54xOVXtHvy1Bz8W/xNiOxC0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a3yvm8UI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a3yvm8UI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5401F000FF;
	Mon, 21 Sep 2026 11:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789991175;
	bh=Bv17kNAfr+GWReaGWxmR3kN67ZtV/gUAsC1CZBpezIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a3yvm8UIribTaWHkkdKkMq16EsJ9fl3TfsqIXKIPViYxYqNy9wilZlSiYc1SjT4np
	 EOsca20qg96+26UeJRSqEyShE/SYBxR4rMMT1ZfEnChNxW+1lfHQ18tzLF4hGUDS7e
	 ehMs6dPxjozJjPqfl0zKdut2mQO3kBlwPLcfI+Fc7hhiUFn0zmTWnNeZuh5oRyHzwZ
	 sIEGJL9JYq0KphlaQ0U99eQG2065/RssXY0mn0heUILEwfFImvd48pt0bvt0DivbkV
	 BcB8+7vBWYCV6DGw9iwhVz4PetdgZeWOoxZPBg1PAlgjVFDufOjZRe+RggvOTMmoR/
	 wdSGD8aIgBkmw==
Date: Mon, 21 Sep 2026 13:46:10 +0200
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org, 
	io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/7] fork: refuse new threads while a coredump or an
 exec is in progress
Message-ID: <20260921-aufwiegen-festwagen-ozonkonzentration-ffe78eafa8fa@brauner>
References: <20260917-work-coredump-fixes-v2-0-f3787fcda051@kernel.org>
 <20260917-work-coredump-fixes-v2-1-f3787fcda051@kernel.org>
 <aq0VLTyxNatFmLOK@redhat.com>
 <20260918-irrsinn-pickt-vermummen-d7167c397398@brauner>
 <20260918-disput-maden-parkdeck-2bc22dd90398@brauner>
 <aq0_lvHDViIpX_Mu@redhat.com>
 <20260918-elstern-potenzieren-marotten-71ebd0744753@brauner>
 <20260918-oliven-lebst-wohltat-c633868711f1@brauner>
 <arEHxPFFrRtvUSPJ@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <arEHxPFFrRtvUSPJ@redhat.com>

On Mon, Sep 21, 2026 at 12:32:36PM +0200, Oleg Nesterov wrote:
> On 09/18, Christian Brauner wrote:
> >
> > zap_process() skips every thread that has PF_POSTCOREDUMP set.
> > do_exit() sets PF_POSTCOREDUMP in synchronize_group_exit() and calls
> > io_uring_files_cancel() right after that.
> >
> > That runs task work, create_worker_cb() runs and creates a new io-wq
> > worker. If a thread started a coredump rgith before that worker gets
> > created from a thread with PF_POSTCOREDUMP set which zap_processes()
> > doesn't see. So two ways of fixing this:
> 
> Christian, I got lost ;)
> 
> TBH, I don't understand why the new io worker is really bad in this case.

zap_processes() only counts threads it sends SIGKILL too. But every
thread that later finds ->core_state decrements that count. An io-wq
worker created from the exiting thread isn't counted and exits right
away because the io-wq exit bit is already set. So it decrements without
having been counted.

> But lets forget about coredump/zap_process. With the change below the
> io_uring_files_cancel() paths will no longer be able to create a new
> worker, even if coredump is not in progress.
> 
> Is it correct?

Yes.
