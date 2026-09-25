Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FD53B71C3;
	Fri, 25 Sep 2026 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790337241; cv=none; b=RhTDZUzXptGcvtuo1QZUX1j08WWFQvqS/Qns4FiGubvdbU60OSz5Uueqqf+CurV5s6BXaaBLtzxyshpCfFvR6B/NmaPY8QceKOT2r/+tCpXqpvqm6Q8qL9Nsq37Z/cIMyJIFRYz5R71TVDXIP1CmLiW58o8L32bTY8SB4ItVvTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790337241; c=relaxed/simple;
	bh=M8CSeWPjnW05A7DrY7mPn+F+BpIMgsiJ1z+GDmePkSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X3fjKpp7gmHm319IlBL5cAf6nlt9O9KF1aapgp0UAm2ljCuoscQycvg67SCOGxho0yUh9IhBp36mH5MJSX8NBn8JmiY3W/jlUIhUgB4gncYTaZmkD5QuU6mF0odop2A3+tcotSs9TN0wd2fV4T9nxz8TV/wynjZvZfBzDOGgKN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5ejPjSA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5ejPjSA"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F13E61F00893;
	Fri, 25 Sep 2026 11:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790337239;
	bh=KH2oWimsuJqpRuTHToiWxIBlDljWFFvnRtlljEb5f4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I5ejPjSAfTK7pW6A6DrNxAk2Ttm4ZG980e7dNr59iMLOe+XTEZ5m36ATtlxE3o9JU
	 wi/hZ3lTHAAzP76IXW0zKW8tLXjlFjo/kIDu0STfuly1tAjdcC0nKyA/l04kZefzUz
	 46o4ApwP/t81BCbDyNV4yQV6S9rAX+BXj0sZAJxE8hlfxueRaaB5pGPfMM1n52vfGS
	 sfNsaiihgiqDce+iQjFio+EJLUoE1uoCietK37ZHYmPCIne5mjZlZbAKVu2k891W6k
	 AwFjiBgBom7jnSJLufKKcYyqmfpXiig8cTrXhBXrIbsBBNcl6lThIUPck3P8cSs5yg
	 b01F/O0mzKSYg==
Date: Fri, 25 Sep 2026 14:53:55 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yuqi Xu <xuyuqiabc@gmail.com>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org,
	Vega <vega@nebusec.ai>, Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: Re: [PATCH 1/1] tpm: ignore duplicate PCR banks in
 tpm2_get_pcr_allocation
Message-ID: <arZg081NHaBL4O5G@kernel.org>
References: <cover.1789800840.git.xuyuqiabc@gmail.com>
 <85b8cbb1985c743325d57e05d51d8814d3c56549.1789800840.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85b8cbb1985c743325d57e05d51d8814d3c56549.1789800840.git.xuyuqiabc@gmail.com>

On Sat, Sep 19, 2026 at 04:47:00PM +0800, Yuqi Xu wrote:
> The TPM2_CAP_PCRS response is external input and may contain duplicate
> hash algorithms.  tpm2_get_pcr_allocation() adds every active selection
> to allocated_banks, while tpm_sysfs_add_device() has one group slot per
> distinct hash algorithm.  Eight duplicate selections can therefore make
> it write past chip->groups[].
> 
> Keep allocated_banks unique by ignoring duplicate hash algorithms while
> parsing the response.
> 
> Fixes: aab73d952402 ("tpm: add sysfs exports for all banks of PCR registers")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
> Reviewed-by: Ren Wei <weir@nebusec.ai>
> ---

It may not contain duplicates as per protocol spec i.e., instead of
silently ignoring the error -EIO should be returned. TPM should not
be enabled if it is compromised.

>  drivers/char/tpm/tpm2-cmd.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index ae22295df798..99e9d89b18e1 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -527,6 +527,7 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>  	u32 rsp_len;
>  	int rc;
>  	int i = 0;
> +	int j;
>  
>  	struct tpm_buf *buf __free(kfree) = kzalloc(TPM_BUFSIZE, GFP_KERNEL);
>  	if (!buf)
> @@ -569,13 +570,20 @@ ssize_t tpm2_get_pcr_allocation(struct tpm_chip *chip)
>  		pcr_select_offset = memchr_inv(pcr_selection.pcr_select, 0,
>  					       pcr_selection.size_of_select);
>  		if (pcr_select_offset) {
> -			chip->allocated_banks[nr_alloc_banks].alg_id = hash_alg;
> +			for (j = 0; j < nr_alloc_banks; j++) {
> +				if (chip->allocated_banks[j].alg_id == hash_alg)
> +					break;
> +			}
>  
> -			rc = tpm2_init_bank_info(chip, nr_alloc_banks);
> -			if (rc < 0)
> -				break;
> +			if (j == nr_alloc_banks) {
> +				chip->allocated_banks[nr_alloc_banks].alg_id = hash_alg;
>  
> -			nr_alloc_banks++;
> +				rc = tpm2_init_bank_info(chip, nr_alloc_banks);
> +				if (rc < 0)
> +					break;
> +
> +				nr_alloc_banks++;
> +			}
>  		}
>  
>  		sizeof_pcr_selection = sizeof(pcr_selection.hash_alg) +
> -- 
> 2.55.0
> 

Br, Jarkko
