Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19D91E9919;
	Tue, 11 Aug 2026 00:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406628; cv=none; b=eMohvY0kVtVwHARlL3vvGjNfEK3ga7Mt2lW1KA+MzJ8tsKmgeZZWOzwKrDkRKUyi0gizHnzNxPwxKHx8KnWtJ0RrYllonyIqVCcrALTu0YPTv6fksBObF+VJu/DgzaiCpEPdJ8CiXI38EM70P1ZMjjMrS8v4YMUuqlb5raDD8w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406628; c=relaxed/simple;
	bh=/P9QHm2zHqotMSSe2iZuuUACd1GyWWvR5GnC/hFwLpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2zDbwBX7GEf2SXKqrecoWcqMoutoqLW9NTrh3Sduc5kBtJq5QeUvUeCeZ7YjSxKjLCDNGT/kOzf5Pfmrn4ULR9IAU8GXZw+dhO+p5DLVZjmvDj9sxN1+8CiuXOtwWr/LZyYDCg9oJiUeOU9/qvkBrZRJttK3vyLckXqeUMNAOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdpWzzYs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdpWzzYs"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2EF3A1F000E9;
	Tue, 11 Aug 2026 00:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786406621;
	bh=mtkm9rvDeXZtH8T6a3Zip6v46uf5BfM9kAQfKxkAkfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AdpWzzYszYIHkD4M/HyZOvoFXbjQw2VKhMGjZezswGolK23+xVO8IAPvJ7orsaLrR
	 eGiIgv2FDAUuHW9pfZ4qMmGQmuYA5aqE3vOhGg8CthItizILNBG/OyReAz2LPRqdmj
	 z52EA0TlqZ3pckqwpphzOEdG40sZ/vinSn3kTcIAmcMGTYHPqQ6dZsGUh9AN3iiG/E
	 8bM8cAIHE1W1qA/FwdT/9P/Zg04d4CANyU9SFV8Uwe6Fy+1dYKefGRbZ24c+wd2S8/
	 N8NsCmeYuWBeBOe95Tovle5Y5pArn+SPWmkpFhFm6EignfYy/QO+JcDSX3RQmkAsvM
	 YUoH5iEkMTzTA==
Date: Tue, 11 Aug 2026 03:03:37 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Fix barriers to prevent hwrng from activating
 during resume
Message-ID: <anpm2fdZEwOlnMwv@kernel.org>
References: <20260803092240.18348-2-fourier.thomas@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803092240.18348-2-fourier.thomas@gmail.com>

On Mon, Aug 03, 2026 at 11:13:24AM +0200, Thomas Fourier wrote:
> The memory barrier is placed after clearing the suspened flag so
> memory reordering between the wake up and clearing the flag is allowed.
> The reader of the flag is missing the corresponding barrier.
> 
> Clear the flag after the memory barrier and add a memory barrier in
> the reader.
> 
> Fixes: 99d464506255 ("tpm: Prevent hwrng from activating during resume")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---

I tagged this too quickly, sorry, let's revisit the patch a bit
just to make sure that we do right things right.

>  drivers/char/tpm/tpm-chip.c      | 3 +++
>  drivers/char/tpm/tpm-interface.c | 3 +--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
> index 12b7394b34bd..7f500797b7a7 100644
> --- a/drivers/char/tpm/tpm-chip.c
> +++ b/drivers/char/tpm/tpm-chip.c
> @@ -173,6 +173,9 @@ int tpm_try_get_ops(struct tpm_chip *chip)
>  	if (chip->flags & TPM_CHIP_FLAG_SUSPENDED)
>  		goto out_lock;
>  
> +	/* Ensure that device is fully resumed */
> +	rmb();
> +
>  	rc = tpm_chip_start(chip);
>  	if (rc)
>  		goto out_lock;
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index f745a098908b..2de12b02f62b 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -474,13 +474,12 @@ int tpm_pm_resume(struct device *dev)
>  	if (chip == NULL)
>  		return -ENODEV;
>  
> -	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
> -
>  	/*
>  	 * Guarantee that SUSPENDED is written last, so that hwrng does not
>  	 * activate before the chip has been fully resumed.
>  	 */
>  	wmb();
> +	chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;

Can you rationalize this change?

>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 

BR, Jarkko
