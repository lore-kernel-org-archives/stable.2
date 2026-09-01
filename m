Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3464D33939D;
	Tue,  1 Sep 2026 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270469; cv=none; b=sdL3T4GWs/O/VU9p4ZPkNxfAuAeMukckMYun7+4QdI4R8msZnkNtsGxoEDfJh3hCjn8ABMTQVWDds/LDQ6RaFOK+JEzm1UlklEmHTzY84i+JdvegAvdkv4BRdnfhQDtWpdyEvFXLaA6jsXXWwH6J2Nj38wu0a8ZPHtaWbPbNPdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270469; c=relaxed/simple;
	bh=8NufWEKCYTBSQ9ZAdZ8bxrVe2MhI5ri5JSbDyio0XWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhuI7bYZOG0egzJ2WXeClUBR6dwOFQyCxFacOqFKj0QsjYdG1WLQYE20tX2ol6ukYKGmR5ahzf45zMvJYMVttw30R2xh8zmvD77tv8ReUH64MPKxNIm3hNs5vKRtO5CMmWQ2efSAnXv0tzl6L4WfchwrJES4nfWwzPVlyzbmPrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQ4XHcNs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQ4XHcNs"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3D96A1F000E9;
	Tue,  1 Sep 2026 13:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788270467;
	bh=IbOOibRuzy5r/5hzD8OOpyB0kg/Phkd6z7W0gt00SUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OQ4XHcNstsu0WL8iVTClgZyYudvrx1S9Wr6nJODnf55JQ23xgYfZMPM5zh8EK/P2m
	 HdPjn2kqh/Gg+ldW4AcWqu1O194qIWUno6JHSJTgI3ojbumV3dNDNDPKWHv7RQLOYI
	 /gxuISwqSyaLm0F7M08d0QWlbfIUFvfebiA/BSPuXxqnp5gr3+D6t8asXKYS/jHKL9
	 9Gn29/zx2Kspn6mr2EA+Ut2Sk57fzGT+wEhL6BjTGznPWclYHkSQTiXPIc59tmH4fy
	 mSvgi4zCrGJhWvuQeIwmNNggLAT1xYTNfp5uKNainbUlb/GAaTQxumG4i/R14tRgyj
	 K/UFBaBWMQCFQ==
Date: Tue, 1 Sep 2026 16:47:44 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, ross.philipson@oracle.com,
	stefanb@linux.ibm.com, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, 13667453960@163.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: Fix heap buffer overflow in tpm_transmit_cmd()
Message-ID: <apbXgGwsxAualfEK@kernel.org>
References: <20260901062850.379870-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901062850.379870-1-yijiangshan@kylinos.cn>

On Tue, Sep 01, 2026 at 02:28:50PM +0800, Jiangshan Yi wrote:
> struct tpm_buf now uses an embedded flexible array for data, which is
> 6 bytes shorter than TPM_BUFSIZE due to the struct header. But
> tpm_transmit_cmd() still passes PAGE_SIZE to tpm_transmit(), and after
> clamping to TPM_BUFSIZE in tpm_try_transmit(), chip->ops->recv() can
> write past the end of data[] by 6 bytes.
> 
> Pass buf->capacity to tpm_transmit() instead.
> 
> Fixes: 3d9e043dab0a ("tpm-buf: Memory-safe allocations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  drivers/char/tpm/tpm-interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index f745a098908b..1ccdbde98b69 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -268,7 +268,7 @@ ssize_t tpm_transmit_cmd(struct tpm_chip *chip, struct tpm_buf *buf,
>  	int err;
>  	ssize_t len;
>  
> -	len = tpm_transmit(chip, buf->data, PAGE_SIZE);
> +	len = tpm_transmit(chip, buf->data, buf->capacity);
>  	if (len <  0)
>  		return len;
>  
> -- 
> 2.25.1
> 

Thank you good catch!

I'll apply this and put to rc2 PR. 

BR, Jarkko

