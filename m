Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FD5313531;
	Mon,  3 Aug 2026 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785758444; cv=none; b=pLkr064Tnoej3+9DWQ0srpuJl++eo3DodkcVopB730WK+Pz7WrbOWIx21eIFN1Oc6ClrNXuzt/7SHplGBNGEnWBLwRAZUOciqZCsDfCtBjUBAmHBkHCaL1MPjWA4i6nayLM9XpX3ckso+pwIJYFXCwKalOt5asebcPGRqgXbYS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785758444; c=relaxed/simple;
	bh=BT9GWJtVVrS2BBBQG8aJNa680svm6JNKn0amoUDiWwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bON85f8x3F9guL3aiXCUm2q8fkaDTSNIbXcrTEs08J4Ygw3q99u3hc7Kpp/SW2piqkPS3s1WmghZR5E+R4LyElPLHUfKNpi7bR/3wfN27baFf2ZP4bzgi3mCL2kUQTZVDEgiFCrQpD5msWz6dji1DyM3/NKxAnA6ynxbeWXhLgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP2cnZ0f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP2cnZ0f"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 65ECC1F000E9;
	Mon,  3 Aug 2026 12:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785758442;
	bh=71sbyhVDBh38HisjpXYvaRZFmS35eIgPTmNGZGCuzTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eP2cnZ0f2ho0ODyMxjnwlrLBqMixv/8aBq/FHTp/qJd0NvYOW8G/c5AaGCBsCr5R2
	 zTbGtoIl9qQfIHr+tTxwflhdiRH/kyu+u0E4g8w2m1zE+uLLl+800eCy5wMsKmfSsO
	 N5nCW4Zy+sogYGPYHAXdHlcQ0XDlXfmRiZ6xG36GVqVCpMFdie/weXAlWfwrFw/YQr
	 bColrShWuQNVQlkE+Ms+jDipFhi5HkZnbndJNBwAW7xxx/z7RKZTOmEth86IYAVR2S
	 Obg5tVvE/axKD0yCUb7S9nAAeBW+LLLujm8pw1kz6v4GnpN1YgKVL5tKkxEuDEAy3w
	 dBlIwVtgZZ1lA==
Date: Mon, 3 Aug 2026 15:00:39 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	"open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Fix barriers to prevent hwrng from activating
 during resume
Message-ID: <anCC57TeFgluohBt@kernel.org>
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

Thanks I investigate this properly before answering. It's my first day
after holiday so might take until Tue/Wed.

PS. And if someone noticed, sorry for copy-pasting the same response to
two bug reports. I just cherry-picked critical looking stuff from my
inbox :-)

BR, Jarkko

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
> 
