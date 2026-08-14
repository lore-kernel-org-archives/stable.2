Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592219D074
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 20:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786740567; cv=none; b=AB8pXtJbdWYp7G/5DcZKzHR0UrGrKOyVdnsHF2mbacPkFBNu5YpmSRXE4/bXKaLRSl/NZZdJ9qwOx9vNwSmDW44yXtCAddcaXnSqLYu1wYKnrQvqWC97mJEANbLFwcyjx1wbVUrpD9QS50y/GX6bWZ4Sy3t2qGOrp17ZAXLXhNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786740567; c=relaxed/simple;
	bh=RLRHlnnojGpGiuTqM+Tp6kJR38c4TLqcitL10dDW6hI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xvy/iwkAWNC8i5bHCqFsQ0M75xU3y/xOVuwHdzbY24OvMGxwZ5mnqmSTXxcKTSncOG6iN02C1S0zM5Rd6xaesvO1t8NC2qDD4V6izDgj4lsuXTDBuffap+HiZWUBdN61WGvYrs+x5oGLVixXSBRAaiymcK0FkxwmKoNk/9TE1hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sChlPhha; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sChlPhha"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3811f512167so2088844a91.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 13:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786740565; x=1787345365; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e9vtdPXUolcQyKYgAPulvlLODWa6G5v7VngkgxZZqDE=;
        b=sChlPhhaRCVSv4uziPLpWe7fKriOKRQCOd5NoURSy2a+8zW8V1D0iJzgG+mHSS6DUX
         BsmiOpwdhD0TxWaItyBrh+GbTCylDmEE8tlOUiDklxGns1rUV4pobJuGHzEdtzs85NO5
         e9xzjBSi8dYjoodLOtod31dXjNClWmNN27NpXx3Xn4ujvD4yMj6YJTzf3KlOCnFd6b76
         pGxtGxiqB1H4F+7vBzV2I/tcNcLR9+8hBSVeEHBMBTqyBhl4nEfFEwoFG9P5lTBmx4J7
         WB8CA+Z3dGdo4DTnvwkpX5w20X2dgBerBfEXUFsuvnArzN/x6cErX1ihZpINlaT2fZDG
         c1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786740565; x=1787345365;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e9vtdPXUolcQyKYgAPulvlLODWa6G5v7VngkgxZZqDE=;
        b=HyH4yyHoCokPEGdgmDrNwcr7HBxu4wmRJdT+5OvVgV8RRHUBrbfdanL5uqsy7Lft84
         pHz4Pi41ZPwfmgqCNLZASjuX4ldeIz6bPNgtsPynkob04cH61R3XFhcSSt9AWCGbiI/O
         ozLtLx4I5G21mnJqSDSqWWS0yf8qwsiaYt/u93p/4X0Fki5mFNOsRqgDGgEnRSmWznF5
         uyJUuJkzl3rkiRuNWq+3kFfdJZ8eDjfwGHdi4hKdq6LtQSJ+1cQ1qQafZhRKef7DARxl
         ySJ11nfcn7sQuH5I53naNhMT5RgEIbO3ERu4poWg789d2xAGhBdHwggmz9dzDxCWXnV7
         OxIA==
X-Forwarded-Encrypted: i=1; AHgh+RqZO17+09Lzba6fhpUjK0MLng4/TmiHZlykDrOVOsUQqeUi546g2lsCaoKJVPyEOU8V/1N76dU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg0ZXmnHMhCq2z7s7SfKZfknIHRzhx2MuIDAAqL9HiRVprHpIJ
	ym4CgH+MXA/xoxoSrBOlKgfnYN4iZFLwu1ul9WWawbTM4WWwvyF9amBX
X-Gm-Gg: AR+sD1310wkE46bWKYgUbbAui/iFUGaFKtb58NM93y4nPgwEeznM3t4ObaUYrSyjLVA
	kdxZUs+sSSY+MkhNyb1tQppDbTrFSX750FAMiFNdLDD/YILryZ73fZI8s6H+TQ0x5aACasPC88a
	VIzZWFdMoQ3NLiet/ykJUygwhAtlKxCHfDqdl6vy5U+RTZymMeCVbWaSSACek3ZoJyAI+ks0ryi
	RK+wzJ/kOcmvTiViW0ynzgX9EfJENrwYdWyYoYSt+wbeW8/I7kpr/jyNcuov4TxuxSQstq+3iAt
	nqpk4rTWtIgnP7iykC4YcvTn9e/d8faB8ohPZpFpIrp0yx9flCGZ5U1vbl6fiEKpf0I4xHCV1St
	IKmti6FdjUAZPHydVYqCVvxfs71oKMXKiahYeX2lKXu/VrCyVRDg3agnwF5UxvnFDRsPJ746nnJ
	LyEVyS67RNnfWknEcaV/Ek9YcRo+zPWErFwOZw7MQ85kkUQy7GA+xUuyyc/oyCzhAFvwOojLmdx
	Hizlp639wix/QoO4X+3oROag7/OXPfM0e3Wra1S2793bA==
X-Received: by 2002:a17:90b:44:b0:38e:2e16:859b with SMTP id 98e67ed59e1d1-3933bcf395amr10588067a91.20.1786740565177;
        Fri, 14 Aug 2026 13:49:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:b77:bdad:4587:c682? ([2620:10d:c090:500::6:84a4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1413889bca5sm17673449c88.12.2026.08.14.13.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 13:49:24 -0700 (PDT)
Message-ID: <d87ed8b8140ef404436d7ddf7a4143cb07ef98cd.camel@gmail.com>
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Check per-CPU address
 resolution per register
From: Eduard Zingerman <eddyz87@gmail.com>
To: Vineet Gupta <vineet.gupta@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, x86@kernel.org,
 	stable@vger.kernel.org
Date: Fri, 14 Aug 2026 13:49:23 -0700
In-Reply-To: <20260814203248.3714536-3-vineet.gupta@linux.dev>
References: <20260814203248.3714536-1-vineet.gupta@linux.dev>
	 <20260814203248.3714536-3-vineet.gupta@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 13:32 -0700, Vineet Gupta wrote:

...

> +/*
> + * An ld_imm64 of a per-CPU map value is followed by a mov_percpu_addr t=
hat
> + * reuses the same register, so the register the address lands in decide=
s how
> + * the JIT encodes the add. On x86 R5, R7, R8 and R9 are the extended
> + * registers, whose high bit needs REX.R because the destination sits in
> + * ModRM.reg. Check one program per extended register, since getting the
> + * prefix wrong resolves the address into whichever register shares the =
low
> + * three bits instead.
> + */
> +
> +SEC("raw_tp")
> +__description("per-CPU address into r5")
> +__success
> +__arch_x86_64
> +__jited("	addq	%gs:{{.*}}, %r8")
> +__naked void percpu_addr_into_r5(void)
> +{
> +	asm volatile ("					\
> +	r5 =3D %[percpu_data] ll;				\
> +	r0 =3D *(u32 *)(r5 + 0);				\
> +	exit;						\
> +"	:
> +	: __imm_addr(percpu_data)
> +	: __clobber_all);
> +}

Thank you for adding the tests.
Maybe save some space by just packing it as a single test?

__jited("	addq	%gs:{{.*}}, %...")
__jited("	addq	%gs:{{.*}}, %...")
__jited("	addq	%gs:{{.*}}, %...")
__jited("	addq	%gs:{{.*}}, %...")
__jited("	addq	%gs:{{.*}}, %...")

	r0 =3D %[percpu_data] ll;				\
	r1 =3D %[percpu_data] ll;				\
	r2 =3D %[percpu_data] ll;				\
	r3 =3D %[percpu_data] ll;				\
	r4 =3D %[percpu_data] ll;				\
	r5 =3D %[percpu_data] ll;				\
	r6 =3D %[percpu_data] ll;				\
	r7 =3D %[percpu_data] ll;				\
	r8 =3D %[percpu_data] ll;				\
	r9 =3D %[percpu_data] ll;				\

More compact and no need to describe in length why only R{5,7,8,9} are sele=
cted.

...
