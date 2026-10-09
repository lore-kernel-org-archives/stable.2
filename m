Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019113B19C2
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565148; cv=none; b=sybq62iLZkTfqJRW5kHbS3gz6Nv6k2LxfbUD3Qe2hwFl4hKkzrhRhDCamQF5KBhXjgtFLd1kYCy5MqKufD9lw3gli+ogRdX3MQk5zmVHDpA9064lxFLtxJ/y9Ovm/Sa7H8QQfatUuTRRKj1/TdUBEk8g8Ys4CUu14HG+qlIuzxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565148; c=relaxed/simple;
	bh=VsmwVWOVpvaJ+Q3nzqPlKtsId4STg45BTDnclVHfZ5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9xN9pHOBAhdZC6pkjUE92wK06LPKmrixizFzJsxU/n7g57VsrDeH9eKjIfoYgVKAK2Kuuc0qFTWCiqpbDe6GxEFf/7H8HRAFR9FgcZYHvHux+Wivo0fMu9W/s6WGrISbkK3tG1iLRbWuuwg3p0WsGmt1aL7PPt7C2PlwaqPTvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/PxoVih; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/PxoVih"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2dd9ec41bc4so27778045ad.2
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791565146; x=1792169946; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8x+7zuv7UzMaKL/3w5sC9AGLBUyDe21tWW+wJXFpe54=;
        b=H/PxoVihOdwF6MpTCjjRHDBKvMh+Wd1+CO48Rt58rN5hn9emLGLf42Rr4nDDr4Pbj0
         U/PYoe4eZeqY/aEOjRvtd6zEEUBZEMKalcSfIVVvgPABGDkGxsA0C1JUhYyI0jOaQRr8
         ARB29IMY5F6BbGeQ4YmvmXjNUg6oenUmGlt+jqydkXgE70ohKo8kAZRpzXQhppeSzbKa
         dqqOu2ICfnQFdaQmS2bfawRSE7Ftg9TKgRS6HGjU2SgLbkNzLWOs0epfgFHqUJES2usG
         jvQMolvQKfG7AEm4JYgQZjXtiuyuv+2sMC5EFP2UY+Z8zeOeZA8PU8bf8RnJT02vdtNt
         ikKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791565146; x=1792169946;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8x+7zuv7UzMaKL/3w5sC9AGLBUyDe21tWW+wJXFpe54=;
        b=wdZkhhpMMhHQ7uh0+BW4rUeYXhGKQaiuXA103aX1JEE3VQxByD076e7Qr+LYTZUEOG
         P+Z6R9CC1tBFyR7dcuNaWhzy1VMoFNquQ0ar4ParjCacqcJBHZyTcWF4oBPu6aRHhkvF
         5t6WLkQ/J8IYs6xtg22SDWPlXhmYd7OpL6PfPO+32ScHi66y3HPPU5kwVesU+y735GGH
         b3aQii00DQP+Oap7pMjalXMwmQNVAhL28h6b3IGfDWPoHozukIg7ntSfZjMdkiNA+MR9
         LYlxWmzpx9qaOp/bR5K2xid3t7HTdhgc8NgWeGVKHWliZbnArHmcyydjY4KrMKFVw9FQ
         /SMg==
X-Forwarded-Encrypted: i=1; AKwUvBx9HCXL8JbwOGZM6ECvv3rBIMXdTY6slMjz1wHKu9zEi4kE8tc6La9B+kLtnI9okk0Xxl47oNU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4JWxI9JKGBTML/kb7cPt94B797/IZTe6+z4XgZqM2yDUrQGaj
	sXGRnK9awikzOygLi/ckVsKzncV0BMC0n0fn1TH1/xWv7Jr6BtrCMjlw
X-Gm-Gg: AYBFou1eBKBH8hCXiaoJS+wLXdZPnMrsvkUrSa+DeemQOIqj6dnEHS4wqTkkHLkK5xn
	HUK+enL+Z9yGFmKEOFrdc+n/FDgRzdgaM9MjumRk/QbRfWlqzB50k2c+vLudNrznW+LxV7Tp6Vp
	n2wkVdR6I26AdEeByPZ0kQQCTKgcRaqjCp4jWc2TkjCQEyaE/i1PjJTkma9whpQdMIC9dMCCLSR
	ndEl7rZXlzrCiIubtGTqRyOVP5kxRNaxjK9UB4ooa3l9HrTykMJws6kUu8hJNm8LImhZPEOMnec
	Ugv8GysL7cJtYN4wRrG89L9QOFA+R6XMqEEt5QuZy9t7VxH4UxHO/GYgsVngefrtO8h6yWXMYqH
	IJbMOPJ/h+zICwjFx/DmewJFLXmKBO7vAh2NX6I1eZ6MJQYLUrghbt08PDZCPLVw9ZoAD/f4Ssi
	rlqe2wGu1DxnCJos4jmG9LSvbo8zUKcflpGVqpNIoGCzSmkuYP3Rjv+3lMxNwOW4JXAcAuG0npr
	LI7CXKn2biVC2Yss7S5QO8fn5AJ27g+0Q==
X-Received: by 2002:a17:903:160c:b0:2e2:d9fe:51fb with SMTP id d9443c01a7336-2e84280aeecmr22910215ad.4.1791565146067;
        Fri, 09 Oct 2026 09:59:06 -0700 (PDT)
Received: from google.com (61-230-52-229.dynamic-ip.hinet.net. [61.230.52.229])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422e2570sm14453055ad.79.2026.10.09.09.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:59:05 -0700 (PDT)
Date: Sat, 10 Oct 2026 00:59:01 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Guan-Chun Wu <409411716@gms.tku.edu.tw>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH] lib/base64: Silence clang-24 -Wconstant-conversion with
 diag pragmas
Message-ID: <askdVfevxztHMyGN@google.com>
References: <20261008-base64-silence-clang-24-constant-conversion-v1-1-0858b60b23c8@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-base64-silence-clang-24-constant-conversion-v1-1-0858b60b23c8@kernel.org>

On Thu, Oct 08, 2026 at 01:08:49PM +0200, Nathan Chancellor wrote:
> After a recent change in clang to warn on signed char conversions within
> array initializers [1], there are several instances of this warning from
> base64_rev_maps in lib/base64.c, which can break the build with W=e or
> CONFIG_WERROR=y:
> 
>   lib/base64.c:58:18: error: implicit conversion from 'int' to 's8' (aka 'signed char') changes value from 131 to -125 [-Werror,-Wconstant-conversion]
>      58 |         [BASE64_IMAP] = BASE64_REV_INIT('+', ',')
>         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>   lib/base64.c:52:2: note: expanded from macro 'BASE64_REV_INIT'
>      48 | #define BASE64_REV_INIT(ch_62, ch_63) { \
>         |                                       ~
>      49 |         [0 ... 0x1f] = -1, \
>      50 |         INIT_32(0x20, ch_62, ch_63), \
>      51 |         INIT_32(0x40, ch_62, ch_63), \
>      52 |         INIT_32(0x60, ch_62, ch_63), \
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ...
>   lib/base64.c:34:42: note: expanded from macro 'INIT_1'
>      34 |                 : (v) >= '0' && (v) <= '9' ? (v) - '0' + 52 \
>         |                                              ~~~~~~~~~~^~~~
>   lib/base64.c:58:18: error: implicit conversion from 'int' to 's8' (aka 'signed char') changes value from 130 to -126 [-Werror,-Wconstant-conversion]
>      58 |         [BASE64_IMAP] = BASE64_REV_INIT('+', ',')
>         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
>   lib/base64.c:52:2: note: expanded from macro 'BASE64_REV_INIT'
>      48 | #define BASE64_REV_INIT(ch_62, ch_63) { \
>         |                                       ~
>      49 |         [0 ... 0x1f] = -1, \
>      50 |         INIT_32(0x20, ch_62, ch_63), \
>      51 |         INIT_32(0x40, ch_62, ch_63), \
>      52 |         INIT_32(0x60, ch_62, ch_63), \
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>   ...
>   lib/base64.c:34:42: note: expanded from macro 'INIT_1'
>      34 |                 : (v) >= '0' && (v) <= '9' ? (v) - '0' + 52 \
>         |                                              ~~~~~~~~~~^~~~
>   ...
> 
> These are false positives, as the branch where the wraparound could
> happen is unreachable with the values that clang reports. This is not
> considered a bug by some clang folks [2][3], so silence the warnings
> using the __diag macros the kernel has to workaround compiler warnings
> when necessary.
> 
> Cc: stable@vger.kernel.org
> Fixes: c4eb7ad32eab ("lib/base64: optimize base64_decode() with reverse lookup tables")
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2181
> Link: https://github.com/llvm/llvm-project/commit/a5ef934a8d295dc03be3960f2b3744ec2e53238e [1]
> Link: https://github.com/llvm/llvm-project/issues/223923#issuecomment-6056856245 [2]
> Link: https://github.com/llvm/llvm-project/pull/226775#pullrequestreview-5454407389 [3]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Reading the issue comment in the link, it seems somewhat subjective and
controversial whether the compiler should emit a warning in this
scenario. I'm not a compiler expert, but from a user's perspective,
it's a bit disappointing when we have to deal with this. When we are
confident that the code is correct and have provided the compiler with
enough context to determine that there is no runtime issue, suddenly
getting a new warning after an upgrade is a bit frustrating. But
anyway, let's go with this workaround to keep the compiler happy.

Regards,
Kuan-Wei

> ---
>  lib/base64.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/lib/base64.c b/lib/base64.c
> index 325c7332b049..e46be3a55585 100644
> --- a/lib/base64.c
> +++ b/lib/base64.c
> @@ -52,11 +52,14 @@ static const char base64_tables[][65] = {
>  	INIT_32(0x60, ch_62, ch_63), \
>  	[0x80 ... 0xff] = -1 }
>  
> +__diag_push();
> +__diag_ignore(clang, all, "-Wconstant-conversion", "https://github.com/llvm/llvm-project/issues/223923");
>  static const s8 base64_rev_maps[][256] = {
>  	[BASE64_STD] = BASE64_REV_INIT('+', '/'),
>  	[BASE64_URLSAFE] = BASE64_REV_INIT('-', '_'),
>  	[BASE64_IMAP] = BASE64_REV_INIT('+', ',')
>  };
> +__diag_pop();
>  
>  #undef BASE64_REV_INIT
>  #undef INIT_32
> 
> ---
> base-commit: 0c2669a9f4a1d607e7591ae50ccf3c432a0aff08
> change-id: 20261008-base64-silence-clang-24-constant-conversion-b682c6bbf563
> 
> Best regards,
> --  
> Cheers,
> Nathan
> 
