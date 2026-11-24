Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795486786;
	b=TUij7APPY37FAo2nBY4PZGz7k9x4seKLzYe36cWxQ/OtMJ2nEA3aU5SX/2niPphONxos
	 G+6LrD94UwkTqYWa10/8NLcDm+qmSA8IsWsA41kvl9HGrWFraSz1DtskZ1btw3bxS9gKX
	 PyOQdNIvmDFSUVouH367bvbHtaG6ckGJxZaYR/uAyHlcDkfHTE91d1HWPy9IcopmYf2U3
	 NvKyDvkD7bfws+mw4GSrCyIOphVUFgFB4bgFvt1TynFw43B9+IpA/wGb32vw3umt4WZIM
	 8oBsy3alAf+5q3XynLAE44JVvS+jgbYOne+v7JA8oh4b7Dze24YX6Gf2YAd8Fp18RoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795486786;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer:From:To:Cc:Subject:References:In-Reply-To;
	bh=vdBhioH55e2rBpiMMIlOy+uYTgZqubhBTCUnkYbH854=;
	b=1LO/+C/sUBCE90t16rCaybjT3me6LXOJMB4M72DE6/pzR4NK6QJG/lfqVqKu1Ag/02l8
	 BkpmUSuJbJkKr8hSr4tuQMD4s0gV/+notUo50UIKFmpPdIHn2OTE95YsLVCT7BZgp7XE1
	 TOHRef203LYBCIo52RwfLEC4HFt0e/AQNkpRWmPqqXyFCYiHUfk6+GvIGWZiYPB5Afjwj
	 L3c6tnb2eZ62cHxgr0Sjb/YjJd64H/SDx9M5iYEgvQLGIpsL8Q3hGvk+2GHy2pPiGCTdE
	 GrYgzVzzKMTbzcE1RsfrrDMdT+iGjc3W+FPrXjAcTlHJBZhIZ3Ivam1eeF3lLNjXJiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=gXLmoeGp;
	arc=none smtp.remote-ip=209.85.219.54
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15D9606A322
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 02:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E15D9606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=gXLmoeGp
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-9215934a14cso15180186d6.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 18:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795486785; x=1796091585; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vdBhioH55e2rBpiMMIlOy+uYTgZqubhBTCUnkYbH854=;
        b=gXLmoeGpp4YC4I6mCpHK2JTvgYkWuqbvABel0yKurKWRD86NbmnEpxOCsbDHXlGUfG
         90ysuBuVV3x0DumZtT9aZ/ZMYHhmBy129SlMJwiaN8mAMmz94b1JeI8fEf6sRhtwa81j
         Hs3DSUfs3f63rbs0OuWXTugp+WQHby0xxjMT3FkjK1iEI4yDhlE4ARTLT1uSz5UzDshf
         SV9ToAVyt3jXDngs7GhS5kJknl+DexPchuFfLV03z3rNdFKMSbp5yx7q/zNMseIEXVlO
         lON1hdivcYRYe4Eu6AJ54f6kYbiDY+fOh0nj0OVFyMKjghqT5tPUzbqrQfWKUaAl+Hjm
         3CTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795486785; x=1796091585;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vdBhioH55e2rBpiMMIlOy+uYTgZqubhBTCUnkYbH854=;
        b=D85G5BV4zENC4AidY+PgJSMIPpBXhEaspLCoZ9sULMCHOgwVsNSLPV3/MXMmnXo0WS
         w8PsA7XRUB0PW9qJTronjU1po+R7ysFUNqbx2raWFqPZsfjOTUeJo30ugeeqPOgZGPin
         NYZCnfPCAzhoFYcTJdrrIWd7PUY0am4RXgFWsjYUqT83l49zmrgDT8osRHHijELafWS5
         IkwnWswpbrWToyirgTVfzAr2dGDulbOdu7YRbN39z84S2yjvVdbFhMOTFdAueE3Mu/7d
         bp2u3YEsvatln0VKtIW6ZesLXPKuxlhCFQxrLMUmmDEmk1tAvGipcr9P5mmDTFmZatyA
         BXsg==
X-Forwarded-Encrypted: i=1; AL+hErEBk65epeikyu1zwSD1yp+8J1dQQuwOhcVoAA+Y0DTb3xPzpNlQwqt3lnMvtlju+u/6vekTdIc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8CIxOxcUqKthIFkY35ugNvUPDmP8doJMRj9hQF4iUlx5DcfGxk
	6L/JU9NloJ5v1shmhcWALoV1kn8wr8oXbB6AP71/SXlgewiDECyBAiznRUqj4QAFRA==
X-Gm-Gg: AZFdTZdUZSZK3ILLmXxvn1+zTFA2sln12i31gL8OIDFd0gJCWRLWYnzzaXPl3zLS52m
	3Xk4CoUENgvr747+i6ygVyBb+k2CzAT5u4Bld3COixCxKI+1K5xgPUSQ9lvFWqI1/c5Ei7vwQp4
	x6bT7z/K0iswFtk3lrgCmwO2Gh6G5XN0jquz6WhUkuHl0Gi8bSDcdA+NVSe1qmcvNz56VomUmMH
	CfwI8Dw55XPJ4sqlSj0eRGeGh3OaW8fZEvzdpgZ20GnkLqej6aewQcDJ3LNN/mx7KWxi9ulSG0k
	3Cuir6sI9ltr3eGNEowHaKs2DRlCoADadBrPctgUyB5MhLl26/7k2gSE8Qfdg641t0EPmB3TuVX
	qz+D98d+qZXFN8IDwNeVj0GhJE8keKhuA7TBZW6/qp0o5e0VH2R6SIpb5YgNEM8rbsS3nhR1h67
	uCXDEC2Qxu2WumvdP0zVP3N4BBJdIPv8/VFJ7n/yu9N7waSe4qbX5XZ1WjUAKKjQ3TNIyPtFrfy
	Yhafzf40DnHe4PLVgTPtgR5dJ51AqQfbukGCWBvXAcOmXPHgARwkvsmIqh88SGnLrxdRXacFlHo
	Rs/3TiUVSPxWWUZAPggtU2kLhW2F7MDlL/viCeDkFEa8N8q6PShkjItgmQ+fXO92pU5597DVWLb
	BuNDGJ2TEdYw8Sz8JB5gh5XDuy2h98w==
X-Received: by 2002:a05:6214:194b:b0:921:1783:1696 with SMTP id 6a1803df08f44-92134a37126mr252343606d6.9.1795486784823;
        Mon, 23 Nov 2026 18:19:44 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213479655asm122232776d6.4.2026.11.23.18.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 18:19:44 -0800 (PST)
Date: Mon, 23 Nov 2026 21:19:43 -0500
Message-ID: <04e583c2e9045e6a8990d752a1a2d1eb@paul-moore.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20261123_1724/pstg-lib:20261123_1443/pstg-pwork:20261123_1724
From: Paul Moore <paul@paul-moore.com>
To: Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae>, Stephen Smalley <stephen.smalley.work@gmail.com>, =?utf-8?q?Ondrej_Mosn=C3=A1=C4=8Dek?= <omosnacek@gmail.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: selinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, stable@vger.kernel.org, Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae>
Subject: Re: [PATCH] selinux: reject a 65535-byte xfrm context that ctx_len  cannot hold
References: <20261124-dev-v1-1-00b99ee684ec@mbzuai.ac.ae>
In-Reply-To: <20261124-dev-v1-1-00b99ee684ec@mbzuai.ac.ae>

On Nov 23, 2026 Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae> wrote:
> 
> Commit 86c8db86af43 ("selinux: fix selinux_xfrm_alloc_user() to set
> correct ctx_len") made ctx_len count the terminating NUL. ctx_len is a
> __u16 and selinux_xfrm_alloc_user() only rejects str_len >= PAGE_SIZE.
> With 64K pages, str_len = 65535 passes, and ctx_len = str_len + 1 wraps
> to 0 (kmalloc_flex() stores the same truncated value first).
> 
> ctx_str[] is __counted_by(ctx_len), so the following memcpy() of
> str_len bytes is checked against a buffer of size 0. With
> CONFIG_FORTIFY_SOURCE this ends in __fortify_panic():
> 
>   memcpy: detected buffer overflow: 65535 byte write of buffer size 0
>   kernel BUG at lib/string_helpers.c:1044!
>   ...
>    selinux_xfrm_state_alloc+0x18/0x24
>    security_xfrm_state_alloc+0x3c/0x6c
> 
> The memory written stays inside the allocation (65536 bytes for the
> string); without FORTIFY_SOURCE the context is stored with ctx_len 0.
> 
> A user context of 65535 bytes can reach this hook through PF_KEY
> (af_key.c only limits sadb_x_ctx_len to PAGE_SIZE); the xfrm netlink
> path cannot, because there uctx->len (a __u16) includes the header.
> 
> Reject a str_len that does not leave room for the NUL in ctx_len.
> 
> Found while surveying callers of kmalloc_flex() whose __counted_by()
> counter is narrower than the count, with the help of an AI coding
> assistant (Claude); I reviewed the analysis and the fix. Tested on
> v7.4-rc2, arm64 with ARM64_64K_PAGES, FORTIFY_SOURCE and SELinux, under
> QEMU (GCC 15.2.0), with a KUnit case that passes a 65535-byte context to
> security_xfrm_state_alloc(): the unpatched kernel hits the BUG above,
> the patched one returns -ENOMEM. The PF_KEY path itself was not
> exercised.
> 
> Fixes: 86c8db86af43 ("selinux: fix selinux_xfrm_alloc_user() to set correct ctx_len")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arina Kharlamova <arina.kharlamova@mbzuai.ac.ae>
> ---
>  security/selinux/xfrm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks, merged into selinux/stable-7.4.

--
paul-moore.com
