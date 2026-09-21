Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B284DF4DC;
	Mon, 21 Sep 2026 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790009530; cv=none; b=PM1kvk/9PTFKS8An4TOsVNpyvIofdaHFyE1Fg+5DQ1KnlEnmRK87/DQulYWPnflMnPjDhq2YU28gDDjssWc71yByIpIIyCA2pflrmdyczDo064fNp1VlbN4R4NskNwj2E8NdeOgjOsy5imL/C+nTxPukzoZYMPSQdN9or6Z3VRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790009530; c=relaxed/simple;
	bh=AATHp7deUCWcwH5lHNkmFOR+IuafxS0XxzQYwEOHKyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fLb0CJZnKBeXWUuC2+f6YPqcb+oRVIqdbI7wVgjs0S8+wft2WDCtkllwtOr0KB/i1sP/9OeAW3+5jV5fbihGrYLlMmQkdqGOf+U1S8F5Wiv8a8UmqBzfYjILf53HYicIQFaoiet87IT94iXPLP/cZvR1Srcwg+peLN5bRlTXlA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jgypbrc/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jgypbrc/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D881F000FF;
	Mon, 21 Sep 2026 16:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790009529;
	bh=CYjSYVRuUZeh6x6H9bY3TnL7LmKRvQQGc31KUTEZw1E=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
	b=jgypbrc/AQ1B8n50Ksn199fxeyIqHkjVEtO/PLpwpExs8H60hRL6gIk9Asf6iaOHF
	 g2W3CscjwY9/nLQjE5LniHBNpEYp6CTKz+d2odc3cwMFI9PN6B8+Cs7dmlLf/h9hPg
	 1WYE5xa7sByNHh2TfrJL8Wh9d6V9kwWmVYBV4uiDgK8X+rDh9WZql5qD+YpZ/nREgq
	 KMFkCsJH3C5p1OZoc4eIwBts8496Nmfw82T5Z//FSGjr+P11RiOxkh0jWCwZSIlX4m
	 ld+EtxYRoaH///pPPJkATf2gDssI66lA7gpYRQg1NpDA6xuXidxkuXePh2u2fAt64b
	 ssvy0eo+SPN0A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id C22C4CE0E8C; Mon, 21 Sep 2026 09:52:08 -0700 (PDT)
Date: Mon, 21 Sep 2026 09:52:08 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH] dcache: report a Tasks-RCU quiescent state in
 dentry_kill()
Message-ID: <a388f09f-153c-4175-a8cd-f54e70262da8@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20260918-dcache-task-rcu-qa-v1-1-963ec83e6d0b@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918-dcache-task-rcu-qa-v1-1-963ec83e6d0b@debian.org>

On Fri, Sep 18, 2026 at 04:01:57AM -0700, Breno Leitao wrote:
> I am constantly seeing the following warning on Meta's fleet:
> 
>   INFO: rcu_tasks detected stalls on tasks:
>     native_queued_spin_lock_slowpath
>     locked_inode_to_wb_and_lock_list
>     inode_io_list_del
>     evict
>     __dentry_kill
>     shrink_dentry_list
>     shrink_dcache_tree
>     d_invalidate
>     btrfs_delete_subvolume
>     btrfs_ioctl_snap_destroy
>     btrfs_ioctl
>     do_syscall_64
> 
> dentry_kill() is the common funnel for dentry teardown: dput(),
> shrink_dentry_list() and shrink_dcache_tree() all reach it, once per
> dentry, and its cond_resched() is the only reschedule point on that path.
> 
> cond_resched() is not an RCU-tasks quiescent state.
> 
> Use cond_resched_tasks_rcu_qs() so the teardown reports an RCU-tasks
> quiescent state as it proceeds.
> 
> Fixes: 9c5f1d30199d ("dcache: move cond_resched() into the end of __dentry_kill()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  fs/dcache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/dcache.c b/fs/dcache.c
> index 1b1a81f10da67..b89c8480b655b 100644
> --- a/fs/dcache.c
> +++ b/fs/dcache.c
> @@ -830,7 +830,7 @@ static struct dentry *dentry_kill(struct dentry *dentry)
>  	if (dentry->d_op && dentry->d_op->d_release)
>  		dentry->d_op->d_release(dentry);
>  
> -	cond_resched();
> +	cond_resched_tasks_rcu_qs();
>  	/* now that it's negative, ->d_parent is stable */
>  	if (!IS_ROOT(dentry)) {
>  		parent = dentry->d_parent;
> 
> ---
> base-commit: 5dd1818b15d98d4a20806cd00b1b40320b06004f
> change-id: 20260918-dcache-task-rcu-qa-b4bcb13f1524
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 
