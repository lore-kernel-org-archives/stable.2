Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793292262;
	b=ahpbBF7066ddVrJrpCvW7pUgPW/qbW82QGWaFWC7CeuuqAYpFmIFmvgJXlHOYDu1dpnj
	 7qrYiLku/1f/xqOaPLpsMliHmqOuT0UlciF7Dx6CJIIqiXUfTp80MhRohpfk2NPzfydt+
	 Wa10+SCdBf7ml67qqND2ydk6tcsuanlfRFnk0xfjZpsNpWrGUCY/Y+uVowP01bmbDz93v
	 zOsrElWBMyXR/9DIcjBPUOn7BHq22hhRmEOv1EmOsVzOlbXQ9wRVe/dI5fxc/2hajDuO3
	 TtJTfnIaem+Q8JEP8AZZWOPRnke1p2n9GqTcOWIjdrewK72HdCBvsn355vfdFYYgmEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=b3+y3Zx9Shf/DUAvT1EB/38PRALBhEtVxrkr32O/5Hw=;
	b=qY7PrdhLmtrwmJLXP8+kX6OK+rfRBl9LLV/2ULxjkYPamtnSFQofU1DXmGMNwmJeibg3
	 utErJLIgPldwsgGu2bnqS3KXd1CdwEzuZoSl9EnfHDbzK4tqV5g5kYJPwU4w6+0ANsqTU
	 TXSfENLf9p1pEHaQHMkkTDjlc343SOeyG2hkQzo84soAXfPEF+cWb/cUXWchJr445wWsz
	 Nyp6IeXoYdNiQTA4u0gdzwgO5lp3V+uOl4151fF5LM92kSp9linDZti1vXRZ52HQqTKRA
	 WdJO7blnmltDf/T19QGLUsrqFe9+zkZtOCNd/G7GDv0InzutaXGC2XbH2PEaF10wtxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AAGCmWWE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.64
Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCCD606A32C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 16:44:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DCCD606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AAGCmWWE
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-4511f6a63edso271094fac.1
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 09:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793292261; cv=none;
        d=google.com; s=arc-20260327;
        b=ia4xdMzrfV2C3Ius+U2ZPMK879nCevdNXhGB7BnfE84M70A48tcn8YRgTMWK3+noh/
         ISV/p/VIbnvkqConPxnlRcd5oT/13RDAwBwQAD1aNdPsylSSDdXhNfLiUOuuNGIySkJN
         yJr5KLT/4263qjO1+Xl5VAYovYbIdErNmXTX73elcQYtWECFapCQYnLwu4Jy7LMXwaVf
         aB2OHo8EB8hKDU7Bu7rbZBe6mzqkGt4xMUDMAzpy5mzV+NLkuQlxFupp+Sv5AjtwSYPV
         k2dwgb9glCmVPNHY66rj7p1LPTHdb6BUx021LEHfVhXPWhixCQYPKhWAI9MQKbq4uxmj
         3SCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b3+y3Zx9Shf/DUAvT1EB/38PRALBhEtVxrkr32O/5Hw=;
        fh=TM1uZkQ3vCCSK/57dvv/fTIhN71DhxpHLCbRE+qBtjc=;
        b=I8dVo59KVk8lLarp+U8kzIH/byRD09NzXK/KhD5nTJy2jhQ6aDL1UunjdFjuBRi+ip
         fK0GHK+PLxM7DPX/pSHiB/Z3n5BfC2KqN9amqMK01Nmaf0Bj9H9KIBYg9nl/KzISpDCP
         /ks6/KaTh/zOLC8jMAe/MUqtMbebX7R0lNQ81S0/vxRcVdX1gJCkA1jbexx+Dw+11AKG
         cX0h1uxJnkny4x+Uz+P1TXgHpmKriratovMtSPwnv+vvpjoj0iKv9aHL1MuPxej5iqba
         VuZJ1Ahguchtj+BzKcGoznAIVjDCkQmyOJt7+PJ7VNLLAejF6e9PozR8OdgsCsBmIvbR
         bS7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793292261; x=1793897061; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b3+y3Zx9Shf/DUAvT1EB/38PRALBhEtVxrkr32O/5Hw=;
        b=AAGCmWWE4tApKkseEkuGhwQaDIuvXKoBEP7SRmhW41ihlMKO+4bZhK+iS27ObPnPFP
         W9mn2giAl0C5EPi2aGu5+JB5AYe8vcltVgsTQRxVM8RhAe6cHkXtS0jQxbsHav63AEho
         ycRIJ2opAcbgBREJIKoYk9C84et5Zb7zTy17+mBcnIvdPOEjJoBnfS2pTf71n+qSRQ/M
         6NC7uCig4PX+yFvfQhqaCPpXxbnuvAOs+34gUd7jDS3Vkt5hORPPehD+8JwXuQ+DYHHM
         2vWWCETwhtajHRNsaYgW6iBX8S52a8p1La0IFhDg4RTyLr4Spf0kOPQ8GmAcpB6h900H
         591g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793292261; x=1793897061;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=b3+y3Zx9Shf/DUAvT1EB/38PRALBhEtVxrkr32O/5Hw=;
        b=b2rz3yCeYTHPyBHDezusxRI869idRlEfxjmF9vYHv2JGZVdMKrGXyADeyeItL2GWki
         egfdvHzdsQiubOfmi3fDZ0hhzBOwPw3FEl0FBDt6x8UIslo4UbfIzsjoBPNNOsyCbRdg
         RLIJ/l7L/aPn/w5SIUKVB7Rj27+KOorLdZbGzAFL2LhHf9Yuni/P9yduNh1800d0RLZz
         jmYnxB6Thpbc1/2h3RF8ojAJ6Tp04Ho0R+60mNLm9NeSOmwHaQtXwJqId3GiyWrm7iIL
         6YQzHicXkKHsKqteHUGaeuCASsfHxJv6MRFO3X/35LsM188exYuchsKm31j99vw7fiGB
         boiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzoYRM4HRttwMwdDWPTdVzE/2fefW3GvpjNvNdqrP3m2XIdgZ0Ok4wiHFEzfFKve6W2IeCMh8A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcErRnfdoPqmm99Xc9kC5NypPuviX32CC/m/OL564QjwFKZcFS
	FEEon4YNrRh2q+xVMP3L/eqt0G7G9YxRi6cg9pVb/EgTbVTJoqHPdtUgSwX3M2/NMB5psoJHyo1
	N/6/FIbFSFsAhMy/lyVjWS6akIClmLs4=
X-Gm-Gg: AYBFou0jCXT9opPvSVCiuyTOpATAPh5kFqfQJGAh758MvUG4ikVcGkdBRUpL5hRd88E
	+m/ZOkA68G93Q3Yid58fZvF/7MjkhD7IdpF2ZvshhJguVs7qnq9YGDEd8wdifrPuixgpwBelbQx
	vIAxmaA/7H5ret+4fn7l4CcHq5+y7QRgBZa34ljOKR/iZWgVzBJo9hpgYOWtC8qwD4m78A9Vjbp
	B3uTO1b0phsLbSjsEOGrJeU8cwdAPbOSpbLjjghcyBVWTuTHai4YkebDzFl6XdjBn+2WLJR8Gtt
	hAw6gtO7kYAcsql6Sl2384AvCGEw+ufqVok57zRtst3wGTp+rRHBtxnWv+afxEOAQo8M+ZSZell
	UL8+KBn7Ao6ym4hQd99GsS72+lEJeJVmvm9Jqnl+25rDRqJjo1hmW6ohkOIEwsMtAF8guB0Sh
X-Received: by 2002:a05:6808:3197:b0:4d6:90f3:74ae with SMTP id
 5614622812f47-56384197794mr4379953b6e.46.1793292261209; Thu, 29 Oct 2026
 09:44:21 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028154008.67451-1-dennylin0707@gmail.com> <CAOQ4uxgDmhddqpFawaK874cfWCp4jVDnE67eqXyDA9eumpMEpg@mail.gmail.com>
In-Reply-To: <CAOQ4uxgDmhddqpFawaK874cfWCp4jVDnE67eqXyDA9eumpMEpg@mail.gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Thu, 29 Oct 2026 09:44:09 -0700
X-Gm-Features: AclHuK_1sASlVUtzDN1GpkTnsvtyNbxnOAThii4_r-uX-r_SWsslPNQvF3mBN50
Message-ID: <CAGEkeHdXVTQU7VS=TxPqmsXMtFFeP=LWw-y04NmcRWJrwHa8mg@mail.gmail.com>
Subject: Re: [PATCH] ovl: restrict casefold consistency checks to directories
To: Amir Goldstein <amir73il@gmail.com>
Cc: miklos@szeredi.hu, andrealmeid@igalia.com, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I am asking because I got some patches for overlayfs casefold which I do not
> prioritize because I do not know how widely the feature is really in use.
>
> If you are interested in reviewing or testing said patches, let me know
> and I will send them to you.

Hi Amir,

Thanks for applying the fix. Please send the casefold patches over;
I'd be happy to help test them.

Thanks,
Hungyu
