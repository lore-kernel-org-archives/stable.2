Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC16D485CFD
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 17:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828632; cv=none; b=lFTvI0C1YXj7tlqxQYqcLKn+iJP4HPNncvMDnoxHOcmlg9UDH/ws1qWn0gon+yFoqZE3vbeLG0crDYIevq4TORTdn4liSFLc1E1OEQ1YX6Pw9rfSCbzgdaNaHjGq3MmR/TeIfJGRE+Qx87XU1j22F/7S+akSu+6hBsVaZKeC3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828632; c=relaxed/simple;
	bh=7CfLiwE5M0TCOSUKAJEyT22HQx9DD5s4V+fJwhTJWV8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=mZWJbSAzd9VCxPyFSmwYI/jWGwQm7UIrW5o/zL01D6/MzpA+LaXpenBUG0/Q1rBhV8cTFoU/zFPVP4WGQNIEwK8tw6EwwhV8X2RJP99Kr4KpnO8jgn16xjKLhPY3ktB+GV5Iqkm5TLx8Tx7BOjWUOTcpbJ+qMT798UqLBMxhd20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Vr71dgUz; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Vr71dgUz"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-90327237340so6995156d6.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 10:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784828621; x=1785433421; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=brmtQMY+PCLY5SqHqKFMvLTgXx8Pdh/IhOMrgYqDWxI=;
        b=Vr71dgUzOAqYSVvjqBnD6ZQCE3SPE5Mmk4qfCKiMbM9zK5Zr4I8p928xXutV5b6dN+
         qgIWEu4UiU7JjrDa4b/fmYS/1mGAkKcs8vnDR9BihkanA6IU4TSVc0gY7gO4hTu2D3z2
         iMkBy1bOnr6rYTzrO+OgDRZuRPEedoExVPsjfD2V8miArtLe+od5z8UwDMSxPFDM791O
         HSySg46wlvWky8fNj4rDm7MS/iWMRHLeKpMjF6GEjdk5jCudU61Zv1QSKC5OcyzE4miH
         QRWLNdXpD5oyRK8mRueLgoJ59UDZJQLfMqeafDuPdrCKWKSvHT7uYiA9DzJqSKPJkgEi
         nfXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828621; x=1785433421;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=brmtQMY+PCLY5SqHqKFMvLTgXx8Pdh/IhOMrgYqDWxI=;
        b=H1rarnYe15gduMIruOog6FfNtw5VR21sPgij+iuPrqVwo58VJW7EswkmhB07iWFLUY
         kDr4jfwBXac2zFfZtJXlAgyzrEDor3m720HYmBdadsmuf12ZmLY2ao5pgpLoTCee5fng
         iBerEUU9GG5TmItYL9Rh/OQ/Li8loIPm0B15drFZTmpJhrNwNT9/ty+iRgkoq54mVjYu
         L0jbCKCO5tjT/psiblxI7ciOObGYFaGd15+BDhzERwMGj6txrCqrCuSVqzQQl33kZzqP
         ATU4Z/bpwgNktM2dPsWgr+iMKamxMj1EBCHsUssUMDj/IWYTmVl+duNtlaRD9bo8rLHu
         Ycjw==
X-Forwarded-Encrypted: i=1; AHgh+RpT0v5SOMXCN/TZiWuP7U+lnU4oeL4Sinsvr4suQO39Bts01TOPDRs5zbIFOt5IL3/wb9zolkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW7h+NVqiWrNoXnXdfFKnaiAkipybRv7SWkt7pCLsTRsiw/Gcs
	vHlHiZMls1P3iXDt1Kpvunw5qVnucYBEWmBFdM/u9SlP0nfXU6g0xpXb+69GY3CvUA==
X-Gm-Gg: AR+sD13SeQeBHi8MaCKti4PlO8Y1DWcb3vos9zS0EzPvFwgxTO/s3tkaSVCt+q0Rhor
	sWSuCy5rjun4kVnNwnFeFML90XMMO5yDdHFMpaaNlAApSTfLP2aevLb04bUcZk4MHqESQEjsqyK
	eBAZqKCxVQPDO41VF5Z6w442Qj/iSpAsP0BgEK6EwZ77E6nueLSpQ0Hyz68xpJIdMPKIdL/3pCR
	t4f6Vq104X3uk8KZe+4amWnlHb1Hasjx1oV88JH4lkTn8U8sTh6e6nu9bcdkr2rs5ny7FJQtOzv
	CYjUJ2CtDZSauuOH5Nb7N6prqG+V2EXwKxz30ayKUScHfsiRgmQK4SpOMQogmo0Ijmw1lVDIDWc
	EYoDbskfOetZ9nm76epU3qSHtkVlNEjSnscpaklDP8UDDc4INCo79VziSkw5Io26IYDHorrODu1
	pSQDUefGPjcvrHtnNzv0g9thj6N69UV5u08z4iHzbgxCTUzaYzLT8cFR/joA==
X-Received: by 2002:a05:6214:508d:b0:907:6fce:b82a with SMTP id 6a1803df08f44-907cd19b0a6mr33743506d6.23.1784828620932;
        Thu, 23 Jul 2026 10:43:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-907ba901c24sm49954856d6.21.2026.07.23.10.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:43:39 -0700 (PDT)
Date: Thu, 23 Jul 2026 13:43:39 -0400
Message-ID: <d79fe8753ff88268bbd9bcd601cc4aa1@paul-moore.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260723_1338/pstg-lib:20260722_1430/pstg-pwork:20260723_1338
From: Paul Moore <paul@paul-moore.com>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Eric Paris <eparis@redhat.com>, Ricardo Robaina <rrobaina@redhat.com>, Richard Guy Briggs <rgb@redhat.com>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: Re: [PATCH v2] audit: fix potential integer overflow in  audit_log_n_string()
References: <20260718050922.1980425-1-zhanxusheng@xiaomi.com>
In-Reply-To: <20260718050922.1980425-1-zhanxusheng@xiaomi.com>

On Jul 18, 2026 Zhan Xusheng <zhanxusheng1024@gmail.com> wrote:
> 
> audit_log_n_string() computes new_len as "slen + 3" (enclosing quotes
> plus the NUL terminator) and stores it into an int, while slen is a
> size_t.  For a sufficiently large slen the addition can overflow and/or
> the result be truncated when assigned to the int new_len, so the
> "new_len > avail" check can be bypassed and the subsequent
> memcpy(ptr, string, slen) can write past the skb tail.
> 
> This is the same class of bug that was fixed for the hex sibling in
> commit 65dfde57d1e2 ("audit: fix potential integer overflow in
> audit_log_n_hex()"); both helpers are reached through
> audit_log_n_untrustedstring() with the same length source.
> 
> Make new_len a size_t and use check_add_overflow() to catch the
> overflow, mirroring the audit_log_n_hex() fix.  No functional change for
> the in-tree callers, which all pass bounded lengths.
> 
> Fixes: 168b7173959f ("AUDIT: Clean up logging of untrusted strings")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
> v2:
>  - drop the unnecessary (size_t) cast on the constant (Paul Moore)
>  - emit "?" instead of "\"?\"" on overflow, matching
>    audit_log_n_hex() (Paul Moore)
> 
>  kernel/audit.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Merged into audit/stable-7.2 with the intent of sending this up to Linus
once it has gone through some testing.  Thanks!

--
paul-moore.com
