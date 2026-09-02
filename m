Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9E53264C2;
	Wed,  2 Sep 2026 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335671; cv=none; b=nkaEInAlAygLAQ2nHPT9QHoW906eEJi8pCnPNukCfdTRvC/iwb9fSvw+i1UXOS90PoX5A43zEQga2dIZhsXyN35TtGWOXeFDGACFgeG4AHuFbS8V29LITIkFl8T/evPAb4tnruanHIcgYRt8Mv3vF/OAA4SYnGWIGBW29P4C5EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335671; c=relaxed/simple;
	bh=+6iRtT479x+Rui+/ke/RcjzBYNlpdLx0w0ValInX0/k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QTTxrAGUXbix5N/Omd62Jx3Gdww/1yAW/+a8JMkE3gW5h+NvjPBKvK3o5JWsfBASXvJviMaUIE3zSZmV/lBolnRAZoYKpcPZwBtRaudO5f7QVVGwLWnrrDrBenlAX4zFgCA8MPGbDr4BJVotMgfklPlH0Zad+UUEV6gjhZFsXLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0u/+gyB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0u/+gyB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EDF81F000E9;
	Wed,  2 Sep 2026 07:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788335669;
	bh=W/NCmJbP7+6fQziptMjAVLT3yF8rXVSjHoR3kv4O6h8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=U0u/+gyB8DPDHQkXsjldsEyAEQd2s3iKW7WWxntckMTpJA2wO1liM4zm5lo9utn/f
	 jOEPejtSqt2rwUyhS6qCIuSSugKpcPjTQ7B9SRIPolPsvu1GY/CxCgBhNiHK1pG/Hy
	 DPGf7uB5eFBHDoZFTSv8CjVolJfFoVz/HkkE+3VpJ22RNRzGQl8EQtAEPMxpujVdjX
	 F6eRX2/KN/2AjoZBA0uj4TZPYzRA4c8/noH7B6BPkMRqSan8pMxRClneZZL4aiu/Er
	 WEpgEPyXi1yfcN6+nSBlmPNYFu5L46gPCNZaA3vSZKm7eil2LwW4RfMboQjQzj+rrl
	 M6paYiu6i2KaQ==
Message-ID: <1c07afb0-337b-4dec-a6fe-b4bd40e4bdfa@kernel.org>
Date: Wed, 2 Sep 2026 15:54:26 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>,
 stable@vger.kernel.org, Wenjie Qi <qiwenjie@xiaomi.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: drop pending discard commands before
 reserving device alias
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260901201740.4040807-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260901201740.4040807-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/2/26 04:17, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> When reserving a device alias via f2fs_ioc_reserve_dev_alias(),
> f2fs_reserve_device_alias() bulk-marks all blocks in the target device
> range as valid in SIT.
> 
> However, if the device was previously in the released state, stale
> pending discard commands covering that range may still exist in dcc->root.
> When f2fs_issue_discard_thread later processes those commands,
> __check_sit_bitmap() detects valid blocks in the discard range and
> triggers a kernel BUG().
> 
> To fix this:
> 1. Introduce f2fs_drop_discard_cmd_range() to traverse the discard rbtree,
>    drop all pending D_PREP discard commands in the range,
>    and wait for any in-flight discard bios under dcc->cmd_lock.
> 2. Call f2fs_drop_discard_cmd_range() in f2fs_ioc_reserve_dev_alias()
>    before f2fs_reserve_device_alias().
> 
> Reported-by: Wenjie Qi <qiwenjie@xiaomi.com>
> Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
> v3: introduce cur to prevent 32-bit overflow.
> v2: fix use-after-free and 32-bit overflow issues.
> ---
>  fs/f2fs/f2fs.h    |  2 ++
>  fs/f2fs/file.c    |  1 +
>  fs/f2fs/segment.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 48 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 511286432483..ae109d3ae571 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -4122,6 +4122,8 @@ void f2fs_reserve_device_alias(struct f2fs_sb_info *sbi, block_t addr,
>  bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
>  int f2fs_start_discard_thread(struct f2fs_sb_info *sbi);
>  void f2fs_drop_discard_cmd(struct f2fs_sb_info *sbi);
> +void f2fs_drop_discard_cmd_range(struct f2fs_sb_info *sbi,
> +					block_t start, block_t len);
>  void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi);
>  bool f2fs_issue_discard_timeout(struct f2fs_sb_info *sbi, bool need_check);
>  void f2fs_clear_prefree_segments(struct f2fs_sb_info *sbi,
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 29cf82d02c77..0b2d173d9597 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -3855,6 +3855,7 @@ static int f2fs_ioc_reserve_dev_alias(struct file *filp)
>  	write_unlock(&et->lock);
>  	clear_inode_flag(inode, FI_NO_EXTENT);
>  
> +	f2fs_drop_discard_cmd_range(sbi, ei.blk, ei.len);
>  	f2fs_reserve_device_alias(sbi, ei.blk, ei.len);
>  
>  	i_size_write(inode, (loff_t)ei.len << sbi->log_blocksize);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index ac0ed8609c1f..6826cb7ab34d 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1873,6 +1873,51 @@ static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
>  	return discard_blks;
>  }
>  
> +void f2fs_drop_discard_cmd_range(struct f2fs_sb_info *sbi,
> +					block_t start, block_t len)
> +{
> +	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
> +	struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
> +	struct rb_node **insert_p = NULL, *insert_parent = NULL;
> +	struct discard_cmd *dc, *wait_dc;
> +	u64 cur = start;
> +	u64 end = (u64)start + len;
> +
> +	if (!f2fs_realtime_discard_enable(sbi))
> +		return;
> +
> +next:
> +	wait_dc = NULL;
> +
> +	mutex_lock(&dcc->cmd_lock);
> +	while (cur < end) {
> +		dc = __lookup_discard_cmd_ret(&dcc->root, cur,
> +				&prev_dc, &next_dc, &insert_p, &insert_parent);
> +		if (!dc)
> +			dc = next_dc;
> +
> +		if (!dc || (u64)dc->di.lstart >= end)
> +			break;
> +
> +		if (dc->state == D_PREP) {
> +			cur = (u64)dc->di.lstart + dc->di.len;
> +			__remove_discard_cmd(sbi, dc);
> +			continue;

Any chance to limit the loop count to avoid holding cmd_lock lock for
long time, in case we encounter an extreme fragment scenario, e.g. in
2gb range, there will be 256k small discards at most?

Thanks,

> +		}
> +
> +		dc->ref++;
> +		cur = (u64)dc->di.lstart + dc->di.len;
> +		wait_dc = dc;
> +		break;
> +	}
> +	mutex_unlock(&dcc->cmd_lock);
> +
> +	if (wait_dc) {
> +		__wait_one_discard_bio(sbi, wait_dc);
> +		goto next;
> +	}
> +}
> +
>  /* This should be covered by global mutex, &sit_i->sentry_lock */
>  static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
>  {

