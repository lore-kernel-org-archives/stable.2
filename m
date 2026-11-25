Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616112;
	b=tz4xD/kakgVDiHIYv64iJHh2oydG0lQZJ49jvhiS4SaYt3CmbFo/rwqeos17SOKW/CU2
	 Xdam+oqw9tcGTXUJAagSWmB+qrzTd44Gli7ovzrqq2p+kflCqlXcFbZhcMsVst7ctJWLD
	 cjgZ6oA1RLqI2G9PIDaAIWmWCCkp0plW0GkLY6lZTE1PeKLFkPdobXWDBFtEqfxnnYAz2
	 b7F1aDiU2LLvSv6tjSRZRnPgBZbl1VgPSJWqjOOqLoPXsDzFHDtLH/szB+mMqLto1cONU
	 ccqHG7uj9jWcaDzZH9auiaS+mMhkrMD6/+94UhUn+NpPRmdrW5+hv5yxaOPXys0vpqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616112;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=iOavuhXclhOaHI/0seHjhELa4YY7Qjxg+BB6UCL4ORE=;
	b=JGzPoUShDXDwzPDvpnhvC6HuxhZ7iwJYT1fMLgwd50QsK0WaJOZsmJYuDy655GZwADi0
	 kb6okhg1ETf898sOLSVvE1a2FFDC9ofGG69aoWn5l87E0yeiHH+y0XJC0s0KXgvQcT2Tt
	 DQNFW6gRaoGzm/Dp6bgGYMHa0YI2rvijwVjs8/jd4mNBiy5XaPlTMD55QzAeIuYRPm4UN
	 fLX6cz+Ro1jOBjQHi8uiQ0sK1Zz8xvtxmHyyOS45CEUHtSdl+wRktfPZMFH3VuZlsxqEJ
	 ByDDNf8qHMCGTF2SCVErn7FCKkj1fcSwYLZuGdYTz3C6by0jkIH17L2NKKiw0/LAisw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehHpva6p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A47606A32C;
	Wed, 25 Nov 2026 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ehHpva6p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328C71F000C6;
	Wed, 25 Nov 2026 14:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616112;
	bh=iOavuhXclhOaHI/0seHjhELa4YY7Qjxg+BB6UCL4ORE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ehHpva6pKhTh2KvNEUIvq2bfyqRjGVrM4AJG005LpJ+GxClpNJpbpOeawcpqTktFd
	 FFOuHnoqcuivWmIL8wMmzLcZAIie3bDqa8N6u6mpl2pPYI6IBZXFETKG8y5dX93i4+
	 Bl7QRas+k4DKYvypNpWTEFZ6shIg1mi5R5pnHppbnafElS6xS+UZ+aaGFDETwbghLP
	 ZZmJxw5uXFQ2ylE2wR1dEW84IJWDnjYEq9TpliDOGD809P5TyS56CmCam3KLACUY0X
	 ingurqTG4XpvGAbjKKdFkdspeakzqRveNhsNMUsCpZ8Dq5S6ZeYFTae0xEx182+b/u
	 95YDmkDbBAqjg==
Subject: Re: [PATCH net v4 1/3] net/sched: act_gate: bound the cycle time and
 start time arithmetic
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 horms@kernel.org, alexei.starovoitov@gmail.com, victor@mojatatu.com,
 Po.Liu@nxp.com, stable@vger.kernel.org,
 syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com, shawnq1@163.com
Date: Wed, 25 Nov 2026 14:15:10 +0000
Message-ID: <179561611071.3135.17430122131465607714@kernel.org>
In-Reply-To: <ACT-WEXM.v4.r0.20261124074514-1@mojatatu.com>
References: <ACT-WEXM.v4.r0.20261124074514-1@mojatatu.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The v3 -> v4 changelog says v4 bounds base_time and cycle_time
  "at KTIME_MAX rather than S64_MAX" and gives as a reason that "the v3…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  gate_timer_func() (net/sched/act_gate.c:119), which this patch…

--

net/sched: act_gate: bound the cycle time and start time arithmetic

The netlink policy now limits TCA_GATE_BASE_TIME and TCA_GATE_CYCLE_TIME
to the range [0, KTIME_MAX]. gate_get_start_time() now works out the part
of the cycle still ahead of now and adds it with ktime_add_safe(), so the
result saturates instead of wrapping. gate_timer_func() reuses that helper
when it falls behind and restarts the walk at the first entry.

Link: https://lore.kernel.org/netdev/20261022144732.61188-1-shawnq1@163.com/
Link: https://lore.kernel.org/netdev/20260827191547.4004973-2-kuba@kernel.org/
Link: https://lore.kernel.org/netdev/20260827121751.33dac8aa@kernel.org/
Link: https://lore.kernel.org/netdev/DN37NBGPJJG9.2DSVDCKS3UYTV@gmail.com/

> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index 711cf24435409..4835f65439011 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c

[ ... ]

> @@ -108,13 +108,10 @@ static enum hrtimer_restart gate_timer_func(struct hrtimer *timer)
>  	now = gate_get_time(gact);
>  
>  	if (ktime_after(now, close_time)) {
> -		ktime_t cycle, base;
> -		u64 n;
> -
> -		cycle = p->tcfg_cycletime;
> -		base = ns_to_ktime(p->tcfg_basetime);
> -		n = div64_u64(ktime_sub_ns(now, base), cycle);
> -		close_time = ktime_add_ns(base, (n + 1) * cycle);
> +		gate_get_start_time(gact, p, &close_time);
> +		gact->current_close_time = close_time;
> +		next = list_first_entry(&p->entries,
> +					struct tcfg_gate_entry, list);
>  	}
>  
>  	gact->next_entry = next;

[Severity: High]
This isn't a bug introduced by this patch, but since gate_timer_func() is
being reworked here: can the callback rewrite the expiry of a timer that
has already been queued again underneath it?

Take an RTM_NEWACTION replace that keeps basetime, clockid and tk_offset
the same. need_cancel is then false in tcf_gate_init(), so
hrtimer_cancel() is skipped:

    need_cancel = ret != ACT_P_CREATED &&
                  gate_timer_needs_cancel(basetime, old_basetime,
                                          tko, old_tk_offset,
                                          timer_clockid, old_clockid);
    ...
    spin_lock_bh(&gact->tcf_lock);
    ...
    gate_start_timer(gact, start);
    spin_unlock_bh(&gact->tcf_lock);

If the timer is expiring on another CPU at that moment, the sequence
looks like this:

CPU1 (soft hrtimer softirq)
__run_hrtimer()
  dequeues the timer, drops cpu_base->lock
  gate_timer_func()
    spin_lock(&gact->tcf_lock)     <- spins

CPU2
tcf_gate_init()
  spin_lock_bh(&gact->tcf_lock)
  gate_start_timer()
    hrtimer_start()                <- timer queued again on CPU1's base,
                                      expiry = min(start, old expiry)
  spin_unlock_bh(&gact->tcf_lock)

CPU1
    hrtimer_set_expires(&gact->hitimer, close_time);
    return HRTIMER_RESTART;
  if (restart == HRTIMER_RESTART && !timer->is_queued)   <- skipped

At that point hrtimer_set_expires() writes node.expires and _softexpires
on a node that is already linked into the timerqueue rbtree. It does this
without cpu_base->lock, and the node is never re-sorted.

Would that leave the gate timer in the leftmost position with a future
key? If so, __hrtimer_run_queues() would stop at it, and other soft
hrtimers on the same clock base and CPU would wait until the gate's new
expiry.

This patch accepts cycle_time values up to KTIME_MAX on replace, so
close_time can saturate near KTIME_SEC_MAX. Could those other timers then
be held off indefinitely? hrtimer_forward() has WARN_ON(timer->is_queued)
to enforce this same rule.

Would either of these avoid it:

  - cancel the timer on every replace, outside tcf_lock, or
  - have the callback skip its re-arm when the timer was queued again
    under it?

> @@ -173,13 +170,20 @@ static const struct nla_policy entry_policy[TCA_GATE_ENTRY_MAX + 1] = {
>  	[TCA_GATE_ENTRY_MAX_OCTETS]	= { .type = NLA_S32 },
>  };
>  
> +static const struct netlink_range_validation gate_time_range = {
> +	.min = 0,
> +	.max = KTIME_MAX,
> +};

[Severity: Low]
This isn't a bug, but the v3 -> v4 notes say:

  - Bound base_time as well as cycle_time, and bound both at KTIME_MAX
  rather than S64_MAX: bounding one attribute's value does not bound the
  start time the timer is armed with, and the v3 range still computes a
  negative ktime_t for some accepted pairs.

Is the "KTIME_MAX rather than S64_MAX" part accurate? In
include/linux/time64.h:

  #define KTIME_MAX			((s64)~((u64)1 << 63))

That is 0x7fffffffffffffff, which is the same value as S64_MAX. So
switching the constant does not change gate_time_range.max.

What actually prevents negative or wrapped start times in v4 seems to be
two other changes: the new base_time bound, and the ktime_add_safe()
computation in gate_get_start_time(). The selftests patch later in this
series also names its tests "above S64_MAX" while testing the KTIME_MAX
bound.

Could the notes describe those changes instead?

>  static const struct nla_policy gate_policy[TCA_GATE_MAX + 1] = {
>  	[TCA_GATE_PARMS]		=
>  		NLA_POLICY_EXACT_LEN(sizeof(struct tc_gate)),

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/ACT-WEXM.v4.r0.20261124074514%40mojatatu.com
