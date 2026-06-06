Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B025927E049
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 04:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780721464; cv=none; b=WwsI9ln8WMDr8VpdTdLD3YfTnCYkI2uXvblSQw/o+9++9+VLPnvkEHeFxkU5W2lWukPWKBRwUcs7Q7qocDiuY7zZvvxXFvg2ZlCcwbugp9EaQXfpdTtwE9iFO1FeghW7LZvlpMKMNRIr993EumcngHmgJvcTggYJYduVa/zNfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780721464; c=relaxed/simple;
	bh=/u4C1kWYVbZiPw/N/UA7MQei+1M1gBnUoiL6TjXpJMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nALkkWVTzjGzdscEROWZ9PkgIy8HtmO6lqjvgP1KPFGtmHMpSkcWxgCUjbMLZFoJX8bZTniDoTqKX9V8eila//kNUtgx0t8igV1ihaCeFKOUfgLTfsBkuaiyo5k2QXwNJ8zmiWtVuqeh+qysSJTzd6li7HdTLC62SeEUJEWIulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmkq+X4D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmkq+X4D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7340C1F0089C
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 04:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780721462;
	bh=sKz22jwoXiX77X9+l1832laRA/oVlQe98Ct+8CuxsJ4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cmkq+X4D7gn5Wy/QtPOGGldw5QYXyKrpGRBzG/OaLIEXmGAiVmTD//4RCGWFZtImp
	 Tc8PhbvtGDd2EFFczm3JJjxuZKUoec3t5WS0CzV/WH3hEkH22rA36BE7Ed7m+HfdYv
	 /ivPseYVrpb2rEjTqE07SXwZEVNmYOJZP+reT7oOIVzuI2gkP699oMSngUfsSzoW4b
	 8ha3jY+Gx02T+kWeR2Z1o3fSIhb+/bPKyU2lXfkP3wcNO0n+Bxu66zBtZ4bY9Uh6eV
	 dW0Z/rFhgri0YR5rXMnSk+EDCNUFRKykPtecZa+2IlivwtpjI8VAv68W7N9EaUfVlO
	 4XEKA97P0TFKg==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68c08bfe5afso4969883a12.2
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 21:51:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8KoHu0umncG1suwQQY1Izy2jtFiDCkMci5KPjUmb7cryntMLh108+GuStIf6W4GfFlwuZMa6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YznauIrpmTksRRh9XRX+q4Fycaej0ZzMtB1hI42CvAhSGkH/rYM
	A+v1+uLrcynORrEI2mlz8k0Y7wtavKBFRdikZ8izRYcWmQUMvcYvnlx7Hql10jFBvLv3TKZ/SV8
	huGcNYK+UriGUOR7tF/W3rzm7qohBpow=
X-Received: by 2002:a05:6402:27ce:b0:687:5157:1d4f with SMTP id
 4fb4d7f45d1cf-68fa524d249mr3187355a12.26.1780721461112; Fri, 05 Jun 2026
 21:51:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604015848.18643-1-wanghongliang@loongson.cn>
 <20260604015848.18643-2-wanghongliang@loongson.cn> <20260604183813.GA982803-robh@kernel.org>
In-Reply-To: <20260604183813.GA982803-robh@kernel.org>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 6 Jun 2026 12:50:49 +0800
X-Gmail-Original-Message-ID: <CAAhV-H648_nNzR67ZCJ9myUG2PQy5q1EHWo1yRjKTUB+4Q+5+Q@mail.gmail.com>
X-Gm-Features: AVVi8Cd1pBWQh2AK-e5GGLwTOpjGHeDAqe2xsmKUiF49BygdYoawTYdPqMMbYQk
Message-ID: <CAAhV-H648_nNzR67ZCJ9myUG2PQy5q1EHWo1yRjKTUB+4Q+5+Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: ls2x-i2c: Add clocks and
 clock-frequency properties
To: Rob Herring <robh@kernel.org>
Cc: Hongliang Wang <wanghongliang@loongson.cn>, Binbin Zhou <zhoubinbin@loongson.cn>, 
	Andi Shyti <andi.shyti@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	loongarch@lists.linux.dev, stable@vger.kernel.org, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Rob,

On Fri, Jun 5, 2026 at 2:38=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Jun 04, 2026 at 09:58:47AM +0800, Hongliang Wang wrote:
> > Add clocks and clock-frequency properties to examples.
> >
> > Cc: stable@vger.kernel.org
>
> Not stable material unless there's a warning in the example (and there
> is not).
It is me who told Hongliang to CC stable because the 2nd patch is
needed. If the 1st one is unnecessary, then please send a new version.
And for the whole series:

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Hongliang Wang <wanghongliang@loongson.cn>
> > ---
> >  Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.ya=
ml b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> > index ee09c6d9c5f0..0beb7f2515c8 100644
> > --- a/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> > +++ b/Documentation/devicetree/bindings/i2c/loongson,ls2x-i2c.yaml
> > @@ -37,11 +37,14 @@ unevaluatedProperties: false
> >
> >  examples:
> >    - |
> > +    #include <dt-bindings/clock/loongson,ls2k-clk.h>
> >      #include <dt-bindings/interrupt-controller/irq.h>
> >
> >      i2c0: i2c@1fe21000 {
> >          compatible =3D "loongson,ls2k-i2c";
> >          reg =3D <0x1fe21000 0x8>;
> > +        clock-frequency =3D <100000>;
> > +        clocks =3D <&clk LOONGSON2_APB_CLK>;
> >          interrupt-parent =3D <&extioiic>;
> >          interrupts =3D <22 IRQ_TYPE_LEVEL_LOW>;
> >          #address-cells =3D <1>;
> > --
> > 2.47.2
> >
>
