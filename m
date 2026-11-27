Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795779579;
	b=xasmlJpV2aER1hjjWHDn6bRiomHtQ4ipz40zRgAgvGMrbP3JvKdRgNqh05jLhnV/PMQY
	 PS9ibSozv9i2Dmmoo2LKkwJ2dKcN+418eiJ4vcosh/KHbl5tag7PCmQ30LF2WMt95wD+t
	 JnRYCejWvXIOAMFkujY+ka+b8llXVaL7ye+ivpqAoV9q6nIOXzqbPUeBnOvTNmByE6Dze
	 Ij0Z4UnjY05aKZUzDERSw+YicB+LBYIlG+B5CuO7Xyn0ZwNAOy3AatSqGfpK6k73j6eWr
	 8C2SxnjzWNOaQso+ZphKp7wGoO48YTD1rH+d5M/aC06kqJEfEsZs4YRardm72lcZXFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795779579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=AdWs/iv4rTbBIAzg2NglTiD85oDIsy90LsJ1bofEwBc=;
	b=CDM0veDG/77hb0RJKbcQGnn+6PgXvj/ifveZayThsgIcETM7l9o3vHvtN1fjS5xO7oNu
	 lEtnFyAgTaOG9cXVzMVi0XRTokDeOAd70Ge7gkMcsqtpbJNa1g5gHAGK8oaPVfMuX4+ZI
	 rd1vUjB63Pv/BXyH6zMqpaTwMw35vseSNf0F4VdPEo6v/DFvhxjWAqBmuZN9j4F0imZTs
	 z5NN1Hv+JegEtkKZClOIeLX1In9CXGGC0iFqK07IUVGtaTqWZHJ2tee8VZg04/5HGek6a
	 TrSG23zR7hzHU5La5ta6OWSUZwf8eVYoEI4m8teV/14dtU/d6qUS2p763f1d49SlSKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b="Glr/8O1/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A573B606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 11:39:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A573B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Glr/8O1/
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8c6c06b3321so6336691b3a.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 03:39:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795779578; cv=none;
        d=google.com; s=arc-20260327;
        b=gCg90LVqsEVMO6+88Pa6g9CnfbdGYLzvMZ7D2agVmeTzRhCnFi0My1qYvs5aNjYWie
         Uxz7gr/8hjf3IGl+JPCCjuaGGxVfQ7W1GWNkpD2HkgWVnpt0wFeIrHljCLQ9MGjcNOvD
         z1DE8h476SO2EWFZwcCD6Y+1iHpz0InxkAwxSslUNzU+Dz+ocQUUoMAaD5I1vv/6Deu5
         U9xlRKcMSUuO4VqkLpLsAXQDaM8/QHMWUpNTVvUm31MMCxwE7Z/uccUTsWIl50NqAruG
         YWwDNxrlMVqQ3DFo0VLwjOXRiJDg+SKSzxRY7NnVvgiQnMvZwM5OOw85w89v1vhrMPdy
         2EPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AdWs/iv4rTbBIAzg2NglTiD85oDIsy90LsJ1bofEwBc=;
        fh=N1yS5QpE26VWxFxcyH1PTQmlLfZzAwgVxTbZ6lA3pbg=;
        b=TEt61PDjXT8eV0YOwWC1ZnxAlAJgwxZNVw+jpe78aV4i8JWV9UV1xW2J92dUnDuuQ8
         heFDQSABkVO/kg2Q9MIXehDvxsEcRjNsEeHTEe2aDzNcBCnOC4OehamF76uL3ol+EWin
         vD/Q6Y5YHZT8aBPoJVN/DyC7lChgEknPqTzM4TnrzZuVP3+tQkCWgQ8ef7imPJfteqs+
         hQ6BAkIzpQyIL2po/b/P/HduFC4/3nYKslEW6ckEYwx/QBpcqPHbz5T85ytCOlFD1cXT
         75KXMmM/UTVYQdZL/mTYDvVUy6PDC9jCCv2br0sWsQ91lbSMpaDKADSrT8q1WFwHE2GE
         L7iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795779578; x=1796384378; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AdWs/iv4rTbBIAzg2NglTiD85oDIsy90LsJ1bofEwBc=;
        b=Glr/8O1/V/bqspFvgDtohP2DYqDQQ9Se7cSmTz0EnulFTv7Kpflf+iupGvoSRIzuML
         1Q/R66g+PNqFpu9amcv0Ya0YQYSsdZguIekQtC91UtmEU05PGUww2PsVzyLMzUBzq61P
         3J5yoRZp0BKeMTytDu9fhO1Sqn5KnJQmG1E04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795779578; x=1796384378;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdWs/iv4rTbBIAzg2NglTiD85oDIsy90LsJ1bofEwBc=;
        b=sKzsnDUVRuEEkyjxGQqBBNO9NSEDsSrY4zbYeUlwVbdyVxOOv8m8s/aHpPGSmf8b5w
         oOUQwm+RYhvrYIm6bYORgzz9el6MEfIDEORDhHAJVebdhlp/+g2PbZFufxB/W2ZYZ0Zk
         YEqiRztnNgsdRqsYqI9eqlkZISlGQUhLa/ptnB9z+9pEVjlJYIdBetPgKna9QGd7w5eQ
         NiVTcLHswD2Jp0QrNOXLzEhldYcOa6Go77SkfJemiqPujFu3ropV0O7Hw7wk/sqx7dnF
         2BsoKNe03rkYRufEGM8Q1KYTjq4Dcu8cKWDzYfk9TCZxb1bE5CiFSZNRCLwIP8KKV97M
         u15Q==
X-Forwarded-Encrypted: i=1; AL+hErFCmQT342g/qFVy0y/7SboZC3rA1SSM69jJO/AcEnQHPDi59w9ij34MTyBbQ0Wb5K2zXaaysbc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Fp/0iwPwMJxZy837vVQylO3V/9mJZnve3I+VEvk5oJ2A5HyPy
	wYxSiPocf9LBmffFua6oiWSAqJBCwdHzytHdxoWxH2mXJccLGwKUQpUK62Qi9mHVxR/0IqC0qNV
	DSmA7qZ8y4vMcFpFUe4ASuzsSnFsZNGtQgXxXgE9l
X-Gm-Gg: AZFdTZdbwEbrIu3LMRCEKr8BNIaCfNohnDC/0L0VEeu2abEqrTwED2H7bllu5mTdxlq
	SRhYCLbMhwb7FzsgBpjRDraChfLZ3zJArNy+FWKG3KxKXJxqhwq4W/H92wVD9BmvfKYlpPD9vft
	L8Wa7FoRx7cj4eyI32Y06A3YcHUq1QIGm20ESd8rHsSMAzZuTw/DONnOvPcni1tuINLb7SNla5K
	673FFyv61lemJOVYng/Hgd+unUyrrWw0uS1c41nPO7wjJvAdJ7/tJZy+OYSygkInLAkqF9ofbtF
	kIVRGBIDZK56XlWWKPKTDYR6WBwK84PwzdqkEeYgZ8E153F8+aND7KxhUWdCTFG3MXLdt+VfYsG
	PIiYYiKuxSdcql7Dn+2yelqBb1olLc6UtSnjWk4Dv/2+iLMLz69b4/rPnVrwwpRqdEPZCW7/USp
	2TSFJzHk4P8M/Xb90=
X-Received: by 2002:a05:6300:6bdc:b0:3e2:86b6:9beb with SMTP id
 adf61e73a8af0-4014e06961emr20469307637.74.1795779577953; Fri, 27 Nov 2026
 03:39:37 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-WEXM.v4.r0.20261124074514-2@mojatatu.com> <179561611250.3135.13753422220190315891@kernel.org>
In-Reply-To: <179561611250.3135.13753422220190315891@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 27 Nov 2026 06:39:26 -0500
X-Gm-Features: Aa3M54qLSWCwzvEnJUnWP_V7LLsQQNti1UrS0jun0fwPhWmWJ5KYQSbFEZB8plA
Message-ID: <CAM0EoMmz_J-KbReOYjJPg1TqzOVk2ydQ1rfjuudnP4c+csQWRQ@mail.gmail.com>
Subject: Re: [PATCH net v4 2/3] net/sched: act_gate: refuse schedule entries
 shorter than 10 us
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net, 
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	horms@kernel.org, alexei.starovoitov@gmail.com, victor@mojatatu.com, 
	Po.Liu@nxp.com, stable@vger.kernel.org, 
	syzbot+0054fed3dc9085390f51@syzkaller.appspotmail.com, shawnq1@163.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 9:15=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 2 =C2=B7 Low: 2
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The 10 us floor only limits a single gate action.

This is an "extra" feature you are asking for - and since you work in
"no deed goes unpunished" I will not be adding this change because a)
it is intrusive and b) it is a hardening issue
So the fix to this is going net-next once this series lands.


> - [Medium] The commit message says the bug needs 'CAP_NET_ADMIN in the

This is what Alexei brought up; i will fix.
Resending because the series broke tdc.

pw-bot: cr

cheers,
jamal
>   initial user namespace (netlink_capable() checks init_user_ns, so a=E2=
=80=A6
> - [Medium] The commit message says 'An act_gate schedule is not tied to a
>   device, so unlike taprio there is no frame time to derive a bound=E2=80=
=A6
> - [Low] entry_policy still declares TCA_GATE_ENTRY_INTERVAL as a plain `{
>   .type =3D NLA_U32 }`, while fill_gate_entry() enforces the new 10000 ns=
=E2=80=A6
> - [Low] The 'Some context' paragraph says 'The request that reproduces
>   the cycle-time stall also carries a 1 ns entry interval'.
>
> --
>
> net/sched: act_gate: refuse schedule entries shorter than 10 us
>
> This commit changes fill_gate_entry() so that act_gate schedule entries
> must be at least 10 us long (GATE_MIN_INTERVAL_NSEC). Before, only a zero
> interval was refused. The goal is to stop the soft hrtimer that
> gate_timer_func() re-arms from keeping a CPU busy in the timer softirq.
>
> Closes: https://sashiko.dev/#/patchset/tencent_4ED9536B0375C96183B2244CF7=
709768C605@qq.com
>
> > Some context:
> > The request that reproduces the cycle-time stall also carries a 1 ns
> > entry interval.  With the cycle time derived from the entries, that alo=
ne
> > sets a 1 ns timer period: the report covers both defects.
>
> [Severity: Low]
> Which request does this paragraph mean?
>
> The earlier commit in this series, "net/sched: act_gate: bound the cycle
> time and start time arithmetic", documents a cycle-time reproducer that
> uses TCA_GATE_BASE_TIME =3D 1, TCA_GATE_CYCLE_TIME =3D 0xffffffffffffffff=
 and
> "one schedule entry of 1000000 ns". That is 1 ms, not 1 ns.
>
> The second sentence is accurate. gate_timer_func() advances
> current_close_time by next->interval, so a single 1 ns entry does set a
> 1 ns period.
>
> If this refers to a different reproducer, such as the Sashiko one, could
> the message name it? As written, the two commits disagree about which
> input triggers which defect.
>
> > Conditions to recreate the bug:
> > CONFIG_NET_ACT_GATE=3Dy, and CAP_NET_ADMIN in the initial user namespac=
e
> > (netlink_capable() checks init_user_ns, so a user namespace of its own
> > does not help), in a new network namespace:
>
> [Severity: Medium]
> Is this accurate for every way a gate action can be created?
>
> The init_user_ns check is only in the standalone RTM_NEWACTION path:
>
> net/sched/act_api.c:tc_ctl_action() {
>     ...
>         if ((n->nlmsg_type !=3D RTM_GETACTION) &&
>             !netlink_capable(skb, CAP_NET_ADMIN))
>                 return -EPERM;
>     ...
> }
>
> A gate action can also be created inline with a classifier, for example:
>
>   tc filter add dev lo ingress matchall action gate sched-entry close 1
>
> That goes through:
>
>   RTM_NEWTFILTER
>     tc_new_tfilter()
>       tcf_exts_validate_ex()
>         tcf_action_init()
>           tcf_gate_init()
>
> The only capability check on that path is relative to the netns:
>
> net/core/rtnetlink.c:rtnetlink_rcv_msg() {
>     ...
>         if (kind !=3D RTNL_KIND_GET && !netlink_net_capable(skb, CAP_NET_=
ADMIN))
>                 return -EPERM;
>     ...
> }
>
> So it looks like an unprivileged user who runs unshare -Urn can set up
> the 1 ns stall on kernels without this patch.
>
> With Cc: stable on this patch, could the reachability description be
> corrected? Backport and security triage will rely on it.
>
> > diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
> > index 4835f65439011..797562dbde693 100644
> > --- a/net/sched/act_gate.c
> > +++ b/net/sched/act_gate.c
> > @@ -25,6 +25,11 @@ static struct tc_action_ops act_gate_ops;
> >   */
> >  #define GATE_ENTRIES_MAX     1024U
> >
> > +/* An entry shorter than this lets the next expiry land before the sof=
tirq
> > + * servicing the current one can finish, so the timer stays permanentl=
y behind.
> > + */
> > +#define GATE_MIN_INTERVAL_NSEC       10000U
>
> [Severity: High]
> Does a per-entry floor bound the total timer softirq load on a CPU?
>
> Each gate action owns a soft hrtimer (HRTIMER_MODE_ABS_SOFT). That timer
> re-arms itself on every expiry with no exit condition:
>
> net/sched/act_gate.c:gate_timer_func() {
>     ...
>         gact->current_close_time =3D ktime_add_safe(gact->current_close_t=
ime,
>                                                   next->interval);
>     ...
>         hrtimer_set_expires(&gact->hitimer, close_time);
>
>         spin_unlock(&gact->tcf_lock);
>
>         return HRTIMER_RESTART;
> }
>
> Nothing limits how many gate actions a netns can have. tcf_gate_init()
> calls tcf_idr_check_alloc() with a u32 index, and every filter with an
> inline action gate creates a new instance and starts a new timer.
>
> The commit message puts one expiry at a few hundred ns. At that cost,
> about 33 actions with a single 10000 ns entry each, created from a task
> pinned to one CPU, would keep that CPU fully busy in the timer softirq.
>
> On the debug or PREEMPT_RT kernels the message mentions, where an expiry
> costs a few us, 3 to 5 actions would be enough.
>
> Wouldn't that bring back the "holds a CPU in the timer softirq for as
> long as it exists" condition this patch is meant to remove? Fully fixing
> it seems to need a limit on the combined load, for example a per-netns
> cap on active gate timers or on their total expiry rate.
>
> [ ... ]
>
> > @@ -199,8 +204,10 @@ static int fill_gate_entry(struct nlattr **tb, str=
uct tcfg_gate_entry *entry,
> >       if (tb[TCA_GATE_ENTRY_INTERVAL])
> >               interval =3D nla_get_u32(tb[TCA_GATE_ENTRY_INTERVAL]);
> >
> > -     if (interval =3D=3D 0) {
> > -             NL_SET_ERR_MSG(extack, "Invalid interval for schedule ent=
ry");
> > +     if (interval < GATE_MIN_INTERVAL_NSEC) {
> > +             NL_SET_ERR_MSG_FMT(extack,
> > +                                "Entry interval must be at least %u ns=
",
> > +                                GATE_MIN_INTERVAL_NSEC);
> >               return -EINVAL;
> >       }
>
> [Severity: Medium]
> The commit message says:
>
>   An act_gate schedule is not tied to a device, so unlike taprio there is
>   no frame time to derive a bound from
>
> Does that hold for offloaded gate actions? act_gate is offloaded as
> FLOW_ACTION_GATE to 802.1Qci PSFP hardware in sja1105, felix_vsc9959,
> ocelot_flower, enetc and sparx5.
>
> fill_gate_entry() runs for every gate action before the offload path
> does, including flower skip_sw rules. sja1105 accepts much finer
> schedules than 10 us:
>
> drivers/net/dsa/sja1105/sja1105_vl.c:sja1105_vl_gate() {
>     ...
>                 div_s64_rem(entries[i].interval,
>                             sja1105_delta_to_ns(1), &rem);
>                 if (rem) {
>                         NL_SET_ERR_MSG_MOD(extack,
>                                            "Interval must be multiple of =
200 ns");
>                         rc =3D -ERANGE;
>                         goto out;
>                 }
>
>                 if (!entries[i].interval) {
>                         NL_SET_ERR_MSG_MOD(extack,
>                                            "Interval cannot be zero");
>     ...
> }
>
> Schedules such as "sched-entry OPEN 5000 -1 -1 sched-entry CLOSE 5000
> -1 -1" used to install on sja1105. They now fail with -EINVAL and "Entry
> interval must be at least 10000 ns". The driver's zero-interval check als=
o
> becomes unreachable.
>
> The software hrtimer still runs for offloaded actions, so the CPU cost
> argument may still justify the floor. Could the commit message say that
> this rejects schedules that offload hardware used to accept? With
> Cc: stable, the new limit would also reach deployed TSN setups.
>
> [Severity: Low]
> This isn't a bug, but could the minimum go in the policy instead of being
> open-coded? entry_policy still declares the interval as a plain u32:
>
>         [TCA_GATE_ENTRY_INTERVAL]       =3D { .type =3D NLA_U32 },
>
> With NLA_POLICY_MIN(NLA_U32, GATE_MIN_INTERVAL_NSEC), nla_parse_nested()
> would report the bad attribute in extack, and the policy would advertise
> the correct range.
>
> Also, when TCA_GATE_ENTRY_INTERVAL is missing, interval stays 0 and the
> user is told the interval must be at least 10000 ns, even though no
> interval was sent. Would NL_SET_ERR_ATTR_MISS describe that case better?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/ACT-WEXM.v4.r0.20261124074514%40mojatatu.com
