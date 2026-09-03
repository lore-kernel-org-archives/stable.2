Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67F3002A9;
	Thu,  3 Sep 2026 01:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788400370; cv=none; b=rlb6B3BX2pGdodcNM0DLwt08U3hVvvUKJR2qIXufSpSrzYpak+TG6OVFd9jSK8Thk1ctJCUaClwXondIkgvw1MtacGMEoZs8yPhErB5dLI7VQE/YdOzxZNXT8nJWIuevrEmknldEHK7XXB+v8RWtg6cglZoPzLfOSV8sujIoKoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788400370; c=relaxed/simple;
	bh=BPMxLrFZvJjAIDilf0/JQYcl9EOiv5YCfUpd3Y1TxEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRDxoPmh/xorEuks09JM86qTz6bAymzVKFb5p9UZD0jB4BZGc4UEGi1YnpMniODgTdz02SX9s/Oohpkded1mmzp5McJ31ooA5DvNBipHo0uu9EZS7hBAlfN5Tqaz8L5+/0k3FJqIA/2H4kHleTUTtJesgPxIefcLShG1aaCvFAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=UcdH67Y6; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="UcdH67Y6"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E83F740E016C;
	Thu,  3 Sep 2026 01:52:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2WRY7zjPmZgx; Thu,  3 Sep 2026 01:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788400328; bh=2UUatXLSffeF0BsLHmu1+wqtFrFN8+UbBafBkI67yBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UcdH67Y6KWCctvT+15SmLXK1gD8zOpa4q+fvScRLlwD5YdQ/leTBlUmGLHNCYknTA
	 ok7k2cSywhuWreIOqQdTzj6F7XRUP7aTCfeuZ1zS5ax0o95gmKhRoZTCF5cODIH4/5
	 p4RWxSuV3Ufdi3/M1VfSuywyUTz2PlZGl1AWhBnJ6uHwiOpsZutL0Oiz9CAmN/etDF
	 M55f2LjxzOnbrdXaQymI+jd8+7w4azDnSFt7sqKsbjVmGWFQBUPSHmSiQWFaBkFB2t
	 qtkdtsWbvm1s9w4ldGUjBBnWLq6R+TrQjTY2QFTKX+oGMs+PFuSXxpOvQdi6mfKKfg
	 ymWzlwFoL7/tv7gjda57TITE3wL3H2XC3Ve77QdCoBPxYQEJf0ScTNZMYQWAKKdCgC
	 zwAjXVLWGc6GJz6miXYP+o7EUunwz28n1G57zLeuNqT52Sx+7vES+U2mYGOyX3Ru5d
	 DG7eRzaz9JyoGO7JsnNQIFzFMU98RNd4bqr81LJzSPHzO36KzuCIt5P10vhZpZBKu3
	 BqZgoO1VkmudNKcxi6pfy4dTj63GGsTm4WnUCLzo8yxNom23hndMv68ZLswj7+tX1r
	 l1/NpEDQ+g7puV+4Ii587kk+EWIqvwGS6Ui7jENPuJx6dNL9umTTPE9BJ8qfvFS/4z
	 lwqTU8UKeIPt3QL3psGiSWyo=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4D3D640E03D5;
	Thu,  3 Sep 2026 01:51:58 +0000 (UTC)
Date: Wed, 2 Sep 2026 18:51:55 -0700
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@kernel.org,
	mingo@redhat.com, dave.hansen@linux.intel.com, hpa@zytor.com,
	andrew.cooper3@citrix.com, arjan.van.de.ven@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/8] x86/microcode/intel: Reject problematic loading on
 GNR systems
Message-ID: <20260903015154.GMapjSujbkKGzyihVB@fat_crate.local>
References: <20260901231634.714144-1-chang.seok.bae@intel.com>
 <20260901231634.714144-2-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260901231634.714144-2-chang.seok.bae@intel.com>

On Tue, Sep 01, 2026 at 11:16:26PM +0000, Chang S. Bae wrote:
> +static bool is_loading_denied(struct cpu_signature *sig, u32 rev)

This naming is not better, sorry.

Is loading denied means the loading in general is denied because <raisin> or
are you trying to check whether this particular revision should not be loaded?

I think it is latter.

So you wanna say

	revision_blacklisted()

or so.

> +{
> +	u32 vfm = IFM(x86_family(sig->sig), x86_model(sig->sig));
> +
> +	/*
> +	 * Revision 0x1000405 contains prerequisite changes for subsequent
> +	 * microcode updates on Granite Rapids systems. Updates directly from
> +	 * an older revision to this or a newer one can result in #MC (GNR98).
> +	 *
> +	 * This dependency can be indicated from the minimum revision field.
> +	 * However, revision 0x1000423 has an incorrect minimum revision in its

So you lost me here: 0x1000423 is not tested anywhere - just mentioned here.

So what I understand is: usually, dependencies like that can be expressed with
minrev but *in addition* to the current issue, patch 0x1000423 has minrev
wrong so that dependency cannot be upheld there either.

But then why even mention it if you're not going to test it?

Why do we care about GNR101 at all?

> +	 * header (GNR101).
> +	 *
> +	 * Prevent loading 0x1000405 or later unless the CPU has already been
> +	 * updated to 0x1000405 or later.
> +	 */
> +	if (vfm == INTEL_GRANITERAPIDS_X &&
> +	    x86_stepping(sig->sig) == 1 &&
> +	    sig->pf & 0x95 &&
> +	    sig->rev < 0x1000405 &&
> +	    rev >= 0x1000405) {

You don't really need to test rev here - it is enough that sig->rev is
< 0x1000405 - that already makes you susceptible and then you can check rev
inside the { }.

> +		if (rev == 0x1000405)
> +			pr_err_once("Erratum GNR98: 0x1000405 is not loadable.\n");
> +		else
> +			pr_err_once("Erratum GNR98: 0x1000405 is required before 0x%x.\n", rev);
> +		pr_err_once("Please update the system BIOS or firmware.\n");

This is useless most of the time because client won't usually get BIOS
updates. You can tell people they should update their microcode packages
instead. That's where we can really help.

> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  /* Scan blob for microcode matching the boot CPUs family, model, stepping */
>  static __init struct microcode_intel *scan_microcode(void *data, size_t size,
>  						     struct ucode_cpu_info *uci,
> @@ -330,6 +362,9 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
>  		if (!intel_find_matching_signature(data, &uci->cpu_sig))
>  			continue;
>  
> +		if (is_loading_denied(&uci->cpu_sig, mc_header->rev))
> +			continue;
> +
>  		/*
>  		 * For saving the early microcode, find the matching revision which
>  		 * was loaded on the BSP.
> @@ -878,6 +913,9 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
>  		if (!intel_find_matching_signature(mc, &uci->cpu_sig))
>  			continue;
>  
> +		if (is_loading_denied(&uci->cpu_sig, mc_header.rev))
> +			continue;
> +
>  		is_safe = ucode_validate_minrev(&mc_header);
>  		if (force_minrev && !is_safe)
>  			continue;
> @@ -905,7 +943,7 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
>  	return UCODE_ERROR;
>  }
>  
> -static bool is_blacklisted(unsigned int cpu)
> +static bool is_late_loading_denied(unsigned int cpu)
>  {
>  	struct cpuinfo_x86 *c = &cpu_data(cpu);
>  
> @@ -936,7 +974,7 @@ static enum ucode_state request_microcode_fw(int cpu, struct device *device)
>  	struct kvec kvec;
>  	char name[30];
>  
> -	if (is_blacklisted(cpu))
> +	if (is_late_loading_denied(cpu))

Aaaah, you wanna be politically correct and can't use "blacklisted" anymore.

Well, you're not introducing new usage so you don't have to touch old usage.
And "is denied" does not express the situation properly. Try a better one.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
