Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794153295;
	b=PfLbBQmyG4ok43NMcX/bHAQSmmwnLydhb5xaxzTK8JOkTqM6d5ASMWqbCQRN+U95gYOH
	 aN3x40CtQWy55wT85wixD05srhBIlU5e/dwM88RGt3Ec3Ii2+Wn+FOOSNZnyZl6s2IY9D
	 15kIfps5Q++DsAE9nmcB3oCv1xqUi7shSei1AfJy4yn6EgKwsxwPdjVv+Z7HiaZZTFXEo
	 jHYSL6kAqsetc3moWZD9Esv0oKv0cHkWSSo7SEFdf/MilvwD6lDlT99Up1qVYfqUHJXmj
	 YAmyGl8DprbeM49OgtMV5kJaUPFpxNZmx5Uw7Y+iyVFufzgLMCQ3FJUepWNhf1F55sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794153295;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=V3XAaHBmtxLnh/VBMvEmT+KKmFAHRQNRMdHOCFz0cHI=;
	b=S+MgVtbvx0JoA4gQH4eiHDyPPiu3L/d3BWLaYgvU4rxWTO8qrMK96CKx0a97fhxjDm+T
	 8EH4ygnejWFIGPPSBDsusgCm48dTOMFP6XN4xJzsAcvnVw9rRTalb4XrubNx/Txr8n8Ze
	 Fr/GZUvKyGY5mr6z+sprSYi0fCRJu2/bzXWbHXkvO3fK7M5aW8quwUsZUkZaA4FqH8D7E
	 D43OCNj4hr4jkAEn2kNOXZbXlQvbXYmML46wO5VfCaimDW0ZL2wQT8P/eDNL4pnpl40IC
	 FAetyXMLKyXGCLNtHsKZauQxXXiQZoIwVJnqzt+G10G2ZbfmCnNGYI+ka1mGmEKewFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+gTriNN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4A417606A31C;
	Sun,  8 Nov 2026 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W+gTriNN
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 55DBD1F0089F;
	Sun,  8 Nov 2026 15:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794153294;
	bh=V3XAaHBmtxLnh/VBMvEmT+KKmFAHRQNRMdHOCFz0cHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W+gTriNN9lQv76klCDWwppAiRDVHBKQjJx0dt7M1w/Ey/2z899EHj2gxMICT2AYuE
	 iGNUUZsp7wg2NASbHoNytSCaqwXtxKIm9bg6egIjgy1/W4/m8P9c0PeFrI2ghvzdXV
	 SXOb80gRX63q1NaNDtpmapxz3ABGB81GQSJ00giQuuwW10vyIUVfOPjSolS8iwV47X
	 NFZD9Tok7O4G8We+wZA4PKpmdqtJiTWHwpEZ/09CVfTAfVCTxakQE4wDYuXrkkugAo
	 0C7E7KxT/0lxV32XX31w9tSEGtvs6z7zQf+MCx+XIMwy38y9VqCV0K3M6f+MUlKYvi
	 KCqOmJpKwqK2w==
Date: Sun, 8 Nov 2026 17:54:51 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: hyunjungg <hj351016@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] tpm: flush timeout work outside buffer_mutex to avoid
 deadlock
Message-ID: <avCbS5nFYSEet_A_@kernel.org>
References: <20261108123247.426040-1-hj351016@gmail.com>
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
In-Reply-To: <20261108123247.426040-1-hj351016@gmail.com>

On Sun, Nov 08, 2026 at 09:32:46PM +0900, hyunjungg wrote:
> From: Hyunjung Ko <hj351016@gmail.com>
> 
> tpm_common_read() flushes priv->timeout_work while holding
> priv->buffer_mutex:
> 
> 	mutex_lock(&priv->buffer_mutex);
> 	...
> 	if (!priv->response_length) {
> 		*off = 0;
> 		timer_delete_sync(&priv->user_read_timer);
> 		flush_work(&priv->timeout_work);
> 	}
> 	mutex_unlock(&priv->buffer_mutex);
> 
> The flushed handler, tpm_timeout_work(), takes the same buffer_mutex at
> its start. user_reader_timeout() schedules timeout_work from the
> user_read_timer, which is armed while a response is pending. If that
> timer fires and timeout_work starts running while a reader holds
> buffer_mutex, flush_work() waits for timeout_work to finish while the
> reader holds the mutex, and timeout_work blocks acquiring that same
> mutex -> deadlock. lockdep would report this as a circular locking
> dependency between buffer_mutex and the work.
> 
> Before commit 9488585b21be ("tpm: add support for partial reads") the
> timer deletion and the work flush ran before buffer_mutex was taken;
> that commit moved them into the mutex-held section, introducing the
> flush-under-lock cycle.
> 
> Flush timeout_work after dropping buffer_mutex. The timer is still
> deleted under the lock, so no new timeout work can be queued once the
> mutex is released, and the flush no longer runs under the lock the work
> needs.

I 100% understand the bug fix but why we need to write an article
to describe a trivial bug? It's long enough that I lost the plot
before finishing it up. Have you *ever* tried to read it yourself?

> 
> Found by static analysis (a checker for cancel/flush-sync of a work
> performed under a lock that the work's handler also takes) and confirmed
> by code inspection. Not reproduced at runtime: it requires the
> deprecated user-space read timeout to fire while a read holds
> buffer_mutex, so the deadlock is established by inspection rather than an
> observed lockdep splat.

I think the last paragraph should be deleted.

> 
> Fixes: 9488585b21be ("tpm: add support for partial reads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
> v2: Rename the local bool flush_timeout -> flush, per Jarkko's review.
>     No functional change.
>  drivers/char/tpm/tpm-dev-common.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index 6569212..97c1b7c 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -132,6 +132,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
>  {
>  	struct file_priv *priv = file->private_data;
>  	ssize_t ret_size = 0;
> +	bool flush = false;
>  	int rc;
>  
>  	if (!size)
> @@ -164,9 +165,19 @@ out:
>  	if (!priv->response_length) {
>  		*off = 0;
>  		timer_delete_sync(&priv->user_read_timer);
> -		flush_work(&priv->timeout_work);
> +		flush = true;
>  	}
>  	mutex_unlock(&priv->buffer_mutex);
> +
> +	/*
> +	 * tpm_timeout_work() acquires buffer_mutex, so flushing it while that
> +	 * mutex is held deadlocks if the timeout work is already running and
> +	 * waiting for the lock. Flush after dropping the mutex; the timer is
> +	 * deleted above under the lock, so no new timeout work can be queued.
> +	 */

I missed this one but I don't think we need this remark for a trivial
bug fix. It's 50% of the whole patch. Please, delete it.


> +	if (flush)
> +		flush_work(&priv->timeout_work);
> +
>  	return ret_size;
>  }
>  
> -- 
> 2.43.0
> 

The comment had the pretty much had the relevant information. Please
next time don't submit RAW LLM output and make sure that you are able
to at least the commit message. This is horrible underperforming in 
my books.

Br, Jarkko
