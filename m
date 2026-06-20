Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539DB379C2A
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781962756; cv=pass; b=kzrVPhCcCWQ0GVgDFqhXpXR41liUXDZ4OJ4VhEsEwNcJxL2nXkt8EJmpWLWEAi+/AVq5txbHx4MtU20YFYgOkHYkiIDB80krhRibfXSnT+vSeV48ZVEXTF9RWptyzeJ4hGYUD45TyX+tISkNkPpErNekgfIOBA2+iB4DLTh2Tdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781962756; c=relaxed/simple;
	bh=d/2Xphxb/NI8SXff8epqBhW9BadwTw3kZPh26Vr8TxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ts74USAC4OupTPalzZPEsyG6qNFtlfdOojixYrnDP9OvHVo1TdpARxPaoFBckDS5fukD7pfpR7DRQScOnGUQa6ODxJ/1QARudG5Jzjrol3IpbHyTgyzbReKCnifLZRPtZMvInmArg0T2H5HX/NbZV4GRU2QfpfMCsTnkOqn0RbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=bOFvcPQr; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="bOFvcPQr"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-662ccb916c5so3105517d50.1
        for <stable@vger.kernel.org>; Sat, 20 Jun 2026 06:39:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781962753; cv=none;
        d=google.com; s=arc-20240605;
        b=FtjK+EqbmI4HkPsxGLpHSJ1sXjqRmUF90ezYnsf0+s4F2mJGRDnv0YnJTfkjMFyY6m
         G+johJsHHdxQheXUBolhQ6cPSsfDNeiE2PkFXDEwq71DabXb85GPAJBvmXGFikehuJbu
         pVJ+NU4zr472pO3ze7onOhHUragGjG4C4Vz9BrqVHxO/9GTekb/GvtcNHNX9w1t0lDUM
         W87VV+MSyOqDnwDg4AwnAaIdTEaYYVJAIT7ObH0nR3Cfeuai6RfuKQc8z7kTi+EYRfQH
         Nc936IAqgHDvsc5DbwF6H1I530ufdsxaDczpTYVyIx0ug6TJcNDTDGEIyu9WSsC48bdH
         cp/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MvXJJoRTCi60JChXHq7XeN8L9UaXun9JAUDhzWqhDrg=;
        fh=1EYiYE5srQBdSuKts2J8Aplb5CRsRmmIb/rPuYCxGaY=;
        b=aw/PB+PaLn0n/D/haGr9Dtv0KsJujh4fzxa+Ksb6onMwYSUUFcsiXyRy2B7PAIQEoQ
         B/sEWWo8eTsgI0GvrHP29vlXH8Z/etxYYiPgCic6OSvvZvjalJ/SQQc8/vYk0V1vtgH0
         OcgWvjgMkNHPFQHOiLCszKSE+kXKJxp9zikTp8ZjNlGofq40cqab6VjGHR9SSkaygti8
         t7YHepdwFj9k7WKurCnEh9MTrLEqd2fKWIS94+swPXnLZ+sUhc2GiKiX7/SzwyCbOEED
         AuJ62KyOcwY1KNPwGE8uuSwD8Y2PPYTOGs5pqtWqGmJ3KMhYiQPbKpYmO6YjXcsXiT3b
         YT/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1781962753; x=1782567553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MvXJJoRTCi60JChXHq7XeN8L9UaXun9JAUDhzWqhDrg=;
        b=bOFvcPQrVxthXOvC7Jm31Cj8l7hm+sQ6sQlv08piCTiTzZhEhAzOUqDqjOtmqgzcYk
         xPXHoaJpNOvgRdaw89x3wvmbWCG/cz8Cg6LruFj8hZIBT4+AABPMqsyOqnWrBeJKd6xT
         kxuo+3VnPNj+6pYSoUGBRjQoHdy2e+z0pQctc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781962753; x=1782567553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MvXJJoRTCi60JChXHq7XeN8L9UaXun9JAUDhzWqhDrg=;
        b=ku/PUzBaLdEtKXiwIbVdhLqC73HDh7NzoR36dFTepg5+jxeTiS9CpgLbsNUHyCdqDs
         3CAmndBEBsqce+eMnmLmbbEWBibH9KPLB+jsN15BQQKRpuZocyH9yUOwbvgH5cjEM8BB
         AKurID/zGEuDnCxa1FYhLDpkXVNnXMP1CqfXYGFM8UVNg6KegbE56bg9nQ1glmxdkv8t
         H3vfzrTTyYTMvsu3eB5n7ibGPo31M2zd++M1MSyamrdZ4l1994AFA2D3hIho1HVn5vnC
         T/kquNiyAtNIHmlStktve10pya4p2/CBKwOwrkRaoGdCIhI3aJGEHbQtzx94ncdHKHdC
         27jg==
X-Forwarded-Encrypted: i=1; AHgh+RqkSc0iToiZYdfl+GyTiirl0IgQ84KSe6zXlB7ZyoTkYVnx7UxEpZWLdDk5/yjsqs+O2xtoKA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkYc9h4NiO6c1NYqoMN8+w9fAKikbgTlvAL/ZSBNAKVp2qPCFq
	mhZo7wF63IkPoMvh56c9Do88hUADASbTFb/rEKGA3wQ+0xA5GSeOyO0QUWtWnYmgEaam88CwSe3
	bfwlKyCmwbRyIHzLhK8UwJwtgXBx7nYf7WTYxgw5U
X-Gm-Gg: AfdE7clEj5NqoWhTwWNITb7kbmGMMtGN+Haq6VbwIcxZC20LFZhY78EAChuhISiH4VU
	VvQHhZqOlrjO9EpLB8MI2rdUYyqoOwCwL8zG0KpysVq8TF8zGJq2oid20SVvhjsxeswziqAjqPb
	FaqPNhaGx43bA7RG9YtkzDPWDgfwjDYjJai9RDuL4PMsXVAMIsnTLqbtnckgmLgVN7G1UlgvlUS
	x+obRl1U/nA9GVAOI3BqLNMb8Gi7BMY5VykOd+Epc9ON8C00Kc7Zh9WF+bSwkpHnS2iCQ==
X-Received: by 2002:a53:b009:0:b0:65e:48cd:7fd2 with SMTP id
 956f58d0204a3-662fcb97f1cmr6274557d50.54.1781962753338; Sat, 20 Jun 2026
 06:39:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260619151447.223640-1-b1n@b1n.io>
In-Reply-To: <20260619151447.223640-1-b1n@b1n.io>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 20 Jun 2026 09:39:01 -0400
X-Gm-Features: AVVi8CeG_uNdG2Eo3vidjrDC2ro61mWJTdFhQ08AjfXtcR5BUcwg6QZpXpOAysw
Message-ID: <CAM0EoMk74Q5W7OFP8OM7YBT6MKPmdeXXo=XQZs8vUMv3eH1rVw@mail.gmail.com>
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

BTW, in the future make sure you wait at least 24 hours before you
send an updated version.
You didnt do that here..

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
