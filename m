Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F00712CD8B
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 02:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781490512; cv=none; b=IpAmA7S+x7NvSAby5UfnuQRt90M5MgIOGJ2EAWIuxLJi+LonaEiGhum3tU6KIZwLf3RgcnivlxFfFTI4L0/DaR8miJCNPsw0vK5q84i436NscO6ZZ13JM02Ew5P3pbSMBHqBNCinpk2S7B1eSht6kP19z0pa38cq0EB6jF+vTlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781490512; c=relaxed/simple;
	bh=2s3H7XMutfBTGQhHYiDPlkcpWbJdlnwO8KNFVSLUFcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgP0pLsz3GuA86nz2gDOsWT4OXC77/wLWtUOZ2PjprGpmb76Oo617Jib0s6iC+HQbRKGGpGXd90vrtZKf2nTErnWNsqiyE7pBWST88b17i8mogOzcBt0YAfg1HOLPju/YaOLzI/JTtQvBroweA9eXW+IJe/UWRdGeaT870mXOj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSCjqjZC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSCjqjZC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22C61F00A3E
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 02:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781490510;
	bh=asoYaaxL0SkrmU7UienB4b34Q7eA2ms+abq39OGgQGk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nSCjqjZC7oeTvkq17frGoKxZmr6Ynq1prUKQJBELA8o1xriQalloxfYH2q6hUHWiV
	 IXe1/nwtkciwghHADLN1yQfQ/ujIM1eTocqBzRbgUK81GY8w6DH94cUe/36nalSUpu
	 VhLJF/bgnd2W9KkmV0tFiDNE1MAFqnwj1J1U40O0fGzXxqkQ0ORbwiQaMqUHVIq1Oa
	 21sQBF+UCqWPaFJoRt73lT8bsh8E4PteBNl/xDMD96gN25ikHdS98OtHuvn5GdPUL5
	 PuPEhQs/leE+fgw6OyGFw4wqjlCemqlegJapyIzCStfOemzUbb8N42STqJMr5lxrXw
	 GoLf+mcnUZ1qQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-bec2ddee9bbso593459766b.3
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 19:28:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/e5vR+hp0oMhKbU9j1vrpmUR2RY6Ifx4xR4wi2KYwPC1KvswZdHcWSEmiz5AR5F8wBZSbBzks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAPpzEXBv1FLzOSGKFHpU8I2nei1hqoUMSOreJ6Sk7vZ49Dlb/
	1GeiRMJ0ZpoOP/o/pnhsJdSikfXuOOGOf7oxU1nOAvwR0uySOAGhvtI65SQJSmsGyO96qmXnCa1
	eU3lvevahJeJzMZn/lfb9EmOUMz/Q7IE=
X-Received: by 2002:a17:906:7306:b0:bf8:a88c:9ea7 with SMTP id
 a640c23a62f3a-bfe2aff74admr617228466b.40.1781490509548; Sun, 14 Jun 2026
 19:28:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608024533.32419-1-wanghongliang@loongson.cn>
 <20260608024533.32419-3-wanghongliang@loongson.cn> <ai8o9vxUX6rbZNV4@zenone.zhora.eu>
 <338facef-6893-c8d9-0efc-b4fc3aea756b@loongson.cn>
In-Reply-To: <338facef-6893-c8d9-0efc-b4fc3aea756b@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 15 Jun 2026 10:28:52 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5R9fPvUs7dvNrZAbXrGiWvE4YPkaca2nxnhgS3A+TVYw@mail.gmail.com>
X-Gm-Features: AVVi8Ce0MMcSlyyGqCOsSUds5-FItelvI2wk6xcrczWAv8W2if2QPOcRo0nZnkY
Message-ID: <CAAhV-H5R9fPvUs7dvNrZAbXrGiWvE4YPkaca2nxnhgS3A+TVYw@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] i2c: ls2x: Add clocks property parsing and adjust
 bus speed
To: Hongliang Wang <wanghongliang@loongson.cn>
Cc: Andi Shyti <andi.shyti@kernel.org>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, 
	devicetree@vger.kernel.org, loongarch@lists.linux.dev, 
	Huacai Chen <chenhuacai@loongson.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2026 at 9:29=E2=80=AFAM Hongliang Wang
<wanghongliang@loongson.cn> wrote:
>
> Hi, Andi
>
> On 2026/6/15 =E4=B8=8A=E5=8D=886:20, Andi Shyti wrote:
> > Hi Hongliang,
> >
> > On Mon, Jun 08, 2026 at 10:45:33AM +0800, Hongliang Wang wrote:
> >> The i2c-ls2x driver supports dts and acpi parameter passing.
> >>
> >> In dts, uses clock framework, by parsing clocks property to
> >> get i2c bus reference clock, and define the div of reference
> >> clock by device data.
> >>
> >> In acpi, by passing clocks property to describe i2c bus reference
> >> clock and clock-div property to describe the div of reference clock.
> >>
> >> Based on i2c bus reference clock(clock_a), i2c bus speed(clock_s)
> >> and div, calculate the prcescale of i2c divider register. The
> >> calculation formula is
> >>
> >> prcescale =3D (clock_a*10)/(div*clock_s)-1
> >>
> >> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > I think Huacai has not reviewed this patch, his review was only
> > for patch 1. Am I right?
> >
> > Andi
> Sorry, it was my mistake,  I will send a new version later.
Why? I really gave some suggestions in previous versions and you accepted.
If an explicitly R-b is needed for each one, then
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

Huacai

>
> Best regards,
> Hongliang Wang
>
>
