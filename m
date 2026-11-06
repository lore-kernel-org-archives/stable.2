Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793962029;
	b=nF5gjzw9ss46B1uvQm3NwIJrLGK9QsnaWfMDpxnAnytFVMBZpJu3vJVUHcbDSHFVPz9D
	 4VoUkgJ1n7Gwz4cMl9WXITmA2JGfKWAbrRqjpsjWw+o67ju/CQ2VrDCrYoK353WmeYMua
	 mfHRrhfTHfA/y+UBDFc2CXQ8NpYpSPjw3GA/1gq7O+X+ge+/Xq0llutEY4n1fZa6TgcXg
	 Bhukq1M9TiCRNek6rgWFZLZRjb9/NPRA+vEO4yXGc2/pASbeSZFBsOLe4FABPGV60JliK
	 g7U4qruxpaCOQNOQPOgBnI17hsxW+wWpX2xSYR1WriNz+1nOEUGEj2K719Wq28R74jA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962029;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=mVOftWnAYn/7oxXQ0fIlg/ZyrPA/pLsdfSvffJ/Pi3M=;
	b=CPPHYF+i14/0yAcgt8QMmUdTsRIEeEAwlri2oEOn3+aEqKedxP9my0YjyoWqPduIMM7L
	 efSVb5/4foECJKpnPcv4AhH+6a9Q0Zh8ugwmrXjLluf28ele1DJ6Lm+zjOvUb5H+Ns7G8
	 vSyoESQM9/mdFxRvg1C+t8JPxatRGscu7qJ+fUiUxAkD/yt8Pnzh5DHTLKT78kQopXnvY
	 2VrKeKyKK8JV29gEoPSWMWbIWWrczrnqw8cbOKUCoR/yKlsUj9tWfz0vtATsYkkUHYZUt
	 XtYHc1Bwc4tpJJrkZ9YiuZIAOV+lxpYzsijuZ/z4HC0K5zCnviDhaFYySEUAK3Dg0IQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0AzcjfMj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F2D606D802
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 10:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82F2D606D802
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0AzcjfMj
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36dc4797082so86892eec.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 02:47:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793962028; cv=none;
        d=google.com; s=arc-20260327;
        b=mb1yYcvrIMkWD/MV9oA5NKbx9WLaQJpR3OtKMALljsw/b0/mOZQMf2+uQsJDXislRq
         VpxUpCfgb8jOp5Zq3qd9LGPmxkERBJ2PnkeO0ixoxr5n953E+foZBZXXKLrC7gfmxTDY
         Hn5CXnJXrtgWho5g3VpjQzf5IWVq4QnBxWC+EoD7x3W5FO9wqm/Pi2sbXujx5yEZpjYm
         NUX0tZFbQEh6YiLKsYjcQZGgV9jSy93fXsxNYdIU3zKeXaQkPkNCj9c901FKKRnVeb2L
         e+3OypbeypcrUGuSLsWordDdOGuJlBNkkIevsraGDIqFrjAqSbJJc1nU9rL+KAgb5BK4
         L57A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mVOftWnAYn/7oxXQ0fIlg/ZyrPA/pLsdfSvffJ/Pi3M=;
        fh=2Z0ubzjQXViS908QOQ3fXhLbjhGhVb+7y/pDgb6dUZU=;
        b=bWhfBTZkWiU1eLLiazzQEIie8uVkm/GFEKp7omcAr4DlFc9WF4KRJ5BNbOycB7EWb4
         WVMIjyCESIuAC/D2emc/4SGsRKePoGTdee4+IAsPSujmVn4QmrTb/d2ZOc4eGxar0M/Q
         6fXmSN+CBbCSrD9ooNyfUnpGwiNx+ArMS8ciFdN+TO6Udz+lmIQHG7JegZ0odfZwxkAE
         Ov7aKgiSHc7r7epIJi0KnF97L9ldwFNXC1Karob2HnaxC44xLjFEnPh+MkeOwSSpaXM3
         s42uBKLKPKSsbSXhXIugLPiUefP7s+bHyZfDJHrsZDMCd+txrCTKl6gCuuZwBr5iinRr
         eEFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793962028; x=1794566828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mVOftWnAYn/7oxXQ0fIlg/ZyrPA/pLsdfSvffJ/Pi3M=;
        b=0AzcjfMjBKzpSYEBMOsO9fuQzZxEJKh1HMhLA35SR9ATmau4/+V3uu2VAhicPbsAVn
         rFudi7LW9HPxR1wMDr2rdIyxPzCrDPzkHdJtsGvG2mAvXaB3zeAfTMrlOACfdhK84OqZ
         rAiGVzYlNa8v232tsEN6hRFg18yq6qMAzvcbuDuQAqmMhBJHi1pEP4oi88wGjLak1FgY
         q7SyZrgHFt1FrJpzGw8CqI7rkl94HHRfHj2zxV1g4ZJB3aOq2r8FvjpSrp5bbnWNKTCf
         lXgiR8bTJeyk9dNWHdAVP1UO8il/HYOQqT96aScTAwBXLIn5pSjg1PCEOfEteYE+HGbi
         ftdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793962028; x=1794566828;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mVOftWnAYn/7oxXQ0fIlg/ZyrPA/pLsdfSvffJ/Pi3M=;
        b=vlFzPCgCDN+LoGmcj4g9bDIKSogY5ig1S4ii0KrBCdcLmSVrF2qSMaKs1M9Rv5HFz6
         kvOql/rubStdjQ7rVp9gJ0/8ipLJn178pIRRMKrhcSkkU9zyqwnrhafzCf+OMZWrS4vP
         UFWAlUJy2lWayTcFjyurvoS7sYElpervyOqfGAlxfdvliONnqLFXhJARhfitAYjIReVx
         sLVyfQKK9v/E0u6/2r8eDdFqEqjhGY3XHy94oLtyAauFtyfa1Nk5N8cCd+gzPl3+eMMQ
         vQ0nxBnzRjlmY7tR8TwCA1pXbxFgGeA4orOt/tEkvxJ3UDF+cXp8dKuI0jCts2Eez8MN
         sBog==
X-Gm-Message-State: APuU4Z85XaVL5LzNOcpmoletl2EiNWw8VlZL5v9Bilh5eJZNA9TlgWDL
	2zzosYey8YASuufJagErIdVtvp7LDHmBY3FI07r4lM7hITa62FV72A/epCIPywxppOrtqX4cxvg
	TOsDpHyyOs/TXZoWdJu2BOjm2BwmRy+g=
X-Gm-Gg: AYBFou1SSUEva++X471A6KMPy2AKmHKwUygQqGZAXCIW085ru8bwt+VaUHoJXe6U0xo
	dYC7ieEQsTRlhXcR0RU3MHcPUxA4WB/dzFWIOIDPfu3wQEPjVFy1j1MVyJtsUViYaq86R7godn8
	iIs4/8vhTc6QPrszv4YdLbv5GZdBIMpBJ8rX0/pkbgov0fn7ULHXxf+ww86Ev6ZgOzuI3+PLWvT
	OE7JY3HGPhGPdhxh6muH3d88C70lSdrh2jO62D2T6KFlXs9wOJCi+0v/L3qZY72I8gK72+ePU+A
	UuDldKAAIykAcT6s/Xl10xy7qYubo3FzHRvyuObAvgRViTouqvMVGoQMAQbLnhpi24XvL0jy4Qm
	jex0s76Cj1WjwlG64kMgGryjf06UIJyIUM3jBogUXJP0dmC2N0wYVmKR75HiKzSl+mLWstYtXRF
	uBRaAoUVfRNw52wS0f+6m8lhceeu0Hexcig6KNl9sdgUZuyyMxmW6BSG9zK1qzSX/TRY926lUZ9
	I5O9W2mcJcF5F+kpvSJd6bcdBI6h3P1Svz3
X-Received: by 2002:a05:7301:78c3:b0:36a:143d:98db with SMTP id
 5a478bee46e88-36f7563828emr3934805eec.1.1793962028405; Fri, 06 Nov 2026
 02:47:08 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <2026110407-hydrated-decipher-a8a9@gregkh> <20261104223318.627233-1-sashal@kernel.org>
In-Reply-To: <20261104223318.627233-1-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 6 Nov 2026 11:46:55 +0100
X-Gm-Features: AclHuK_pGyLnrAxSli0oNcgggGVEdPGRi0p2F2LrzS7rXjWfRlbg9JumTrRzGXE
Message-ID: <CANiq72=qDLHJWhkvdqMHu1MAy8M3azXKGB3+B7zBy6u6mrNX6g@mail.gmail.com>
Subject: Re: [PATCH 6.18.y] rust: irq: declare cfi_encoding for irqreturn
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 11:36=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> [ sashal: replaced bindgen's custom enum attribute option with sed post-p=
rocessing to support older bindgen ]

> +    sed -Ei 's/^pub struct irqreturn\(/#[cfi_encoding=3D"9irqreturn"]\n&=
/' $@

Meh, not great, but it is what it is I guess :(

Should we send the other two, i.e. for dma and hrtimer? i.e. we had these:

  FAILED: patch "[PATCH] rust: hrtimer: declare cfi_encoding for
hrtimer_restart" failed to apply to 6.18-stable tree
  FAILED: patch "[PATCH] rust: dma: declare cfi_encoding for
dma_data_direction" failed to apply to 6.18-stable tree
  FAILED: patch "[PATCH] rust: irq: declare cfi_encoding for
irqreturn" failed to apply to 6.18-stable tree

but I only see this one for irq (I imagine perhaps you sent this one
to see whether the approach is OK first?). Do you want the other two
to be sent on top of this one if so? I have them, and checked that the
hashes match C's.

Then there were the 7.3 ones -- I will send those.

Thanks!

Cheers,
Miguel
