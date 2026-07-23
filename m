Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A326C363C48
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 19:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784834553; cv=pass; b=UlpbAflQlUgFziaXTXFjaa+398aQRkFzMfao8UBzEs69vCjJwY2wd3lN/M4GHjLFJTHkcadzar8KRKthWNEq/mFe9xVLsvHjH4XxbgYQPp9C6mX8VV1OoPKKdpcXLsf9LNlmh5/llj/6rSRVIYqMutOa6P8y8IEQh+A/4xVP3Ig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784834553; c=relaxed/simple;
	bh=CQzDk6eLJ3OVzLdnUWi9gbK+31evwXTddGNItHuRUwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cWCKYIrAh0/8KIZs5ZNbXQPaczc2FRQcIDwQDOgTZx8uac20fX8oGEIo0Zj2LILvveeZKkKEpNaIX3dEP5GSuLfVlRs44sqeikJb3ca7u1n2H4EAErUBR4rljeWDgoK/yHS9uOhqSnLivc3KXPdsxsSOUEKFEQ8kodGZbPh1L7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AjgLyv5D; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AjgLyv5D"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51c10ed63c0so53471cf.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 12:22:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784834550; cv=none;
        d=google.com; s=arc-20260327;
        b=SrmQuivncjcU4+gGb9RGeCOPbSYlu/L1MxgKKvEz9Umpi13vY6lkp8SFL6GV4GL1RZ
         A86xR/DVfDUf6NXefOpA+tda3g9QsaX6+OLr8qEYgwQjhpu0g5LDsbyJVgcmn1+enxwy
         DC9BfXGbf0vvA9Q/gOWkbYKD7COOWJ21x2YAvNQBl3CERcRrkAbVupdxOxsXK0Cz3x9y
         GYfc8tSrA2J2ylkbIbyuAGq1yqVAuuuPtyT2xAP3LnNBrpI2KjV8wVKVQrVUZYMqDvKr
         5Hpfw5upp/9NV/GYoIyPlexwAnqQ/ASNBNDfqTOxIJdZCe5IJGBx6zLyQx1YHa1nMKZp
         JzdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CQzDk6eLJ3OVzLdnUWi9gbK+31evwXTddGNItHuRUwQ=;
        fh=4ULjXJzFG4I2m4ak/zjc8amyK0RO79AyVRWZQQEHUsM=;
        b=PEd9ommx1178f36UZATv+QCPN6dgxvtK6wDwCRTsQ3vNisj794Nj5dgo0XZVCuq5YA
         QuGqV5QhibRt1rZooJ/uzZz1xkzjteqQFmfOj0qzfq6Nsun0cB5W5GHlUoBsLmWDCcmc
         ZL9YOnMNmIe3cBpxq7xU04dwB2XV3fRSabPC06yCrpbaCgOrx/whfU6ufDz5u/egP5bM
         mz/1CWM3IiCLdEgBMLK9k2rA50zfbl1JozYYGwaLRp+tQKRYRTyfgEj+rUAfR5J62ZX2
         OrKJgzO124gvW2j3/zrxQloHQ0YX4ZGJxUCibNtF5Aevc1WZ+AgkGttyKE96r5JO/Pyv
         ONDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784834550; x=1785439350; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CQzDk6eLJ3OVzLdnUWi9gbK+31evwXTddGNItHuRUwQ=;
        b=AjgLyv5D0wX9QZOG2VrBrkKIKrDta2M5uUv04id3mOnJX6cTNn6N/0BVukWN6Xx8PN
         A5/fO1ML2+L94t5KTnX1crKGdA1XluAu53uklZ2CWMpNuti8z1pjDik3tpxdbbER9IwN
         2e+eGxHuJXkuMgmBG5bCPBcGiDA/1w3Zzpz2U90072q9p00K0YGkjJxh6q9C5bzpwP82
         qrZZfEvoaT1GKZAOG9sLx+aOOHj1tnGqo7mrFleUrOhtdqGbGcvu5Le9UhTYKZIed7yG
         oXUveRS6rGLiJXZpLAaGoTETmqVHabRVQoL5NsRZu6uO+9ZeVEohuZwZ2Ju5GRPLjBws
         a5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784834550; x=1785439350;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CQzDk6eLJ3OVzLdnUWi9gbK+31evwXTddGNItHuRUwQ=;
        b=Seaqy3QSsc38Vwkusx5H4hMBjw9s0FsZK6h2MDaXfN68R/LpdQ81OAeVW/0MsJ17vR
         oOpxttu7TgPbkVbtrEVtOk7ZUC2yJspytGCwCMhTLaGyxy9anEAn6FdSrrWFQH19zGcA
         et8XQ86p2Ba3YKH/PEo33o6HkMD4NW5vHL9D6/HVXFnuYDnbQNIkUtVF0WVc7GyVThbg
         95pXmNvpC9hT3z7dqsW64SJu/+ItVNRb3D8iUpJY/m6lnXjMMwKFhTJ/c9FXuN+xwWhs
         Q8cuXVjpieFP8bIAol30Go2tlkh3Z5l6rzh8lYGNpkGbwsMrQ767Q4rSukXvyF2lfZJN
         YDKg==
X-Forwarded-Encrypted: i=1; AHgh+RomtnfkHCeK3YcVVenMEja8zrEK7ScMtKUmX6K1Sw6fSBB0fs/KIOrAEusOvhITWD7XwLWi0b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrqizqwdPQn6vA7jbCDFyFdvB0Dhhk0dawotHVj7dGjQArxMxh
	WweLcNeHIUTItRBQYWU741T/Fy3IjHRdpRXhHHWbh+z129Qn4zDglHaHmk8MCgQeTA0daZgLCrR
	au8LPeYL1ja09a4kNIbkj5vQIQz4ZgOFzYJPjEruK
X-Gm-Gg: AR+sD12/+4loRryIlD1N7uby7pVLhlD5TnTheYkya18vBx8KIuuieAfGkGq8djQd7IE
	KyFCnVRSV9mkNSCAmYQDAoorVhQTNgzeZoPD1kZuqW6cEy882pFivzvXKzNljSkOk7IxQQinZqo
	d9GpaHNjagJM3TlN4G3XN2SYumfCekkl2Q+nU9aZ6OAXz8vLfjYYC10bA9c+jvO0nLaKkPHM2G7
	gaAyNVItJRaA7U5VJRwWU+ayL1VyqU/ZtjbF+6PrAZz8TPtm9pWhmzl14PugZDNXaMi3g==
X-Received: by 2002:a05:622a:5790:b0:51c:ad5:93be with SMTP id
 d75a77b69052e-5284a9ed117mr1848021cf.8.1784834549852; Thu, 23 Jul 2026
 12:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718111340.159896-1-linux@yoavmoshe.com> <CABCJKudqGL+BFFcz3qsuoJB6S_OAt-vs2yqePC_=oy+JzmPpVw@mail.gmail.com>
 <3046e60d-509f-471f-bd15-3ce78c87500b@yoavmoshe.com> <20260721180950.GA3684684@ax162>
 <180001f5-bddd-4e58-8442-f7ef3c979500@yoavmoshe.com> <CABCJKufhvTxmVm8y7xr4RWWKsoZk0h8UGBnem+F5fknnimaqPA@mail.gmail.com>
 <7f273a08-b29c-4e15-b340-898b251efe57@yoavmoshe.com> <CABCJKud+GsBVv+XMTsi_4QAaTHo7jXD2Hyvi9wqKd7x3i2xyAg@mail.gmail.com>
 <415ffa24-a30b-43b2-aa6a-a1cde3bd4ef0@yoavmoshe.com>
In-Reply-To: <415ffa24-a30b-43b2-aa6a-a1cde3bd4ef0@yoavmoshe.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 23 Jul 2026 12:21:52 -0700
X-Gm-Features: AUfX_mwIn057sYLi7onMumtMkCOBiIb6bjljRVwkdb130ocIXYLLv9gbv_H9dWo
Message-ID: <CABCJKud9B8vB-J8f0HLHw6EgEKVWzy+Q1PrNxpO_6yCGtEyi8A@mail.gmail.com>
Subject: Re: [PATCH v3] ARM: imx: Fix suspend/resume crash with Clang CFI
To: "Yo'av Moshe" <linux@yoavmoshe.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Russell King <linux@armlinux.org.uk>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 6:30=E2=80=AFAM Yo'av Moshe <linux@yoavmoshe.com> w=
rote:
>
> On 2026-07-22 8:03 PM, Sami Tolvanen wrote:
> > As long as the C prototype for the assembly function matches the
> > function pointer type, the hashes should also match. Can you dump the
> > hash prefix from the OCRAM and compare it to the disassembly of the
> > call site?
> Here is what I saw when checking the disassembly in vmlinux:
>
> 1. Call site expected hash in pm-imx6.c: 0xA488EBFC
> 2. SYM_TYPED_FUNC_START hash prefix in suspend-imx6.S: 0xd4d4d4d4

What's the value for the __kcfi_typeid_imx6_suspend symbol in
vmlinux.o? I would expect the hash value to look a bit more random.

> It looks like because suspend-imx6.S is an assembly file, Clang emits
> the default assembly type ID (0xd4d4d4d4) for it, which doesn't match
> the C call site expectation (0xA488EBFC).

Clang doesn't actually emit type hashes for assembly functions.
SYM_TYPED_FUNC_START just adds a reference to the
__kcfi_typeid_<functionname> symbol that contains a hash calculated
for the C prototype.

Sami
