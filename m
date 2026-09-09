Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE8556B8D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957299; cv=none; b=Bwk55DHgMmVgpGzzWRsw/HrlInoRTFyOH65iqoqZsgZONmF4Zc1sAnBigfVy1a8EHt9IQUsjPHyvzwbrQn9wVYi6RsOp3vykiLzKYQFOS/9ZoK/3aTK8OfH8KRLQtl1lMo7jEpzWHsTa6vo7Osx6c+Iwo3/d9R8fl7MxzvvfARo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957299; c=relaxed/simple;
	bh=CYcKxxr9KFvE1VaD1QAUqzCBweu1GHBirNlezUrrvTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gERrnDeAwMN0vYJht87l93WpEpnnNF6t9FQCE7Q2OiPeIUq8C7o1AP787uLQYPGndBj4QYP5eavFCwWzvOCokaLT6QXCgUXm3pMbm7FnFgSIhOGIvs3lueFOYQAIGnwST7e4ZngtLKlHSUIUV3AGHDK3zsvhQAkvKYSMCnw073w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=qsmcFcof; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xif8sSzR; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="qsmcFcof";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xif8sSzR"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C7F021400082;
	Wed,  9 Sep 2026 08:34:56 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 09 Sep 2026 08:34:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788957296; x=1789043696; bh=0Ib7N4b16G
	eFSUnnGq0SLwgpjuEqsYWQvNdkI6vAvao=; b=qsmcFcofYQXimbwbfHBhs7Iz4U
	965dOb8PhbsVWP9Es/tOVhbUD1EHM6Q+Kd961vR9DGu0VDki1162PTaAV0a1F23N
	OlYhVmpO3JJIjjHPTLxX1n+uR5XMSR3S9Vpkyf6BVhEhwfa37TPaWpCfSqZH324r
	PIm/P3tS8k9yTNXOm/NXXl1fYlqmK/a2G+IC1ILdkdLIrWHSvU0qc9x+wxGrIlb6
	48aIQsOh4Zai+jB+h2N1vijw0de/sLfaFhs45KvKoZsPmeeW8qcGgkB/YhN2JbC7
	CQh/hkY32fnRTkAyX1HOM11OhOsibqSMNMdDW1HfnKcgme9NQQqeqKK0YtRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788957296; x=1789043696; bh=0Ib7N4b16GeFSUnnGq0SLwgpjuEqsYWQvNd
	kI6vAvao=; b=Xif8sSzRUr4OmTojZ6WWcvlVQV8O3lsrjrM1mwKj8eJeuPjHrnj
	c9BmC2OJlmv8yisH9RSePN0ZyqV90nyuIqX0QiSZ6Hu1HJdv7Wbf2qA522L6m5ws
	CG56LZwvQjdHStKZ51PUhTwNOa9pRO1F7ppDZhNkq0F15CBHzktM69FVovBTrbyS
	aqKo1ptsrAnYETNUulglxUUOKTbXBujxdHtOIPGvPIIZE504MKin9Yo0WaKrzax9
	oClk9+9lSE/f1LY9IPom+mXeHyKFky1AIwpBGMJQ2ea1A+WwvK6noSLN/kZx+23r
	fG9yGn97PRo4eIRLb/QCkxxEThMybVFIj0Q==
X-ME-Sender: <xms:cFKhamfWNea6t4EJxAAieFMVoKxbRiSAXDwWIrfu9Q23tBirEyxgcQ>
    <xme:cFKhaphDbkDlPcAZ1ADnh75xgn_46NGJzSsbUmW7Q8UlWs9ZKkrYvtn2CI0KYynzu
    7O-eiipNCY387BSGlWikeR3i4eOe7y5OOc9ZHft59Iz7MOeoP0>
X-ME-Received: <xmr:cFKhauwmQwYRtpQR2TdSIpBJ4yGU_BIXkFtiONR1Up0m_ncBMq9YcCwSZczCVIt_qvAbIOCyQKsZUzEPCrZ7bI3KxvlnA_lKKMmIJRKJWQQ>
X-ME-Proxy-Cause: dmFkZTEHNjiKP9GRJhpnVMIS/twZiuzLN/rCwucpcAfSY3EwQ9JVVgEHO+voUfnH21k7Uz
    TW6A9PsTjb85AZ1wrV2H7GfRDiPU2ZzHgOuyBnmWUflLMAuZ597VNraWfrx0eRM5K2o7MM
    P8MbpFboH6219BcjtioouQQPz4Fsfk43R20iw0U4z+ILFwoDaybgkcv533zdSSDIaRolAx
    NTas7EZgDz6onGGPcNgWyzzC9B9sF5PHkR0qqztpbMGaQtsa1ZohyMMaaopM0ITqYEFxWD
    qNlW4qDFAG8Y61ch5cAvbimiNMhwmCZOHF3fkMz7VL/A6OTTb6lNImmthFjjDSS4ruUsfo
    P6AOzLiqW/LQTy1VpIe1a/wAzJ3Em4iyXhbSF8snllfi1vQiY0Q+GBuagq+M3LhEArCckg
    glPWHyUTp3v3YjkR/qv98osZjdGQhO8wNyXadVC2c5wmRsidh/WsaUKuGiQePj6BIyk3c6
    sO/mqFh97kMi/yJwQXt2KNGyYHoZn3GI5WZxw5HHfNOzxlR9jWR4SO8n/OjgVYQAd3NkNU
    HTFgN4JqM6tO3YNMx90qbMts4nQ4HIfYQO7JsMC7qDWya3XdSNVvL2e0ABu1XkIcrqqPEJ
    lH8tFWHbmTewzcnz63Qh1BZLZHiLZQiD4TSwh/YmgB86LxrpI0t5NqOBelew
X-ME-Proxy: <xmx:cFKhalO5Txhg15oF_fjNGLGxFxuXTNCqzErzzm4rImOG6kN6pVagFQ>
    <xmx:cFKhavXw_toMV6DGWIoRFEKVWW3vzh2hYO1P_qgkn7739rbnqrD7ag>
    <xmx:cFKhap26suF1Ze2C17VEFefuRme3D6Npqg8b-G0losOp-KU7NjDyjA>
    <xmx:cFKhatpewsa0_Iigr5ujukuQlc5gRQOzK9t11zxGK59fIYKZ4eFudA>
    <xmx:cFKhatBqeDuxC_EysTv5CUXCGjn5HwvIsWcFpTr6smjuxutJgt-H65YU>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 08:34:56 -0400 (EDT)
Date: Wed, 9 Sep 2026 14:33:20 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Miklos Szeredi <mszeredi@redhat.com>
Subject: Re: [PATCH 6.18.y 1/4] fuse: abort related layering cleanup
Message-ID: <2026090913-courier-static-e571@gregkh>
References: <2026083101-rimless-sadness-3898@gregkh>
 <20260831164256.270090-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831164256.270090-1-sashal@kernel.org>

On Mon, Aug 31, 2026 at 12:42:53PM -0400, Sasha Levin wrote:
> From: Miklos Szeredi <mszeredi@redhat.com>
> 
> [ Upstream commit 4eeb5e6cb0fd89b343fcf755ae3aad76fdb5b2c2 ]
> 
>  - rename fuse_abort_conn() to fuse_chan_abort(), pass fuse_chan pointer
>    instead of fuse_conn
> 
>  - pass an abort_with_err argument that tells fuse_dev_(read|write) to
>    return with ECONNABORTED instead of ENODEV
> 
>  - move fc->aborted to fch->abort_with_err
> 
>  - rename fuse_wait_aborted() to fuse_chan_wait_aborted()
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> 
> [ 6.18 has no "struct fuse_chan" -- the connection object still plays
>   that role, and the surrounding series that splits it out is not in
>   stable.  Adapted as follows:
> 
>   - the renames (fuse_abort_conn() -> fuse_chan_abort(),
>     fuse_wait_aborted() -> fuse_chan_wait_aborted(), the "abort_conn"
>     label in fuse_check_timeout() -> "chan_abort") and the new
>     abort_with_err argument are taken as-is, but both helpers keep
>     taking "struct fuse_conn *".
> 
>   - the "move fc->aborted to fch->abort_with_err" bullet is dropped:
>     there is no fuse_chan to move the flag into, so fc->aborted stays
>     in struct fuse_conn.  fuse_chan_abort() only ever *sets* it, as
>     control.c did before, rather than assigning the new argument
>     unconditionally the way upstream does: on this tree the flag is
>     write-once and is what makes fuse_dev_do_read() and
>     fuse_uring_cmd() report ECONNABORTED instead of ENODEV, so letting
>     a later abort with abort_with_err=false clear it (umount -f,
>     fuse_conn_destroy(), fuse_dev_release(), the timeout worker) would
>     change what userspace sees after a sysfs abort on an abort_err
>     mount.  Consequently the fuse_dev_i.h and dev_uring.c hunks, which
>     only rename the field access, are dropped as well.
> 
>   - fs/fuse/dev.h and fs/fuse/req_timeout.c do not exist here: the
>     declarations stay in fuse_i.h and fuse_check_timeout() lives in
>     dev.c, so those two hunks were replayed there.
> 
>   - in request_wait_answer() the connection pointer is named "fch",
>     matching the name upstream gives it in 28d733cc3ecad ("fuse: change
>     req->fm to req->chan"), so that the follow-up fix applies here
>     unchanged. ]
> 
> [ sashal: Reduced backport -- upstream 4eeb5e6cb0fd8 touches 9 file(s), this
>   backport carries 5. Not backported here:
>   fs/fuse/dev.h
>   fs/fuse/dev_uring.c
>   fs/fuse/fuse_dev_i.h
>   fs/fuse/req_timeout.c
>   This note is generated from the file lists only; see the resolution record
>   for the reasoning. ]
> 
> Stable-dep-of: 64b0b5cacbd2 ("fuse: wait for FR_FINISHED on abort_on_kill to prevent use-after-free")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/fuse/control.c |  4 +---
>  fs/fuse/cuse.c    |  4 ++--
>  fs/fuse/dev.c     | 35 +++++++++++++++++++----------------
>  fs/fuse/fuse_i.h  |  4 ++--
>  fs/fuse/inode.c   |  6 +++---
>  5 files changed, 27 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/fuse/control.c b/fs/fuse/control.c
> index 2e300f6d646c3..5536d6ee65514 100644
> --- a/fs/fuse/control.c
> +++ b/fs/fuse/control.c
> @@ -37,9 +37,7 @@ static ssize_t fuse_conn_abort_write(struct file *file, const char __user *buf,
>  {
>  	struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
>  	if (fc) {
> -		if (fc->abort_err)
> -			fc->aborted = true;
> -		fuse_abort_conn(fc);
> +		fuse_chan_abort(fc, fc->abort_err);
>  		fuse_conn_put(fc);
>  	}
>  	return count;
> diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
> index 2bb98bf81b079..d90f138321fe9 100644
> --- a/fs/fuse/cuse.c
> +++ b/fs/fuse/cuse.c
> @@ -425,7 +425,7 @@ static void cuse_process_init_reply(struct fuse_mount *fm,
>  err_region:
>  	unregister_chrdev_region(devt, 1);
>  err:
> -	fuse_abort_conn(fc);
> +	fuse_chan_abort(fc, false);
>  	goto out;
>  }
>  
> @@ -593,7 +593,7 @@ static ssize_t cuse_class_abort_store(struct device *dev,
>  {
>  	struct cuse_conn *cc = dev_get_drvdata(dev);
>  
> -	fuse_abort_conn(&cc->fc);
> +	fuse_chan_abort(&cc->fc, false);
>  	return count;
>  }
>  static DEVICE_ATTR(abort, 0200, NULL, cuse_class_abort_store);
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 77c3982bca3d7..934f9ac5056ed 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -87,13 +87,13 @@ void fuse_check_timeout(struct work_struct *work)
>  	expired = fuse_request_expired(fc, &fiq->pending);
>  	spin_unlock(&fiq->lock);
>  	if (expired)
> -		goto abort_conn;
> +		goto chan_abort;
>  
>  	spin_lock(&fc->bg_lock);
>  	expired = fuse_request_expired(fc, &fc->bg_queue);
>  	spin_unlock(&fc->bg_lock);
>  	if (expired)
> -		goto abort_conn;
> +		goto chan_abort;
>  
>  	spin_lock(&fc->lock);
>  	if (!fc->connected) {
> @@ -107,7 +107,7 @@ void fuse_check_timeout(struct work_struct *work)
>  		    fuse_fpq_processing_expired(fc, fpq->processing)) {
>  			spin_unlock(&fpq->lock);
>  			spin_unlock(&fc->lock);
> -			goto abort_conn;
> +			goto chan_abort;
>  		}
>  
>  		spin_unlock(&fpq->lock);
> @@ -115,15 +115,15 @@ void fuse_check_timeout(struct work_struct *work)
>  	spin_unlock(&fc->lock);
>  
>  	if (fuse_uring_request_expired(fc))
> -	    goto abort_conn;
> +	    goto chan_abort;
>  
>  out:
>  	queue_delayed_work(system_percpu_wq, &fc->timeout.work,
>  			   fuse_timeout_timer_freq);
>  	return;
>  
> -abort_conn:
> -	fuse_abort_conn(fc);
> +chan_abort:
> +	fuse_chan_abort(fc, false);
>  }
>  
>  static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
> @@ -180,7 +180,7 @@ static void fuse_drop_waiting(struct fuse_conn *fc)
>  {
>  	/*
>  	 * lockess check of fc->connected is okay, because atomic_dec_and_test()
> -	 * provides a memory barrier matched with the one in fuse_wait_aborted()
> +	 * provides a memory barrier matched with the one in fuse_chan_wait_aborted()
>  	 * to ensure no wake-up is missed.
>  	 */
>  	if (atomic_dec_and_test(&fc->num_waiting) &&
> @@ -551,11 +551,11 @@ bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock)
>  
>  static void request_wait_answer(struct fuse_req *req)
>  {
> -	struct fuse_conn *fc = req->fm->fc;
> -	struct fuse_iqueue *fiq = &fc->iq;
> +	struct fuse_conn *fch = req->fm->fc;
> +	struct fuse_iqueue *fiq = &fch->iq;
>  	int err;
>  
> -	if (!fc->no_interrupt) {
> +	if (!fch->no_interrupt) {
>  		/* Any signal may interrupt this */
>  		err = wait_event_interruptible(req->waitq,
>  					test_bit(FR_FINISHED, &req->flags));
> @@ -579,7 +579,7 @@ static void request_wait_answer(struct fuse_req *req)
>  			return;
>  
>  		if (req->args->abort_on_kill) {
> -			fuse_abort_conn(fc);
> +			fuse_chan_abort(fch, false);
>  			return;
>  		}
>  
> @@ -1491,7 +1491,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
>  	spin_lock(&fpq->lock);
>  	/*
>  	 *  Must not put request on fpq->io queue after having been shut down by
> -	 *  fuse_abort_conn()
> +	 *  fuse_chan_abort()
>  	 */
>  	if (!fpq->connected) {
>  		req->out.h.error = err = -ECONNABORTED;
> @@ -2475,10 +2475,13 @@ static void end_polls(struct fuse_conn *fc)
>   * is OK, the request will in that case be removed from the list before we touch
>   * it.
>   */
> -void fuse_abort_conn(struct fuse_conn *fc)
> +void fuse_chan_abort(struct fuse_conn *fc, bool abort_with_err)
>  {
>  	struct fuse_iqueue *fiq = &fc->iq;
>  
> +	if (abort_with_err)
> +		fc->aborted = true;
> +
>  	spin_lock(&fc->lock);
>  	if (fc->connected) {
>  		struct fuse_dev *fud;
> @@ -2547,9 +2550,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
>  		spin_unlock(&fc->lock);
>  	}
>  }
> -EXPORT_SYMBOL_GPL(fuse_abort_conn);
> +EXPORT_SYMBOL_GPL(fuse_chan_abort);
>  
> -void fuse_wait_aborted(struct fuse_conn *fc)
> +void fuse_chan_wait_aborted(struct fuse_conn *fc)
>  {
>  	/* matches implicit memory barrier in fuse_drop_waiting() */
>  	smp_mb();
> @@ -2579,7 +2582,7 @@ int fuse_dev_release(struct inode *inode, struct file *file)
>  		/* Are we the last open device? */
>  		if (atomic_dec_and_test(&fc->dev_count)) {
>  			WARN_ON(fc->iq.fasync != NULL);
> -			fuse_abort_conn(fc);
> +			fuse_chan_abort(fc, false);
>  		}
>  		fuse_dev_free(fud);
>  	}
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index c288f28f6c6ea..8b745045f1ab3 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1272,8 +1272,8 @@ void fuse_request_assign_unique(struct fuse_iqueue *fiq, struct fuse_req *req);
>  void fuse_request_end(struct fuse_req *req);
>  
>  /* Abort all requests */
> -void fuse_abort_conn(struct fuse_conn *fc);
> -void fuse_wait_aborted(struct fuse_conn *fc);
> +void fuse_chan_abort(struct fuse_conn *fc, bool abort_with_err);
> +void fuse_chan_wait_aborted(struct fuse_conn *fc);
>  
>  /* Check if any requests timed out */
>  void fuse_check_timeout(struct work_struct *work);
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index e9ed693fc7b37..399298816dea0 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -621,7 +621,7 @@ static void fuse_umount_begin(struct super_block *sb)
>  	if (fc->no_force_umount)
>  		return;
>  
> -	fuse_abort_conn(fc);
> +	fuse_chan_abort(fc, false);
>  
>  	// Only retire block-device-based superblocks.
>  	if (sb->s_bdev != NULL)
> @@ -2099,8 +2099,8 @@ void fuse_conn_destroy(struct fuse_mount *fm)
>  	if (fc->destroy)
>  		fuse_send_destroy(fm);
>  
> -	fuse_abort_conn(fc);
> -	fuse_wait_aborted(fc);
> +	fuse_chan_abort(fc, false);
> +	fuse_chan_wait_aborted(fc);
>  
>  	if (!list_empty(&fc->entry)) {
>  		mutex_lock(&fuse_mutex);
> -- 
> 2.53.0
> 
> 

Series did not apply :(
