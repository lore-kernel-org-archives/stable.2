Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795694789;
	b=YhkpElDTmz3KLSnyoddMfaJfCadnCU2Z+aGtzOaO8Pc2lPw0x1L46o3oT2dGEFV2UAhA
	 uYZP9DIfZKa88crBxGR8zYwI04PPwL/7CjRPOG+1U7r9hb83+oaUAZZ8I3ZZV+nQeLW/A
	 AEbFdoXNyxiKt8JIy/6lbDj+mxMf6an6ksqvsQG9vK0XEG28L5mu9koi1QAUcpimjC1hH
	 l7rutdK4tF2AALTdVBkLIgFFqvn6NrkO73bE6Lt+JuKuCuF7EoCT+nEoOhk/+5HYa+rLS
	 sz1wHgD5kajsM6YpZmdRBVV39kStZc4nZMQj6VQWb6c3aNA6KMiOWAw0EEGlY7kcZMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795694789;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:X-ME-Received:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=EDJEdQ1TjvzunefynkN28sXQqGJbavrI+88Tql9ZN6s=;
	b=DatW3sjdr2a4/3YRTPtTmMLHYnwCCTUJfPcYE/k8iDNe/Sh3ZyJbJeAgJBLXEse4sU7c
	 AqYXUrWNtZ/5Yr9VUP9OVTw2kOcmRysVE6X1nCv5iUoldALJGfgxNDq7khI4gxo2rO6Wc
	 pGBIllJviqJyUI0Tv6pt3hmhXiXbyuRSn0lS/075owwKNAXMiAa5CsMc7B1Ozhpo+rXEs
	 1WQV01wZfeDQ4Z75el/NG8HY0Nu7wpQ6asq1q/mCGpAM4/OYzEC/VWyHIEHDSIfyKpyyT
	 9hlKOXrLvi9bAo+0mpMlmcLx9HRdsY4/bwkxC8Gev0SXzgkE6tjCTdwJZakkyV78XUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gpp6RsL2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A32606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gpp6RsL2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A641F000C6;
	Thu, 26 Nov 2026 12:06:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795694789;
	bh=EDJEdQ1TjvzunefynkN28sXQqGJbavrI+88Tql9ZN6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gpp6RsL2X4F80fs3wqAw4S3ABgTbzjJVxPoS2lKJFmUMt5hZkrSDh9GT9ZE2tH0Wi
	 c6NLMHO1Nv6ntV0IP8k2Wn5LsxFnUIOIdEFWqmtc3gO59KgZDvKNebR8cUY5dKGvw8
	 mqWIEKj+CDX/9qdu4G/LTtggxYhBhVCz14TEe2m5+g8B6ikeJRo7StlBnaQaiyYw5E
	 V3Fd3md2D1HRZEXYYRtJLku/9FW50BESdtj56/dRryCgRQPpig335y8vPsIdpO4t3S
	 obxwqogTiDiuNNxQuZEVGcr8SkzZVL035F+Q32fQOz1jLoTR7SbTGkZtFIju0HXZRZ
	 WmEWDr4BVr8+g==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 29F261980074;
	Thu, 26 Nov 2026 07:06:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 26 Nov 2026 07:06:26 -0500
X-ME-Sender: <xms:vyAIa-3m5v1yRqO0vWj2J7VTPhKB5uemSZ4UUbAu43HMhdt3TUueCg>
    <xme:vyAIa36mZZsZkWSk-oh8K-NZknNIazY2ee5I-q8j-ydH-zASTYxGw3FkFCJ4EYwL6
    sLQCbHgjafoRfrQ6l409z97PTkyon4_KlEySxAqRw6nMZCowECImJY5>
X-ME-Received: <xmr:vyAIa_2tkhug_3k7eRKBaKtBcgVEXr9UjyWTJtajmat4AmPjU_LSZW0aiYY>
X-ME-Proxy-Cause: dmFkZTEG867qwPubLmy7FicciVJmTUol3Qz1f7B791QDJNbzIPzz4f9uomLjIqOPfvH7yO
    NxswOWJs4mi6y+Sp1R6QB1dEk6JMugZGnH7Bk4gHz9v+wM/uHUtphmdKRHj2GLnxfQNldv
    yADJr+1oORV73XEU0XfbBxYVi2EGODCQWC8QKV9J+LCHJimcLfSkJVMxo6xJPRLGwUECfh
    1K4q+WTecykqIdZ09/7sDBJwltqu6nEbu+dBNc3vuT0xlv9d3jjahc5qRXUolaQSTMOMJB
    p+bRouw6vkuelppkWr6Tn7KnHwPtYDBIIcpk3G+QiV+y0Q3eNRfb8apDO5QVoR2HDzemRp
    bJxtURZak5+r9R5JFqzDvIx/0Kk9PwEMqCOv+PZXbXzM9AtubbFpNosLUF0PHIFlq39hy8
    JhESN84RHMhFqs1xxmm/ubbX/eGmKp/fQcEw65PZbJN5kgw2felAiO/Et8I5JqQOt5S4ZN
    xtoxsIaM1FIuPeLYep2sQ4v6dAMiEmbuHBhN34wNpYEs9pgUUJBtGOFiNT+zkc2xA87myT
    /lwkrXcEBvn+hrzf4oYt9sI7HRdHz8Un4AELAQJaBaSfa12qo+YHJSSX5lCq/bPM/HN7Je
    0uNJW21s1xGdrA1XZ1Ep/zCgxlRe02m5KcduzGA/9c4z7LlN3diKQeAUI4Aw
X-ME-Proxy: <xmx:vyAIayouA2kdHOPuMjktIbnK199eprThX_wqlPcdAEWBzEytF5TSkg>
    <xmx:vyAIa1XnPKyk3pM6CFL4mOdKN3iJAGie9_hjOCvNMti4OSELm-gPwQ>
    <xmx:vyAIa3dFD2mZB-2rrDI-NSWhDBkcwHEusbPgmJGICdFORiaOefk9Ng>
    <xmx:vyAIa2C6XbpgO9CF8EFGX-dc8JTDy9Fcki1cro5kQIQNqnihlODZGA>
    <xmx:vyAIa23jQzM9hhVggKN5dZEABvfJO1_a9j0DUNBFIq-0bFtlIa_PYFoX>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Nov 2026 07:06:22 -0500 (EST)
Date: Thu, 26 Nov 2026 12:06:21 +0000
From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>, 
	Mike Rapoport <rppt@kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Pankaj Gupta <pankaj.gupta@amd.com>, linux-efi@vger.kernel.org, 
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] x86/efi: Handle EFI_UNACCEPTED_MEMORY in
 do_add_efi_memmap()
Message-ID: <awggd5bP1Yg7qgRQ@shutemov.name>
References: <20261125173338.1250080-1-kas@kernel.org>
 <2c075daa-978b-4efc-bb36-736909ec5ff6@app.fastmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c075daa-978b-4efc-bb36-736909ec5ff6@app.fastmail.com>

On Thu, Nov 26, 2026 at 12:29:30PM +0100, Ard Biesheuvel wrote:
> 
> 
> On Wed, 25 Nov 2026, at 18:33, Kiryl Shutsemau (Meta) wrote:
> > The EFI stub reports unaccepted memory to the kernel as E820 RAM.
> > do_add_efi_memmap() has no case for EFI_UNACCEPTED_MEMORY and adds the
> > same range again as E820_TYPE_RESERVED. e820__update_table() resolves
> > the overlap in favour of the reserved type, so the kernel never uses
> > the range.
> >
> > do_add_efi_memmap() runs when soft reservation is enabled and the
> > firmware marks any conventional memory EFI_MEMORY_SP; that takes no
> > command-line option. It also runs with the add_efi_memmap boot
> > parameter. A TDX or SEV-SNP guest booted either way loses the memory the
> > firmware left unaccepted, and it does not show up in MemTotal.
> >
> > Add unaccepted memory as RAM, as the stub does. Without
> > CONFIG_UNACCEPTED_MEMORY the kernel cannot accept it, so keep it
> > reserved there.
> >
> > Fixes: 745e3ed85f71 ("efi/libstub: Implement support for unaccepted memory")
> > Reported-by: Mike Rapoport <rppt@kernel.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > ---
> > Build-tested only, with and without CONFIG_UNACCEPTED_MEMORY.
> >
> >  arch/x86/platform/efi/efi.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> 
> I can take this via efi/urgent if desired.

It is not urgent on my part. It can wait the next merge window, unless
someone else needs it now.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
