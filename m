Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9531C364E93
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 13:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781962536; cv=pass; b=VV8UoVPh4FsLrM39BaImBVcaaKEegQf6TvswA1QdVhFPWWYHrW6+6gVd2fmV/pptfcGlAKQhkZXmu+giXmgKvIo+/yvQotqTWRDzpyFKxWIixoO+haEu5dpplGWil8ynOdkVyx5ZsEFfXWX52s2sPLoTo6ITQJU6AEka6ZRRkaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781962536; c=relaxed/simple;
	bh=y3doYASW5ECQ4nHcNiLPC+9Ao8BMX93ek5uutFzUeIQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ugQK5olp+fPPHUrZ7MyD8IO4ELi+VNoIAqFFwOuXzOX32nguiTAdg452agixip+5WMQM1+uMp5Sg5KSFLOYpqhr8WK1TQm6sYgJ/XROrp3Di9FebAMx1m/g0l0Cr081rudXqRjjLykTEjx38zeifIdVkeUvdylOXTJkyug5Cc3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=wwNZUTbH; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="wwNZUTbH"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-66310a69f65so895579d50.2
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 06:35:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781962534; cv=none;
        d=google.com; s=arc-20240605;
        b=HkC/iApz4TQ8Ky/nRb4j3DloDvTCr6XYI/n3I8LaTliKgc14ewgOO+H+hBBKgIyEvA
         pCqTBFNmL5FNh0ZFc7oZCnRoFkyHjLs3XyznLtwTq9XegVL0GBj0cz8F9dfvoe6YaZ7L
         pIQxIYTBxBfXvDY9247AvAKGs6qahzqwhPMdeps/PJMUIS/ybPJhsdL6Z8hv1UP0fdU9
         QMh1Pl5oGJ395RxrGXD845Hm3yBqM0qWo9pVjeq8QeJxmhNUUbmqcojFAqTVXssWkk5v
         KcV38ypdjk+6ovA86VPdd+vOD8wSTTBUzvGpddM3wqCicllU9p0sYXMDuyhNsMeGyuv+
         1Jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yx+PTC/S7HbVkqI1ApnQaU5vb58oKN55FN9FqUeM7fA=;
        fh=Ln0RpI+NCV5Fyz7n6b2K76tnj+9FP3fBY0wEfx2HjgY=;
        b=Awaz6XM7IT2cgXthlcxaIKMHzDnAh2aeD9NbkNXoJsMzcJ2GbUmPkTkN92oJlJQPe/
         XGyFXJ04qyKtszv6qYYoE7rkn8Y0JjDLa9X78HcAhs+zH0Zba2UOE8GqruylwK6XakrK
         YQDFidCYV8HO6x88EjjTARWnj768PX5Lf6OkMhsRZyHkWcQdCVzF7BSpFxHU4hPq2V18
         teiGUjpjsFgKk8az/a371QojK0UV4PfuisGotJqdaM9LZzFwF127s3qOtalwnGLIfyin
         1oddk+vxBfClDeaZ2wOCZ6bHXuXWl7XU0bNuITHTSRTudHWUA+qjM6vfe3Ti9fSEcXG4
         qwbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781962534; x=1782567334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yx+PTC/S7HbVkqI1ApnQaU5vb58oKN55FN9FqUeM7fA=;
        b=wwNZUTbH87bJdU8ccQ1ThL9vx+JKJo2SUgiGUpYF6iVOaPLs9AkfC1Ty9puMp8qBeM
         KTdKD17kJ+tGHUmscJmlGk5DZEgR01TIJoegXftJ7Ct8w6pe0s5j+gE5qHS8btcVCQdD
         C8f5o5y46K8ijk0OpsPK8Yw0avT1EwBQIMKEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781962534; x=1782567334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yx+PTC/S7HbVkqI1ApnQaU5vb58oKN55FN9FqUeM7fA=;
        b=MPS5LDr6Dw5qM2tF1wZ2UJYx29EL0VZ7Fu/2VteO0P6RgzPEWDauksfbaX5t9DzZ5z
         g7cny6gxfJ2BBKEauSYvmOx7cT+y9rZEp+LQcRMWoGhx1QFtXlw3tLUArq+hHLRZ3MCE
         Ab4Bk+kvdKgv1btA2sULPHMCbyoD4M0DxU8OooE3/VFh3crfCZjoZpqRnj01O+s3uG/C
         Ji9WSvS45xq/U9e6GJ1FlRc3oVI7cWOJuJy7VKTk5mj5NNX8qcWMQukMxSA90jiwo4uZ
         jZzclKBL+cPTT5Zwg8TCS7c0bHPBkYDawsm1qKnDFcVFncCwlb0NAc2aUZV5V+r6/vmA
         Mjww==
X-Forwarded-Encrypted: i=1; AHgh+RpdYl/PBeb7LEVVu+XxWapOyzDkvqIv3PU7XZQJkAQfryvPG2Y+yR5hV7Q4raDk8XPB0Oy1f94=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXHmhM1Wtb7KPnwL2g8svvHlbXx8jgVTfrOs3Y7iVgDYR48xeF
	d5/uywseyMnII4paltT9E2jT1+ZP81XQ5NGMEXb7Op7ABeOGTdrNJJboS21g5a40p7Dkfl1BDMr
	0WACV78dyhtnw7bAVcp70WA25LK5rlGc3rul+Zr40
X-Gm-Gg: AfdE7cnXV98T8JSg4ahblE9yEtmC2FoTXN9djUYuMujV4B8AIUQYoroAiM4bMzrS04W
	F09JGhDok/n//EpXvN4dhFGbRMSbBhuuapb0e6es1WvcSPtkIj69T24+Z44/8mAmMq7/iICfRA7
	+KoYPJJKV73ZnWVbymmxT4Wa4+D66/T5v/cz4Zihq/oSdcA0lDn3F+MhsA7SR7Q0pvS7gcr9NIp
	s9hsDgmcOvidy9x4PUZ09tXH5FAex0AAItgfrfqvRGUJIt8jNh+ynAav1O9L4PM9xAE0w==
X-Received: by 2002:a05:690e:168d:b0:662:c587:4351 with SMTP id
 956f58d0204a3-663033dbe71mr5581711d50.55.1781962534607; Sat, 20 Jun 2026
 06:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619151447.223640-1-b1n@b1n.io>
In-Reply-To: <20260619151447.223640-1-b1n@b1n.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 20 Jun 2026 09:35:22 -0400
X-Gm-Features: AVVi8CfaQz3apZiOvExxZflvS1CkQ5NK9ylZ237bnRCRWFgA4GQhV_B_m-t_Sps
Message-ID: <CAM0EoMk7Ev6oXZ0MzYEbR2Ld2_mHsXv6u6J84=TcSJv9WJn-0Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] net/sched: dualpi2: fix GSO backlog accounting
To: Xingquan Liu <b1n@b1n.io>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 19, 2026 at 11:15=E2=80=AFAM Xingquan Liu <b1n@b1n.io> wrote:
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
> Follow the same pattern used by tbf_segment() and taprio: count only
> successfully queued segments, propagate the difference between the
> original skb and those segments, and return NET_XMIT_SUCCESS whenever
> at least one segment was queued.
>
> Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xingquan Liu <b1n@b1n.io>

Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>

cheers,
jamal

> ---
> v3:
> - Move the UDP GSO sender into tdc_gso.py.
>
> v2:
> - Change patch commit message.
> - Add tdc test.
>
>  net/sched/sch_dualpi2.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
> index d7c3254ef800..5434df6ca8ef 100644
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
>         return dualpi2_enqueue_skb(skb, sch, to_free);
>  }
>
> base-commit: 96e7f9122aae0ed000ee321f324b812a447906d9
> --
> Xingquan Liu
>
