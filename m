Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1924D6C3D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771996; cv=pass; b=khoailfWs69G9gI9clVkCgwPlAxC/Pe6xMdn5C+kvQ8qGAcLzHWymcjXxPie4N/UcPJ0hQxGfDW1o0PoaUM6zGHHpX2Gp+A27czX+L6ew4vbrgy6ppUsyQvpMOJ6G5kvi1d+DOkBWMs0S07wZLvjHSMH7yyWdySn+Y6Sk1gBwIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771996; c=relaxed/simple;
	bh=puIJOSdAjxGqRiaiV8MmV9MmKvzEIue4jK9dygO9uOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CudBKDMbwSon/vIacJds45GwhYZvs3iVA/P7VOwtUj2ZuOlkTdAVLbwZUNAynjhHTogJBBMeTI90BqMZ8F3oUwvpHKVG6AZDvOaJ+Iz/X2sutKmAFjXVEKfxkxV8GKifraquDCb6YXPUIlhJkYrPr/2ufXlFOZ/vzAZZuL9U4GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cBwhjtAM; arc=pass smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBwhjtAM"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso55293095e9.1
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 05:39:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790771990; cv=none;
        d=google.com; s=arc-20260327;
        b=ih/uxA3/yBTO+Krmzgtd0+onwRVWkTN6Dh6/LvXlhEdMTxfHDeiwsbZAYRDedrX7go
         4lE3/Iw0LQcKr3e94hjnafscAeUMaxWVBnmryA/c3C7mpzfMCUwn2sT1aWngCD72t9Ff
         HcTTYrSpCXy+aQ7XmQwy9Mu0W5NjlpT3Rc7ls/gaFQepdwBVcH2v7JqhLfIrrGiLfWjC
         6upKpqs7748j5F3k45FMFlEqsRXrWu+lbZNlbzs5yX0MrRbhXZI/RZjrmxHsYMzqdak6
         jOUz+0F3xK8gWGEMD/HJfkIJV+F7d4ISO0HBzT/vgD77/V2WH7c56ZtQNW+r2BX4cyrQ
         e+5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=puIJOSdAjxGqRiaiV8MmV9MmKvzEIue4jK9dygO9uOI=;
        fh=DYk/Dyg2lhXR3g+niWKF+K5Fr2kQW3CFuh+w7EILbZY=;
        b=UBeIhBkQXUq2g0IaYtjMYBGYLjxPRtLdAcC9GtTq264SMmdFEVB3kY2XylX7DrtR5a
         QfKXqaYHb71SR5D5a7IMUS5pW2MJFAFlb8gsG6ITkXUCG8Q+p7CE++mYXr63jVchV0R/
         0/7esNyp2WAB20lDCOEosG56shKixVbp7AD6DeCeirNfSwt74/q3t2ACoRdGoG2l5XF6
         xmN1e27p9miJXG8yIwlKu/jeUS5g90ZP1g3BcwL37X2CUAqsgUCv2w8OIvEVXVHVX1EN
         lI1jCGhPo0BAO46RN4ONeg5Q25uPRMEZUyu4B4vAYCrT4jvzJ3dHBxDXAvW9RQtp2V3l
         9yWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790771990; x=1791376790; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=puIJOSdAjxGqRiaiV8MmV9MmKvzEIue4jK9dygO9uOI=;
        b=cBwhjtAMFSdtVnG6LRzegpNIxy9hg8p60HgTCj7BnKMvCeDsJ115ZolPwKhdNlUw8u
         g3fCIDIxnj39GyepQgrChVrn7IAKGAklFHLRnl4SquKBx1lhh5J8KWJ2TlfUu1VrBCVE
         ufpwR6MdHg5LIkMWU+wgtg9fDnk0+nfx1c3mmq3n8zSCGax/ksSXTuny15pQ07nlcrpB
         iCACO9vmtuUehCBPuNz0Jgt3ICycQXb0q9F5XuCd0BjpcIUuYR2o5q6mN49IFcUWBJJd
         KLBhPiOOXcqg81Dcpbk2u43KJM5e9JDRPJZF0eRzKOtR6PrJHAUKwcLEOCiDcHt1q6Bb
         cWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790771990; x=1791376790;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=puIJOSdAjxGqRiaiV8MmV9MmKvzEIue4jK9dygO9uOI=;
        b=zEleOFsIRruxL/c8iiKD7dUt4/Rdves15JVT9AezTIOqYR9mNfFFgRa+wK/aDcXFUm
         o/GlNfrE6GnLXobLX1HS5hjeLNH/FDAMZK6CVeK3a9gncw9TZj7dQW+QCLtbI7chEI/i
         7mQMYh2tUaZ3ss5JtVW6jewWqqUdiws1ahSWjQsb9lalTd1Rh1R0UBhpfYhulrJ7n4Cx
         eVh411JPOd3ILOknSPOnBbgrmixW37ifVM3HQOO+Q+ErtKt/y9Hs0W3UV7OAPUgc9GPU
         RZoV9ex0/OO9+6TmottYzS1xvJ2lTC8BB+beHjWvzfskCZGTbZZD65D72daUikkMwdrF
         I9dw==
X-Forwarded-Encrypted: i=1; AKwUvByz3dweJYEZkqWyUbEK7w8JYWxtXIP9AoPLsAxaF45s3f4pW2TpaAjNIV2UxNFztGVMvD4CbVA=@vger.kernel.org
X-Gm-Message-State: AFuF++k9nDpe48qs/rVzVBpS6KHsn4k8dvpM6M5Bpyc5rtbi86dQBHfQ
	Z6wHGcz7LS2uBXwpz4ao95UG+CMHpmLIJmv5zVQkmH2qaAErKuCfrzOKRySWF8rAQiDznAmFob6
	VR04y+ndAXMVLnV/VwbucxVn4rlQLa+ZXv519azGG
X-Gm-Gg: AYBFou24mQoy1tmcKI0WYp+QFUIrrVyEZxn++eJG/q7gNiMLeiZduQ4ygOe/al447o9
	CM4KJvWUkcKNy8chxC8mgOGiR5n4pbKmF6WNhYvg2AXMMI8kF+F6ox/M8V5skfWe3F49OLAzMnT
	YU5s9Wn7bSI6eeWttxnV0LP5ygIr+uVzix77U6rsaFtBo3lz6mkqhnqXLSKP/y9UYxy0cUylOdg
	zfAf2kYLRtoyEeVV7Yo8J4EjO9tol5MVJDkI/x/JB4nD2gmWKVX7+wyEJybpH/bqmY1bPF8lNcn
	2BXpxfBEAyh/oSUQ18Y6N9sGHFnHnt7YbTou1SBVGa1hLVbVDer57zncr+TW4IhJU7/TSYwoF1s
	V3BnQsGeCrsrmLInRbiWpSNPKGWjqK0DhNW/isZ2M0u9OtSE7xdrSRYMwvh3lmUg=
X-Received: by 2002:a05:600c:45d3:b0:4a0:317:1996 with SMTP id
 5b1f17b1804b1-4a01affb6e0mr19906585e9.27.1790771988560; Wed, 30 Sep 2026
 05:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930123645.302318-1-ojeda@kernel.org>
In-Reply-To: <20260930123645.302318-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 30 Sep 2026 14:39:36 +0200
X-Gm-Features: AclHuK-nnHolXXuoRh47s39oDXL_U03hT_173aRcXTb3_dZm8vbu2krhGYddJ6c
Message-ID: <CAH5fLgi067ZcHT-F641tMZ-2cUN_7judeK_YTTrmX=OLqsNtnw@mail.gmail.com>
Subject: Re: [PATCH] rust: bindings: fix VM_MAYSHARE blocklist entry
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 2:37=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Commit 2b6a3f061f11 ("mm: declare VMA flags by bit") added constant helpe=
rs
> for the VMA flags and blocklist entries to suppress their direct bindings=
.
> However, it listed VM_MAYEXEC twice and omitted VM_MAYSHARE.
>
> Thus fix it.
>
> Fixes: 2b6a3f061f11 ("mm: declare VMA flags by bit")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
