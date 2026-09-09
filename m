Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E09492E33;
	Wed,  9 Sep 2026 00:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788912821; cv=none; b=eeSvQAFy/dsSlEMNQdnasTxNzYdvZmgrVbJgHbjtGRYy3NaY3xDiOgsxzjhJ0WrOBfd4I7Wc4meYaMaJnJAJyEhtvWlNycoc2KQNYgLTegwmM6BDZXPFMEn1YnxksD2q0joCH4uvwl6E5aSEi2SqYkNDWLCOrysTX64BdYsEn6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788912821; c=relaxed/simple;
	bh=HIFf88ACSjBpSsB22CEams1/Un1rG9U83Vusrxht4r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JN1qPwIAPIdQK6iCWNl3MdX436LzLFsAGvbAlSqBL5PL4+7eCPQxv+dqMNMjm1s1LoT4hRM2zgfyBLl5NpbMfCPeneI6MWLHBmzWti90kN1/UptNUI34aLZ04jTQIWHH6ajelVB8oKYqudqOrZLA1gU9NlWGwUb7JBXkdRU3Yaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=fOC4hFNr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="fOC4hFNr"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 041CA40E01E1;
	Wed,  9 Sep 2026 00:13:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dxklJezAZa5G; Wed,  9 Sep 2026 00:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788912804; bh=as05g1hAqgdNnjznDYHEyoHHqmrfV+KyUOcXb/MunjE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fOC4hFNrw16JFLNGfT3DOY4c5QzrTYhEstJCE8jaq1Y4/bteISyWl8lC8iRDG942F
	 V8QIRF9Sh3Q+1NStLwgLFJoXDHw13ngweh/WX5aJ4IXa1STSKRAgmIPfV1SgllWCh1
	 /prxKC1+BYkufuEZoZZNl3ZeqDabp8CYnJzgg1SyrM8uezr9L7U+KPWLyAmLBwDDS0
	 uPPPqrvLRqP5E0d8nAWryTphU/a/dfv/IVG47LarXe0HxmM4kx3Uz7vkZQXKf6hfIi
	 Y6rdaxDzdQzhiDx+Idf6YldK7Gwzb6hMA8q+2DlhqGHvagmE+OYheWO5Wjo3Oow4i0
	 wUxI/0cXEwBBiMBUtnMPnuYrwljrRpfnEuQ1IEkDVplg+VKX6UQNw2F3R0vISP4FC/
	 MGrffijiXe8XQCTvN8K5SpkkXyQCM3Dd+Nzcoycmaqo4F74M03lBpbnZSVz+zko1ZG
	 O3E09Sx0IxMOG4zj5LVnTuAvRcVZ6F6gWU+aNqKqsrd5bQH8guMJZF+Z1otSCt39oj
	 Ldrm5P7Jqr0aBPTmwm4t9+pIrCUf2BuOCgpZoeV/uk/10D/x/hDpa7tm/xdRlVGNWh
	 1QVkgNWgWFRWJseq6QKRsMTiE7J7/gHlJSFjvPmlyzrTqVMxMH5QSMQrm9jFEQFbav
	 YdxTZLc4uPaFw/AbKu1ykr4Y=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0BE8F40E015D;
	Wed,  9 Sep 2026 00:13:12 +0000 (UTC)
Date: Tue, 8 Sep 2026 17:13:09 -0700
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@kernel.org,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	andrew.cooper3@citrix.com, arjan.van.de.ven@intel.com,
	sohil.mehta@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/microcode/intel: Reject problematic loading on
 Granite Rapids systems
Message-ID: <20260909001309.GGaqCklY8mNHjyJsH_@fat_crate.local>
References: <20260901231634.714144-2-chang.seok.bae@intel.com>
 <20260908223209.916758-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260908223209.916758-1-chang.seok.bae@intel.com>

On Tue, Sep 08, 2026 at 10:32:09PM +0000, Chang S. Bae wrote:
> Microcode updates can usually jump revisions. However, there is an
> erratum on Granite Rapids systems. If they "jump over" to revision
> 0x1000405 or later, they result in #MC.
>
> Prevent loading 0x1000405 or later unless the running revision is already
> at least 0x1000405. Apply this blocking to both early- and late-loading
> paths.

People have got to stop explaining the patch in the commit message. That
should be obvious from the diff. If you have to explain it then there is
something very non-obvious here which I don't see it...

> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: <stable@vger.kernel.org>
> ---
> V1 -> V2:
> * Cut the code comments and print messages (Boris)
> * Rename the new function and keep the old function as it-is (Boris)
> * Rewrote the changelog (Dave)
> * Add `revision` in the error messages (Sohil)
> ---
>  arch/x86/kernel/cpu/microcode/intel.c | 32 +++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 1142183c950c..61ad280497e9 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -309,6 +309,32 @@ static void save_microcode_patch(struct microcode_intel *patch)
>  		pr_err("Unable to allocate microcode memory size: %u\n", size);
>  }
>  
> +static bool revision_banned(struct cpu_signature *sig, u32 rev)

I like Andy's naming:

https://lore.kernel.org/xen-devel/20260908171525.3196765-1-andrew.cooper3@citrix.com/T/#u

...is_safe is much better than banned.

> +{
> +	u32 vfm = IFM(x86_family(sig->sig), x86_model(sig->sig));
> +
> +	/*
> +	 * Revision 0x1000405 contains prerequisite changes for subsequent
> +	 * microcode updates on Granite Rapids systems. Updates directly from
> +	 * an older revision to this or a newer one can result in #MC. This is
> +	 * documented item GNR98, #835486 (Intel Xeon 6900/6700/6500-Series
> +	 * Processors with P-Cores).
> +	 */

What dhansen said - keep this short'n'sweet.

> +	if (vfm == INTEL_GRANITERAPIDS_X &&
> +	    x86_stepping(sig->sig) == 1 &&
> +	    sig->pf & 0x95 &&
> +	    sig->rev < 0x1000405 &&
> +	    rev >= 0x1000405) {
> +		if (rev == 0x1000405)

I also like Andy's testing of the patch revs:

+         ((cpu_sig->rev < 0x01000380 && mc->rev >= 0x01000405) ||
+          (cpu_sig->rev < 0x01000405 && mc->rev >  0x01000405)) )

> +			pr_err_once("Erratum GNR98: revision 0x1000405 is not loadable.\n");
> +		else
> +			pr_err_once("Erratum GNR98: revision 0x1000405 is required before 0x%x.\n", rev);

And you don't need those semi-identical strings here.

> +		return true;
> +	}
> +
> +	return false;
> +}

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
