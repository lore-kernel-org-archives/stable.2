Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C521E4D9F92
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789644750; cv=none; b=c/Vm2J2TDhQ6lL6azqos/EPMMxb7bc2TDEqLgP6ThaAeghBX2Eod7Rem0uNqXQQt9F0eh/Tw+g1qB+cN4eKMLqtEOqa33Ddyq7xhoxu6Vi98mkrmQABemF4bCd43ymGsAxkPdGWtcaz/sO6T9H43j37QgdsHkerjvb1OOz1MXY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789644750; c=relaxed/simple;
	bh=kYblj5F1UET2WnrQaw/UMql0/5doJsJnkHI1E9t0e2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M951NHeVDURj3RB/zH7DIZ1LpK2v2orGoECUc5hDwsdgEJCgY5N0jWYh9ooR36kmVwAZ2F/TaY83dVVJB8QB0ERzSQewys7NOIjNJ3za6K8l2fN38XYaIwgCP0xC+Keiyleski9svvzYNwgXU35SXptR5pRjSfknYU+FAJHvE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=rWgOseaQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XnMOY/4P; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="rWgOseaQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XnMOY/4P"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC04C7A005A;
	Thu, 17 Sep 2026 07:32:27 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 17 Sep 2026 07:32:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789644747; x=1789731147; bh=PZIQyWm8LI
	r9gCznxePFakQGC32BKZ5dRs6LL1GRdNk=; b=rWgOseaQLabtzovdGVKWBSy+ni
	NEPVmQyp4sX/Rbhe2FmIrFTe32UL0k+4t8zSiV6+hXYrBU/sVBR2Ye+wll7GyEvZ
	SVe+gdXVE2rEKtO3e/6lSsQrv6vTMrKoJo4ZDCU1bfwHUxvJ9PdI5CtgXdFGQhLe
	bqHbzs/iBbXJRViJ9RsjAvUTUQtHGRPGJCHCw+9pzTWINAB7sttFvnV29lhJ9zUu
	No0tKQiBkYaegqcsavvpsvWRxSG0+7PvqKMF1mQqa4CwvujmAVTzhZCvPaQ7ki0z
	Jjpge08tFl5oKllp6HLFTw2dmDp755k2cNQT8ZIlM0i9K5oCx8PFtZnuE0Vw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789644747; x=1789731147; bh=PZIQyWm8LIr9gCznxePFakQGC32BKZ5dRs6
	LL1GRdNk=; b=XnMOY/4P5DsOTX6I44Jtu0klEIJCJ6FBs0eBjjkpni/HNdP4Uwa
	0fFdL3SHusmDCyANcf/LoQy3xRx4Brkb52ge1vulhdzw8JwXJlykBk7k9hy+p1wr
	ZAliVPlhdELJghbraivDahcJPsoRuEwUPoq7eCdCjD4rotPt9xAsE4h4dMhiABOd
	TaUXBSKM/kFn1LdB/SnoyKAQQQCuZptRnFbSrvPiJ2T0FFtJn2GOC1Ieqzm4rtvl
	9ynXFIg++1PJGin8GBf+WJJrFJ4C6wHxu7DVMsc09dImWTZ2ud0ZCIcohKkSgLZ+
	pMolNUL3QmenZbG5cFZqx0Y/KmNrwqs5ypg==
X-ME-Sender: <xms:y8-rah3opLjdhsr--TmfRfk6qbvr--iBrihP6xK3_0E4anJSpS1GBg>
    <xme:y8-raiEAZlx_NnQBcf503zJoYB68X28jFtnnheKOIBfYGv4cbhfN62DWAB76tllyY
    caev84QlTnOGhnqqiqbzLqmQ4vKdn6BQvnYpAytd_npOeUzXAc>
X-ME-Received: <xmr:y8-raohCNuAcMUo0-Jno6VeazTvCriCXfZF5fp2GStTdCtFsXI-C0TipOluZ>
X-ME-Proxy-Cause: dmFkZTEf/k++HHOoLTSlHfrIgeaAPB7UHXbfAvfQcRqWtppGIDskVfYBuxqUHuEaOUKGTW
    Up+YCr9SUps8z1SsdXSb9FN4yrzCgUgNdsDVO8T+9VQcn26vS9KHWveGl+kPXeFXKIS57F
    UGJttETG+MqK6Dt3m8+LUdnx8hgv0fLMfIn0MLwG6LhyMft/V8yG6jfiqRn7O4B8pt+1hj
    zYPhu95OFNnX0Bj0eSszQdCrgPbWZEl1sUcDqnumICKHDRjXiRCug8WOJzewlL+Do8AvBq
    CajbGZ9XX1ur9ZQ8hp7pqec/kRdijikURUqlaDNWm75k8bX0wFVNCcF6OR5S/kgz9rqfbT
    janCe8k5jFro6biWHymd18C2lN9DTGuNdLE1dWuAtT3cdzzXyXyM+046R6fD+PPq4BSveH
    qI6sbM7iV7HHB4HeDk6MwZSynh3mFjrofRgzTzOyu0lXVCkGiIg+ucob3sfM9B+Vfp5eez
    9aQ4BpwJ8JOM0IUpUtixePqgh5JHG0pNCOeGUfH3kGsEnTNGPDtYFEMUiJviSbRoQhvJsy
    oPbAh0TimnQOLIz2TFIAA2KU4LfP6VxjXUsjs7TvjCOvCqaVvLCyPn33BJ36TmRCDMWJM/
    sq0FQb3wO5GLc8Tr+/zJIQh2ieXeUAahC9spvunsAYc/fSPDzLpnSy15/+kg
X-ME-Proxy: <xmx:y8-ratCB-FzoM0twfDjKj2ACSJD-TyJoCKbXtzp3vM2g0LBCuLgF9A>
    <xmx:y8-raiR282j4DSc9vXdl3JgMFl96ajbV6VGFHrD-PdW0gFl7Ze7UMw>
    <xmx:y8-raqWFsb_NoUDKp7orNEecn1J72QiZmrZTPt8tbaLFZ7GjPobC5A>
    <xmx:y8-rajf64e0qKDKJjBDKilA4spk0rRUSP78H32l2xw704j4NWzyQ1w>
    <xmx:y8-rartbNGsOo39Bn8LopuxfmfXEIghxLZFxdukZ6WAU-JuItsYCj4hZ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 07:32:26 -0400 (EDT)
Date: Thu, 17 Sep 2026 12:29:02 +0100
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH 6.12.y] nfsd: fix fcache_disposal UAF by inlining dispose
 state into nfsd_net
Message-ID: <2026091759-rewash-denture-6121@gregkh>
References: <2026090339-quarry-bottom-b4e0@gregkh>
 <20260905144718.272869-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905144718.272869-1-sashal@kernel.org>

On Sat, Sep 05, 2026 at 10:47:18AM -0400, Sasha Levin wrote:
> From: Jeff Layton <jlayton@kernel.org>
> 
> [ Upstream commit bbf13732f74351d21c5e0e8dd9bd8e1c48dc35d4 ]
> 
> nfsd_file_dispose_list_delayed() defers fput() to nfsd service threads
> via a per-net freeme queue, preventing the shrinker and GC worker from
> bearing the cost of closing files (see ffb402596147).  However, the
> queue lives in a separately-allocated struct nfsd_fcache_disposal that
> is freed by nfsd_free_fcache_disposal_net() during per-net teardown.
> The global shrinker, laundrette, and fsnotify callbacks can still be
> inside nfsd_file_dispose_list_delayed() dereferencing that pointer,
> causing a use-after-free.
> 
> Inline the spinlock and freeme list directly into struct nfsd_net (as
> fcache_dispose_lock and fcache_dispose_list), eliminating the separately
> allocated struct nfsd_fcache_disposal entirely.  These fields now have
> the same lifetime as the net namespace itself, so there is no dangling
> pointer to chase.
> 
> nfsd_file_cache_start_net() now just initializes the inline fields and
> cannot fail due to allocation.  nfsd_file_cache_shutdown_net() drains
> the inline list directly instead of freeing a separate struct.  The
> alloc/free helpers are removed.
> 
> Fixes: 1463b38e7cf3 ("NFSD: simplify per-net file cache management")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> Link: https://patch.msgid.link/20260602-nfsd-testing-v2-7-e4ea62e3cd5c@kernel.org
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> [ adapted disposal-list references while retaining the older unguarded service wake-up flow and removing the legacy kmalloc()-based helper ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/nfsd/filecache.c | 77 +++++++++++++--------------------------------
>  fs/nfsd/netns.h     |  3 +-
>  2 files changed, 24 insertions(+), 56 deletions(-)
> 
> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
> index 05f0a4867673d..4381d76e83c63 100644
> --- a/fs/nfsd/filecache.c
> +++ b/fs/nfsd/filecache.c
> @@ -61,11 +61,6 @@ static DEFINE_PER_CPU(unsigned long, nfsd_file_releases);
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_total_age);
>  static DEFINE_PER_CPU(unsigned long, nfsd_file_evictions);
>  
> -struct nfsd_fcache_disposal {
> -	spinlock_t lock;
> -	struct list_head freeme;
> -};
> -
>  static struct kmem_cache		*nfsd_file_slab;
>  static struct kmem_cache		*nfsd_file_mark_slab;
>  static struct list_lru			nfsd_file_lru;
> @@ -431,25 +426,25 @@ nfsd_file_dispose_list(struct list_head *dispose)
>  }
>  
>  /**
> - * nfsd_file_dispose_list_delayed - move list of dead files to net's freeme list
> + * nfsd_file_dispose_list_delayed - queue dead files for nfsd thread disposal
>   * @dispose: list of nfsd_files to be disposed
>   *
> - * Transfers each file to the "freeme" list for its nfsd_net, to eventually
> - * be disposed of by the per-net garbage collector.
> + * Transfers each file to the dispose list in its nfsd_net and wakes an nfsd
> + * thread to do the actual close.  This keeps the cost of fput() in the nfsd
> + * threads rather than in the shrinker or GC worker.
>   */
>  static void
>  nfsd_file_dispose_list_delayed(struct list_head *dispose)
>  {
> -	while(!list_empty(dispose)) {
> +	while (!list_empty(dispose)) {
>  		struct nfsd_file *nf = list_first_entry(dispose,
>  						struct nfsd_file, nf_gc);
>  		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
> -		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
>  		struct svc_serv *serv;
>  
> -		spin_lock(&l->lock);
> -		list_move_tail(&nf->nf_gc, &l->freeme);
> -		spin_unlock(&l->lock);
> +		spin_lock(&nn->fcache_dispose_lock);
> +		list_move_tail(&nf->nf_gc, &nn->fcache_dispose_list);
> +		spin_unlock(&nn->fcache_dispose_lock);
>  
>  		/*
>  		 * The filecache laundrette is shut down after the
> @@ -473,17 +468,15 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
>   */
>  void nfsd_file_net_dispose(struct nfsd_net *nn)
>  {
> -	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
> -
> -	if (!list_empty(&l->freeme)) {
> +	if (!list_empty(&nn->fcache_dispose_list)) {
>  		LIST_HEAD(dispose);
>  		int i;
>  
> -		spin_lock(&l->lock);
> -		for (i = 0; i < 8 && !list_empty(&l->freeme); i++)
> -			list_move(l->freeme.next, &dispose);
> -		spin_unlock(&l->lock);
> -		if (!list_empty(&l->freeme))
> +		spin_lock(&nn->fcache_dispose_lock);
> +		for (i = 0; i < 8 && !list_empty(&nn->fcache_dispose_list); i++)
> +			list_move(nn->fcache_dispose_list.next, &dispose);
> +		spin_unlock(&nn->fcache_dispose_lock);
> +		if (!list_empty(&nn->fcache_dispose_list))
>  			/* Wake up another thread to share the work
>  			 * *before* doing any actual disposing.
>  			 */
> @@ -658,11 +651,11 @@ nfsd_file_queue_for_close(struct inode *inode, struct list_head *dispose)
>  }
>  
>  /**
> - * nfsd_file_close_inode - attempt a delayed close of a nfsd_file
> + * nfsd_file_close_inode - attempt a deferred close of a nfsd_file
>   * @inode: inode of the file to attempt to remove
>   *
>   * Close out any open nfsd_files that can be reaped for @inode. The
> - * actual freeing is deferred to the dispose_list_delayed infrastructure.
> + * actual freeing is deferred to the nfsd service threads.
>   *
>   * This is used by the fsnotify callbacks and setlease notifier.
>   */
> @@ -863,42 +856,14 @@ __nfsd_file_cache_purge(struct net *net)
>  	nfsd_file_dispose_list(&dispose);
>  }
>  
> -static struct nfsd_fcache_disposal *
> -nfsd_alloc_fcache_disposal(void)
> -{
> -	struct nfsd_fcache_disposal *l;
> -
> -	l = kmalloc(sizeof(*l), GFP_KERNEL);
> -	if (!l)
> -		return NULL;
> -	spin_lock_init(&l->lock);
> -	INIT_LIST_HEAD(&l->freeme);
> -	return l;
> -}
> -
> -static void
> -nfsd_free_fcache_disposal(struct nfsd_fcache_disposal *l)
> -{
> -	nfsd_file_dispose_list(&l->freeme);
> -	kfree(l);
> -}
> -
> -static void
> -nfsd_free_fcache_disposal_net(struct net *net)
> -{
> -	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> -	struct nfsd_fcache_disposal *l = nn->fcache_disposal;
> -
> -	nfsd_free_fcache_disposal(l);
> -}
> -
>  int
>  nfsd_file_cache_start_net(struct net *net)
>  {
>  	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
>  
> -	nn->fcache_disposal = nfsd_alloc_fcache_disposal();
> -	return nn->fcache_disposal ? 0 : -ENOMEM;
> +	spin_lock_init(&nn->fcache_dispose_lock);
> +	INIT_LIST_HEAD(&nn->fcache_dispose_list);
> +	return 0;
>  }
>  
>  /**
> @@ -917,8 +882,10 @@ nfsd_file_cache_purge(struct net *net)
>  void
>  nfsd_file_cache_shutdown_net(struct net *net)
>  {
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +
>  	nfsd_file_cache_purge(net);
> -	nfsd_free_fcache_disposal_net(net);
> +	nfsd_file_dispose_list(&nn->fcache_dispose_list);
>  }
>  
>  void
> diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
> index 09a06e46dab98..610d514d35312 100644
> --- a/fs/nfsd/netns.h
> +++ b/fs/nfsd/netns.h
> @@ -206,7 +206,8 @@ struct nfsd_net {
>  	/* utsname taken from the process that starts the server */
>  	char			nfsd_name[UNX_MAXNODENAME+1];
>  
> -	struct nfsd_fcache_disposal *fcache_disposal;
> +	spinlock_t		fcache_dispose_lock;
> +	struct list_head	fcache_dispose_list;
>  
>  	siphash_key_t		siphash_key;
>  
> -- 
> 2.53.0
> 
>

Does not apply
