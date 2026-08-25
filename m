Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F191E38F928
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652235; cv=pass; b=iYN3ZHSs/52Li2NUN6Eioh5dM7wHaZ0VY60tWP1TOk5Pt+c37lCpDyaS5Ejkg/shB2J6yrrnD6u0SRb09f6WMWecvm1DAFuLpdgRB+zCpbuwyO+0ipet0lPyNpkucWgkTyyB2cstkv1p2vt5fyMUQB219jhKP2oRRexCS2djQBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652235; c=relaxed/simple;
	bh=FWkt09UbBKIac6SE9n9RsiLu/VCJytuwrYsBhc0fhS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKkM+iD0qkTHBnB9Fb53Z2vRgfFD4sQ6ANosQ+A/aq2uguWEvMFoyP19arceMrSBKb0PI7AornzFUmFSvS5AHxqE5/2JaeX+JzlT8uY6Prc3oFoz215MaFRWKTw77HqAuCZ5glTGFa9xVO3vSneDwjznUSPJsqy4HDLwPl3V4u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGHL+e/T; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGHL+e/T"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e6c4a867cso259696785a.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:03:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787652233; cv=none;
        d=google.com; s=arc-20260327;
        b=XtKTvBVXjj/voz8IP8235jpSES43ArI9adXVjSBLLpKhSEsMgTYYEUEQq+holIgQJw
         n32+8sHb29KnC9fzuGcC1w19LlbIvrNa2zXtl5bwWGwEFD372+yKtr2Hgw4NugUwvsVj
         h52R0YvYWiPcjcW6yg4PslYmDcZJ20V+OzRRA9mMysslwDO7s8d4mJHEnSmQQVAB7jUY
         mN39COHZBQ5iRZNETw7hB8ICdcVec8SnL2RuZ93s/Y/CLlqTh+t1a3COSLUD5b0CEYua
         QewsIBINDylpc9au701Zpj+P4f4T+jQqu5l2F16YKSCykdcgFwd30dtJjGuN/pJcfD+5
         qPGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FoItutinKhxa4OyXuJYgEukYYBMtDGgceiSaSZ7ODBY=;
        fh=G7sN1n7b34fpg5HYFPWiJRN2DGjedEgThae2U6n+oDE=;
        b=bGBfwM4iegDV4xIqPEqUkara8dpgGRhZpZeSwbBA7SkII/6sxog/ICtJvkqTflbiiK
         dPuoibqDpisg0FN+ZD9NOkr+f2RF4D0zsp0O9RFXMZNcLvab5mnkIFo5Nwh6Z552rMmB
         3LDhhQ/HuFng3wQC4lCLJZV5WnOffWVO3aPKzcMnPmCxY4Xtgn5UyTuPaPGJN2gToTZt
         dUnu1PNAOhzQYS3CH+7GVkshMLs72IGg/AFYlnBRcwmi30YIVXRg+O8ykoBLPtE1cvUH
         JiPwuMGE+jRsFn/pgiIlQxlTfpx4mfEdSUlyj5bhQ7ehq8VZgW02ZqLOfDtaC4btT2+u
         gzsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787652233; x=1788257033; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FoItutinKhxa4OyXuJYgEukYYBMtDGgceiSaSZ7ODBY=;
        b=OGHL+e/TXSmzNLPz7FPrE9CDshPw2cwQ2Knk461bM6R7zwMTqZhlQr3p/AVHwpPitw
         PAUWPTm/5WtX3lYxaN80vuZ9pnd1qpiHLL4K5pKa9K3bkblVAehnuARk/26NEiFfIx12
         ao1DlZZium/NepP3k2cFWNqjXQ88FI4ReCz06LI31ImA4HlfEFhDAfl5E0jBPX9oBpYm
         9xIN2jcN1OsJItvw2OU3yI3fBGw+OXH9Muct5EZM1A6q0jUeLaS+BDT3FCr7egEIPWg2
         RkSY9qbsDxm0o2KTyrh00QSbACjeiYuRDUI5Az6/IBMYL/qkoSiH6tOoyGcObsiSF426
         M7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787652233; x=1788257033;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FoItutinKhxa4OyXuJYgEukYYBMtDGgceiSaSZ7ODBY=;
        b=JLZcW5CQaSDZ2XX4C92MqpKWaxf59QiiOTumRcITPiPHFevU1gNhkhxOScfrIJXhGm
         2aKwxdFK4j/4y1aNxzCNifdC2WdkZodjLTIqOQ6jcwcQJrvzBDxmV9iH/YnPQbXft1k8
         VXx7hKf52U+3xWswfa0dtOD1725VOy+RVSZphCC9ClkEsHPEawY8rKq4rNuVim4o6naR
         ldz6LbOUqNmbRulyndNx1FtjzUhMQ9iMa8HOEP4ms3+W6TyUg//FJhqgzLgZ2zmUt/dg
         VMxzAzPtNz06H3tlQinQfJFDmfTl178RnkAfbfa+d1vQ7MHPe+d4vJwHFAPkOT7EMFII
         PRaw==
X-Forwarded-Encrypted: i=1; AHgh+RrxZjQTaA6CzOsSKwRusJLZUZZaUocKZTUpXauedhDC+JVGDNwGEkAqfvpMGYHJ9BtvapJNKXg=@vger.kernel.org
X-Gm-Message-State: AFuF++njzjxJbtJD1L/v5CHsWHHAxonHXAlgisMAaOQaSDnd1pk3RQdL
	4WrIGVlOTcL7Sv1/ZLQIBivtwmoYadvnLZqyenKGk3KEAAiPfy0C0VwJi9RWQStpvHRvbXWx5nj
	qvQ5GLRoZv2v6g2JyKpE/h5dErKseDN7XuGvYxMK9nbzIXVyheybrbu5eIMA=
X-Gm-Gg: AR+sD10VQdKOGztfWnomRWFj9r3d7ejbx/o3Sekvg8Vp7o3nd3NbojgtJ5EtIYbmpmJ
	tLifXuyGlLvjGY+TroHV/cYsgF2ku+HUCP52ObO9HQICUXM6LI6flxK2ScoLHAeYQL8XIkyhLrf
	pgssuvx9mv++XJ3blfGn49aBbeOvQwjiQbQdnwu9e7k6IPg48s6vsMM5ZPr4Bg5pDCS6+/Bp5XJ
	p20Mk7bNg28RnQ0gftSzaVGHePNv7xqKA3mqumZmv/w15O0lMxTod7hIIYBwVWQ+94nBcKFGNux
	ziokO4HaATIWVhOWUvFrNDYn9SMhijRP/zw2y1SpD7X1g0RArP7IqbN5YJ/haT8znY4+YacM7Lw
	Bva/aQbJuzZ2lwTdEVqqUbufmlIpbBg91zZxpdFFpdJVED0lNWHYxAZ6A
X-Received: by 2002:a05:620a:2911:b0:92e:fd2c:6a26 with SMTP id
 af79cd13be357-9376fa52bc8mr508483085a.24.1787652232196; Tue, 25 Aug 2026
 03:03:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822195509.112717-1-jhs@mojatatu.com> <20260822195509.112717-2-jhs@mojatatu.com>
In-Reply-To: <20260822195509.112717-2-jhs@mojatatu.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 25 Aug 2026 12:03:39 +0200
X-Gm-Features: AcwNN1U-T2UVBGOpf4wEx_gJO_Kp1mFyeeAJvr5ZzZXPomIOZJxZG-wpD1QPj9Y
Message-ID: <CANn89iKYg5YzY1QhU7D8mETW6avf4K-yoCwPNGiSrxRhdswbCg@mail.gmail.com>
Subject: Re: [PATCH net v3 1/6] net/sched: fq: add overflow bounds to quantum
 and initial quantum
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 9:55=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> fq_init() computes quantum =3D 2 * psched_mtu() and initial_quantum =3D 1=
0 *
> psched_mtu() with no overflow check. A device with a huge MTU (e.g. dummy
> with max_mtu =3D=3D 0 accepting MTU 2147483634) makes psched_mtu() return
> 0x80000000; the 2 * and 10 * multiplications wrap to 0 in 32-bit
> arithmetic, so q->quantum =3D=3D 0. Then in fq_dequeue() the credit-refil=
l
> loop adds 0 to f->credit (which stays <=3D 0) and goto begin loops
> forever under the qdisc lock, creating a soft lockup.
>
> Clamp psched_mtu() to [1, 1 << 20] before multiplying so the product
> cannot wrap, then cap the result at 1 << 20, matching the bound already
> enforced on TCA_FQ_QUANTUM in fq_change().
>
> Conditions to recreate the bug: a device whose MTU (plus
> hard_header_len) is large enough that 2 * psched_mtu() wraps (e.g. a
> dummy device with max_mtu =3D=3D 0 accepting MTU 2147483634). Requires
> CAP_NET_ADMIN in a user namespace.
>
> Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
> Reported-by: vega@nebusec.ai
> Tested-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> ---
>  net/sched/sch_fq.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> index 7cae082a9847..8a071c35b869 100644
> --- a/net/sched/sch_fq.c
> +++ b/net/sched/sch_fq.c
> @@ -1222,12 +1222,14 @@ static int fq_init(struct Qdisc *sch, struct nlat=
tr *opt,
>                    struct netlink_ext_ack *extack)
>  {
>         struct fq_sched_data *q =3D qdisc_priv(sch);
> +       u32 mtu;
>         int i, err;
>
>         sch->limit              =3D 10000;
>         q->flow_plimit          =3D 100;
> -       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
> -       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));
> +       mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
> +       q->quantum              =3D min_t(u32, 2 * mtu, 1 << 20);
> +       q->initial_quantum      =3D min_t(u32, 10 * mtu, 1 << 20);
>         q->flow_refill_delay    =3D msecs_to_jiffies(40);
>         q->flow_max_rate        =3D ~0UL;
>         q->time_next_delayed_flow =3D ~0ULL;

Note that after FQ qdisc has been created, it can be changed, and
fq_change() and/or iq_range
need to be fixed.
