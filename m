Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CC03B19D4
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 06:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787208190; cv=pass; b=hBoXJkXQCCeYJwUB4bzjNqK/qyHPKUz3JrLxAmRAuzUq8gMmMCMfcXoHtg9b9h4pVDpUHPkUd+eiRjJCDZlQ4zRHNUCB3T0N6zVjCYfklHWWSkhbQBFRxHc3wxaIB3j14rhqadEzqRpqupzc/avNlbepQhpZL167dLr85yqXTU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787208190; c=relaxed/simple;
	bh=KfruKuf3bq97mGd1z4GYf0eUtHQK8orEQIL/xa/xHO4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4CHikYMXnlGDlyDobA+un6mUfnkn6Q8lVBJCquvmMI6R7h+OxcWDs/t20oSeQL7tNaBZldfCMZ83n7gDuogLV42gfTyCwGbOEcK2gU3LSirQqCUX4YgIB1kdovwHmAQzB+vPGPSpREAAv6SHKIKCdAR4xZlXrKCBfSqamnutVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Tuml5VvA; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tuml5VvA"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66cad42593dso2099701d50.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 23:43:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787208187; cv=none;
        d=google.com; s=arc-20260327;
        b=MSZeb5HXI0BO99026FgJ5ZGWAfconZa31j2rt99brs5Umal1A79rk79+fVjNqqYay8
         8L6D0FuXN56K38CJn7cVXVCDdAF7TmTzFzB9JVPyDd8XuyoxaVmmYU7FlmjZevj7oUYQ
         W8ynivZWimOZbmDGZvIP28LMSBr9a8BT9CeptyEDJCzi+JOMsTHDGYUjMfaBC2ry14oa
         3ua4VNSYAijpL6/VvQEMlRY5ABn/sKWLs5o86anubGTeR5z7t0fE94obWH4YQsx2PsSo
         cnHLwwFc5254ScfTQAymmzxTQsCcBvBjpouk2/ScRUa3VwYtkuLeR7XlM1i6d/hf7CeD
         WLdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5DS3txWmnShWeOSkYZcCOb4QBbjc4rEfH1Wqk5hfTNM=;
        fh=RoKwA7GnxGiTlmL9RGJNvnRPoEE61MPjS/klXp1lKB8=;
        b=Wpxec8RBjchMl3Om/b2l4+z8H85BxtfrbWGctBUSbKg+dwDnhayeUMmiCtozWR7PMr
         RMZbkvxWblQWBpBjhprrz3wyj8M3SHvDWchvlHsBuD76yjQEv4Rr1l7L0oisPrSXN84V
         5F44EovQM/JL3jFQ58V9E8DjdKh2oUP/JurlKILvHvR5/7q6Ke+Uv5xxdm328BI7vl5n
         e41G4vV5JqemJFZYEUg6gzUPP7BS4cDk+GLhrK4TULjSI2J2/zgVxKstYrClmf8+dLZa
         y93+ojM1dFRhvQO4cE/Nd+4lCBnzfdhwBhFpazBg2BBbptxClX2ClOMlMNwO3NWcE5t7
         6YVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787208187; x=1787812987; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5DS3txWmnShWeOSkYZcCOb4QBbjc4rEfH1Wqk5hfTNM=;
        b=Tuml5VvAkg0vtzDR7gQRKiTkdFzTbCyo++ZzrWv2tPqDzIn/VZmIAzls4ww8kbBjr1
         gBZZm0eosQqTupPf7Ne0IoH+v9wyGqvHXjwurr98hqqFDcoiz1om5xVcv7E0VUAynroK
         4BOcRbDBdjzFXQRStUJZoIyKi5R5esFpE+Hd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787208187; x=1787812987;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5DS3txWmnShWeOSkYZcCOb4QBbjc4rEfH1Wqk5hfTNM=;
        b=f2kcY0aE97oaeHWWkQ+Tc448NfeMwJvoZCJ8HNUBLFXJumyR2SitbIY/6V+kHOyj37
         cVd7Vq6qZxGBX0lJheF1EIX0GUoLH7HGWZ/ZFR2Uxx8vbgov1iznCwmMxqATT64irTOO
         /ggCeiVSYg/mrEd/WOeaC29C51gU7aH0XAUZp0VY4DPfx/CxKOEpEGqcq2dIDSMNwKC/
         3TYhNugsHhM647crgnzy7KEQOjU8JebLwrq/WzVMUSFdzKudS1mhGyZ61vqRwjURfffg
         GgtQbMmbI627PIlKFAILc1PEvhCtlOW+lYzdJbhsrFH43xDUJhzqJNNQBS8JdhtsnPZ7
         kNuA==
X-Forwarded-Encrypted: i=1; AHgh+RpSKnhIHLJaJWKchMSFN4GQQMrXD/WAhMLQg1YESZh+ew9xmsaSSWxrhTpu14/LFfz2OHfVacI=@vger.kernel.org
X-Gm-Message-State: AFuF++m30hXwaRxrcRnRnql1TcEHq3CclSKijTzm8Lmu51XObh9OWnlm
	i1el9Jtjt27u3+FUZ2iOUShiMfX1ODquiNBrywqWXo0GH/FpKrhsH5kvsMtT7GeoZRCLpbDbfcH
	s1qnC2G7y73FQwGQllpLI3HRfasGOCt1ruTn5aAA9
X-Gm-Gg: AR+sD124sxJAzuAeW8fZtG6wb4VqbE1i+bha6UoYsIzIxkBVAeDT/UGGarupoeH3BVN
	wuJRdoNnxLjA1zW9SZa6IXb2WQSZFNjjx/6gQ9tYnRfgKZoCJorJkRyC+0utJ2/Dj1TjbkJz8KA
	9QzBzBm3RC29H3D2n8YnkDpJdZYoOZMWrzQP0J6o1dXlFQFqHxtXVUN9fgqcN7oweVI8sXlvPBC
	d1sl7X+XMnYUv8G7to9Wz5qkZgYrDFMNFMqQvmdi+rjHbyO2Lw4q6bgtSnkOVkthHv2n1TIdnBy
	fGToipOS+Iho1foZYELLzDcgNOnn7MVRXy+e4rDFtNXWkrlq4rILGPVY6eoHlaF5QkR4aDvlwxo
	=
X-Received: by 2002:a05:690e:161b:b0:667:debe:494f with SMTP id
 956f58d0204a3-66ccb6baa16mr2792320d50.44.1787208187320; Wed, 19 Aug 2026
 23:43:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADOrJmbTyrGGkq+9OJDXCgTa2HvNo8BWxoE6yjafcrOq7WNamw@mail.gmail.com>
 <20260817215428.84740-1-gvalkov@gmail.com> <20260819-generous-nickel-dalmatian-b6bb08@quoll>
 <CADOrJmYfBe3ADun_kFjFSH6YOSTX7Vu3UsFsL57yuRdaQ=eJCA@mail.gmail.com> <e554c007-67e3-4fbf-b85e-5de02f649e83@kernel.org>
In-Reply-To: <e554c007-67e3-4fbf-b85e-5de02f649e83@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 20 Aug 2026 14:42:56 +0800
X-Gm-Features: AcwNN1VnLR1aHYarg7cpxijdC4GmIDA-AAePy3yNd-kTz7zpQyFEH66e6jDxZZE
Message-ID: <CAGXv+5H7AhZgZ06r9KO3HLZ9Cymkai+Cv9SgVTuSC1PjgGf8hg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] dt-bindings: net: wireless: add flag marvell,ignore-regulatory-hint
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: George Valkov <gvalkov@gmail.com>, briannorris@chromium.org, johannes@sipsolutions.net, 
	andrew@lunn.ch, krzk+dt@kernel.org, francesco@dolcini.it, 
	johannes.berg@intel.com, kees@kernel.org, miriam.rachel.korenblit@intel.com, 
	rafael.beims@toradex.com, avraham.stern@intel.com, error27@gmail.com, 
	s.kerkmann@pengutronix.de, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, conor+dt@kernel.org, 
	Frank.Li@nxp.com, chunfan.chen@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 8:27=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 19/08/2026 13:42, George Valkov wrote:
> > On Wed, 19 Aug 2026 at 12:42, Krzysztof Kozlowski <krzk@kernel.org> wro=
te:
> >>
> >> On Tue, Aug 18, 2026 at 12:54:26AM +0300, Georgi Valkov wrote:
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/net/wireless/marvell,s=
d8787.yaml b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.=
yaml
> >>> index 930b700b73d0..5f235cb9f3e5 100644
> >>> --- a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.y=
aml
> >>> +++ b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.y=
aml
> >>> @@ -59,6 +59,12 @@ properties:
> >>>      description: Calibration data for sub-band 3 in the 5GHz band.
> >>>      maxItems: 502
> >>>
> >>> +  marvell,ignore-regulatory-hint:
> >>> +    $ref: /schemas/types.yaml#/definitions/flag
> >>> +    description:
> >>> +      Ignore an incorrect regulatory hint from ROM,
> >>> +      so userspace can set the correct regulatory domain.
> >>> +
> >>
> >> Same comments, so you just ignored entire feedback?
> >
> > Do you mean this feedback? I already replied to it:
> >>> Anyway, property looks like SW choice. You must describe hardware
> >>> instead.
> >>
> >> I am sorry, I do not understand what you want me to do?
> >> Can you please send a diff or a clear description suitable for people
> >> who have way less experience than you?
> >
> >
> >> Again: you need to describe the hardware, in commit msg, in property
> >> name and in description. You cannot tell SW what to do, that's not the
> >> purpose of bindings.
> >
> > I still don't understand what I should do?
> > Can you please show me an example of the changes you want?
> > Else I'm likely to make a wrong guess and implement it. That obviously
> > won't help.
> >
> > The commit message already describes the issue with WRT3200ACM and WRT3=
2x.
> >
> > About the description, do you want me to do something like this?
> >     description:
> >       Ignore an incorrect regulatory hint from ROM,
> >       so userspace can set the correct regulatory domain.
> > +    WRT3200ACM and WRT32x are known to need this.
> >
> > About the property name or flag, do you want me to add a separate flag
> > for each affected hardware device?
> > - wrt3200acm,ignore-regulatory-hint
> > - wrt3200x,ignore-regulatory-hint
> > - the list may grow if someone decides to add other devices
> > - and the driver will need to support all of them
> > - that doesn't make sense, because it isn't scalable
>
> You need to describe the actual problem in the hardware or firmware, and
> then name the property and description accordingly. "Ignore regulatory
> hint" is clear instruction to the OS what it should do - ignore the
> wireless-regdb package/instruction etc.

You probably have it backwards. The driver is taking the hint from the
hardware ROM, which is fixed and thus wrong once someone carries the
device to a different country. I.e. it is a quirk saying the _hardware_
region should not be used.

Whether one should override the certified settings, or be able to do that,
is a whole different discussion.


ChenYu

> >
> >> How did you fix the threading problem I mentioned in v3?
> >
> > How can I fix a threading problem?
> > I don't really know what the correct thing to do is, once I forgot to a=
dd
> > a version tag in v4. So I just added v5 in my next submission.
> > I'm new to sending mails using git. So far I've learned that I can do t=
his:
> > git send-email --thread --in-reply-to=3D<Message-ID> =E2=80=A6
> > and I use the last Message-ID.
>
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets. See also:
> https://elixir.bootlin.com/linux/v6.16-rc2/source/Documentation/process/s=
ubmitting-patches.rst#L830
>
> Look how correct thread looks like for v37:
> https://lore.kernel.org/linux-devicetree/20260819-imx-se-if-v37-0-5ef5de9=
ff1dc@nxp.com/#r
>
> Look at this v5 thread - it is one huge chain:
> https://lore.kernel.org/linux-devicetree/20260817215428.84740-1-gvalkov@g=
mail.com/#r
>
>
> Best regards,
> Krzysztof
