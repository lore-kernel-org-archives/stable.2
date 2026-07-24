Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180A5423770
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889829; cv=pass; b=m1xVOrH0GYNbVeVjq5l90tw0GXPpveJDIbL7MhbOXqvUm7yZ1Y7c0AnY2XzakdlX3EoBBWdYXCSJeq1SkYdU2l8I1SocYkVZBDy6FY0U1mik4VREfkw86nW0KqOB4+C0BqpYmYlZWj2Ay51bzvSIpXXO5gyRn5K+CZrKF4mhiuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889829; c=relaxed/simple;
	bh=5zjfyufp55cUafsB5TW/gzWxPo9YnjRh+gz6mRSML90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G7lwIYK2yhzP7Vmd4SMwif1siQpHxtJCDmBe/lqIzPPBjXynGhB1/KbGLD68PFVxF4v9o7FlbR28bshmDC+UIM9G9DaJ1eB0b2JawBScfymaNj+XqjfAMd4HfIWKQQvSOOoRne49SlPhks3rKEN2GnwFzhhjJ1avPZrtztVrEq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYo0u6g+; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYo0u6g+"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-69a33fb0031so38593a12.1
        for <stable@vger.kernel.org>; Fri, 24 Jul 2026 03:43:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784889826; cv=none;
        d=google.com; s=arc-20260327;
        b=Oaxrh4Ycqe7L5Z0ZlnlBUKTVf2AVwiFdpJFf82deNmIAOf0YAZ4KF8IamgOeLFs7oh
         a8ZgZcTtrswU1CWKicGpgLimWPZQBn5h26o77jKYuRRS10Wi6TBQq1wra0mhB4CryQOT
         undl4BxuxtSb7k1zQXbHCNxBjvTiUV1VSyFSZTHrvYneh/A+TEanVCRtrRAvMtBPZSlG
         59bGxOQrCdPovSmWf1XlaapYr2BloamgeMxvcWdRHK+rq+zIizRKeR1xvGrSoG7LQ/Rp
         fq7nV8/R3Ilf5Jju2dSWwyRJPpsUiFvGhqNYb4mKC22gBNrqlnwpKDp5QdZyO1W1qRCa
         jFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5zjfyufp55cUafsB5TW/gzWxPo9YnjRh+gz6mRSML90=;
        fh=FMahyrEEm33wiFxrgWjDhUkEBjb5ZEVnhm4VGBmWHHY=;
        b=ouM6Sjb63hVMtihQ587UZQPMd9A/VmAHJO+7WuYAE9l6fgv4N+h8U526CzWGvrHEj9
         hLqM5IDdiNFgWGxV6/HHirCTROPFz1gHD8SxgnyEHQ+AfeOCd7UMO097plKgiZRyvk8E
         +Pz0aJf4K9mD0EzhtWmr6pbzQLkCAiBcXHIY3xQfkldDXLAkqcdsj8adc5MGgAE2zq/5
         Y1CDj7TYMKrVkSAH/EZd2jwfYGezkO1NJfsOT4FYffnREqQ+Ktfy9dyZyoYGPpV0zhMf
         q/hdYU1tPh872jQaou9k1/RxLujsMkCibmnuJh/GElOIf9cjm95+kNAcyAK1os5rnuow
         mwgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784889826; x=1785494626; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5zjfyufp55cUafsB5TW/gzWxPo9YnjRh+gz6mRSML90=;
        b=VYo0u6g+ZlXejTwgeQp1hmpxlhdOFiBh6LXBNM0GcuKMaUaryc+CKy1SYV7Y6aVf5u
         OmtnTh4pEK2MQa2pDJNXPwQx2WQcuWP32aEh+4HI8nvdWWRjFRuKwvXs8JZd+oW01z37
         pFboOTUKL2TTNboj4DJbg0hWde29+5nRB9CD8bLNqGDFZn2mMc/Y4CWLGP7fxaizMpim
         OFGtDvF0BmAG+Rr/THtJNktOtKlPuRCs73C6pXRZWHbJrku67qLx0Cfk3PTtdYyiBNVQ
         iu6KfeilKMz5Yyr+tQAnY1rQwKEnzErvvBooA2j8X8C9vFD7AzQexU+tsG87gdHrJW9+
         54WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784889826; x=1785494626;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5zjfyufp55cUafsB5TW/gzWxPo9YnjRh+gz6mRSML90=;
        b=EOk9mXRJd3EpBs9+xOMVC/zwS/3ijRhVEydSpX9fPAXTILTqDyi6vTHYj5q/hc9gL4
         FvdrktT66An+Nzh98wLeZ9hf3owzM2psXFkiMDJ/wQoeG0H65Grg3Qu6EANO3m31HQGk
         3hj5fD7b3KjKWPjj+cKIVYxsYPuaHItxkWbLW4duohMfZQ6lPePweklY/aaeo5XzgLRL
         xPJZp/cUjGGfBcvs/Ykd7OqoeIShXIYPVlHz4/PGc425Uqrd37V5aTn6bNfG7Y5P01e1
         /SbhsdDs9an0U/adChb+RQIFVCUtP7MWCo5hY+2ToIik3fGCAi7o4rwd23amaJSvwg0k
         Sj7A==
X-Forwarded-Encrypted: i=1; AHgh+RpgQbvO7LwTJp+aMCS7r+o/feHfaj69cIQXLv/PIw238SJogowQ5ADynUD8cw1fVXCATEQOcCU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/SMHortMv7t1Eu87pV6UHE11RGUQQfkW7qVelETpQe3uIo6+O
	zVmkH4cab76eZWAhzYKTQVcPXhBazOVl0ePLZIqdbsZTbUOn+Q7U6PtbqAVq+qC30ZkSyQ0yxNj
	b6wv7IsSvICNtmiHERHgTz+LOeFOBEy8=
X-Gm-Gg: AR+sD12UB/QAvO44Ljm0r4QJojk3ySu9V4aVx9GAFH9ZR2l7JX9BhblOgHmMbZwRme4
	SGoMC3QPPt0WPs2dR/fLvvGOqMEVz/SjL2TLy4VaAe+tEOionSaUL95xYDNrIx61UFnRmU2Sib2
	uU1RuyGV0O3ATBevj2dKdTFDZBfhPjuWAxdSryHCsbPzzPQ/52UowfK+dy/Ef+Y0Hl0i8xPgjyP
	ew0Zu6vmec8+PimPnNdPuBXa013zyjfPL5luVRh6BoJuVHinSZqh0F2nXAc3hA01xXgzOIZvk/K
	IjxH6RccXFZx530=
X-Received: by 2002:a05:6402:5388:b0:698:81d7:b812 with SMTP id
 4fb4d7f45d1cf-69f8ddc0d34mr814454a12.3.1784889826059; Fri, 24 Jul 2026
 03:43:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
 <20260723162602.3275661-1-nicoyip.dev@gmail.com> <20260723100030.3eee6d51@kernel.org>
 <87ldb0lo8t.fsf@cloudflare.com> <CAAo+4rV_5B-KOQgPL3BC3WKGa_otkEUXD=wDjCig9M0Se-mYtA@mail.gmail.com>
 <87fr18lmzo.fsf@cloudflare.com>
In-Reply-To: <87fr18lmzo.fsf@cloudflare.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Fri, 24 Jul 2026 18:43:34 +0800
X-Gm-Features: AUfX_mxnlnSFi_yV1t_Ui--j4AHwdWK1tce35HMxRExxAoQFSSo6xtrsHUCb3QU
Message-ID: <CAAo+4rVrB-Lv4MfaaH9sbosbOPFJQy0_UaDcbu9tLUFoGtWnvw@mail.gmail.com>
Subject: Re: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 6:07=E2=80=AFPM Jakub Sitnicki <jakub@cloudflare.co=
m> wrote:
> You need to resend v1 with "PATCH bpf" prefix for bpf CI to pick it up.

No problem, just resent as "[PATCH bpf v4]".

Best, Chengfeng
