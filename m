Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C93C5525
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 16:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784217604; cv=pass; b=F5IaaSJ9lhYBd9SnpNRzDIyXUB3siPPiM3u833qG9AzMDHYohX6SwWxHKX9WQ+PCkS15qa3gnmgGy6LBo0DcnTrc0atWVL9O8nKO0DUgas9GrpMQTUGeU4fK/wdyFxunBaNnJ/qE4ffCqtuaShGJ6oZ1j4kvle5eI0Qi8r+o2Jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784217604; c=relaxed/simple;
	bh=QyfLOTmDKblqNf/f8CcxpjE+LTEpqUWf39doD/kMj9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PxdPWj5I9ssU72U4TdFQLTQGXbEcIGST5SAbpyKsa7XRe6D1SDH3GYcPvX2wuNzJlZpT4XSTaR8hpqEltomeZDf2kQTv58UFhYcO+OvzYMki2FIQfTTY0i8S/wHBXOkoBtBfjX+wmgtCYhbxUTpTNxqcvKcVgG9uaniOqstg+Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=reoBOQSx; arc=pass smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="reoBOQSx"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dd1cc8dc8so618701a91.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 09:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784217603; cv=none;
        d=google.com; s=arc-20260327;
        b=LPA0tU/kBBuWPwsOaOCPHu3YjHE+CtOhuUGKdIyVh8Anw3CmLLqzwq3pgGI9/YGFzY
         CQCWqqOwRoiyqxvR91hM/xekyGkG8qQ4cjrkS/AfOZpOXHBmBRlZNSjrZEaKC6kMdL6+
         peo++Ro5JCZCLdAjgINr30CP8WpZhTn3xjhugL53JeIb5Uh9b0+D1pGP1NVhtCqIpG0I
         /8QkFf1gsILKSwMNgNxOlMlos/Hkp3K0w5VAX2TSSfV3S0DqcwEM8uGQZPk8RyLw08eA
         onGVhCYNhZvnT7pDOlJclgYuoFTtnnzN2l62jT5hEJQb/w3cFSaggD3jCa57KNaCRYIK
         +xFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iY17dWR71qKy/7I4B3cswFVlH36Dhc9DEFHqiD07hVQ=;
        fh=MMeMReNoLytCn+VqdW2LNqgjWNr+nrBhxOYfbZz2qDg=;
        b=oXy8ypaVtcXp+BhMpJxZYiRMNJwS7Dkvc//xpwJMecfGczEZkpnK+yGzN2kSXUmWZu
         HpPaW3jbrHQHeK2fjCCCN15fz3/syLM+yVD3MwI6lhZY6/23MT8s2cm0NBBeOhMeLz0/
         XvNtRU4tui+cmNodjGaYsdKtDxePL7ZwUPVT0/VcUKHADLTT8Hk66rZkcnlh1CkN9Meg
         AJ/EUBgbCNaZN2DmHzVVDXZGX9dPWJDTKovQ5OyEVEAxNZPYXt+bLixac/0jQUjXqL3r
         ob/VK2SfI4SHwyp0348+gyayGhkSTB4J0eBUiwoN+0NSgc3h1dmgoz6bxcFVpM3NfHZs
         6owg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784217603; x=1784822403; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iY17dWR71qKy/7I4B3cswFVlH36Dhc9DEFHqiD07hVQ=;
        b=reoBOQSx26UAL/SVxjcdTxHSKX1RmQmrba7CbUswZN+ff9ZUWIL7o2apzeMCsQ0QrL
         aWzt/pyVqPkZFNgpqrdJaf/f0rgpsWUfqJvSU+rOl6n7gbt38XnbD8hoRMm8XkpX3vqh
         9WztYufg+7wKnM8uC1IdMFjTljgNgxjyY2P2y+TI/YXPxdu/P8BKqSQETVbeaklCZ5om
         DcODzTPFUyVbj+SgUnmrJviXPEO6CnKybEyB508Qmtng6oCzZDI1cvWWwk+T6EASbAoS
         LfHj6VigGN0X7thZFbRrHvs5vaYNmJgLpME/9Jr367Ld2aKwOzL2kuia0YE01FrW/X/d
         zYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784217603; x=1784822403;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iY17dWR71qKy/7I4B3cswFVlH36Dhc9DEFHqiD07hVQ=;
        b=eKMGpYN93mHdURlXL8F0i3kwqBYnTlZDQQoSuCu60bSdvqLf0wZelRPGIuxhEZDbe+
         PIi1IzSuFRqapseJp6tb3Ivf6VOsUmVjPEzvTzP9NBjCVvmluDotdVKSZcDmtavOK3Yo
         smy1HeIzpAXOU5Bm749A2MRpzk82A9gCpzB31rNNjkKkk128AJtt9uUHX21O0krMx2D/
         HLtP84fTlgJMKRHcu2Z3bjSGGqy5Hf6bLFnRuj8iKnCwj+u74WE/nICtB7GsOkLHNvj5
         3IpFO+KT6DZnMfvudY1PDG0/NdrkyaK014LlSsJQNgl8W1yxEPsXiBZHHB68ukmE5Rv9
         P01w==
X-Gm-Message-State: AOJu0Yx7pPXjgMrlbp7CcNWPig7D5u48+3+Zus/LWJcIpspDhu+evod1
	ckYpbEzCKozbtQLXQNAsXNTag4xQHHvr8jZRzmSQQqqvEdWgH4Wa8MlKhyn7E8KvuaR/1ycTQOj
	OwpcHhldLYSCRIMgcpuvTXkSZ00qhNFo=
X-Gm-Gg: AfdE7clLWeYBCRQU0kpq2UvyoH0fQSK7LzA0581BlX87uzRwQ8tD0fTRVSf0RPjPlSc
	1iOnjqnmQZfUlojWUBisvO2h/DjEAtaklr9lzWQxx6CVGhgp832LO27XC0JCkzmhJEHtBzm+rUt
	6DUFZtwTKl2rPqqWEOcYuFSoz3bbwSuNX8EEnXmc2mYuh+gbRoEo3X/KsFzDiphKJ9c162vP2Cs
	qnROGLXCdlV87Je2MSr04Ujj+QTDqGJmYzP7gP2bPuyxRcqyaA5tobgupkcCCQU1of0H01OWToa
	u1nejGNt/GA76/0e/ZJghSy/jMMTcCcDPMxPSm62DhxGQiyLX57ScjxumBps8UlTA0N+W864hTB
	alg==
X-Received: by 2002:a17:90b:224a:b0:38d:f0a7:85f9 with SMTP id
 98e67ed59e1d1-38df0a786cbmr13297783a91.0.1784217602679; Thu, 16 Jul 2026
 09:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716133033.287196923@linuxfoundation.org> <20260716133034.168967917@linuxfoundation.org>
In-Reply-To: <20260716133034.168967917@linuxfoundation.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Jul 2026 17:59:49 +0200
X-Gm-Features: AUfX_mzlN6ts9jWgrhP-ttrpXbsj6Hl4xw5ZMe12lcilwll7rvreCnk-3_-tHvE
Message-ID: <CANiq72muOR3T_yjzo5JocHOzcQRXFPCZzUky=CwSF2vyHw9KHw@mail.gmail.com>
Subject: Re: [PATCH 6.12 038/349] rust: Kbuild: set frame-pointer llvm module
 flag for CONFIG_FRAME_POINTER
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 4:21=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> [ - Adjusted Cc: stable@ as discussed.
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
>   - Added comment with link to the PR, similar to what we did in commit
>     ac35b5580ace ("rust: arm64: set uwtable llvm module flag for
>     CONFIG_UNWIND_TABLES").
>
>     - Miguel ]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Ditto -- a script got confused by the brackets + dashes maybe?

Cheers,
Miguel
