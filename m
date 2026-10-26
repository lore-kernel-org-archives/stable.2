Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008807;
	b=XT/yHqYFNtB0eblqutp8v6Gqu2GqrOI/dqZYG8tWLbKqP6EpefkM3jgVNMCGhEZ0Rwyf
	 io3AqMrd8wncwaON9eA8vbMaVcZIz9/25NRHt1VAQag3DqjFj6y2AyyE0ViFeHB8xRQn+
	 HCIpCY+2AKkKE2dN2qoWUhL1/WMD1vZY/EwQ8P8CsFQDUr9ESMGf/B1o5gLLvONZ7AQ6B
	 vASAySKU8vTGDcAoWX/NFlWOe04jPCBT11UmTacksZAXnzMP6xr+dFC9dBFFlCYC/rVk4
	 BFIiN9mpXuonE9PA1kEmOWy0dz+HZGV1YohBfLr5+m3tvvH7+o/zgrbG2f6tcDnHY7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008807;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=F/pa/uFhSJPFHIEewk36wTKJdJWq4rFHLThxtYs5ePs=;
	b=Nx0jLcGNNGjfEJ8RLn/n8BKkZ/Qw4kL6WSdBcwcHv5zkV8x88z43NETpzn16hdeFcG9p
	 rJVHrUXtjhgWT40xHVg/768Dk7Rds3aXKbPRdrW0jze//i4TbzlkLAN5HRDZIWMF8WoY0
	 exrg9XcQJQlnyowDr5hxE7vClz3xWmhl1aqyggjcJzWRb+L7MS9KeDGToLFT6I3Q4YnHN
	 6aWjH7Wtbjxb9SXDy9JbP1AX7ftUOsMnw3Z2mM7TQ8meeaQuAF5gatZiQ7loovKm62Xvk
	 qFrWPznWvj1GycOrLuLr0vZFYM/zvrNY1QDmV2StoD/d8un1sPqENESnU8unnGkDiOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dwlM3Jda;
	arc=none smtp.remote-ip=115.124.30.111
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6634606B454;
	Mon, 26 Oct 2026 10:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6634606B454
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dwlM3Jda
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793008802; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=F/pa/uFhSJPFHIEewk36wTKJdJWq4rFHLThxtYs5ePs=;
	b=dwlM3JdaG5OIPj4Hpwv6O+JHHTOsMIur4AduK7yfy1WQtq1WlssMpBZ5KPIcbYRGK5R55/izikwaCtLpgnIuI8lQL9f1TE4LBmScw+3iSCX5mqBiJKDafwC+KvB29VhQsgTcT7+EmuneBwXusMiwx/ZH/K9JdowyBgALjAu4Tmc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XDW4SKg_1793008801;
Received: from 30.221.130.82(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0XDW4SKg_1793008801 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 18:00:01 +0800
Message-ID: <87a005a4-c61f-4525-a0d1-89bfc6a8f75d@linux.alibaba.com>
Date: Mon, 26 Oct 2026 17:59:59 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ocfs2: validate move extents against a stable EOF
To: Cen Zhang <zzzccc427@gmail.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, heming.zhao@suse.com,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
References: <pm-ocfs2-move-extents-isize-rrw-v4-d4b80ed0748f84dc3f8e@gmail.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <pm-ocfs2-move-extents-isize-rrw-v4-d4b80ed0748f84dc3f8e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/26 12:20 AM, Cen Zhang wrote:
> The move-extents range must be bounded by the inode size used for extent
> movement. ocfs2_ioctl_move_extents() checks and clamps the request before
> taking the local inode and cluster locks in ocfs2_move_extents(). It also
> uses separate i_size_read() calls for the range check and subtraction.
> 
> A concurrent truncate can invalidate the first check and make the later
> unsigned subtraction underflow:
> 
>   Move-extents ioctl                  Truncate
>   ------------------                  --------
>   check me_start <= i_size
>                                       take inode and cluster locks
>                                       shrink EOF below me_start
>                                       release locks
>   compare me_start + me_len with EOF
>   set me_len = EOF - me_start
>     [unsigned underflow]
>   acquire inode and cluster locks
>   select extents using the bad range
> 
> A truncate after clamping can also leave the range extending beyond EOF.
> Conversely, the cached size may be smaller than the size refreshed when
> the cluster inode lock is acquired. Early validation can then reject a
> valid start or permanently shorten the requested length and threshold.
> The me_start + me_len comparison can also wrap for a large input length.
> 
> Validate and adjust the original request once, after inode_lock(), the
> exclusive rw lock and ocfs2_inode_lock() have stabilized and refreshed
> the size. Read EOF once, reject a start beyond it, and bound the length
> by EOF minus start. Normalize the threshold using the same EOF snapshot.
> This keeps zero as the default-threshold sentinel until validation uses
> the size that will govern extent movement.
> 
> Move goal validation after range adjustment as well. Its allocation-group
> capacity check uses me_len and must see the EOF-clamped length. Both
> validation failures use the existing inode-lock unwind path before any
> extent movement or transaction starts.
> 
> Fixes: 53069d4e7695 ("Ocfs2/move_extents: move/defrag extents within a certain range.")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
> Changes in v2:
> - Validate and normalize the original range only once, after inode and
>   cluster locking have stabilized and refreshed EOF.
> - Move goal validation after range adjustment because its allocation-group
>   capacity check depends on me_len.
> 
> Link to v1: https://lore.kernel.org/r/pm-ocfs2-move-extents-isize-rrw-v3-b2a7508c41108cc2d00b@gmail.com
> 
>  fs/ocfs2/move_extents.c | 68 ++++++++++++++++++++++-------------------
>  1 file changed, 37 insertions(+), 31 deletions(-)
> 
> diff --git a/fs/ocfs2/move_extents.c b/fs/ocfs2/move_extents.c
> index ad1678ee7cc4..f2682ef6bf2b 100644
> --- a/fs/ocfs2/move_extents.c
> +++ b/fs/ocfs2/move_extents.c
> @@ -907,6 +907,30 @@ out:
>  	return ret;
>  }
>  
> +static int ocfs2_validate_and_adjust_move_range(struct inode *inode,
> +						struct ocfs2_move_extents *range)
> +{
> +	u64 i_size = i_size_read(inode);
> +
> +	if (range->me_start > i_size)
> +		return -EINVAL;
> +
> +	if (range->me_len > i_size - range->me_start)
> +		range->me_len = i_size - range->me_start;
> +
> +	/*
> +	 * The default threshold for defragmentation is 1 MiB, which
> +	 * matches the maximum OCFS2 cluster size.
> +	 */
> +	if (!range->me_threshold)
> +		range->me_threshold = 1024 * 1024;
> +
> +	if (range->me_threshold > i_size)
> +		range->me_threshold = i_size;
> +
> +	return 0;
> +}
> +
>  static int ocfs2_move_extents(struct ocfs2_move_extents_context *context)
>  {
>  	int status;
> @@ -936,6 +960,19 @@ static int ocfs2_move_extents(struct ocfs2_move_extents_context *context)
>  		goto out_rw_unlock;
>  	}
>  
> +	status = ocfs2_validate_and_adjust_move_range(inode, context->range);
> +	if (status) {
> +		mlog_errno(status);
> +		goto out_inode_unlock;
> +	}
> +
> +	/* The goal check depends on the adjusted range length. */
> +	if (!context->auto_defrag) {
> +		status = ocfs2_validate_and_adjust_move_goal(inode, context->range);
> +		if (status)
> +			goto out_inode_unlock;

Seems we'd better log the failure like ocfs2_validate_and_adjust_move_range().

> +	}
> +
>  	/*
>  	 * remember ip_xattr_sem also needs to be held if necessary
>  	 */
> @@ -1028,27 +1065,8 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
>  		goto out_free;
>  	}
>  
> -	if (range.me_start > i_size_read(inode)) {
> -		status = -EINVAL;
> -		goto out_free;
> -	}

This seems changes the return value. It returned -EINVAL without touching
the caller's buffer. It now unwinds through out_inode_unlock and falls into
the copy back and returns -EFAULT instead of -EINVAL.

Seems not a bug since the goal validation failure already behaved this way,
but worth a line in the commit log.

Thanks,
Joseph

> -
> -	if (range.me_start + range.me_len > i_size_read(inode))
> -			range.me_len = i_size_read(inode) - range.me_start;
> -
>  	context->range = &range;
>  
> -	/*
> -	 * ok, the default threshold for the defragmentation
> -	 * is 1M, since our maximum clustersize was 1M also.
> -	 * any thought?
> -	 */
> -	if (!range.me_threshold)
> -		range.me_threshold = 1024 * 1024;
> -
> -	if (range.me_threshold > i_size_read(inode))
> -		range.me_threshold = i_size_read(inode);
> -
>  	if (range.me_flags & ~(OCFS2_MOVE_EXT_FL_AUTO_DEFRAG |
>  			       OCFS2_MOVE_EXT_FL_PART_DEFRAG)) {
>  		status = -EINVAL;
> @@ -1060,23 +1078,11 @@ int ocfs2_ioctl_move_extents(struct file *filp, void __user *argp)
>  
>  		if (range.me_flags & OCFS2_MOVE_EXT_FL_PART_DEFRAG)
>  			context->partial = 1;
> -	} else {
> -		/*
> -		 * first best-effort attempt to validate and adjust the goal
> -		 * (physical address in block), while it can't guarantee later
> -		 * operation can succeed all the time since global_bitmap may
> -		 * change a bit over time.
> -		 */
> -
> -		status = ocfs2_validate_and_adjust_move_goal(inode, &range);
> -		if (status)
> -			goto out_copy;
>  	}
>  
>  	status = ocfs2_move_extents(context);
>  	if (status)
>  		mlog_errno(status);
> -out_copy:
>  	/*
>  	 * movement/defragmentation may end up being partially completed,
>  	 * that's the reason why we need to return userspace the finished

