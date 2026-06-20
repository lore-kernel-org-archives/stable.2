Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1341A267;
	Sat, 20 Jun 2026 07:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781942231; cv=none; b=c1+af5VOqaeIVIC5cOFILMKF4mK9c049b3pGuqR6ETZy0qY6WSIWfmbnEY24pb6hwK7cGinLpjENyunNeYVzAaNfw4WjP8Spo+vX8llVk+C5+l9Trqco4mWauZXn2nrw8T8LHL7tgRV8WeVrY1ZJK7jmAHxB/iBtDyFwA54337s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781942231; c=relaxed/simple;
	bh=11VbcpyZQLk+vve7euwQHVRlQ2xXptGzPlCebIy+PYs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ss4/Wxx0tcG+tKmOcf0o5wvCfYisLQBY0914yXHVFXeU/XYcxwOGZsH5PobsPXBF3r7eudWpAbDPTPYLaEtGE/p8M0CweIBqqCayLV8Xon31f7/XpxOXk3GapsbS25E58SRQvrB2YDO98iKEsMLTMUSqYm9AvnatGN5ClueLEIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJuPVECq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJuPVECq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FB11F000E9;
	Sat, 20 Jun 2026 07:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781942229;
	bh=gHo00aZGG9TlBjDkx/VKiOqBtFoIJs+Yb9ZY2yZ5UZI=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=IJuPVECqtlSg9Dy6GKD129q8dm0hdzyH7acwAC9w66Aw0rFp6cxP/6X8y5p6sWTUt
	 Wj/Ak3CMQC33ejZbG7HmJ4+sSxtjMOi0uI0H6srqdzCU/qaE4JtlT+snf4OgXlaHZL
	 vLdkS5k8S2ppCQ7XrD9ltBfKLm3gZy81FZDHwlAz5DI/lcwriCM/DLfLlEI3T7kTP/
	 miyqr4DOR75mVB8LSgGCVs3KaylwUqdzNY6/48/LfK276CXmNwxC6TWQ0v8kts+enP
	 q533yBTSi8u9NEq1iC5cwEMGGs952hk70vPBU32f6ZF9aYUtq9tTOSPXQBZpU3sj84
	 49a5eoeLabNUQ==
Message-ID: <4354654f-3aca-40a8-bc88-23e540ee5aec@kernel.org>
Date: Sat, 20 Jun 2026 15:57:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, geoo115@gmail.com, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 qiwenjie@xiaomi.com
Subject: Re: [PATCH v7] f2fs: use post-decrement count for cp_wait wakeup
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260618100503.2601790-1-qiwenjie@xiaomi.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260618100503.2601790-1-qiwenjie@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/18/26 18:05, Wenjie Qi wrote:
> f2fs_write_end_io() decrements the writeback page counter and then reads
> it again with get_pages() to decide whether the last F2FS_WB_CP_DATA
> completion should wake cp_wait.
> 
> That second read can miss the zero transition as below:

Looks comments of v7 patch is quite different from the one of v1 patch?

Quoted from v1:

"f2fs_write_end_io() currently decrements the writeback page counter before
waking sbi->cp_wait for the last F2FS_WB_CP_DATA completion.

That decrement can drop the F2FS_WB_CP_DATA count to zero. It can unblock
a concurrent unmount path waiting in f2fs_wait_on_all_pages(). Unmount can
continue through f2fs_put_super() and eventually free sbi while the end_io
callback is still about to evaluate wq_has_sleeper() and wake_up() on
sbi->cp_wait.

Commit 2d9c4a4ed4ee ("f2fs: fix UAF caused by decrementing sbi->nr_pages[]
in f2fs_write_end_io()") fixed one post-decrement sbi access by moving the
warm-node-list handling before dec_page_count(). The compressed writeback
path follows the same rule and documents that dec_page_count() must be the
last access to sbi when it can drop F2FS_WB_CP_DATA to zero.

Apply the same ordering rule to the cp_wait wakeup. Check whether this is
the last F2FS_WB_CP_DATA completion and wake the waiter before the counter
decrement. Then the callback no longer dereferences sbi->cp_wait after the
lifetime boundary. A waiter that runs before the decrement may observe old
count and sleep until the one-jiffy timeout, but correctness no longer
depends on touching sbi after the counter reaches zero."

I may found something interesting: v7 codes try to fix UAF bug described in
v1 comment, however v7 comment tries to explain what v2 codes want to do.

I suspect your LLM goes another direction after prompted w/ my comments on
patch v1? Let me know I'm wrong. :P

Thanks,

> 
> checkpoint          end_io A              submitter B
> - f2fs_wait_on_all_pages
>   - get_pages() > 0
>   - prepare_to_wait(cp_wait)
>   - io_schedule_timeout
>                      - f2fs_write_end_io
>                       - dec_page_count
>                        : count 1 -> 0
>                                           - f2fs_submit_page_write
>                                            - inc_page_count
>                                             : count 0 -> 1
>                       - get_pages() > 0
>                         : skip wake_up(cp_wait)
> 
> The checkpoint thread can then keep sleeping until
> DEFAULT_SCHEDULE_TIMEOUT, even though end_io A completed the old last
> F2FS_WB_CP_DATA page.
> 
> Use the post-decrement value for F2FS_WB_CP_DATA completions so the wakeup
> decision is tied to this completion.  Keep the existing dec_page_count()
> path for other writeback counters.
> 
> Fixes: e234088758fc ("f2fs: avoid wait if IO end up when do_checkpoint for better performance")
> Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
>   fs/f2fs/data.c | 12 +++++++-----
>   fs/f2fs/f2fs.h |  6 ++++++
>   2 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index d83a21998ec2..2afdcd209d54 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -392,15 +392,17 @@ static void f2fs_write_end_io(struct bio *bio)
>   		if (f2fs_in_warm_node_list(folio))
>   			f2fs_del_fsync_node_entry(sbi, folio);
>   
> -		dec_page_count(sbi, type);
> -
>   		/*
>   		 * we should access sbi before folio_end_writeback() to
>   		 * avoid racing w/ kill_f2fs_super()
>   		 */
> -		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
> -				wq_has_sleeper(&sbi->cp_wait))
> -			wake_up(&sbi->cp_wait);
> +		if (type == F2FS_WB_CP_DATA) {
> +			if (!dec_page_count_return(sbi, type) &&
> +			    wq_has_sleeper(&sbi->cp_wait))
> +				wake_up(&sbi->cp_wait);
> +		} else {
> +			dec_page_count(sbi, type);
> +		}
>   
>   		folio_clear_f2fs_gcing(folio);
>   		folio_end_writeback(folio);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 9f24287de4c3..db750cef371d 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2776,6 +2776,12 @@ static inline void dec_page_count(struct f2fs_sb_info *sbi, int count_type)
>   	atomic_dec(&sbi->nr_pages[count_type]);
>   }
>   
> +static inline int dec_page_count_return(struct f2fs_sb_info *sbi,
> +					int count_type)
> +{
> +	return atomic_dec_return(&sbi->nr_pages[count_type]);
> +}
> +
>   static inline void inode_dec_dirty_pages(struct inode *inode)
>   {
>   	if (!S_ISDIR(inode->i_mode) && !S_ISREG(inode->i_mode) &&
> 
> base-commit: c0b65f6129c7fbb526e921dd60261650f1b2bef9

