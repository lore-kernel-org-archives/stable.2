Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCFC47F2CE
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 17:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787248073; cv=pass; b=XYHcWzhjhgpsK2k4RE92WAoLzhzUdlkc2UzpjEYGvCBSlthmJWkztS94cIXqCfvVrHcKFRvmJ6dOUDmihp7mP2p32+5X/ESN4gqH5XCo0tG9ntevcMS3G32cUkLCcbje/BuXNO9wCMI3QUdVuj+g6EjsyCTlCHz1yYEeIUVW56w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787248073; c=relaxed/simple;
	bh=PK2juyR0+4sSX8nWB4ZgPQINhNKqxmYt1dGYGExkS/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b3kd5sIkVJ+cwY1UyRe1hyY2I8hNwvkIZsKQ2flCT9zNxkHG6KTYrK8GS4eYsOGnrMhoFUXwbTKWfpbSfO+tsJyLm5eO8h1FQYBrLKaEvfXJ6gp7xdQYVlaCpVd+on4gibyUsIHsttLK41yZb/UDrOnuhuvP05td3Ee0C20VBhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=vnIyjEaJ; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="vnIyjEaJ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84fa3b14ee1so66249b3a.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:47:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787248071; cv=none;
        d=google.com; s=arc-20260327;
        b=ppaf/cpxqptdjqS48YxkCvXV0YFEPDHxwTQJjBW0f9Sw32nF6Uk5oabbx2gOGOpSPc
         +4MbvDknHDkZOWyYcCJPmrbGQI1vIEg1exRtIcorxbXbL/XpCklMQdwHVsmcc5x/x1qu
         axBvuy5y05BPt8nTA4YynxNkoNNdz3RdUd/vOWXbj9w22LpsUJUX4ZJQbQ+fPSX90frf
         KWXmZWCGlv6PoMfHnjKRubC+XCpefXK2achIjfmmpzi7riNY+50i5Ki2OwJAQL/u81Eu
         1Tp7CKu1QGpoy8CAWqJEVS5aPnp0Vy4rbRqAHt7DqT+7SgF5RnEtOMN5IaFPHZIuDf0H
         7ZUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9WtEbfb/RtXBpy/BE6EExtoOWnZJQnx3t/3213dsBZI=;
        fh=EAg5rmz5WXGp3M2A+OrgXBoap7BJ6iKjVtr3srN9cNU=;
        b=RTawx/lqYhsZaxAivk5olEYKH0mu/1TgH9RFsjxi20iLulNXre7ny215waQ753hPzT
         iWM0JnboYadDwQ6Q6SETYpNqZCFHKc8s/8hoZQj4VjgtuvlkiZ4ydfNWiLvH93X461i/
         V2C2dMBk1hHwcxAMEAYtMomOvZS5k02EN4ITQjYV62BvGqGQnARtUuAJ8Y7TiwPtgZgJ
         fd37eoMyVxHQn6RZ0gzHKSZ74ts1G5TZId7K1E2+tGvMKFOnDqUgxVuDxQNjsh6HR+kS
         WfFmRQCZw99im7qg4XlbOnAI0MnQt4ohTyOjsmOF4ikIUnJnXwN/iGBrq6LqpWNJcYj0
         45Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787248071; x=1787852871; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9WtEbfb/RtXBpy/BE6EExtoOWnZJQnx3t/3213dsBZI=;
        b=vnIyjEaJQ85wiQmWq9/HZ0YNhFrt5xGZGkKaYVPywExqrIzITq7r5umWa3fYChFPoT
         pSoTYc/+VCJ8+a3x4tdX08a00OmnYtGsNdq1/EIX8HtIiUjhNPcemm9OciJfs8bYBaN7
         2p5aCp6NnajzST4vg9AObzzFInSWfL9FjU0Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787248071; x=1787852871;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9WtEbfb/RtXBpy/BE6EExtoOWnZJQnx3t/3213dsBZI=;
        b=SrzfLeMx8n+ZGHXUn2NACezbAR6ia6QoLiA31SWzuu01xJvnGrnk5YgI/lofIvCug9
         huRs66wATeEhfHcEjDZjbF9w9iD6RzAQEdspcP3qK1fCh9oqjxzWEFOHBgv9ZjH6DscA
         jBVCGM7A/cBEYw7SesTj035xfBohOv8dhyt222ubz/tIxkl3/7tbGJRCM+cuQkltHwZS
         e3f1/EHEfa5NKVOfWje98vO5xNR+LbkhiGFQFSycZV83V8VG0kletcXuIw3XiHDu5s6x
         gMSVOwBSKkOtcrLVtz9+hxJNKnJpucA3UrO5iJc14oxzjWl7A4A1lmPciCvd2asbKoTf
         8hTQ==
X-Gm-Message-State: AOJu0YzaM2uz4dgckNaKgII30Mug/AkA5Xyegesw4LAGTPUqh300FKqN
	t4pedaeCw11Um9OS7DT2Xn4CmUTx54EKXyht3yYFzbJWnlNQOouAiSYjdlWqILlrVZXJJGBZHdQ
	QOjso8Ks6hJlQPj9Ldt2r9VY/Ppv60gbU7Ue70ioq
X-Gm-Gg: AR+sD11IQ4WqRSNrJ+v5Ty8bO0/H7wy7ETdtf5HXKO9T3ClluWUZy1dzrfC0a3zxWPH
	nylWXq0oPqIU0onvowAmJIslbWI4Meujn1VmFZ95CZW4SKH1wIE4dZbjpV5+e9xKe5nFUIN688f
	xBsGdfZktFfdOrDNj+d2T37A63D2Fq0XWRJJGFhKaXHTfonNv8QaEUAf0YcrYU/W4AbB39dqWQl
	zKG+v592fXqCLk4JEyr+34qkQpov9aznFoodnHLSLEZvVT9GBirEtQgxHVXXp0GoicoxYeWvfO+
	/s0FdXzbWTIEIXuZ6UM38wK94qsvnkRdGeaCeOvMkQ==
X-Received: by 2002:a05:6a00:37c3:b0:848:76c4:fba9 with SMTP id
 d2e1a72fcca58-851e6741ab6mr11315632b3a.7.1787248070664; Thu, 20 Aug 2026
 10:47:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818101735.16655-1-jhs@mojatatu.com>
In-Reply-To: <20260818101735.16655-1-jhs@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 20 Aug 2026 13:47:38 -0400
X-Gm-Features: AcwNN1U622mcQ_XE5FHiQQfckxRpOICEQKMJI2lJXfG28Y0JomuR068mochjHag
Message-ID: <CAM0EoMkoRBX5-RZu4-zwJ9CEDFj6sE7q5mzvsoS1bsbjYkz=4w@mail.gmail.com>
Subject: Re: [PATCH net 1/2] net/sched: bound TCA_STAB overhead to prevent
 qdisc soft lockup
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 6:17=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> qdisc_get_stab() copies the TCA_STAB_BASE overhead from userspace
> without bounding it. A huge overhead (e.g. 2147483000) combined with
> a small DRR class quantum (1) makes qdisc_calculate_pkt_len() set a
> ~2 GiB accounting length, so drr_dequeue() spins ~2 billion times
> adding quantum=3D1 to the deficit under the qdisc spinlock with BH
> disabled, producing a soft lockup / RCU stall.
>
> The same unbounded stab overhead also lets qdisc_pkt_len() overflow
> the per-flow counters of other qdiscs (fq_codel, hhf, sfq), which
> were recently clamped per-qdisc; bounding the overhead at the source
> closes the root cause for all of them.
>
> Reject overhead > 65535 (matching QFQ_MAX_LMAX and the max single
> skb length) in qdisc_get_stab(); legitimate L1 overheads are a few
> dozen bytes at most.
>
> vega@nebusec.ai provided PoCs for both DRR and ETS demonstrating the
> soft lockup.
>
> Conditions to recreate the bug:
> - require CONFIG_SOFTLOCKUP_DETECTOR=3Dy
> - Create a veth pair (or use lo) and attach a root qdisc with a
>   TCA_STAB overhead near INT_MAX, e.g.:
>     tc qdisc add dev veth0 root handle 1: \
>         stab mtu 2048 tsize 0 overhead 2147483000 drr
>   (or ... ets bands 1 strict 0 quanta 1 priomap 0 0 ... for ETS).
> - Add a class with a tiny quantum of 1:
>     tc class add dev veth0 parent 1: classid 1:1 drr quantum 1
> - Send one small packet (e.g. `ping` or a single UDP datagram) on the
>   device; the ~2 GiB accounting length makes the deficit loop spin
>   billions of times under the qdisc lock, tripping the softlockup
>   detector (panic with kernel.softlockup_panic=3D1).
> - Reachable as root, or from an unprivileged user in a fresh user+net
>   namespace (`unshare -Urn`) with namespace-local CAP_NET_ADMIN
>   (Level 2).
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

I sent v2 and i noticed when i changed the subject it confused patchwork

--
pw-bot: cr

cheers,
jamal
> ---
>  include/net/pkt_sched.h | 1 +
>  net/sched/sch_api.c     | 5 +++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
> index 18a419cd9d94..a4c1b7b0263d 100644
> --- a/include/net/pkt_sched.h
> +++ b/include/net/pkt_sched.h
> @@ -12,6 +12,7 @@
>
>  #define DEFAULT_TX_QUEUE_LEN   1000
>  #define STAB_SIZE_LOG_MAX      30
> +#define STAB_OVERHEAD_MAX      65535
>
>  struct qdisc_walker {
>         int     stop;
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 65b35528d125..cdcf861c85f5 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -544,6 +544,11 @@ static struct qdisc_size_table *qdisc_get_stab(struc=
t nlattr *opt,
>                 return ERR_PTR(-EINVAL);
>         }
>
> +       if (abs(s->overhead) > STAB_OVERHEAD_MAX) {
> +               NL_SET_ERR_MSG(extack, "Invalid size table overhead");
> +               return ERR_PTR(-EINVAL);
> +       }
> +
>         stab =3D kmalloc_flex(*stab, data, tsize);
>         if (!stab)
>                 return ERR_PTR(-ENOMEM);
> --
> 2.43.0
>
