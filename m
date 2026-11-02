Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793586342;
	b=kQ17CnzDoGohqTOpDbkbmUhXtTmyxr5Dsr6vudtKA8TSXaMbFDyrRc6UwDmRfRJ35+UL
	 M1mb+NXj6+9tvoARPtw6ZIk3awnjlwvi4kPjfKW8DrfDqnLjjyXd3xZfNafm6wrwU9whp
	 iXCkZA/26D7mZmVKBv7ah7dqmwNb5aeNCWc9T/ezJhgtuhdtPsciJ8fSCfBTtljhkfiCE
	 ndoG8IHiKpaijTpYaLKsjAldXAczRtvVlomHVN56MpC2p0MH/U7nzWu74+UcwbSf0Jv/D
	 7Z5reGTRuRlOlzvh3QN53S/zS1K5expTS+dzhB8FTTx6j97YmQnnnk2jToZ05vuADmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586342;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0m11DqAQsWViOluQPYNzPkQX9NkHKluVITQUvXZ17kE=;
	b=nok3bMOrVgNk953NMXUlC/doGfklB/vD8PihfXbbkdRlEpzOBIbqhKimqJSGgUIYFv8O
	 rUeaNdMiO7f0Fr+kXQpMEMICbt2qh6DU9CfL5N7CKUwONrLSzjnAQ2we5I05SQG3Hdj/h
	 dRsi96K6HH2L1gLJuoudRxEXmGByT8UxZbC0BmA1ykAfyTnx6ta68wnjcqxi1bKZ46zkG
	 DNsGVxDyanJ5MdV6V4z9XqcrpwVEr3RpViXtzN8aOoJVvm33jxFvsdEvn7fp9zRmDb/E5
	 8MD8fxbzH6Z0823YruXuGgy9kaBZGyh7sUVWUZdi+SSjl6R8jkFseEa3tUHES+OuqkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ugDCsvDY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.49
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FF9606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 02:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23FF9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ugDCsvDY
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5be3d5927ceso2075108e87.3
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 18:25:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793586340; cv=none;
        d=google.com; s=arc-20260327;
        b=UA+us26lRPyWOg9eMO2Hu5Uxtm8HyCNcRfgt5yKFezIp5cIrxj4len5OZC/oPbeLWj
         G6LHGYv0VYHh2HaFBo7Dv/o6emkpF6k+8EkKwl7jqrGmW4hzPFi1b1UDn75rgHKAKOUm
         KugdR4tkzJIs5YoJMBu4OLWcEUfpk8upxMshTFZ+a9NhQnNq0bElXbJjOPuaixiNCiVO
         BeH1w/p+5JNSI1oYmwV6v2spEwAxFN0cJ7amPyl330TPltW7fzl+ECHVmVjR9EINtTeT
         S20bYyWjbW++b/GSGKs3tnzxfsN+62AjSumAr++/3vr376skG+Mq10Im1+vHM6ikZctI
         AHRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0m11DqAQsWViOluQPYNzPkQX9NkHKluVITQUvXZ17kE=;
        fh=wQr4Jckgcb3ehVzna0rLOl6y/bFWbBwnsuJsCJGDCNU=;
        b=KPa+xsFJxZ340uxT20KlKen0vGLZHTkKfxm2vUX7SXv4vqX5fHNFdfypQxGMrkrQCo
         qgaERIDeu4/uRODhOdC3iUIpOwfqLbhAqpqTKVIRX1ziziE+fvFDCG5hj0NJ8OjLEoJJ
         8Ye797ii36CNa7tdClTJw93AfEVvurqeqx50iqf4B8veyRWJioulVmIKsSfRofBWkbjt
         L883udp8OxCDszFw2y1GwGuSJOaqFnA4h0/DdysxM5zYStp3C+c2W6XbXYBh8ZdL/Ia2
         pC+n1sSl6h3oFtPWAQ1KwKitEo+OxqUqnA5ilvlf37CprTOnbI4RqXkpmjWR8nOiHN4/
         q42Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793586340; x=1794191140; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0m11DqAQsWViOluQPYNzPkQX9NkHKluVITQUvXZ17kE=;
        b=ugDCsvDYCkDc501EStBD45BR0hKilJ3mHh5PLVzf5klKd9eNQ8fs3jIePlTP0KNAPt
         r5EOByLZmYdmqZO0W7i0VzKXiB+0qwLpqz19LfLPF5WJEU+UOWoJfrFEFqWtVTcBcdiO
         Tlwwd/Uf+ihgzH2fBeoSDDPZ3lZjk4bXPpSKc0I5mR1pFeRxHgeLLD5R8ZS1mxu0kOV2
         BwCpFUQHqwcxEKUL9mvZXZJoeUuLNygu5SgxQecFGOYDKPXe+0mVis5idDsh0w8q5nzV
         Qd9k+zsIG5Jm9agqPdNs43nJzKTLXs25BjQN1v2kKT+jyshNQ3Aa8/U+ONAzCvLzWUj/
         GKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793586340; x=1794191140;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0m11DqAQsWViOluQPYNzPkQX9NkHKluVITQUvXZ17kE=;
        b=xRKTfyE43hVuhfS0eSEED2ZcnG8DhtqlsYS4bIchk6RoqViGnevBURqMwlPBPH9A//
         eR1pp9XK/pzIYE9xExBlc0u81lyRQH3gx1ZqShcv53Jo2wOrXjlkoi26H6QO6iz7ARky
         6LVBOmR7pFRnSXUfC/Cd03BP0wfT0OZf+x/qxdjqO7YvMCcqhekxN6TwBpzQ1BGjx9F9
         n5DKZb7fnjBpKtnjXtStSy+fzfWr+9mgSUtV7V2XggPHdZDtJE/rDHWUX9WCcoRGLzHT
         Kf1omDxXy6RsnNSHvoWm9BGTl62Bcfci2ksrSsXdCVpIi9O0KxSm451jw+KIwh2T4u5s
         B3aQ==
X-Forwarded-Encrypted: i=1; AKwUvByLMfJ3JKWCfYHMoDpNhWy+cE4BoFTdIIl8znWAn8kUqkHmnbuzEVbBBOm9BHpnQWyAXj0lkPI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9JqKQ2ClBnnLne+A5Tv77K/6U1pwritHYg8+J6KVizp21TsrBB
	CshUEcoYGkX/KP0Wq90BLlCUxZfTidIBusPraEjmVOg0DybhodYd+vkWT1UqlJyG2bcChzhU8th
	8xfXVZfdlJOWCx/Ba2K2mUS3hO9kAfsE=
X-Gm-Gg: AYBFou3Dewsbo2GxNFItiUhiB5V9Eg+0t1YLtSmN4OnxqOTF+XvBaKBLqvYEKM9Trt/
	bSr0ap0F7jbYBeDugAd6TBLRG9RMUteA2EOhWKZ97PylfpG9SlPBzVtdPeoCJHriAoTXXMM84uS
	EPdl4wFXRygx08a73rNNQed+Hki8ysRTugOgCsNk4PItkJlCn6ncHtd9Wl/jBn5ne7N2iQ4LFth
	ADra3tsqgbCWZQUKZI8f6mHG/+5JaGbnDSXpW+zqSksw5cFd70HbQIjjN+ITCqVglmQGpSDEXC1
	/36EZzyaiON6EciNEnLTz4eSodc+qDAj2ZvjQiKoLfF4PvJCBZeoeuNl/U3vBKFioo1WU13M25N
	gRorObvmkWOT9N6CQCQen5TCsPsCi6hxnmszF9t+Z5mDrONdOfpuKWyI/r+zVAiO6qoErjkKMOx
	4J8BV3ZpX2qMlWJQbhzcZin+ALbtWwYx5pbzIwiKF43h+uY67AaR0EA3Kh6VJFm2u7p7RPR9mOF
	chxn496hs4=
X-Received: by 2002:a05:6512:a94:b0:5bf:b246:87a2 with SMTP id
 2adb3069b0e04-5bfd957b610mr2907633e87.10.1793586340194; Sun, 01 Nov 2026
 18:25:40 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031133455.3070233-2-rsalvaterra@gmail.com>
 <CAL+tcoB6vg+-w1JZdND_cTN_zPeh76_+-W_NU34jkunJUFwrrA@mail.gmail.com> <CALjTZvbPacWO+NY62fbFdQEAJemD57zmhdYy+v+BXpxFgntcNw@mail.gmail.com>
In-Reply-To: <CALjTZvbPacWO+NY62fbFdQEAJemD57zmhdYy+v+BXpxFgntcNw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 2 Nov 2026 10:25:02 +0800
X-Gm-Features: AclHuK-ou4PfE1lO6DM3P8nj553WJIIK4Nvl4HbobZUxI6ExZLuUtqWgm0YgoO0
Message-ID: <CAL+tcoAnw=5vP_s5qTOo8O-8uBntph4MOAxYE3fnw3+K0jhyDQ@mail.gmail.com>
Subject: Re: [PATCH] tg3: make depend on ZONE_DMA
To: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: pavan.chebbi@broadcom.com, michael.chan@broadcom.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:41=E2=80=AFAM Rui Salvaterra <rsalvaterra@gmail.co=
m> wrote:
>
> Hi, Jason,
>
>
> On Sun, 1 Nov 2026 at 05:48, Jason Xing <kerneljasonxing@gmail.com> wrote=
:
> >
> [snipped]
> >
> > The blamed patch seems correct, so I think you need to root cause it
> > instead of adding a global dependency here.
>
> I'm sorry, perhaps I misunderstood, but *I* need to root cause it? I
> never claimed to fully understand the implications of the patch I

This is not how things are going here. As long as someone proposes a
patch, they should at least know what they are doing.

> sent, nor the intricacies of the tg3 driver. What I *do* understand is
> that a supposed "fix" from Broadcom has left the Ethernet controller
> on my late 2012 Mac Mini inoperable since the 24th November 2024, when
> absolutely nothing changed in my kconfig. That is, by definition, a
> regression. I'm entirely available for testing any patches people send
> my way, if whoever fully understands the driver and the hardware is
> unable to reproduce the issue. However, asking the user to fix a
> problem created by a patch from the hardware manufacturer is=E2=80=A6 an
> interesting approach, at best.

I see what you meant; I thought you were trying to make your first
contribution to the kernel :)

With that said, maintainers would pick up this and probably send a fix
with your credit (reported-by tag). Thanks for your report :)

Thanks,
Jason
