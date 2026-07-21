Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C866538BF7A
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 14:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784643603; cv=none; b=XecM28HvsdDLQiNbvdLpxBw6wu5nbf8U9bvw3iwsVQvslQi2Onh0QOINDI8ywlMJ2KJ2GYPlYxq/7htw77BKTIUdRAK40EKxxRgFFdMMCAQEL7Nz9ewAkgkX+rc41mMNbFwByp68nicn718oS2CHaFyd7S4GzkrUm1CQuMuqziw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784643603; c=relaxed/simple;
	bh=A8prulnmm1ga4lGE0sSVb7k9ebeGh22GsYjy2De6KbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PyXhpg0vS7btPhURnC3+L92fHpoj8RJHx/dOvEkVy+R0I2tkqplSQaPb6OH6oh3AIfE1f5nP29UWfCbYgb90gvsWRqhoelx9VW3yKkFKbK59nyZ1lKgpMC6Rcoskx3XwyKpqx1RWnTlGkQmBuktfFiBtie+C7HYxNrhUD21gOfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rj9WAW9D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rj9WAW9D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF391F000E9;
	Tue, 21 Jul 2026 14:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784643602;
	bh=fXsy5s6X0GiJ+rg0BUYJHNte1Bc0GoGmEsDjTLomVpM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rj9WAW9DXFKlLy82fd0VXcuuUhmenPHaIY8Fuwgg8Xc3HDkukDJPWsiELztecNSfP
	 OMTUj9NI9LwM6wXuFlPxox4L1JzoqF3yMicGqPt1Od8807VWs1u4FMRqlK578xEJMG
	 BJ9MAGiPX89f52Afxfa9FBC5RdpcL8vftt3or3xY=
Date: Tue, 21 Jul 2026 16:19:53 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kuba Piecuch <jpiecuch@google.com>
Cc: tj@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] sched_ext: Skip ops.set_weight() for
 disabled tasks" failed to apply to 7.1-stable tree
Message-ID: <2026072139-phrasing-scroll-e4fa@gregkh>
References: <2026072131-citation-reshape-587c@gregkh>
 <DK4AN7P1B5KK.15R8G3B5L5E85@google.com>
 <2026072141-spotless-tarantula-5421@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026072141-spotless-tarantula-5421@gregkh>

On Tue, Jul 21, 2026 at 04:19:02PM +0200, Greg KH wrote:
> On Tue, Jul 21, 2026 at 01:47:04PM +0000, Kuba Piecuch wrote:
> > Hi Greg,
> > 
> > I'm unable to reproduce the failure using the steps provided.
> > The patch applies cleanly. The code compiles and tests are passing.
> > 
> > FWIW, below is the patch after cherry-picking the commit:
> > 
> > Thanks,
> > Kuba
> > 
> > ------------------------ 8< ----------------------------
> > 
> > >From adc748e669cc1564255430299abf086b9ecd9b45 Mon Sep 17 00:00:00 2001
> > From: Kuba Piecuch <jpiecuch@google.com>
> > Date: Fri, 10 Jul 2026 14:43:41 +0000
> > Subject: [PATCH] sched_ext: Skip ops.set_weight() for disabled tasks
> > 
> > When switching a task's sched_class away from sched_ext, we get the
> > following sequence of events in __sched_setscheduler():
> > 
> > sched_change_begin()
> >   switched_from_scx()
> >     scx_disable_task(p)
> >       ops.disable(p)
> > __setscheduler_params()
> >   set_load_weight()
> >     reweight_task_scx(p)
> >       ops.set_weight(p)
> > p->sched_class = next_class;
> > sched_change_end()
> >   ...
> > 
> > Notably, ops.set_weight() is called _after_ ops.disable().
> > This violates the expected semantics of the callbacks, the expectation
> > being that ops.disable() can only be followed by ops.exit_task() or
> > ops.enable().
> > 
> > Skipping the weight adjustment for disabled tasks should be harmless
> > since the weight will be recalculated in scx_enable_task() if the task
> > ever rejoins SCX.
> > 
> > Fixes: 637b0682821b ("sched: Fold sched_class::switch{ing,ed}_{to,from}() into the change pattern")
> > Cc: stable@vger.kernel.org # v6.19+
> > Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
> > Signed-off-by: Tejun Heo <tj@kernel.org>
> > (cherry picked from commit 0e2f4ab68a89fad42e0f5a9ff4b740738e7aa1d6)
> > ---
> >  kernel/sched/ext.c | 11 +++++++++++
> 
> If you look, the original file was:
> 	kernel/sched/ext/ext.c
> your cherry-pick fixed that.
> 
> I'll take this, thanks.

Nope, the whitespace is corrupted, please send a good copy.

thanks,

greg k-h
