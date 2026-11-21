Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795288789;
	b=fajYxMdaFZAomjOJYSxowPhjDCi7xVXImon926OH7V0wHBUIq1WcdO08+/bPNF2gA3FU
	 rxhh8MJaBTvnP/Ch6h0XwBZX3KC1CymSdPZPGUNNv6KZSIFce+Zx+bfXpSeu9eYv0HSYy
	 EE3fBKWeyVhX1U1zEO+JKRVSjEaz6CgAMBSUNzwdad3bBidIr/z+pSvTqnlfFPziCsv3n
	 T6GLUlN8V4gPIrbgY3779Fx8AzqNZYwRfZg4nqh3pCHnnzkJUELDI+W9vlkJhzr+UiY/R
	 +TM5+HN9StUwjdImA/gfLRUHn0ErPaj8KfvyeOAUXUMWhNVMQUzVwA/bzrdRPELkfLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795288789;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:DKIM-Signature:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=6SrPi0bx6GHMMCmA6LUjcTk40O7E8I1mi6dEbN9j2Pw=;
	b=hCyzXOoEluRsR6mxO1PP0SlgqGp/dgy4QTjWzKGabi2Ktx6+kGUuwPqAO1tUb533XGW1
	 M+qwQvMC7k+zbmQmQ8gYCbFzfwXRUuDGWGOsj9nd/2FSQauNxmUGUBxCkUKmdSRwj+izi
	 +09FHLZunsyDTkX6RQtW3wuS+JF1qK1NEtANgsa3cRmcVTUTg1fXFN4zzAeudYgdLmB9/
	 RcU/5RigsZ+TctMhZSfycLFmw66u57lLwAI3J1ZwJGZcX6gMIbuFwadpPq6FTf6RAH5td
	 G/DEcYc5o2L9cIGCQzi7tcQwnKxbFLlU3+Fl46tc071/zdQoYR1CdTVaUbVBhU+VCBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alien8.de;
	spf=pass smtp.mailfrom=alien8.de;
	dkim=pass header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=SUdyUo3B;
	arc=none smtp.remote-ip=65.109.113.108
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8D8606A320;
	Sat, 21 Nov 2026 19:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E8D8606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=SUdyUo3B
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 37BF540E0218;
	Sat, 21 Nov 2026 19:19:40 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dbxgZAZ7WSbB; Sat, 21 Nov 2026 19:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1795288776; bh=6SrPi0bx6GHMMCmA6LUjcTk40O7E8I1mi6dEbN9j2Pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SUdyUo3BZP7LdTG1nKwjE3gy0EoBtvxEGR7xdyrVw1v32JjOHf2xZ8RRvbCvaF/Nj
	 7QW3X9l5D/E+9Kkc3TpPger5kKYZ+yy12epBCvoB9+sbUwD+Q2LraeqQdS0EXsa1na
	 uDg1iTZOeMPHqR22mH7YN/9tC6ysvQZSx7ZYopfQ3eX8/WsuMouvFk6E1b1n2a36az
	 S4HLr7fs8RyE8s31yZCaRvbYdZei1vaDumPYmGJPIFTpBNVLaumsRoOuzxfKv/PJVI
	 9Tm+HRsu2qkThp9xUvUDe/6FCyN3YdB1nTFnUso1f5siWks0kSdwIfIrJjw7vFWH1/
	 GX9yfIw6hyyzu1rm+jWENLyC1Qlokdzn2vsKaGujZ5cWdFPEV4oipNz7HohMHA5DW6
	 qYiHsV9eGDNBjZvgF68FQ8hEduJmbzLmODpCK8CAddERy21Zx5ntWjc/59H8SJlzrq
	 cUJB6CEE58avCGVTeZDzfhSy5n7ACxh6KhOmDtqsMNm4zddj8s81G9r+pDARahqTZF
	 yfhs7XKsr0BAuF56zOKMgVyzK3rLFDGDbv+B/It3oD9CQ5tGMLJZ0X6Nnl5i9se133
	 7+lZ2Ro03c17M0eZs1WusxSaLkeqo/wGbWHB7LeropVuANj1lV/xkGJ1VE6gHRDqVI
	 hNC4j0ZY0yHVD/3alx+cXOjU=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E47BC40E015B;
	Sat, 21 Nov 2026 19:19:22 +0000 (UTC)
Date: Sat, 21 Nov 2026 11:19:19 -0800
From: Borislav Petkov <bp@alien8.de>
To: Tina Zhang <zhang_wei@open-hieco.net>
Cc: x86@kernel.org, puwen@hygon.cn, tglx@linutronix.de, mingo@redhat.com,
	dave.hansen@linux.intel.com, andrew.cooper3@citrix.com,
	david.laight.linux@gmail.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, yangzhen@hygon.cn,
	dengqiming@hygon.cn, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/cpu/hygon: Work around XSAVES Erratum 1386
Message-ID: <20261121191919.GAawHutzJsmVu7m3Tz@fat_crate.local>
References: <20261121105320.478279-1-zhang_wei@open-hieco.net>
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
In-Reply-To: <20261121105320.478279-1-zhang_wei@open-hieco.net>

On Sat, Nov 21, 2026 at 06:53:20PM +0800, Tina Zhang wrote:
> The XSAVES malfunction described in AMD Erratum 1386 also affects
> certain Hygon Family 18h processors. Under specific conditions, XSAVES
> may fail to save XMM register state, allowing stale register values to
> reappear after the state is restored.
> 
> The failure mode is documented as Erratum 1386 in "Revision Guide for
> AMD Family 19h Models 00h-0Fh Processors", Publication #56683 [1].
> 
> None of the affected processors enumerate supervisor XSAVE state
> components. XSAVEC is therefore equivalent for their enabled state
> components and is not affected by the erratum.
> 
> Family 18h models 00h through 06h and model 10h are affected. Other
> Family 18h models contain the fix in hardware.
> 
> For the following model and stepping combinations, the minimum
> microcode revisions containing the fix are:
> 
>   Model  Stepping  Microcode
>   04h    0         0x9040000f
>   04h    1         0x9041000f
>   06h    0         0x9060000f
>   06h    1         0x9061000f
>   10h    0         0x91000004
> 
> These are the only known steppings for those models.
> 
> Disable XSAVES on affected processors unless a matching model and
> stepping entry identifies a sufficiently recent microcode revision
> containing the fix. This allows the x86 FPU code to use XSAVEC
> instead.
> 
> [1] https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/revision-guides/56683.pdf
> 
> Signed-off-by: Tina Zhang <zhang_wei@open-hieco.net>
> Tested-by: Qiming Deng <dengqiming@hygon.cn>
> Reviewed-by: Zhen Yang <yangzhen@hygon.cn>
> Cc: stable@vger.kernel.org
> ---
> Changes in v2:
> - Keep the workaround self-contained in hygon.c while following the AMD
>   implementation pattern.
> - Describe the affected processors in an x86_cpu_id table instead of using
>   open-coded family and model checks.
> - Add a reference to the public Erratum 1386 documentation.
> 
>  arch/x86/kernel/cpu/hygon.c | 41 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 41 insertions(+)

https://sashiko.dev/#/patchset/20261121105320.478279-1-zhang_wei%40open-hieco.net

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
