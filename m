Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3702D7393;
	Sat, 22 Aug 2026 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787428945; cv=none; b=GP+iTCzj2fDZ7B2Q374ksDL4gG+mCqdd5UKBcoCEI9HVZoWwieBpQIRVx+afsCAaMs4CtbD33RZL9LNKl56hpJlmf6OU+KnyYCbWNord6pDOuc4nJPq7pdI0oSUTm3qRXZbXKXYpHsi65RxXuM3AvwGd5A0i5lHl0nj4rW8Aeos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787428945; c=relaxed/simple;
	bh=N/CpZcA3Mab+KL25bgb/t+34oY/2ZMhLpTk+tWPSip0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJ7yP1RWRoeQf4ZDSlK9IsTR+2Q6LvCjVr21YXInWOelzw47VQznwSfnjVT/x1P0yQiKWdrZidtnR52XN2jIougaIS04wfV3T+ifzOEpNHLA4ficnfaHdjrRnhlU3RImmnTt40hPKp5dlKDRh+b5qVtJISbm+CVdIf+/vyhDJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M1KmSis8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M1KmSis8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29AF1F000E9;
	Sat, 22 Aug 2026 20:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787428943;
	bh=+FDMWu3UM6zkioTEx7T5t/xUn7Rv5OilvCn5j3EqwKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M1KmSis8a/hpXezLYS7AFB/BLPymx1qa2/130QOJEFZLts5XY+kNcMcOmVMlEXgtQ
	 rAQ7lg7l/oSnsQoykUZ/7yzViMLZLFV2NZ2k4RPOiBje02TuS7y8yaenFTwO/BvUWO
	 XNNGII3TBgEfcm4IkjgNT+QU4wLC4gS0a8oTGOtbLS2AjE1eSr2VrR/80anqHemWH1
	 74hpIhUxUTz8W+LtNyCLQOiA/0BfiSJ8sij5go6E03TuingBams7TPoAJ8nnnrDsdG
	 bTFXEJ9gBSWndlujrkSLhLs5xU0+5VkCkLNyICsTLrBiQFC9fsytWn9vv/6KDAM6Gy
	 0omz2dXkOz76g==
From: Jakub Kicinski <kuba@kernel.org>
To: jhs@mojatatu.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	vega@nebusec.ai,
	victor@mojatatu.com,
	takis@issaris.org,
	ast@kernel.org,
	daniel@iogearbox.net
Subject: Re: [PATCH net] net/sched: account classifier filter allocations to memcg
Date: Sat, 22 Aug 2026 13:02:22 -0700
Message-ID: <20260822200222.2211875-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819143733.57538-1-jhs@mojatatu.com>
References: <20260819143733.57538-1-jhs@mojatatu.com>
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
net/sched: account classifier filter allocations to memcg

This adds GFP_KERNEL_ACCOUNT to the filter objects, per-CPU counters and
per-filter aux allocations in the tc classifier *_change() paths, plus the
shared exts->actions array in tcf_exts_init_ex(). It also adds an
idr_remove() to the cls_basic percpu-allocation failure path.

> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index 4e6a2812a4f32..be63b347640ba 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -3364,7 +3364,8 @@ int tcf_exts_init_ex(struct tcf_exts *exts, struct net *net, int action,
>  	 * This reference might be taken later from tcf_exts_get_net().
>  	 */
>  	exts->net = net;
> -	exts->actions = kzalloc_objs(struct tc_action *, TCA_ACT_MAX_PRIO);
> +	exts->actions = kzalloc_objs(struct tc_action *, TCA_ACT_MAX_PRIO,
> +				     GFP_KERNEL_ACCOUNT);
>  	if (!exts->actions)
>  		return -ENOMEM;
>  #endif
> diff --git a/net/sched/cls_basic.c b/net/sched/cls_basic.c
> index 492cd9ce8d46f..e2a94ba9fba76 100644
> --- a/net/sched/cls_basic.c
> +++ b/net/sched/cls_basic.c
> @@ -193,7 +193,7 @@ static int basic_change(struct net *net, struct sk_buff *in_skb,
>  			return -EINVAL;
>  	}
>  
> -	fnew = kzalloc_obj(*fnew);
> +	fnew = kzalloc_obj(*fnew, GFP_KERNEL_ACCOUNT);
>  	if (!fnew)
>  		return -ENOBUFS;
>  

[Severity: Medium]
The changelog says this "closes" the bypass that lets "unprivileged users
to pin kernel memory outside memcg charging". Is that accurate when the
larger, user-sized allocations on the very same basic_change() request are
still uncharged?

basic_change() charges fnew and fnew->pf here, then reaches the ematch
tree through basic_set_parms():

net/sched/cls_basic.c:basic_set_parms()
    err = tcf_em_tree_validate(tp, tb[TCA_BASIC_EMATCHES], &f->ematches);

net/sched/ematch.c:tcf_em_tree_validate()
    matches_len = tree_hdr->nmatches * sizeof(*em);

    tree->matches = kzalloc(matches_len, GFP_KERNEL);

and per-ematch payloads in tcf_em_validate():

    void *v = kmemdup(data, data_len, GFP_KERNEL);

nmatches and data_len come from the netlink message, so the uncharged part
of a single filter can be much larger than the charged part. The same
tcf_em_tree_validate() path is used by flow_change() and
cls_cgroup_change(), whose filter objects this patch also charges.

Should the u32 hash tables be converted too? u32_change() charges the
knode, but the TCA_U32_DIVISOR branch in the same function still uses the
default gfp for the up-to-257-pointer table that is published in
tp_c->hlist:

net/sched/cls_u32.c:u32_change()
	ht = kzalloc_flex(*ht, ht, divisor + 1);
	if (ht == NULL)
		return -ENOBUFS;

The same object type is allocated as root_ht in u32_init(), also
uncharged.

There are a few other siblings on these paths that keep plain GFP_KERNEL:

- fw_change() allocates head = kzalloc_obj(*head) (fw_head with its
  256-entry hash table) a few lines above the fw_filter allocation this
  patch converts.
- route4_init() allocates route4_head, which carries table[256], while
  route4_filter and route4_bucket in the same file are converted.
- fl_init() allocates the cls_fl_head plus the rhashtable that grows with
  each inserted filter, and fl_tmplt_create() allocates the template
  object; both stay uncharged while fnew and newmask are charged.
- tcf_proto_create(), tcf_chain_create() and tcf_block_create() in
  cls_api.c, and the IDR nodes for the handles being charged
  (idr_alloc_u32(..., GFP_KERNEL) in basic_change() and u32_change()).

With the boundary running through the middle of one netlink request, a
memcg-limited task can still see slab grow faster than memory.current,
which is the signal the changelog uses as the reproducer. Was leaving
these out intentional, or is the intent to convert them in a follow-up?

> @@ -212,9 +212,11 @@ static int basic_change(struct net *net, struct sk_buff *in_skb,
>  	if (err)
>  		goto errout;
>  	fnew->handle = handle;
> -	fnew->pf = alloc_percpu(struct tc_basic_pcnt);
> +	fnew->pf = alloc_percpu_gfp(struct tc_basic_pcnt, GFP_KERNEL_ACCOUNT);
>  	if (!fnew->pf) {
>  		err = -ENOMEM;
> +		if (!fold)
> +			idr_remove(&head->handle_idr, fnew->handle);
>  		goto errout;
>  	}
>  

[ ... ]

> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index c297d7dbcf916..ac6d0fa5a40e3 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -1114,15 +1114,16 @@ static int u32_change(struct net *net, struct sk_buff *in_skb,
>  		goto erridr;
>  	}
>  
> -	n = kzalloc_flex(*n, sel.keys, s->nkeys);
> +	n = kzalloc_flex(*n, sel.keys, s->nkeys, GFP_KERNEL_ACCOUNT);
>  	if (n == NULL) {
>  		err = -ENOBUFS;
>  		goto erridr;
>  	}
>  

[ ... ]
