Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475E2AD32;
	Wed,  7 Oct 2026 00:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791333990; cv=none; b=Btn8hpVD2AaYiCBnLElaiobZz1dzC48Rj6UR4cGT3leWkfjO9WUGn2e9W1wV5lb5nV+e3hLpSuz9v957AXJG+l/htdIN2T3xo5VFp3UgvB1BLv9hdnHrFOJ1VBBTQoaruMW7l2qqhsqA2LK+U3q+3cCgtkBp0XarEnqbvnTBpSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791333990; c=relaxed/simple;
	bh=DWkd33monIfLrk8hXdr6qmQ91ALR2N8OUPmwH+/KDGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoQEb8iO4KbFyfNSVW2LVhYZAXyhsudSztwkCoko5VNkAV6SdY7PZ0pGyVEzrGmMr6OiN7de+kdf2OgvfTxxQpgLmloLlRGSB0v+ifzPikwUk2MhF89B7AuVErmhJeNRb7HdH/NshZyjKAQqC1rQz8q4mWmBcXGu6wAoMvH5K0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RjBg8YnQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RjBg8YnQ"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 20AEB40E02A8;
	Wed,  7 Oct 2026 00:46:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dlnvTP_8Zdjw; Wed,  7 Oct 2026 00:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1791333969; bh=MpDg4jsfmyhPM2TgyK4940GnDik1JkqLDLHNrmYEoyI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RjBg8YnQ7RsoKOUndGPXxVODu/r+M/LGJD2w/lfJK+VqHrfDj/g98DhUTG3IlMDif
	 9kRRgpFb8m9A8pOgz71LczqvI7KHNvwcFD3psgHbam0WDjpN+B5Im8srEfNT8W1Vxh
	 6rUOJZgqlMVtzJnMKkPIXFIuoVhoxeGRBwZ3IsPwMkCiUZVPFFp+RNMpKHsXlDTJAv
	 ic9VCfnwNpWb/201V12S4xnXAzG/s+uPFQUsNwQqzjrXLHoFqc5Y28s/vvrghhhkXQ
	 YeYbywSYtxgxXkspU+/hTwB/MSaZGE41Dz2Pf8gKQYGgcpI++o/UIYzdOcfeL24lQM
	 p13v06g+GdlJit8+L9hy2AhwJwOAQvYX61mY19SojWZYYl1Zvai93R7/ytDEp6pCf8
	 F3YySqFfJvHWs/NtS3wAxpPiF61UDilTYcckg4eY5NtK4QUKPrASw4uG85KDgVNmLl
	 eMw2Q2U9PJON2yqI8cyyHd/vqB4RGa1w3iCNxFFDoRueySpn7jH6J4+4xfU+Qyf9r0
	 1wVkSw17hzkm/w/IaWOqCeUNvSJMyQ+6oAG/lBEe84uWHDl+ybh8kInY7KwxH/HDFC
	 5Y0BTjmBPwE7EHQRh6Znleod91ZovG3R8yDJDuCwkAxK+gZG6GdEq4Pyx0MJBv1j8i
	 /kB5kdyZ3Z+kUIKdFkqyBDgI=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::2b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A8DF040E00E5;
	Wed,  7 Oct 2026 00:46:00 +0000 (UTC)
Date: Tue, 6 Oct 2026 17:45:57 -0700
From: Borislav Petkov <bp@alien8.de>
To: Kyle Zeng <kylebot@openai.com>
Cc: linux-kernel@vger.kernel.org, tglx@kernel.org, mingo@redhat.com,
	dave.hansen@linux.intel.com, x86@kernel.org,
	outbounddisclosures@openai.com, stable@vger.kernel.org
Subject: Re: [PATCH] x86/fpu: Avoid kernel-address leaks in the FXSAVE
 workaround
Message-ID: <20261007004557.GAasWWRcOTfDzcZZw3@fat_crate.local>
References: <20261006221541.35963-1-kylebot@openai.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006221541.35963-1-kylebot@openai.com>

On Tue, Oct 06, 2026 at 03:15:41PM -0700, Kyle Zeng wrote:
> On AMD CPUs without XSaveErPtr, restoring x87 state without a pending
> exception can leave FDP/FIP/FOP unchanged.  The existing workaround
> replaces the previous context's pointers by executing FILD on a kernel
> fpstate.  This exposes the kernel instruction and operand addresses
> instead.  On TCG qemu64, an unprivileged task can recover the kernel
> text slide with FNSTENV at ELF entry, even though FXSAVE64 reports zero
> error pointers.

Is this where you basically prompt the LLM to find you any bug in the kernel,
no matter the relevance, as long as there is something?

Or do you also ask it to consider the practical relevance of the fix and
whether it is even worth doing it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
