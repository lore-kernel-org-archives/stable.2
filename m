Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CA6556B81
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957838; cv=none; b=fm3npdhyhJy2IsNAMMDQjn9WnjBn0BRCgCuOPGc3+LP7SRsUPNSX3LN3aLK5ecUuGT/LhpuiLFUVuSBZ+rPLesHn/jf78cRy8KLROmtURMNKtEgo+/20SDLdfLGZsKvIqMLBCeAEXGnwn+FaRd9RPRKTuj0yFuIbIJ3nz4cSrd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957838; c=relaxed/simple;
	bh=KB8nUJlwOpHCWB5gkyV3Eky6DIdRP3Cl93Z8I6qocX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejyBeW4XczYvnvyQNMIJAlgizterhlfdkFbWAy2wI/szW39mrdtFZ60DbyHEXoQhpPphkCptfU+i3T2u2YMINyCnQmm3L+62XIpo9J8fKcgAKVnZ9Dp7fLCab9BvwGISspUMxVf3tbeZcYhjPGQNQ0OqX5p8jkkM6JnKMFcXhsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=KboCTw96; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B1NVfjAP; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="KboCTw96";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B1NVfjAP"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9914B14000BF;
	Wed,  9 Sep 2026 08:43:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 09 Sep 2026 08:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1788957835; x=1789044235; bh=HbuZgRfMX5
	Q2GY0OUbNFcpFwgBmTYMoUOWVwKyUwaeQ=; b=KboCTw961H/AyvtL53Pc4RDHh/
	rOByStYVrEO65D0S2BXZK8GAHQnV8DyUN+96CQ5f+d5/n7v1MY2YZoFAp+2OU/iV
	1EsHLwYbpPYF2Cs4MEmzMnTK3aJ4Xj+994ThfPF3/egd6FuZuaXrn07dAmaTwyob
	m5OL7SYWedlF6HbtWG7mvqZ2L8PFD4Ef8h/PEOxPxXUzhhBweZkWxOLLK5hTgLON
	fw0KQDYcOvRb7XCkNA7qzAUVkScq57fiQvqCGE18mIRIbOm+OkHrxLG1w8auBY1W
	GBa6mfk8k2rpNBv59ZkoS4Qz98QPff3hE9EN1miKdRxjKu/GAsRa1gII5qxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1788957835; x=1789044235; bh=HbuZgRfMX5Q2GY0OUbNFcpFwgBmTYMoUOWV
	wKyUwaeQ=; b=B1NVfjAPw3Z/jOD48LhVrn0G7XiDrcGAAiX+gYsDE9qJbF5yXo/
	GfRQ2IYHPeYtzMEjen5rwsFx0fOtPg0QhUG23SKSyLZ9qUXkHyUvuShBEYzGhQ4t
	Z5n2sFO4d0QcuSUMrvs2wH8MQiyZb1kDRN3xymr4sHOfK8maWQz0yNcjqgXtJGkc
	OrbBgIEoC9C4/ycSD5ZnDJgDqWQz14l1eJs4D94WXVsGr2hBBH/d6+2yjsThe7Hw
	Lao/0VKoyhyhSr0k2oDOTht44zqPgBKkIp7pIfgQDaNqgbCwACz1qeZfaPIRKTwj
	K7H26URa5ahdrRC2qwAj8VeV/GeylsaI4PQ==
X-ME-Sender: <xms:i1Share-vNFjJ-UafP5YCPZAD_Hv-zl9mAiA0fkdmAISakeLM9u3rQ>
    <xme:i1SharO7UtgTWrb1FW1xy0XVBt84WUCTtl1Se3lf-98jGGxGWNC41EszRfUpud3Sp
    n_cu19CrGo6TNWxhma_IkNmlfFlRUU7uKHq-fjcabGpdWcUCdM>
X-ME-Received: <xmr:i1SharJLH9vYTFOAXsrxzfllqZUMi2JT_0Wj1HfkK7iPoe8F0vlEPj2XBXBBL3dWqapA2CuAru3tqjTNqNBaXWG0OLbVHFy6HqXN4DB-8pg>
X-ME-Proxy-Cause: dmFkZTFJ/pXbfD9qbUuROi4/XsPCj1M+tkTCiWYeboO+rKD+H3DYkqMqxgAqVxaoW0s1GZ
    kh4wrqn5XhKYiLRcIgjoRxaIk4dkABQlAIEbEBFG8B0Rq8y6JCApSV7wtOnzjjVcxeOotx
    5Oy/QqXXiOp1D7eCPOLEU/MDeY8eIyrBvlPtrHWzi4tvKV2wFH2JX/xqTL5HIdVDv/bLgJ
    6zj9YJDdxLFuZcdK+5D1l/bwsn1hKU3FO+fOLXCoJhzR+Bh0HMjG5YLa5vZHa6a1F8l5os
    iwQe1Yki1vsBMb8Js5UDKKFp3YPlLd6JvvzrUBDsZEW90Yn+t5KxwX5tAm9qiqt7pxv/OO
    WpZb+DoU1vT/QHWWKNWucOd4MsyMwp5HmXAyK/rDa71+58KpwefpzIqO+Vk5LHO8e+L7Uj
    kEb2wUwTQemq91LwXsKIJH6Z66MQby5BDduwcsEiypUeu7AFh0+D7Xr/jWUIGSfWYLDE2R
    dfS4SAWRwSxNYjvz9SYxSZILOPflzZO+ediqp0ISsPxSVXDuX3tOWByAw77+n8IDIZL1o7
    l9TkFSidMvIuzFtIzxS/e3A6k8PMiZYYL7z4Kjh1FFfGWG8NcNQ8zYnRk6RhAVhYFZGASa
    +NIKBbNwnbvnaEecLDPHiUWN6PA/5twvDskbN6RBmjIOTieOPN7vn1tAIsXQ
X-ME-Proxy: <xmx:i1SharIkJW9mOaZpnaoZXJ9ZX7goDbSDal0tqsuUqzwWBmI0h-Alqg>
    <xmx:i1Shal7co2R5t_x1_n1C5ZHPgPZ9Uq-oiOcsuox_lFEeh70acGgwVg>
    <xmx:i1ShalcoHe80Q2bksSR9s2aX47czwJvAvr7Vj-jl-ej8NFH-VbMeVA>
    <xmx:i1ShagEs-ipEOW8gGajhwKEhn-VCiFxXGm4K_ThqHs3f85E9HjKvFQ>
    <xmx:i1SharFDygrmz_FOrQcbDFlzV2aqo-Hq4wZHu9R_eT-tDXhNWg1_nG-s>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 08:43:54 -0400 (EDT)
Date: Wed, 9 Sep 2026 14:42:30 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <cel@kernel.org>
Subject: Re: [PATCH 6.18.y] lockd, nfsd: RCU-protect nlmsvc_ops dispatch
Message-ID: <2026090924-ergonomic-willfully-6d1b@gregkh>
References: <2026090303-kisser-married-4c63@gregkh>
 <20260905000459.1657593-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905000459.1657593-1-sashal@kernel.org>

On Fri, Sep 04, 2026 at 08:04:59PM -0400, Sasha Levin wrote:
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
> [ Adapted RCU and module-pinning changes to the older `__be32` callback interface and existing `nlm_close_files()` helper. ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/lockd/svc.c             |  4 +--
>  fs/lockd/svc4proc.c        |  4 +--
>  fs/lockd/svcproc.c         |  4 +--
>  fs/lockd/svcsubs.c         | 60 ++++++++++++++++++++++++++++----------
>  fs/nfsd/lockd.c            |  6 ++--
>  include/linux/lockd/bind.h | 12 ++++++--
>  6 files changed, 64 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
> index d68afa196535a..28b9886394c8f 100644
> --- a/fs/lockd/svc.c
> +++ b/fs/lockd/svc.c
> @@ -48,7 +48,7 @@
>  
>  static struct svc_program	nlmsvc_program;
>  
> -const struct nlmsvc_binding	*nlmsvc_ops;
> +const struct nlmsvc_binding __rcu *nlmsvc_ops;
>  EXPORT_SYMBOL_GPL(nlmsvc_ops);
>  
>  static DEFINE_MUTEX(nlmsvc_mutex);
> @@ -143,7 +143,7 @@ lockd(void *vrqstp)
>  		nlmsvc_retry_blocked(rqstp);
>  		svc_recv(rqstp);
>  	}
> -	if (nlmsvc_ops)
> +	if (rcu_access_pointer(nlmsvc_ops))
>  		nlmsvc_invalidate_all();
>  	nlm_shutdown_hosts();
>  	cancel_delayed_work_sync(&ln->grace_period_end);
> diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> index 75e020a8bfd07..a1adfd66dd230 100644
> --- a/fs/lockd/svc4proc.c
> +++ b/fs/lockd/svc4proc.c
> @@ -31,7 +31,7 @@ nlm4svc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
>  	__be32			error = 0;
>  
>  	/* nfsd callbacks must have been installed for this procedure */
> -	if (!nlmsvc_ops)
> +	if (!rcu_access_pointer(nlmsvc_ops))
>  		return nlm_lck_denied_nolocks;
>  
>  	if (lock->lock_start > OFFSET_MAX ||
> @@ -484,7 +484,7 @@ nlm4svc_proc_granted_res(struct svc_rqst *rqstp)
>  {
>  	struct nlm_res *argp = rqstp->rq_argp;
>  
> -        if (!nlmsvc_ops)
> +        if (!rcu_access_pointer(nlmsvc_ops))
>                  return rpc_success;
>  
>          dprintk("lockd: GRANTED_RES   called\n");
> diff --git a/fs/lockd/svcproc.c b/fs/lockd/svcproc.c
> index d98e8d684376b..49d20df3b8ae3 100644
> --- a/fs/lockd/svcproc.c
> +++ b/fs/lockd/svcproc.c
> @@ -61,7 +61,7 @@ nlmsvc_retrieve_args(struct svc_rqst *rqstp, struct nlm_args *argp,
>  	__be32			error = 0;
>  
>  	/* nfsd callbacks must have been installed for this procedure */
> -	if (!nlmsvc_ops)
> +	if (!rcu_access_pointer(nlmsvc_ops))
>  		return nlm_lck_denied_nolocks;
>  
>  	/* Obtain host handle */
> @@ -519,7 +519,7 @@ nlmsvc_proc_granted_res(struct svc_rqst *rqstp)
>  {
>  	struct nlm_res *argp = rqstp->rq_argp;
>  
> -	if (!nlmsvc_ops)
> +	if (!rcu_access_pointer(nlmsvc_ops))
>  		return rpc_success;
>  
>  	dprintk("lockd: GRANTED_RES   called\n");
> diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
> index d11beea76ddb5..58846c235c6e4 100644
> --- a/fs/lockd/svcsubs.c
> +++ b/fs/lockd/svcsubs.c
> @@ -90,24 +90,38 @@ int lock_to_openmode(struct file_lock *lock)
>  static __be32 nlm_do_fopen(struct svc_rqst *rqstp,
>  			   struct nlm_file *file, int mode)
>  {
> +	const struct nlmsvc_binding *ops;
>  	__be32 nfserr = nlm_lck_denied_nolocks;
>  	__be32 deferred = 0;
>  	struct file **fp;
>  	int m;
>  
> +	rcu_read_lock();
> +	ops = rcu_dereference(nlmsvc_ops);
> +	if (!ops || !try_module_get(ops->owner)) {
> +		rcu_read_unlock();
> +		return nlm_lck_denied_nolocks;
> +	}
> +	rcu_read_unlock();
> +
>  	for (m = O_RDONLY ; m <= O_WRONLY ; m++) {
>  		if (mode != O_RDWR && mode != m)
>  			continue;
>  
>  		fp = &file->f_file[m];
> -		if (*fp)
> +		if (*fp) {
> +			module_put(ops->owner);
>  			return 0;
> -		nfserr = nlmsvc_ops->fopen(rqstp, &file->f_handle, fp, m);
> -		if (!nfserr)
> +		}
> +		nfserr = ops->fopen(rqstp, &file->f_handle, fp, m);
> +		if (!nfserr) {
> +			module_put(ops->owner);
>  			return 0;
> +		}
>  		if (nfserr == nlm_drop_reply)
>  			deferred = nfserr;
>  	}
> +	module_put(ops->owner);
>  	if (deferred)
>  		return deferred;
>  	dprintk("lockd: open failed (error %d)\n", ntohl(nfserr));
> @@ -174,6 +188,33 @@ nlm_lookup_file(struct svc_rqst *rqstp, struct nlm_file **result,
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
> @@ -183,10 +224,7 @@ nlm_delete_file(struct nlm_file *file)
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
> @@ -301,14 +339,6 @@ nlm_file_inuse(struct nlm_file *file)
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
> index c774ce9aa2965..6cd028c142fe3 100644
> --- a/fs/nfsd/lockd.c
> +++ b/fs/nfsd/lockd.c
> @@ -86,6 +86,7 @@ nlm_fclose(struct file *filp)
>  }
>  
>  static const struct nlmsvc_binding nfsd_nlm_ops = {
> +	.owner		= THIS_MODULE,
>  	.fopen		= nlm_fopen,		/* open file for locking */
>  	.fclose		= nlm_fclose,		/* close file */
>  };
> @@ -94,11 +95,12 @@ void
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

Does not apply cleanly :(
