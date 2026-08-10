Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C4D35AC16;
	Mon, 10 Aug 2026 15:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786376351; cv=none; b=sah23gYVJAfqSCIXwLjQer2cEtOmzfYalQbH/lLBLPDEUNMDc2rXRATgNT1tJ5tpOfTArmCf/FzgJJbxebesUjET5+qsLRkq7mJXNMwjZc3D6mONzZZXu5+aiA6JwUmx59CEU6+lAofhWijr+YIkFxZ0BKfOA6a3LMyyrydxbuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786376351; c=relaxed/simple;
	bh=+LqkHQep1KHiZLNJ6qsz5sLE9mi0YmmLXDoNmHu4/20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ClX+uM8NoxuYT6eMAi2YiOGxKal7ThzENUGH+f6zZPMLYHFTuqlQCUks6ZYb2hz9s2J1CDsQvvlfKzGFUH1JycQmZWONpwfqC17de/hNp2CUXvFiW6L0iJdE++8r+5cLULBM1A3lFDr03smF4w5TiebonKywDMp2ela2YS5FT5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c62h8VDd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c62h8VDd"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 44DB91F000E9;
	Mon, 10 Aug 2026 15:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786376350;
	bh=Y5IlW+UoYImc9M9babjCZDjXvbHxEaG1fWYIG9Orny8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c62h8VDdrRzfvvrT85q/7tdAS3nwv1ncHT3ck5Cg/SoVlTjjeo8CFDHJLsDg16Pw9
	 xwpAKBE6BL5ar+7BQF/GX6CF4tNT2p5W7+wbsqI6h48O4lCoLHqZK+6Me9TtNgZrsx
	 rBpMhc3KVHz2GGR8YUsoAG4vWouZw2JFkKlBYyLX+autyvNN5bhQkfLFowl6auccEK
	 9qTjOQO69TXqIY8oMoC50H5eVx6/P3ZoU6WzIGkG1ttdot5kVTJ4R0kyeNvYyGGSeo
	 SE7YawgVCVfSo6gyJvpUYzkTfRi28CaGSbF7gQnEwGFHhqIs6mSDzXZ3GvEnoVUIOp
	 Nz9UUP1YlgaTQ==
Date: Mon, 10 Aug 2026 18:39:07 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Fix barriers to prevent hwrng from activating
 during resume
Message-ID: <annwm6hZLiTE0hM9@kernel.org>
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
>  
>  	return 0;
>  }
> -- 
> 2.43.0


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Applied.

BR, Jarkko
