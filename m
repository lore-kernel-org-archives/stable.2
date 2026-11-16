Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815911;
	b=R7exJbymbj7buIvuLyEHOXoHoy3dSNRHrnEiif6baP2trxrIyJi57p8GddOasE0qLeBs
	 7DJMMRI7dPwIsNtaLKExHKbZYHbjd47eqebBd5nh+gG02Jc1p9k63bw/seeIYJwSKNo1u
	 KPCFuuE04spVCNqgEk/OtTIkpbinhUPr/aLnQMTz/0DtYpyVTy5g5WkKYaqCPGKTyqtTm
	 Tl+dFr4176GP+CxPUg9ZqPKQ8gJXwbogmwA3LdiXnmciBSqEIOSNy5qY7TSDyBvyS6xkA
	 YhpG1Ng+6X2FYWWezFpF5xdB91yxZ3eIyH36aVjXUNe+vIWNLoj/cTD5m4FaBRSHldg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=MJ7d3rNHeUtNAkSjUSjsQ3HRQiSBTnNiLXOBSu1liKw=;
	b=BVPcBLuJBttxUzmZAWCn480fF/JyOwXV6tNMwcrjXdZ66Dlb8ytg0rYB5R0OMZr9Kmg3
	 BpExeCjn1dn5EcGoBhIyN4sdKiA+8FyIzaT/x3TKv1OsY+gxpBTlNJPE6XWeKN8PihuYN
	 D0PfSc70HRCQaEbmgGa49DL1DOcTh6eHtjB0cFfwIsZjcGGC8abnCpbyNzvKe/9QU/X+T
	 A5h9LsH7Ta32d+nJsIDdnMWge6amC59ESUVRQWks+jOEmPnIV+45OIVfH0WSfU3eOajbn
	 GsX2D4SRm/W6thvEi2t8oq7w9Zyy5BNxJ3hWhtzIpS8doul1320n2umGayhp5aR5QjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RZwbcCo0;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991A4606A32F
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 07:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 991A4606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=RZwbcCo0
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4922dbcee23so1409381f8f.0
        for <stable@vger.kernel.org>; Sun, 15 Nov 2026 23:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794815909; x=1795420709; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MJ7d3rNHeUtNAkSjUSjsQ3HRQiSBTnNiLXOBSu1liKw=;
        b=RZwbcCo0a4gjuV18T+2Ucnw6jCdsWPKRC5LMIQkGS1u3K0j0E8r+eXQHgwhpFjV9Ns
         E4eQbhZlMF0oYosxibPqVnuTLzKDIZ56ygSzOKMLI0U3HdyWkdsGQRg4ffVVNprx0lNl
         3VoShnBY86Rw8ivEwPnvAve0hmIwWUhUt2ZoXiWAG5yImwJfbTo3xhtFN5I/MYPHtn4b
         enxL6PfWiyWc5q9d46A94egMlP3knZPlBbquGKVnCwHFNT5Fsl4ImTFxxiA9tP+r47o4
         8TQ7tud9tTBHlzYrfDmF4FaRvuovfFXjlIwl3BFIwbrGT1RvY+zLOzg32pd1vrPaiWJ/
         fCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794815909; x=1795420709;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MJ7d3rNHeUtNAkSjUSjsQ3HRQiSBTnNiLXOBSu1liKw=;
        b=OHtw2ALVLqsjMrngZ4kZSWdzA7nU0kvhA2CeEJRyUDb3gpLLr9OffgJz0IuQaOPUPH
         qKfUWpNuDgPP+/JJaXCG7jQh8UPXqnL/8xNNgQXoY+LKo8QRnTSKMZjszyqYkW9MPtZw
         pUDYrAI8comIBqqxgceA7DhZc+8Iuw3xkuWeULxwuDJ7tz4R6xYztWjsQSkHnJP7Cydd
         Q1qBnT96FYeRvBAEwWHrHqbK1oqmhGBa3pd42OqPANkXpTGzg+arCfPRBFDc0Bp+wJ/u
         hPFaWyAcvc3LYXbqRxUHKw805Fdvz1nzfBnXW5nrd3dEYe8vR9M1EzYFhzULb8fM5FZT
         y4zg==
X-Forwarded-Encrypted: i=1; AL+hErHskJALNBw6ZcKE65owCV+mxROJT765TjMnkiFhRwNIu2s2HCQpiMFMT4NGAOEVjFpGfhlnXzM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/up4XENRfRWuHsT6m0hdhSGrb3AfaxHMA4iIll2tvaM9sG1A3e
	TOKcsUOWDr3K7n7EVPuVWMSNLa+L2a4HozhDfxPvTWkxXsiIecxMmabF4aRtOJin0YqF
X-Gm-Gg: AYBFou0AhlTKRVoUFAyNDAPnk15AiIQHky6Fz/z9Z8x5fS0cMOd3qmD+qYnxSV/Y4pu
	XNi6ciPbaeCPBCldbR4gUrZQUpg0uUQCJUtFGpZxKSzODdt9m0yI+JlBhsduGKrTKlXY1pqc/JR
	MZTd8GD7JX5Jrm6q0DQu/A4/XDMGPWfM09sYV8w6/UrlYRFe5ho56CWLSQyfj+Ve0qSpGUnNTIj
	rRbwbqsFWl8GHGCGBBo+iQplq57G+l5iibjwLkly4q9XISNsXaShOX3up8IciiAmHumdYbX1gn7
	+TmhHzv+mi7QlnvJP+Qpn2hHQNoLEonR4sH5zuvpiHBfRYAeymrAJwIhAK293AJd0hstPY2sldP
	VTzm+wr7Vttx/3tGC/gIyPyrbHBgiYZz80z5v/NLFSL83pnQDE/mGBbkPIPyg3Bll0AyAXN76BG
	HG6X0E28aAHTnlTtAkVFzEma+GS2XkjBsrXecunsfR8ygwwvllD9zlQ8Az3Nelasm6uAmAGjThg
	4oSY0rvYCt52xgult0OwbA+ZBQxJ6Khths47m90DrISSKaxN1NIxqrSZVbNrjVM8Rn6hnsmFSuq
	YJseeFEBZ912lAoy+yyjNe6QcMgb6JRl3wSANOGvWc77aqJ8+UwMBkfsMEVqmFM=
X-Received: by 2002:a05:6000:3108:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-49c7353c415mr20084703f8f.45.1794815908942;
        Sun, 15 Nov 2026 23:58:28 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5ff2be55sm21124748f8f.28.2026.11.15.23.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:58:28 -0800 (PST)
Message-ID: <19b4c35c016a91302bf6bc3380bfcd3d21dc50c0.camel@amutable.com>
Subject: Re: [PATCH RFC 1/4] powerpc/crash_dump: check ioremap_cache() in
 copy_oldmem_page()
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Breno Leitao
	 <leitao@debian.org>, Chris Mason <mason@kernel.org>, Thomas Gleixner
	 <tglx@kernel.org>, x86@kernel.org, kexec@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>, 
	stable@vger.kernel.org
Date: Mon, 16 Nov 2026 08:58:26 +0100
In-Reply-To: <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
References: <20261112-work-procfs-oldmem-v1-0-ecdcafd99265@kernel.org>
	 <20261112-work-procfs-oldmem-v1-1-ecdcafd99265@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-12 at 17:37 +0100, Christian Brauner wrote:
> copy_oldmem_page() maps a page of the old kernel that isn't in the
> linear mapping with ioremap_cache() and copies from it without
> checking
> whether the mapping worked. If it didn't, the copy reads from an
> offset
> into the NULL page. That oopses unless the copy happens to be a user
> copy, whose exception table entries turn the fault into a short copy.
>=20
> Return -ENOMEM like the other architectures do. read_from_oldmem()
> turns that into -EFAULT like any other short copy.
>=20
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 54c32021eb6f ("[PATCH] powerpc: Add arch-dependent
> copy_oldmem_page")
> Cc: stable@vger.kernel.org
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>

> ---
> =C2=A0arch/powerpc/kernel/crash_dump.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/arch/powerpc/kernel/crash_dump.c
> b/arch/powerpc/kernel/crash_dump.c
> index 103b6605dd68f..1543917bd3e1d 100644
> --- a/arch/powerpc/kernel/crash_dump.c
> +++ b/arch/powerpc/kernel/crash_dump.c
> @@ -86,6 +86,8 @@ ssize_t copy_oldmem_page(struct iov_iter *iter,
> unsigned long pfn,
> =C2=A0		csize =3D copy_to_iter(vaddr + offset, csize, iter);
> =C2=A0	} else {
> =C2=A0		vaddr =3D ioremap_cache(paddr, PAGE_SIZE);
> +		if (!vaddr)
> +			return -ENOMEM;
> =C2=A0		csize =3D copy_to_iter(vaddr + offset, csize, iter);
> =C2=A0		iounmap(vaddr);
> =C2=A0	}
