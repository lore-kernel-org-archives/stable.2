Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7504825A0;
	Wed,  9 Sep 2026 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788993627; cv=none; b=W7mnIYNVCYXjIlScihmYmMmJWJsRpcLGJPv3Si/MXu2arL6oPoEVARQq4sxvgjGmGyJu8jfnq1ha6xKUs2ZCAVUwoB9BRbOvqVF1wqIwandYHPP5QFOB/A7ycdaudHLHOHsCj9/R940lFvJ3lj62g9xuLvaMXO5hS1ZdK71+9mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788993627; c=relaxed/simple;
	bh=2woDYYmqyLDmG6WZhX/y6RAT7b2JBzjj5L8L+GW7rcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZH3nem5Cq2P5+5WeFv+mW534Zr6R2OKSOhovuLyxScBMzyXIQ4eRL5CtWJhOVzSOKEEHR6jy881AA3529M4Yu9cK4xmUqQzSj3ySelwBcx9lcJBHj66YLnxIm34e4iZs+LfZpiLuUK87gRFvSFc5tI3H6z59VjGSf4yTIcRk0K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfDICusj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfDICusj"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C5D141F000FF;
	Wed,  9 Sep 2026 22:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788993618;
	bh=4wym2Ay+ABh3JkqnlJQRx+Kvb/QLEFiuk5lup2Jk0bg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZfDICusj2b6iCI+ynglqOYENV1qEufTbbJQY0hQJH4UhxcbaAkR/jKV3DBDIdOJOw
	 MSwPjK2gIIrD6iZUjw/Ahb8mECI9+I7rerYdPM2w3XPSN3xZdxp26mOZ2AO9/u7kE+
	 64pU7bmk2//JTH2Bn59fvXcaLKDyAZUAkagogvYCJxtHy1Joc7X+/jdMadqGBWj2ht
	 9ZSEZGVblpwq0t67139zwUcgEYesEGrXjFtvFWH4upPrStNeZdd/DPpU6/oE5/FpLP
	 FvVkZI2hyBqxQ2ODTtSZ5yf//qgUZVASXs5PTGJw8AuTzy6e3cjrcU+0rXV/dmkvI/
	 zsjWzbAc5SN1g==
Date: Thu, 10 Sep 2026 01:40:14 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Jiangshan Yi <yijiangshan@kylinos.cn>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, James.Bottomley@hansenpartnership.com,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	13667453960@163.com, Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: fix off-by-four bounds check in tpm2_get_random()
Message-ID: <aqHgTqQQDQhUFFno@kernel.org>
References: <20260903035837.219284-1-yijiangshan@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903035837.219284-1-yijiangshan@kylinos.cn>

On Thu, Sep 03, 2026 at 11:58:37AM +0800, Jiangshan Yi wrote:
> When the response carries the TPM2_ST_SESSIONS tag, tpm2_get_random()
> skips the 4-byte parameter size field before locating the random data,
> but the bounds check still validates the response length against
> TPM_HEADER_SIZE.  A truncated response can pass the check and make
> memcpy() read up to 4 bytes past the response end, so stale buffer
> contents end up in the caller's random bytes.
> 
> Fix this by checking the response length against 'offset', which
> already includes the skipped parameter size field.
> 
> Fixes: 1b6d7f9eb150 ("tpm: add session encryption protection to tpm2_get_random()")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260902074839.417419-1-yijiangshan%40kylinos.cn
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  drivers/char/tpm/tpm2-cmd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 48cec39995fe..d74df7808a3f 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -305,7 +305,7 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
>  		out = (struct tpm2_get_random_out *)&buf->data[offset];
>  		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
>  		if (tpm_buf_length(buf) <
> -		    TPM_HEADER_SIZE +
> +		    offset +
>  		    offsetof(struct tpm2_get_random_out, buffer) +
>  		    recd) {
>  			tpm2_end_auth_session(chip);
> -- 
> 2.25.1
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
