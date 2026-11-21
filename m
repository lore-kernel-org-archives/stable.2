Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795286204;
	b=uRTgb/BQwd54O3qwGn6dCoI30W51OCmS5YMml0DyNKxFQi2JaQ5jc6xIUPIsc0bpkui3
	 JAlc8l26QRuJSYbPhQ2ce5KHAK5hp3677g2wN0p8gIY4GRjIdd0SZXtSzLTugPjbYnVqN
	 VNvdtg4+HTExDWOqtZaycvlz+mS8Okw0CW+u90iCitP0UAI3XPj/zmW73TevZYqVWG/53
	 BK2mUqTurFiMQcgZBjFaHmCR4YeCullHS4i+jy2/EH6rPimaCcDYiyYqFY5xaD4bLyOr3
	 0yM4CpR3fOduJyouIJvqRGZ96HsdV7JkKsvcAOuf5V0Hd6uaUATN3bSLe85Wc1wBf9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795286204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=+ww2YgpbwqAsCskuaPEB3Im3FqWoUKfW8X2evO7N+Ik=;
	b=j8f7sARFAaXHUuBNX7KGRZ3sJX23cF05a2v7lWI3IbLvZBZHrJbY8sZZfD13j9fAN4JO
	 ThRHMDqOMnZQrbqHnpS1j2X/IlHVX6QuS+YpdRNNlljXiTT/Y6/cGctYbNjtfKtjbPae/
	 j9u/6UyMIXhmJhEAoN2HYDLPgd3gtBJI7x0PwGAsRG5Te2GQIzBV9CoXSed96m2Cje1P2
	 U3nwM33XSIObZW5azdTw0UyuduGThw1WY54HYa5np47U0SUCbbm7WaySmeQzlLdpV0+zc
	 11AUAX9SDo9tiM0f5RV/P3ItB8T4D8SznwjmJGedrO4T6VqwlW69aiQBmCMuqax5WFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kllpQrZs;
	arc=none smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B2C606A32A
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 18:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7B2C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=kllpQrZs
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ee254f6eefso46885ad.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 10:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795286203; x=1795891003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+ww2YgpbwqAsCskuaPEB3Im3FqWoUKfW8X2evO7N+Ik=;
        b=kllpQrZsclScBd2V4ukGbVF4w3Z5xGIfBuKD9oTDjED0p6TvaUbvCeUH/8zmkri8dF
         XvQsHvTlcKJcBNfNxcu9D38cO6Gy+/praAzbn3HI9Kh6Y9cu65ca2AbXgrnR/sWaeIWS
         riuJU9KsN4FnehnKw743RaDgUqv/SEQQWblKFIWtSkOTuYYQarqqjGsdBvgNghhkVO3e
         JKBReVAKiKsWIVqV36LavngpZRvNMkoppts/T5bJCXApbMWUJ1H6Hqvf9Y5nL3ZsySZ4
         8l93I3IL0tull5tEDaZQwok8x3/XaWECLYQ8pjz3bzFMLsNH9kRgMwWqnHx3FyorMVl0
         X/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795286203; x=1795891003;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ww2YgpbwqAsCskuaPEB3Im3FqWoUKfW8X2evO7N+Ik=;
        b=s7Yvx5vZfJKdJnyMHKlVxfdSLrP/kL+uk1QsYpjW60lZNkXi60jVJK9B07A7RwKT0L
         AmVD9Ey2egZCxyg+RafBsHE02jHlBfP4qqs7WERj3MHdZvYh8GoVYtZS/xrKW9zl1xf8
         2yJA5ag+b2XnenOoIEUeFSZojCYQBgkv5S6p1AwPP6KDbE/mw01+2NU8CfJEJ2SGqOFy
         v7o16bnzU+sRVYd+PdxhO4GGo91VbNMjN86Uvf85av0iWY+yvuRg/UvYmBXCoYeGxVBD
         mhCDs8j4wzZNltuZ5KgJX8d9nSm0WCTBzWzHyfxqj/zrQ3Fr0/iod1RrCNQBTZOi4SXr
         uLXA==
X-Forwarded-Encrypted: i=1; AL+hErEp3gmVesKqKqxEXQB1UOlGoba282yCIAGwV1TtAFjo/PlFS8bkrfub5jfjLgF6RepvBxwTO1Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dCh2CJSWVinTrZpjkXn7wdTVAVTm+N6ZP4/TauGbJ2mLFC45v
	/PHQnyaZw7WKxYbT0rxA0EneuINt9hyqa0DQPzA7JN3aB2CC+mV7AGxYB6pmy2XIkA==
X-Gm-Gg: AZFdTZdRPIiro4dU3GgZ/LpcRGchkHUoJsKVu5QPs6K6bAPQjJmES5xRGnh32XH6GHo
	fDw1fxJQHTc1VSA/ut1w3EPm+eefs07r6mL2K4cHz63AVcv55craAgKKlJ8qTadieAYxrxyDGb5
	K7uAXqcSm8bqsfXcoYh0NrmR5zDga4c/nucGGHrohQGR1sz5vXBVfrqPaBObfD2qDST07TrT01y
	XCf9U5F7HQXyprMWivoJPW9wNQPZ2vgOcar6IOxhclqxLVkMmD6XDBVNPpyUYBo1zZ5gPNE+KwI
	rAIJDmt0i17VFJl5GtNMQAeOTwI5YTEMme11yhgJjiiPRwyk5lK7ya80K1erpst6CvrHCc39GMM
	TtFieXnGv5+fhpPmcw4f928OcaIyHgbhvrSLrCuwIlDlhW76F5RNict5ZeFQ3ZNWhEtTTqlBKwM
	tywFWAJ1xCB7sP0yR99sxmXjFRejBZekuVaoIlZqFiNlWe9M/8l+OicM6YnnqgweAcOM3AFbtpJ
	DlsZcQZBvSVHSNG+yGH93ilxwyFL5313r0vbYhFymoZ99bptax3tNiu9eJYFKvXwqFEtja6xmVn
	l8kha191KQQsZC5EvUtV5g6eekUa1ibxm3ssoVh2VDcLYDpshmBWTOGfC9z6q/s0Kz9P+cjCblD
	PGyQlwVqMZZTQAh86mWeoktoGhkxUcwC/B9dgyfy+BmdpQ9pVqaNxNjXjb4RKQIyYtsdgXzOdWf
	uTAFDAVcHB2koqMEIvPvXafJdaxuLCKe9MwfmM2Uup4quqbBP1LJ8sGVcWjD7MIByJrkrzsA==
X-Received: by 2002:a17:902:ef52:b0:2e6:d25:d874 with SMTP id d9443c01a7336-2f066568e6fmr2749075ad.10.1795286202449;
        Sat, 21 Nov 2026 10:36:42 -0800 (PST)
Received: from google.com (130.155.125.34.bc.googleusercontent.com. [34.125.155.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b8c2fcesm1972529a91.4.2026.11.21.10.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 10:36:41 -0800 (PST)
Date: Sat, 21 Nov 2026 18:36:35 +0000
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
Subject: Re: [PATCH] rust_binder: treat ESRCH as BR_DEAD_REPLY instead of
 BR_FAILED_REPLY
Message-ID: <awHksyRSafcJKXjI@google.com>
References: <20261118-binder-esrch-is-dead-v1-1-a45bb951fd14@google.com>
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
In-Reply-To: <20261118-binder-esrch-is-dead-v1-1-a45bb951fd14@google.com>

On Wed, Nov 18, 2026 at 11:24:25AM +0000, Alice Ryhl wrote:
> When sending a message concurrently with it exiting, the transaction may
> fail with ESRCH if the timing is right. Since this is delivered to
> userspace as BR_FAILED_REPLY, userspace thinks that something went wrong
> with the transaction, but actually the target process just died. This
> usually leads to the sender aborting.
> 
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  drivers/android/binder/error.rs | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/android/binder/error.rs b/drivers/android/binder/error.rs
> index acf0aa09c555..00f1519a8d77 100644
> --- a/drivers/android/binder/error.rs
> +++ b/drivers/android/binder/error.rs
> @@ -78,8 +78,12 @@ pub(crate) fn new_frozen_oneway() -> Self {
>  impl From<Error> for BinderError {
>      #[track_caller]
>      fn from(source: Error) -> Self {
> +        let reply = match source {
> +            ESRCH => BR_DEAD_REPLY,
> +            _ => BR_FAILED_REPLY,
> +        };
>          Self {
> -            reply: BR_FAILED_REPLY,
> +            reply,
>              source: Some(source),
>              line: ErrorLocation::caller(),
>          }
> 
> ---
> base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
> change-id: 20261029-binder-esrch-is-dead-8109ceb9115c
> 
> Best regards,
> -- 
> Alice Ryhl <aliceryhl@google.com>
> 

LGTM,

Acked-by: Carlos Llamas <cmllamas@google.com>
