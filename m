Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793989034;
	b=Wp5Yc6ibomxWsexdl0zSDDbbatBW4ZPsjs2+fiw9JX2RbFq6WhS8ZjMfTdhddht4+8lP
	 WP30x3Y5h0ipDtYsmIF3iaYWaWkfuUXoxLe4y70JMzWj3UFRc/PZtlkvAWYDR2EMYDGN0
	 EqGh9DTLEaaD8I1i11kciAMQrFE/gnvuHp2+2HvHpRDsyhk44nL595krPWetzJYvmcKI6
	 pVrXQA9GDukVDyxrOfp7p6U9mc/xwyfERZO+zlNFkUNhA3o2GfOWqiY+jSs1XIAS4893Q
	 x6h/vPry4jrltTOpxe2lAcy26GMw5PKxMHrBGuAzpoIcKVf1OBzxkLVCA7AEp8zePOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=iO2JEAydHDgBReyWjoaKwK3iFfajRHjkVPraMabJC1Y=;
	b=0QZo8jrliqIcXCijhAZGCiZN8gtOmJd7bht/1vcHzX8N5R3McOuX4hron0y/G7lwOyjT
	 NHyey8s7MXVQEoZbUceaWqqWjN/CK/SZFHftlG4ng13aEIB47ncwCp+mdke+NqI/uQJq6
	 +Dv4upaIw/m3bNFnyLdrnuR/I/gXXEpFT6sdLgEEBkL7THUxj2xPd0S1aCwp9gcas6/bF
	 o/CJtNE8ejJ0LuIO/WQ8OFMGd+/Y7Mn8jgAbdQV0RF3P+aB+nCUkAM/oZs1jpgGbuhsHv
	 SqZhfRSiK/CjJmZqxrYIppLNy/RH+o8+8JApfvYi57oQpWIm5gsVpVaKVd24yiLyNjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QXf+r9tS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C889606A33A
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C889606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QXf+r9tS
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-49134c8509fso840304f8f.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:17:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793989033; cv=none;
        d=google.com; s=arc-20260327;
        b=qYQAXVJnKlIKdF28he1eb9wD6VHfdSwd6V67rO11gf+B1ScN7ni0n9I1zl/F9YD2ka
         7bHtbC6KvqGn2UfcG3RSI+zr4789FY4RMc7NTdR/WiMIKMznzA1J+oyu8kTn+a/Asv+k
         0zXAEJNWnhQeg9nxgTqEiTL8bHlFqgFvA2PZ2dBHsiLTOOSd1CbMGg5i9fCrnLfCoiE0
         onmnO1MXIq2ZYrdwv05DtZvMeXIkQu/+aVlYRxqU6XI3jncv2QJpH1yQCttJswd4fj5n
         JX9nb+N0U8geXpI81u0/VU3YzGX9iqJCAZsRn3CW4g6N2G/dgZk2qMcuTSgqirMxyDFp
         aq2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iO2JEAydHDgBReyWjoaKwK3iFfajRHjkVPraMabJC1Y=;
        fh=BHx1jfpfsNw1lG2wL31eNRklKBCb19DlFI4vAoG5TNg=;
        b=WMfQLyFsBYPTx8dmn8uHbc6to+ccpqN1T/87+s77tCnl+6d1GUetoXxagrS2gZZl3o
         qug6OtI8NpqXlFWi5mOI7xEudQoTd72zpc6QAk1zjvLcCII0gcmKUd/tDuV4+/Ozas7z
         P7cJ1oC7wJUFssVMqU7xLq1sf0bBu05naqyvMLh0RLQHgf9fgKZd2RPXKJBnWip6Ik4X
         3X5Ft12SqV5h1M3Rd/0oTFvc2Ql+/KOfc6C+VM1oKhQdwhGcyUh8jGcujxaQXQ4e6nF7
         9TVyQDamLI9XiEdfTN+WXISo7h/PHqmpLC1Z/54QREAQckHrdnPqb1AiBQbkDeN+5mE6
         KEcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793989033; x=1794593833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iO2JEAydHDgBReyWjoaKwK3iFfajRHjkVPraMabJC1Y=;
        b=QXf+r9tSK4HAXl26QxvgyqCQhrcdRmvDWopljBqKvTDaenjsjHcUXtknxTjaXPwC4N
         qLXy+sNmLL6j3Bx4kgjWPx4mLC76qd1R1G33/AFQx8kO9pdmOTW1bE/Ij1pM7SHCHJk9
         TFtWZCG0vPES9U7B2wLKCkql6hAsLvqSCQpM1OiT+HZY8VJtiPAoVrxWuO/mRNZaTyUf
         rvXdz5oG7EwZx8LyO41SK6J1Lp6GNxfRUOq0cIt2Xc1YaeHGxWOEb3m3j+69QLH3wcNB
         yGi9ud5aQXCyQQWyXXfMsttWydJvTkoZiwhFxuoQZZDVpCUTM5aFP3UiKtGLnYme6uDm
         r4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989033; x=1794593833;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iO2JEAydHDgBReyWjoaKwK3iFfajRHjkVPraMabJC1Y=;
        b=a7ND+SampS+1FXzhImDsUir9bUaGftjppMYUoHkhDTtZbSlBqR8hMBq7hj3S5Pnuic
         x4NUPq54J8BY8qJCor87/RcG3ouMA5vOc9hTRW01JDbvfw51HtIBgDAbZrWkl+C7KPFl
         y9fZ+vtumL0kDp6Da6KgNo5LYgN/UlcRdI3y7xxVJZ3A8Q75IHpkVSWUcUBKY59WF9OC
         UUa24Xsl1KoRYKC4bp+YnrSMTr+fm2v/RR4/rDgFZfvoI++ITLA6ADpJeav644AVzc9K
         bVTCMJzv/7trPyT9Uvb9VhTsxWq2QXecSEj06MM7RVs6KyAM3Q9Rc+Uz2QcW77YKe5S+
         Q+Xg==
X-Forwarded-Encrypted: i=1; AL+hErEeqftWPvSW7v2BfjwxCfZ+D8O6zlujsR+g3NrvEhoRFfBq4Y7Z3OTIEWfxJ4z1/oqBYb8e7Tg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bWPSfr3rRQAdBoRCLzM+iDG5A1D3rKspaK2bxQ/6/w7pwzRB2
	dWd+ScRF6qD06fdl+hlICAPBOv5vUKM/ujIwULmMdlQM72pnTFCUHPsu6pTDNUebK4+wseNYgho
	qZZIxU1zpOzAzd/zYSeF4OaU0L9Zb8xIq1nNeDZHk
X-Gm-Gg: AYBFou3hcj8foubBx+Vcp2wJqo5VydnDcUgQOun3A1kFi5PNvxmo4Kg9tGXGn/KYaqZ
	K6fwEDuYPrZUKKjXhhTtPL3IalTq2SJZ0SRJDtZXQCo9D1LSB+/EypB8CrledyRKD9lqJ6Ihbwk
	dsNTH5PnGgLkUAd2Yt+tIcICQ858F3dfqRX69IXcELXPPRB20pyYhjPkSNpXu2I2cDOZnkY5Hs0
	p2HRa/loJL2opIuFMRitwF5tV/McJe+FBtWjXrM6ukUyt0OZf6yiywRmSVOTA2acW+LkAcyfKQa
	3YFuZDghVSUdX7b92lPPjfCR3WS4B6h5v4ICRB5boT+TG9iaqy6TuZI48EfRDcJ7+kxcoc4actf
	TDoWX8vJMaGvJtiqWZvXVqGmAPR+VCIUnJ/1/In1opgY2AjoL3kLdVoOYKhcdBCFxPKFjKNNwky
	WVodE/YUaC/twS3ELhvXawd0Ony9o++oUp7LLjRi5yz0I9av3O/3f5UHhNGJwpROLL4RLEyWIEu
	Cq8JFZtXUK8+p7sDuHHUuYgcH6Ab8fD1QTwQqn80c7l6+j6SsRU2temynI=
X-Received: by 2002:a05:6000:2892:b0:48d:c186:dcc6 with SMTP id
 ffacd0b85a97d-492777dbb54mr6867359f8f.57.1793989031973; Fri, 06 Nov 2026
 10:17:11 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105151159.1.I0b27923381ef34cc99cdf8b65fea2e1bafce6370@changeid>
 <CAF1bQ=QkGntJu8G67ssH2dS3Sn200_JuYitjtAfNPBu_hn0fZA@mail.gmail.com>
 <CAF1bQ=QiP4fb-+Kn8wzEH7wqjAjZaagxUd3sYpv2SkwDcnFPWQ@mail.gmail.com>
 <CAD=FV=WGKOnDoY1W7CuZw=s3e8f3jrXzkJ5_Qp_Y4WfT0XwXDg@mail.gmail.com> <CAF1bQ=TWZ=u1h92Nt9NgGcaDNTo=BOHmUp1DCWEeUMfwBb3WhQ@mail.gmail.com>
In-Reply-To: <CAF1bQ=TWZ=u1h92Nt9NgGcaDNTo=BOHmUp1DCWEeUMfwBb3WhQ@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 6 Nov 2026 10:17:00 -0800
X-Gm-Features: AclHuK9SWyCEYtuJGMl-fJhTBaGxGHpWXefZx7LtX8R0YzDCJePA2Pf99_IEKbE
Message-ID: <CAKwvOdmTaMQf4Wyk_sygaushmMd9dRR3xPZ6K9rbKYB25uz7jg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: AutoFDO: Disable Profi (-fno-sample-profile-use-profi)
To: Rong Xu <xur@google.com>, Doug Anderson <dianders@chromium.org>
Cc: llvm@lists.linux.dev, linux-kbuild@vger.kernel.org, 
	Han Shen <shenhan@google.com>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Han Wang <nesthanwang@google.com>, Snehasish Kumar <snehasishk@google.com>, 
	Nilanjana Basu <nilanjana.basu87@gmail.com>, Yabin Cui <yabinc@google.com>, stable@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 10:13=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
> As far as I know, Profi is enabled in the Clang front-end initially. I
> remember reviewing a patch that enabled Profi for the Rust front-end,
> though it's possible that has already been merged.
>
> It seems strange that these flags diverge between C and Rust. Could we
> add a comment to indicate that Profi is currently not enabled in Rust?
>
> Rong
>
> On Fri, Nov 6, 2026 at 10:06=E2=80=AFAM Doug Anderson <dianders@chromium.=
org> wrote:
> >
> > Hi,
> >
> > On Fri, Nov 6, 2026 at 9:43=E2=80=AFAM Rong Xu <xur@google.com> wrote:
> > >
> > > Just one thing: I think we should also have this flag for Rust so Rus=
t
> > > and c are consistent.
> >
> > Please see the commit message, which says:
> >
> > > RUSTFLAGS_AUTOFDO_CLANG and KBUILD_LDFLAGS do not need changes becaus=
e
> > > SampleProfileUseProfi remains false by default in the LLVM backend an=
d
> > > is only enabled by the Clang driver.
> >
> > Is that incorrect?

Probably better to be explicit, rather than rely on the implicit
default value, which sounds like it may be changing over time.

> >
> > -Doug



--=20
Thanks,
~Nick Desaulniers
