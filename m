Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FEE3B4EB0
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 15:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028441; cv=pass; b=nco7Qfu/s0yAZrA129InMAakBiW1KpGCFbYuBKLgtUEuZkpj4cuAf1pQlp8BxbjaS2s5Cj+/or+pyifl+M2IhOmYXrVYIKvY8zaQUWCEE0uZ4I5y8PCWNvZvvL3HDmJJ3IszTX5aum76j7e3LDhKynk3NDPxLGJD7ZbASSJht+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028441; c=relaxed/simple;
	bh=xHWfrtbUKzJn60DpMzTvrgdZeVM3KtRHSI8GmZl6zPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIfrHVooS2wImm4GSkaWg5uJbBTT5Ml/7SxYpaxLZQHIPT8OPOW6D73hItuzXs2RjvskuUFQjPhSuasHSkTLsNaULLpV2xQBU7BWLmq+lg0lBD36EbSwNjnMkOqpoprzbYFrbyEmmyh/9o065yBLXKlhPoyFTX3zhYf3JofgAfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKSxu1Ra; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKSxu1Ra"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso12109705e9.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 08:00:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786028433; cv=none;
        d=google.com; s=arc-20260327;
        b=mJofaEuYyBaXdVJ7JSITOTK3RyJFEKS8cWqrVFugzJKkibh1g1vpmIicsyWXAymFa+
         DTK4wjp7UnMKcsFPvVJIvvT/5Fy/FjHSPDCp3AeNcncDuW0Wv/11WwhY2+LcLRSVyfwH
         qlc3wgqTJyA1WIln85woRw5+X7T5uSEWvfPMCha6btKs0/fypjvZSHJWs3uEVM32jgNP
         GQm6MKH6O5xnAwn0pCzaDRYdoM1wTb5UK0mhmrvz1WNe9sMC6Vu/jkVcswSN/aAgZoii
         0OyK56irynlc5lxLZ1Q9DkR3hSyjgIlRm0XY6ATSKaBNycE3AWR81e3KVuQJfjsKb5m6
         epqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bLCroHoGf0o5ghe7Jl8U/e3ej3D31Q4DTDci56rDNSM=;
        fh=Q+/lZN91B2NrNVzM9kUEonZ1epYxxC1JnrzwwO/bARU=;
        b=dCuf6EdbxgQ4b+NGE1kBovQg2+hDKuVPQeGrsuI/PPA9RhSie4twVu5sLKg07blZr5
         1Kck3TPKKzCKQVHHCONDmNeSnFKxL3krvsDP4vDYNcNVTPDTRMDn7+DIJWsh9K6urrMp
         cnYvYLSEntLAOn0O7EKzh9CZzfLGvt+tK3LRHpKLXd7fq9nIMsMuqaFxJX32W3VORXW3
         O3XupQJhVdI6AilluJR7OCOalmfw7pJcCSwOj9HW5NecF3qpRkmEH+83ka5dYcwiMkkc
         pmWuWyXjWZBVaFPuVyUs45th8+qGxgQooyE9/bGjssh6EGVgYUv5fU1PGzUELctVPzw/
         midg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786028433; x=1786633233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bLCroHoGf0o5ghe7Jl8U/e3ej3D31Q4DTDci56rDNSM=;
        b=BKSxu1Raq6JT3Ik0gqq5iBH5cROw+YPM2+EG5MwCXqCZ2JpqHTJyqFznlT9ikO6dZN
         +d6pDajoVcRTZ5sDWVeZxBRgNaIAieqhHV/yzu4lP+bidE+ORLMqgvrWHhxFcfRF94S9
         +EtudeYin7bNjC2etIxahk/Jx57p6j6g3Wl74oh87FioCifGvjLqxQj1BC3phTOCap1h
         BblC2Qq2UzLABLvhtIzrGkhrxiNdVns9ehxCmfWqiNROy4NS/e0rTfey0Cm2zNxUDlLv
         j2TFzagrmemJ71oo4NRoT/yUweoOCc1b/edb7NuFzXqBC07Ce3Je5RMl3/JLgWa5Gt6l
         krpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786028433; x=1786633233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bLCroHoGf0o5ghe7Jl8U/e3ej3D31Q4DTDci56rDNSM=;
        b=EhA4tqdsgk8DKk8GViQEUPUGDaicWNFFruDhTKj75nVFdtBHlFOzpjrzmwqLYGrK4c
         s6Yn8qdipYdMoV1wLmqgq3ADBDpYOzez24YH7aVPzyWQGhas//iYNuBFRhWYJGRMjWag
         SSP0WUB1bJ2JkmDyiKn7WDDj0vXj5SOWGIFSIHq1pCag94fXusy5euS4ZEjOrXBwEcPy
         QMsRDMp5qFvE9X9ae97ESEPgDVbi3A3N0vorcrT5znLMMkMAKGzyMpriTadRtxncOYIi
         onq/cM1KOi3LmN0EEbIskjTu4rXQn/3oxRkkeIxLoGbeVEJI0oxYNClUpQZd7nqeCMm6
         w7hg==
X-Forwarded-Encrypted: i=1; AHgh+RoVU4pksLITiv6iuXlJWPlTi2HY0UCG2GM1e6YJlxMujTGiZe8XeoOnHo8tdZaO7iLqghs1O+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsoQXQaW1b33UFdqog7wIecZQHoHZTQyBajQB2SIidTiW55Red
	l8Uqfok0CHXRaJ54ASF8RRp1wCoyt3AwE55Rb5lmyO86MAOEfdFI7KLi1AYPxGmILb0Gd1jdcK8
	BymFPfoNVmVqd2eOqCXZKhCIjO6IX+ZBsSiEANkU=
X-Gm-Gg: AR+sD10XFQYOEJNwaGBfjANdau8QlhEU6Xip6RpGKhzFnBUwX3Eg9xR13ymI4ov6wx3
	zc/bpBHl/t+Uu+W9OgEM/aUU2USsmlvDXVSJGUdpgo80W25SGSWNLXqtBH8oDE9jNU631ldIb7O
	a9GUwHF3JL119Dc/G3f1BMA6f48CmyEbhIBGJ3TbVfU+gUxEjdBNi9Jd4Dk+duAFqH8PI+qDGi1
	lbtIal/UqSlzy93qH3H7XRtc1dZgRIaAcBUFu5kIq4gua4yASSJP6IePJ+NjKL2CkjQAYvW0RNT
	d+7UjqUkSYNKUeAV4yCcROXwh3Bo3J8Ao7XeiuUZFzAuCQ==
X-Received: by 2002:adf:e005:0:10b0:47f:8b9e:f44e with SMTP id
 ffacd0b85a97d-47fec52828bmr21215134f8f.12.1786028432410; Thu, 06 Aug 2026
 08:00:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804213917.3413525-1-gyf161023@gmail.com> <905fe2d9-a8c9-4047-82af-6f530d024ba2@linux.ibm.com>
In-Reply-To: <905fe2d9-a8c9-4047-82af-6f530d024ba2@linux.ibm.com>
From: =?UTF-8?B?6auY6YC46aOe?= <gyf161023@gmail.com>
Date: Thu, 6 Aug 2026 11:00:17 -0400
X-Gm-Features: AUfX_myepY0Ow5BHeLBg3UOI6iMPPgT6p_3js1Gm3-IOdv6gZ05ymxdaZ7gYMsQ
Message-ID: <CAB665WCeZ2bTxCduGqKb_xeaoDb1Ty9wJ+vZ2be_jwj5osHYrQ@mail.gmail.com>
Subject: Re: [PATCH] net/smc: fix sock refcount leak in smc_switch_conns()
 error path
To: Hidayathulla Khan I <hidayath@linux.ibm.com>
Cc: "D . Wythe" <alibuda@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, 
	Sidraya Jayagond <sidraya@linux.ibm.com>, Mahanta Jambigi <mjambigi@linux.ibm.com>, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Karsten Graul <kgraul@linux.ibm.com>, 
	Ursula Braun <ubraun@linux.ibm.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hidayath,

Thanks for the fix =E2=80=94 I see yours covers the same issue and was post=
ed
first. Please disregard my duplicate.


Hidayathulla Khan I <hidayath@linux.ibm.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=
=885=E6=97=A5=E5=91=A8=E4=B8=89 02:26=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Yifei,
>
> Thanks for looking into this.
>
> Yes I have submitted a patch for the same issue.
> https://lore.kernel.org/netdev/20260804082800.498672-1-hidayath@linux.ibm=
.com/
>
> Hidayath
>
> On 05/08/26 3:09 am, Yifei Gao wrote:
> > smc_switch_conns() takes a reference on the socket with sock_hold() bef=
ore
> > dropping conns_lock to prefetch a tx slot. On success the reference is
> > released by the sock_put() after smc_switch_cursor(). When
> > smc_cdc_get_free_slot() fails, however, the function jumps straight to
> > err_out without a sock_put(), leaking the reference and leaving the soc=
ket
> > unreclaimable. During SMC-R link failover with an exhausted backup link
> > this leaks one reference per failing connection switch.
> >
> > Release the reference before jumping to err_out. The err_out label is a=
lso
> > reached from the smc_switch_cursor() failure path, which has already do=
ne
> > its own sock_put(), so the put must stay at the get_free_slot failure s=
ite
> > rather than at the label.
> >
> > Fixes: c6f02ebeea3a ("net/smc: switch connections to alternate link")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Yifei Gao <gyf161023@gmail.com>
> > ---
> >   net/smc/smc_core.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> > index cf6b620fef05..04c6ce608ec7 100644
> > --- a/net/smc/smc_core.c
> > +++ b/net/smc/smc_core.c
> > @@ -1148,8 +1148,10 @@ struct smc_link *smc_switch_conns(struct smc_lin=
k_group *lgr,
> >               read_unlock_bh(&lgr->conns_lock);
> >               /* pre-fetch buffer outside of send_lock, might sleep */
> >               rc =3D smc_cdc_get_free_slot(conn, to_lnk, &wr_buf, NULL,=
 &pend);
> > -             if (rc)
> > +             if (rc) {
> > +                     sock_put(&smc->sk);
> >                       goto err_out;
> > +             }
> >               /* avoid race with smcr_tx_sndbuf_nonempty() */
> >               spin_lock_bh(&conn->send_lock);
> >               smc_switch_link_and_count(conn, to_lnk);
