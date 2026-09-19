Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E47922E3F0;
	Sat, 19 Sep 2026 17:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789840436; cv=none; b=fPJddVOadlzcijY8DjU4bNssE9zzKAGt3bvB7tI2cLtGLmnWLTVJUYG0Y0wx9w9S56sMXg2NKHi2lVsPCH+B1d9ZhAsbRfJen52VJhBzegKmgfmBzE1rmlcCbJB6KjT8C5uKzoBb4Z3FzC4E7cbfnNjVj+NcD1PZtVBDgBTVclg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789840436; c=relaxed/simple;
	bh=Lze/nS1hhnL/kziNlIsE34/oTHnyvYq7icyZckjoLnA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a75S87kmYon6jLXfXlzli/hUXFQKE8+Vgw/OPsyqdpuPbQTkwCP4zhTUAI7WraceQpFS1zimsJtDJv6pfNesEfU6pGN4LsjbZ1/o2vNJKpd3gQHrEEk+zfBBFFxE+WhKhInDzkQioA+ESGcGn7AhWTRUMN3DM2YhJndfsW1Elr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UWEyhuG8 reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UWEyhuG8"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D6C4840E0173;
	Sat, 19 Sep 2026 17:53:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bBIJx-YJV69X; Sat, 19 Sep 2026 17:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789840413; bh=SXiqwKtdNNUw70nrLfz6bcKBIdshJmQNRlHzGsoGp7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UWEyhuG87+5c3DEkcI6k9kbCf7oqNuWc7NNVp+B0jdkCEFaq+bUs3xutwcASp62Dm
	 xBdQHX+gY060/K34myaFqGgQe+2f/z3C6mpkz6uOkpM01sUZzWw/aSPJsD8Z24qiLI
	 Z7vqWAQbgKb6wHT7E1CBmb4dnbAsxOY2OJ05fCl1kSnIqEcGHIpe6aaV3+jzi6lJhP
	 cbU8nC6dsoKI2Qyb2fvOVN+oU+2fKN38Alu/a4rPUApwm0ccFCz4IAWeO15OO1aOTE
	 UYVdJU357+iOqhipNfoJXMn+ETz0RFXxRlNDMIrGWhVRUzduCPwkeRBSyuGTSPMMxu
	 aOphzimH8sxfRQfHLI5C7d0/rJFlUDBpQW0gR3rqbUZ+nWFkcYaNksQVFRPXsdgNbJ
	 bKx1DXIoi3wmz5BqmhsveI6MCk1Qq6PZU9spJoDhgwKKEecM9ON5EVsxz1XxPcQowK
	 LyByULYfxFktJ100cN6FT/nzQSE5HxRuoF/iRJSgndbYT5FdTvPkvQ5vV+RXJXxq4b
	 SHlmUxnFz34Xj/7YurGtkbj8n8tIL7lvtnMSdOkFVIu6Gl70ewQ/HFNOYSjlaYWWIf
	 59OINNfItYdX/nmbWo4bsu07fF2iTiY7QrOF1wL4vdDyonaaah6s9CFyEBhbZD91UY
	 3MKqf3aAd5VBi4CrKQFnm7NM=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5DB9140E00B9;
	Sat, 19 Sep 2026 17:53:20 +0000 (UTC)
Date: Sat, 19 Sep 2026 10:53:16 -0700
From: Borislav Petkov <bp@alien8.de>
To: Laurent Wandrebeck <l.wandrebeck@quelquesmots.fr>,
	Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] x86/mm: don't apply va_align to hugetlb mappings on AMD
 F15h
Message-ID: <20260919175316.GAaq7MDHnfhdJFPtsM@fat_crate.local>
References: <20260828135747.724789-1-l.wandrebeck@quelquesmots.fr>
 <3faecf65-7edb-4cec-be7a-e5266dd3a649@intel.com>
 <20260829174704.GAapMbGAZMwImcvIN7@fat_crate.local>
 <0B48BE2C-2E72-4961-91D9-35E215F537A9@quelquesmots.fr>
 <20260829185120.GBapMqKFM35KtL0Mod@fat_crate.local>
 <78225f07785ed89e0c3e5def8a8bb1a48e444322.camel@quelquesmots.fr>
 <20260916200247.GFaqr15333nu5IAfjU@fat_crate.local>
 <45dc4a4f62e49107de788b4be9a4039e0d772fa1.camel@quelquesmots.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45dc4a4f62e49107de788b4be9a4039e0d772fa1.camel@quelquesmots.fr>
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 10:47:46AM +0200, Laurent Wandrebeck wrote:
> Here=E2=80=99s the =C2=AB v2 =C2=BB patch I used instead, on top of 7.3=
-rc3.
> Works without problem (several hours uptime).
> If this looks ok to you,

I can't complain about that too much, but let's see what Dave thinks.

Dave?
=20
> diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.=
c
> index 776ae6fa7f2d..a54f930e2c9a 100644
> --- a/arch/x86/kernel/sys_x86_64.c
> +++ b/arch/x86/kernel/sys_x86_64.c
> @@ -28,7 +28,7 @@
>   */
>  static unsigned long get_align_mask(struct file *filp)
>  {
> -       if (filp && is_file_hugepages(filp))
> +       if (is_file_hugepages(filp))
>                 return huge_page_mask_align(filp);
>         /* handle 32- and 64-bit case with a single conditional */
>         if (va_align.flags < 0 || !(va_align.flags & (2 - mmap_is_ia32(=
))))
> @@ -50,9 +50,13 @@ static unsigned long get_align_mask(struct file *fil=
p)
>   * value before calling vm_unmapped_area() or ORed directly to the
>   * address.
>   */
> -static unsigned long get_align_bits(void)
> +static unsigned long get_align_bits(struct file *filp)
>  {
> -       return va_align.bits & get_align_mask(NULL);
> +       /* hugetlb mappings must stay on the huge page boundary. */
> +       if (is_file_hugepages(filp))
> +               return 0;
> +
> +       return va_align.bits & get_align_mask(filp);
>  }
> =20
>  static int __init control_va_addr_alignment(char *str)
> @@ -157,7 +161,7 @@ arch_get_unmapped_area(struct file *filp, unsigned =
long addr, unsigned long len,
>         }
>         if (filp) {
>                 info.align_mask =3D get_align_mask(filp);
> -               info.align_offset +=3D get_align_bits();
> +               info.align_offset +=3D get_align_bits(filp);
>         }
> =20
>         return vm_unmapped_area(&info);
> @@ -222,7 +226,7 @@ arch_get_unmapped_area_topdown(struct file *filp, u=
nsigned long addr0,
> =20
>         if (filp) {
>                 info.align_mask =3D get_align_mask(filp);
> -               info.align_offset +=3D get_align_bits();
> +               info.align_offset +=3D get_align_bits(filp);
>         }
>         addr =3D vm_unmapped_area(&info);
>         if (!(addr & ~PAGE_MASK))
>=20
> --=20
> Laurent Wandrebeck <l.wandrebeck@quelquesmots.fr>

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
