Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6540532E128
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 15:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377337; cv=pass; b=n6FTNcHywAwOfr2D1z0t36A8wNt53/hXQkoavs/OgAECzGzulUeC6HE4x4Q4igzHK6u0SdhqSFxZMykp8BpChXZtIp3nzArRLvpzKiv0Y8XJCoshRnHSl3ruewwE0kY1MqI15pQRMB2C/I64B3nYQe4r0icSHhv7LGsz9mtFumc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377337; c=relaxed/simple;
	bh=5Uf9/VcM5B9RSVuaqj+cody+JCYqoXGghFsCIUOSork=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6118WDYA1gY8t497hfGtBQBhMsWrpNdhSHM9t9nN2peguZWQgUNaeYsk0gY3bBTGT+xHx6ytk9WiNtumw1O+ay4ryNBsshkDG8gJcA4FDnzOdHB3HudFUo3qn+hLPq3Xv2Bij1fEPNkvcRhNwjGWefwb/XlwZ7Og48xM7V5iok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eCuv44Xp; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eCuv44Xp"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so15612a12.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 08:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786377333; cv=none;
        d=google.com; s=arc-20260327;
        b=KZJd1pvwhaAb5xu6bbAncQbviOclokG185ekdgXtZtmqSzSNZ+v+yHetplE1DbYx+0
         pexZPnT6aPkhh3RBu3KBu/vnZJ2ZL+r9OZzB76YxH2JYGiQSftd8wQnfDAb9UMuPuu5i
         AM38mQtsdhXDOKMRioM58Dh925BzqWt+vPMFhpJr12NmmncxoDgnvzuxpamscDE1fUyA
         a+MOpKtVcvJlHc0K64oe4NAJrlzYK3QOwa1qXz364FoBsvNZ4ShKFhMHV8+ylhN+gERK
         ycJhcs3OZd2jqPROk0iasbe01CKensRytTQ+u43pN2PisIN6zKwRWYtfiO4tKxX/oigQ
         YhWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rbA1CHur0GUQ4jEFBypZks8oGwisaoU+6uuW/eNA0YM=;
        fh=IX/0sNU37w5mLSXOzhGhSfwd5/56H8KbT+Kfb/Mq3QE=;
        b=FcLYrvzAXZl4IQg0cTa+iUblAotrIiQzM/fse0f76dqag30MYnAHSBfRVgNa4xKgjk
         m/mHggF4x1E5zoa03rqtzTMgqErDc+8Jj0J85oii3hv1GAEuQ7Us1FQiWM/BtmYiFgdC
         /BHXa9o8G1vsreQLjms4snb1DnANZWU1TPtzAXG6MP2nDZDz6jD9VX5K1XR8QiAXoWKR
         jacc8DwlXc491wDqpkDjBB3kRefjvZM8ZIxVIBrPYp1KxsdgWKckAURKbr+bugwkhrcT
         5Yl3Hu0Do47KxgCEdP6Fga0ghXc/cAEvZtpiuvMw8rPmHL/mFXavB9J0WU/nVbZID2Ux
         KP8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786377333; x=1786982133; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rbA1CHur0GUQ4jEFBypZks8oGwisaoU+6uuW/eNA0YM=;
        b=eCuv44XprK5mKfPY381STcKa1yVqWLxSRwYBvVgwOVNexr0497bU9cT7b03WXOIrAU
         753XWpwqCkih3ANVsyauCxklWMwTqhjNDcgcPA/nxEUd5qdWZCNdNbTwrakZixDsqo5i
         qkV5zHKHno6F7f/rDLoypl2dqtvvIbzOrQqT4tFb+cYU0nqmu2+dCsYh1z8rE7Tlqzyv
         yFxSyRVhxGsZHcj9C9Vpqo01r4k7W+EyokXJqL8YG0BnbnqfV7fLPDqOx5RNSa4AfxFU
         OkXzgPUMYqGl3JPO3eV8mp/rYOG6+kdvwnKyxYsJPAtbJ0Wulj8bU4mgXeskhL/i48eF
         rsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786377333; x=1786982133;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rbA1CHur0GUQ4jEFBypZks8oGwisaoU+6uuW/eNA0YM=;
        b=U9w7y3jS0D9XzSKj0p0jcdA2Iu4jEdDYuRvc9+r6vCSrTLc6KQfPxNbgQXk2SbBoie
         IIqzgrjMFYv05mV89pTU4iCvQQ5cwE3XX1ZAYV4cMFAOJsayhMgI/EexySZvSrGtm4Du
         ADQ+KVDH5F4ZtN2Nl7yuWsTJo3qLWdE0AAi+f4U0IbGcEUIiCII+8ziEjb/bt1ub9yQm
         TqWxbog73y7CknlNOlXigFTYwVE5RdNyMQjBGiM00WkDq99qAIHYnLDDDL6Xkg25EaR8
         5ZusxeNDGHy34LOruZ/qPU4sy5W2ACGsNvVEppbsb+j1oisAHLObHUTlJw+ExjYaV3EY
         5ARw==
X-Forwarded-Encrypted: i=1; AHgh+RrnbLAFLip66U3PsCdsIEcKPzkLjefZlsaX37EviDFjvPxE7jBT2WgToRLneuUsD45dd7bxb6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmUjSFZJu4sXVwN81zymnQ2iebSDVFRxKnY1KNXqASnZVX/J5D
	0YPkU5/L4YQVoO2buxb42nVExh0w2EqFDjR1y2S6Wa9Q3ThmO3Jw0lCHarQSLgj+cbSpypPUMh/
	8jiYUBep2Czv/X8d70AjK5EuJyncEXwsQMzfJUZro
X-Gm-Gg: AR+sD13oRpOXzUQE87AA0hsw0ismE/RxRrp6M0o1tGLjYkhXQm0junCuYX1uCb6KPYn
	nHS85m3l9XztpOL95/6bCriZMJ5FF2aTxjQmg74dTU6hmGyXd5NhioHvb4fID57TobaVlotndtK
	pK6D3Y4cmR7FRQaM8VLpAAmcwo+hHoKMENrkUs6WbDYyFcpLwKuaC1MgGF8sGv/7w787Knw/mIY
	s82/zAhqRvpp4XyLJdCinKoejogvVQZ3bnG/FNyf1DLLC8xNCSZjWfRwWxeseJkZmOqjo9C6hsv
	86TIug5/hRpZyeN5uiI8FmWNSjOrfGMjZIW/c/IvjplNV7+6jDcB4EJhwNwX4GfpDzkiManlJsA
	=
X-Received: by 2002:aa7:ca56:0:b0:69e:98c8:e958 with SMTP id
 4fb4d7f45d1cf-6a1f8abc5f9mr93172a12.7.1786377333065; Mon, 10 Aug 2026
 08:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807224315.234152-1-hramamurthy@google.com>
 <20260807224315.234152-3-hramamurthy@google.com> <724b2c8d-1481-4418-a10a-4331a620cd91@linux.dev>
In-Reply-To: <724b2c8d-1481-4418-a10a-4331a620cd91@linux.dev>
From: Jordan Rhee <jordanrhee@google.com>
Date: Mon, 10 Aug 2026 08:55:21 -0700
X-Gm-Features: AUfX_myD3XTlTxUQqL4tvfBeD_iQAwj02FudsC5BYAQgffmKvKyl1JjnqkX3W50
Message-ID: <CA+mzVttPSW=NKqqBwY9kxdL_r0hKzQfu38eZtmfUB6iaeHcNRw@mail.gmail.com>
Subject: Re: [PATCH net 2/2] gve: fix NULL dereference due to missing ptp adjfine
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com, 
	thostet@google.com, ziweixiao@google.com, willemb@google.com, 
	nktgrg@google.com, pkaligineedi@google.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 8, 2026 at 8:27=E2=80=AFAM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 07/08/2026 23:43, Harshitha Ramamurthy wrote:
> > From: Jordan Rhee <jordanrhee@google.com>
> >
> > Fix NULL dereference due to missing implementation of adjfine, which ca=
n
> > be triggered from usermode as follows:
> >
> > sudo ./testptp -d /dev/ptp0 -f 0
> > [  551.943697] BUG: kernel NULL pointer dereference, address: 000000000=
0000000
> > [...]
> > [  552.061946] Call Trace:
> > [  552.064487]  <TASK>
> > [  552.066681]  ptp_clock_adjtime+0x1c0/0x2c0
> > [  552.070874]  ? get_clock_desc+0x6b/0xb0
> > [  552.074825]  pc_clock_adjtime+0x78/0xc0
> > [  552.078755]  __do_sys_clock_adjtime+0x85/0x110
> > [  552.083293]  do_syscall_64+0xea/0x610
> >
> > Cc: stable@vger.kernel.org
> > Fixes: acd16380523b ("gve: Add initial PTP device support")
> > Signed-off-by: Jordan Rhee <jordanrhee@google.com>
> > Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
> > ---
> >   drivers/net/ethernet/google/gve/gve_ptp.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/et=
hernet/google/gve/gve_ptp.c
> > index 06b1cf4a5efc..1d6c59f4ead3 100644
> > --- a/drivers/net/ethernet/google/gve/gve_ptp.c
> > +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
> > @@ -26,6 +26,11 @@ int gve_clock_nic_ts_read(struct gve_priv *priv)
> >       return 0;
> >   }
> >
> > +static int gve_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm=
)
> > +{
> > +     return -EOPNOTSUPP;
> > +}
> > +
> >   static int gve_ptp_gettimex64(struct ptp_clock_info *info,
> >                             struct timespec64 *ts,
> >                             struct ptp_system_timestamp *sts)
> > @@ -60,6 +65,7 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info=
 *info)
> >   static const struct ptp_clock_info gve_ptp_caps =3D {
> >       .owner          =3D THIS_MODULE,
> >       .name           =3D "gve clock",
> > +     .adjfine        =3D gve_ptp_adjfine,
> >       .gettimex64     =3D gve_ptp_gettimex64,
> >       .settime64      =3D gve_ptp_settime64,
> >       .do_aux_work    =3D gve_ptp_do_aux_work,
>
> .adjtime has to be implemented as well - neither adjfine nor adjtime are
> checked within ptp_clock_adjtime()

adjtime() can only be reached if gettimex64() succeeds. Since GVE
currently returns -EOPNOTSUPP in gettimex64(), ptp_clock_adjtime()
will short circuit before calling the driver's adjtime callback. We
will need to provide a stub for adjtime() when we implement
gettimex64().

My understanding is that fixes should only address real, reproducible
issues which is why we only sent adjfine in this patch. If the
maintainers would prefer we send adjtime() as well, just let us know.
That said, our preference would be not to delay the other patch in
this series ("gve: fix zero-length skb frag with header-split").
