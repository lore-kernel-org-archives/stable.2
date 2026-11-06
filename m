Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793987586;
	b=1ucDLsy/hpcFWwD85L8VopxPQwtouK0g1nrH7RmlHpeImR+eXArhfoNMRIlFB3yddXpm
	 FEkWn4dfHLbr+jZtu8JVWK0xV1qHJzRJw5XZmdMyYMF8WtfvCRvy8EEFbyKoQKiQ+wAh4
	 Ju0UfVFjwHrTLPUcCJXfGhq1yq3vRJwDZxvF/Jmf/GIzxeCro6p18X/IB2rAYG0U66Cmq
	 xqRNJIHxI8JXHxjhkKvADRvuelh5k58VJ7A4tdOsoz2CzbF8wggr4kXP9sd1/olJ3r+2u
	 nll3quDk/20v+dHbk6UTz/PugXVGCePACtOZ1rGPa3+7iQZ0e4+/Xq4rT39BPWrFUgw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987586;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZZ43LFlhd+sk5fh/FJb4zHzz1CW3FUt2jfsXu1lejAk=;
	b=pj6y7dpSVdmxG8k3zIbbnW2Ia2sLQURu36iTymM/usKXsE0q6dpt4FQIEhqylo0Bioak
	 pOOcaUYmkDsVHhaDfc3FlAu1sr9jbKu71YhiKr/Vv1SGShnkG1T27zRjn0ShbUT1E7ewe
	 YUYDapsSt6YGyiwQKBizgw0EVKN/ib1NaWTk18qO2wgBRBWDmyEGZFn3HcIN6v4J0z19h
	 Da8P4lkRQfs+rUgWMhbftBFb7virbU+CYBiMIJYlWyYcLIDgGHi30djY0lBnzo++ze0pq
	 WFx2rp12u6WXApF2sBSDO1/FK/iXPKXf6DR/dGeMQBoz/8uAJx3R3DOtevvvqDoMjDw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NW8uuGdo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAC6606A332
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 17:53:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBAC6606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NW8uuGdo
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso10178365e9.1
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 09:53:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793987584; cv=none;
        d=google.com; s=arc-20260327;
        b=Tr5/7gHRy6xX9MyimDvwpkq8d9O5Vi6p/CJ0r40sbDDdoty0Emc4yDl52Dk8x3ooAq
         Hj7h6oxlQRE7ao0C+5dmO7FQ0p0/QZlg/jlqHsr19xFwm2tLJW07JAwOYmNoYerd3nJm
         Io1tZ6GNlMJkaKZ/jOwExb131fEVDme+T6DENuvnimK0M933XnwZAGqRYRJC6WOVrOBh
         LurvyqBIi0gyGL0pcQOsZu8b6Fvt7TZgO8wpeiVtksIKn0HWcYOqe+URc2Akqvdiqs17
         rEiGa/Hmv0welTBFA/kldFMgVJnT3amJPfEnUMtFUnOvcq7e6+IfUGc0ShmESi6+3E9g
         dXlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZZ43LFlhd+sk5fh/FJb4zHzz1CW3FUt2jfsXu1lejAk=;
        fh=dVqy6pSPzzC2y146PWjEWt2AD94vQhnZKPRHLs2HXFc=;
        b=JtpcLH2xBkxPpDf186Hnrf9pczsv9RqkQoHeFpwU0zu8iU/UFVXVtd34N0yOX6vmUG
         /KXsKd56SGqziddMYWvmKdtiPrm3oot1jVrkLZycpeNDtnnU1zyJVljxzIAoCs1NCnj6
         N3NOb/NePSVv6ikm4UPckADs2TCGUHAg3sBIPT+wjLkdpTUQI+68eoHTJs0XLkgy60ZF
         T27kHuuA9mpic/Uktd4Clrh4j2L7i715Yjp7DUOMxnoDiX7NBXHA7807e1gvjZanSt96
         Qf8/xHjkJaww7lmcPXtTv3NSauTzLgLTRYIur8lCDRtmCRifX3jFl94uiLUSgYrGFief
         fUGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793987584; x=1794592384; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZZ43LFlhd+sk5fh/FJb4zHzz1CW3FUt2jfsXu1lejAk=;
        b=NW8uuGdomYzmuDtrXAWjZ1gtLZzmP/KNhlvC6gK50mW7XxvuKLLOP7EtsCLtPqcsjr
         CVhVoqc/CQmnXOg48fJnD/JELJAgh4f17SX+kNmO+Swc+gsoVLoszlZRfBN9BT/HYA1Y
         pT0aN7LyWPUNYf6+pfUM4omNBOYoHsgyvTFoj9xnJMSx305fiCvitTUSnTMK+hwxYgJF
         8X/qVB0ZP36kaX7C1IBDUGacr/M84c8WJU7AAUqSsSFBymFezWmF3SGZ+dLclXmyfNYp
         /hkKQ/z7Z0+SBl7ZAXfJHodjznt2X7lj8z6XBADnHfKKdxjOaUQIAGL22I30sDPxKhWT
         AzLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987584; x=1794592384;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZZ43LFlhd+sk5fh/FJb4zHzz1CW3FUt2jfsXu1lejAk=;
        b=yxsLwQcllJakXojSDkVPOI07+M/0J6HIHhFIf4gsZch4YVktPehsLjXxPCEKBQEkle
         TmUxPLMIe7WOyyZ9ox5IUkuRI9+AcayV4Blcp+dDWexr/8kB+xwXpwwA5Rz62R20Xv7t
         xjGT6lAPZKgPryqeYP8PZqf/4aimv7E7ZZ2qEP+4Ul6zPJ8CKEKQFtfl/jMXQMeHIEC9
         D/c9hmVy5VHg6T2UQrAO20Cdd7QwAvn89x5ymjXiaBCcEga6oZ2j80fA9b95MTRdZPrT
         CjLFqIDmsnpYTp9joshWDwLK1k675fFOoztSkxXH5qHWKPkPAaPE8TVP288qoMVxC7FE
         UJzA==
X-Forwarded-Encrypted: i=1; AKwUvBynsukTyC4PRIuxLLMYtQbKEMnH+CPuUuBXGr0fu122II1EiQIo+jebB6GI/hf3Og/phHBeFvA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/4mOs0Gpc4SrCQkqPIAI7ttjp4T6WwH46fZJmPTm9qpO0qItUD
	AsfL44Swgo2sVS2hAoFNATdrTKY+clfWrHmLQb5nf1aDwYB/+Drmq8wqIRCKIpJRKhyFlZKYfZK
	Wa7zbRtQOIdwFXWEayN6ipYUlOi5Dvu453CxkCIv3
X-Gm-Gg: AYBFou0NoBcBN8arycFiViD2smXz8y/n++Q+yr0WBp4eGvuHi2um2TsS4nvllQBpUiS
	CoDJXc7+VqnIfrtRQfY6B6loFVOoIGEMgJvGZsLQ0Cpa9tvgMTnSVC9gtd3NDthjY1ujVE1B3Hv
	tLkafNdAr/Yma1/NQPa5j/TvwG3kYkWwL6NOfz93GMGPFjlj8B0blvh5MnOQsayWFVmCX8LwsHc
	y+mKmFWzCnjnMZS9xNr5LRKtq+EGE6wdcBPsr/U/7vJjWP6VyAsxaG1fneRxn9DauYsyZI5HUe1
	oCD6hv70vAgmeF28hG1M6QRxb04J/9IQPFvu50JPsd1aPjK60mFyc95yWrtJ5LaiDXSgCcQMALK
	0sTPN1bdZej/hfcH8dqwW/kSnyqLTOgW6TJxcrWsj0rKJ0nUZjvhunZfw2A==
X-Received: by 2002:a05:600c:6387:b0:4a7:9025:5c3b with SMTP id
 5b1f17b1804b1-4b6de1c6450mr56262855e9.19.1793987583819; Fri, 06 Nov 2026
 09:53:03 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105151159.1.I0b27923381ef34cc99cdf8b65fea2e1bafce6370@changeid>
 <CAF1bQ=QkGntJu8G67ssH2dS3Sn200_JuYitjtAfNPBu_hn0fZA@mail.gmail.com> <CAF1bQ=QiP4fb-+Kn8wzEH7wqjAjZaagxUd3sYpv2SkwDcnFPWQ@mail.gmail.com>
In-Reply-To: <CAF1bQ=QiP4fb-+Kn8wzEH7wqjAjZaagxUd3sYpv2SkwDcnFPWQ@mail.gmail.com>
From: Snehasish Kumar <snehasishk@google.com>
Date: Fri, 6 Nov 2026 09:52:27 -0800
X-Gm-Features: AclHuK9INR2TnwJM3Zpn1cFZ_averI8IiQe0rbAuzb--L9go7NViW8h1McGlP0Q
Message-ID: <CA+aGii5ZbLRMsvOZ=Xk_gS10O_WgjEc=oW9vJ2yYPrRdwpZbZA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: AutoFDO: Disable Profi (-fno-sample-profile-use-profi)
To: Rong Xu <xur@google.com>
Cc: Douglas Anderson <dianders@chromium.org>, llvm@lists.linux.dev, 
	linux-kbuild@vger.kernel.org, Han Shen <shenhan@google.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Han Wang <nesthanwang@google.com>, 
	Nilanjana Basu <nilanjana.basu87@gmail.com>, Yabin Cui <yabinc@google.com>, stable@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 9:43=E2=80=AFAM Rong Xu <xur@google.com> wrote:
>
> Just one thing: I think we should also have this flag for Rust so Rust
> and c are consistent.
>
> Rong
>
> On Fri, Nov 6, 2026 at 9:38=E2=80=AFAM Rong Xu <xur@google.com> wrote:
> >
> > This looks good to me. Thanks!
> >
> > Reviewed-by: Rong Xu <xur@google.com>
> >
> > -Rong
> >
> > On Thu, Nov 5, 2026 at 3:12=E2=80=AFPM Douglas Anderson <dianders@chrom=
ium.org> wrote:
> > >
> > > Starting in Clang 21 (LLVM commit 2fc4a4a9d3a8 ("[Driver][SamplePGO]
> > > Enable -fsample-profile-use-profi (#146795)") [1]), the Clang driver
> > > automatically passes -mllvm -sample-profile-use-profi whenever
> > > -fprofile-sample-use is specified, enabling LLVM's flow-based profile
> > > inference algorithm (Profi) by default.
> > >
> > > However, as Rong Xu noted [2], the kernel's AutoFDO implementation us=
es
> > > flow-sensitive discriminators (FS-AFDO), and Profi has known issues w=
ith
> > > FS-AFDO that degrade runtime performance compared to LLVM's original
> > > profile propagation algorithm. In addition, Profi's min-cost max-flow
> > > solver (applyFlowInference) can hit pathological compile times (30+
> > > minutes or hangs) on certain kernel control-flow graphs when profiles
> > > drift slightly or when combined with GCOV [3].

LGTM. I've seen degradations without FSAFDO too, reproducible on SPEC
workloads 531.deepsjeng and 502.gcc while controlling for profile
drift with newer versions of clang.

Reviewed-by: Snehasish Kumar <snehasishk@google.com>
