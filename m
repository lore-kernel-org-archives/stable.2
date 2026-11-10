Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794316844;
	b=G03SHthSoCC4uElAUrnYYc2C09D70GBRBQpmeowV/g0ulXJRX9uPVb67PUOoMj5L8nmT
	 3ICtdoJYVyjCfUXafGPqWzu0xxP2qDz4Gzey2uDgO2W2CmGAIoMwDgmIQl9oGGDT7HOuE
	 bcLaqkbSsxBEn10gkFHGVjh8vfB/z3lKn8pXBjKFfY5gxDxdt8UeMilhvrDy7rt6jMytB
	 WDU+ChWuWKilxqKDOU/za8Zl2YnrA7e0AS5jpB+7wIcVK/fbcqj2AflZCA6upA4oGtKrD
	 xLdHuHnlIaaCmVf6XK6tD3LyPI5wmFQOTBC8nLsj9JH8oUQZrzMQ8tym5vL4UW71yWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794316844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=HgEZ6R3QT14xsrDbsdojkQHFi4Tt+tUPqMpmTREpgRs=;
	b=D+kAhpo0RY2OG59gUOn3vOkuZ7SJOGI5VKkjdyn220eZYA27v33jgMmO3sjBPE8RQUJy
	 DUlPjLKcuBiTc7OFLGjGLf5a6iR8rptEzFj+CUmM76PslVQ4lWejZGF5d2yhbQ9cMTPIk
	 OaER1n8KnJC/C+Xy71TyopovUG1HUxL16D9Mi3gmyU2jzpTITpJKcQKmsz2hQnW8M4TQ/
	 Rf0joLDZGi3uoGKR72x6BGZ2pK5WSvr/LzxF+BLfgsxbM3tWdpHgtYBtcCK8nXtEEHtba
	 4JfQ4OarqkjUflGK+Jeerb4guqxLivQhQqhZuOPiw0DkC5vh1P/T+8jAqjbaeIoEsEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="VHpMP4/j";
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A126260798B0
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A126260798B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VHpMP4/j
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so16858855e9.2
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1794316842; x=1794921642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HgEZ6R3QT14xsrDbsdojkQHFi4Tt+tUPqMpmTREpgRs=;
        b=VHpMP4/j4sBE/3GTsWVQXCxciymuJ7C3nxN5+Dp/83CDvcD79g8DhfK8zTD7Ivmg6i
         67lH3Ulh4eABXI9QypW6gyGJdhevQT3cUO0D4gsxOrSN2TBJAGFjTCmosGKAmsbezZQP
         2I1iFT+TIbq8d6EYGfEwV104xY1K3Hbt8xJ2SwGtblNfbti+36u7nsX9oq8qeor8/K+v
         uaF059Jff6l639HK4RXNTwRqNy98Vxu2z6afcpsQUqh+LKG5NWFFuHaQOrhTa5uz3XrP
         g6WsjwyjfzjhzaGseTGgYPYMkKmZFLmQZbul1cUcIhtMOK2/LBA2BYRyDQ1gkhRh0APK
         t9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794316842; x=1794921642;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HgEZ6R3QT14xsrDbsdojkQHFi4Tt+tUPqMpmTREpgRs=;
        b=pNVecpAIiwPyxlkyRIeHn0pFSSdpmnpefsLfjQJzFhpXZsZwTHKxY9geTRkaapnYXo
         +jEVOAQjVvWRK5svYBvTGf0GXQlckg2HWGAaLWrBb9wg7aZcgVylYm9W0tZe6wU7wa7e
         FIHaJTb1Ec08BRACKLMwqtvOajCJb8abzecKxpUQ1/bVifvUaEOpgy5cqAZvrPFWFhHX
         fNa0kEf5GIOYzSK7Ho2fRBOcB13f3HIsIO9I2ba2W4kTN3Fs2xt35fVWR/TTckMuYlON
         eotke/1hHFfbaixEPwuqdy2Iz3hh8KzjRhWm9X1/6bVwf+B/Fn0D+1z3LWXTAVrhcqi2
         W21A==
X-Forwarded-Encrypted: i=1; AL+hErH81AegRF7ljm3OAwiBFkYf6VRjvV0y0mJmMCHF0S7HpIMBduq2KwVRXpKVteiCfT5P/gJ0FPw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9x1iUYw9G9L6DExI6UwaKbHBqKJ8EL4l1QP8m7UYyliq4z9gt
	ei+wz5lsMDnuc79K83gNJ16Eur60S+T2hJOxQHbndxNb+jTHZEnveXyztVePN8bQYukub13AqhB
	ail7/CMQ=
X-Gm-Gg: AYBFou2Wh3MUTsKMFA3MPiibM1scciilTYOPAkWgBm6Y8QyCnj3F9uNiuNO/U6zxdRF
	ANDMHlcVJhrc1Ds2loOlTIdF8jPe/jhDIJbPtwBqv0SGPh0saGzYCqCgiJ48rZccppbxarVFq/l
	/zEdc3waXDsSSfE8dPv7qhm6GxxTjo34ODae203BHUk5OYLgVwyoLaoy3Je994jOCjC+Mr6qgzK
	HFjmNdd9DPbXiJBjU7twno6Vw0i86Qk1zLWXedYv0XBCFbjvojuNza6hJ/xELdkwdvVcFZU/kQY
	IOxOE5GBuwcOmvfI25B6qaX4TW0uqOjZu+YDFtrdCKpoQOlmVBQ74aRjnxzIWg+eU6igT8sSBFj
	Kl/+LdrDR9OYLmlbUCNLr3qqfcjcSDkXiNIN94VOTWljkw0YNiWjrdexym2g9a1DycCWDeaBYvY
	GB3MSuZ0cBJJdNK5bqUMDiq0CPCmqjgIXQ/qxO19ezMHc+VE7b8Ti+nzIEs5UFkXZsZ8UldyM9H
	dgwO7RoJipoomtH53uWMSI6NylQ24QZVkrFgYgyvcJbroQlRYh9b3jr1NsmcCJGdQchNFezEJ+J
	GJuzKVSG8m/36aO3FK4RRdD2s/Vwyq5457xqd2j0vtQOvPGOrQpPw5F/IRo2dCTyanQ=
X-Received: by 2002:a05:600c:6089:b0:4a1:fcfa:2a07 with SMTP id 5b1f17b1804b1-4ba0234f9efmr39939615e9.30.1794316841996;
        Tue, 10 Nov 2026 05:20:41 -0800 (PST)
Received: from pathway.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498369a3f4esm5435036f8f.53.2026.11.10.05.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 05:20:38 -0800 (PST)
Date: Tue, 10 Nov 2026 14:20:34 +0100
From: Petr Mladek <pmladek@suse.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: rostedt@goodmis.org, andriy.shevchenko@linux.intel.com,
	linux@rasmusvillemoes.dk, senozhatsky@chromium.org,
	akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	keithrteeple@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] lib/vsprintf: Preserve the sign of seconds in %ptSp
Message-ID: <avMaIj0DGI9yei5O@pathway.suse.cz>
References: <20261109215445.43419-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261109215445.43419-1-dennylin0707@gmail.com>

On Mon 2026-11-09 21:54:45, Hungyu Lin wrote:
> The documentation defines %ptSp as equivalent to %lld.%09ld, but
> timespec64_str() formats tv_sec with default_dec_spec, which does not
> have SIGN set. Negative seconds are therefore printed as unsigned
> values: {-1, 0} produces "18446744073709551615.000000000" instead of
> "-1.000000000".
> 
> Negative values can arise from time differences, for example in
> fnic_get_stats_data() after the realtime clock steps backwards.
> 
> Use a signed decimal printf_spec for the seconds and add printf KUnit
> coverage for zero, negative seconds and the signed limits.
> 
> Fixes: bccd5937447f ("lib/vsprintf: Add specifier for printing struct timespec64")
> Cc: stable@vger.kernel.org
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Tested-by: Keith Teeple <keithrteeple@gmail.com>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

The patch looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>

I am going to queue it for 7.5.

I am sorry that it me so long to get to it and missing 7.4 merge
window. My TODO list somehow exploded around the Plumbers conference
and I am still catching up with it.

Best Regards,
Petr
