Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7D93B47D5;
	Tue,  8 Sep 2026 23:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909379; cv=none; b=nOsyvKPcmjoiJ29QGI62J4kZOPjngGerzwyOk/G6uLNZZ8Q29TjxMlYVL9dOWPSrNNnMrxtNWbnoveVbZllObpPjPO+yr8awJP+X9eCbVfGefbb055Q1WV+q17G2PV5nwroDvfVNP67GpGGpGwus9xU9/nY/wOHQhAlEumZk5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909379; c=relaxed/simple;
	bh=FZkpYr2uck61cIN+btm62m8JTmhwKvtSUVKcro10fDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rldq9SeCVsYOYj1YegAEafGGi5vrjwp6Y3iR444IR9XMF6U3GgxE6zs5aZ/8sBLkdlHK06NL/t0evcq1bcPKo/q3+534+zstYnekpC3RA1SS/zw7R+QvszrtYp0fp8eDy0MOnMCoArzaHQWyTuSSNOP1VNSeDJGADhEA2Kej4/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D7GlLWtc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D7GlLWtc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788909377; x=1820445377;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=FZkpYr2uck61cIN+btm62m8JTmhwKvtSUVKcro10fDg=;
  b=D7GlLWtcWKpIAoYUG0hrMLaJTcDAQJj65sXFBRDnMuxW1Ejqey/y4Jfi
   9ouodX7E65p++Y8YOHKMxFI5wptnX2D5ZLBY0hx+EtWEd3vgh2KlVMzeu
   YoXWmc10mCRH7g6rG4xozwxO8xOwvSYmEIihaZK0RwoLXfamPjk5So5BZ
   NPZ08OfAnMXlkX9u1RYBkFEptPlKcHO9NBiSvbenpx55UjIh7y33jeLUB
   0xv33i3XDLMKdEl/jNrwKXyIFuIW1b7ToDz/aTRD5mzY2fR9U3uM7r2PG
   euSSzxOy0+p0vIMe6T7cJtC1AR8z5iw/zjyUZA3BEn8xO5kQ5hYdPI82f
   Q==;
X-CSE-ConnectionGUID: bEZlsgPiSryTvRcRUN1nUw==
X-CSE-MsgGUID: 67T/L0UPQR+ME8f/IUVHRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89530231"
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="89530231"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 16:16:17 -0700
X-CSE-ConnectionGUID: Schtx44rSbaLD/hyOT7Xhg==
X-CSE-MsgGUID: BXnrmtFgSBGzQoZTi5oWBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,269,1779174000"; 
   d="scan'208";a="266829125"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.111.130]) ([10.125.111.130])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 16:16:16 -0700
Message-ID: <0bfbb372-31cc-42af-b485-001f9a64f3b5@intel.com>
Date: Tue, 8 Sep 2026 16:16:15 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] x86/microcode/intel: Reject problematic loading on
 Granite Rapids systems
To: "Chang S. Bae" <chang.seok.bae@intel.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, andrew.cooper3@citrix.com,
 arjan.van.de.ven@intel.com, sohil.mehta@intel.com, stable@vger.kernel.org
References: <20260901231634.714144-2-chang.seok.bae@intel.com>
 <20260908223209.916758-1-chang.seok.bae@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20260908223209.916758-1-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/8/26 15:32, Chang S. Bae wrote:
> Microcode updates can usually jump revisions. However, there is an
> erratum on Granite Rapids systems. If they "jump over" to revision
> 0x1000405 or later, they result in #MC.
> 
> Prevent loading 0x1000405 or later unless the running revision is already
> at least 0x1000405. Apply this blocking to both early- and late-loading
> paths.

This is a kinda wonky-looking patch but I don't know a nicer way to do
it, so:

Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

> +static bool revision_banned(struct cpu_signature *sig, u32 rev)
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

I honestly still prefer that this comment be more short and sweet. Does
this miss anything?

	/*
	 * Erratum GNR98 can cause #MC's if "jumping over"
	 * revision 0x1000405. Avoid the jumps.
	 */

Also, we don't need to put whole document titles or numbers in here.
They're fine, but if you can Google "erratum GNR98" and get the doc for
the first hit, what does it matter?

Leave the precision and long chit chat for the changelog, I say.

But we can edit this in place when it gets applied.

> +	if (vfm == INTEL_GRANITERAPIDS_X &&
> +	    x86_stepping(sig->sig) == 1 &&
> +	    sig->pf & 0x95 &&
> +	    sig->rev < 0x1000405 &&
> +	    rev >= 0x1000405) {
> +		if (rev == 0x1000405)
> +			pr_err_once("Erratum GNR98: revision 0x1000405 is not loadable.\n");
> +		else
> +			pr_err_once("Erratum GNR98: revision 0x1000405 is required before 0x%x.\n", rev);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  /* Scan blob for microcode matching the boot CPUs family, model, stepping */
>  static __init struct microcode_intel *scan_microcode(void *data, size_t size,
>  						     struct ucode_cpu_info *uci,
> @@ -330,6 +356,9 @@ static __init struct microcode_intel *scan_microcode(void *data, size_t size,
>  		if (!intel_find_matching_signature(data, &uci->cpu_sig))
>  			continue;
>  
> +		if (revision_banned(&uci->cpu_sig, mc_header->rev))
> +			continue;
> +
>  		/*
>  		 * For saving the early microcode, find the matching revision which
>  		 * was loaded on the BSP.
> @@ -878,6 +907,9 @@ static enum ucode_state parse_microcode_blobs(int cpu, struct iov_iter *iter)
>  		if (!intel_find_matching_signature(mc, &uci->cpu_sig))
>  			continue;
>  
> +		if (revision_banned(&uci->cpu_sig, mc_header.rev))
> +			continue;
> +
>  		is_safe = ucode_validate_minrev(&mc_header);
>  		if (force_minrev && !is_safe)
>  			continue;

