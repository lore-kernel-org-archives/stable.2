Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3459B3C8728
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770212; cv=none; b=R0ko2Hwxaf8bNDvXGiuwN3kNn8I/W4TOWLg3xle3u15O80vlGoK5VadJ5pBjgOZe5FM3mdE33fIis0hBDM6M0NwUIF7qv+0CTUuV1i2OfMRjoFAWZk3DTYe7fWS9ubhgz1Rw/pG5rBIUy+U8z+3seNG+5k2aHa3F/is17SSasLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770212; c=relaxed/simple;
	bh=uusixSFs+hHWeHjYQO6cNQyxarokof1WWTgfonvIi10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TA6Ej26zjfK+DK7RZmLe4jxUKgRzNr5B21idhaFKoECksR7uvKaQ7DSYf9S3ah4uGGzk4lq3ll+mpsjjLR9VkE2iTJjmGB7x5gKOWpg4n9dRNM2V1Rcy0X/EoYoyXl2rJdyiGwV7W9fs18s+lR6C9caoSgW2LOX7+1rrpz52+kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ydis2Qo1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ydis2Qo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC651F000FF;
	Wed, 30 Sep 2026 12:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790770210;
	bh=4dlrMeM4QWoqXEkRYB8TrXyY03Si1Ddql5tWqzapgbQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ydis2Qo18+EDInolH4E7e8eiv7QOppSN5hW5w6/lE9YYhEeRTdcBXN0KA+giRsmiA
	 3VUhq1wrr5Vwvpm4fg9z3hgEsU/lfnQxgPkzduMSPK4V6Que8NwONt3y5ebAMnRH69
	 3/cR8WGwrQvdYEyMvZ4whWLW2roxJoScg4C4QoXs=
Date: Wed, 30 Sep 2026 14:10:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Tim Chen <tim.c.chen@linux.intel.com>
Cc: yu.c.chen@intel.com, mingo@kernel.org, peterz@infradead.org,
	stable@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] sched/cache: Skip kernel threads for
 cache aware scheduling" failed to apply to 7.2-stable tree
Message-ID: <2026093056-santa-ecology-041c@gregkh>
References: <2026092935-angelic-kick-1d0a@gregkh>
 <850294df0f51d6ccb131557af74d4a42dde00b3a.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <850294df0f51d6ccb131557af74d4a42dde00b3a.camel@linux.intel.com>

On Tue, Sep 29, 2026 at 03:45:46PM -0700, Tim Chen wrote:
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
> > git cherry-pick -x 65efcccddc83d6a19e8a2e2a6117811e39e589bf
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092935-angelic-kick-1d0a@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'
> > 
> > Possible dependencies:
> > 
> 
> These patches in upstream needs to be applied first before this patch:
> f0d243a96f268 sched/fair: Avoid creating misfits during cache-aware balancing (should be included in stable)
> 28f9c0e0a0b94 sched/cache: Decouple sched_cache_group from mm to fix UAF  (just merged in stable)
> b636fef85bda7 sched/cache: Introduce task_struct->sched_cache_grp to fix UAF (should be included in stable)

Can you send a proper series?

thanks,

greg k-h
