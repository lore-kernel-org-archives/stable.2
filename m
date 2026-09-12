Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2511F496D29;
	Sat, 12 Sep 2026 20:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789245387; cv=none; b=tnY3t5Qw5rv1QnEONiSn1h0abKjMQnmvegF4S6RpoDNr1TG6vbhBTw5bNMjC3+/mWUFqFhAhwhHUG4CsMoLD4jNBZk1ZxqIzXz+B9jnRpTcdJa1wkfPAc7h2T4IztoufjlXlQN8T0JFPcxHWRI8WIUMYqed815LW3k+FC4cEAuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789245387; c=relaxed/simple;
	bh=oCxvQAow13m+FFNPe36hLQ8WAlLRu7Xg3vTdxkKfffw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F8YfWHkWHbz6dWQdro5HcRznR25J5c0HAprQTypGnAWVGLtyKES3RI1saC/3sSUIgLr4EZZdgckXmZlsCCNJpA48BVRcsmfPF3CtmNfDte8AOCgEdONhOBLei7QPZ4y4/2531Ad/mJrnbdW5ralY+eavnsie1YKrJEqUqdfUFHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAg0HaQ+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAg0HaQ+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC911F00899;
	Sat, 12 Sep 2026 20:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789245384;
	bh=ukweA8Ivw43RoWAeuxce+R7YQQKROPLpamA0k7U27mo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OAg0HaQ+g4JWhqALvRReLsSz/qwbXXM0Mnfm9JN5GDDKn28n5uKFh2C0Wi83rE737
	 sdNj5CbQaVKnuSpWtbyVqRqjhVlp7wPYlGY0cX26QQstfw+GEAzgMsFUDOd4vOmlkt
	 6xBvQeyqb8VW8UBPqjHt8tFQcmA7mm3xFvK8jK0nc4ixTExzMtQ2q/c3U5TaThpvE3
	 uK/RtAWie6mNHWW7gc2FVQaTS4PyUzNiDS0/Yy47iiIkPdEzGrmfh21feEUODyuRqm
	 ID7C59ClSA36OsSnagv3J+aL9nyBeacoC8wbz4ITNNx1kstmoqSKM4qlHG3lpeFyDA
	 rxnplN9NAyygQ==
Subject: Re: [PATCH net 1/2] net/sched: hhf: cap hh_flows_limit at change time
From: netdev-bot+sashiko@kernel.org
To: jhs@mojatatu.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 vtlam@google.com, stable@vger.kernel.org, victor@mojatatu.com,
 hybris@mojatatu.ai, sashiko-bot@kernel.org
Date: Sat, 12 Sep 2026 20:36:23 +0000
Message-ID: <178924538361.3125.3706649335976216385@kernel.org>
In-Reply-To: <QDISC-B855.v1.20260911153152@mojatatu.com>
References: <QDISC-B855.v1.20260911153152@mojatatu.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] net/sched/sch_hhf.c: the new `[TCA_HHF_HH_FLOWS_LIMIT] =
  NLA_POLICY_MAX(NLA_U32, 2 * HH_FLOWS_CNT)` policy entry (line 530) is…

--

net/sched: hhf: cap hh_flows_limit at change time

The patch bounds TCA_HHF_HH_FLOWS_LIMIT with NLA_POLICY_MAX() at
2*HH_FLOWS_CNT, passes extack down to the nested parse so the rejected
value is reported, and moves the hh_flows_limit default in hhf_init()
ahead of the hhf_change() call so a user-supplied value at add time is no
longer overwritten.

Closes: https://sashiko.dev/#/patchset/20260822195509.112717-1-jhs@mojatatu.com

> diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
> index fc72f825fbd92..5dec1ed969adf 100644
> --- a/net/sched/sch_hhf.c
> +++ b/net/sched/sch_hhf.c
> @@ -527,7 +527,7 @@ static void hhf_destroy(struct Qdisc *sch)
>  static const struct nla_policy hhf_policy[TCA_HHF_MAX + 1] = {
>  	[TCA_HHF_BACKLOG_LIMIT]	 = { .type = NLA_U32 },
>  	[TCA_HHF_QUANTUM]	 = { .type = NLA_U32 },
> -	[TCA_HHF_HH_FLOWS_LIMIT] = { .type = NLA_U32 },
> +	[TCA_HHF_HH_FLOWS_LIMIT] = NLA_POLICY_MAX(NLA_U32, 2 * HH_FLOWS_CNT),

[Severity: Medium]
Does this policy entry also change the behaviour of the qdisc creation
path?  The subject says "cap hh_flows_limit at change time", but hhf_init()
calls hhf_change(), so the same policy is applied on add.

validate_nla() dispatches the max check from the pt->validation_type
switch, independently of the validation level:

lib/nlattr.c:validate_nla() {
	...
	case NLA_VALIDATE_MAX:
		err = nla_validate_int_range(pt, nla, extack, validate);
		if (err)
			return err;
	...
}

so even the NL_VALIDATE_LIBERAL level used by
nla_parse_nested_deprecated() returns -ERANGE, and hhf_init() propagates
it:

	if (opt) {
		int err = hhf_change(sch, opt, extack);

		if (err)
			return err;
	}

At baseline, tc qdisc add dev X root hhf hh_limit 4294967295 returned
success, because hhf_init() unconditionally reassigned the safe default
after hhf_change():

	if (!q->hh_flows) {
		...
		/* Cap max active HHs at twice len of hh_flows table. */
		q->hh_flows_limit = 2 * HH_FLOWS_CNT;

With this change the same command fails with -ERANGE and no qdisc is
installed.  Is that intended for a Cc: stable patch, and should it be
mentioned in the changelog?

The commit message says:

    Configs relying on hh_limit above the default were relying
    on unbounded, unsafe behaviour and are not supported going forward.

Is that accurate for the add path?  A setup doing tc qdisc add ... hh_limit
<value above 2048> was running with hh_flows_limit clobbered to 2048, so it
was not exposed to the unbounded allocation behaviour described earlier in
the changelog; only tc qdisc change could reach that state.

The sibling knob in the same function is clamped rather than rejected, from
the referenced eb56a495f59b:

	if (tb[TCA_HHF_QUANTUM])
		new_quantum = max(256U, nla_get_u32(tb[TCA_HHF_QUANTUM]));

Would a min() on hh_flows_limit in hhf_change() give the same memory bound
without turning previously-successful add commands into failures?  If
rejection is preferred, could the changelog state that the add path now
returns -ERANGE for values above 2*HH_FLOWS_CNT?

> @@ -546,7 +546,7 @@ static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
>  	u32 new_hhf_non_hh_weight = q->hhf_non_hh_weight;
>  
>  	err = nla_parse_nested_deprecated(tb, TCA_HHF_MAX, opt, hhf_policy,
> -					  NULL);
> +					  extack);
>  	if (err < 0)
>  		return err;
>  
> @@ -624,6 +624,9 @@ static int hhf_init(struct Qdisc *sch, struct nlattr *opt,
>  	q->hhf_evict_timeout = HZ;      /* 1  sec */
>  	q->hhf_non_hh_weight = 2;
>  
> +	/* Cap max active HHs at twice len of hh_flows table. */
> +	q->hh_flows_limit = 2 * HH_FLOWS_CNT;
> +
>  	if (opt) {
>  		int err = hhf_change(sch, opt, extack);
>  
> @@ -639,8 +642,6 @@ static int hhf_init(struct Qdisc *sch, struct nlattr *opt,
>  		for (i = 0; i < HH_FLOWS_CNT; i++)
>  			INIT_LIST_HEAD(&q->hh_flows[i]);
>  
> -		/* Cap max active HHs at twice len of hh_flows table. */
> -		q->hh_flows_limit = 2 * HH_FLOWS_CNT;
>  		q->hh_flows_overlimit = 0;
>  		q->hh_flows_total_cnt = 0;
>  		q->hh_flows_current_cnt = 0;

Moving the default ahead of hhf_change() is what makes the add-time value
effective for the first time, so this hunk and the policy hunk together
produce the new add-path failure described above.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/QDISC-B855.v1.20260911153152%40mojatatu.com
