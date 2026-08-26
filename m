Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C4A331A65;
	Wed, 26 Aug 2026 04:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787719556; cv=none; b=QKKsbcus+Xb2pli85rSsZZiQegclWL8M0cO5oGSczGQOubxIvUo7EEIyfk8wFf7QYE3rUDJjYizr2NJQu+5PEvA0PlPiKuXbm+itqUPSJZ57YFOpcbveTbncAYlCcqo+RHzFCMAa0WVIsPbO2p7MCNQxqdoTDnDjc+xeOH0RXhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787719556; c=relaxed/simple;
	bh=rElWfQ+Wz3Zo/4wQ6cl2qnVpBQPyuGZfOw3zT9IRZyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeJJhrvvj+nhR8Zu0lvhBZWi1nC4KDjzCfKh1fiIjXitHC+a5VO5vtTawswiCB1NosmTNobP4NrcXtNGOpEy/wPuhIIzNJL3JLGhr6obn/GDGNHmLssP4PnJIW6cYKzP8Y89yeViBbiSX/sS7FaCfYbDDjV0dA4Dp0oyXz50NTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=gX0Uw4j3; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="gX0Uw4j3"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2766E40E016E;
	Wed, 26 Aug 2026 04:45:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PvFifB31hLDh; Wed, 26 Aug 2026 04:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1787719533; bh=kjCHRp80tQJ6yaTKT3KVV04TnWBmqenKO3U0WSUN3Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gX0Uw4j3jyNJvSz+cxBmeM90AjSGBdCv8Incs5KfTnaMggWuMy/Pi4mkrIJXXAe48
	 MaDXZnNgoNtugDHlh55uLVyAGsYt7QmJ2ZQthIP4/fMG379ZvMXq+vMXL3qz6kRNZC
	 aWF3GxBYYEvqPqdGNa9K0UsqGPXlunr45P9SAEt7JrejNzupZXZWGOoYA/sVvGClZW
	 6WfZ9cCNZw/Zz3OCKHa/9x4GrZzhr5SAz4RCTtKbDhG+fsrSTe+sAJD8ZFpwEgJXQH
	 F5sjbF4kEopvKBqnKaNZA1VAHDqju17gEi9zyArvQC1Ik66h9InpcYmqmGLBvtq+Ti
	 LtePonwpIC0cCTPz8AiM7yoa0uepBqaKfpPcJ2LEsmw9q4DLbxFthrMOBl5e4VxRE9
	 deAqzKozOEMTJv2VE6M5JjhbOa04vnRBgnYHsg0lnkTskfp0PHyixMNIsqfkIsJo3L
	 AngBO28XjI8eZTh10aXhMumv1x9IUGbe5OsEiS2lBo9rWfoXK9DCZ6doGYKr2bFt28
	 0oR7NlRzj1B4gP3m3WVhauWpV/T3dRqMZl8XNNj8pM0KJ3p5tG6hCcIxBJqn+Xr+qC
	 r9RFLQxwLBzcArQ7yodhpIR0x/yi0VsYoNz46GHHfMsVQliNjCIu7zswwRZ5Z9oTvD
	 YycJ/P7Utu7w9RUfeQnUKiig=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42EBF40E015C;
	Wed, 26 Aug 2026 04:45:22 +0000 (UTC)
Date: Tue, 25 Aug 2026 21:45:18 -0700
From: Borislav Petkov <bp@alien8.de>
To: Jason Andryuk <jason.andryuk@amd.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>, linux-kernel@vger.kernel.org,
	Penny Zheng <penny.zheng@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] x86/amd_node: Avoid divide by zero on virtualized
 systems
Message-ID: <20260826044518.GBao5vXvWQx9_a9RzF@fat_crate.local>
References: <20260825214805.39148-1-jason.andryuk@amd.com>
 <20260825214805.39148-2-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825214805.39148-2-jason.andryuk@amd.com>

On Tue, Aug 25, 2026 at 05:48:02PM -0400, Jason Andryuk wrote:
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
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> ---
> v3:
> Add newline to warning.
> R-b: Yazen
> 
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
> index 0be01725a2a4..408b9fd48349 100644
> --- a/arch/x86/kernel/amd_node.c
> +++ b/arch/x86/kernel/amd_node.c
> @@ -287,6 +287,11 @@ static int __init amd_smn_init(void)
>  		return -ENOMEM;
>  
>  	roots_per_node = num_roots / num_nodes;

Hold on - the only way this is fixing something on Xen - and you say that
roots_per_node becomes 0 - which means that num_roots is 0.

But a couple of lines above, we have

        if (!num_roots)
                return -ENODEV;

So we would've exited already.

num_nodes can't be 0 because you'd explode even with this patch.

What am I missing?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
