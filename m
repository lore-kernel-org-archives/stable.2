Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B9D296BD2;
	Sat, 19 Sep 2026 05:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789795973; cv=none; b=u8/FJV8zInaJOOWz65qJ1fZeRIeIl9YRJSZKxfdX5yQ5F13j595OSsROSzugWHPpvM5E+mODhl4lYUQnkGQxb1k4bwWBw26tO31uayFh02JkfcEfmcEAOY4u5sMu5DtQigCx+Vsow4ap9pdRITlcjBu/bYfgCGU4NUvKq6ClH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789795973; c=relaxed/simple;
	bh=jVCJCUYTQa8rV2LmuddgI8qQewIHG7uwDF2ztBf6Ckg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLTSoYr5W0MChW22dIEElEM8+CxBX97KkQZ2AHyIRiyhSKiERPLYZtIyjIATU086wZd50+A6v2EF6IUL8lDSQzZnwAwul+S3HMeyNJMp1drD8qCZyWtlZlxT9QP2eGqdK1v0fx7bpII2H4e6TLoBdocsFvBKg6YHkhZlX2HLGXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ZHxhM3+r; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ZHxhM3+r"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6800F40E01DD;
	Sat, 19 Sep 2026 05:32:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4rzDwpKcnbv1; Sat, 19 Sep 2026 05:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1789795962; bh=Jp347S+tUf4NrCs21r22Wb4cHWwaVrLnTpDkB8ZMX0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZHxhM3+r3yt0P5oLEP0eAKFABDknErakkfox4mBN7yUso40/66WKmZEc5GzkcYe0l
	 uo1/3/B0umPnR8aU2Qdoe//G/yZQFn/Mm1UpbfWFsMX9uFdryPk4GrC6P3uSHfQHH/
	 UwlMzr4Hs6ilsWaK8qEXuiXX1D4BuRR9ko9EmhlIFNxjy2t8zMIbHJLi9Ksuh+FXyF
	 Xg8NxFzB4SgWNs7CYJWmAbt9xlYn9hJ8tWbCR/l4S5Egvh0YXr7K2/tiHvgqwDDLDv
	 Yg6eFVgK26yvM2vAax9rYWm5Th0cLZl2rdPBBJy8vM61K4Ld9+yJlhcWla9aCJHTxp
	 /1tFtBQoduJkOOND7iAR/cKqGrzILmsyuiW+S0Sbir70Jte4fUTg7mwxBA+TEyGiqR
	 5cn/0tRqJ6+6Hx9B6i9q/r2zfMRIGj4R1Ypqe9NckIO76Z92AgBsjI+pwvwhr3Ylp2
	 qzPd64IpQGWB0DYVkprvJmDdnhmNYpbHRZkeWT7FTT3L4YNz2tRh+FvfeeW98/mzFt
	 /uGO+vf+ANiEsOWOCqU3BGhTACvtoMO+TNE4NC3d+3X5pPu9SHFCyaq+Ymz1hmSTbp
	 wvpXgsbJtkuP4CCYR2nTruJgatxitY0n3ygHS7IerlI4nOk17cqfsxGJsK+8tjzxFK
	 jaSbXY7NYU7yf9JkVR25Qxzc=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 50F0D40E015B;
	Sat, 19 Sep 2026 05:32:34 +0000 (UTC)
Date: Fri, 18 Sep 2026 22:32:30 -0700
From: Borislav Petkov <bp@alien8.de>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: akpm@linux-foundation.org, dougthompson@xmission.com,
	linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
	mitake@clustcom.com, tony.luck@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH] EDAC/x38: Fix mci_pdev reference leak in x38_init_one()
Message-ID: <20260919053230.GDaq4eblgO_HsGHXQ8@fat_crate.local>
References: <20260916092121.2000892-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260916092121.2000892-1-vulab@iscas.ac.cn>

On Wed, Sep 16, 2026 at 09:21:21AM +0000, Wentao Liang wrote:
> In x38_init_one(), a reference to the PCI device is taken with
> pci_dev_get() and stored in the global mci_pdev even when x38_probe1()
> fails.  On that path x38_registered keeps its initial value of 1, so
> x38_exit() skips the pci_dev_put() and the reference is leaked.
> 
> Only take the reference after x38_probe1() succeeds.
> 
> Fixes: df8bc08c192f ("edac x38: new MC driver module")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/edac/x38_edac.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/edac/x38_edac.c b/drivers/edac/x38_edac.c
> index 292dda754c23..9c6542c4e3ee 100644
> --- a/drivers/edac/x38_edac.c
> +++ b/drivers/edac/x38_edac.c
> @@ -423,10 +423,13 @@ static int x38_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		return -EIO;
>  
>  	rc = x38_probe1(pdev, ent->driver_data);
> +	if (rc)
> +		return rc;
> +
>  	if (!mci_pdev)
>  		mci_pdev = pci_dev_get(pdev);
>  
> -	return rc;
> +	return 0;
>  }
>  
>  static void x38_remove_one(struct pci_dev *pdev)
> -- 

We just orphaned this driver but it has been practically an orphan a long time
ago already.

No need to send fixes for it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
