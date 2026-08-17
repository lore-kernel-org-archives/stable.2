Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A6424D6D
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972953; cv=pass; b=sDsCk5C3T4tA83bGGHCuLN2ALm6KfjBAtH2DvgnBhuFO6aFVd//OYUpA40k8cSeH9VyUSveDqzAH7mOL2f3M761QoxTekOyvBDB4XDVPnmHZNA52gBULO4d/hEsCf0dSRNc2e9PzQMQDyQWUr9OCJESa6NEYPqhCjcQgl3o8X0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972953; c=relaxed/simple;
	bh=IDXBICyW5K9yanU9AkRYwPsRUzVXWytBadGnz45RTes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2eOdXv5eVkdEBkS9qB3ynUoiKqH61v2a+MDA78sR1KUwblQsH9mlQZkNz3qKCnRmcTru9BpHyxvT1fZ/6hfXhrJlkXNtlYhYe/cEeJvp54Stg6BQ76d2dVDs7j6z9VYXKjdE67t0OLF1UNp7xS05bdtNO/0Cvtb4bc6Ad/a7qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=YOSoSbJY; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="YOSoSbJY"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84e0688b7e8so2709266b3a.1
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 06:22:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786972948; cv=none;
        d=google.com; s=arc-20260327;
        b=dAlVoV0Q0MK8Cn3ppPdlZsNlKDo1n4y0po3xjShPTRZJ4SfRDFq5YiwshH7u3Jn2S6
         GS/dCAhVjdbVQuBsJ/NVmrGdpgwDSJAfzuiC41BCunCyw0ANac5QOOZKEvHPadfnlhcK
         7jY5jUNe1hLwMoYO0Ln/5qQLG47IzExsVhExsLM+NC2g3d8nvEErLrfuIfGp5O2VBl6y
         8uDnrVCSWAUkCdnpaLh45yC91jKWlCGsQQZWhAKPd4HIABqecgEC3nKP70DxpMPCO5kW
         BTHC9d/OoBw3YT3aoVZcPafCKyy1QGezIbYP8SYlb7lYUgkbcdtF7i+mCfxq5oQlANB+
         MYHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7p2R1K/orjZ9v/LS5PXtHMMx90Yq9cMvIs7A5Wjt7vM=;
        fh=hCX/zN5jFkDBZ/zUk9/rgoGdcCeD9UPiKdUd2spYedE=;
        b=oktwEIPibDBfLtDHTJs9kJyhnqwhtpI9q/KHtqnmyVN0v1fQPgpwUtGQSSSSvwVxGq
         KbSj/jt5KZEnHdtjaPagVqhiMSaQC4zWhWptyHoDRKKpCeRGZ8gsUFa64+O4YQIx7lTE
         kCWzHM0iBtbYXmGapopL4LhI9Dbw7KnW3xUNW08n49/gDOAd1Nzb7S+7E3j3uc3jaJpO
         MVs4X8ZWKTGxhquL4YpaGYbmbNwlIlfQYoqqwdQw3JbDPRZXpjgZOEKYaEIt944AvsjR
         c3pk/CskJFYJJnxi5EgisrhRWLYlqiaImZgmyO3swcbSucbG7kawcxtJJox5yas5+4U2
         d97g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1786972948; x=1787577748; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7p2R1K/orjZ9v/LS5PXtHMMx90Yq9cMvIs7A5Wjt7vM=;
        b=YOSoSbJY9lksKFVXSUXy4IQWD8KGBXhUqarWZoPGHG0Jp5ch6CbUdM62jigoVAgsSf
         ERnFWCcyjQhSxde1uPRWmES7WqNum+OScElzReahKe6rgl9AGB5RTaqZG8yp1cSqHAkt
         qHxLH2tf1/rooKBo8BtqKoRUvFD5KDLFsEnNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786972948; x=1787577748;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7p2R1K/orjZ9v/LS5PXtHMMx90Yq9cMvIs7A5Wjt7vM=;
        b=THTmraqfq3ByaiY082eOrlUTg92acgcfS/B2p7t4K8+VLMjnjUSFBh27CNs8dfYMOb
         ua/I62ZlwvLKrz5uE+QPqrelnIWQCPSBT9SCHMe3Qh+1C32O9FtrVJWxMvjOKrB4FnYM
         z8aMCnY6bB8AOJo75Yu6NAPMEm9pKwPWrS6HIpG5jvVMXkjwZ1DxEzunK552MOAU/kK2
         rYXIcYwbm3pfAjxzwsKKjACiCsJPxJL1bOweQc4gY8vSQscz9N2szZPzYfy5w8a4eEnk
         wrxMuckOKxAboNk5xo9Si42K2AeZQnHqTuuHHJPFEQfv39NnS4h10V2vlluOyLQI3SpX
         Yc4w==
X-Forwarded-Encrypted: i=1; AHgh+RpWiy3kTNCiu5tmMbHllz1DrhsmK7FQGQLM+Z5m1Yu9TRHbLrB3r7nFuEynFUA57UxCbqrqad8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJQQtixwBME7U/av6mB/+iwdCcMDNdf3CQ9yuHFtTNc4AIFVJW
	toTQ/LOu/WOxmNHFYqpz+6TxhsrfAK42Ao8P6VGcMYCdmp5178TM72w1Ychb+umty5cvncLTKdC
	SdYCCUqqVSNv3A5YvWq8gODfpo5ZS00T5TqoWhVGi
X-Gm-Gg: AR+sD11uMkNPpSXPqlqaAmS+MitV8F81lQoL9uQ+UnYdh2OJy0OgfOWJcG2gugUJi2+
	uw/1x6xKGjvItWSImTqX4RkJdiPvTjU3RA1LqDt3voCN7OEwfpCosOGZd+THd9PMtzj333n96f3
	YFX61jkNQpH9Tkh/50OpprfH/aS6x/rwD2F+vzSI0NauhMJFqnzZSnrxVDuE1G7Hmd+YfKsQaSc
	2wE10jw2FJbmK+mFlLGdTG9SCSO2ZFyWUz43jZVevIkwptllGzrYIj9xhZ2oNZGjKpqHhGFP1Fp
	9/wqmwUY6f2KOy+xz2+K+vtnAddzHr/nOceL5t9o7A==
X-Received: by 2002:a05:6a00:4004:b0:847:99bb:b6d8 with SMTP id
 d2e1a72fcca58-84fde251c75mr26346536b3a.26.1786972947890; Mon, 17 Aug 2026
 06:22:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809091657.879929-1-jhs@mojatatu.com> <20260809094325.2069096-1-zhanxusheng@xiaomi.com>
 <CAM0EoM=6zZVucSOUDi7pJiGhkoeTJ-PN9M18DnPWSpfH4GP6=A@mail.gmail.com> <20260813184515.16a874d9@kernel.org>
In-Reply-To: <20260813184515.16a874d9@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 17 Aug 2026 09:22:16 -0400
X-Gm-Features: AcwNN1Uuyh4IGGmXWZR6U_I6dcEzQ_QXz-mDnDul4sDrX6tz9HQAWXx5NYONCeI
Message-ID: <CAM0EoMkW2a-Brq7tfi36J1-_eGmX02GjGStnMm94oS5RsePkaA@mail.gmail.com>
Subject: Re: [PATCH net] net: sched: gred: fix 32-bit backlog wrap in gred_enqueue
To: Jakub Kicinski <kuba@kernel.org>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, netdev@vger.kernel.org, 
	Zhan Xusheng <zhanxusheng@xiaomi.com>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>, David Ward <david.ward@ll.mit.edu>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 9:45=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 9 Aug 2026 05:56:01 -0400 Jamal Hadi Salim wrote:
> > > The gred check is the newer of the two: it came in with a3eb95f891d6,
> > > the commit in your Fixes tag, while the bfifo one goes back to the
> > > initial git import, so there is no useful Fixes: tag for it.
> > >
> > > bfifo also has more ways in than gred.  sch_red.c and sch_tbf.c insta=
ll a
> > > bfifo child through fifo_create_dflt() -> fifo_set_limit(), passing
> > > ctl->limit and qopt->limit straight from userspace; tc_red_qopt.limit=
 is
> > > likewise documented as bytes.  Since this is heading to stable, fixin=
g
> > > gred alone leaves those paths unchanged.
> > >
> >
> > I should have paid closer attention instead of focussing on the bug rep=
ort.
> > Since i already submitted, we can wait to see sashiko says - if
> > requires an update i can include the others; otherwise it will have to
> > be a followup patch.
>
> I _think_ the Medium severity issue Clashiko called pre-existing is
> in fact a corner case missed by the fix? Please shout if you disagree..
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809091657.879929=
-1-jhs@mojatatu.com

yes, it is. Sashiko (Clashiko?) a bit pushy. I will send a v2 because
i want to add plug and the fifo qdiscs since it is the same
bug/pattern.
Some of these things are ridiculuos tbh but they are bugs
nevertheless. I'm happy to note the bots are no longer finding serious
bugs.

cheers,
jamal


> pw-bot: cr
