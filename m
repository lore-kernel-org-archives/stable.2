Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794913165;
	b=4nJs583MZrMpi+6vHADto+cJNRXfW71XPBt7rVHSufLLHsjpSVFfjmgUvN9DcmFFKhL7
	 oqmv9XOjMwW41ObiP2DHcM2X3cHack9NfoxhyPnAdo9+Gr9JUdQwNYN9AoUw7xcDr4HV2
	 2mzBaveWhPcn0WMLYLfNYH3sgTt1M0byoK1tvk+2oEiJgO3HA2Iag2tZJ9xDv66Bw2NRf
	 efsL2UIpYbaSNgOJ1kGPKiJQhlFViOepNYdFwf5AkijVHTxJ14LnHwhb34hFHrTGtx0mk
	 EoA+O+CC4azA4oIDVcpzRAaIbjhOXOJ6Hkr2b8krGBsOWZzT403UL450u4Po6IkOaNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794913165;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8eW6/+VtufNXs6nUVXwIqQ9eydkypxI9gUCA9iysrS0=;
	b=E7OX1514SEfrlN+9rXi0kKJiav3sFQW95Eb5kVuppGeLqN8KRxuz2R09M3ltqHevDsTf
	 OxPpBjVzsYyhtlonlv0ALKAtal2aVDm7RFop1H4omQreXnHpAa0AMdKt1JB41S+kX0OfG
	 mZtI+gTGCcyRj/1O2W8Rr2ApVxK+eGiGdc4CK34jcUWzQ8tT7V2kbIQ05Bo2ArWaaadIl
	 oVl9jGsjHqYHYd7GYSVMgj+ijJxMhfjHn8TEJ2xf5hBqYQGbx+IElkxIOQNa1LTmbxwck
	 M/RBueMwI8jFSzelNYv36ee4TbIlPZY9PtSHMNMKNJo1W68ohbzQTlvpkujvfN8+fKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ajlkMD/k";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 779BB606A323;
	Tue, 17 Nov 2026 10:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ajlkMD/k
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8D7021F000CC;
	Tue, 17 Nov 2026 10:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794913165;
	bh=8eW6/+VtufNXs6nUVXwIqQ9eydkypxI9gUCA9iysrS0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ajlkMD/krL+lSXAegaa8+3mjbypBV2BigEGUHlJ+srJYfsgtSK9F0itQ6RAl+NV8/
	 EppBum2pVYRHAY6vqVila4McXYDCWzTJaHVA0pqJLaNMyOBf6WmoWYtNP64soRYbS0
	 gCERj1LJsWT8Pml+zI7RmDlz7mOD113Md95RH5w5gBt30kkkMkqDSZEvFNceSVVav+
	 nVDVvjzL6jHPeW0uyE+/wp6wbEBsAfMcgv9Mc8GFGMaDW7ZcPq1EFKNBpIYpLfa4ww
	 hxeKPQGtJMBVKEyKHHjeqD2H7folUTauZJksxEPlkzQcN/P8RTVZ7uqjAoGlqen9TE
	 2vJtDdQPzxoRA==
Date: Tue, 17 Nov 2026 12:59:21 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Rustam Mustafin <rmustafin@cloudlinux.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Jaewon Yang <yong010301@gmail.com>,
	Tadeusz Struk <tadeusz.struk@intel.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: track the response read position internally, not
 via the file offset
Message-ID: <avwzid1Ovl4ACkaQ@kernel.org>
References: <alvD5nOP15O5B8Ai@kernel.org>
 <20261117104838.2650999-1-rmustafin@cloudlinux.com>
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
In-Reply-To: <20261117104838.2650999-1-rmustafin@cloudlinux.com>


Please remove that claude'ism from short summary (, not.. uaargh).


On Tue, Nov 17, 2026 at 05:48:38PM +0700, Rustam Mustafin wrote:
> Commit f20d61c22bca ("tpm: Make the TPM character devices non-seekable")

Duplicate information to fixes tag.

> made pread() fail with -ESPIPE, but tpm_common_read() still indexes
> data_buffer with *off, and io_uring can still set it: IORING_OP_READ

io_uring is a data structure, not an active actor and IORING_OP_READ
is a constant.

> copies sqe->off into ki_pos without checking FMODE_PREAD, and
> loop_rw_iter() passes it to ->read(). With sqe->off = 0x1400 the read
> copies heap memory past data_buffer to user space and then zeroes it:
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
> Keep the read position in file_priv, protected by buffer_mutex, and

Why open code variable names in English?

> ignore *off. This also closes a race where read() samples f_pos before
> taking buffer_mutex and a concurrent write() replaces the response in
> between.
> 
> Fixes: 9488585b21be ("tpm: add support for partial reads")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/CAHk-=wi8aXM9=Y8othMb1oxTv-PDw4isj-FPbXu0MXsm_EPE1g@mail.gmail.com/
> Signed-off-by: Rustam Mustafin <rmustafin@cloudlinux.com>
> ---
> - A C reproducer for the io_uring path is available on request.
> - nonseekable_open() only closes the VFS doors (lseek(), pread()); io_uring
>   bypasses both, so with this patch an IORING_OP_READ that passes an
>   explicit sqe->off ignores the offset and reads sequentially.

Why weren't you able to realize this in the kselftest?

> 
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

I did search read_pos but it had zero hits in the commit message.


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
