Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794159121;
	b=jawBGzynNtYGLvcITswhUHjakVVKaZeQJVzbVIjB1M3gqlBGtu86GV2DGErgWZS4SFGR
	 CV9zOKIOsSBlrZ8wY4w2wou2oaChCBcLdtqemF5piRjIKRU53bjdkNToi2GHy6e59vldD
	 UgGQE4DD9DB8CQvoGklX+Aj6FzYAoDQqdCPy9ZT/NhwE8DIwjCH0/INbY2rdZ4kYnlHWD
	 UNId60sZ6qXfKgkRfrvTncknsHU9j62BZppQmuzEypxgc+Q5Riwch8IwZyEsTNSP3LhL5
	 nwF3vLQJBU522OKv9m6NrZ8vkRQ1Id2Zuu/9NusdNuHeoBA+vqv2ZkL9tul2t59sArA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794159121;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=MLdZwDJc+53tcrCchy7nxgEPs0vFSBNFdY5MSxkQrhk=;
	b=KOYZuJ+N7jc8+gE9zwPDUhjmiZbx/sebyqDZdbDhdaBKvYaD3VOlgwEIo1yVZuKu9ssJ
	 Nsx0y4kJOL+H9Hwx3tz+er586tRA8L0zIbbV3FST6o/+14431ngaE01Pbhh1LkP5BBSOT
	 VxCArYJJX60AVyuOuBL+7UqWALo8bDpGKYb3syOx/i/ISRsQC9M1WflxhK0fL3i8yikkh
	 vNDixAgJaWRSZScZ/5KqVexxMhf+wenbLwwkeWkhBQ99B06fb0IOpKASRW4MqRTqKOz6a
	 a7hc2aML6+QB/eSfyH0MUX6qiwih5/1VR0uOD2NGYkq9srOm2U3QMNxBJpembNrBxAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VNxYyzpv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 07E32606A31C;
	Sun,  8 Nov 2026 17:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VNxYyzpv
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 145B11F0089F;
	Sun,  8 Nov 2026 17:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794159120;
	bh=MLdZwDJc+53tcrCchy7nxgEPs0vFSBNFdY5MSxkQrhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VNxYyzpvNOxhGGinaHuCNku4AxbJ5tK3hnk+TaWjc4QAiPEzSIGOAparcTl8eRtVQ
	 sEmXVn18Zj5YjnHnD2QDOjQwBwVqR6K3hvGe7p5hhVrzYeg6hGv2O3B6GKS4Wgu3lv
	 U2pyygBYMSnJr8QcKa2KZct2Wyqt9tqW94vANElgG5y5s5we4mGFVFUgvICyVnHawz
	 Ln3pIGrbx9qyKY41doR449SZpDwwGGTHHvuOW/0nF8ejoYEXpn2Yvk8+tlfg2nDLV5
	 +JCY7JW4M4AXSN6usDBZTtclx4lwuHD5Aw+B5SS02CAHaAd3wdUBAkaFQ1jxEGwgxy
	 wtnclmfdQEFLg==
Date: Sun, 8 Nov 2026 19:31:56 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: hyunjungg <hj351016@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] tpm: flush timeout work outside buffer_mutex to avoid
 deadlock
Message-ID: <avCyDN5nbQCqPgTY@kernel.org>
References: <20261108165812.676876-1-hj351016@gmail.com>
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
In-Reply-To: <20261108165812.676876-1-hj351016@gmail.com>

On Mon, Nov 09, 2026 at 01:58:12AM +0900, hyunjungg wrote:
> From: Hyunjung Ko <hj351016@gmail.com>
> 
> tpm_common_read() calls flush_work(&priv->timeout_work) under
> priv->buffer_mutex, but tpm_timeout_work() also takes buffer_mutex, so a
> running timeout work deadlocks the flush. Flush after unlocking; the timer
> is deleted under the lock, so no new work can be queued.
> 
> Fixes: 9488585b21be ("tpm: add support for partial reads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
> v3: Trim the commit message to the essentials per Jarkko's review.
>     No functional change (same as v2).
>  drivers/char/tpm/tpm-dev-common.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index 6569212..ee91f45 100644
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
> @@ -164,9 +165,18 @@ out:
>  	if (!priv->response_length) {
>  		*off = 0;
>  		timer_delete_sync(&priv->user_read_timer);
> -		flush_work(&priv->timeout_work);
> +		flush = true;
>  	}
>  	mutex_unlock(&priv->buffer_mutex);
> +
> +	/*
> +	 * tpm_timeout_work() takes buffer_mutex, so flush it after dropping
> +	 * the mutex to avoid a deadlock; the timer is deleted above, so no new
> +	 * timeout work can be queued once the mutex is released.
> +	 */
> +	if (flush)
> +		flush_work(&priv->timeout_work);
> +
>  	return ret_size;
>  }
>  
> -- 
> 2.43.0
> 

Ok, let's apply this, thank you.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
