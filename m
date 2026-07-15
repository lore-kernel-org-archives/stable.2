Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2889C2931F1
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 03:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784084539; cv=none; b=OEFvXtUVNoFtbfHkuH6mEa5JLVdtKF7sysxVAQCpV4LalVFsVhKrgQD9s4K06TLllUYeR4Agc14vThCvmfjbYnH+OGF4VwtLKVf8nD8PWSz2bOo41kHEjtPvpi5l+TTSPfRnloenicVp248tzj21rZnsUNnKYu35Nm0m2he5qdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784084539; c=relaxed/simple;
	bh=Pyp2DnCViCnJgUi88+R0XBfifCiYiXiV56seNpVS6sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HkEAZH43l23272B/mbo3ybjq43OuDO9ltEcEfMZqlAGtcjIWuusLTyGVho28RNKMLsyZR51IfvzevbuskjIG041TOcvd27tVCigZJRieW/9S3BWd8qTE6ZBsKZcq7eMylh7YKRcyN23qSdPi3DTbIwTED3Jizf4xCmBgXxxL2/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CgJACLJ9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CgJACLJ9"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15cd3fd760so567932766b.2
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1784084536; x=1784689336; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hOjABmuvBW+jCcuokYEE7Gv19LjuO15ZtZi5onZDlks=;
        b=CgJACLJ98v8bx0a5WjsLkmXa0c45JEdSrekLF6tl5Fk22ghzpLJUvgFKQNzQTq8Ifl
         /ETsYk5Eo6xIB43MhUwOTHfm6l/60rKnMk3z77HYo3eisYf7NRzZMM+qx11ZKE/B/IiZ
         vklNHjKz3M8XNO8/Ulp4B/L3Ont5OEf+hb9qmZq7FfrXmYIOgTLvsYr1mcGB8om87koA
         eNoJog5ZJsjRDPz3ZRg0hRIWoIoPBCEPrG28tjn73CcgQw9BSKK4PCVnl0TowIaMCQJl
         cKRfYR0ykvJXtO91SW3ILye1CqC2a48Lpg1PjvVqZVEEk6hLo2Llro4s7MO2IjdwzHBW
         PEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784084536; x=1784689336;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hOjABmuvBW+jCcuokYEE7Gv19LjuO15ZtZi5onZDlks=;
        b=JbdXpTRwKLIOAJap3nU6wFM2qBCfi4Qr/mP2VC7QUE7c/HT6fLomQvj2P9fEAe7OIj
         ZdWWDtJv48PXVgsV0VXHIkKBLYiKbJ51Lm438GfKpF3QjPxPkJAKy2YpR+W8cPmcDZPU
         Skr6XvCUoUDIMrah8iPf02Oyr8QkWBOEunE2v3F0qtMi0DvRzknYtbew91pkuHBHDNp6
         35BRYKc44scuT+VX8P/ICcvzVWjtVGHypS6RtpGY3k6+oAO9K+uhvnYTKWjOVUvVFExX
         T6i+m8R+94Bf0N+L5cGljEud3Tim/mgyUGysO7wwzNpeKoK2E8FgSukL3c4kGZWsDgQP
         T1+Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro04irtM0qrWTJoKuGic1vaP0I5MDPmA45CXl7kJqOyejYZIjwrKsr6rogtlb1lKHEPzu+Hu1s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/8rR6UKPI+tx6DvyR0bguiiijVwZZlbY0ppS3SCmNf87Td2Z
	2KNWytQXIEeOnV1eRmF0UQhr1ERhSSL8SqkqobvLOQMMIVrc76DfBDrrKdv/R6yWzYg=
X-Gm-Gg: AfdE7cnxiVpOi5k7FjOXZwnHIfbAUWZCI/u0aZPO5iE4PC7Duo9Em0bK+C/yFNre+7Q
	q/MeHLS4d4X2NUg/xWgDhXLR0bjzG1L0bPKPqcgVqSRLhU/i32ENhAhwqGo6FQKNRnZBas9tZEe
	zgahb5iY6IISq+QlBmUCFsBEgor1yyAawkKCc72vtTMAKKDMtWilQACgnJQRA3wADPNdlNG8Uya
	FpirDBolawuzX9NY+JaZFJHIPbe9wmNAzWUKm2KHHeYp4wJvhDhuMXfC2lex/xnb+aBFRqWbLVQ
	XHXGsLfPlI2wwQfnSxnQqKb7pCVFSzH08jAMD6Vc2vaTeIvyXLmN3F6/lncU4Z7hwU8Tc/EIB4d
	iJSRIbKs1QzPJqNkoQ1cKZdaqD+1YPFa31uYQ7jX+QE/L2R1OVsCm7lsBNN43QwwcR7ojlqJlgh
	L+rAInxVGIsO/pUTPBv66wrMf5UYACgcby
X-Received: by 2002:a17:907:f815:b0:bb7:eb68:514e with SMTP id a640c23a62f3a-c167940e66bmr67514766b.36.1784084536316;
        Tue, 14 Jul 2026 20:02:16 -0700 (PDT)
Received: from u94a (27-51-89-168.adsl.fetnet.net. [27.51.89.168])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a39a4a7797sm7988739eaf.6.2026.07.14.20.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 20:02:14 -0700 (PDT)
Date: Wed, 15 Jul 2026 11:02:02 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Matt Mullins <mmullins@mmlx.us>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: Cover negative buffer pointer
 offsets
Message-ID: <alb1fmxTl6-c-HJs@u94a>
References: <20260714093846.18159-1-sun.jian.kdev@gmail.com>
 <20260714093846.18159-3-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714093846.18159-3-sun.jian.kdev@gmail.com>

On Tue, Jul 14, 2026 at 02:38:46AM -0700, Sun Jian wrote:
> Add verifier coverage for constant negative offsets on PTR_TO_TP_BUFFER
> and PTR_TO_BUF pointers. Both programs adjust the buffer pointer by -8
> and access it at offset zero, so the negative effective start must be
> rejected at load time.
> 
> Switch the raw tracepoint writable attach checks from nbd_send_request
> to bpf_testmod_test_writable_bare_tp, avoiding a dependency on the NBD
> tracepoint. Keep the existing past-end case and add a case with a
> negative var_off compensated by a positive instruction offset. The
> effective start remains non-negative, so the program loads, but its
> access end exceeds the writable context size and
> bpf_raw_tracepoint_open() must return -EINVAL.
> 
> Reported-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> Link: https://lore.kernel.org/bpf/alRtilWhKw4zzMkI@u94a
> Cc: stable@vger.kernel.org # 5.2.0
...

IMO it is slightly better to split this into two. First part would be
[1] suggested by Eduard, and the second part would be the addition of
negative offset test.

That said, I checked that with v5.2 we do have PTR_TO_TP_BUFFER and
PTR_TO_BUF support already (latter as PTR_TO_RDONLY_BUF and
PTR_TO_RDWR_BUF), so there shouldn't be a problem having these tests
back in stable.

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>

1: https://lore.kernel.org/bpf/3430dc0a2a141769a596ab21d7abdd86a0a804db.camel@gmail.com/2-tp-test.diff
