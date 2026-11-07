Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794054629;
	b=O+yPCmd86zBvF9Osi26JTG94auRbc2Y3SPnmbkWbSzWyh5gVewChIVR5FVzRm9ur/sUo
	 Xm2E4nkg6AmHD5SVhUYlsBGvreIAHtVOGD8byjkdQq3qGun70VMrnGyHnWgY6pk9ll2qm
	 R/pZrsoYmaFLhK4r7n1I0hEdk9H8cFYvG39WZsRaPGwM4IauP7PP4/JBNYXZr/N+55kGq
	 vnmwucnA0I8Z9QCDNIQV1v76s6bEKN0mwgdeeS/Pgbn2ATVvY9wHi9Gutr16eM3iLoh5s
	 1dQZDDpJ759wYLiIM2kkRQiE9gNfJWQF+FIe88J/0lEcJYa0Li+sQdBxhHSOeQG8WpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Lu2kFk5CdruTWYX7t+7vOd1DKJC/XAvUCcqbjS25Vu0=;
	b=weDZYxEOjYgOUTmrsouYp8YGUAWHTAPnPtKyHKxLfJHEYkwlHsOj5MAQ7ZfxmkHtl6sJ
	 GBcC3o9Z0dsqVkJuj0zX9GHdPZtCNjCi4im4hEadkg7/nDaAlQpiAlhKANLLGefSrsm8B
	 Hwa+vq4KoAJA9g/ZNuwAS8VUu7gM2RB9ihlkaPMnzw3FfNwqUdxezFtI/XgzWjX8QQLpp
	 FW60l3goA8x9xUPnlfs90/JtSxhQGMdnRnEpD6m0WCHjfCdtYnlAA8MI1oOJKqF9RdcyV
	 1HIOPitiqB47fFmPwdajA8tO8cY851OJILn0AIZoi2GAjo+2u5oUnd7lw7jY7m9EdSg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cc973wTZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AAF606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 12:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2AAF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cc973wTZ
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-37123334649so28518eec.1
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 04:30:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794054628; cv=none;
        d=google.com; s=arc-20260327;
        b=gM99HTNYVA2wEN1kjkuwcNd5LKN74Ks/vpmdAzDNqK+lKERGr1TTw6iOujfK4zN2YB
         3TSMYKXJg2pOW19TziFQEx3IZUIYPlNNiNON1Ge4rwUI3ulhQFVmCE5fzuJJiamAKjOD
         eJWKjW2zxK8eP5SAm4o2kJ6gzHPNeMyAbCiTJ22fGgANKmb0n05WcZaVjEL0/sb+ObkI
         gQBcu2HzQ5hb2mJDp8hO8yDg12cdvGCeNopvgEN+XzOPyOrsCnUICckh8jJ+F/L5la6o
         5fE/0sdFkh9WnvAi00Q4txay5PpqTnSOZ7J02VkAbtlgkNSKjbJuF47uyz5mac8dI9FB
         hRqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Lu2kFk5CdruTWYX7t+7vOd1DKJC/XAvUCcqbjS25Vu0=;
        fh=os/xi5fJ+09AyZDIspegSgKHgUoy8dqSqQG+qh9mbKA=;
        b=bFuRrZk3SKM2WkY1Rn79B4sEwunoD2YiELgUZAQO89KwsgyVwjtlKW/wxSwd2imipw
         Au0ZEZwM6ECBHadmfA8n6ob4ksnBg2wHgQFhvXJ1w3BgXY6veAp73IB7KuRVTZzOltym
         2hg/J0BjW8aJaOBFx+QYHBu2mTfG1OfeTjZaDtoh3yzEbgTXffkQOET+h0i9/AdlFwrx
         2gy/29nDLv+6I1k/YM+slKsEg4Skpxg1gNwjmp/TcIgCPWc6yBNNXaS5zqoCZ1afGi4p
         tapvDAg7DfFyQ5Qa5FBiEoDCdu6PI6HmraVY0CJmw4vvAOGhJyPqOdDCj5Waor48peig
         VNRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794054628; x=1794659428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lu2kFk5CdruTWYX7t+7vOd1DKJC/XAvUCcqbjS25Vu0=;
        b=cc973wTZfyHps8RaQIru89a9PINwcUc1qpqNUbRzpv28duIPAttcge5FNKl6THpBQ+
         anfX0RaVT21+u8nPCBLBDennh9QHmCJodT5RefTfs9zQVPl4AolRYNw02WJ9xoawbVjF
         jsIBlGffqIHK7A1ADJoIqds1d6UQ0NOwzxe2Exhdh3mBNPXK56dPMWRn0CW7vnRgFPtJ
         014PeSeflSVR9geRxMJci3KbGRX4D/fuN89m45FW1eC9kgEiz+noFIuELfq4NGLp/CH7
         Un64tB6rYIEJfTbuAQiCOBE11058tk5gRxTNiPrKbT1AW0UTp5N/ZPLD6iuMw3FXyNwS
         iVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794054628; x=1794659428;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lu2kFk5CdruTWYX7t+7vOd1DKJC/XAvUCcqbjS25Vu0=;
        b=HNhVUKPt1Wyt6hREZbZeWx3RRQcLvKqG4kDlb+TUbzwnr8HgBEME//8i+fslzrFA77
         u0szoLq0Fx5E2YcFt65BE7yeUrF6DhCJgmYhQlmw0PEAbzGT4dl9aOgraLDD+LSQUwzi
         xo6hVDuZITjoYtFZXkMSACk/gxHBffAZyINFqrwu3O6hI7Q2hp+Z2zvDTVagKS4vFOR1
         AqeSqoVgZKdpETVd1b4m3xChZvfZrxt5102vV2Ev5qFJsJf/O96KgO76RZVMU555DC2d
         GM93+4xjg7NQA7oUtV3FdjoOgT/23o9Q4wMGxuM7XT48ZQdET3BgpjYtMpYLX+9dXe2i
         0B7g==
X-Forwarded-Encrypted: i=1; AL+hErEkAKspyZsLYMqHRHHGjFBFDPx6tkhjTY6cWTrVBtm36xGN7ZTR24SfYbkHwkz1ldBku3RAJEA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/H6cBcKnMvqW2z0zfy2RDbPqAfrA9Hf/3poBnMUsui8eJqzbdi
	Lb3qHKovxU5MBo+N3m9/L+87IrhkdAwHl6G6sZga39aNR28veeMco5GkCDGbRPjISpfQz08totQ
	hauA3Ft7ysA7ZJYSYbqmD4eDS1kmYiU4=
X-Gm-Gg: AYBFou2SXd+T6srfweknCUz3Qf34ZtXZduIv0sgVmOqlnEadzbkWrRFcuCyjqZG1XxO
	ZMht49eUnW+Hcw0il2Xh6CnGC8yMYeAbAYLJkr0nhDLXSRE4X6zLI6dnCh6JLzpHkCh8ESGXCca
	W20ckhEtz1u/8WESW3iKYcGnIePN8zqQoJOdBkK466yUgZXd+5aGLtMvi3aMFbVSyf1lp+rSPbC
	MFS1dQq5x4CmpljZ0aoq6HddHsF1O9brJhxYzj9bKCbMOkO41VQ/2vMcsM3GI0Sv1A21HjHbA4F
	US9Ql+7pYRU4pl7e4uv4CPBjVm7wlssqtpufSzE4vv+1NmNoxFCEowa10zsGHiNwklhmD7cQpG2
	UR2BAw2WNa6QSXqZycDg6gs20wK5bvhhIzavslSQZRQE3V7FcVQkY8PIJNtzhy5YvHmfef3R1Y8
	pVcct+1r9oVCzc6Hoyf8Wv4s3A+jMHmKEh8L2SyGxKtqRCgL3kwm7noTKKFYi2OBJobEoQOZT7D
	lzBBJN+lx67SgqB5w0q3XHdo6r6w3j1pV5tFQ==
X-Received: by 2002:a05:693c:8858:b0:35f:ea17:d171 with SMTP id
 5a478bee46e88-36f7524bf37mr11414034eec.2.1794054627446; Sat, 07 Nov 2026
 04:30:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107055253-failed-6.1-6b704ec9007a@kernel.org>
In-Reply-To: <20261107055253-failed-6.1-6b704ec9007a@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 7 Nov 2026 13:30:10 +0100
X-Gm-Features: AclHuK8xFU6CdhsNMHZGn6thBaCPZ1HbWzOkHztqVub4xa4_fezDoBRnmlmj1l4
Message-ID: <CANiq72kw9pmwj3acY8_X49cr=H2q9Z=h4wAq6EahujQAYJU_yA@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] objtool/rust: add one more `noreturn` Rust
 function for Rust 1.101.0" failed to apply to 6.1-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: ojeda@kernel.org, jpoimboe@kernel.org, peterz@infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 11:52=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).

6.1 has Rust, but the version is pinned, thus it will not need these
(if we were to change that, we would need to backport others anyway).

Cheers,
Miguel
