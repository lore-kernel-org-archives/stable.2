Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FB23C1F45;
	Wed, 19 Aug 2026 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787164230; cv=none; b=hHcnFAZRpGguzu1d3QzdZQrMyIIfMbxL+XCUul0ImA6Entvrw5aFugEtwDAldvSANnuZzzDXR7epVMwas5YnkJF86z0gPzsvd67HkgNsT59bidgxP825cbz0c3fw9PMlcihQF9z7aqzSSqvyveaDPOj+/vj76UoPDhPgq1kqXnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787164230; c=relaxed/simple;
	bh=EozIj19Q2yBeOKIgTXyY0fdexWuZoPW64RCQOaFGdTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=neBHeByggtLoLTnVGMxy0rWSbsNlKP7on2lI+TNSRp+jg19UnMfYEKA/3yA/3h85U+uNSY5iDUhSqsb3JRigdTDM0OEGFmtMUaV81pAPbF8gy4iQKPNRUEgMkZcPaPoeJbwcB08SEKvN852LVEQ8htQPtFe0Ox7CVvY4S5wvdbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+hTXVTT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+hTXVTT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B921F000E9;
	Wed, 19 Aug 2026 18:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787164228;
	bh=DeF3PyNzWGkZKxotm1I3WQHx9rcWHnpKPJu3ApQG1jE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F+hTXVTTDLGzyYaUmwdSaG3sm0zC5AToT5GtMsTG11trwunxzM4w2dtjYxfBFj8r7
	 CAq/UtNgEoMo0490bX5Ws/jU6eP0deFp8DyFJpz+sOGeUIAMJW8SFuccKg7j0skCrH
	 iDM1+wJcAXIRC2H2IYfZm8OqFwcdXBIjB84kUihHXP4+ZO/5MiEEw0ftYyBnwvzRBw
	 8EUTcbOQa+r7fti29shjWWfovIsi3SOMYRp8ZED6xd7NORif0mkfG1LbDlf7NmjwF9
	 ogYzUXuqjJ04dK7NjhvWFGtoZM53omJm0C/C3fJKHMKvFaXAeIYx3MP5KBhob4QzYb
	 tyNALo1V5OSJA==
Date: Wed, 19 Aug 2026 08:30:27 -1000
From: Tejun Heo <tj@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>, ElXreno <elxreno@gmail.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/6] sched/core: Handle pick_task() releasing the rq lock
Message-ID: <aoX2Q6VLHHCddHuA@slm.duckdns.org>
References: <20260807210221.232543-1-tj@kernel.org>
 <20260807210221.232543-2-tj@kernel.org>
 <20260819093751.GI1247881@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819093751.GI1247881@noisy.programming.kicks-ass.net>

Hello,

On Wed, Aug 19, 2026 at 11:37:51AM +0200, Peter Zijlstra wrote:
...
> Suppose the SMT siblings CPU0 and CPU1; this core sched pick nonsense
> runs on CPU0 and does that multi pick thing.
> 
> For CPU0 it pulls a task from the global DSQ, places it in the local
> DSQ, and returns that as the pick. No retry, all good.
> 
> Then for CPU1 it does the same, but hits a RETRY, so it stuffs the task
> back on the global DSQ and return RETRY.
> 
> Then on retry we find a FIFO task on CPU0, because lock-break and all
> that.
> 
> Now we pick the FIFO task, but have not had an opportunity to put the
> CPU0 task back into the global DSQ.
> 
> This is still possible, right?

Yes, that's possible but it's not different from the task being dispatched
and starts running and then getting preempted by a FIFO task or the CPU just
losing to the sibling's pick. Tasks being staged on local DSQs doesn't
really break anything. There's the question of whether we're triggering
reenqueue reliably for SCX_ENQ_IMMED tasks for all siblings, which I don't
think we do for core-sched path but we can get to that later. That's an a
lot less severe problem than oopsing at least.

Thanks.

-- 
tejun
