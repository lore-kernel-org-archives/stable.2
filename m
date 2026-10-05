Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0F54A4EE2
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210481; cv=none; b=u5fs7CvAP3eE7fWLTHI3zfmwCVKIj22MedgqesjbdmV40XnfuiX7l5hsoHk5+b/C587IgL6mUzVxe/jpiOORleubck4aPx9nIEexQ1Pj3i4nikPpVFOYpFCOynjudSpoZ8I0quuIAPVIzQ8sVU7PjfZsZmA6A9NjT4jWxP+Rle8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210481; c=relaxed/simple;
	bh=8aHhvrXOqmGPePIkLtxikGO2wK12h9aCV5UV5DWpIR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/C13grGY2CORFoLoVA25l42HHcFPXyV8Q3xSfP9ndaLI5RGSct/h2LYMn5XMNtlpGP2MBxUKYpdl2YJBekCBhhbVWYIvMzfbqjmXGXttGqLtLETwaYs7IqCXd/EuGY75gzTXBV8F5S3l9WeMRZHM3XDIHuxS6ZEFY+L2E0YNOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jIJrGqUA; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jIJrGqUA"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 54B3E40E02A8;
	Mon,  5 Oct 2026 14:27:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2BNUDeMeS2P9; Mon,  5 Oct 2026 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1791210458; bh=cZtHqlO0XZbeiyjkyXGFxI+e36HVHGVU3NICYNx/TZ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jIJrGqUAH2RrE2PT0rhIhq3ZLtLsmGutFeipsxcwSYPpFZQK2BT0x6g49wsVD6YLU
	 k5BRvuKxx9gZygao7jrGLo3/iS1+Ouo4xY669Y7vtcirDCZyfLWwrWE6ZGL0Y47o+B
	 wCh1W5LMnKBEteirI6fLkJ7EZQRQ/if77FNtK+uJrJXPKmkVX8qwX9GOQFJUF5yK2F
	 mHPqC9PMcFt8lAZ+2D+NIGWuJ5EhPcJ+r0ZQjjYitIiTP+kd0iYTME3Ij7oBNYK636
	 yPI4yP2ekfYiWQ99JrEFywb0/5vUyLyG+XMTBZSIa3sFhlWebxDYz/oEgTxOBv0OeN
	 G3ztPbFyYg6ZfZTjBBHsbntHHYUYf768V1yhL+PfSu8gGDNfRFWGTEqfe4V5Infio/
	 F4nOneiBuKFFmvemdQylE8XXGyOulluPIugkplV+OAloZQ94P6f2AXmhkYLNvIgJpk
	 DEqgGCXgdzjU+FoH09Xlk2rFHSlujFF+h+3A3yxtUs2fc2cjzZB0lRmYBlbeRiOF6D
	 whpRuszFigiF8hcKYMrWy81dglfLUyE5Vk9lskZIfgpcDDtGL1F//48S/GnL2xqrKI
	 w19FV8Nla2gt877Ze2gl4MV+tEHY9VaaoUWS+76hmO9eOsjK3eo574iA0zYRvurJgA
	 UKyLIPnCyBT9Eh8P2M8QPAm4=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::3a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6D6E740E02B3;
	Mon,  5 Oct 2026 14:27:35 +0000 (UTC)
Date: Mon, 5 Oct 2026 07:27:32 -0700
From: Borislav Petkov <bp@alien8.de>
To: gregkh@linuxfoundation.org
Cc: dinguyen@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] EDAC/altera: Fix memory leak on dci
 allocation failure" failed to apply to 5.15-stable tree
Message-ID: <20261005142732.GBasOz1POO8wYBLJC2@fat_crate.local>
References: <2026100524-payer-capricorn-e50f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026100524-payer-capricorn-e50f@gregkh>

On Mon, Oct 05, 2026 at 12:27:24PM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 5.15-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> git checkout FETCH_HEAD
> git cherry-pick -x 3e4a10a4718e3d963ee4d6c5f26bc5ad57c1d2b1
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100524-payer-capricorn-e50f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'
> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From 3e4a10a4718e3d963ee4d6c5f26bc5ad57c1d2b1 Mon Sep 17 00:00:00 2001
> From: Dinh Nguyen <dinguyen@kernel.org>
> Date: Fri, 11 Sep 2026 07:06:26 -0500
> Subject: [PATCH] EDAC/altera: Fix memory leak on dci allocation failure
> 
> Sashiko reports:
> 
> "If devres_open_group() fails, the function returns -ENOMEM without freeing the
> dci structure allocated earlier with edac_device_alloc_ctl_info()."
> 
> Free the dci structure if devres_open_group() fails.
> 
> Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Cc: stable@vger.kernel.org # 6.18+
			       ^^^^^

You probably should drop all backports before 6.18.

Like we marked it!!! :-P

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
