Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083D3559314
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958061; cv=none; b=aqFGZ+rUReP55sxFnz9OF8NgCl5dkTOJ4HAnHz8+qpIbTQWTsFD/i0Da9Z0sqPk1LP9N3W6UJXD+HJrKxI2JbXyuOcVkBniM8d0D06FGi8etbAB9CvAZmD03r7clctc1QZausF+o3J4kWfqYqvKN1QhDtbyduN6gk5IabaaQIN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958061; c=relaxed/simple;
	bh=yjnnbPi5TkP2uaGhDEtr0coS2a5EbD9dVJtNej0SVAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOtuE9H5xNf/ZfUlrVLi5o2e+nMFEWBYx+yUmGd8pa29SyDTLPPu0uaLVz8Y3qhz/ZWwkoPSzUAIcThyh9ncx5U3tmdf5D6UQ1jhTlAuJX5suyG3Cjpb1bF+8GDh89XeraumIkRkp/vWzxloyYFgSFhV+WzqPNfCPtnRpCRQJFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VI7e9WBF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VI7e9WBF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10A811F00A3A;
	Wed,  9 Sep 2026 12:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788958058;
	bh=JBkkvY+WJG3TYSpRbn9ebg7B3luGI39GMVqvlk9sfyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VI7e9WBFnMoV7LO6ThueXNe2jD8nFc2R2nKlmGxf5w2RpWucwbxpTuLQeR7RWqmTq
	 yxnDNJaHuFkoW+J8KzmTnICEw0BcQQxbKXV/grCDx9nnux9uJttr/b09FwIaz3JaFH
	 Hu4Sv0teOjT0FN00n2xjJPIqmNznGxs83Js3E69E=
Date: Wed, 9 Sep 2026 14:44:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, NeilBrown <neil@brown.name>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 6.18.y 1/3] nfsd: use workqueue enable/disable APIs for
 v4_end_grace sync
Message-ID: <2026090920-chef-unsealed-26d9@gregkh>
References: <2026090325-overpass-emoticon-993a@gregkh>
 <20260905032834.1915305-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905032834.1915305-1-sashal@kernel.org>

On Fri, Sep 04, 2026 at 11:28:32PM -0400, Sasha Levin wrote:
> From: NeilBrown <neil@brown.name>
> 
> [ Upstream commit 27e383ddeb3c88e20874c545285f2dce1a98f56a ]
> 
> "nfsd: provide locking for v4_end_grace" introduced a
> client_tracking_active flag protected by nn->client_lock to prevent
> the laundromat from being scheduled before client tracking
> initialization or after shutdown begins. That commit is suitable for
> backporting to LTS kernels that predate commit 86898fa6b8cd
> ("workqueue: Implement disable/enable for (delayed) work items").
> 
> However, the workqueue subsystem in recent kernels provides
> enable_delayed_work() and disable_delayed_work_sync() for this
> purpose. Using this mechanism enable us to remove the
> client_tracking_active flag and associated spinlock operations
> while preserving the same synchronization guarantees, which is
> a cleaner long-term approach.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> Tested-by: Li Lingfeng <lilingfeng3@huawei.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> Stable-dep-of: 9b57793863f6 ("nfsd: dedup nfs4_client_to_reclaim inserts")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/nfsd/netns.h     |  1 -
>  fs/nfsd/nfs4state.c | 22 +++++++++-------------
>  2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index fe8338735e7cc..d83c68872c4c3 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -67,7 +67,6 @@ struct nfsd_net {
>  	struct lock_manager nfsd4_manager;
>  	bool grace_ended;
>  	bool grace_end_forced;
> -	bool client_tracking_active;
>  	time64_t boot_time;
>  
>  	struct dentry *nfsd_client_dir;
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index c9d9a7d46e7b2..8c47c7fbd6a34 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6653,14 +6653,14 @@ bool nfsd4_force_end_grace(struct nfsd_net *nn)
>  {
>  	if (!nn->client_tracking_ops)
>  		return false;
> -	spin_lock(&nn->client_lock);
> -	if (nn->grace_ended || !nn->client_tracking_active) {
> -		spin_unlock(&nn->client_lock);
> +	if (READ_ONCE(nn->grace_ended))
>  		return false;
> -	}
> +	/* laundromat_work must be initialised now, though it might be disabled */
>  	WRITE_ONCE(nn->grace_end_forced, true);
> +	/* mod_delayed_work() doesn't queue work after
> +	 * nfs4_state_shutdown_net() has called disable_delayed_work_sync()
> +	 */
>  	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
> -	spin_unlock(&nn->client_lock);
>  	return true;
>  }
>  
> @@ -8995,7 +8995,6 @@ static int nfs4_state_create_net(struct net *net)
>  	nn->boot_time = ktime_get_real_seconds();
>  	nn->grace_ended = false;
>  	nn->grace_end_forced = false;
> -	nn->client_tracking_active = false;
>  	nn->nfsd4_manager.block_opens = true;
>  	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
>  	INIT_LIST_HEAD(&nn->client_lru);
> @@ -9010,6 +9009,8 @@ static int nfs4_state_create_net(struct net *net)
>  	INIT_LIST_HEAD(&nn->blocked_locks_lru);
>  
>  	INIT_DELAYED_WORK(&nn->laundromat_work, laundromat_main);
> +	/* Make sure this cannot run until client tracking is initialised */
> +	disable_delayed_work(&nn->laundromat_work);
>  	INIT_WORK(&nn->nfsd_shrinker_work, nfsd4_state_shrinker_worker);
>  	get_net(net);
>  
> @@ -9077,9 +9078,7 @@ nfs4_state_start_net(struct net *net)
>  	locks_start_grace(net, &nn->nfsd4_manager);
>  	nfsd4_client_tracking_init(net);
>  	/* safe for laundromat to run now */
> -	spin_lock(&nn->client_lock);
> -	nn->client_tracking_active = true;
> -	spin_unlock(&nn->client_lock);
> +	enable_delayed_work(&nn->laundromat_work);
>  	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size == 0)
>  		goto skip_grace;
>  	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
> @@ -9128,10 +9127,7 @@ nfs4_state_shutdown_net(struct net *net)
>  
>  	shrinker_free(nn->nfsd_client_shrinker);
>  	cancel_work_sync(&nn->nfsd_shrinker_work);
> -	spin_lock(&nn->client_lock);
> -	nn->client_tracking_active = false;
> -	spin_unlock(&nn->client_lock);
> -	cancel_delayed_work_sync(&nn->laundromat_work);
> +	disable_delayed_work_sync(&nn->laundromat_work);
>  	locks_end_grace(&nn->nfsd4_manager);
>  
>  	INIT_LIST_HEAD(&reaplist);
> -- 
> 2.53.0
> 
> 

This series breaks the build :(
