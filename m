Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7F53BA25F
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151155; cv=pass; b=rrdLOM2TkXlRJZV6okRDHza6GzsY2YJPmK/ZoHVCs1S8nISVgyeiqxDP/cpYsJoYfoR1hTg0h9ksSXf3Du0LtjnbyFhPcwFcFbVKcTLg24Rd6aLoLxupiBo0SMdVhEVtDGcoNJVS/gv0ZTr4Ux18uQ6DSmPpa8/OKE4Zx/nS3Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151155; c=relaxed/simple;
	bh=xX7tul4hXcBSX9qG+ACteaG47P6VqHGByp7AxU87r8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GlHztQdUi0bbd4Q1HIU8iIhi3SIm66sEOafgwA/xgknxPWbEk7tvFKG4k0aTocZzg9FLE4HhAxRRJWius3dOuhitNdX/lsXa4THTsui0k+HTYU7o1v3jazaD98MaC4p58z1leeQ8Ow8idOM/MpSK6pmyydbg0LOEb9T+YGDjrc8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G3XpoIPE; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G3XpoIPE"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92e57a753f9so93286085a.2
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 07:52:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787151152; cv=none;
        d=google.com; s=arc-20260327;
        b=CBhrexMPtNkg7FgYNsq+7U589uk4A5CKc2pSBi1elqZPtIvFV4z78f4R68vn4qpq0f
         UvjEa1xyZ77GgNWyt4tINkVvMro2ZKYsl8Nr/Hp8EkFA5Dhkdwq8WuOYBHWx9R3OZZbH
         X2DPvC3B15trXG5AbyrWMqyPs7+BTjoB2ywPoG1R+oDoxnhKfs+uPMsFhfE05pQxcrVV
         Qdpx28xTZGQTPhB81mu1HgLAdsssSKusbEizwI6iBUO/BNyU5zj/ByDwyhbzDxs5pihd
         JAJHqqY/4sW7RVJrk+43/UvMe4sUjrswLj6vRhibiWfM7SyXNjTSIAt6pqhxVI+SzAlQ
         C8Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e37xg4Cf7pXUssRAo8BCWvtHI0TL4IZrMsLP0V2hG2U=;
        fh=i3IwhoEMF91tY+GnTilxbebUVplaz5k7AvxLb8jk5w4=;
        b=R9bKvJa9WMqwdPwQbPZ46LnuJfl32V7quMNPJIK7POvLWN0xW9hRfNqhJ428adxjYm
         GT0XzC9QBKH5Ww8qIoXBRaM5BEe/INpoodBtAVTVqQlsgnwQiWLpnxGzgmBVzVPVhPxl
         X6tPV0BebxAZVTVAsD+tYSTzaUiRmhYyc9T87Ht2kt+ChljKZ7W9RlnzuGQRmFyq88uT
         YMhu55c57J/S6tCE3TtTUpi3TGsfI45fM/DKOUTnT2dqlzpCCjuntXuCDfBPlseKtF3m
         BVOPm1kPOK8TJ2LHlOAdSHJAjiuDp3/z+dPBLowJImqOpIM9CSM7CUdxi+h9+SffgyI3
         FwFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787151152; x=1787755952; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e37xg4Cf7pXUssRAo8BCWvtHI0TL4IZrMsLP0V2hG2U=;
        b=G3XpoIPEHaz2PtFcb6F4rspT4WyESdoFjVwjOqMIP/w8AH+hnk/p0HvOgf5zOqExAe
         FcVQkZJTBYPDWShWEKCHM4+JovFscNpbDEnTDxAf1m6T1Cf96yuVMkSOl0HkWTdymLZS
         jLv/gMuNR+PHibz0tmmGLIQ6kcbINlFRX90fVtv13Rq+TTdnkH+LZM+servwkwKo5stn
         vAuaKvOntzJyUfcW0vnEMshgTqSaY1x86rkQ5ZLQjuZnID0iF2l/ikvavETzwNneWLee
         8M0MLJyJH2tLQaCGwGRu5aa8syL8kNYZ8qi98e8dVeAyoyRUpcjxlriSTqVmxPtvZzFj
         NI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787151152; x=1787755952;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e37xg4Cf7pXUssRAo8BCWvtHI0TL4IZrMsLP0V2hG2U=;
        b=nkm2Cgromlid/9Bg5LkKySppnbCEcEs01il5sERIsO+eHWBdfQVczAQudMChcDhacP
         BWqZn+Vj2zHhlZsXz3yUtjPPUVELhvtOmaK7TaOBc3WTeJ38/kNpx0yaEBFSOQywWDEm
         Bd6AXbJOgH/rPmevKKV/dc8JMYQoXELU7iiMLgnZfhUSsLFOiTMZK8xPWnGTA2zZ9pAf
         DHE9BjeGidMpxbzRW8O0nSRTRr6zvtPoZXqn4UO2t9mlHP6Smxbrc+6xkFm9qWvUupnp
         fk/FCZgI6q4zru1BafVVtmS0p1qgVVCEnuA+FtNwGV5vVio5wbXqTPuzoWXqRx6yXKyq
         RWMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rri9VhfsUiXeDpxhw6xS83/+RgwacF/EKKf3PI1+wYhYF4cgadjv1lxM+GucqZAO4+CI5C/a1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdQOINeeiHTTI0ywNsC8K57lkrZMLLUvFqOEfmMDt3RFFHyAqq
	4GaZuZ3O6Eter+NDwicE8W3n7PbEUlk1GFAS4N8kNkLrRz8/tYClxSQHPaGkcKfxnt7/k2Xp9Y2
	74Nsw+UVQxjnC2gqPTwqaK/lVc+Ink4H6KNGrbiqW
X-Gm-Gg: AR+sD10cq4yR2yk0pG1WrgyrmOyyB6H6NpNQjNtcVwZ2HwhiTNKbojoeJuSNfF/eF6j
	arfEHE/kYKY0Mr4GWTavbqTh89docRSj5GykTGP0ViLyYwboKsCfsKHD3w/JjF5wXYLHYD0uvkc
	55F0lZGv2fSf2jPhjBcHeGOcsk5Xd0te75evXATV4VRIY1JjDIvQ5qBN2WoQSrBQBs8yFrpsVnx
	UEhmjObmQc472hin+9DEa984llJ3kC9X1kAijpsrH0jlEkweTkuipFbXk3/PBz63T0gTyv9tTh9
	uG1szvlFuySZHWBkXCTIadeI0jb7la5Ln3FSLtvGx/B28wZB9Vcn9PDRH0lZ6kRxkGb/1oeGBoN
	vQedx/OeNTTrm2RgO8quTMyQe1G3s8SblIKy8idLHlTHSLJBXQZlHSA5FA1Ic09eAN+q8VoQllD
	Ttem4LfTY4sZb3SlE=
X-Received: by 2002:a05:620a:1a0b:b0:936:9b1f:d3fa with SMTP id
 af79cd13be357-9371e65b207mr508702885a.43.1787151151775; Wed, 19 Aug 2026
 07:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143213.57401-1-jhs@mojatatu.com>
In-Reply-To: <20260819143213.57401-1-jhs@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Aug 2026 16:52:18 +0200
X-Gm-Features: AcwNN1Xp6InSXOSnLzrSDbazyiPc2lWYJwdnLOyeKjlzuUXiTDsmBqpqmz7lAM4
Message-ID: <CANn89iLM1JT7xeANTFYOxaOKuz1qSmM4yugRDg4y=uFwP7bdEw@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: bound qdisc_pkt_len to prevent qdisc
 soft lockup
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 4:33=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> qdisc_get_stab() accepts a user-supplied size table, and
> __qdisc_calculate_pkt_len() amplifies qdisc_pkt_len() through the
> overhead, the size-table data (u16), and size_log (up to
> STAB_SIZE_LOG_MAX).  A crafted stab can therefore set qdisc_pkt_len()
> to ~1 GiB for an ordinary skb.  Per-flow deficit schedulers such as
> DRR and ETS replenish one quantum per loop iteration; with a tiny
> quantum (1) they spin billions of times under the qdisc lock,
> producing a soft lockup / RCU stall.
>
> Cap the final qdisc_pkt_len() to GSO_MAX_SIZE so the size-table
> amplification cannot drive deficit schedulers into an unbounded loop.
> A legitimate size table (e.g. qfq's overhead 999999999, which is
> handled by dropping) is still accepted.
>
> Conditions to recreate the bug:
> - CONFIG_NET_SCHED=3Dy, CONFIG_NET_SCH_DRR=3Dy (or CONFIG_NET_SCH_ETS=3Dy=
).
> - Attach a DRR (or ETS) root qdisc with a crafted TCA_STAB that
>   amplifies qdisc_pkt_len to ~1 GiB (e.g. size_log=3D15, data=3D[32768]).
> - Add a class with a tiny quantum of 1 and send one small packet; the
>   deficit loop spins billions of times under the qdisc lock and trips
>   the softlockup detector (panic with kernel.softlockup_panic=3D1).
> - Reachable as root or from an unprivileged user in a fresh user+net
>   namespace (unshare -Urn) with namespace-local CAP_NET_ADMIN.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
> v1 -> v2
>
> 1. Sigh. The v1 overhead cap broke the existing qfq tdc test 5993, caught=
 by
>    running the whole tdc.sh instead of affected qdiscs reported reported =
by
>    poc. That test legitimately uses stab overhead 999999999 qfq and expec=
ts
>    the qdisc to be accepted (exit 0) with packets dropped.
>
> 2. Better Fix: cap the final qdisc_pkt_len() to GSO_MAX_SIZE(524280) in
>    __qdisc_calculate_pkt_len() per sashikos[1][2] suggestions
>
> 3. Given existence of tdc 5993 we dont need the tdc test created earlier
>    since the essence of that test is covered in tdc 5993.
>
> [1] https://sashiko.dev/#/patchset/20260818101735.16655-1-jhs@mojatatu.co=
m
> [2] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260818101735.16=
655-1-jhs@mojatatu.com
> ---
>  net/sched/sch_api.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
> index 65b35528d125..ad4f117ff55a 100644
> --- a/net/sched/sch_api.c
> +++ b/net/sched/sch_api.c
> @@ -610,8 +610,11 @@ void __qdisc_calculate_pkt_len(struct sk_buff *skb,
>
>         pkt_len <<=3D stab->szopts.size_log;
>  out:
> -       if (unlikely(pkt_len < 1))
> -               pkt_len =3D 1;
> +       /* A size table can inflate qdisc_pkt_len() beyond any real packe=
t
> +        * (via overhead, the data table, or size_log); cap it so deficit
> +        * schedulers such as DRR/ETS terminate their refill loops.
> +        */
> +       pkt_len =3D clamp_t(int, pkt_len, 1, GSO_MAX_SIZE);

Yeah, although it is a bit strange to mention GSO_MAX_SIZE in a function wh=
ich
does not take care of GSO packets.
