Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972861;
	b=3qiOG2RN3NvnblBcCR6mXLciPGRkWyfLVXWvaJzscpfTyi5Z9YS6t41mYvshPqMZon1R
	 C0uhzLmD1qLPzeKrcm2PcGD0JOl6LfEJlWDhmlaAGf5xiEQmLoRHxfParAPZUBZXALX3G
	 X9AVQ+4lDD+o7QuLVQdmRElU9W/pM66DhyLHltwJwskythvNNgiLQdh66XLJDw0FRIQAV
	 bJKQ2atFcR9hiPflZ3BAX2YndN3P1l1obU3ho8OSGIYsqVYtAmaJvd0aVN5Sf65SRjBFO
	 Lqt0H+CriPoTCbyDqLebRNeCgGOxpidK5eq4xCuo6RdiQS57Nj09o0Hb9LqjxD/7+GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972861;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4vVL1EiPkJtSj0Q5/MEZPPVQTmsj+iOOThXSePIk96o=;
	b=NscM5J2nbMxg5QznMmfdrRvZIzsg5XXk3AcVKxr5DhAsT502CHh60re2E/FNuWjOqVQH
	 mp31JG/dPthugtPSm6AQ2kpuc3RwOaR+tg9+IrU7KtBxo7U0+YTVjF8ave4aO5G1S7/k0
	 kA/jTxVkKkrZyt2sJuhygM1raOtrjA/ONia/abqfSkfsEbWmZhLg2eLNsqTqo3CgmpF56
	 GSK4nDSpezuWHWifxjXPz5H0XAKjh9YWeUuM92FPIzwrsv5egOn1jiyjzQY1H4GfN1F7+
	 u5QSKgveEJAbQrh4LoDKed7y8eCQZshlBg/cEjHcbwRBubXFrIHbxfjOvj0OPRG61FQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hq0Bqfj2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0A1606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hq0Bqfj2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6B9A1F008BC
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793972860;
	bh=4vVL1EiPkJtSj0Q5/MEZPPVQTmsj+iOOThXSePIk96o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hq0Bqfj2UyhLMuTH5ekszeM/i7rugVYBcjwLWOQjWb5rKs5SSOkLzbvQOxdY/lWjf
	 qmNzTDIjow4/PpnuRv/OABiVlxSnKeMxeTZVMaknC3ZUax/bvINmgAKMlNidIiH88P
	 LGFWmh2WsKNsJl3zUmLa7jn/ECIt41Ur+LHGhk2bHnrozUx+tOpVNYzIcpCPuGVDzD
	 MIPAZVI/7RAaLoWyUhNo4XrDTQl55uGWDWrzWcfy+KQleJK//ZytW9nn55oa6HvI4R
	 tN5Xv/Mno20UNLkbF4V6WTbFWJqRwU16ONj5edIc9D+TkD83sv8Iy3jTTW6x45cCp0
	 O9ZoAgM2DqvwQ==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bff8fc7cf2so711861e87.3
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 05:47:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwYE7suGpqi0TSkksEQhb454udZk0rQB1sQueZ5GNFyOYSFnYIic/PPVcHpEJZ2RDNLqwlPrrM=@vger.kernel.org
X-Gm-Message-State: APuU4Z91e/AHnGESQvkJjQOunbQRkY8aNvUTjNK7pRkfLlIHxwl3eJ3N
	9+MapZTJB4KxBkEyjkRcu/F50iEOzT0DStSpYQaoZjC56XtZ283fjWY8mxmt/9wjIu7ypNLFxNI
	9sUo3M/QO5oX75YWWwSCioQBdsLWYX7U=
X-Received: by 2002:a05:6512:3b11:b0:5bf:d6f5:f966 with SMTP id
 2adb3069b0e04-5c003adf1ecmr764970e87.47.1793972859536; Fri, 06 Nov 2026
 05:47:39 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103213002.1673560-1-lee@kernel.org> <20261103213002.1673560-8-lee@kernel.org>
 <CAD++jLmF0U6ehFSuauqKDQiZRkuUnqpbZd--v2aqF2YZQF=HwA@mail.gmail.com> <5c414196f5e34bfeb7a94714e5542a72@realtek.com>
In-Reply-To: <5c414196f5e34bfeb7a94714e5542a72@realtek.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 6 Nov 2026 14:47:27 +0100
X-Gmail-Original-Message-ID: <CAD++jLmBht_EauPV1ggkw_pnydVbCTHk7s_dyHPN6OA_zXOKvg@mail.gmail.com>
X-Gm-Features: AclHuK-g1F9N5vtbEMFGavDY124RqKgGGFWqEsXHGpoz6PIuenneZBMpw1y5QLU
Message-ID: <CAD++jLmBht_EauPV1ggkw_pnydVbCTHk7s_dyHPN6OA_zXOKvg@mail.gmail.com>
Subject: Re: [PATCH 07/10] pinctrl: realtek: Initialise omitted offset fields
 to NA in config macros
To: =?UTF-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
Cc: Lee Jones <lee@kernel.org>, =?UTF-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>, 
	=?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.com>, 
	=?UTF-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-realtek-soc@lists.infradead.org" <linux-realtek-soc@lists.infradead.org>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 3:49=E2=80=AFAM Yu-Chun Lin [=E6=9E=97=E7=A5=90=E5=
=90=9B]
<eleanor.lin@realtek.com> wrote:

> Thanks for applying this patch. Just a quick heads-up on the merged commi=
t [1]:
>
> 1. The first Fixes tag kept the original 'dcc9334435b0' instead of the co=
rrected
> 'e99ce78030db' I suggested.

I went in and fixed it up.

> 2. Branch: It was applied to 'for-next' instead of 'fixes'. Just checking=
 if
> this was intended.

Yes Lee reached out to me on IRC and asked that the paches be queued
for-next as nonurgent fixes.

Yours,
Linus Walleij
