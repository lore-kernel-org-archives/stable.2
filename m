Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37244352037
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 06:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780296092; cv=none; b=aW0+6Zyu2Cn4cqzN6EIKCUtrhoaiVyijXb7K8YHddfw6TIDkG7taZSxEVuJ/fHr4d6gaJ/VGSLIQRt7h2e4ITEYuGxiCVnEn3BXjsoORMZu8h+vrGJiY+JHkrSvvsiQkOGcvQ5YwutEOR4WT7yyX91XZ3hofcs0wosHYYPN/HaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780296092; c=relaxed/simple;
	bh=JKr3Z0kvyM5THXu2zQIiY1on4STp7BRu77YEIZYjAyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIdIGaXypJLGy38hNgrUxuaEQmIvlB/A+N3VqEij6xiI7U7zv3QlHDVAks6ixq0elTrBIpzjc2iGVnFBc+YW9M10lX50slgppbndv/ZX1zNqdN23x2ViY5r170raencn/eatPQZUwZrSeaS1xH9ffOIJACTtIe8++rzQg6xF7b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Nu/YY+VT; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Nu/YY+VT"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68d232ed3f9so1412252a12.0
        for <stable@vger.kernel.org>; Sun, 31 May 2026 23:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1780296090; x=1780900890; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=grkecyCDjbFeNTHglTGH7ZaSe0hCCHo9PMK+wzDd0Ts=;
        b=Nu/YY+VThFuzduDOhbPy6kvesQ3t0yNLO8mwd13OMN6YX/Syr/BLQ6XX+u6G4lByTy
         oVzLfKkIk4ddJysR3VV0+RG/elUroYpSQSobfkHAkxDJeS8FDvNL2PyaJb2KhWaMghJm
         dZUjsGg4Xu0vvlimL/SDnJ/di3ZiyW4Vqtv2E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780296090; x=1780900890;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grkecyCDjbFeNTHglTGH7ZaSe0hCCHo9PMK+wzDd0Ts=;
        b=agpK0B5iw6Sz5J/+GDc3E+BMf4lLGESENBdjXmEAh3yYhUEHhFA0N+6nemnlBW7pqk
         0KKkllj/A5nSV0xpLdoJJBaiOMUk/iCplj4Zj9HxE2xJAMQgNkfyBiCAzTe2okTUydHF
         SadHmcllPqtrgakIUO0U+fVhtuGM8bFVynzOeQYa5Tn3rGyTwS4yamfH4b5iYVaXrr/+
         6sGRDUY0q30GghInHCI6IgK5WpN6s4HjWjeXhKUqBlfHhLaB9T7JlBb/cJg0P0toQNbQ
         Fz6/7MzgBk8h9UP3ETbI9Y7rD6DQRKCwDQBCbd0D5bYsOjgaq3GAfA2VSUQk+7EHAEgh
         z0Kw==
X-Forwarded-Encrypted: i=1; AFNElJ8fTPpXOX46CX/xJClvxd1x30Sm1gqCW4h2HL0izjDcWO0hgfd7d5vRr5+VZa8MlNw7IW8C4ws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKqn374RaCsduarIMgsU7jnufzzd9iSlJu0p7YZMgDjCfUtaNN
	Eyr3BfcSkMfZYKuXSVMgfjF7ymvc9NompDElaTtFU2LAFlBpMWa5GS1n2f8uLUENkXyrXYA9n5t
	0FJZxFA==
X-Gm-Gg: Acq92OHbUiWvczBsAmiuYtMCJjJy2KDpH3px1z4YbsJQ3IXLs22W7+oJrYYD0O/3SAS
	RiEmO0EQNviniIQ1YmOMu5CZeQBYdM7K1iftdBNIbDroIrZOBAeYmdzQbCOM6cI/f5xUlnAqGUs
	HQwPf5Jzg78jXp3jmCEfcFnytEd0tXc3tMByA3G3i9/f7FLudefMKtI/IrRzuUZBDVSn5RKAK83
	fVgWWh+nAdOmqTnpPh5Zg8DyEiPsWlhZ+nHsLJcrYl7qTdws4+lD0H03m1KySM1FZHzqQwD5vxy
	UG7cHOdaHXoPNTYhzThMnWxUQ+3DgOCmy6waO5/dDCkhKV4LBay9oQ8hKUmkpNf70QRIRi6hpbI
	2owSjbl+9q1jrRU4uYasoyE7UPPOe8wODnX47vejT0eWZqqlF36fzkT5rLUZvVW1zJch5WWRjLd
	KkD1kSmWiIO5XGlIeNaTpbITzQ3j9IFcLUm5JFLiBbrI/vhOK20Mpx5zIJF15pESlC3CTU8sE=
X-Received: by 2002:a17:906:f595:b0:bd6:4d8c:bbff with SMTP id a640c23a62f3a-beab04dc033mr525214266b.22.1780296089597;
        Sun, 31 May 2026 23:41:29 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-68ceb844b5esm1666763a12.17.2026.05.31.23.41.27
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2026 23:41:29 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-bebac79fff8so119014766b.0
        for <stable@vger.kernel.org>; Sun, 31 May 2026 23:41:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+RP+4IfnR+Nd91G6K08PUE+1z4gPXHDIfa5qTIGYRc9UduMZGsdKN2m+J62PL5AOANQWnr6VA=@vger.kernel.org
X-Received: by 2002:a17:907:3e0a:b0:bcb:66df:819a with SMTP id
 a640c23a62f3a-beab1e809cdmr487255866b.40.1780296086476; Sun, 31 May 2026
 23:41:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530160224.570625122@linuxfoundation.org> <20260530160226.496219768@linuxfoundation.org>
 <5e2ac444-451c-4220-8013-0e6382b5f165@pobox.com> <136f03aa6f51bdfecc786e5278f5fd03b4a6966e.camel@decadent.org.uk>
 <20260601015021.rc-uvcvideo-heuristic@kernel.org>
In-Reply-To: <20260601015021.rc-uvcvideo-heuristic@kernel.org>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 1 Jun 2026 08:41:14 +0200
X-Gmail-Original-Message-ID: <CANiDSCvh6u6AWnarEtso=zKPD3upEsaJBMOm1x35fHyPMaEMyw@mail.gmail.com>
X-Gm-Features: AVHnY4J7eEIEPEY8n4veiWY6QsIg61l11iuaxssDhuKBbjpiPm_kh5n0oDz1rwY
Message-ID: <CANiDSCvh6u6AWnarEtso=zKPD3upEsaJBMOm1x35fHyPMaEMyw@mail.gmail.com>
Subject: Re: [PATCH 5.10 072/589] media: uvcvideo: Use heuristic to find
 stream entity
To: Sasha Levin <sashal@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Angel4005 <ooara1337@gmail.com>, 
	Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, Ron Economos <re@w6rz.net>, 
	"Pavel Machek (CIP)" <pavel@nabladev.com>, Brett A C Sheffield <bacs@librecast.net>, Mark Brown <broonie@kernel.org>, 
	Peter Schneider <pschneider1968@googlemail.com>, 
	Francesco Dolcini <francesco.dolcini@toradex.com>, Shuah Khan <skhan@linuxfoundation.org>, 
	Jon Hunter <jonathanh@nvidia.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Vijayendra Suman <vijayendra.suman@oracle.com>, 
	Ben Hutchings <ben@decadent.org.uk>, "Barry K. Nathan" <barryn@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Hi Sasha

On Mon, 1 Jun 2026 at 04:11, Sasha Levin <sashal@kernel.org> wrote:
>
> On Sun, 2026-05-31 at 12:53 +0200, Ben Hutchings wrote:
> > This doesn't properly fix the problem.  Commit 3d9f32e02c2e "media:
> > uvcvideo: Create an ID namespace for streaming output terminals" (which
> > reverts this) needs to be applied on top.
>
> Rather than carry the heuristic and then layer the namespace rework on top
> in 5.10 only, I've dropped this together with its regression source
> 0e2ee70291e6 ("media: uvcvideo: Mark invalid entities with id
> UVC_INVALID_ENTITY_ID") from the 5.10 queue. That mirrors what 3d9f32e02c2e
> does upstream (it reverts the heuristic), and avoids exposing the
> 0e2ee70291e6 regression that would otherwise enter 5.10 in the same batch.

Are you going to apply:

Commit 3d9f32e02c2e "media: uvcvideo: Create an ID namespace for
streaming output terminals"
?

We need either that patch or this one: media: uvcvideo: Use heuristic
to find stream entity

The namespace solution is cleaner, which is why it is the upstream
solution, but both patches solve the issue.

Regards

>
> Barry K. Nathan wrote:
> > Comparing this patch to the corresponding patches that went into
> > 5.15.203/6.1.169/6.6.117/6.12.58/6.17.8, I believe these Tested-by tags
> > may be incorrect.
>
> You're right that the tag set on the 5.10 backport was over-attributed
> relative to the other branches; since the patch is being dropped this is
> now moot. Thanks to you both for the review.
>
> --
> Thanks,
> Sasha



-- 
Ricardo Ribalda
