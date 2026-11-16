Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794855972;
	b=YTF13wUCugKj0AlrNEHSA2AGbJ3A4Dp6IAcQfE4+BYl02u/YLqk5GePqkV9mcIbPdrz5
	 lG/d/rdR6hZzaPzw4X5rUKh4vw1ABb9pDJZzb19+zfPYcHADuC2itxveADbb8kVtpRTmy
	 7S9+Z7S4HUUsNn5cnquO8lmA4ba9b1VDQGz4VQdJ6Cyfy3+jEjOWP275Bs2xv2nnjAzUT
	 nNqRg5nuu9/Qwr0BJge1auG1DP4QU0D3J4GteDapEj7H0gPUk0Jn8Hwwv4osqF0j9O8lR
	 I+mayLY5tXQMsPWvEGJPJdLNYHPAsBxE4FeSiXtkFhIFrnu+0g0BYbiCybuJmCWKdpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794855972;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=G7I1SlfQuGFwSPm/Qi4+nTEZRsPgA0OBSH2M8WIp0JA=;
	b=uRZwHSNkraiPiGgxp2ENQdTwkvR9blZWkPvaCr2qun+0sXR+GNr6wzwDL0sj3L0ifLZu
	 NduYUhAdl6MP8bHR6nCVpSKMcaXx0Vi6VLq0lPTZCFnpYaKB+ZjFf4VUOzze7KOQAQzk/
	 HItIZNlSs3YmTIl+l0qhvpI0PZrf3njwcYUbXREPbwAGvXw2DylEAPBzBgU2Ju1d2eAqC
	 /mzrmxkzC8zOsB3sv8tOAEpjHzXrKqi/9cSOB/Nn17J+rPx+GslmQyidLagldZHz+4Yif
	 wYm7gzXM4zMElunNFFvwKakmgG7jeaX/5ohx0ZxYE6NVyqyAyZUx297tpeSB6oLILUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=everpuredata.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=Jm2Gk8kj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E2D606BA33
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 19:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6E2D606BA33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=everpuredata.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everpuredata.com header.i=@everpuredata.com header.a=rsa-sha256 header.s=google header.b=Jm2Gk8kj
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eae1276409so1406507e0c.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:06:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794855970; cv=none;
        d=google.com; s=arc-20260327;
        b=l66eQQaaofyfYSDgsEh/sJb5peS8Idjm74vEOeo0ea5FW0lh1pTBdIpcfD8jPbsYVC
         7xsny+PbsdoSaURG9NCBIg9rS2+yOnt4KW4bviUnJ2iDcHkj5xAuDlz5oyI42gBpEPM9
         8vCwHD++bl8WlqDRvcNoMSfPIRgbDD6gOTyoNSVUcm4PvQ5PFzK8J+2iEU0CzoVTLKdf
         VH3Yq5reHI0w6qh8bDa0ApkOURgVCMy6QkQj/6pm+1eUTT9AEioOYD/CwTjZuu5X17aS
         Mt5Grn7jbxafkiBOtBfSHfDLsbdILOfHH7n1MekPdzslyJG2pzuXL+8LQK3IfWiqASI8
         tjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G7I1SlfQuGFwSPm/Qi4+nTEZRsPgA0OBSH2M8WIp0JA=;
        fh=q3AdA9DbzqcL0mFIvmqOFth8pJmRV/0zARIE8jy13xA=;
        b=g4JulFOCx1eNxzIZ99BlgwIXMEkdZAFGma+nCm9t0iUkxfxxo153puilxK8dVdgXGZ
         YMhbHEhDhpxLO9/9NvXtOtfzf5yx0VPmqhGTf+PKEb6RgxdJyP5TNLZiQk4P5Re93ZD7
         VUMvAOpoBAiT569ynhnj+yKWoUwqcXoSoHQKDGYhzkMh14dZW7fmhgLUfJgLrEb+ngTZ
         PrCls8n7jiU15cwTpHqHgICwQHzWwzz0jBEKBOCyIyWvIai8pdWmtwpU5sX4oWQTHqeV
         3xYTY2c2iJ1pJ1pJUI5qR9bqf7NfD+pUkJ2bUbyOwWMF3ef1JvDQs4d9Derpoa42SAS3
         GZ4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everpuredata.com; s=google; t=1794855970; x=1795460770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G7I1SlfQuGFwSPm/Qi4+nTEZRsPgA0OBSH2M8WIp0JA=;
        b=Jm2Gk8kjWWwRV2Oi1KDcMVKvvo2dKssVrRlht1w65ARIvAvJHtaRkh5gALMeNGFexR
         j2tS4wtXZv6yXg83D423lAlXUdUogfBCNoql26Ht2pY9lBro3u2idDSeOaZkduUKxiwt
         g8cTxqxbDTTTOvMQZYgK5qFPiJ0jZJY9+JwRFURRFaoYKECLPDoGE9lTtLEC5ClMw6zQ
         W41sm8KufFyLvIFlC7ApPY7fL4TIZGIgN6ckkuKJV1IWh9KX4VRJ9wg60OI2QVITa/7B
         h6XBilkVxUviYZ0x1faQAS+D45VQIabR3Pm3OxpAR6OX1tFpiMiSDb/O757nTsQGAq9T
         DLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794855970; x=1795460770;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G7I1SlfQuGFwSPm/Qi4+nTEZRsPgA0OBSH2M8WIp0JA=;
        b=AqTfar7YVZEJ2yWDgWUOzMOCYnvCfUf8Gap/hFG3HXOrzbKQ3yWdXHVKP3/MAfZ+23
         ZV0YigvrGAn1WeMiFZj8jAbAVZ6e/KO1YT2jS8m7nXXkTW4m3X51fGAxcw8Z3m/cWJb9
         C7sQX53JEgLqSeQodheKwSBvyZQ4izbCqMeGDOntWTute1r5F/i3Pi0wF0vlC3FrrpV3
         iJKwFIfwEYUsMV40B6jxwCSnANZL3lbXYg1TzeUTIr+msiDavsBJZcTHzAt4HZvokZRQ
         A3ud1J6EVVPz9HGr8SS0zQoVfRJ/NYj3yWlMSC/fdX7V9CtD+AoLy1FW+P0LXPSpdCOu
         L8fg==
X-Forwarded-Encrypted: i=1; AL+hErGomf8/cwxwnbDBd3nx81NUxoQZihwZR8xPTzRae1+rsYomgAqKyTGTPlI7oep7hBzY4c+i+dA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Tc6B0aRFmNk7EEA1QlIZuMQTwF4efexkpkOILM2GvGNOuTjLd
	asvUsbpTuHtKFPcwLODpY40Cy5pFJvdxST3KXMRuI2dUwfOYgLbZEXbHmWA5Z6mZuhZ18iduntC
	yHTpdd05IYFaCWDYrIavJXINXjEIAX+1n2OhhjyWZyA==
X-Gm-Gg: AYBFou37vGJ1XE+KJ/f2dS+lx4avkkzJl7gEh+DVMOpEQTcl27jaiHt52KLnHJSy8Ie
	jbam/RRHHgTr1TL9CSek2Wcqo/Ka/zWtAJpaQQanHxIVKAhsuTWIYCUXiPza6FfBVwqBKJUC4L8
	2Phy59I6Q1r/ojg0QjFzpp01Jqnm1ANKzuPo75JnC1AS/p3F/VNu1ElwLHkj5MqcDFdEt39qJeL
	zzWg9ALiPOnNJVYZ4pS4pyZYJUxlBIUHs8uOSOFmhztjTUFmn/z8jTljD7BODNwt3GKswGY4E40
	uq/vZJ3+Vcc103Kwa/4ZNGNE3fKEzfXkPvsfPYJk8zqR7jyQDNti6Un75J/bzbJVQqMxB/mlYrX
	XLdfolNnQawXRcmUbshxo3AdeYbWF1g0At7PCrGlkRlB8xHRYt4i5TW57zVVRrkZERsvdtisRSY
	TLDS3PmwhsZLdQKqz8pVOTbaMWi+DUn0CnYGIQT15NrEaX8V1Xgj2D/iTM/N1PwKtxmA7bMY50K
	fv99U0jIdgvrcOkd2TQLzfzYqCgjgIedB+/ZC1TAwHEfEI=
X-Received: by 2002:a05:6122:1b10:b0:5ec:4a13:8aae with SMTP id
 71dfb90a1353d-5ee34a9298dmr3969191e0c.17.1794855970467; Mon, 16 Nov 2026
 11:06:10 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116190111.3317976-1-rjethwani@purestorage.com> <179485574283.3291.7349043137994808253@kernel.org>
In-Reply-To: <179485574283.3291.7349043137994808253@kernel.org>
From: Rishikesh Jethwani <rjethwani@everpuredata.com>
Date: Mon, 16 Nov 2026 11:05:59 -0800
X-Gm-Features: Aa3M54o7vX-XpVUCQ5-uuaPc-Fmkae2NyST6GEXFL4X2HiaIMluNfTh_m5Er0I0
Message-ID: <CAKaoeS29P8SukOACusGaO=7z13_eFR5pFWDjbYqurgYd2bVz9w@mail.gmail.com>
Subject: Re: [PATCH net v8] kcm: reject TLS on attached TCP sockets
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, jiayuan.chen@linux.dev, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Dave Watson <davejwatson@fb.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 11:02=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrot=
e:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account.
>
> *IMPORTANT*: If you do repost (for other reasons) - please include
> the relevant info in the cover letter or commit messages.
> --
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Found by code review. The sleep in atomic context was reproduced on an
unmodified kernel with CONFIG_DEBUG_ATOMIC_SLEEP.
