Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FD93B3C10
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691847; cv=pass; b=G0eygIERXQA3GoBTD1GFZ8jXKj7pHW2YzzNSnGiJb1xXD0qZXSs5gffKCHwAs2dBE54lsV+1lIaWF2IYfC17rlTbkr+m6EwhQIKscYjwWl0yHIIR1Y3v//K8yYYvb4mt8EvWvlrD1uTWYkwn6cxUG9be73P+u2zWE2lF4cyBiKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691847; c=relaxed/simple;
	bh=jVl8Kk+7N2+3A7OUo265p8WkCedRSfj20KGk2VYd3wI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UeJIbFvkXpazulV2JPkIhtT4cxHCHjd8NzUnWdNfVC1TLVs8eVSsYisqB+6qKcHtPpIkSdR061XxppZsRKMjCvE3CDffVePLShJi67naqvS9Rg3piGXHzOHc6/7dlxUTBeueQcSdwOePaQcC0AkEOXj8M2mBqx5Mebu580ET5/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=Ckgaye1w; arc=pass smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="Ckgaye1w"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8423f52af13so4353105b3a.2
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 03:24:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781691844; cv=none;
        d=google.com; s=arc-20240605;
        b=U2xDYU7LP08EjD8I3ThP52BkEPmJ11r6/hAnOH2q6RV7HSvIOgH23rorqqgtfb0AGs
         D9M17ur9PjNGaSiaRyIeD/S1Fia/Rn5GT8qXwKFXTRo4MEAgfFt58D2w1TyrTmcvyoWr
         +QdNaTkfrW+zIT6yBd1WYSrkAbrTQmFHtxjnu1XCP+1sJ8ZVPYaDEHF2qTMwmWdJVxCZ
         lo2Ronuk4M6D5b2dNGyPSxbbEAiCx0ANCElFzVVdtfF117jQFumU9s604dhESCJpjSe/
         0sIpLcBDSSRIuE62y8nmZ7PBE0LM/NnUDdyfo+Bei327vz31rqtvA4nVGt53b/gFWQQS
         Ddog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SvAKPeBK/UEH+3cfnxX1t7rghGjDy5VtNAsb2Ilfjs0=;
        fh=3unyBgt7YMcHQ/OaN6SFiAMz1BCyit2r5nzKdFDnA+U=;
        b=G+8PBV8dTp8S4Z8rfNKg8wAEsgspXCpsK9DN5GZmZTaPJ9hQ67yZiqoa61kOxwc+cv
         Cxqo57DniKGavF9AdmpiCITpFQHtSgcSCo+W9Ck/9B5fhTiPt+4AHa2QoPe5GsDFpLwB
         e8U1WfqPI35iERmAO7qZibo9QUV0AyxO++Rpctr1ok6G6hVO+ymlBe11lPg2t67IGbmd
         ct7A24kjTMwfyl25eHoEfr2BXi+p1llzvSQGR0NVLXRHRbz61mqFTgvw7AiJmnFIedyp
         ZR86m4dfPqkvkuQM3NfSclCxQZa2+knO9JMCAl7qvZbjZUuIH4NDGgFgNOY1pltTFKCi
         rUjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781691844; x=1782296644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvAKPeBK/UEH+3cfnxX1t7rghGjDy5VtNAsb2Ilfjs0=;
        b=Ckgaye1wLaYX/urugE+uW14hp7U6OGHLUfwKg8P24uiPhWjx38Ita2Vur/liQJA9gm
         EAp05bD9KaNW2HAsXjTBRjumMfRB+GPHDzpBbZ6FxI0UpnYP+cL0gHO/r0kNAW+Xe2rn
         mrATZdVm3h47tpigxClktdtNAI4Hu0GJqfWqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781691844; x=1782296644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SvAKPeBK/UEH+3cfnxX1t7rghGjDy5VtNAsb2Ilfjs0=;
        b=C1wAoLHB4XJiVtyVBERmTJwWZrqszCL7SNOB65qlKrCZAmb8Y71OMLx1SThc8TlaBW
         Sk8iEYs0ZEglBHTVe4l+C8oN+/HPDfvqjkGX7dra4mCNtYRlZaXs0cM4dPNHrOPT3BRJ
         rz6KugdWwE+0k++dljhsp/cXcp5QvcFggtopluthlDcmnVZaom0IUwRFFyXzO9X/mfkU
         z2qeqC0iTLUm2z3/Tj6PxlZhH89+1C4lu1QKqkrURGPEJUTGBHrkknKxWNJP06U+DCiF
         zSmGZPmD5Nluphz05G69WqniYvwxWTNVgE9hIfGv7ugzWq/QRdyKrbt7AQLh/6s3jHni
         qNXg==
X-Forwarded-Encrypted: i=1; AFNElJ8zpiY2qu0sOToS166HTUvhuGQWt9grAhglBdqx0NDDQ0Rw5klTCn05p8qzP3QsO2eWhlfr5lE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7dDubwBz6kg78ue+8j7Tt3ETYGjCLRBx7B28OQ/anMo3xtwP4
	dQbWdANueVxtX8wfuzlv2rOLeOFfazXOgKMNQvioWQFXZVZxXPVtYTlpJizOEe6I4ExHmP2jwIk
	KTaAsyVDhM8UXWJnrn9Hpgi0ZrRx8L6XX7Zh1z6wk
X-Gm-Gg: AfdE7cnjFYN9+xt2aOoYOxvrBkuN76YrwZxA78f8NMzLSEXkDwYeDs6X9ZBmQle3rYF
	AtDhUtfgEfT3NNIZtT1G7KZ3MR9PkMo6eIdluG2JsMUGhNIP4t4Zuk5l088kJWwPUQr3HC/sNPj
	0I/9KIFdsMLl+Bu1KR7NpYni+4ylKY6TFbzP49GzTPy17vFowTvTNXnGxnrm0zC+8zWJ6OSTD+B
	VjzPw4w4WmxEDfeW8FipeTEH4buJBUz36WP8oBW4Y6/Zj4NYucXL0iuYdBeuZkV19bYqKPV5g==
X-Received: by 2002:a05:6a00:138f:b0:842:77ab:35df with SMTP id
 d2e1a72fcca58-8452447d39dmr3419556b3a.11.1781691843947; Wed, 17 Jun 2026
 03:24:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616220303.31552-1-b1n@b1n.io>
In-Reply-To: <20260616220303.31552-1-b1n@b1n.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 17 Jun 2026 06:23:52 -0400
X-Gm-Features: AVVi8CcKfbarbJZ-bMsU6UB3-GhuhotwMtHzB7f6SaXLLmOIiEdwKWrsO43hrhY
Message-ID: <CAM0EoM=o+kBQNND8ViMe8bZQmFAtATav+CFMmtp1udzu+tpTzA@mail.gmail.com>
Subject: Re: [PATCH] net/sched: dualpi2: fix GSO backlog accounting
To: Xingquan Liu <b1n@b1n.io>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, stable@vger.kernel.org, 
	"Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 6:03=E2=80=AFPM Xingquan Liu <b1n@b1n.io> wrote:
>
> When DualPI2 splits a GSO skb into N segments, it propagates N
> additional packets to its parent before returning NET_XMIT_SUCCESS.
> The parent then accounts for the original skb once more, leaving its
> qlen one larger than the number of packets actually queued.
>
> With QFQ as the parent, after all real packets are dequeued, QFQ still
> has a non-zero qlen while its in-service aggregate has no active
> classes. qfq_choose_next_agg() returns NULL and qfq_dequeue() passes
> the result to qfq_peek_skb(), causing a NULL pointer dereference.
>
> Count only successfully queued segments and propagate the difference
> between the original skb and those segments. Return success whenever
> at least one segment was queued.
>
> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xingquan Liu <b1n@b1n.io>
> ---
>  net/sched/sch_dualpi2.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index dfec3c99eb45..37d6a8960310 100644
> --- a/net/sched/sch_dualpi2.c
> +++ b/net/sched/sch_dualpi2.c
> @@ -461,7 +461,7 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *skb,=
 struct Qdisc *sch,
>                 if (IS_ERR_OR_NULL(nskb))
>                         return qdisc_drop(skb, sch, to_free);
>
> -               cnt =3D 1;
> +               cnt =3D 0;
>                 byte_len =3D 0;
>                 orig_len =3D qdisc_pkt_len(skb);
>                 skb_list_walk_safe(nskb, nskb, next) {
> @@ -488,16 +488,15 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *sk=
b, struct Qdisc *sch,
>                                 byte_len +=3D nskb->len;
>                         }
>                 }
> -               if (cnt > 1) {
> +               if (cnt > 0) {
>                         /* The caller will add the original skb stats to =
its
>                          * backlog, compensate this if any nskb is enqueu=
ed.
>                          */
> -                       --cnt;
> -                       byte_len -=3D orig_len;
> +                       qdisc_tree_reduce_backlog(sch, 1 - cnt,
> +                                                 orig_len - byte_len);
>                 }
> -               qdisc_tree_reduce_backlog(sch, -cnt, -byte_len);
>                 consume_skb(skb);
> -               return err;
> +               return cnt > 0 ? NET_XMIT_SUCCESS : err;
>         }

This looks like a behavior change?
Ex: If the last segment failed you will return XMIT_SUCCESS whereas
before it could be with __NET_XMIT_BYPASS, NET_XMIT_CN,  etc.
I am not sure what the best answer is and maybe it doesnt matter. Did
you look at what other qdiscs do? I dont have time right now but will
later - or you can before i get to it.
Also, you didnt add the owner of this qdisc on your to:  - maybe he
has some thoughts..

cheers,
jamal


>         return dualpi2_enqueue_skb(skb, sch, to_free);
>  }
>
> base-commit: fbc6a80cb5d3fd4ac4b56e8c9d791dd17be890c4
> --
> Xingquan Liu
>
