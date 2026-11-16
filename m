Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=93.93.131.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822240;
	b=H7BFh6Cfwy983GpG82hdgjlw6lh1prwSM47briB6ctNCnwKezIrFgmVVLDODEtM614CC
	 dqFhvIZRyqb9n4uzAR43E4xSycyamk26s66j67R9OOaQ/SNjDR2gog4qRDkZdPaYmk4PI
	 WXotgj67G2A+tcgchy8B3lXpCHyJcEEANGHt0Zw3MNjkmPFIV3JlHLF56PUbyGIFN1OTJ
	 kjP+zkLkVc7u637N0JpHOocB8N7AkOffdqkXYmwHq8SMENUfs7JnfqRJ+43cZzD4Jpf6V
	 veSm8wmqOsV76+xwPp/oyho8yqZ3dcC0YeHomr+OGgkuPWimqkvrg5IBRDEE8lnYAeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822240;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=RSWKnESEVnr4VXKVjRJhnaoqTz4cwHJfNjyq1NrtClw=;
	b=Db5iVERh2ZMKh3mjL4otCwJ1qJDZNou7cot9nANucnJYmCZXqk9ib3kzTfWPTiCQ9+hy
	 7krk2VD6KzCzrS+H30nbFDqwuPsD+eAHwr2U9xzW89fZDY3A+WBF55kTCh5RDyF38y9Xb
	 TGTggR7toTVjNTejdvDI5sva6CuAVqtYqPFobDme4PVTyOk46NX8kkznWo1O9CtGbqJev
	 TlH9Y3+vP5gmtxpHRlfpPToa1bzLiCFQYs6NAeE3505wh3iHV510MuXFxHd26Ma8055ku
	 FFMIKOm1sU8hBWoHACAkrGZKWJJm6CEou/pR5RVUgnu7DEeAwg+GI4kk7wG4ylFvP4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=earth.li;
	spf=pass smtp.mailfrom=earth.li;
	dkim=pass header.d=earth.li header.i=@earth.li header.a=rsa-sha256 header.s=the header.b=M1cq45IL;
	arc=none smtp.remote-ip=93.93.131.124
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79786606A323;
	Mon, 16 Nov 2026 09:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79786606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=earth.li header.i=@earth.li header.a=rsa-sha256 header.s=the header.b=M1cq45IL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=RSWKnESEVnr4VXKVjRJhnaoqTz4cwHJfNjyq1NrtClw=; b=M1cq45IL+n51Vb8QGu8nCZ0eKU
	XeqhXFMpC67FbM/nNk+CTZCBl1E6UgzMVojKFjJJFxaRwzvt7wBBp5BN9E21+c2bsbVfmU7Q4KovT
	xduNpdow4PS/A3zMY7jl/WhaNPoUjep6ow8e8nglFmnJ3pq5XiLCaWpk0amcwElEu1WW3wX+f6pMo
	JIRE1QbUgRU8oOEDcPjfI4TZiRhpUYYi5O3QN38DxXUULeIb0tijJlzwwnM7oDlEIellcOdBng+4x
	/2xFljQUl6zKR1C+30nYL+4pgChhQPvvxRn6+eUNCJ3JpJ2ApPwaH1ozu3uDhe8iUmn9qgoAcwK3E
	+kKkZ7OQ==;
Received: from noodles by the.earth.li with local (Exim 4.98.2)
	(envelope-from <noodles@earth.li>)
	id 1xStFU-00000008R0V-1SMs;
	Mon, 16 Nov 2026 09:43:40 +0000
Date: Mon, 16 Nov 2026 09:43:40 +0000
From: Jonathan McDowell <noodles@earth.li>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	Alec Brown <alec.r.brown@oracle.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	James Morris <jmorris@namei.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/5] tpm2-sessions: Drop TPM2_NAME_SIZE
Message-ID: <avrQTPj-iwlrUvcp@earth.li>
References: <20261116005105.1573016-1-jarkko@kernel.org>
 <20261116005105.1573016-2-jarkko@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116005105.1573016-2-jarkko@kernel.org>

On Mon, Nov 16, 2026 at 02:51:00AM +0200, Jarkko Sakkinen wrote:
> TPM2_NAME_SIZE was left to include/linux/tpm.h when the base definitions
> were consolidated. Switch struct tpm2_auth to TPM2_MAX_NAME_SIZE and
> convert TPM2_NAME_SIZE users to TPM2_NULL_NAME_SIZE, removing the
> redundant TPM2_NAME_SIZE definition.
> 
> Cc: stable@vger.kernel.org # v7.3+
> Fixes: 88c5a62c3af7 ("tpm: Move TPM common base definitions to the command header")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Jonathan McDowell <noodles@meta.com>

> ---
>  drivers/char/tpm/tpm-sysfs.c     | 2 +-
>  drivers/char/tpm/tpm2-sessions.c | 2 +-
>  include/linux/tpm.h              | 8 +-------
>  3 files changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-sysfs.c b/drivers/char/tpm/tpm-sysfs.c
> index d915307ae833..0f726cf65189 100644
> --- a/drivers/char/tpm/tpm-sysfs.c
> +++ b/drivers/char/tpm/tpm-sysfs.c
> @@ -318,7 +318,7 @@ static ssize_t null_name_show(struct device *dev, struct device_attribute *attr,
>  			      char *buf)
>  {
>  	struct tpm_chip *chip = to_tpm_chip(dev);
> -	int size = TPM2_NAME_SIZE;
> +	int size = TPM2_NULL_NAME_SIZE;
>  
>  	bin2hex(buf, chip->null_key_name, size);
>  	size *= 2;
> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
> index 9608e545602c..94c11135beb3 100644
> --- a/drivers/char/tpm/tpm2-sessions.c
> +++ b/drivers/char/tpm/tpm2-sessions.c
> @@ -137,7 +137,7 @@ struct tpm2_auth {
>  	 * we must compute and remember
>  	 */
>  	u32 name_h[AUTH_MAX_NAMES];
> -	u8 name[AUTH_MAX_NAMES][2 + SHA512_DIGEST_SIZE];
> +	u8 name[AUTH_MAX_NAMES][TPM2_MAX_NAME_SIZE];
>  };
>  
>  #ifdef CONFIG_TCG_TPM2_HMAC
> diff --git a/include/linux/tpm.h b/include/linux/tpm.h
> index 0db277af45c3..84c8fe226235 100644
> --- a/include/linux/tpm.h
> +++ b/include/linux/tpm.h
> @@ -94,12 +94,6 @@ struct tpm_chip_seqops {
>  /* Fixed define for the curve we use which is NIST_P256 */
>  #define EC_PT_SZ	32
>  
> -/*
> - * fixed define for the size of a name.  This is actually HASHALG size
> - * plus 2, so 32 for SHA256
> - */
> -#define TPM2_NAME_SIZE	34
> -
>  /*
>   * The maximum size for an object context
>   */
> @@ -166,7 +160,7 @@ struct tpm_chip {
>  	/* saved context for NULL seed */
>  	u8 null_key_context[TPM2_MAX_CONTEXT_SIZE];
>  	 /* name of NULL seed */
> -	u8 null_key_name[TPM2_NAME_SIZE];
> +	u8 null_key_name[TPM2_NULL_NAME_SIZE];
>  	u8 null_ec_key_x[EC_PT_SZ];
>  	u8 null_ec_key_y[EC_PT_SZ];
>  	struct tpm2_auth *auth;
> -- 
> 2.47.3
> 

J.

-- 
... I am afraid of the dark.
