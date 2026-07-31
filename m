Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D93D5C2A
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515650; cv=pass; b=Pi/moRihSrh+j5nStZqJpeF4UpWu//cRUFedu7g9Cavzt6zkaJ2tfBFNWMalayGgF9RUESlCPTi8r8UeWqqb5UwiwO+ZQ0mcCNiz8Htu8iIJPwk95T1OMHcj9jln2bxITwDX2NHjzSC+4XrMxWNyl9L0Qqgg/neBw5rBPXlcYsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515650; c=relaxed/simple;
	bh=okHwXQSOYRv/EX6kAKl/uikenhAdgox5qe1/tlHCQtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WK0S1VUcFL3DTkR7ppW+Y2oMFlMPiTwGHM5D9xzBWM/17WgAsBJxhBw80L5bwrgs6xi2q0VY2rgxOxAgfq2KkLbHx5Mz2DBGeUejNaQjpNHBScB3jT15LJr9szLuzVMlyGwC3QHV8KUmpwOwzBvuj6MQnyJkrLRz54q9VqGJVBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=qcqIdadu; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="qcqIdadu"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84847482584so762945b3a.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 09:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785515649; cv=none;
        d=google.com; s=arc-20260327;
        b=HIvk5jRQ+/vRHvshXyTOyM9KGLU2SOCdC1a/Sdk2zwS2jaYowsb1PTrl4y2t9wmlvP
         LyNmoHc4Dwwl+XQiG1tZZXobEjwSdMBoDBNoZe4V95XW2Kk95tSO35OCVCjn4REmUWnm
         njHiGDyc+Hm189yVrospiS9WAtaktkIEMlKMCAMWg2Lf5BVvFNqnXFDvSLt7UT7UCIjw
         YpNrYLMHaKywC1GE/wGBJ261iPfonzkpnj1vKaYK6M66upNz8RVduncSymy2AcD3IHsb
         WUyJUIONZUStFgjZRA1LWwoandszVWXdC/LRDLHkHQsfz7xbGyqyqRX667Z8MJaNB1qP
         3cZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U/cFb4+9Yfk7EEvP7BR+ieCVi0Z844OEPZlHDt2nv7o=;
        fh=nUj2IwPqAA2CaNHRZkLyi5mTwb8EeRdC9zi+cMM1IR8=;
        b=HyZn/5CHa80OgcO0zRVq8GqTs7oI3MsOdD29bjtSW74hJVLq/TiC/dX70qTWZRmhbC
         sh+b70xX5dpZLx6ctOuyjjXxUoSFl9rGhQoOW1b1kwOilxZzy2Lp2O/dvg6ZC6rVGnjz
         j0L2P/scaat0t7cgg3DG0Q4i624HSAok0115yETiS4TbfYR3nhDHqA8bL5OnosWwJQOS
         higKtQrBSPwLIS+JsncICVuE7MDZJQa4cjLd3GJjCNF3qFnhiaR1hXSowO052qeYsVyT
         YXQGXH6Tsgv5rlsJK5X7Y0El7+W+N2mtXGRKQUJ1xn+6wRduYUxx6+LpQKI305+Rkz8E
         aTZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1785515649; x=1786120449; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U/cFb4+9Yfk7EEvP7BR+ieCVi0Z844OEPZlHDt2nv7o=;
        b=qcqIdaduX3RIF4vIElnRwjAJXV0m7ygIPu02yQ+BFyTY5DZALjkWa2LzYO/qPVbUbP
         nTBgTRYngvvHndp527YNUiB4ZlUDz/sIyz2Xein2HM78RQpSeFskJht3qAMFEyvotISN
         njX2IGllh9gcmDhpiyqF/6a4G/LN8CiRTDHeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785515649; x=1786120449;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U/cFb4+9Yfk7EEvP7BR+ieCVi0Z844OEPZlHDt2nv7o=;
        b=LJRq9+p2veDlKKb8UTYHJjoAKFM9lBvhpJ8Ti9MXhVt5535EI7CkczCX+ZqKr+puv7
         1crMB+w7zl2Xxxs8IkbBTd9hayHyZFUqhC5Oh22S5G9+Y+LwAEmbE9nuCMkSxfj6XIvL
         xfp3zLbh8A1MRzPfEE9M3ObbeDlKoBTlPngivjALESqNdDj0yKOzLrNQFcmH9/mgO8ID
         YCVo0zNlFthU2H1dKLtpNE2kmMG5vT7bACoSDaGLoC99V+gLr3l7FybOVz7z8V89jjCv
         DpvlKOPfKduHXaZbwRfaEnb2DJNIEg/wHrUDO7bGkMDHVjZhRHE0TSw/4c7A+Likm1yH
         CnSg==
X-Forwarded-Encrypted: i=1; AHgh+Rr/hD24Yonl5zndYP3McNiDRec5qTVkHFRWT6QMVH2s1unvwh6pzQRebT0hYo8FIQJwCqVOe10=@vger.kernel.org
X-Gm-Message-State: AOJu0YxICrNQukowAinhxJo4t6qBgrLgBdWWU0B23M9dphEmwjBRHGO8
	GbECbUKiLm1YbrCT/+eAw6GqOpr541SMv2gf/K35hx7/9CctMqJtizx2+KsK2pCdPsjHLWzaT3l
	nqqpK4y0WxNAMbv2pz5QjPjzfUc0OvYmWJD+Q6p5h
X-Gm-Gg: AR+sD10t7QvoFvb6SsD7Yw+9SpZMLImf++YFXrWYWgKnVMm71gxJNAE+j9vORA2nght
	YBtRIcf2cjBc0lzzKKNEKFNbZaLSZ3UKnT0lUwshgQTawLck3hSTrL6SfS/BGfWYqiG/FTICvTM
	jpEsXDIYmdq5AK2SZyOHCZq3jjvaWIFIqyuaG2P73ckW+n4NclrB6SHIF2PfhhUnotmVLUz1HSe
	EGvJQ3EOiGFvRCY/U/b84sXuDwVzOg2NU9oHMF8wgig7Wda33Q9qA2AR/5PzGRC6OnIFju+0EtY
	D8C6fa2bUJzdJ3gKKwCCsr6aNLccL8hUyZpkD6ePRsQpU5WGOhRKXGxQ/CypJjB2lIro
X-Received: by 2002:a05:6a00:430d:b0:848:2ef5:50dc with SMTP id
 d2e1a72fcca58-84ee49a3159mr240282b3a.36.1785515648841; Fri, 31 Jul 2026
 09:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731153031.3201165-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260731153031.3201165-1-nicoyip.dev@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 31 Jul 2026 12:33:57 -0400
X-Gm-Features: AUfX_mzWP3nhr226FdASueIw6k8K3-HTeoneL27FCRHreI6GF6mzQr2bcITxGdw
Message-ID: <CAM0EoM=2Yqg2FqCpxvn7teM8E1m6oF6nebyvXA+JBKuwpowSQA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: keep tcf block alive during offload unbind
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Vlad Buslov <vladbu@mellanox.com>, 
	Stefano Brivio <sbrivio@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 31, 2026 at 11:30=E2=80=AFAM Chengfeng Ye <nicoyip.dev@gmail.co=
m> wrote:
>
> An RTNL-unlocked filter request can race with qdisc teardown on a shared
> tcf block.  The filter request takes a temporary block reference before
> teardown drops the qdisc owner's reference.  Teardown then enters
> tcf_block_offload_unbind() without retaining a reference of its own.
>
> The following interleaving can occur:
>
>   filter request                   qdisc teardown
>   tcf_block_refcnt_get(): 1 -> 2
>                                    __tcf_block_put(): 2 -> 1
>                                    tcf_block_offload_unbind()
>   tcf_block_refcnt_put(): 1 -> 0
>   tcf_block_destroy()
>                                    access block->nooffloaddevcnt
>
> The unbind path may sleep in flow_indr_dev_setup_offload(), allowing the
> RCU grace period to expire and the block to be reclaimed.  It then
> continues using block->cb_lock and block->nooffloaddevcnt.
>
> KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in tcf_block_offload_unbind
>   Read of size 4 at addr ffff88811ae590a4
>   Call Trace:
>    tcf_block_offload_unbind+0x158/0x190
>    clsact_destroy+0xd6/0x690
>    __qdisc_destroy+0xdf/0x290
>    qdisc_graft+0x5d7/0x1560
>    tc_get_qdisc+0x415/0xd50
>    rtnetlink_rcv_msg+0x367/0xa40
>   Allocated by task 85:
>    tcf_block_get_ext+0x803/0x1570
>    clsact_init+0x1ff/0xb50
>    qdisc_create+0x392/0xde0
>   Freed by task 88:
>    __kasan_slab_free+0x43/0x70
>    __rcu_free_sheaf_prepare+0x5c/0x220
>    rcu_free_sheaf+0x1a/0x100
>
> Keep the qdisc owner's reference until offload unbind completes by moving
> the unbind before the refcount decrement.  A concurrent temporary
> reference release can no longer destroy the block while unbind uses it.
>

Please always send a reproducer - either as a tdc test case or if it
is sensitive send it privately to me and Cc the other maintainers.
I will not look at it without a repro.

cheers,
jamal
> Fixes: 92149190067d ("net: sched: flower: set unlocked flag for flower pr=
oto ops")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/sched/cls_api.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index fee4524adc98..d3b2506d87cf 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -1312,6 +1312,9 @@ static struct tcf_block *__tcf_block_find(struct ne=
t *net, struct Qdisc *q,
>  static void __tcf_block_put(struct tcf_block *block, struct Qdisc *q,
>                             struct tcf_block_ext_info *ei, bool rtnl_held=
)
>  {
> +       if (q)
> +               tcf_block_offload_unbind(block, q, ei);
> +
>         if (refcount_dec_and_mutex_lock(&block->refcnt, &block->lock)) {
>                 /* Flushing/putting all chains will cause the block to be
>                  * deallocated when last chain is freed. However, if chai=
n_list
> @@ -1325,15 +1328,10 @@ static void __tcf_block_put(struct tcf_block *blo=
ck, struct Qdisc *q,
>                 if (tcf_block_shared(block))
>                         tcf_block_remove(block, block->net);
>
> -               if (q)
> -                       tcf_block_offload_unbind(block, q, ei);
> -
>                 if (free_block)
>                         tcf_block_destroy(block);
>                 else
>                         tcf_block_flush_all_chains(block, rtnl_held);
> -       } else if (q) {
> -               tcf_block_offload_unbind(block, q, ei);
>         }
>  }
>
> --
> 2.43.0
>
