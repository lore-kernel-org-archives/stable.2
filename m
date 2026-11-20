Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795177639;
	b=05LG3+YAkP9dbPRbFJ1RAV/1gUieXUIR6OsKDoCmMmfgiH0Oh6C42CW1O3+Jq4O76HNR
	 taqL4bcPLUpaQsSrRVYQLWSxJcBoAWx+Bp3FOlN/pVBpSI20hdw9Xzw0isr7jB5V5rDjz
	 plvM7fLlxlXviTkPJNH2IBlKYEDcFU73hol3pMSJd6luTudTLpTtv9MkqyI9MrqmudFh6
	 FnXLjZ4J3prydk5N+SOGm4cqhMNiWDjIHstzO/B6KEB7UR0iCxbtPVrhqEHxCmDgMNJKd
	 WbTjgc8McvWD0wJyBXl01hEUnr1Z1GIiYcb/xvZe1S5SUDzyjrC6UUgzPWfIsTo7Iaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795177639;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=R5Q/anIS5kma9/R7yRs1Zjye56minOa3GoeRtxvDz3k=;
	b=CJUJZ3bbT7/+93Q8xQmzliNAjJJeH9ei8b8+olVl4mSaxvRpTIZIHq79kYX6HBp/kByK
	 E+/gCQUhltZGm4xrL3qZ1NU3TzZLwukdpsiUOwQMNXvh2RfQ3dSlhT2CD3u60qQ1fTU0w
	 qwWhYwMV2aiWGkFq8xOFNEoxxaFoWW/JgGQ2tZutDNPI8J0A9V9H6N416HdZJO3dTlT5S
	 1f1xSa8XXihSv+VTpeVqp9NGWtBK+vP8aFRGWjRCAT7aVC2ndWrMhMgx3RND6eoMiBwS9
	 qWo4Cii5y4GdcWWdgk4FSCDy+hxS8yBwVHlintV29gUcQVWOhLmuoCZzTWq1W8zrGqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLFQM+yw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6EC41606A326;
	Fri, 20 Nov 2026 12:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLFQM+yw
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 861CB1F000CA;
	Fri, 20 Nov 2026 12:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795177639;
	bh=R5Q/anIS5kma9/R7yRs1Zjye56minOa3GoeRtxvDz3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lLFQM+yw6/YBiNzrGx0lqhesKDPvmN+Iz8MNxC+SzdA2pSt58JcVIc32cjI9x/Kb2
	 VBOsu76rVwrbPqrv8FfMXXSxclDvX7XSBE4PDIoUdQE3iSouKnTQ4Hrw4fnoai+6IU
	 vw38fCdqoz7ZM4jDFBbA2lcd/JJpQb1DsPkkqeLmCOxIH9jccR5t3PnOj/SQpUONQx
	 mCUyPHXLZ/vaggAMuYjQDodOgHqtxpew7a5ddDehdgrDW01i4YqGMQkwwo3p07QmQ2
	 LD+hc5KE3XTJtldRV/LUGINykBVTs9NU/H0ZkQiNNB9YhnEZrX3S6WO7qA0Qe8S4u4
	 1FhdXMQg+jA6w==
Date: Fri, 20 Nov 2026 14:27:15 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Shuah Khan <shuah@kernel.org>, Jaewon Yang <yong010301@gmail.com>,
	linux-integrity@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tpm: Track the response read position internally
Message-ID: <awA8o4oIq81a7J1z@kernel.org>
References: <20261120121614.978396-1-rmustafin@cloudlinux.com>
 <20261120121614.978396-2-rmustafin@cloudlinux.com>
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
In-Reply-To: <20261120121614.978396-2-rmustafin@cloudlinux.com>

On Fri, Nov 20, 2026 at 07:16:13PM +0700, Rustam Mustafin wrote:
> tpm_common_read() indexes data_buffer with the caller supplied *off.
> A read issued through io_uring reaches the driver with that offset:
> loop_rw_iter() passes &ki_pos to ->read(). This allows out-of-bounds
> reads and zeroing of kernel memory:
> 
>   BUG: KASAN: slab-out-of-bounds in _copy_to_user+0x4b/0x70
>   Read of size 16 by task iou-wrk-148/149
>   Call Trace:
>    _copy_to_user+0x4b/0x70
>    tpm_common_read+0x16e/0x2c0
>    loop_rw_iter+0x235/0x5a0
>    __io_read+0xc6e/0x11a0
>    io_read+0x8a/0x180
> 
> A plain read() racing a write() reaches the same access: read()
> samples f_pos before taking buffer_mutex, so it can consume a new
> response from the offset left by the previous one:
> 
>   BUG: KASAN: slab-out-of-bounds in _copy_to_user+0x4b/0x70
>   Read of size 75 by task trigger/151
>   Call Trace:
>    _copy_to_user+0x4b/0x70
>    tpm_common_read+0x16e/0x2c0
>    vfs_read+0x189/0xc00
>    ksys_read+0xf9/0x1d0
> 
> Replace *off with a read_pos member of struct file_priv. It is only
> accessed under buffer_mutex, so the offset passed by the caller no
> longer matters.
> 
> Fixes: 9488585b21be ("tpm: add support for partial reads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Rustam Mustafin <rmustafin@cloudlinux.com>
> ---

So... why does not this block uring? You are implementing a feature
as a bug fix, or so that it appears.

>  drivers/char/tpm/tpm-dev-common.c | 11 ++++++-----
>  drivers/char/tpm/tpm-dev.h        |  1 +
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index ee91f456f975..553fc6aca94d 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -107,6 +107,7 @@ static void tpm_timeout_work(struct work_struct *work)
>  	mutex_lock(&priv->buffer_mutex);
>  	priv->response_read = true;
>  	priv->response_length = 0;
> +	priv->read_pos = 0;
>  	memset(priv->data_buffer, 0, sizeof(priv->data_buffer));
>  	mutex_unlock(&priv->buffer_mutex);
>  	wake_up_interruptible(&priv->async_wait);
> @@ -149,21 +150,21 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
>  			goto out;
>  		}
>  
> -		rc = copy_to_user(buf, priv->data_buffer + *off, ret_size);
> +		rc = copy_to_user(buf, priv->data_buffer + priv->read_pos, ret_size);
>  		if (rc) {
>  			memset(priv->data_buffer, 0, TPM_BUFSIZE);
>  			priv->response_length = 0;
>  			ret_size = -EFAULT;
>  		} else {
> -			memset(priv->data_buffer + *off, 0, ret_size);
> +			memset(priv->data_buffer + priv->read_pos, 0, ret_size);
>  			priv->response_length -= ret_size;
> -			*off += ret_size;
> +			priv->read_pos += ret_size;
>  		}
>  	}
>  
>  out:
>  	if (!priv->response_length) {
> -		*off = 0;
> +		priv->read_pos = 0;
>  		timer_delete_sync(&priv->user_read_timer);
>  		flush = true;
>  	}
> @@ -214,7 +215,7 @@ ssize_t tpm_common_write(struct file *file, const char __user *buf,
>  
>  	priv->response_length = 0;
>  	priv->response_read = false;
> -	*off = 0;
> +	priv->read_pos = 0;
>  
>  	/*
>  	 * If in nonblocking mode schedule an async job to send
> diff --git a/drivers/char/tpm/tpm-dev.h b/drivers/char/tpm/tpm-dev.h
> index f3742bcc73e3..34efb1ffa491 100644
> --- a/drivers/char/tpm/tpm-dev.h
> +++ b/drivers/char/tpm/tpm-dev.h
> @@ -15,6 +15,7 @@ struct file_priv {
>  	struct work_struct async_work;
>  	wait_queue_head_t async_wait;
>  	ssize_t response_length;
> +	size_t read_pos;
>  	bool response_read;
>  	bool command_enqueued;
>  
> -- 
> 2.52.0
> 

Br, Jarkko
