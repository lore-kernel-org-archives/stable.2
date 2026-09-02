Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52EC37C11C
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 17:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369039; cv=pass; b=UrqqPBDqIK0UJOo1H9j54a5MKgkAkTSloA4VNFimAMscXoUFilTfx2b8qBfJGIlVryDc8kGl4vKnsiayh9RmFtNhmBIPbXvaw/j+gcrdZKE19pC1Y+kB1cLfnP1rXOKtch2BfBthrYWOp5ZQua50GW3kv5u9Tib/FK8HCtoXsp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369039; c=relaxed/simple;
	bh=mTnQX3Mp7xcXwmjhHicO/NT4zipxlJZDBHdnZk6kKHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UmwBW8ObyorP3FLJjAbny5RFNBLx8nJ26z1MAIXeEX3BLZdOpm0LhLXC/VVtoN3hmfnWfy+Ndhvtdd0J9QeTkxS+y7BmPEuttGSPoz5OL8fIet/LcLPSP/ZOFKWFh9lDgv7Um1fWPw1kiDNRimqhcxU9JJhvqBtTEiG2QRFYFFo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FG8KjALi; arc=pass smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FG8KjALi"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-482fc2b44a7so1384028f8f.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 10:10:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788369036; cv=none;
        d=google.com; s=arc-20260327;
        b=eAXWNjZyJIbZopzA5ZoB2fYRI3U3/sV+TEK5ZflK5xaADknUTrT0/GatV9z/NN9cBn
         q+FdElb3B4SeG1PSN26nO6inz6Ztbwn6a6z9+pdCSP0A32QxhUb0hq6pUj+yD1TJZcDN
         A2/2pUjLxqlJNSqehRpIRIFnFE2baVDqUnuPVPMREuU++B7zrD1LFBOXlWKTDTclLSy3
         zL03qhJlDURQy/QOrinar8PX9Ni+ZEup38K6VclMvBMR4FPcTRgcyQ5dIfRj2qPROhiA
         JOvZFrFk/Q0aQzEIxXqrOdUvyBnqyvj3lQHYf64EXsr/GoRRClOv4aNastvvJ2hsN6cc
         hZxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ols0WNB2AMfbKxMdXMytoV45ljZKuMGIe/f4CAtUcyk=;
        fh=m1ya12uCN7Nd4Y3SL3fAph9kRydxeelsHGziwWz6Y6c=;
        b=ESEVAZfsEbaOUeGLSy3sfSQpDqmhE1tK2BU8rRSlq3ZuGHgGUFfVlsXBRpa1zQ6AG/
         hnzNFcSBGnpgw3X+H3qQL8+rL0llWx9ZaSK4eyysPSMEFTiBlt8HjEbnf2t0Wq7dTRMo
         jsIqPNFijBeByDRRa6FMe15uDwpD9JXmLEBEbOyMPTtkMB+5u20O7CHyERRZMSy2VfOV
         cN6oCgQ2KBlUQLpi12mTP0IW94k4pAz5r7fsgD1JVua34x5QuKKjcI/13eCsuCAF9nAW
         WESKtwu9IWZr1CVdr2imCZIRrET+CAyoW7xOWcdxPcaz4o7Ujc98zrnMgq59VPsVw8Rt
         4OTg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788369036; x=1788973836; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ols0WNB2AMfbKxMdXMytoV45ljZKuMGIe/f4CAtUcyk=;
        b=FG8KjALitVD7ogJ+gNph6ib75C3ShEpptnXdQ97uExvnSkawuF2lax0fpp9Hq96oVX
         5NaLiYbPBqwwR21QTDosm9S1tzfhQlQevnIhklwegKDlo4kPcThH0Smtf9LF61UBRZfv
         geTdAq6BLL+2KZ33Ld+Vf8VnCYgJ1J92g5y0DaLUvRTA4INQSv05oC8JgcFXyXQn6TPY
         qruN/qiUHz044cZrtF8tWVDFLGn2rcrZrvqRsEtWt/xdDyfpvA/0wPnJc3UQkPm96wc0
         cHWslo/5AkIUznz/O1ULgWvoGdPnVirQ0lxU5xlOPaz7H9zZzwjxdiX/EDYVYU4k9NZc
         OGxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788369036; x=1788973836;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ols0WNB2AMfbKxMdXMytoV45ljZKuMGIe/f4CAtUcyk=;
        b=HLRZKHZZPnpJYkvibzKvuJKiCJUBGwzYeRHrirybY3/x821Sehit1G60IzEhqntQDA
         jXaAxjqaC4D9u6DBFDH7bBTa/F6M+i0My10qQeVRRdARWtmmPS7Oz2ZSHMf/znLvTNx+
         J9qsw4/I5DjO6crL8JVbClHeqY7LdDZI2HmCz+utcKml3dZoo+4EHAj2Xq8y2Ntnw7Ab
         /+cJxhIFS8trSnh2/lGCVHh0tRAW98lxSxOvV8MgYnwwNC3dBqPo9sJIYCW3KeNns83S
         tB8VCZYIcPJ2OePGlb+1aYsji3SCjFQJXSCWZD0rj+h38ZJOciySKC9lzBXDuoB6vH5q
         5k4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxSpiYIkgpLjWOAda+HTqkWslduvXsrZT0ifnE47SO9a7Zc+N0+Oh+mL7t7yX7aw13Etq0PxxU=@vger.kernel.org
X-Gm-Message-State: AFuF++lnCsKNW6Yz9FKgzoGgMTdf1U1tkae5NZebivELRbG7ZZjUSPMj
	HwGqPQqasd8CrWLePFeko7onQ1JnWdtJ7k6qhkoqOzkS4KGg4LY3pvl0ME56bDfnmIwZ92DJrbH
	crgjdBP60s9BqRjs8uGuBU6U4CnsFEtmY2G6rrtPD
X-Gm-Gg: AYBFou1XO7fqwgVdGaSJ6VdQYL5kNz/FoPFISGUm8v7lMbG1MUX5DtQq9VyYwiuYDHj
	lGRD+LXovEfc04Y3PoDv+gUALdiatOrVuBgebkDJYtx2ZpcqNZ2BVdFQWTUr8SQ+ZrV9zgoTL/1
	masdpA4SDMey5i7tuu018UlfIpXxvkAmhsCajnkHSc30n0/NTnqciCzcUEZOhyzj0XvRRMbFaiV
	07S2yCWgcS9Q68q8zjOGkHAH0PNmxP5R2GJDXD+4OXMKPBkBQfMBAZOnhf6YxnKBSFH6vzwSPNN
	3I9oI5FHlj5on50UdDqGkyiwaG+k94dVmpaaMkDsZrWOGyPwpyS6xp5+J8aat/cK3F5WOB6YI7y
	+VEp/XjgJcmoZw07stMrOMHi9lL9az2zAjKOXfJopDVBUjifGQMj6PFI=
X-Received: by 2002:a05:6000:4817:b0:484:40b0:ef30 with SMTP id
 ffacd0b85a97d-48488deded3mr13204952f8f.6.1788369035314; Wed, 02 Sep 2026
 10:10:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260718111340.159896-1-linux@yoavmoshe.com> <20260827194508.446733-1-linux@yoavmoshe.com>
 <CAKwvOdkSZBbq=e916=efx8G-CTzZ5b31AhyUytO6eJjjkEdMow@mail.gmail.com>
 <CABCJKuc0cWWdkA7zrCcuze4AE-qTSETuUi-eRewPnn_ivHEADQ@mail.gmail.com>
 <CAKwvOdnA7Ej_uppSL7U2xwxyUQoDMvO+RArj4HCUSOziH0rCqA@mail.gmail.com>
 <CABCJKuezb0HtOcMBsObczS=HBaRvMszagkOZGHyOVbXBqtJi5g@mail.gmail.com>
 <2bd0c842-d0cb-4ad7-b3a3-fed2000dea83@yoavmoshe.com> <CABCJKudb5RegHcNPkXG5p1TcCFAe5_8+hqBP-2GyHVK19oB94g@mail.gmail.com>
 <CAKwvOd=OLLO5AXiR54o0nU16e_pTDt_yiEPQ0GgnX8DRGJXYmw@mail.gmail.com> <aphSYUS7xGJjj2gT@SMW015318>
In-Reply-To: <aphSYUS7xGJjj2gT@SMW015318>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 2 Sep 2026 10:10:23 -0700
X-Gm-Features: AcwNN1XAESqNH6wBokuk-x9G05tfeqXIGUNdG4bw9ZYytsqReJ2H5J3a05HeJ1A
Message-ID: <CAKwvOdmG92SPOuMJka6KqODqObB0F8YJ6NhpEj7eisv-ZK+GXQ@mail.gmail.com>
Subject: Re: [PATCH v4] ARM: imx: Fix suspend/resume crash with Clang CFI
To: Frank Li <Frank.li@oss.nxp.com>, Nathan Chancellor <nathan@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, "Yo'av Moshe" <linux@yoavmoshe.com>, 
	Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Russell King <linux@armlinux.org.uk>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 9:44=E2=80=AFAM Frank Li <Frank.li@oss.nxp.com> wrot=
e:
>
> Nick Desaulniers:
>
>         Is this patch good to pickup?

Yes.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

It does depend on
https://lore.kernel.org/lkml/20260604-tracing-fix-cfi-h-build-error-v1-1-b2=
7015390901@kernel.org/
though, so you might need to coordinate your PRs to Linus with Nathan.
Nathan, is https://lore.kernel.org/lkml/20260604-tracing-fix-cfi-h-build-er=
ror-v1-1-b27015390901@kernel.org/
going via kbuild tree or what?

--=20
Thanks,
~Nick Desaulniers
