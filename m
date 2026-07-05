Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B0F374A04
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783264760; cv=pass; b=G35dPTb033JCcrRMGuiE30bNN8hHckjo4qNIiVBdhluPNHVHORxNRw7k0nUyQXCZfV1VBRdMNN3YO7B6cZ63qzk1ahur1Gf2C3SGRY6XyYW/EjUMSC1HrgU6Y6IDxdixYNOI7euO/Uwz6dAN1qV8GSI7XOuvQZEhLr4dyWZ+L8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783264760; c=relaxed/simple;
	bh=oP7nSsm92j9AKFJ5eaVUz/K2L8mjciRFihFP24h4pN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lJqqUUiQOs0LO6bguvvOvnYo0oO55ob7ZL/KvidbbbeSVOSuR5R2Goj7DpkykHZTqSHJFtcmcgSzOkMN0kX7wxvXrn3rk0Nh1eFh82TfgXmzl2xZKSU/i+R9cJOBBnRD9CmlmItazFBkRx+u5C1wkt/SokGf70tUTyv6nQ3pWNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9ZXbjV3; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9ZXbjV3"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-381065a7a03so1525249a91.0
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 08:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783264759; cv=none;
        d=google.com; s=arc-20260327;
        b=DY07A0cD6SC4kaKPPZQu5YvRP9L5kASJkzXGI1gnhhxmpzKv0cTxKxfRpSpJAUcj2/
         XEIZgjIQgaCSn/M+3CeuGDK6N5OY+3Dwh5hECRlYDOs935NpNKes9rqQIzac6mg/U53c
         VGUwPEW4OsNbKFsBtp0FqUoBbS6ZfD2NeuQ8kbUCpX8WHOo/lmEn4cDaSU4rsPXv6DVa
         QI6PprEZmBOZib0YJflFOWTeKIxTXQIHcFO0+srb02UaVbVFhwxmGW3FShQIb5WRmkG8
         J6qxxNYPHv7kdyfVdyd6ZFZejcveXz50ZApTLYmDqRqBWukFnYsb/h1SMfazo/cK6v+M
         F5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oP7nSsm92j9AKFJ5eaVUz/K2L8mjciRFihFP24h4pN0=;
        fh=dljNS2ooK6fYvh9vxurHKUMg+Tx+AOHz+/1AkKhkEKc=;
        b=n+Ep/eO6KL4aBzHqgwXwNWLY/yQDE5TZroWi62FCRV1odnMRMNQ31P3qMxiqONkyB4
         kRbfR4gi1I2JcLRDuZvmcC5i6Wd0IGdotlmGaeT1uUQGMKuCuv44BZr3pACoOroYf/t0
         1ST8sHyEpOPz0qomnIQGI0bxCEUMVkYMmwAl8PBusZq4xXRQEb3ycePEBddjuiaxSv8n
         dEatVR29T/62Nx1QjA93QJ4GQvt6r8Na62No6o5m5iTTMhOdyk5S0iSDUSU3aR6x/Cot
         fo68lKwB754OqiU+QpcRnoXpcGKzsp3wPbyPumr1cum0pHEg7CrqrKmWisxbwDVNQXI9
         RVFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783264759; x=1783869559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oP7nSsm92j9AKFJ5eaVUz/K2L8mjciRFihFP24h4pN0=;
        b=E9ZXbjV3XrOfKJhFLJAuZIVSzyrt7nGbNIZYU/Y61of8lbJf5fT3w0YLzmtK6VB8xM
         Kojy/T1tAZuo0zNSQX2i+D3gsiOaEPzZmqSLOw5SNCO6ONUpRyAVh8n3GEZa7euqjZe3
         YM+Q1x3AJFqAyY8fu+NY6+uEG55bzVLx/LTmVZc+7wQNWCSIKSzSxh5jAcRvwHZCiPBM
         MbHFdp7kudRLMlZo9+hgkg84aHb/LX23MQKN/oINmFEnjHm309Qipn3lnR9je2oqRGXE
         08uAXNQmgIAhtMs8IEKWu4lycJbkb3CltLudpB2WAgC+D6cVSkOt990g10gFjC3FnyT1
         NH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783264759; x=1783869559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oP7nSsm92j9AKFJ5eaVUz/K2L8mjciRFihFP24h4pN0=;
        b=ESTiiZV03uWaXTy724PcwXd5ZF4bsWnm0sk1mFKAaSR1PAF1W6wsJsrP1+wcGC2ek+
         rGziUItqscm509Acdlym0XU5d6GKHEiBvJJHCvbqhVeMlxRZ1Yd3peVpxehl2p7q99aN
         HM2EIZ7rO5owBdlQL4KkDzkq631bCviyFQ8FsL5Gf+OabdZ2OhultpRYU/truB+FYmer
         Z6X1yGo+uR9Qm03ooNFS3lVCGSnr6nGRb/QKOV+YphFRaW/GGMDg89mojl9vqjzxzif1
         n0Q/R1sJMP4WaTGRhtWZZ9XQvSjnol05Fjkrj4XqgQonqifLUPWT0x7BwfAYf4DN24Im
         xfCA==
X-Gm-Message-State: AOJu0YyzyIXGkrcY1d27goR52fi2OxkCW4H3bP6HiTPZYq8ZK7V1LfCb
	BbDVMqSkqUnbTJJg0yWRGekY76pS5geE/IO1byTjewVi/tU8SW9NeFjHLfBK8om6C6yrSZMobQa
	JzDoCjR4lifdXHyHalXqDEqQdxixBxG0=
X-Gm-Gg: AfdE7clq1z+dgKmhR6rdsB5KomlONFd8RWvs173JruHHt9SBaHPH76DpGQzS62uKx5I
	iXiJOFs15hBoBQ4zOySzG9DBOhvD7J9QPIXvbYDZSLKO5vkqB7HE5fWjFfMmJPX438WTDI3FqKp
	xPEINAF/NzKzWPhFLKDc3ny09VECk+TwsOGiJWsMJ/ENfib4z2s79FcRVVcSXooT/ZQhJ8gPrOP
	tfdK01c9pqM/PFU98f/EJ0wD7RgVFN0n+RBJxQRvWEJHWn6on0Ylg7YKLAisOuk9hje1fETUPI=
X-Received: by 2002:a17:902:ce10:b0:2cb:ea0b:9164 with SMTP id
 d9443c01a7336-2cbea0b92f3mr66876105ad.6.1783264758990; Sun, 05 Jul 2026
 08:19:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528194657.359703301@linuxfoundation.org> <CAFQ-Uc-wu8fbTDXhtyODCz36_1DBue5ay7V2LpzjrUgHs+0WvQ@mail.gmail.com>
 <2026062933-storeroom-amusement-0b66@gregkh> <CAFQ-Uc9p7PhXp-FC4N3iYAtyeKgN6z4A_+L8YwKDAkXxZAvksg@mail.gmail.com>
 <2026070446-blank-duckbill-13ec@gregkh> <CAFQ-Uc8AAEGw90BPximQm3cLzB+KiH_PXr-UZEPK9nvueMGtSg@mail.gmail.com>
 <2026070406-squander-geography-213a@gregkh> <CAFQ-Uc8CDnGUH3xhjaVBd+Dr=+b7Lfu1SUrGGh2gQ17WW+gqxQ@mail.gmail.com>
 <2026070421-overflow-voyage-73b8@gregkh> <CAFQ-Uc9JvsHVCgj6ydVrg++hA4CCxw+FuQYfKzBC65HyuJNMoQ@mail.gmail.com>
 <2026070400-broadways-designer-ea0b@gregkh>
In-Reply-To: <2026070400-broadways-designer-ea0b@gregkh>
From: maher azz <maherazz04@gmail.com>
Date: Sun, 5 Jul 2026 16:19:07 +0100
X-Gm-Features: AVVi8Cflt3WU4EW9KvEe6pUrgWLhymOYj-fuuxb_awP3laKJg2ZT0yxF-A-6ylY
Message-ID: <CAFQ-Uc_+TQutABrGb5+JvrBLUyq30KcfLURQHoJdCw_Uu9-MPg@mail.gmail.com>
Subject: Re: [PATCH 7.0 345/461] vsock/virtio: fix zerocopy completion for
 multi-skb sends
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, Jakub Kicinski <kuba@kernel.org>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes i am sending to cve@kernel.org, i sent using another email just a
few seconds ago, please re-check?

On Sat, Jul 4, 2026 at 12:40=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jul 04, 2026 at 12:34:20PM +0100, maher azz wrote:
> > I=E2=80=99m using gmail directly. I=E2=80=99m requesting a CVE to refer=
 to it directly as
> > im going to disclose the poc on my accounts so people know about it
> > and patch
>
> You keep sending html email :(
>
> And are you sure you are sending it to the correct email address?
