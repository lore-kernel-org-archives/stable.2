Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C73BF698;
	Wed,  9 Sep 2026 22:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991375; cv=none; b=eFGphoqYtV9IKjl+ur+sGVdvkOiJsLv1inCkAhjuvmcDeuz45AlZNHxirSyN6tHIy2yDoTrFK8gdtLrpRyqfcwMEUETy29rRh4yA+QU7FlXqg8KqtaZ8LBLVO1W6i0wD6XQ74aB8+K6AITuSSh7etwgR15zgO4oYLixaq+2RlMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991375; c=relaxed/simple;
	bh=PIr999dkVsqkNOP/mQaDPLNlNBJ9hu0hty2k+AWuDUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tv3fqw37R4ys0zxQocz8aftareAUZM6tQuwiEwN/0VjB/BhLHd617xOONUGzAvw1VtiHIJcPL1CswSlPdKM4N5exXy5yJg96rPtaHIX92KIzGDdEFuP6B5dfF2KcuiVyLfH+qZrvxMcHyknbsIc0Dl2Fkx8OaXZeaq7SNW29QxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WUFyUyXs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WUFyUyXs"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1CFDD1F000FF;
	Wed,  9 Sep 2026 22:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788991368;
	bh=o/7/fOJJihJD6TeJR+1NHG1ohDsYNgeDfHT951V/5yI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WUFyUyXsZVLSRRTRrZzJPzLeXcVQ7ffdyFIEFD0GLUu7QVao/lcht3+yY/FojyJY6
	 ehPeVL2+fY0K9YgelzhP1zrBLrdU5x4Dcaf7HFyXgwqbl7/yrS0hhs5kWtiPtJ3Eon
	 +qleLYRU3U5keyZrPQ/TEk61aSK2/NIsiWU24qILWtWMehzpzZn6rJB1jkSM3cgxl/
	 P8tVLjx2hDrkZTz25GHgX9qyjPsV90SAF2al1gt6Df7WBz960TXlIo66x3FiAp5tPg
	 HTOkWKZs+CvNVhlpR+dHez210xCLtsNR0a65LtYKNO4tzVSMT238IIz/J7Z9D76qUl
	 r51Lcd2FsXsOw==
Date: Thu, 10 Sep 2026 01:02:44 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
	rnsastry@linux.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] keys/trusted_keys: return immediately after TPM
 unseal failure
Message-ID: <aqHXhOrIbtMdGGoi@kernel.org>
References: <20260902230305.118931-1-ssrish@linux.ibm.com>
 <20260902230305.118931-2-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902230305.118931-2-ssrish@linux.ibm.com>

On Thu, Sep 03, 2026 at 04:33:04AM +0530, Srish Srinivasan wrote:
> trusted_tpm_unseal() proceeds to pcrlock() when the TPM unseal operation
> fails. If pcrlock() succeeds, its return value overwrites the unseal error,
> causing key instantiation to succeed.
> 
> Return immediately when unseal fails to preserve the original error.
> 
> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> ---
>  security/keys/trusted-keys/trusted_tpm1.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index bf0bf7f36970..9cdfeea800a3 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -923,8 +923,10 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>  		ret = tpm2_unseal_trusted(chip, p, options);
>  	else
>  		ret = key_unseal(p, options);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		pr_info("key_unseal failed (%d)\n", ret);
> +		goto out;
> +	}
>  
>  	if (options->pcrlock) {
>  		ret = pcrlock(options->pcrlock);
> -- 
> 2.53.0
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
