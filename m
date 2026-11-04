Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793833505;
	b=RrKOl/A72tYYx9P0zWK7t8AfJtUd33sjNp2XpDeBdlhgqNTnwjBpRfhlbndYkb3wAtxW
	 qpGnjSlYmOc3kfTdpSpjkHpXoMPJPhWmNOcDe3U/GU+Cgj8e8Yyiw2N/XvBWUH2MIZF7L
	 wLpbdXxsR9sORMekobijqwyLU72mgzSGhnQ8N30j2JZK6BokWdIGqHDu1sTdfwrq84bFN
	 ckKb8WVf53fkxHL1xbzesGU2ROT6UVUywqoMMJhqPReF9D7E6exWPcllrohdU82R50ymm
	 DCwWupm1lx/isCllkuNzxzmyF813cUHbyc4e5LMr3dzr2+DoV261FBgkpDnGIVOea4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793833505;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=fdKcInFwYxEQdF2Iwzxw4Nto24hXOYR2F5pyiTFVT6A=;
	b=A8Yoz07KHjokm+jYCLhsWL4ESNOZRqTCqscGUecH/iuJ6lNQPxy1hc2SUQsS1pAypE+j
	 6ITUglxoZnLWVLUuBL/oZT9aLINL0KFKUJ7UDECPTC3KrU4h5rdg37UoiWeykw3MKiSit
	 C6XN9ipt1dp+icvmZ0lTfVfwnxmx2cExzJnQbAtMYJqsGCAncBFTi6wzhCpc04ltFR7Gd
	 +/S60XZIiY5RrdRbOy1ua+S6ZkxvsG+RS9hCutAG8RMPToLunUywpdWrCY1+33OFExg+k
	 537Dfp4nmArczumC5olYQZstHH4uTpt1rPKMXRw45zX7Z8ntWTOtMn2RrJzc7MwrU8g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LVdNwZbx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B88606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0B88606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=LVdNwZbx
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-353804b591eso2393478eec.0
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 15:05:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793833504; cv=none;
        d=google.com; s=arc-20260327;
        b=INDAUnSiclFmT1WXQuSdPkQJCJq0n6KqqKkluJ7A97cyYa7j+Ut+zxRRdMugZAJo1d
         XI+LDSoYfiAoNzHpwbuOdpSJ3U08i3iPaNj/Donekh0VGABFdge/y0SCw92Bglvg1CgJ
         DdWkvE0XXr39QjLY23RImrB3NxJQWnGokA7AOP7Y59Wr+bhOnnhCzyBIinZd2PZ2yB5G
         8N4goYnK05/N2JI3G5qo9xMda/Nw1XbrZeRQrdVLWmKfCxBpTlxQqHyGbwMbYt653FuD
         3LzZ6XBXeXAyJqFwBenyTmpskh0CwZVxWlG82cPoLkRRg6QH+TawgUV9yZ/iQlKXRjlo
         04Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fdKcInFwYxEQdF2Iwzxw4Nto24hXOYR2F5pyiTFVT6A=;
        fh=l/NSP3TJGMFGVdLEmkGa6dhlpgxudtnSb10QLru/rQU=;
        b=PlxY0JZJknnLvHdxRp7fOPutQq/atSU5y/MzXKnP4++qty8OnBKffvHwmGsVne3lI1
         Hy4ytKr6+0JzniAkPU/fo1vNldmF2UCPUevOrJzyB/ZccPtEb43ikOaCtTDqQLBhbSi6
         2vAjuHRpL1auF4xE2Eb9fXPP8+7QWmnlilgLx3ghamL0SSp5AeIoFU5Zzw9t9Cn02a4X
         cwx7BZN0ujgGjjdu3SFnEqoU/YLFjduBuS1dtYkzSj50AahDqFZOOSA8eTZEgTh2gQiF
         flnE1lylAz1ewYpsT3llA2WEZfkWU7uMsX7Aac57wdzBcci+2gXCpv7PP1q5qdZZDUoz
         n6CQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793833504; x=1794438304; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fdKcInFwYxEQdF2Iwzxw4Nto24hXOYR2F5pyiTFVT6A=;
        b=LVdNwZbxDcmkWD1uXn/RxjypNH1wto79YbS8LyXrG4RGGmzVBFMTW6pU9soKUPHn46
         R/cAR1vwXiZAR/yycp0Sb2+LTRVqKSel6/6GCTxqEddvLjk6iTgqTVv1+rLhDS9jrWsU
         BLbHcmA9lXOX5allYF4Fq7CSSGoxtmouikOMhcjvv5udlz2+v1wFNTFyjawND6IOi25x
         F2gmHoZs8RQz08qZ5NWHQoDaKC971HNUYSuBsPzgYoy0p4/UOJUIbHiFA/+Q7lUk9r5m
         5kRg/7cPwRFxJKG6D26jPf5DhPyV0RqWMiJbekGQdWbOt0vJmmgoQ7SQvASFq62ElMix
         Dfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793833504; x=1794438304;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fdKcInFwYxEQdF2Iwzxw4Nto24hXOYR2F5pyiTFVT6A=;
        b=sDDH4zjlYRc9lwJnsFg+2vMNtvJHdfWZmbGkW5pi3cenSpW6BByuqFNeNm+JK81c3a
         SJUXLfVDplZeSNJltc2k7XZ5d5ego0P9euk+DBW8F7ltrwk5ZCjaOGoK1VxqJ9gzqfiz
         mGtB8qXQa3PeR0xDxESkfuqVsL1fLBjV6ci96ZUaMawI4YMuCkYqmKar6kMipHOK1C8q
         REkauEeekpCvhXmOKEVhAwq8aZjQmxXqffZ9NQ+nQeTU7YtNT1aUTa2Mo7VIM7G1LPQ0
         7Exl6NqGzFMWuFSakjT8lDHob5yuJ2DqsA6uOaPZFn6bzDI6Rjd1Q1RktfBwqXz4KnMn
         xgrA==
X-Gm-Message-State: APuU4Z+3+zhO7N/8CKfmkhbok6yUH6UfgYt9U2cTPTYdjsJUcPN3PKaG
	txk0ejFebjH33Cd9Q69w3iFJgziM1FVVf7XJonVS8OvWQd0xzqvc6wvIQh+rdatt0yHr6+Oye2S
	CXOVnO62V2MgszqP4cqp0RNzSmPp/v82ea4srJ0SOgA==
X-Gm-Gg: AYBFou25amksVzLmt3Jj4vRCB2pkCIzLPbqfV3Xxtm2b29308uNee3YTBC763q9JFyo
	JiKSbs2QqB4cCZgxVHDN1/Ch2i6oue2+8l6PPndPU4w5bCSn97vK+kXdrzQFxXTib57ZwgXry/P
	vuWcUS06Gu/t1BAAtL4gDUDVe/LF8ZNG5q77AmUPFF/xzZ9Qdg7l2rQ1INbiRHP1kSFeHhk4343
	Bz/xU7s0xkbR/BoDrAJVXEcIpnO9mMAXrbyelfDtdwgORLi5DKjZW+e5kzWJu1UfI0/2K75WeRq
	OkvEo6xGvvx9rGu2egVxMjWCFxliAPQ4Adh4zYQG0wqB7p1IEr62Odo2sGJLRVqH7e+QmPcnpw3
	wVbsCEsJwWit3sTYrpp3tM3nRjGRX/ykWkxCIYcg3p20JxhsjL4zJmeLNL/Z7JVmUuziRQnGjaT
	DVBAeYSnULPPhdRaGeJggFWWN4akfaYwxMNs4BVfI=
X-Received: by 2002:a05:7301:4246:b0:368:7c2d:a612 with SMTP id
 5a478bee46e88-36a42345878mr25113685eec.10.1793833503438; Wed, 04 Nov 2026
 15:05:03 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260930152347.700140858@linuxfoundation.org> <20260930152351.156698628@linuxfoundation.org>
 <auj7ZUcOlNC-rEnk@maple.netwinder.org> <2026110444-preshow-shelter-42d2@gregkh>
In-Reply-To: <2026110444-preshow-shelter-42d2@gregkh>
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Wed, 4 Nov 2026 18:04:50 -0500
X-Gm-Features: AclHuK9ErX2cQvIR3BHxau2O44hKq4GbcDvQQlooLxeAojfKv2Z3D8f5iBXKHQM
Message-ID: <CANp-EDaxZTff_UvEwW0o5=0XeDSzO3edT-aPodkXwJ2yuiGN_w@mail.gmail.com>
Subject: Re: [PATCH 5.10 159/595] gpio: dwapb: Mask interrupts at hardware initialization
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Liang Hao <haohlliang@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 3:52=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Nov 02, 2026 at 04:06:45PM -0500, Ralph Siemsen wrote:
> >
> > This caused a small regression on 5.10, details below.
> >
>
> Can you provide this in a format which we can apply it in?

It was submitted by Miguel Gazquez and Sasha has already queued it:

https://lore.kernel.org/stable/20261103-dwapb-fix-v2-1-9bd3785d1365@bootlin=
.com/

Regards,
Ralph
