Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B5C3A48F6;
	Tue, 25 Aug 2026 04:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787630470; cv=none; b=h9rHwLSpS4fSydKAfp1sJonhuj1EL5BixcFOU1dryz1w4V6W64lY4iOhrwXwtwrAsni8iLpwI48tFYLzzVEuXeQn3liUt6nNc8jBTx6wP/CB4SbP6UYJH4ngrUMAygurXCZuFl01Oj7zX+62h0/Xrd1rU1BemXuxdKzxEFEdnWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787630470; c=relaxed/simple;
	bh=OwJZQqNtodqfxQD/LXqPXjdr+C6RM5iK6LW4mr4E4HE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JwSNpG6VL9wQmgRdIslXJ6oku0DEPKdie3MnpOO0NXIx5gEFCxcnaVYJAR1d+ceGltiQ+m6yJAfTL7swl3+Vp2Eg8yWgUAk+xbYGx+KW+Z3lhn+6vrpYyEePkMrF/FQ7sJrIb7tahLpWxYaLTED2Efy47cv+ylCCvVMo7yGyOi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=SD68F4qN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="SD68F4qN"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ABAFD40E015C;
	Tue, 25 Aug 2026 04:01:05 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qnYwr9dfZAPJ; Tue, 25 Aug 2026 04:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1787630454; bh=bz8Ecmle0UUnbjlFKNpfbTWc8BEwShknF9n2ucb7H9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SD68F4qNI2tFVQu3vqOdw2H1onrwQQBJ/CaOiygaaG+Yg7R6KEpM7AyRhK/MFcwO0
	 tyYaiKAsAdfuOBOP2WsmUWSSrskgdnpea8Ax4qn3fhaBdovWVsPgW/0Mvd37Bvahyd
	 o4hy8qscsc1aPIMw17kBWSh4/x1i6MT47WADNq2wBM7RJ6h7lSAglvNXUCzycf7lXB
	 VwzAJZ8OTKDqFr3wua6kq7+MH6COgMOSWB0Bfx5gl/e0PRelGc8Jhtu3TeVVpBCK+i
	 HVrPbzVbp88q8m+xNy+xFuhVgV28zc1M3r0kNL3YMFgojDw5NQ1KSXZNiDi4sqHqpd
	 2HbFconHTqoejyV2FZtPFK+IKf6k48Ke6YbIMcQ5Lw4x89TpT0AMlMf+Tp9I7688+c
	 cunv4GeiL+wKCqlj5GYXe++hsul8U98eInP915pZs1K8NSSILxRTi1Mp+rM8cqsHJH
	 H1cDN83Lssm8lBHQBvzOYEUPyfZSv38iBJ7dhaxFKC0w9yv9l/PErcI5xuLPkhoGk8
	 FLF04tXrWAqtmltGRxwPNheA7xF3uscTIeyd4m4yD+RNv2hamHYrzjwoMrmnmCH84w
	 7cPRd5n7hj6Mq9QOiXRcNLm2dkX3B6UniGy52vwbornf03hdh2LeGbfGZkpMW83qxe
	 5PHccBtcpNMguF6aoIek3XA0=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EE5F740E01B5;
	Tue, 25 Aug 2026 04:00:42 +0000 (UTC)
Date: Mon, 24 Aug 2026 21:00:39 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>, linux-kernel@vger.kernel.org,
	Penny Zheng <penny.zheng@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] x86/amd_node: Avoid divide by zero on virtualized
 systems
Message-ID: <20260825040039.GAao0TZ6b8j0kp2RKk@fat_crate.local>
References: <20260814214255.83127-1-jason.andryuk@amd.com>
 <20260814214255.83127-2-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260814214255.83127-2-jason.andryuk@amd.com>

On Fri, Aug 14, 2026 at 05:42:52PM -0400, Jason Andryuk wrote:
> On a virtualized system, the number of nodes does not have a
> relationship to the number of roots.  A Xen PVH dom0 can calculate
> roots_per_node as 0, which crashes with a divide by zero in:
> 
>     if (count++ % roots_per_node)
> 
> The issue is seen with Xen, but it could affect other systems.
> 
> Change roots_per_node == 0 to 1 to allow the system to boot.  Print a
> warning when this is performed for non-virtualized systems.
> 
> Fixes: 0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")
> Cc: stable@vger.kernel.org
> Suggested-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> ---
> v2:
> Print as a warning instead of error
> Use "!" instead of "== 0".
> 
> X86_FEATURE_XENPV is only for PV, but this is observed with a PVH dom0.
> ---
>  arch/x86/kernel/amd_node.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_node.c b/arch/x86/kernel/amd_node.c
> index 0be01725a2a4..c3e214925d9c 100644
> --- a/arch/x86/kernel/amd_node.c
> +++ b/arch/x86/kernel/amd_node.c
> @@ -287,6 +287,11 @@ static int __init amd_smn_init(void)
>  		return -ENOMEM;
>  
>  	roots_per_node = num_roots / num_nodes;
> +	if (!roots_per_node) {
> +		if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
> +			pr_warn(FW_BUG "Error detecting roots per node.");
> +		roots_per_node = 1;
> +	}
>  
>  	count = 0;
>  	node = 0;
> -- 

https://sashiko.dev/#/patchset/20260814214255.83127-1-jason.andryuk%40amd.com

And this one specifically (the other two are being addressed):

"Are we missing a newline character at the end of this warning message?
Without a trailing \n in the format string, subsequent kernel messages might
be appended to the same line, resulting in malformed dmesg output."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
