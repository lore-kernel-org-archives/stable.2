Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4A4A23;
	Thu, 27 Aug 2026 19:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787859267; cv=none; b=oXJx3jLjky4agzI4URlIpzuTUQf7MWG4FE71+g/6I3+lCWoABfNJPescr3oDLT/uqMNwUyPIpx/TMCyrvsY2kNHgSgXJlMy3zEAyjeao5ojG07NJGer+Zjsr1avKfojfnLHLrUVRu+a9cwrXrBD64mY/d7yUN/huBY6149WkDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787859267; c=relaxed/simple;
	bh=wCAD1z2bUw428egC7YHDipBCLUNtQs93HlH2vVvxCg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHXh6sonR7n75VvI+h4T2OUaIAGCcRDA0ufYvTEjoWvn4ljNiiIz3yFjUyFYJbcOhgg6uVzvNd3anP4v373c2J3cTbv9IHT/cwFLqz47jP1DLdLU42fPmkX2daJjqI8EVqZLYf7dmdl+HC3u1c9rLMu5BWc8dlK/siglu9MEsm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ+8dGiG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ+8dGiG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911E21F000E9;
	Thu, 27 Aug 2026 19:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787859266;
	bh=+dw3AN4UTXUcx8Tma7ukPw6EUulOmIGk2nxsdv6Y2io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EJ+8dGiGoRNOKqGVQZjbQKbcYFstFT05XjiMCb4Llj5KQ0L3OjPyl1O+iVybPM1VN
	 +0EAa9KOLLBHjbViZ7RuKayC9pa5/JGSiPtt3GqwRJ04juhWluRkE5Bts76d/1OTYJ
	 KQwR68pODnYxyWqyVPKvXM5GtTlf74OyZguB8OI/vlTCVo2U0KBEGn/GwI7m2rr8/W
	 N1T7dEXVrbKB679EWb+o4HIkVmU2QjrXan+cMacU0k8Kinti1GXMY4Xavtn706s23B
	 dNhdjsjJ4dDG9Prj/KuvF+tGCz3pIjqpnOT4cHT0xbDazZvQljPEpRAREWwG3I39Ki
	 Lo0KbZlAigVFw==
From: Jakub Kicinski <kuba@kernel.org>
To: jhs@mojatatu.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	victor@mojatatu.com,
	vtahiliani@nitk.edu.in,
	toke@redhat.com,
	chia-yu.chang@nokia-bell-labs.com,
	subramanian.vijay@gmail.com,
	vega@nebusec.ai,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net/sched: clamp quantum and psched_mtu in change paths and missed siblings
Date: Thu, 27 Aug 2026 12:34:24 -0700
Message-ID: <20260827193424.4017151-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826074056.7873-1-jhs@mojatatu.com>
References: <20260826074056.7873-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/sched: clamp quantum and psched_mtu in change paths and missed siblings

This follow-up to 709f34f7c28d adds a 256 byte floor to the quantum written
by the change() paths of fq_pie, hhf, sfq and drr, floors the psched_mtu()
fallback in drr and ets, narrows the sch_fq TCA_FQ_INITIAL_QUANTUM policy
range to 1<<20, and clamps psched_mtu() to [1, 1<<20] in sch_dualpi2 and
sch_pie. The stated goal is to stop a small quantum combined with a
STAB-inflated qdisc_pkt_len from spinning the deficit-refill loops under the
qdisc lock.

A few questions on the changelog first.

>     8. sch_ets: ets_qdisc_change() falls back to psched_mtu() with no floor
>        for bands without an explicit quantum.  Add max(256U, ...) on the
>        fallback path (vega@nebusec.ai independent bug)

[Severity: Low]

The ETS item is described as fixing a real denial-of-service condition, but
none of the seven Fixes: tags names an ETS commit. git blame on the
psched_mtu() fallback in ets_qdisc_change() at the baseline points at
dcc68b4d8084 ("net: sch_ets: Add a new Qdisc"), which is not in the tag
list. Should the following be added so stable tooling can map the ETS part?

  Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")

>     1. fq_pie_change() accepts quantum=1 (NLA policy fq_pie_q_range.min=1).
>        Add max(256U, ...) matching fq_codel_change()
>        (Sashiko nipa gpt-5-6-sol-3-8 and gpt-5-6-sol-6-7)
[ ... ]
>     5. sch_dualpi2: dualpi2_calculate_c_protection() and get_memory_limit()
>        call psched_mtu() with no clamp. A huge MTU makes (s32)psched_mtu()
>        overflow in the signed multiply for c_protection_init, and 2 *
>        psched_mtu() wraps in get_memory_limit(). Clamp to [1, 1<<20] at
>        all three call sites. (Sashiko nipa main-6-4)

[Severity: Low]

This patch bundles eight independent fixes over seven qdiscs with seven
Fixes: tags and Cc: stable, covering different bug classes: deficit-spin
quantum floors, the signed multiply overflow in dualpi2 c_protection_init,
the bytemode divide in pie_drop_early(), and a netlink policy narrowing.
The tags span very different stable ranges (320d031ad6e4 for dualpi2 is
recent, 13d2a1d2b032 for drr is from 2008). Can this be split so each bug
can be backported or reverted on its own?

The changelog also carries what look like internal review-tool
identifiers - "Sashiko nipa gpt-5-6-sol-3-8 and gpt-5-6-sol-6-7",
"Sashiko nipa main-6-4", "Sashiko gemini", "Internal review noticing same
pattern". Are those meant to stay in the upstream commit message?

> diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
> index 91b1ef824afaf..0ffdab27bae42 100644
> --- a/net/sched/sch_drr.c
> +++ b/net/sched/sch_drr.c
> @@ -82,8 +82,9 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
>  			NL_SET_ERR_MSG(extack, "Specified DRR quantum cannot be zero");
>  			return -EINVAL;
>  		}
> +		quantum = max(256U, quantum);
>  	} else
> -		quantum = psched_mtu(qdisc_dev(sch));
> +		quantum = max(256U, (u32)psched_mtu(qdisc_dev(sch)));

[Severity: High]

Only the low side is bounded here. drr_change_class() still accepts any
non-zero u32, and cl->quantum and cl->deficit are both u32. What happens
with a quantum near U32_MAX?

  tc class add ... drr quantum 4294967293

net/sched/sch_drr.c:drr_dequeue() {
	...
	WRITE_ONCE(cl->deficit, cl->deficit + READ_ONCE(cl->quantum));
	list_move_tail(&cl->alist, &q->active);
	...
}

With quantum = 0xfffffffd that refill wraps modulo 2^32 and is the same as
deficit -= 3, so with a STAB-inflated qdisc_pkt_len of 0x40000000 the loop
needs roughly 3.6e8 passes before deficit wraps past zero, all with the
qdisc root lock held. ets_qdisc_dequeue() uses the identical u32 arithmetic
and ets_quantum_parse() rejects only zero.

Should drr and ets also reject quantum > 1<<20, the way sfq_change() now
does in this same patch?

> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> index 25fcf4079fece..f23c8dc68f8cb 100644
> --- a/net/sched/sch_ets.c
> +++ b/net/sched/sch_ets.c
> @@ -636,7 +636,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
>  	 */
>  	for (i = nstrict; i < nbands; i++) {
>  		if (!quanta[i])
> -			quanta[i] = psched_mtu(qdisc_dev(sch));
> +			quanta[i] = max(256U, (u32)psched_mtu(qdisc_dev(sch)));

[Severity: High]

This assignment is guarded by !quanta[i], so it only applies to bands that
carry no explicit quantum. Every explicit value still goes through
ets_quantum_parse(), which rejects zero only:

net/sched/sch_ets.c:ets_quantum_parse() {
	*quantum = nla_get_u32(attr);
	if (!*quantum) {
		NL_SET_ERR_MSG(extack, "ETS quantum cannot be zero");
		return -EINVAL;
	}
	return 0;
}

So does the reproducer in the changelog still work for ETS?

  tc qdisc add dev dummy0 root ets bands 2 quanta 1 1

ets_class_change() has the same gap, it writes the parsed value straight
through with WRITE_ONCE(cl->quantum, quantum), and then
ets_qdisc_dequeue() refills one byte per pass:

net/sched/sch_ets.c:ets_qdisc_dequeue() {
	...
	cl->deficit += READ_ONCE(cl->quantum);
	list_move_tail(&cl->alist, &q->active);
	...
}

Would putting the floor in ets_quantum_parse() cover the explicit path as
well? If so, test 41f5 in
tools/testing/selftests/tc-testing/tc-tests/qdiscs/ets.json expects
"quanta 4294967294 1 1" to be accepted and dumped unchanged, so it would
need updating.

[Severity: Low]

The comment just above this loop still says the fallback is the MTU:

	/* If there are more bands than strict + quanta provided, the remaining
	 * ones are ETS with quantum of MTU. Initialize the missing values here.
	 */

On a headerless or tiny-MTU device, which is the case this hunk exists for,
the band now gets 256 rather than the MTU. Could the comment be updated to
say max(MTU, 256)?

> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 6144b5686f13f..ab8e7c6ae2039 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -980,7 +980,7 @@ static int fq_resize(struct Qdisc *sch, u32 log)
>  }
>  
>  static const struct netlink_range_validation iq_range = {
> -	.max = INT_MAX,
> +	.max = 1 << 20,
>  };

[Severity: High]

This narrows TCA_FQ_INITIAL_QUANTUM, which seeds the credit of a new flow.
The refill amount in the dequeue loop comes from q->quantum instead, and
fq_change() still accepts 1:

net/sched/sch_fq.c:fq_change() {
	...
	if (tb[TCA_FQ_QUANTUM]) {
		u32 quantum = nla_get_u32(tb[TCA_FQ_QUANTUM]);

		if (quantum > 0 && quantum <= (1 << 20)) {
			WRITE_ONCE(q->quantum, quantum);
	...
}

net/sched/sch_fq.c:fq_dequeue() {
	...
	if (f->credit <= 0) {
		f->credit += q->quantum;
		head->first = f->next;
		fq_flow_add_tail(q, f, OLD_FLOW);
		goto begin;
	}
	...
}

The lead paragraph says "The change() paths with the same pattern, same
writer of q->quantum, same privilege level ... were not clamped", and
sch_fq is the qdisc of the primary Fixes: commit. With

  tc qdisc replace dev dummy0 root fq quantum 1 stab data 32767 \
    size_log 16 cell_log 0

does fq_dequeue() still need ~2^31 passes of f->credit += 1 after
f->credit -= plen? Should sch_fq get the same 256 floor as its siblings?

> diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
> index 96acab6a8da03..bb8e8952f5553 100644
> --- a/net/sched/sch_hhf.c
> +++ b/net/sched/sch_hhf.c
> @@ -551,7 +551,7 @@ static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
>  		return err;
>  
>  	if (tb[TCA_HHF_QUANTUM])
> -		new_quantum = nla_get_u32(tb[TCA_HHF_QUANTUM]);
> +		new_quantum = max(256U, nla_get_u32(tb[TCA_HHF_QUANTUM]));

[Severity: High]

The floor is applied only when the attribute is present, so a small quantum
coming from hhf_init() survives:

net/sched/sch_hhf.c:hhf_init() {
	...
	q->quantum = psched_mtu(qdisc_dev(sch));
	...
	if ((int)q->quantum <= 0 ||
	    (u64)q->quantum * q->hhf_non_hh_weight > INT_MAX)
		q->quantum = 256;
	...
}

Values in 1..255 pass untouched here, unlike sfq_init() and fq_pie_init()
which use clamp_t(u32, psched_mtu(...), 256, 1 << 20). With
ip link set dummy0 mtu 0 psched_mtu is 14, and on a veth with mtu 68 it is
82.

The changelog states "The init paths of fq_pie, sfq, and hhf delegate to
their _change() when opt is present, so the floor covers tc qdisc add ...
quantum 1 as well as change". Is that true for
tc qdisc add dev dummy0 root hhf with no options, where hhf_change() is
never called? And for tc qdisc change ... hhf non_hh_weight 1, where
new_quantum defaults to the unfloored q->quantum and is re-committed by
WRITE_ONCE(q->quantum, new_quantum)?

With q->quantum = 14 and a STAB-inflated qdisc_pkt_len, does hhf_dequeue()
still need ~7.7e7 passes of bucket->deficit += weight * q->quantum? Would
clamping in hhf_init() to [256, 1<<20] like the siblings be more robust?
The member comment also still reads

	u32		   quantum;        /* psched_mtu(qdisc_dev(sch)); */

which no longer describes either writer.

> diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
> index 187d3ed578f26..8bbcfc9e85d94 100644
> --- a/net/sched/sch_sfq.c
> +++ b/net/sched/sch_sfq.c
> @@ -660,6 +660,11 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
>  		return -EINVAL;
>  	}
>  
> +	if (ctl->quantum > 1 << 20) {
> +		NL_SET_ERR_MSG_MOD(extack, "quantum too large");
> +		return -EINVAL;
> +	}
> +

[Severity: Low]

With this reject in place, is the documented field contract still
reachable?

net/sched/sch_sfq.c:sfq_sched_data {
	...
	unsigned int	quantum;	/* Allotment per round: MUST BE >= MTU */
	...
}

sfq_init() already caps the default with
clamp_t(u32, psched_mtu(qdisc_dev(sch)), 256, 1 << 20), and after this
change userspace can no longer raise quantum to the MTU on a device whose
psched_mtu exceeds 1 MiB (dummy clears max_mtu and accepts an MTU of
2147483634, as noted in 709f34f7c28d). Could the comment be updated to
state the enforced 256..1<<20 range?

Also, tc_sfq_qopt configurations with quantum > 1 MiB that used to be
accepted now return -EINVAL, while the peer attributes
(TCA_FQ_PIE_QUANTUM, TCA_HHF_QUANTUM) clamp instead of rejecting. Was
rejecting rather than clamping intended for sfq here?

> @@ -688,7 +693,7 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
>  
>  	/* update and validate configuration */
>  	if (ctl->quantum)
> -		quantum = ctl->quantum;
> +		quantum = max(256U, ctl->quantum);

[Severity: Medium]

Does a constant floor bound the spin, or only divide it by a constant? The
numerator stays user-controlled:

net/sched/sch_api.c:__qdisc_calculate_pkt_len() {
	...
	pkt_len <<= stab->szopts.size_log;
out:
	if (unlikely(pkt_len < 1))
		pkt_len = 1;
	...
}

STAB_SIZE_LOG_MAX is 30 and qdisc_get_stab() only checks size_log and
cell_log against it, so qdisc_pkt_len still reaches ~2^31. With quantum
exactly at the new floor:

net/sched/sch_sfq.c:sfq_dequeue() {
	...
	if (slot->allot <= 0) {
		q->tail = slot;
		WRITE_ONCE(slot->allot, slot->allot + q->quantum);
		goto next_slot;
	}
	...
}

that is still ~8.4e6 iterations per dequeued packet with the qdisc root
lock held and BH disabled, and fq_pie_dequeue(), hhf_dequeue(),
drr_dequeue() and ets_qdisc_dequeue() have the same shape. Would bounding
the STAB-derived pkt_len, or rounding the deficit up to cover the packet in
one step instead of looping, remove the class rather than attenuate it?
