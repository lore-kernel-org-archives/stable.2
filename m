Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616114;
	b=14rIx7d+Z5rEa7Kyl4YcfCcw/wdxgE71uXAkwjarI7BYCXpmFz63GdTQUzCW+mz9E9Dh
	 6PR/nCI+G/FJ0SfTmmJ0qh1GkHF8QsZlrjqHS+qi6evyVqPDwpNjO3peCASKBxGrVwF0E
	 b3AmTp+GBq+6KFeN3U1/5uhrzyDsjGeK7aKvXnQGE2Fpv+zx55bpSdL3KRFwbtkkiy7Co
	 cVUAmau7vkXI+dMo3XTXMJGOGPRzNThp26js+YwRa62rqoKc1GTQphezXSAFtmRBBaxhu
	 X/qks+7YVmj2kmz8nxOxdQUEreXbBjm6hUyrxF3sZRSetJv7uz5jLbkh75rIO/NwkuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616114;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=khM9e9PdssTSli3e34PBJItuouqfZ7EJL3XJV+m3hEU=;
	b=E74TDpmUqG794SJTO/EsbhRZdIcNn0P3dAumhv62o0FZIhni2GWV2NxdP07SjIcizA58
	 Is79nDYRE6UilVjRC768H8wFAtVvkxGB3dX6ND+2Giu4++bgD17shWILggYtTs51YEacD
	 YZSCXMkahsx9CEQO9uXeKA1N5PyvDSkebUg0seQRXw20WszFq37Qg8vstdGb5I3870sI0
	 kkqv0b0UP58MBGBh2oSXZQ2Q5pwRjiYBywIDt8AcIy6ZHW7cZj52kSWZ00AAwnsTR6hgP
	 AvI6t6Vq0C20fbpbn0oUtYXZguCmIJ3NNKGWWbP9bWkhezPLXZMSazIqWVmThQzQ8Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MD8upZBi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC95606A32E;
	Wed, 25 Nov 2026 14:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MD8upZBi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E813E1F000C6;
	Wed, 25 Nov 2026 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616113;
	bh=khM9e9PdssTSli3e34PBJItuouqfZ7EJL3XJV+m3hEU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MD8upZBirAQjC66IJG6viYZMNbwOZoJ4fJc1PFdGCz4Jf4VlN6Vmmk/bc3Dwv1890
	 2+j8zTlnIFqrsSdsQMdJPhfS0xD0cXty7rfe0PTAQVSrNi0+r122tLGxKs/q2sS8BH
	 rFPcWTYMdbnvF+RRmkHJ10P78bnCmQpncVibzLgSaPV4l8TlUAJ98LRils0blqgq9G
	 w3RAUbASVhuiditgDndHaIRyX2WxBYXdp/vD97ZtI3oh/2/lA0T+nfwNq6SeoYqePT
	 gqYWF4zdxYJvvBTTNi08t9csvz1N0GUP9gaa6Jc8tPoUTiUgNjbjeaBVPIEnRMsoQP
	 783cerc692Olg==
Subject: Re: [PATCH net v4 2/3] net/sched: act_gate: refuse schedule entries
 shorter than 10 us
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 horms@kernel.org, alexei.starovoitov@gmail.com, victor@mojatatu.com,
 Po.Liu@nxp.com, stable@vger.kernel.org,
 syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com, shawnq1@163.com
Date: Wed, 25 Nov 2026 14:15:12 +0000
Message-ID: <179561611250.3135.13753422220190315891@kernel.org>
In-Reply-To: <ACT-WEXM.v4.r0.20261124074514-2@mojatatu.com>
References: <ACT-WEXM.v4.r0.20261124074514-2@mojatatu.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The 10 us floor only limits a single gate action.
- [Medium] The commit message says the bug needs 'CAP_NET_ADMIN in the
  initial user namespace (netlink_capable() checks init_user_ns, so a…
- [Medium] The commit message says 'An act_gate schedule is not tied to a
  device, so unlike taprio there is no frame time to derive a bound…
- [Low] entry_policy still declares TCA_GATE_ENTRY_INTERVAL as a plain `{
  .type = NLA_U32 }`, while fill_gate_entry() enforces the new 10000 ns…
- [Low] The 'Some context' paragraph says 'The request that reproduces
  the cycle-time stall also carries a 1 ns entry interval'.

--

net/sched: act_gate: refuse schedule entries shorter than 10 us

This commit changes fill_gate_entry() so that act_gate schedule entries
must be at least 10 us long (GATE_MIN_INTERVAL_NSEC). Before, only a zero
interval was refused. The goal is to stop the soft hrtimer that
gate_timer_func() re-arms from keeping a CPU busy in the timer softirq.

Closes: https://sashiko.dev/#/patchset/tencent_4ED9536B0375C96183B2244CF7709768C605@qq.com

> Some context:
> The request that reproduces the cycle-time stall also carries a 1 ns
> entry interval.  With the cycle time derived from the entries, that alone
> sets a 1 ns timer period: the report covers both defects.

[Severity: Low]
Which request does this paragraph mean?

The earlier commit in this series, "net/sched: act_gate: bound the cycle
time and start time arithmetic", documents a cycle-time reproducer that
uses TCA_GATE_BASE_TIME = 1, TCA_GATE_CYCLE_TIME = 0xffffffffffffffff and
"one schedule entry of 1000000 ns". That is 1 ms, not 1 ns.

The second sentence is accurate. gate_timer_func() advances
current_close_time by next->interval, so a single 1 ns entry does set a
1 ns period.

If this refers to a different reproducer, such as the Sashiko one, could
the message name it? As written, the two commits disagree about which
input triggers which defect.

> Conditions to recreate the bug:
> CONFIG_NET_ACT_GATE=y, and CAP_NET_ADMIN in the initial user namespace
> (netlink_capable() checks init_user_ns, so a user namespace of its own
> does not help), in a new network namespace:

[Severity: Medium]
Is this accurate for every way a gate action can be created?

The init_user_ns check is only in the standalone RTM_NEWACTION path:

net/sched/act_api.c:tc_ctl_action() {
    ...
	if ((n->nlmsg_type != RTM_GETACTION) &&
	    !netlink_capable(skb, CAP_NET_ADMIN))
		return -EPERM;
    ...
}

A gate action can also be created inline with a classifier, for example:

  tc filter add dev lo ingress matchall action gate sched-entry close 1

That goes through:

  RTM_NEWTFILTER
    tc_new_tfilter()
      tcf_exts_validate_ex()
        tcf_action_init()
          tcf_gate_init()

The only capability check on that path is relative to the netns:

net/core/rtnetlink.c:rtnetlink_rcv_msg() {
    ...
	if (kind != RTNL_KIND_GET && !netlink_net_capable(skb, CAP_NET_ADMIN))
		return -EPERM;
    ...
}

So it looks like an unprivileged user who runs unshare -Urn can set up
the 1 ns stall on kernels without this patch.

With Cc: stable on this patch, could the reachability description be
corrected? Backport and security triage will rely on it.

> diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> index 4835f65439011..797562dbde693 100644
> --- a/net/sched/act_gate.c
> +++ b/net/sched/act_gate.c
> @@ -25,6 +25,11 @@ static struct tc_action_ops act_gate_ops;
>   */
>  #define GATE_ENTRIES_MAX	1024U
>  
> +/* An entry shorter than this lets the next expiry land before the softirq
> + * servicing the current one can finish, so the timer stays permanently behind.
> + */
> +#define GATE_MIN_INTERVAL_NSEC	10000U

[Severity: High]
Does a per-entry floor bound the total timer softirq load on a CPU?

Each gate action owns a soft hrtimer (HRTIMER_MODE_ABS_SOFT). That timer
re-arms itself on every expiry with no exit condition:

net/sched/act_gate.c:gate_timer_func() {
    ...
	gact->current_close_time = ktime_add_safe(gact->current_close_time,
						  next->interval);
    ...
	hrtimer_set_expires(&gact->hitimer, close_time);

	spin_unlock(&gact->tcf_lock);

	return HRTIMER_RESTART;
}

Nothing limits how many gate actions a netns can have. tcf_gate_init()
calls tcf_idr_check_alloc() with a u32 index, and every filter with an
inline action gate creates a new instance and starts a new timer.

The commit message puts one expiry at a few hundred ns. At that cost,
about 33 actions with a single 10000 ns entry each, created from a task
pinned to one CPU, would keep that CPU fully busy in the timer softirq.

On the debug or PREEMPT_RT kernels the message mentions, where an expiry
costs a few us, 3 to 5 actions would be enough.

Wouldn't that bring back the "holds a CPU in the timer softirq for as
long as it exists" condition this patch is meant to remove? Fully fixing
it seems to need a limit on the combined load, for example a per-netns
cap on active gate timers or on their total expiry rate.

[ ... ]

> @@ -199,8 +204,10 @@ static int fill_gate_entry(struct nlattr **tb, struct tcfg_gate_entry *entry,
>  	if (tb[TCA_GATE_ENTRY_INTERVAL])
>  		interval = nla_get_u32(tb[TCA_GATE_ENTRY_INTERVAL]);
>  
> -	if (interval == 0) {
> -		NL_SET_ERR_MSG(extack, "Invalid interval for schedule entry");
> +	if (interval < GATE_MIN_INTERVAL_NSEC) {
> +		NL_SET_ERR_MSG_FMT(extack,
> +				   "Entry interval must be at least %u ns",
> +				   GATE_MIN_INTERVAL_NSEC);
>  		return -EINVAL;
>  	}

[Severity: Medium]
The commit message says:

  An act_gate schedule is not tied to a device, so unlike taprio there is
  no frame time to derive a bound from

Does that hold for offloaded gate actions? act_gate is offloaded as
FLOW_ACTION_GATE to 802.1Qci PSFP hardware in sja1105, felix_vsc9959,
ocelot_flower, enetc and sparx5.

fill_gate_entry() runs for every gate action before the offload path
does, including flower skip_sw rules. sja1105 accepts much finer
schedules than 10 us:

drivers/net/dsa/sja1105/sja1105_vl.c:sja1105_vl_gate() {
    ...
		div_s64_rem(entries[i].interval,
			    sja1105_delta_to_ns(1), &rem);
		if (rem) {
			NL_SET_ERR_MSG_MOD(extack,
					   "Interval must be multiple of 200 ns");
			rc = -ERANGE;
			goto out;
		}

		if (!entries[i].interval) {
			NL_SET_ERR_MSG_MOD(extack,
					   "Interval cannot be zero");
    ...
}

Schedules such as "sched-entry OPEN 5000 -1 -1 sched-entry CLOSE 5000
-1 -1" used to install on sja1105. They now fail with -EINVAL and "Entry
interval must be at least 10000 ns". The driver's zero-interval check also
becomes unreachable.

The software hrtimer still runs for offloaded actions, so the CPU cost
argument may still justify the floor. Could the commit message say that
this rejects schedules that offload hardware used to accept? With
Cc: stable, the new limit would also reach deployed TSN setups.

[Severity: Low]
This isn't a bug, but could the minimum go in the policy instead of being
open-coded? entry_policy still declares the interval as a plain u32:

	[TCA_GATE_ENTRY_INTERVAL]	= { .type = NLA_U32 },

With NLA_POLICY_MIN(NLA_U32, GATE_MIN_INTERVAL_NSEC), nla_parse_nested()
would report the bad attribute in extack, and the policy would advertise
the correct range.

Also, when TCA_GATE_ENTRY_INTERVAL is missing, interval stays 0 and the
user is told the interval must be at least 10000 ns, even though no
interval was sent. Would NL_SET_ERR_ATTR_MISS describe that case better?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/ACT-WEXM.v4.r0.20261124074514%40mojatatu.com
