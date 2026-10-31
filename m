Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793470802;
	b=uZIot74UGKlEdIojVQ4bQQVbepv8a1bH5R9aqNmCu/vmye102V6eD2q/4pZXZgtY54E2
	 IwHw6GZ4AxWzv83H0I0ggwLkrAGU6nCuQzpKPG2YiqfbC5XyzH13cthYs0Ukkydsts1qF
	 fL9Ik1grQtVeD5U0ZYK3I51BMi0CxzeDuA/GbcN33gQtu/AkdelnfPCqQvWBzib0OocrA
	 cX40Jzb4uhJ80xyimbiYEz2Vlj2N99QDMbxPKudEUlAVOPPBytGOGdMKWeCX1BnVtrBOJ
	 ntskWMPLjMRH+FR8jbvMaf/3tmmmVRO9yRYxugT6QyurdgY3fXWEgiBYGDTCSkDOucA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793470802;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=D41Hh/NNI4IUeUq+Enn57cI7GAXB63F2OqaY8vmBuTc=;
	b=1fCJoRvCOduUDR5jmXYUVToF1k3ZdI7zbOBhm6O5cuwewerpByFWMuB6HPIwT7fWCjnr
	 3NOmV7ysILgQjJUPmndzyqmwnrS3r28ShW6wku+BtnAOY/hDoURW80W0a9WEAkj7wMTJV
	 m7r36rJhxL9R3booDriadPmvt7mUiot9E6qpyH27wcJTpUc6ojxhcS4yFUerEaBGwDpMe
	 jRCTjcgsogNdoacN0DAenxBrg3JOou0Tp7L1g/+IO9UJKx5INRfLB3i2o1hX5RJkxjAVT
	 6MpMstv1HlHQBXElV1qqapS/Ugfoy0rvjWPfJxHHyoOfcQsPcDJyYhgoL4HOqaGg2lw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QUt55f4L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8D8606A31C
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 18:20:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A8D8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=QUt55f4L
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8ac1f2ff78dso70480b3a.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 11:20:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793470801; cv=none;
        d=google.com; s=arc-20260327;
        b=VsNgcT43GYa3gL+/SdzfKApobReb9Wol5buM0R4ZHf0SEOx+4XmewXpAfrljVFMwbl
         dKz4U4OB1OX6M08aI/zqiagaweYHbmZZwQMv1+yODQaT7ySDvPmytSnpNEc7qQEev9Wb
         hAxJIat5XTnFN0a3MD7dM0n50Sd4wsfk72H6sUX6hr+jYnSQS3XlbaqMsSR6yRjLIJQe
         rCxnS0KtNL3g9Uw1zvxAzuwHF80Zt5agfFuJUAjOfA8hPWuMNfQUXoG6v2gUVT9W5SSn
         OXp4kwH6BYhumBT2kqL9xDMGfVOh5WlWezQm1h+jHOJQKeyczEPGfmZqQamnuEIl0Mg2
         caIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D41Hh/NNI4IUeUq+Enn57cI7GAXB63F2OqaY8vmBuTc=;
        fh=SjKDuXD0Gn0HVFGkdM7//OtOaMIuAABy9FfSa1Z0f3M=;
        b=QSMBvShL4HmNfLtvfeZEuH1L3mpA2GYVef4sL4UGUPQlBI/rJV4t5EgJxRTB8qyjV6
         1xwEZYMMsiXJ+6V6auKWgNGYagJ0FpTV7pS7Iu39ju2/yMOykiHoXGkfitqoXqVRdo3b
         lqWDvds8F4/brznMpiLdJGjHNY5cgvcvLU/G+DOOU3KJCc/1it9EbfLms6PXPmuTX5as
         1kxGQpWPFgDUKtBtHRMFH6IVkq1zLQMTr7wIl8Z1pKBRrKjze2/P5Jb8MBZ38gewSuyn
         d4UTQQ+5NUBaSQDyIbBjXc3qAMYd5XDIiyzE0KXc3tEffArFj/PUqsDxmcNtWh/LvtZu
         BHIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793470801; x=1794075601; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D41Hh/NNI4IUeUq+Enn57cI7GAXB63F2OqaY8vmBuTc=;
        b=QUt55f4Luw2qqAGSZIH4Gu8Aqn3QAekTwR5YXlOoJezua35S0nwd8e1FlH29OazNZW
         MDAHLxE0kTikZM6rR+giL2QRi9bdWJh4JLhmaxhaaXDPPXBDVQj43ViV8exyExacKv9c
         2+LaMcQyiJHRqyNm7JS0DhNEu/4tdK5bu6XEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793470801; x=1794075601;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D41Hh/NNI4IUeUq+Enn57cI7GAXB63F2OqaY8vmBuTc=;
        b=Ab0GEu62aZWkUQJIDddWkJzBEyJhqrXTOtpNQXARHdO7NPkNWDk9sJeB3I26NuHxwM
         lTPiVeJzPZl9ZmMdBSETGYgdi0g2sv3+8kTL1ijxAJDz4qgPjhJ/ILBUVYF7962qnPqd
         Pc1QesLladNSQh17G+g+m/B7LKpZPHDIPJmGbkDhHyZ/jdVeu9gOgRxMUHRXlkjujIEB
         O62K3sHWiowScH+PPJyBPh7qvd6EJ6UVcIJYOhzSVuNvAOYHLLSQn9mh3ntcq+eS7tQC
         vEymHI69FFaZGAWOszlbIC6OcWUrIJR93mbr6/8BiWphi3zUuC/rdd71DaM6ogLq47RU
         dCpg==
X-Forwarded-Encrypted: i=1; AKwUvBzBIEeOskwhZPG7JfzSLM6ClUwe3nmql6u/jo9cS32KCr6GfJAWeIFW66mQ7zYl7kGxlr1wCQ4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfYTT7+Ha4N9VUF9Th4ANUJCXip7B5R5/Pvkk5w4Qd/2DcP3Ge
	qqkK8xdwq2VKX6JYINVIQ2qQPJTFtd5hmTz+/UPSTa6OOSbdMSG/UkeCestIrG7K6Zpn9r5gGHM
	6S+l+x9E+abVBYH/bjo6itUUUok1VevOGsvaG3IhT
X-Gm-Gg: AYBFou0NjCCy7Cla5I5ryNA35e1evaAQztY6LiC9HjCRDl+mvc44AdpjXIq1mP/KJgq
	ke2jdnsZwoEIIiHmKOr+Qf1BgH+Rxsr4sMZgB/Mxt3j9aHWpz1MScd5LpOEGratOoCfLGI+m0K8
	2YTEHUsyaCp2G/3buUXthynmKBtJrI3zt0KWPS2pT+XjKblyRcvtyKNp0LZk3ebZ562TiHHxTxM
	XSYjscXxerdZj4eNzEvhvgRfEHYo0qVVtDYfaM5swXbvYMBmfElTHA7/dCeRBly1xJmzWjqnt4B
	DBLQUUF0ZTctV/yVQJsjTRSovyNnU+5tNtJksgDFjMBeUMbM9+oVb56PLKO7Wm0LXjqcqcn58mO
	TuQrUXJAeCbwMAVRpw4Ryyy52fZ5v+2SIB7aMbrEL7S2O4QOhWIg9pmt49Xxb3G7ESfYygzKn7u
	Kk+xomUjr5vXs47gUuSi1edVGk/Nf4oqXgW468
X-Received: by 2002:a05:6a20:7348:b0:3e2:2b76:bf37 with SMTP id
 adf61e73a8af0-3e9288c7ae3mr3751337637.9.1793470801396; Sat, 31 Oct 2026
 11:20:01 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <SER-NSBD.v1.r0.20261029191634@mojatatu.com> <20261029165943.41fc74c0@kernel.org>
 <CAM0EoM=WYGMNxc=n3j+nwyXA41SHq8o+bVvTR6uYp6HUeEa5aA@mail.gmail.com> <20261031180149.GU257209@horms.kernel.org>
In-Reply-To: <20261031180149.GU257209@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 31 Oct 2026 14:19:49 -0400
X-Gm-Features: AclHuK-mIz4j-feH-N2bwZ5m92RWDfoh4LoIWUMhaR3znmD1qLdXroDo_03SCv0
Message-ID: <CAM0EoMmfjXExhtLkYk2QznPJtQ1wjxwXdfwC7iaY5K4qrwei6g@mail.gmail.com>
Subject: Re: [PATCH net 0/3] net/sched: fix short-skb metadata and namespace boundaries
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, stable@vger.kernel.org, 
	shaos <shawnq1@163.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jiri Pirko <jiri@resnulli.us>, Paolo Abeni <pabeni@redhat.com>, 
	Victor Nogueira <victor@mojatatu.com>, Sashiko <sashiko-bot@kernel.org>, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 2:01=E2=80=AFPM Simon Horman <horms@kernel.org> wro=
te:
>
> On Thu, Oct 29, 2026 at 08:07:18PM -0400, Jamal Hadi Salim wrote:
> > On Thu, Oct 29, 2026 at 7:59=E2=80=AFPM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > >
> > > On Thu, 29 Oct 2026 19:27:36 -0400 Jamal Hadi Salim wrote:
> > > > Subject: [PATCH net 0/3] net/sched: fix short-skb metadata and name=
space boundaries
> > >
> > > Please fix your setup, Jamal, all your recent postings have patches
> > > posted in reply to the previous patch:
> > >
> > > Patch 2 is in-reply-to patch 1, patch 3 replying to patch 2.
> > > They should all be in-reply-to the cover letter.
> >
> > I know this is what you asked for before - but then Sashiko started
> > getting weird and i went backwards and saw it accepted this format. I
> > will resend this in 24 hours and stick to having it reply to patch 0.
> > Maybe the sashiko issue is not even related to this but it was getting
> > a little frustrating. In any case , sorry ;->
>
> Hi Jamal,
>
> Please also be sure to rebase.
> It looks like this series does not apply cleanly to current net.

Will do.

cheers,
jamal

> --
> pw-bot: cr
