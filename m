Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC6E3148DD;
	Fri, 18 Sep 2026 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789714449; cv=none; b=Su8nBBrHLNQQKcdQvi2eBeq7Rm/2QW234XscACoE5gXLxtC7yRxbNivAuPvxOENv16cBQDyr9avx/uyAriqFi7owV3XyKKFxLQnhWiXdolAljZICT4jIGfYe585IdfnRy7V6DTFGm0JWe4eVEzXIde6hDgdoanpcwGuiRNxjsfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789714449; c=relaxed/simple;
	bh=h5AnNenFDUGze3sFlUX4eeDZWfmuaoCj7vCYcXHh/20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsWKVgXlb/mhHFOTfwDTEnWQNDCHtrlirtFgM5BKQm4hBS9oJEwXRCzU37SD9xJtaG+YPrUW8gK1yNJO/SR8GtP+Xlp+lA2tABhURhTJleEC6etK40T4bcLc7fnHxGEv7tBLVktI0P7qjtasQG1DhpvZbcPNoNJVEZCxYC/X5WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUeoShxp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUeoShxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D321F000FF;
	Fri, 18 Sep 2026 06:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789714447;
	bh=csRqZiafzhTfb75zREhA3CBU+pjzsX8p5cYdBB7wQRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IUeoShxplnclJc+KvKg/U6YU2hEo7nuq7V8Kwg/pPQHuLu4RycSV9670PFXzCdNd2
	 7aVCN/GDOBI6FY5TGzmtLpoQspECTpmjIKzia4ufhijnfVDBFjhsQn19A+klD03doQ
	 p3rPeSOFUnQwDmly3Y4gULa5U4R66nCz15kJF0FPIpoojK61wcBiAR+GreAGufPZUv
	 7vNaj4BYgyEolBRIxy7fpIf/TQ1Pi9d39e5kw2b1G6/l0MPEsx6p2p77GLU0/VI8pj
	 CjZqjoUI5pyC1TamRJ+VHmfJQVI9g31ekTbEgjvKheQi7D4hWj0xrNdUy4gEeqfAIB
	 k4+1+FvIPiZLw==
Date: Fri, 18 Sep 2026 08:54:01 +0200
From: Ingo Molnar <mingo@kernel.org>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, andrew.cooper3@citrix.com,
	arjan.van.de.ven@intel.com, sohil.mehta@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] x86/microcode/intel: Reject problematic loading on
 Granite Rapids systems
Message-ID: <aqzgCatxdoLDvS1B@gmail.com>
References: <20260908223209.916758-1-chang.seok.bae@intel.com>
 <20260916225939.1144524-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916225939.1144524-1-chang.seok.bae@intel.com>


* Chang S. Bae <chang.seok.bae@intel.com> wrote:

> Microcode updates can usually jump revisions. However, there is an
> erratum on Granite Rapids systems. If they "jump over" revision
> 0x1000405, they result in #MC. Avoid it.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> ---
> V2 -> V3:
> * Shorten the changelog and rename the function (Boris)
> * Reduce the code comment (Dave)
> * Allow 0x1000405 loading. Thanks to Andrew, this fix got attention.
> * Collect Dave review tag. Thanks, Dave!
> 
> Note:
> * GNR98 currently describes loading 0x1000405 itself is unsafe, but it
>   will be updated to say okay with that. I will watch out the GNR98
>   changes.
> * Jumping from < 0x1000380 to 0x1000405 was identified as an issue, but
>   0x1000380 is the first revision as GNR products. So loading 0x1000405
>   in production systems should be okay.
> ---
>  arch/x86/kernel/cpu/microcode/intel.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
> index 1142183c950c..30a22388d4b1 100644
> --- a/arch/x86/kernel/cpu/microcode/intel.c
> +++ b/arch/x86/kernel/cpu/microcode/intel.c
> @@ -309,6 +309,26 @@ static void save_microcode_patch(struct microcode_intel *patch)
>  		pr_err("Unable to allocate microcode memory size: %u\n", size);
>  }
>  
> +static bool revision_is_safe(struct cpu_signature *sig, u32 rev)
> +{
> +	u32 vfm = IFM(x86_family(sig->sig), x86_model(sig->sig));
> +
> +	/*
> +	 * Erratum GNR98 can cause #MC's if "jumping over" revision 0x1000405.
> +	 * Avoid the jumps.
> +	 */
> +	if (vfm == INTEL_GRANITERAPIDS_X &&
> +	    x86_stepping(sig->sig) == 1 &&
> +	    sig->pf & 0x95 &&
> +	    sig->rev < 0x1000405 &&
> +	    rev > 0x1000405) {
> +		pr_err_once("Erratum GNR98: skipping revision 0x%x.\n", rev);

So this was explained in a really confusing way, I had to read the
changelog and comments trice and then the code to figure out what's
going on:

 - There's a microcode bug that makes it unsafe to apply current
   post-0x1000405 revisions on Granite Rapid CPUs if the current
   microcode version is below 0x1000405. The interim 0x1000405
   version *must* be applied first for it to be safe to upgrade
   GNR CPUs. Will this be a problem perpetually? Will it be unsafe
   to have an older GNR CPU and simply apply fresh microcode to it,
   without first loading the interim 0x1000405 version? Will GNR
   microcode upgrades on pre-0x1000405 CPUs will always be a
   two-step process?

 - The new code doesn't declare it, but this patch creates a hidden,
   permanent microcode version upgrade barrier if user-space
   firmware/microcode tools do not provide the 0x1000405
   microcode version reliably and implement the two-step upgrade
   workaround.

 - The message the kernel prints is rather passive-aggressive as well:

		Erratum GNR98: skipping revision 0x%x

   It does not explain *why* the fresh microcode upgrade is skipped,
   and if firmware tooling does not apply 0x1000405 then the kernel
   stays in this state indefinitely.

   It should at minimum say something like:

      Erratum GNR98: new revision %x is unsafe to apply until 0x1000405 is applied first, skipping it. Please upgrade firmware tools.

   Because, presumably, this scenario should not be possible with
   new user-space tooling, right?

   The comment and changelog should be updated accordingly as well.

So this patch is still problematic IMO.

Thanks,

	Ingo
