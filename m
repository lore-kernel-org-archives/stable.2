Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A71F3A963C
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786269374; cv=pass; b=UvrxTe67hTMdoPR+bpNVGIP9QADy8UacesnCxEXgMCe5r9L3Tzrcwvkh9589EKB1zzwUR+ybddlBCWW/bLX3oY455qLCaw6jNfpl6KD8q2Jzh1SdTBM+rAHiV5/0RppQ8Gg3rdam9lQloxIOZvq80azd9NRThooonZOcvse70sI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786269374; c=relaxed/simple;
	bh=6NbThvuy4rPuJReAEm9UjzLDU20SOkwlmj/LwAEe8jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R3j7U6KsLMkIe6hiS2JK06bbU4xZZNWP44/eJAOcr1tXHdm1tcGXHuBMj5XYju8+IU681NzBMIuVg8/1/SfSEPX2oxTSVEDx91bWmgYv2HmM3Bw3qGcCnfBxEi1m23zcSgCNbn+Hz/JBYBVrVuvbSmMFcOfBvjhqkcboVtDPt94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=zSDZJftM; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="zSDZJftM"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso497131a12.0
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 02:56:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786269372; cv=none;
        d=google.com; s=arc-20260327;
        b=V/AqASQNRmWliAu2RXwhPl/5W9DqhtxKosQrOaZ1oTqqv9/XLozG8m5MpBPR1gGm5S
         PPFikF4GDRsp6dzlVRXLaeqjTXc/EX8gfEh7QjpzGPQGTgQqoQEoi6jDjaEUbx6NvkEN
         jiOkn9W1GQiWqDw4Cr0udVGWXJHYHWri7EG1thloKt1jfTxD0s3PY2ah5KZPs5iqOsjC
         88G/mgQ0+8WDFHXfOvJpWGondxgGEHR+4YxPWuyMHfzAxssaYf05GsPOou47i6YiM2u3
         vQd9sBG9KQ0CepkeBnCXquo2jRGNoAtGO9APIMyhfk5f5gM95T1W9VQ3FByqseRGIhMD
         ACQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QAtBNemFKTwUgi//CJ+v9MoC5iBu5RDcY9yA9uNjhrE=;
        fh=qI9KKcey4xRJjGDIzMs+jPL1Mk8QxJEtT9PLEUaSQ5o=;
        b=F5GZFTuerlBo7gwKWZhJySJCY1OFW9JDOyto+e2A+0DcD4ebCkFzdYzJiHZqlGOd0W
         btMthCF1pXfy7N70bMrrVsVig50Nt2Y3bxd1rKds+LXmqn6rOASyVnZKAoWX9Zwon0pC
         w9boPgJp1nlRec855cUj+MMXDI0fFItc+AEWSH/CLGsNSduvQGqRw4cI9fs8rb/a02p6
         emPtZ0g2aLwrujY5kRCFPe515pvtA9HyPlrU5y5GtwFg1P/5om6ry3bUvfEV65ZsQqAg
         adBdKFAZlzsgI/rEZ7ZlU4OnIdVPKeUiIxcyMBenrNVTW0Jd6Rv+vu/FqNjYy6Ca1xE3
         NTmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786269372; x=1786874172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QAtBNemFKTwUgi//CJ+v9MoC5iBu5RDcY9yA9uNjhrE=;
        b=zSDZJftMp5vlMR6/4SSUPKfRe4PCeZ8ffgvwbxFLe8EL51dd72yXpHA8YFfFu0uPYH
         rZDBxNAyIyUfIhOPd2iS4eSm0doY32LmRzIMVPrOh3KJURBxhXbNdxrc2Lh6LFgIQxGi
         o7F58Yt+yUpfGNvQ3W/gGvkKtleHHFngYkBXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786269372; x=1786874172;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QAtBNemFKTwUgi//CJ+v9MoC5iBu5RDcY9yA9uNjhrE=;
        b=AckP5pUdvjQEV9FZqrDI3hGzvJoOyoXyfZo0zIjFwZP8tVQg0O8ZsVIg5fHKmKIxg4
         l9jUo6q2QuRDkSFGIX2nTVKO0rovq4qavEzY1oqfvaW38pu7wn8wMRjr++CQORJxrE4e
         rBLkVe7axKsuCebFHZ+Ya16UNRCRWcFfM4V1fu03xXo3AXBuVWdmi0Mic+G7TJj394iq
         97uSKlvNu2TKF7VFzerW2sonwMbpd7RDPTnZZ9we0I1NG9ITMJ33YGjQwSglKf+eJgTU
         NKR6GpxWxvBCKXoYhijcTXv7WnLwk+zRazu1nEfnJdkDy0KTLGkQ1WdLzGGB1Z1J3mFV
         SfEw==
X-Forwarded-Encrypted: i=1; AHgh+RqdSaCIqGNhL/oeaiR3tGXjXzuWDi5eC51FZSWMf4t0zLQFacD11jT/Fw5/2TrMsID+wpXmSv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytJL0jVD1A9wAkVj4MrNEW9y3YehnIVuwARe2rsf5uHhSS3RL9
	IvsvIRvfJaenFntM8i7EK8hJxio4Lrlog0yDFfBWDUAVgzZjfbyT/Fnyb3o/47kJ1S7b0/Jc5Tb
	5pZVae1wYtP4o2TMmVmsYIyJ/OYnOEfA3Th60NQVa
X-Gm-Gg: AR+sD11llfDUzFH5oN/pU74iblBfLXobwa2rF+rJLj45bOUEX3z0svQ4oGNykjOUAqq
	V/51GWHnW/gLmYMjhSSDlnDG2w3nCVNcvLeyJcMaHmBWhF+UbnL9zIl7gD81GaQu8KNp2osqkHg
	4d9yShRZMOM+oaLDW5NerMq4I1+aGMf0OnipqZVh20fkDgaD+/27SUaJWjpuWQhd50BFPV78VYb
	euucU0ox1pNtj0ZE0b5SJkz2huvk+JT1uWmLPF7YrAoLmpL4QSmRGkS7L0VFIy4xi8GWQ8zH0Ye
	BPq6WDU6rUTFqD6ZJjeY5bi3X1Qmm/61QP39lfbM9YZqAA==
X-Received: by 2002:a05:6a00:8d81:b0:845:e9ff:5d97 with SMTP id
 d2e1a72fcca58-84f2e025254mr43501422b3a.12.1786269372512; Sun, 09 Aug 2026
 02:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809091657.879929-1-jhs@mojatatu.com> <20260809094325.2069096-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260809094325.2069096-1-zhanxusheng@xiaomi.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sun, 9 Aug 2026 05:56:01 -0400
X-Gm-Features: AUfX_mxoa5eix2-K5PWwzIzpo1d79ch7RQPsOafp-mOlSRe7tulfa1m60BYdmkM
Message-ID: <CAM0EoM=6zZVucSOUDi7pJiGhkoeTJ-PN9M18DnPWSpfH4GP6=A@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: gred: fix 32-bit backlog wrap in gred_enqueue
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: netdev@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>, stable@vger.kernel.org, 
	vega@nebusec.ai, Victor Nogueira <victor@mojatatu.com>, David Ward <david.ward@ll.mit.edu>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 5:43=E2=80=AFAM Zhan Xusheng <zhanxusheng1024@gmail.=
com> wrote:
>
> On Sun,  9 Aug 2026 05:16:57 -0400, Jamal Hadi Salim wrote:
> > -     if (likely(sch->qstats.backlog + qdisc_pkt_len(skb) <=3D
> > +     if (likely((u64)sch->qstats.backlog + qdisc_pkt_len(skb) <=3D
> >                   sch->limit))
>
> bfifo_enqueue() in net/sched/sch_fifo.c has the same expression, and this
> patch does not touch it:
>
>         if (likely(sch->qstats.backlog + qdisc_pkt_len(skb) <=3D
>                    READ_ONCE(sch->limit)))
>
> Same u32 backlog, same unsigned int length.  sch->limit comes from
> tc_fifo_qopt.limit, a __u32 documented as "bytes for bfifo", and nothing
> caps it on the way in -- both .init and .change are fifo_init(), which
> stores ctl->limit directly.
>

Looking at the code, I can confirm you are correct. I notice also plug
and sfq have a similar issue.

> The gred check is the newer of the two: it came in with a3eb95f891d6,
> the commit in your Fixes tag, while the bfifo one goes back to the
> initial git import, so there is no useful Fixes: tag for it.
>
> bfifo also has more ways in than gred.  sch_red.c and sch_tbf.c install a
> bfifo child through fifo_create_dflt() -> fifo_set_limit(), passing
> ctl->limit and qopt->limit straight from userspace; tc_red_qopt.limit is
> likewise documented as bytes.  Since this is heading to stable, fixing
> gred alone leaves those paths unchanged.
>

I should have paid closer attention instead of focussing on the bug report.
Since i already submitted, we can wait to see sashiko says - if
requires an update i can include the others; otherwise it will have to
be a followup patch.

cheers,
jamal

> Minor, and in the other direction: __fifo_init() does
>
>         u32 limit =3D qdisc_dev(sch)->tx_queue_len;
>
>         if (is_bfifo)
>                 limit *=3D psched_mtu(qdisc_dev(sch));
>
> which also wraps in 32 bits, but fails safe -- the result stays below
> 2^32, so the limit ends up smaller than intended rather than unbounded.
>
> Thanks,
> Zhan Xusheng
