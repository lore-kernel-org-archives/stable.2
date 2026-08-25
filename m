Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483743F20ED
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654619; cv=pass; b=L4Y3p8cMnbjGDN4exq6YGpvonscp7BwFquJx6LKIT88xoAjerzcZWRHy+Z8lIRbh7GnOlDQ/Se55OvD/1Dn9jalL62EfUDqy8OidJuGmbss+Kvte2TFGPFII4q/RzETSa2VoZHvJTCvROys8J+ZGO3vREx9jdeeFZgq30yNMK9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654619; c=relaxed/simple;
	bh=n5dJjPpKSJfH90elYqlrp5vduTpCXSGX1WJfOfKRPMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQM69nmH8kXt6YwdDhfWVRDP7AD4fVhaS4foTK6muikbkv5eoyQAsx13gG2adKMSufOjvEvsbgMxbiqGE7wkhD+wyuV0BS0PeYXKk8iQVH8OKEa3V8m2RHeao9rvy16JUp4yc1kavyAX4QvcZKmfdF1zEti4CWH5RBFFLj47c5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=GnmSk2re; arc=pass smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="GnmSk2re"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc1a4c62804so1743055a12.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:43:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787654617; cv=none;
        d=google.com; s=arc-20260327;
        b=YnrbVGzcnlnHjn0ZreoigSpM8V4Orcui/pnsBmLh+HYB+DxpWM833m+cx/grU778Kx
         sbosgzh7yBh0FqLZp2Q01NGCoRBv2UOejgZKI25LSXZ9wKMHWggf6++CVTYFSi4adGmw
         9EexXt/dPv32blzsIBeA+MgIJpw1tj7QEyVeMXBLFZNFjasc8920s900q6UcizbCW6Qy
         IUcAw/rV5svpTvFVzt+ypvLQq7Szan2T2ZjsXb5sDRLLc0wZPMEex4FaLUjBAIDGT+0+
         rNJDJmLrNfSV8nq3Ozf5YVv71PUANA2ixpljHEXvPVqlrJrID4LBLrXmiOt4sQHJDSE9
         7r7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZdGTka0Yza0dVcCHhkyzv7CSSWAtqffDnJeFW3qODUk=;
        fh=E2f79+r6SFoVD1/7LQjUQbkoSp05BS2iY0vx7ujiUhg=;
        b=NLrC7TNn798/v5eg3YmuKwP5zdRYv+aQhUQQ6NTSOGd5VEOkg15tACAL/J9mYG7hDZ
         w1YbwApf3pi5Fq+mDcljay8iKPY/Dw7BdncwxHwxFYzIW+spdX6+7Up8QZA4ihx/p8ZZ
         gNNUT8MuQzB/UkNSeJbdraofY4kEIPu57MDImi5RUqPQHuXA4cF1LK7eLJtVONwRyDVS
         aeyadZjwSjs+RAOFyJdqK1/f2Ol4zgcwTuSk+M7nxjedsYgW+QDBthcQCRvunYvXjGR7
         4Xp/nOAH6abs59yE0jh1c4UDGGXYmRJpgcgHhdmLhKmevoEXq+BX8BNUkHPaoctk/YZC
         JHgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787654617; x=1788259417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZdGTka0Yza0dVcCHhkyzv7CSSWAtqffDnJeFW3qODUk=;
        b=GnmSk2recgdwU27hdcnjQwHZs0z43837z10UFtjs7rGE6ATTka+GIi2Z+7Zsm/mO5C
         SYNsNe1/aGjYD5rN21q17K/n9/AbSHBduGedE048EC5zcPr9l+zRnUul6ykuuVbxUnf7
         FseB9tPMKQH2t7xVFsR146wULDawAll+GW0Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654617; x=1788259417;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZdGTka0Yza0dVcCHhkyzv7CSSWAtqffDnJeFW3qODUk=;
        b=ZWaC1IeX3ynyg55IezF0RNMU79NAeGroUyTyvZfbLB4GsOwbs/x+c4G8vrU/+p3Kkn
         BXvwfVMEflzm5ZQHG+F5FBivm9HiFI9Kbtq7OhGMxH27H/Gne9Krk7k7opL7FJvw3+rb
         iIt1e1BDO6o6MNP7eE4a362xai1TRT6bNVU98C5LZJYZlcxWyqbY7IcF0w+uo1YkBS4l
         PqTGYC6V5sAPBdYGvF3RJqtlsqX3Vtud8HyxeP08N5C9iQgZEpu7gvUisTIVsP+CJmOO
         CH2hBRZhkadIQQHf5zNql517Q7aIs6c/Ux7qMt1FO/s6UGw85NQ0Vhp7BoFN/3ZfA73q
         EcsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpWuMhbYnyqiQiPcYbU0OFgG481XiA/S3sss0HgwA8FY+HYSS65S1aNJsSa1/vZYkcJpF6/I8s=@vger.kernel.org
X-Gm-Message-State: AFuF++lDsvSDINEe1iMoMDGr5RdXhrEV+jVwJRtEuTgHpyO/ctauVqqh
	3xR0nzHoIzPHDKE6ydgma5boYepU7DZ7v52m0wQybFScaNtbS+qtrFZBjiYL7MBwBkplBf5PUqr
	5lNJgX20AhT3F3amU+65G/srU2wavSlqcS4ws+MeB
X-Gm-Gg: AR+sD11qLrWPMYOIwiuB/tu7SRSVRIRbUG4SF6onbmcmFaGMkEMVxveabuuvBmLWoyT
	e9jvdZpLRJ5oZ/20mO5WYTuF3Ocdx1zpmasOW63VuuypBjaRt9JYZR6sXIDwp3xcHGFyKlz7M3h
	ZFyME0rTxmaZZwZuXOGUmTthi1ooZqsXKwSALjGbTvwPYMwgmKokWqGShdAwdJyQhjPZ94bP0JM
	fAIsp3d+m2uplTOd4h4NxDwVyBK9Bu/LBelTFc2WqxAdUBXrFXx4+X0qrYaYCaExkPgVg0MvByY
	fWmdvBhMzoEddAE4udO+Yb5kjFHagqAOV7JZpzTj4dRh+Ss50/ZK8vHP
X-Received: by 2002:a05:6a00:8014:b0:84c:4b58:2cec with SMTP id
 d2e1a72fcca58-8520ba2fd59mr48133611b3a.15.1787654616646; Tue, 25 Aug 2026
 03:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822195509.112717-1-jhs@mojatatu.com> <20260822195509.112717-2-jhs@mojatatu.com>
 <CANn89iKYg5YzY1QhU7D8mETW6avf4K-yoCwPNGiSrxRhdswbCg@mail.gmail.com>
In-Reply-To: <CANn89iKYg5YzY1QhU7D8mETW6avf4K-yoCwPNGiSrxRhdswbCg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 25 Aug 2026 06:43:24 -0400
X-Gm-Features: AcwNN1Xhj7XAr_H0RwEMjdPLsdaAYy5h8QYdPE8yQDfMkd2izreMqaJdyy577dE
Message-ID: <CAM0EoM=bNoXFP5ub9gBopJ_-1GxSB68s65pZGvYjGwifuOsBTA@mail.gmail.com>
Subject: Re: [PATCH net v3 1/6] net/sched: fq: add overflow bounds to quantum
 and initial quantum
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 6:03=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sat, Aug 22, 2026 at 9:55=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.co=
m> wrote:
> >
> > fq_init() computes quantum =3D 2 * psched_mtu() and initial_quantum =3D=
 10 *
> > psched_mtu() with no overflow check. A device with a huge MTU (e.g. dum=
my
> > with max_mtu =3D=3D 0 accepting MTU 2147483634) makes psched_mtu() retu=
rn
> > 0x80000000; the 2 * and 10 * multiplications wrap to 0 in 32-bit
> > arithmetic, so q->quantum =3D=3D 0. Then in fq_dequeue() the credit-ref=
ill
> > loop adds 0 to f->credit (which stays <=3D 0) and goto begin loops
> > forever under the qdisc lock, creating a soft lockup.
> >
> > Clamp psched_mtu() to [1, 1 << 20] before multiplying so the product
> > cannot wrap, then cap the result at 1 << 20, matching the bound already
> > enforced on TCA_FQ_QUANTUM in fq_change().
> >
> > Conditions to recreate the bug: a device whose MTU (plus
> > hard_header_len) is large enough that 2 * psched_mtu() wraps (e.g. a
> > dummy device with max_mtu =3D=3D 0 accepting MTU 2147483634). Requires
> > CAP_NET_ADMIN in a user namespace.
> >
> > Fixes: afe4fd062416 ("pkt_sched: fq: Fair Queue packet scheduler")
> > Reported-by: vega@nebusec.ai
> > Tested-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> > ---
> >  net/sched/sch_fq.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
> > index 7cae082a9847..8a071c35b869 100644
> > --- a/net/sched/sch_fq.c
> > +++ b/net/sched/sch_fq.c
> > @@ -1222,12 +1222,14 @@ static int fq_init(struct Qdisc *sch, struct nl=
attr *opt,
> >                    struct netlink_ext_ack *extack)
> >  {
> >         struct fq_sched_data *q =3D qdisc_priv(sch);
> > +       u32 mtu;
> >         int i, err;
> >
> >         sch->limit              =3D 10000;
> >         q->flow_plimit          =3D 100;
> > -       q->quantum              =3D 2 * psched_mtu(qdisc_dev(sch));
> > -       q->initial_quantum      =3D 10 * psched_mtu(qdisc_dev(sch));
> > +       mtu =3D clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
> > +       q->quantum              =3D min_t(u32, 2 * mtu, 1 << 20);
> > +       q->initial_quantum      =3D min_t(u32, 10 * mtu, 1 << 20);
> >         q->flow_refill_delay    =3D msecs_to_jiffies(40);
> >         q->flow_max_rate        =3D ~0UL;
> >         q->time_next_delayed_flow =3D ~0ULL;
>
> Note that after FQ qdisc has been created, it can be changed, and
> fq_change() and/or iq_range
> need to be fixed.

Right. TCA_FQ_QUANTUM is already bounded to (0, 1<<20] in fq_change(),
but TCA_FQ_INITIAL_QUANTUM goes through iq_range which has .max =3D
INT_MAX =E2=80=94 so fq_change() accepts values up to INT_MAX while init no=
w
clamps to 1<<20.

I'll fold that into the follow-up patch I'm preparing for the
fq_pie_change()/sfq_change() 256-floor gaps Paolo flagged =E2=80=94 same
pattern (init clamped, change path not). Narrowing iq_range.max to
1<<20 will reject at parse time, matching the init clamp.

cheers,
jamal
