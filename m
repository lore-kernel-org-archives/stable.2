Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553123672B0
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781719784; cv=none; b=C7UKXFNoSwUrOZBiRkU/3WTMwxYO/UlOtV+M7djyDpVtsXp+KG/TyTEzhmWxJufuiD7NxoUuUvBwSdcIGnMA/dYMUtEd5VEvwQ5odhVXTYr2IKtGmQLs8dWJxIOdExgU80RcN5dMcF2z2gGKraSxUCLXU+Ht0Hkl9y+Cufw8NFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781719784; c=relaxed/simple;
	bh=D/h9L/UU5IrLAgPpZD9DokP02h4MaKEMa+ynTC5wr5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmW3vXl155QaCl0TmCX1DNzoTbMm72yrbdqfB09lewDE9AO43uu7UiORISgpzEamsuJd9I5MeSakpFjEDZtdVZ6sD2l0SWtMBVXYWeTC9LILGpDVhwSgYZ1DuxWz7WNbWIzbP44BuYqpyv2ibTHVWIhmEpiqTOfDDGFm5wfQQmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P85CGUv6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P85CGUv6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2308B1F0155A
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 18:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781719783;
	bh=QnCTxMfzth94PQEfsdKbicmQyRbNjGL2DxZDY803+4I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=P85CGUv6if44gPxptsH0lnpEI9y8s4L7UlXzSvAiBqbWmCQyKWcPWcnIdwjodG86j
	 1WNKWjfF+FD8FwBgHEwxnN7Wd5bZqfTfD0O/3TX67TDqR7C5zRLM/gjoRNDjgsnSpF
	 GORS80QoFudpjmmFX578+77ig1s0SqgvoXuNa7pruYKZ7LLRqmYeY0LG7fQeqwWqV0
	 cf9fCSe9UeUco6FnlTksU7hCp+gDlkQ40cFWiJdX5xp+pZ9+J4sSfKdMPZRReipEZt
	 NPkGlMRBmFPflhU7c8wZpDGynXdPUz6DN+k9HSB1Q74Zw11C2rIKqONloOBikfRTmo
	 MHZUICEE1WIgQ==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3967620ceabso1310651fa.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 11:09:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8BJFVtonHGznY/TwTzd5PsjO6YwfzcJHwld7MJtIFemxvv6pFTGq6Fc1KnNCxc6+Q8zc4avbU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5OlehFvkQdoB5XMDsYCPVAsHM/AMbNldVy1bTz8B4d4DBzuzn
	wI85j1rliIuADjabozH8TzcoOnlSJH32TZKN1csPVpUehH0cWr6hevmq5S28DnppRalCYZbN0E+
	HFML8Nqy6NNb17m9TfvW4MDzonJOzAxk=
X-Received: by 2002:a05:651c:1582:b0:393:cb61:17e9 with SMTP id
 38308e7fff4ca-399777bf7b3mr1258941fa.17.1781719781538; Wed, 17 Jun 2026
 11:09:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616154733.2405236-1-zhongqiu.han@oss.qualcomm.com>
 <8d3ddc27-5024-4b9f-ac84-f3d92f35246a@transsion.com> <0767a224-d988-46d9-a535-2b490d990287@arm.com>
In-Reply-To: <0767a224-d988-46d9-a535-2b490d990287@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 17 Jun 2026 20:09:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iS+NA81z6Z42e9d-frjON1QHi1bopBZg5OApObQ331PQ@mail.gmail.com>
X-Gm-Features: AVVi8Ccr9VFwIcHGjWa3Cfm_lM0CuX9rYalmB8mJZe1VR8jyKlKfYV86_rLw7qc
Message-ID: <CAJZ5v0iS+NA81z6Z42e9d-frjON1QHi1bopBZg5OApObQ331PQ@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: schedutil: Fix uncleared need_freq_update on the
 adjust_perf path
To: Christian Loehle <christian.loehle@arm.com>, Hongyan Xia <hongyan.xia@transsion.com>
Cc: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>, 
	"viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>, 
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>, 
	"dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>, "rostedt@goodmis.org" <rostedt@goodmis.org>, 
	"bsegall@google.com" <bsegall@google.com>, "mgorman@suse.de" <mgorman@suse.de>, 
	"vschneid@redhat.com" <vschneid@redhat.com>, "kprateek.nayak@amd.com" <kprateek.nayak@amd.com>, 
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 9:28=E2=80=AFAM Christian Loehle
<christian.loehle@arm.com> wrote:
>
> On 6/17/26 05:06, Hongyan Xia wrote:
> > On 6/16/2026 11:47 PM, Zhongqiu Han wrote:
> >> The need_freq_update flag makes sugov_should_update_freq() return true
> >> regardless of the rate_limit_us throttling, and is cleared in
> >> sugov_update_next_freq(). sugov_update_single_freq() and
> >> sugov_update_shared() go through that helper, so the flag does not
> >> persist there.
> >>
> >> However, sugov_update_single_perf() (used by drivers implementing the
> >> ->adjust_perf() callback, e.g. intel_pstate or amd-pstate in passive m=
ode)
> >> calls cpufreq_driver_adjust_perf() directly and never goes through
> >> sugov_update_next_freq(), so the need_freq_update flag is not cleared =
in
> >> that path.
> >>
> >> Before commit 75da043d8f88 ("cpufreq/sched: Set need_freq_update in
> >> ignore_dl_rate_limit()"), this was effectively harmless because
> >> sugov_should_update_freq() still honoured the rate limit even when
> >> need_freq_update was set. After that change, the flag forces
> >> sugov_should_update_freq() to always return true, so once set, it stay=
s
> >> effective indefinitely on the adjust_perf path.
> >>
> >> As a result, cpufreq_driver_adjust_perf() gets called on every schedul=
er
> >> utilization update (with the runqueue lock held) rather than being
> >> throttled by rate_limit_us, even if the driver itself may skip redunda=
nt
> >> hardware updates.
> >>
> >> Clear need_freq_update at the end of the adjust_perf path as well.
> >>
> >> Fixes: 75da043d8f88 ("cpufreq/sched: Set need_freq_update in ignore_dl=
_rate_limit()")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> >> ---
> >>   kernel/sched/cpufreq_schedutil.c | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_s=
chedutil.c
> >> index ae9fd211cec1..a4e689eefdfb 100644
> >> --- a/kernel/sched/cpufreq_schedutil.c
> >> +++ b/kernel/sched/cpufreq_schedutil.c
> >> @@ -486,6 +486,7 @@ static void sugov_update_single_perf(struct update=
_util_data *hook, u64 time,
> >>      cpufreq_driver_adjust_perf(sg_policy->policy, sg_cpu->bw_min,
> >>                                 sg_cpu->util, max_cap);
> >>
> >> +    sg_policy->need_freq_update =3D false;
> >>      sg_policy->last_freq_update_time =3D time;
> >
> > Nice catch. Thanks.
> >
> > It does seem to me that setting last_freq_update_time should then asser=
t
> > !need_freq_update, otherwise it doesn't make sense, but that's a
> > different topic.
> +1, feel free to submit that too.
>
> For $SUBJECT:
> Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Applied as 7.2-rc material, thanks!
