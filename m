Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795668469;
	b=kRXY1w/aQxPwsk89FX8IPIfHEml0iPFZZVIWREudhdspxHNgUIaLovh+PJzcgk5WD9AA
	 YzH9b7BY2zoLHrH4s/rK+K9IyZhH/To6SLOjeo/0ia+E7B53rXFOscG5ZWppMoGhZzcIU
	 mRJmVPw+vDehfHTcZ5f+FsJUgVXaUv0msA+nwxcBK08jgGhIfuuqTBdZ7iAbHl+F8n7uQ
	 VfRwn+rzXNYmbXUY6+WFblwo8R7Us8rqFt9yWakAMXgvdZ8FARmG5lXIGUFykyh/Cwep3
	 zjkbezpQqZ6X8R0vg6tL0QTzqI+4tXE14m0F91e2+1JKgx9DRDx2EGvqjL+aaVVEOVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668469;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=3edPbggb6BiQnOysng16x4194oP6nU2d7iRnCzRGYxY=;
	b=b/htnjMy+Jyi7xMe/gQvXoydrWkDwIEqiG/My+/7qbHTXaB4wb/4U8lagvqBRZIi3ICh
	 TG9Jf//CUAQ26cFtvYqdiBJk3pnWlOx0dOlBLkFy6iB2FrLdINQ2mUTC2JT9nmDZh+K55
	 10ZVPOh+xr3DnkLTi2PBBdUJEn7T2pKo8LMENRsEOATvqpEAfA1jL9+EyfmyEo+K19U5C
	 dWiT/kb+Qb1VQ5SAebEl6aI12NXTl/9o1XDeHWD19qqxwLcCJZY74MW+EetaQgD6+O4I2
	 H0JrsXQkR+vd0sLXaPjNTr1RbEG6vUfiBc43DDLwnq/WuumSfx2Zi9L9HwbX3aML17g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=HojWF0GS;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28252606A31C;
	Thu, 26 Nov 2026 04:47:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28252606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=HojWF0GS
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AD37D40E01F4;
	Thu, 26 Nov 2026 04:47:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id uQXmhZzSIfry; Thu, 26 Nov 2026 04:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795668457; bh=3edPbggb6BiQnOysng16x4194oP6nU2d7iRnCzRGYxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HojWF0GSMTFCj4A9D1eM+gUg+Zoc3WnwZ3SB9hOMGK1ES30F0tkDoh76MIsrrb1s5
	 QUj1twCtWhN3DaMUA5V4mpPI4bbEcVZ36jjiK9x2jfYm4ZQgqnIgd50xG02thbdul+
	 Wjps5TtRDnLUmAele5i5J1PiIC2YuDzpd7gUYw+jQ943TR1/DPT917P3jPpovbYD6Y
	 7y6eObRMNt1q1qfpyrjbXnxcXDJgbdFsiVreGgKxSawnF7MU6tM4BxsEwzCYrSnqdm
	 13Oen3Lz70C5LJp5eaxbM3LJTW1UwOVD34OU+jHSGy4rAF/kDjC1UgNVm0ffMPFxJn
	 1q1FPFM8bIdJ8HDRIDBJBWW/WiUuc/qRBZObV90o3/9tsaJjoRqqCN1QnltAPqBV+h
	 rnEZwSlWqjU46qOJiVR2kQ7XQSN+hyaT6dxWhyJvrceBI9VTkbRDqRhxLcTH2Fydei
	 niv5EEwRC4Uw7BnnK2u9+X9G2tJWY1baMwLh69eKhHckExHeN+rc1jecICQWRMLUNY
	 54+0rYw7E75AsvfK/kk2Otu4Yvwips0ZhEwbr+AfQa53xcgF8k38wZQeC7Ov8pKXoT
	 jzOpKngnTuORVRsog4ZJgUXDiTCiPS4g5usvOONcdpDWGo+nXhcyI87WfrEiw1iG/8
	 +jQtxsoIbJAHZeaIkkI+h0mc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F188F40E015B;
	Thu, 26 Nov 2026 04:47:23 +0000 (UTC)
Date: Wed, 25 Nov 2026 20:47:20 -0800
From: Borislav Petkov <bp@alien8.de>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: x86@kernel.org, puwen@hygon.cn, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, andrew.cooper3@citrix.com,
	david.laight.linux@gmail.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, yangzhen@hygon.cn,
	dengqiming@hygon.cn, stable@vger.kernel.org
Subject: Re: [PATCH v3] x86/cpu/hygon: Work around XSAVES Erratum 1386
Message-ID: <20261126044720.GDawe52PLY9WWihaLw@fat_crate.local>
References: <20261124142632.844105-1-zhang_wei@open-hieco.net>
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
In-Reply-To: <20261124142632.844105-1-zhang_wei@open-hieco.net>

On Tue, Nov 24, 2026 at 10:26:32PM +0800, Tina Zhang wrote:
>  static void init_hygon(struct cpuinfo_x86 *c)
>  {
>  	u64 vm_cr;
>  
>  	early_init_hygon(c);
> +	/*
> +	 * Model 00h is a valid Hygon processor model, but x86_match_cpu()
> +	 * treats a model value of 0 as X86_MODEL_ANY. Match Model 00h
> +	 * explicitly.
> +	 */
> +	if ((c->x86 == 0x18 && c->x86_model == 0x00) ||
> +	    x86_match_cpu(erratum_1386_cpus))

So this can be:

	if ((c->x86 == 0x18) &&
	    (c->x86_model <= 0x6 || c->x86_model == 0x10))

and you don't need the _cpus table?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
