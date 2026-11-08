Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140994;
	b=WOPFyTWhmccUHVxcXI8OKmNVl/enQ43e9tcZ2/YaBxzzVsGDJq+WINtaRuwiWGNupcla
	 UC1KqqaLB9DchL/fCGfps9Dqxl9Lh3Zc822ghwheWVrr5EuvTBWlrCOml8peQHyyObdsS
	 0KRNNAWSuqU5AN+JW0bG6ZNr5rYztgSmsGmpzJrwIx3DnX+LVVF8e+VeNtOXhhgs5CcjC
	 spESj99MCUCmtXXcazETfBUqUS4JUnH079TGzuTL6SsxlVOjDXQvuIiJFmnFwnfdk2mP3
	 HDW3fU+WnhFUWMrTY3xQRKBXsexm2HNBeKI4m46YRBvWuQZMBng1QsQN8C93Th08HGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140994;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=nzguZBxFGT7Ld1CuDLFoowXYThcPeVDRDZD/xldyIQE=;
	b=aD3sUJOEZf2ulnOeY2pmxwr+8JOwAGA7SFsIrmJLfnQFgH6nt99+5LG4TE1WzI3aJdSO
	 upW1hVkFSxmGLTVqeGTy/7z595TpCu8SG8YnN4Uy16KHXdgPTDHbUKARiDCliLkxT5sKx
	 qJxDviJLN+gs9CN/Ljw+Kwxj+cGL9VJDX4s80iekGxu0GvxQXKPrqiCW00Ny9dyA2WDpY
	 zCuvLXRIECTIB7RYfXBVW4hRBkJv9Fs/6QRTaGu91RSIB2h0r6g4kQUgPEQ3Kev5wfOSD
	 k4txtYn4BIf7kSMFoaK3RdN76hx/Ise13vQ9dvHXycITt3F7opevy6fT94oE81F/VbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MeJrhITh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 28A34606A336;
	Sun,  8 Nov 2026 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MeJrhITh
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 44E091F008A2;
	Sun,  8 Nov 2026 12:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794140993;
	bh=nzguZBxFGT7Ld1CuDLFoowXYThcPeVDRDZD/xldyIQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MeJrhIThxuIbY67XQzxLWCSK5/tU6TWBHazm1Iluy4JV40EQY26h9fNxaJ4WdeCt4
	 wg96VZraTjbWDU+OmDr94GOzHHsD4oACB89teiJufc4UpoOs4xEbG9wF8azIo9SOqo
	 3WSqskT5SpmPovDxGv226fpMAh70Lu6uaBe7noHYMGiRJaq7HC6EsgJYHcgSSv6G/w
	 /jMQu5aM6FC7f5v53TiOYEAfloVWtNJ0FYrGO96RIZqa3w4z+R6KySrc734UuuMvzH
	 i343kMyDKnPljAf/QYBvbSk+r6eW3CHHRDC2uo4zrBPVSGyeg+rcs0OXF7prd6NfL1
	 VikjRMVNBLmFw==
Date: Sun, 8 Nov 2026 14:29:50 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: hyunjungg <hj351016@gmail.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Tadeusz Struk <tadeusz.struk@intel.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: flush timeout work outside buffer_mutex to avoid
 deadlock
Message-ID: <avBrPjvw_5EH_W5r@kernel.org>
References: <20261108075848.257145-1-hj351016@gmail.com>
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
In-Reply-To: <20261108075848.257145-1-hj351016@gmail.com>

On Sun, Nov 08, 2026 at 04:58:48PM +0900, hyunjungg wrote:
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
> 
> Found by static analysis (a checker for cancel/flush-sync of a work
> performed under a lock that the work's handler also takes) and confirmed
> by code inspection. Not reproduced at runtime: it requires the
> deprecated user-space read timeout to fire while a read holds
> buffer_mutex, so the deadlock is established by inspection rather than an
> observed lockdep splat.
> 
> Fixes: 9488585b21be ("tpm: add support for partial reads")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
>  drivers/char/tpm/tpm-dev-common.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-dev-common.c b/drivers/char/tpm/tpm-dev-common.c
> index 6569212..f9b18ef 100644
> --- a/drivers/char/tpm/tpm-dev-common.c
> +++ b/drivers/char/tpm/tpm-dev-common.c
> @@ -132,6 +132,7 @@ ssize_t tpm_common_read(struct file *file, char __user *buf,
>  {
>  	struct file_priv *priv = file->private_data;
>  	ssize_t ret_size = 0;
> +	bool flush_timeout = false;

Rename this as flush.

>  	int rc;
>  
>  	if (!size)
> @@ -164,9 +165,19 @@ out:
>  	if (!priv->response_length) {
>  		*off = 0;
>  		timer_delete_sync(&priv->user_read_timer);
> -		flush_work(&priv->timeout_work);
> +		flush_timeout = true;
>  	}
>  	mutex_unlock(&priv->buffer_mutex);
> +
> +	/*
> +	 * tpm_timeout_work() acquires buffer_mutex, so flushing it while that
> +	 * mutex is held deadlocks if the timeout work is already running and
> +	 * waiting for the lock. Flush after dropping the mutex; the timer is
> +	 * deleted above under the lock, so no new timeout work can be queued.
> +	 */
> +	if (flush_timeout)
> +		flush_work(&priv->timeout_work);
> +
>  	return ret_size;
>  }
>  
> -- 
> 2.43.0
> 

Br, Jarkko
