Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760523;
	b=e8f53Dy/EFE5poxUnoGSn+KCUOl6iEkboxmWZe66nXKMHz/U2BTUQM3ey84KTPLIU9BE
	 kGgAXP1sXZqKI5eR/0W56MKXyoM+xYqUZfraT1Yea8L6/k2t4rM02v1TqmqOucwVOq3y8
	 XxHa54QgzqhL5AmbRZ8pht7ZF1LmgokbINEnJ1TqXYQ/Ge+0bHtR46nZm/eOcDVP8B2I7
	 /dDFlwZatxXgaoztTeg7e3Tdlpme5k8DFeDiWkmIZP4isvPPnABgaBYx50s0ywpUdFKfy
	 Ti15UwlL7aWoir9j5KCl2/8Nn9mPW4qPQzcQKpPALS4JhHiPod/7PazYKv39tWt7QcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760523;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=HdTceXF/VTdv7WfIKt6WYyyNHKWsIb3Avw/qVXMQxzY=;
	b=QI5p2iLrdJ0/dk+jne+Sb5/n2bp3JCNNjUZn9yClBqoc6xNYjsUCrVqraQuFFSqJPU5F
	 WpKBJlGuFRZ8JzLuF6x3FlJ67Vt6VWhckd2seB8kmm5JXZjXcxBUS1emUJOg6KGA+AdFP
	 0ftOB5bffrZwKUOLgiaRv0UattqKaWeNxQXFY9sMFN+VUTygJqhDPl51RqrLuWmydGDz8
	 KSS4sbjiTgLj1FAEy/3m194QI2AfrKvEVQ80pz7H2cTyIaMBdvbrOZzF3vQ2kilnvPINg
	 9MS8M/18pB3q7o8V7YWLH3jfY/k8tYAuS71B7fIEcytf5odp5W+/BiHS167G1+i73dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Y+ZLzmhf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDB7606A31A;
	Fri, 23 Oct 2026 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Y+ZLzmhf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7613D1F01825;
	Fri, 23 Oct 2026 13:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792760523;
	bh=HdTceXF/VTdv7WfIKt6WYyyNHKWsIb3Avw/qVXMQxzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y+ZLzmhfm/bq0uTfqPDRDnlWh876qdnPiT/h86V0977XP+OD0y20bKOjr7JfMey1n
	 0auFCN46huTatPKWVBcXIBcE43tDeP1H/x/dQjCTfxaP6v65qsJAyxzxmgNLJlBmGp
	 mRNvyklsRy1xNbHrxxICN9nCW93HZNirf/YbNS8Y=
Date: Fri, 23 Oct 2026 15:01:25 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: Patch "sched/eevdf: Move to a single runqueue" has been added to
 the 7.2-stable tree
Message-ID: <2026102336-deodorant-repressed-45e8@gregkh>
References: <20261021115034.4170616-1-sashal@kernel.org>
 <20261021131517.GN2823843@noisy.programming.kicks-ass.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021131517.GN2823843@noisy.programming.kicks-ass.net>

On Wed, Oct 21, 2026 at 03:15:17PM +0200, Peter Zijlstra wrote:
> On Wed, Oct 21, 2026 at 07:50:33AM -0400, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     sched/eevdf: Move to a single runqueue
> > 
> > to the 7.2-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      sched-eevdf-move-to-a-single-runqueue.patch
> > and it can be found in the queue-7.2 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> > 
> 
> Ufff, why are we backporting this?
> 

It was to fix:
	Stable-dep-of: 2f93bcb3f9aa ("sched/fair: Avoid overflow in place_entity()")
but that's a mess, too many follow-on patches needed here.  I've dropped
it and a few others.

If someone has a "simple" backport of the above commit, we'll take that
instead.

thanks,

greg k-h
