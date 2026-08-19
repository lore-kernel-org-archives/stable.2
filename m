Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF82381AE4
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787139789; cv=pass; b=N1aF6+0BGRcXn+K6D0RgrpqZntfPcmrYnPADsV3PGkNlClYbk58FbAf3KETSoVPzQ2tWwwwa25QWHCzwDQFdx4vkbAqisA+V1KQiOLYoIIoDRnKSwDPe0BWgQV1viJQokqVurn9AOqotnMKLuZxjzl4eefF0XV9PIyjIhRaJtDM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787139789; c=relaxed/simple;
	bh=08kL7JbQEa8fJNQW+ej623AwIur83mUMehYAetGta8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lqUrX2bgyBrnzCEkJJAqrxGWG9E1aZm+wmjKEy6CxZFXRSrr0x4Rqe9ndO6zwTOOhF3fp6fdVTpO4ui2piTpIifiK6IvM18RIE5ImYIY0AGSTlz/ijbaPNtwXASpixb8G1VSy1Z7srIQVAPNk5Y3dNRvhG/gYqOrnz0LnZu/xzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kB1u61St; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kB1u61St"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c7ed5410bso6414331fa.0
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 04:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787139785; cv=none;
        d=google.com; s=arc-20260327;
        b=ODXHYP45atgWWHsjoEMCGkCWT+srblMY07Nd1sW2Jv6Dg1q9JC0h4HJXjd4SaC2jQh
         QmlCeQvmzjraV1RuqV7N4miPU6bxhJty7rSXF7ttFJfNiSIk16cmAXbUqlHFwSJVdxba
         Qq4r+uYdt/9MaX4HB3ZyVDC3FDUAHUmpZfhgut1CCwrBC/G3UDTZtnsk8kJ8XO0FTLYF
         /qrsuZyYoMTrVJ62wcdGUNHsLfm751Qpod9e1YApPetgXj8D0nmEord27bcpqssQ0V+m
         Z9eB1IcsAf4+ew1HScJRYl766a3fBadN2wXSXLaDNkj8Ak3wwgM2K3Em5m2U+YJLfhmm
         ftZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rruUpDInQvQQuqMyUIBpR8nVOpeVCVZSdKEK5ZtInD4=;
        fh=Jxr+MOQcaQYb6y4pbcOMDiWnFaQfWGwceVOXRq6R/Rg=;
        b=j9k3f/otpfUjK16NWc/pBrApI/B1hrK+1Gt5b+HStXPesqC6xDAvrPE2GH4ZqMX+qV
         IYieJ+6OExskysZzZUBtqlQJ2ZmoDLsgDat+rf65ZtVUCY/1/Kgde48yPBhOaNV7/4fn
         tBhbnftJXlLAea8JYSuvpIyRLlVVgdnbNQkyXwxM8xXTdAHVVxXQzKRg3xLxq1ve16Cp
         aBpWM3Hlr+s5NxI/YdDMer7degTQFMYH1Yez34CDrQ43kHVnTfL5CfbO1+M0M7/ILC3c
         9aEEpEQBKXAu/21opw+y8Z2hkruWItW8tY3aJ6Y+Zyt5ACjq4C9AVfot2piWYaTbRFy5
         aP5w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787139785; x=1787744585; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rruUpDInQvQQuqMyUIBpR8nVOpeVCVZSdKEK5ZtInD4=;
        b=kB1u61StMBPj4ZUwlTwHo+rDCRoAE5H5sTiEx11AuTUvin8iPliLRtBKxaC05+2QNC
         8UCoND2pA8Rs7/VjUmE+YAy4z3Oi0aG/5+k04EQ6DnLfCcCRXfidCVAjYP8KeBUvWKNr
         dwiTBGKay8aNf/Vx9ewIF3VmaBVFTUvNsmyNI/liOafSUBX3lYUv6FJ63UtIUxmU0yaI
         wMCB8dzreVt/D1PCrSLbKFDhB2Tz8h5jQkvO/xIAnI8A88l2mkPtcZQ5fypWyZ7qpsAY
         6D8+0wrUe83CmR/almLB207xYt1t4X4dyEWNyuEJBYpWo+QhAfYKOakQM7qajdrRaADn
         Lehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787139785; x=1787744585;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rruUpDInQvQQuqMyUIBpR8nVOpeVCVZSdKEK5ZtInD4=;
        b=e+LHKLV1bb3AEKAwfrcKLPzEdVB7r1hG0QhnlA7c+y5jkQfPxOEckofBYvNGvKH54K
         NnVdxyYfw9UBrZccvanbGGpiJdxEu7A9lHCdSfWMZFiBc3A04jtxIrtOfRAkFEhCElta
         q9aaKfdgNo0vuwGLwJhcVWUW7lGzHbSezaij6kS9Ciu6C8bqnVD7lEqkpXQChYT+thsa
         DuGkuxDLrfrx5GBGwufg4rqIcJi/u9xz3eptQq15SVx3ZofflNyP7WyvwlrIWKNlnhaW
         Gkl6g1hsWzEppWNZu/0niFzheAYMbHwIKegJORRWlHRIrJ4rUK0GhmtrcTOh+F83sloF
         m00g==
X-Forwarded-Encrypted: i=1; AHgh+RphyDxATC1M6YizX7hpn82N/qMIgKoi14mCiu6xdoRn7WwSbCvUw8c94stvAb1RmebcKlsZv2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyELHm/Mmjw9y6wjfEi7+8OwHmI3FDKO1MwHhwRhRE0a2mFRe7z
	o9dU0ARshk59N/PuhfOuMcB5gJMC+dd8fO7SvWKwDtLZJXMClBMZzdOg2zVe0FHqqfqc+DRJN0f
	XvW+JzxuPbCYUDabEQiXkbVbuK6a+oZg=
X-Gm-Gg: AR+sD12sJW/EyKpMC0AGalA3Gzws73wzvZFsA1SK0aUQbP6HdpDp2kAO+UkzSBGbThb
	tytNFVciGZCb4gxtJEzyJD2SvtBbTT8O6JUssVumhzRZvLI2rQXAOvdPaSPAl9bOPJZdmCAiiDN
	BALAHOgy1TkoWzPK6SHavusVoD+UahwJGjcCEZH3BWFylDgIi8d7/+ScLo88XkyVDG+5P2pOspY
	z+kUzmIcpleCLDFpTIqPLAXvj2BjP8GTnobSP+o5ew1LxWra+XSEGGg1zNx5j9OzTJGmgFBVTx7
	Qr2xlrMRQqinJ8VHNg5mGBezea9GFR5KmF+cXO/XwNbdwfVKxCP/ybSQEQnPIpxHa7cPGVd91zC
	bqYvGYlsakjQUe1mO9Ogi0UZyow==
X-Received: by 2002:a2e:bea5:0:b0:3a1:85a0:c5c1 with SMTP id
 38308e7fff4ca-3a1899c16f4mr8655901fa.11.1787139784486; Wed, 19 Aug 2026
 04:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADOrJmbTyrGGkq+9OJDXCgTa2HvNo8BWxoE6yjafcrOq7WNamw@mail.gmail.com>
 <20260817215428.84740-1-gvalkov@gmail.com> <20260819-generous-nickel-dalmatian-b6bb08@quoll>
In-Reply-To: <20260819-generous-nickel-dalmatian-b6bb08@quoll>
From: George Valkov <gvalkov@gmail.com>
Date: Wed, 19 Aug 2026 14:42:52 +0300
X-Gm-Features: AcwNN1X_uzL9E44yhbWS_M41oClBHdMfV11eL6pc59WJx0lXGGLZ-ZZh_4cYzLM
Message-ID: <CADOrJmYfBe3ADun_kFjFSH6YOSTX7Vu3UsFsL57yuRdaQ=eJCA@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: net: wireless: add flag marvell,ignore-regulatory-hint
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: briannorris@chromium.org, johannes@sipsolutions.net, andrew@lunn.ch, 
	krzk+dt@kernel.org, francesco@dolcini.it, johannes.berg@intel.com, 
	kees@kernel.org, miriam.rachel.korenblit@intel.com, wenst@chromium.org, 
	rafael.beims@toradex.com, avraham.stern@intel.com, error27@gmail.com, 
	s.kerkmann@pengutronix.de, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, conor+dt@kernel.org, 
	Frank.Li@nxp.com, chunfan.chen@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Aug 2026 at 12:42, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, Aug 18, 2026 at 12:54:26AM +0300, Georgi Valkov wrote:
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/marvell,sd8=
787.yaml b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.ya=
ml
> > index 930b700b73d0..5f235cb9f3e5 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yam=
l
> > +++ b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yam=
l
> > @@ -59,6 +59,12 @@ properties:
> >      description: Calibration data for sub-band 3 in the 5GHz band.
> >      maxItems: 502
> >
> > +  marvell,ignore-regulatory-hint:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Ignore an incorrect regulatory hint from ROM,
> > +      so userspace can set the correct regulatory domain.
> > +
>
> Same comments, so you just ignored entire feedback?

Do you mean this feedback? I already replied to it:
> > Anyway, property looks like SW choice. You must describe hardware
> > instead.
>
> I am sorry, I do not understand what you want me to do?
> Can you please send a diff or a clear description suitable for people
> who have way less experience than you?


> Again: you need to describe the hardware, in commit msg, in property
> name and in description. You cannot tell SW what to do, that's not the
> purpose of bindings.

I still don't understand what I should do?
Can you please show me an example of the changes you want?
Else I'm likely to make a wrong guess and implement it. That obviously
won't help.

The commit message already describes the issue with WRT3200ACM and WRT32x.

About the description, do you want me to do something like this?
    description:
      Ignore an incorrect regulatory hint from ROM,
      so userspace can set the correct regulatory domain.
+    WRT3200ACM and WRT32x are known to need this.

About the property name or flag, do you want me to add a separate flag
for each affected hardware device?
- wrt3200acm,ignore-regulatory-hint
- wrt3200x,ignore-regulatory-hint
- the list may grow if someone decides to add other devices
- and the driver will need to support all of them
- that doesn't make sense, because it isn't scalable

> How did you fix the threading problem I mentioned in v3?

How can I fix a threading problem?
I don't really know what the correct thing to do is, once I forgot to add
a version tag in v4. So I just added v5 in my next submission.
I'm new to sending mails using git. So far I've learned that I can do this:
git send-email --thread --in-reply-to=3D<Message-ID> =E2=80=A6
and I use the last Message-ID.

Krzysztof,
I am thankful when I receive criticism from you or anyone else, because
this helps improve my PR and it helps me learn. A clear communication
along with examples and links to documentation can make this process
easier and more productive. Thank you!

Georgi Valkov
