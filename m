Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6504D957F
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 11:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644753; cv=none; b=pccEyvZc/VmzTdDiLpt6aF9n3hZyhgsKvzURRv3h+093rg7quSopKBV4FuiAx7PrJ8fwA0sQutNTKieJTd3MQvlDcb7M34CmMsNcfU3QvIUwKURTQTM584KT1hKhHFl3NeVpY7PoxyybkfgEl6yNdkJgr4rAaeu2hS3tNebEFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644753; c=relaxed/simple;
	bh=AlDmUx5P3tHH9C3xYORUgsU7LmEFgPlsmgUASClJoEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/zj+msbYqJGdK7LVaN1NOhMgS/Hm9014Ml6J70Mrzv4xCffx05bQOBPxjhO92629PRgIOCUUJ0wMKTyuSNXoeuyY43RAx3wPfesx4qP+egiu6NF+ydEMU26ae3t5u+YCMNvuRlonvpki4PKq/JEM9+ZqK8io7Bg+xWoRtXXM4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=S7T3QiaT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PJMpOjzm; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="S7T3QiaT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PJMpOjzm"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EBC247A00B9;
	Thu, 17 Sep 2026 07:32:30 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 17 Sep 2026 07:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789644750;
	 x=1789731150; bh=QoB4Xzc+YPgDr6lsGvi5kB5HQqCB8svTCv6+vRg5aEs=; b=
	S7T3QiaT7siI9kqfwK0d9qz0S33PEI9x/5yWHnHIR8NQfiJQt7IMS7StrX0U44U8
	bxx4VpDW3ObPMTn88A04lq0kopQeAT6ITSTNbv/jLRd8t5XsBDeePKinCmMEiBET
	xxt3Xxk06VIgqa4aDklFOvKZolDO/4j9Dasd3A6msskIf1kdzQbZ7oEspY4kNvPS
	YjCYt2MvEFbdsQkWuu9OErMqJiODO1HpW1V3X7qhqq3+shWRJ6E9kMLkUnOpruZ9
	XTjpBz+sOpsYgmNA9Pjrb5+kU9lwAB43HnkCzADicqmYp4iPiqLfp2IbIFvwQODt
	uuzPVBoOBTgPHHgK0pwnaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789644750; x=
	1789731150; bh=QoB4Xzc+YPgDr6lsGvi5kB5HQqCB8svTCv6+vRg5aEs=; b=P
	JMpOjzmjLKe+ZXpk3+9VhbTAkwTr1ZB60gnWOEip75MS05Ryw4d+dOISKObTfpGZ
	by5BL+zvDAkOOtX6E3+f+i2P9mm3+8JtNrAm/M0eStHln2X1auLF9K9ZjJyBjWsM
	EjbHxGOAzMT1HIvQRDHAwwHDD8+i63KQzgLqrKJ4P3ql/DAzKMqTasfzlpgIaNYx
	XxjZbYTqIq3b15hllR1lElkRff1JGVTuE4N0kOIkXSj52yLU+k0MW4IJFE6e7E4x
	0hD5sYeljzAnnCbPE4rGZO0FCSpJSyysBQPKV/hSPO7nNPS/NLrXbMVnuh6K8T8B
	H11u0c7KW6aCDgcY+sKvw==
X-ME-Sender: <xms:zs-rarYCj1JjzZebRZbBdeBwYoCFMcRh5AKwsGuuGpoehejVZLN3jg>
    <xme:zs-rakbJBGyh7ytmvZlHJjRmgTf9kSj7Kn43Ov9gwYYJmDWtfxhGI-Wtu54fANmCo
    Z6m5iCT_OUps1Z-DOF1BlnrKQWywWCmGjQhUo6_nm7uO9LUsf40>
X-ME-Received: <xmr:zs-rakklpbPF7iEQ_XJ9iFFL3LAhu0MJV0n_3FlHUXpg5K8h4thvQ3zg_y2o>
X-ME-Proxy-Cause: dmFkZTGCUBAKMie9tcNdlQP9PuzNgDX2HZzelnkXRl8JAN7+vVxSsulxGFO7AZCYVJ9GOw
    fEa7045MCkDz+wrIrxa2A/9fmXwcrpUahmg44A3iDkMpjxQxAlKAaqaaQfNqQ4pprAONeT
    +FBVIGiKm2PgjKviBACWsjIjTWkW/0T0doNm3oJbQtHljVqay2Nm+21iBPUK+GFjnhHhLp
    mw+cM0qZqsocKlLA0eKbNH9Q2undM0DQePyn9TeUBXV4a+v7hqY1Dbxw4GZ8naVjidVcmX
    8eICiWZ+2SPxN01pWBu5ao9wzFWito8C2FDNn/9BUsDZVSoCg9zNsxXN3pGp2W3qwicATd
    ljL62xvJE+3uZzg1z6K4zBKy4C3rcIfXPN4YFWEEQpltA4t/j7b9KCmhmFjcNI7A1Nf4cf
    FY0jEUHFPPYjMtnWqNy7eMoPCRaExnmiMzViZh40F0gHGfwBW0aasHLgKe/qRlh6EOlcDo
    n4lI8P3JmYwyIt50gERLlGHKSdm7fHfX3REIzZBtnWt5CFX7BvCiCbwS6lE/hgIZwqgiX+
    0XuOIH0SZt/Mn8US8n6AruwgY68svV0YRwzRhZvsQhJFGcfTS+0nGyQLYi0sS0hkCxhs62
    Qm4vX16xJXBa9vHZaaOjxAqapUQAmRV3lsdJ1cNSMWSMmTWMKDMcD+xV0vfg
X-ME-Proxy: <xmx:zs-rav1z1GohUcLLlnx_s_kh0hBNmNlMgifmr9-DuAqTtC4VPTsvFw>
    <xmx:zs-rak0BqjLwQ9qNdYs2cEpGaCH2zn3VmC9vY4tRj8ovp5ODsoPDmg>
    <xmx:zs-rahqcPXttAqW9iX6LPzYVJ7xmvGScvIgebjNue-qeZ5CKUytieQ>
    <xmx:zs-ragiokM78lh0wPglB5IIaXqig-wLYcY8jFQG1prDod0shb1EGhg>
    <xmx:zs-ragCL2Z0uKF8AogdLTwZoUJpf5d7nz79_WvV9aTwuO0srgTOs2gWk>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 07:32:30 -0400 (EDT)
Date: Thu, 17 Sep 2026 12:29:23 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH 6.12.y] lockd, nfsd: RCU-protect nlmsvc_ops dispatch
Message-ID: <2026091718-luckless-splinter-a61a@gregkh>
References: <2026090303-limpness-basis-79a4@gregkh>
 <20260905015027.1808554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260905015027.1808554-1-sashal@kernel.org>

On Fri, Sep 04, 2026 at 09:50:27PM -0400, Sasha Levin wrote:
> From: Jeff Layton <jlayton@kernel.org>
> 
> [ Upstream commit 641e5e20852359b8c31149be4598884e30652f60 ]
> 
> nlmsvc_ops is published by nfsd_lockd_init() and cleared by
> nfsd_lockd_shutdown() with plain stores, while lockd dereferences
> it unguarded from dispatch sites in fs/lockd/svcsubs.c. The pointer
> targets nfsd's .rodata and the fopen/fclose callbacks live in nfsd's
> .text, so a stale load after rmmod nfsd results in either a NULL
> deref or a module-text use-after-free.
> 
> Declare nlmsvc_ops as __rcu, publish via rcu_assign_pointer(), clear
> via RCU_INIT_POINTER() + synchronize_rcu(). Add a struct module
> *owner field to nlmsvc_binding and pin the module across indirect
> calls with try_module_get/module_put. When the binding is torn down,
> fall back to fput() to avoid leaking struct file references.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Link: https://patch.msgid.link/20260611-nfsd-testing-v2-16-5b90e276f2d9@kernel.org
> Signed-off-by: Chuck Lever <cel@kernel.org>
> [ adapted nlmsvc_ops protection to 6.12’s __be32 fopen API and existing nlm_close_files() helper ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/lockd/svc.c             |  4 +--
>  fs/lockd/svc4proc.c        |  4 +--
>  fs/lockd/svcproc.c         |  4 +--
>  fs/lockd/svcsubs.c         | 56 ++++++++++++++++++++++++++++----------
>  fs/nfsd/lockd.c            |  6 ++--
>  include/linux/lockd/bind.h | 12 ++++++--
>  6 files changed, 61 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index 4ec22c2f2ea3c..87f20d1edb2c2 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -47,7 +47,7 @@
>  
>  static struct svc_program	nlmsvc_program;
>  
> -const struct nlmsvc_binding	*nlmsvc_ops;
> +const struct nlmsvc_binding __rcu *nlmsvc_ops;
>  EXPORT_SYMBOL_GPL(nlmsvc_ops);
>  
>  static DEFINE_MUTEX(nlmsvc_mutex);
> @@ -142,7 +142,7 @@ lockd(void *vrqstp)
>  		nlmsvc_retry_blocked(rqstp);
>  		svc_recv(rqstp);
>  	}
> -	if (nlmsvc_ops)
> +	if (rcu_access_pointer(nlmsvc_ops))
>  		nlmsvc_invalidate_all();
>  	nlm_shutdown_hosts();
>  	cancel_delayed_work_sync(&ln->grace_period_end);
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 3f633bb24623a..ea3b689f8b93a 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -29,7 +29,7 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
>  	__be32			error = 0;
>  
>  	/* nfsd callbacks must have been installed for this procedure */
> -	if (!nlmsvc_ops)
> +	if (!rcu_access_pointer(nlmsvc_ops))
>  		return nlm_lck_denied_nolocks;
>  
>  	if (lock->lock_start > OFFSET_MAX ||
> @@ -487,7 +487,7 @@ nlm4svc_proc_granted_res(struct svc_rqst *rqstp)
>  {
>  	struct nlm_res *argp = rqstp->rq_argp;
>  
> -        if (!nlmsvc_ops)
> +        if (!rcu_access_pointer(nlmsvc_ops))
>                  return rpc_success;
>  
>          dprintk("lockd: GRANTED_RES   called\n");
> diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> index 8cda2aba82d25..44da63392a09d 100644
> --- a/fs/lockd/svcproc.c
> +++ b/fs/lockd/svcproc.c
> @@ -59,7 +59,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
>  	__be32			error = 0;
>  
>  	/* nfsd callbacks must have been installed for this procedure */
> -	if (!nlmsvc_ops)
> +	if (!rcu_access_pointer(nlmsvc_ops))
>  		return nlm_lck_denied_nolocks;
>  
>  	/* Obtain host handle */
> @@ -521,7 +521,7 @@ nlmsvc_proc_granted_res(struct svc_rqst *rqstp)
>  {
>  	struct nlm_res *argp = rqstp->rq_argp;
>  
> -	if (!nlmsvc_ops)
> +	if (!rcu_access_pointer(nlmsvc_ops))
>  		return rpc_success;
>  
>  	dprintk("lockd: GRANTED_RES   called\n");
> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> index 1a97f69397c00..396436eac8e22 100644
> --- a/fs/lockd/svcsubs.c
> +++ b/fs/lockd/svcsubs.c
> @@ -86,12 +86,24 @@ int lock_to_openmode(struct file_lock *lock)
>  static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
>  			   struct nlm_file *file, int mode)
>  {
> +	const struct nlmsvc_binding *ops;
>  	struct file **fp = &file->f_file[mode];
>  	__be32	nfserr;
>  
> -	if (*fp)
> +	rcu_read_lock();
> +	ops = rcu_dereference(nlmsvc_ops);
> +	if (!ops || !try_module_get(ops->owner)) {
> +		rcu_read_unlock();
> +		return nlm_lck_denied_nolocks;
> +	}
> +	rcu_read_unlock();
> +
> +	if (*fp) {
> +		module_put(ops->owner);
>  		return 0;
> -	nfserr = nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, mode);
> +	}
> +	nfserr = ops->fopen(rqstp, &file->f_handle, fp, mode);
> +	module_put(ops->owner);
>  	if (nfserr)
>  		dprintk("lockd: open failed (error %d)\n", nfserr);
>  	return nfserr;
> @@ -159,6 +171,33 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
>  	goto out_unlock;
>  }
>  
> +/*
> + * Release the struct file references held by a nlm_file.
> + */
> +static void nlm_close_files(struct nlm_file *file)
> +{
> +	const struct nlmsvc_binding *ops;
> +	bool have_ops;
> +
> +	rcu_read_lock();
> +	ops = rcu_dereference(nlmsvc_ops);
> +	have_ops = ops && try_module_get(ops->owner);
> +	rcu_read_unlock();
> +
> +	if (have_ops) {
> +		if (file->f_file[O_RDONLY])
> +			ops->fclose(file->f_file[O_RDONLY]);
> +		if (file->f_file[O_WRONLY])
> +			ops->fclose(file->f_file[O_WRONLY]);
> +		module_put(ops->owner);
> +	} else {
> +		if (file->f_file[O_RDONLY])
> +			fput(file->f_file[O_RDONLY]);
> +		if (file->f_file[O_WRONLY])
> +			fput(file->f_file[O_WRONLY]);
> +	}
> +}
> +
>  /*
>   * Delete a file after having released all locks, blocks and shares
>   */
> @@ -168,10 +207,7 @@ nlm_delete_file(struct nlm_file *file)
>  	nlm_debug_print_file("closing file", file);
>  	if (!hlist_unhashed(&file->f_list)) {
>  		hlist_del(&file->f_list);
> -		if (file->f_file[O_RDONLY])
> -			nlmsvc_ops->fclose(file->f_file[O_RDONLY]);
> -		if (file->f_file[O_WRONLY])
> -			nlmsvc_ops->fclose(file->f_file[O_WRONLY]);
> +		nlm_close_files(file);
>  		kfree(file);
>  	} else {
>  		printk(KERN_WARNING "lockd: attempt to release unknown file!\n");
> @@ -286,14 +322,6 @@ nlm_file_inuse(struct nlm_file *file)
>  	return 0;
>  }
>  
> -static void nlm_close_files(struct nlm_file *file)
> -{
> -	if (file->f_file[O_RDONLY])
> -		nlmsvc_ops->fclose(file->f_file[O_RDONLY]);
> -	if (file->f_file[O_WRONLY])
> -		nlmsvc_ops->fclose(file->f_file[O_WRONLY]);
> -}
> -
>  /*
>   * Loop over all files in the file table.
>   */
> diff --git a/fs/nfsd/lockd.c b/fs/nfsd/lockd.c
> index 6b042218668b8..e933788e7a350 100644
> --- a/fs/nfsd/lockd.c
> +++ b/fs/nfsd/lockd.c
> @@ -88,6 +88,7 @@ nlm_fclose(struct file *filp)
>  }
>  
>  static const struct nlmsvc_binding nfsd_nlm_ops = {
> +	.owner		= THIS_MODULE,
>  	.fopen		= nlm_fopen,		/* open file for locking */
>  	.fclose		= nlm_fclose,		/* close file */
>  };
> @@ -96,11 +97,12 @@ void
>  nfsd_lockd_init(void)
>  {
>  	dprintk("nfsd: initializing lockd\n");
> -	nlmsvc_ops = &nfsd_nlm_ops;
> +	rcu_assign_pointer(nlmsvc_ops, &nfsd_nlm_ops);
>  }
>  
>  void
>  nfsd_lockd_shutdown(void)
>  {
> -	nlmsvc_ops = NULL;
> +	RCU_INIT_POINTER(nlmsvc_ops, NULL);
> +	synchronize_rcu();
>  }
> diff --git a/include/linux/lockd/bind.h b/include/linux/lockd/bind.h
> index c53c81242e727..e25943e485c5c 100644
> --- a/include/linux/lockd/bind.h
> +++ b/include/linux/lockd/bind.h
> @@ -21,11 +21,17 @@
>  struct svc_rqst;
>  struct rpc_task;
>  struct rpc_clnt;
> +struct module;
>  
> -/*
> - * This is the set of functions for lockd->nfsd communication
> +/**
> + * struct nlmsvc_binding - lockd -> nfsd callback table
> + * @owner:  module that provides this binding.
> + * @fopen:  open a file by NFS file handle on behalf of an NLM request.
> + * @fclose: close a file that was previously opened via @fopen.
> + *          Implementations MUST be semantically equivalent to fput().
>   */
>  struct nlmsvc_binding {
> +	struct module		*owner;
>  	__be32			(*fopen)(struct svc_rqst *,
>  						struct nfs_fh *,
>  						struct file **,
> @@ -33,7 +39,7 @@ struct nlmsvc_binding {
>  	void			(*fclose)(struct file *);
>  };
>  
> -extern const struct nlmsvc_binding *nlmsvc_ops;
> +extern const struct nlmsvc_binding __rcu *nlmsvc_ops;
>  
>  /*
>   * Similar to nfs_client_initdata, but without the NFS-specific
> -- 
> 2.53.0
> 
> 

Does not apply
