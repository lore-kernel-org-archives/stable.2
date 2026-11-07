Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794026348;
	b=NynEW1Ue6dJhWgG/Eq14Usqewl0w8kLeRwVLYYJ1dhf7xhI1Kp4J2phgfi/fh4nwtKVB
	 /8YrLoEly4NwGO0L4xZ14QQrHzrkDKuhSOzY2iHRdLAc8RO4oddzzmNB3G06g+dMyp8bZ
	 vmIkoAkQEldYGR42vdJo4FwOmutnVQw3rOm4QIw5CRI71Cj4TpFqhSqZA0AdWAnS0JglN
	 xs8xMXHMHPdfizuKNQbOTyvoWipekCnUlpPmLn52UQ6zmiDU2MRDhektC88QUwHzDHCoe
	 m4mj11f4a8SfSGf5LiAf+Cq6dEJZl5SnzQB6/OM//YXNKas3ioVGE4AQ/L9D8r+yUPA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794026348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=fWABTxQt0TPDz25XXDUzvz1pdSuFM0l8HegkYoRHLLM=;
	b=XEhTbrL34rvhPVHr6VnicSyMCRpeQKYOl+n24ItbSq0saqKVze68xXDhykC/vQagON/p
	 ExPyFXa/UOrF6mILAHWVkBKiE9X9gkYmZExHxcdLWK8kN0CCT+gS4+xoHS1nbc5I/yh1O
	 7HY5AyYrRlbw6jC32yIPv5mddmsVfbiEXGak6AOQ4WJUal801KMRVtAVWcaWxzMTluytX
	 4FeD6E3hRXsxEKVT/Caq5ao7sbuXDTmqZwwweVbhQbtU0nWeB1PAv2pYWwwS5fBR+41u5
	 Wt6RA1ZRrUh14dkLEzVKl69zI2PNXjjHRajQAeg0JnXeMMYsViHBItf4TJIIOnnRMZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YemYGyiJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01491606A334
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 04:39:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01491606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YemYGyiJ
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a091e4eea2so35527b3a.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 20:39:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794026347; cv=none;
        d=google.com; s=arc-20260327;
        b=A/eQLin4qMe6AuS+k0z/qPQR283r1snZUOfNgB1wYdm6yELUe1Yf7ic1wQyg67sRLZ
         gRgltpcVx74Pu3EABO72e0r+E/BJLUIhUDO93GSFqw3id9UBEJfKFVpmW99cBV2WNWEL
         x8S7fwk9ogMxu3YEyNxM/4yaNY6SHnwdkQtLHoAmsUhDqjQj2djtfQx8cNGiYq7uBqNX
         1IPDLPE1u1nHt5QhZa76QdOUlCzqb1O0B40lPetZnfWNDDeX30vzg05BzioSYgvkwxPW
         acN7sFaYFBsJOru6+qfZOG8rjqozhugEXOyGTYrjbOVUQqPfMegTSImexw2esGeI2EGh
         GYrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fWABTxQt0TPDz25XXDUzvz1pdSuFM0l8HegkYoRHLLM=;
        fh=ZgJBvFqv8KfkXx8PiB/waJbq5xYIRfq0nodb284qrk0=;
        b=CYhzEgGHuP+dvFsEbk05IWJ/x9hgVQSevnWvw2fm7NiU25PAqf48rB1e3cFALQM7AG
         +K1YsKPm0kbKaP5SrlGhNLEOQR1peDEOCRbwWDUwJ9SlI8w1D6T33giaTu0XPJiLl1jM
         SGUE6qsw/7i5EHr7tn/Zs7LXusAB2MY5RPim5TnltpER4H3CLAOAFbFZ1rQXSUDXFPnw
         bQ30rtOFGnoahpgEITBU7c6En/PyT8WC9HNijYb6UAAbRG/aKsORtZRBpWwerRXvRMbI
         bkaUjhsUn7uWkVr295G003aJin6pGsTYbNqyW1fQHhdb3olSDEMCGroXE/qHRRystcl0
         GIDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794026347; x=1794631147; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fWABTxQt0TPDz25XXDUzvz1pdSuFM0l8HegkYoRHLLM=;
        b=YemYGyiJJ3tiwh7MrSfXGj8B2O5GNYI4E3GWdlW2UXtMZ6xvecJnOMnwtd9YXsOch1
         otmae5sq1LQ9Nk9AfSb7QcyGoGkyUdSIpuVp01uVzFJNYTqGr3hKeEiHdsJEgbLgwWqQ
         6ZCGC2Rf0BlCvZxOvAsRKjIz4QsDgNUZleuR03fgX5sz1evxJ0Rni1sIxtXbzzoefwZB
         gEfGVKI2ueaEEYRDu7jDnmCFy7yK6zwUd+m6f0IHDVufRGMaT9s6CrIeHOTP9OCv44//
         GyzKxQ++yzEQfRBwCVFKHDhQUflRCAIDRx4gWELcwW1IYbn0LCLFQhsRp5R0ZpNhCevr
         SwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794026347; x=1794631147;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fWABTxQt0TPDz25XXDUzvz1pdSuFM0l8HegkYoRHLLM=;
        b=wvgSkXrIAKJxWW7AvWOrnvLeS6rACFML+kk6KQYXMjnCK5iC2aoxdAn55mN09uQqTr
         dvIy6A9i0O4gO0gneqpTVuhsTb+ic7C06LkNK62gzrmBowWj6DiJJenZI4BEGJuppXXY
         WsKaqxpRb2fKSCg3D6EAT7EfkKPOeQjKQ1swwMb+uw8DB39vrroHEX4PVVFrEi8mU/3P
         5IBse/e6gFRejiOPLFmKaHh1i3JzTkYHqCLUwTqDFONfcVLqQjH6HwTI+T4yKKE9FC+J
         jXYKRS7+kVNdIJXUA7YKm67evGhSCcefzMN0ghj+Fz/Guj9sjMdL00gIm+ryZbdC+YYr
         w2bA==
X-Forwarded-Encrypted: i=1; AL+hErHxUepgUAnTbbkJAtnDlXqcU3NFgTDtriINygcSn0LUeNEzakzATCkuuRV1N+S8p1PPGZ+EqbI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8eGq+tAGZvtxAnByaEtb3V/bAt1AiBamU5W4cwmfDXC9vgHUPi
	bIggFJkIpqQwwfzUmKUCbjmxBNennLW8duw1lBM7iBVXZlQtkLRrlMbcLONCOx0M934vv7UHJPh
	+jLYvkdUgHyBz5jVckZv6S5RBqRxPrLI=
X-Gm-Gg: AYBFou2LF/TZCxCn55RIJqTONIAb3eitC6vtzHx72IeqEqGbFcu5oAAfY7Ag7DE4b8g
	24Huie1es3ORWakcjxryMrqBhPT7LoJhvYXdwi0JY9abo/yKPuuAD8ohW1SK8kSAAIpwN6ckNED
	2gqD5FRprzzCh5NigRmW9l08Wy02jKZJwcHBL9GIZzMM+hBBFXe1l0WlvQlLxcPv5ozPSi6i069
	i/gA8n5T9KtDIbPOxwhd5WbKMrBrnTK1ZY0SP9oCkZ/3CUFbJbumUz8cXOt9LCvY07ai2wdJxOf
	VNK0fpd6teKeT8gwkwByDqvPehzvMiK8VG/E5B3D5XZO+6JXMG3acMbDgknJxtMSDJCeBq06TDJ
	7HjtYvscbBq0v0RShtSRY37pYsKNEM25XqsBZMA==
X-Received: by 2002:a05:6a00:c4d2:b0:8a0:89f2:3340 with SMTP id
 d2e1a72fcca58-8b374e61e12mr4346500b3a.0.1794026347305; Fri, 06 Nov 2026
 20:39:07 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103181410.1601083-1-lui2012qwq@gmail.com>
In-Reply-To: <20261103181410.1601083-1-lui2012qwq@gmail.com>
From: Chengyu Liu <lui2012qwq@gmail.com>
Date: Sat, 7 Nov 2026 12:38:53 +0800
X-Gm-Features: AclHuK_HAFgI5V9CnrqbzbHWRtWchBIBPDLlothsK4mysUxnFrG0CyAz6a0eG48
Message-ID: <CAE=Q7=7Ct5pPrT+HLG6PgWKW0z__WDZ0LtRJWQs00SYfFJjQ6Q@mail.gmail.com>
Subject: Re: [PATCH] nfs_common: release decoded ACL on nfsacl_decode() error
To: trondmy@kernel.org, anna@kernel.org
Cc: cel@kernel.org, jlayton@kernel.org, linux-nfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I noticed that the Patchwork status of my patch has changed to
"Handled Elsewhere". I'm not sure how to interpret this status. Has
the patch been picked up by another maintainer, or is there anything I
need to do on my end, such as resubmitting it to another mailing list?

Any clarification would be appreciated.

Thanks!
