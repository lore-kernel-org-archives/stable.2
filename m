Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795286059;
	b=of2figN3RCv3E627o/mLgZaTyasaKxDeg+2iosKZoD7yAKuPtVdnrHZTj5aukbF/RQXY
	 bFagTtJwGkwX7POg6I8aNoO+AN1bTrjC35G4IsAlkmDi4+zdLSRa9qO4U07tCRNnNHUpS
	 +vtcx/d2sUVoqQi6Hl1OH35aL0dDXcbQmvc4P4Boki62UyXBmWFReV48gkIlQ9RshoFsa
	 CnDyIIYIIqZVbfFqfCrTvHgG9Al7VMV8+GyRhwxbQPe/UIwqLwFUfhwe5+GevpqoNvogc
	 3jZ1eR4+UJsifQ8O6UiJoLJUB8Dm367UD0nst4UJiS7VAeSjX/g9HSOzTc9jmYK2/5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795286059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=pZwAAsxZcP3F0DIRuj83h9LceocBWHM2k4wu68EYJlk=;
	b=a27sezvclNYvzljFoXvdrFvReNNNgsmK/EomCUAfzeTwVHGlw3iLmifbriFImL8IRvV3
	 ySSP2h29rAQnr8rPcuf8AkfsgQWD1hPpjtmbw8OYIXbqDkMDd/ACJYKEUSCbozoJFm+q4
	 EHYOGQzFlJdf9F8atC/NCsWahB0FJ+0XHVFlRQSSkUI7z8VFGwPO/V/JFar+c7dXwX/Z3
	 1aAQm3Q7Bf0/690Y6P5tpOPhM2wNjyuSeR6Xzjo2l6JwqY9DnGMwKSyY/vXMU97PBzEvF
	 BEkuR4rUS/bVJuKIfH6Xkv0PM9cWMV602SXWW6LBZpwSSTTy2KlfWWawNh7uUdHKmuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ib6aRbCf;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71602606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 18:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71602606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ib6aRbCf
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2efc4a84e75so29995ad.1
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 10:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795286059; x=1795890859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pZwAAsxZcP3F0DIRuj83h9LceocBWHM2k4wu68EYJlk=;
        b=ib6aRbCfOGwQE6/BATIR+ceYurjtyrXkoCQHVhE028ha+RoKuL8pR1qHFqJyREFiKp
         z8p0CuAQU2n88ax0i8wGZlB6nXui7WzmCSc2h0hXq3v6IsM2CXQWpqyyv1iALwoW9ZwQ
         NvataTs2P5rQ8WJAEEhfk4cuMQ3PG9jA2yrPBuWooin0pTdFTUTZ1coIiZTEa9+r7lfk
         /QPClRGwXRDRWTQToXdR4j3aUxsV8XrJ0tuosKcEP/cfY524JSaePMdH0+JNm6/o/sx7
         xw+9VJpw6BCTn+81JZihzC1VDOlc+XArW/7P8L2u8Sv1dC3L49WMbrDg/NKIXjBupZvt
         KuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795286059; x=1795890859;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pZwAAsxZcP3F0DIRuj83h9LceocBWHM2k4wu68EYJlk=;
        b=i9igdzb2mY+InU7OHF/XQnYmvyhngw33s0oEOwY/DeDW4WaE7QFr5tA3EOo0wMD7tO
         b25wsjM7RTUh3hg6il9iSzX5poL/PurLcJk1x4jnzKIJoBP50fD63Zuo53iUkaf+b6Ei
         L1ALUB6meG+LlN/abjPh3YdfBWZPuY5QH8F94ratFx/E1A5Dr8vO6/AP9KMNYprYNlYG
         I9IOlbOzE2ZI28kk3aumhXNzA4uhqX6hGAfFjLV42XId5DOZNQcWh3718xHIsfUjCjAC
         PrsJmr5hU+fHtgL90YPiZC4/hBhumhhfYwdMAoNCQLF5s66VGKiS9V+yG+6dNoAY/j0m
         WYVQ==
X-Forwarded-Encrypted: i=1; AL+hErHJIj7VsIAO8BNpadIE/kgAr9GnNNyzPhf952AZI/SZH+f7vzlq+WI9ZlRJqbF4JCcxchd5NqU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9A4HtotHaX7cT/Vo4wP+L3nrjV5SRq2BHO2BKJP6xYM6ZP2zkU
	LDMMai0ND+lQEmuL3aw86qxHb5D3dBbY4nPF/FnptpQ+vMUi7tte/LfoHIJzSTfqhQ==
X-Gm-Gg: AZFdTZfed1Ho2xFTFcF6ysuMBT4SKC39biCV8RXM/qPuALDTFzf3lpjSEXPWxEEdYKM
	1mrj+6eD3YPdnSVIjCH+W6XVIJQnBLPCosKTU/znLFVamykEUDCI4IxTFRVia8C4DwkxzA9a/pv
	c4gdEDaKH2xKh0+kx9DwUNrRqNtb2elRghwbXc5f+lqSi6DxA0hed+Ax7vROmPUXX/V/DBCeAv1
	6cS4AmyEUl4/+N1lG9lAMdZEl6T1imYY1SFqLl2VYjKcofpsU8lCO9Sfu5zYEof3IQtW8nNB7rZ
	iT3EGUgQFjtbhmGYrCGKDm5xltsy4895qFF+dqanZQfgj4dmfQsx9CC6gtg3aD+BfTtpPUB58jh
	H5HVwgdEDctCjAh4Y/7Yqhsg76QR70jIGiF9/WfFWEe8Sf+pUq+Tct/rYjmJPjPOQRP8Srq1+2Q
	AHyzmFN4ldw5g0McJt+BXNI4cv685a4TXPQXKSwhN8qn/SHKQeLVbALpcE2KXO3BeODvY3mDFLu
	QJaIQJsVGrZv9w3uoPSI0tZlgoYqi+iBpIq9oKz7l876dOTB0MOZ+ZDvjVOpdjchcfeF0nWpKcY
	QaI+lE/7BSHZYtM8D8VefGdDMhDFw4sjyPGjzx/CUH57ySXJiFTxbil1LAeEjXWIaZYMDE4J4/Y
	OgBQITEO6c1YQntuSwbEZYReinhooR/iCe4ZMsG6KduI9oSK1Wy2M6p0rBdKJv/uTETdTj0SQVj
	ywAq5Iwoswar0nFv5FBqvIsrOltrHVQhZeEU+gR/CNCdT7epB4bvxUo6rKuJJfynt43xhg
X-Received: by 2002:a17:902:e950:b0:2e6:12af:5b04 with SMTP id d9443c01a7336-2f0615b8824mr3806955ad.0.1795286058213;
        Sat, 21 Nov 2026 10:34:18 -0800 (PST)
Received: from google.com (130.155.125.34.bc.googleusercontent.com. [34.125.155.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b6fe711sm2350677a91.1.2026.11.21.10.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 10:34:16 -0800 (PST)
Date: Sat, 21 Nov 2026 18:34:12 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] rust_binder: report EINVAL for unknown handles
Message-ID: <awHkJIAjp7FuTxia@google.com>
References: <20261118-binder-unknown-einval-v1-1-ef4ece277b26@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118-binder-unknown-einval-v1-1-ef4ece277b26@google.com>

On Wed, Nov 18, 2026 at 11:25:40AM +0000, Alice Ryhl wrote:
> Currently unknown handles are reported as ENOENT, which userspace
> doesn't treat as a fatal error. However, providing the wrong handle is a
> fatal API violation, and indicates UAF in the userspace process.
> 
> Thus, change it to EINVAL to match C Binder and make userspace treat it
> as a fatal error.
> 
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  drivers/android/binder/process.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
> index e97213250beb..406d80cfff08 100644
> --- a/drivers/android/binder/process.rs
> +++ b/drivers/android/binder/process.rs
> @@ -958,7 +958,7 @@ pub(crate) fn get_node_from_handle(&self, handle: u32, strong: bool) -> Result<N
>              .lock()
>              .by_handle
>              .get_mut(&handle)
> -            .ok_or(ENOENT)?
> +            .ok_or(EINVAL)?
>              .node_ref()
>              .clone(strong)
>      }
> 
> ---
> base-commit: 917fcbf033154a6c8d83cfa6c88f012b71eb37b2
> change-id: 20261029-binder-unknown-einval-10407d1ebb1e
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

LGTM,

Acked-by: Carlos Llamas <cmllamas@google.com>
