Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BCD57F724;
	Wed,  9 Sep 2026 15:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788969467; cv=none; b=HS+t/S+BVGuHqtFgi5tM/JneBska2jwRAmuCZoStbos8Lv/krmmtyCuhqLhbl8EZ5kvilfWQdbebhsQUVdyATgT3pKorFst66NJSH/N76AE6umqnltK6J9/D21o77kDtu2qLhukxVFchxLRCS4jHTouuVe8MBH2z9JNEMsie2NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788969467; c=relaxed/simple;
	bh=UsacJRO0IBOW9sLjrzVfAphSQbsb3cBIkkc+0EyhgYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fwNBlduRx5+0Jnz0x6e4//73Ji0FUtF1rilyYYYVEAMwDBYDNcpe/8CiFVbn79dkaQDwnVFjw/mXqDyFRly29i+UNFZ15Hn4LQQfcHf3wwVmwLl8mgDABQKwd6yJHm+BicanL6R0wh6gtrQRQ1J+FNTSdEijP7e22AngrzBj3ZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzJQr+nC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzJQr+nC"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 253A41F00A3A;
	Wed,  9 Sep 2026 15:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788969466;
	bh=M9SJYyQzXEllRJjMf5EQlh0KIDDZNzKZkAIQnq79Cj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LzJQr+nCyPi33SJReLNL8c80/99/Buxzle2qTznrBj9VPeh+cMg4cQkqIClrX4Arg
	 PJknStCgoBaf7vcD4RKLx8tvQuTZUmmLCPjbqYNI4FbeFtlVywYVrupXjaAMRIKuFo
	 aEcjTXN12I/Zr+IwGZSVgCN+NtncoqeldQoBRj1U07XC96pCDOS1slSlCrNBLSfE7T
	 c/I2o2H5Ly/UrU8A3ryfL09UdBonOYJ9Rdg0jXzqme4vlHzl2U9B5+7aEGPLWQYHK8
	 QL0ox84t5PlOOHjo9LAvwwTy8rA+b1/h8CXGMTqE1iylDFAX3WGXiB0dikfX61V20J
	 0z7f5NKArp9Uw==
Date: Wed, 9 Sep 2026 18:57:42 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, ross.philipson@oracle.com,
	stefanb@linux.ibm.com, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, 13667453960@163.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: Fix auth session leak in tpm2_get_random() error
 path
Message-ID: <aqGB9gxUv5IThT_q@kernel.org>
References: <20260902074839.417419-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902074839.417419-1-yijiangshan@kylinos.cn>

On Wed, Sep 02, 2026 at 03:48:39PM +0800, Jiangshan Yi wrote:
> When tpm_buf_fill_hmac_session() fails in tpm2_get_random(), the error
> path returns without calling tpm2_end_auth_session(), leaking the auth
> session. All other error paths in the function handle this correctly.
> 
> Fixes: 3d9e043dab0a ("tpm-buf: Memory-safe allocations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  drivers/char/tpm/tpm2-cmd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 48cec39995fe..96e0e06bbbf0 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -281,8 +281,10 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  		}
>  		tpm_buf_append_u16(buf, num_bytes);
>  		err = tpm_buf_fill_hmac_session(chip, buf);
> -		if (err)
> +		if (err) {
> +			tpm2_end_auth_session(chip);
>  			return err;
> +		}
>  
>  		err = tpm_transmit_cmd(chip, buf,
>  				       offsetof(struct tpm2_get_random_out,
> -- 
> 2.25.1
> 

Thanks for the fix.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
