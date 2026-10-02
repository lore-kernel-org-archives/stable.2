Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D926AC5;
	Fri,  2 Oct 2026 03:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790912680; cv=none; b=TpYGKwBpE+k5n7a6SqdOU8VzS2x1TNDoub3pOQ6A3PWH0G+hlgSWLsvZmn7S/cgdkOE8cNQ73KMhZc1bn+kKdQogq1eiuSF74XNKZ8tjvK6Cl6+jNNgMssKBM5hSMOFM4Dsrjs4wStT1ZhyLTcLECV3LQ7SPuBbLgU6ZHldLhxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790912680; c=relaxed/simple;
	bh=ILPpPq8Vser1NH+/VD1JhEO+iKNEFYL2zNBTQTEwhS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFFvamxapHhUnK+B0sMAq3r51SRybk9PyNRqgnpaocP0hhLjIaBXPEoESJdf78Oz6/5l/VD2CaXuap/iXX4YZPXgvAWFLPZOgLko/6Gfr98SLj1kdKchPTaafdkUudQraNz5pObEosuFE9NZ6uHsjmzwhAdKPq7dWdJ7iCeg+4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4AUjpod; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4AUjpod"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 821AC1F000FF;
	Fri,  2 Oct 2026 03:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790912679;
	bh=ya+ofgI7W4YYzdVJENAGjbAvZq2LEFB3huWIBYBKhXI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g4AUjpodLKOORKyWJrnaPsRWHMsJuCm9GsZlgKFAcwmZBcV8jTcW6rE0lRdFRqBwr
	 CjOlB4jiCZhVvUebh5+D1PA3wxjFRGo89YpLMvQ/KpWztSgxKEerBCtL0+D7zxj/bp
	 ffkCnGvw7nBLiVRjSX3lFp5pz0DG5VFAUYgPF9er9dp530nMQ4RGwYALLwbW+HJOa6
	 ZRvtAoRZX31s1zSkjvS2XBXm1M/LTNvVxBgA3IuncnddEgnOelprfOAK1Agl8XQkNt
	 WQv6FAceX4unesNo1tCQrCFUPVPv412hWhvb0SWtgYzvf8UoF1u5bGGWvzOD/AMYa4
	 2tm1O9RbEbGJg==
Date: Fri, 2 Oct 2026 06:44:34 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "A. Sverdlin" <alexander.sverdlin@siemens.com>
Cc: linux-integrity@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jay Freyensee <why2jjj.linux@gmail.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>,
	Nayna Jain <nayna@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: tpm2_probe: propagate transport errors
Message-ID: <ar8oot0ceRNTMF7p@kernel.org>
References: <20261001060114.1582092-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001060114.1582092-1-alexander.sverdlin@siemens.com>

On Thu, Oct 01, 2026 at 08:01:11AM +0200, A. Sverdlin wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> tpm2_probe() reads the protocol version from the response tag and is
> documented to return -errno on failure, but it always returns 0.  A
> transport error (tpm_transmit_cmd() < 0) is thus swallowed together with
> the intentionally ignored TPM response code, leaving TPM_CHIP_FLAG_TPM2
> unset. A transient bus failure on the first command then misdetects a
> TPM 2.0 as a 1.2 and the probe fails on the TPM 1.2 path:
> 
>   tpm_tis_i2c 0-002e: 1.2 TPM (device-id 0x1C, rev-id 22)
>   tpm tpm0: A TPM error (-62) occurred attempting to determine the timeouts
> 
> Return the transport error instead; rc >= 0 still means a valid header was
> received and the TPM's own response code is still ignored.
> 
> Fixes: 94e266ba1fa3 ("tpm: migrate tpm2_probe() to use struct tpm_buf")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> ---
>  drivers/char/tpm/tpm2-cmd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index a94f4395c198a..4b2bb2ddc321a 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -483,8 +483,9 @@ int tpm2_probe(struct tpm_chip *chip)
>  		out = (struct tpm_header *)buf->data;
>  		if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
>  			chip->flags |= TPM_CHIP_FLAG_TPM2;
> +		return 0;
>  	}
> -	return 0;
> +	return rc;
>  }
>  EXPORT_SYMBOL_GPL(tpm2_probe);
>  
> -- 
> 2.55.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks.

Br, Jarkko
