Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795245307;
	b=oqNym7p77jUxi/KC35/YvAPn/na5JwDYhZBNX9g6Lk2FaI9biVK81QBm0anCQJ3p5yBB
	 VgLcUNmrOUi0XYl555TKc0MQMKJ/5KI+5n5xZbBeMtkGeKuj/yUCVzetL6keqGnvm6LRC
	 vPStJAiZqBeJFvRkgzQBrqNPa95oZZlZRh/TV57GJGFAyox+6c6iDYl6Wa1GWSW/sBBEq
	 U1EHvRdO2lygj1J5YFWUNePJvzqoHP4i+DjGcXtYY3qC+Vl41qKvecK9cry0CZEodj0qs
	 hZ+0RkmTG106T/UFrZ0wEehA2TjCOnR72hGGDfTWTUXQAmle9U/buFjctpJHHbGeYMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795245307;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=jphhe9W5UCk3gjzh2JeM6aA2VjvVddfIzmTZSGQzdgk=;
	b=I1d65z6iCn7/hmlIYHhojbOUN5U+fkOomBf50dLsnvvMe5AGZwDUs+q0ACkhnE+wIH9j
	 kjmOnfuRIMRnKn/ApDlBCir9+00HHlkuOpecNtSfRzinXJJJQcpKeY/sSGcvYEvyEZPJH
	 aeYeCMfjpXIs0Ls1tPVw0XJuATpbXRivSUWrclVXP/LyGE301YrZFUZFFsaJwKBCcGNzu
	 tZPXKOAncIxp3WHm2zDfHpOeo/AQZ33xxJA38hZ9oYay7T1mOqK63aoVJE+KRwPpQrVz6
	 um2sWjNOPgB0QHJkAIeM1YFZGsg9eX7GUpftk8+hGgSxKKQJ+IT8TvUcG+23k3HvumQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=KRAkMRMz;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B15A606A330;
	Sat, 21 Nov 2026 07:15:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B15A606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=KRAkMRMz
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A8E7440E019C;
	Sat, 21 Nov 2026 07:15:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Eh9b41Hgcbm8; Sat, 21 Nov 2026 07:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795245300; bh=jphhe9W5UCk3gjzh2JeM6aA2VjvVddfIzmTZSGQzdgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KRAkMRMzGvaaTbQZeWRcJDP7JApPv4vvgEEXB0iHkyPT/kcEV3qlPMnBIBmdDkn2o
	 xXawBFlgPOKCKUxEN6JzZ53RcodD0bs5U1wSxGPdkkllxodjBNJnqcFFk7GvOxTqbp
	 Bz6ZmXQPS2bSvo5ax3aHWOhbclNW8/l4N2gD201baFoP+qU1+DpLkWQlOl2gT7Atjy
	 PY/BXuJjtudsAO35NXCgXCU5ct+WjMzFzHjX1r112pNarFzvIuN/eIfKGFNW+qbJSd
	 9Q7ZdhEfcShWglKUBJ+8WFxFBcFxVGgZEAX7i+pCKEQSQZPZLGqb0JhRNDfyLM+M0Q
	 c20WUsaqJCEWBbuMl0QnFsFvYZ5A0Dh8iCDamdTsf+8h98JTdBafMAe1LOQRjojnLJ
	 blur85K83lZe1ouPfuvatlMsaF7Wm9ltPLjhbIqBqWpd9ytxSYF++lusNV+NANs9Rp
	 MZCX0yTjI6O/dgygCX4DUxdyF60BV6bmp6JJz+u5Xbu3WHvFX+mNO11489S7oEeeQb
	 RE9Q+LasADwPRyHK++PyJBb3QNNkV8UTIoYVPT+JJ1R11uIsIWx9pRszzUgiHS9lZy
	 MqCzWd7Gm2SuRm6vV5lwfvSaaClzRIsBu3auQpDxmPkA3XTqQE+FIT/FaBPtM2BOzP
	 RS9VnAbp8fKdfc3GGYanG/ms=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DB59240E015B;
	Sat, 21 Nov 2026 07:14:45 +0000 (UTC)
Date: Fri, 20 Nov 2026 23:14:42 -0800
From: Borislav Petkov <bp@alien8.de>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	dave.hansen@linux.intel.com, david.laight.linux@gmail.com,
	dengqiming@hygon.cn, hpa@zytor.com, linux-kernel@vger.kernel.org,
	mingo@redhat.com, puwen@hygon.cn, stable@vger.kernel.org,
	tglx@linutronix.de, x86@kernel.org, yangzhen@hygon.cn
Subject: Re: [PATCH] x86/cpu/hygon: Work around XSAVES Erratum 1386
Message-ID: <20261121071442.GDawFE4rWdzLeaqjoH@fat_crate.local>
References: <b04950ad-d655-4ca2-8cbd-59360509d25b@intel.com>
 <89a5aef2-ea88-43d7-adcc-3f6b7374932f@citrix.com>
 <46d14366-dd1f-45f4-abc3-4d9dd8c32e7b@intel.com>
 <991d9608-fb44-4bcf-8ee8-b0a398899217@open-hieco.net>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <991d9608-fb44-4bcf-8ee8-b0a398899217@open-hieco.net>

On Sat, Nov 21, 2026 at 02:46:31PM +0800, Tina Zhang wrote:
> I'll extend the existing erratum_1386_microcode[] table with the Hygon
> entries and make Hygon reuse fix_erratum_1386() instead of duplicating the
> workaround in hygon.c.

Sorry that I couldn't jump in here earlier. Those folks are all giving you
confusing ideas, don't listen to them... :)

You simply need to copy the amd.c code and adjust it with your numbers.

The reason why we're copying and not sharing code with AMD is because AMD
cannot test on Hygon and thus risk breaking Hygon or you vice versa.

So we have it all separate, that's why there's a cpu/hygon.c.

Once it all settles and once we absolutely cannot live with the mini code
duplication this causes, then we can start unifying.

But that time hasn't come yet. For now we will do all separate.

Thanks and sorry again that I couldn't jump in in time.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
