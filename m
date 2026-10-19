Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5344F85AD;
	Mon, 19 Oct 2026 12:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414145; cv=none; b=o7nUoj+qc1Ctvc204lhqVAcMVR8iRKC2BAyCWuVQ/LEVD5zj4K/stKCNxZS7tsgXAwgAqfgnRN9B0Puil/hbC22IYkTSFkyScGPS8FwPUnPf+ZykmF+SocQaFzCvbKbv7mWQ9bL8S9S/ClSVwNTfrkeHHCQCOJxHOu001VDOUuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414145; c=relaxed/simple;
	bh=nSpM0j3+znkzFmIU9xoQSupcFMEyLp7bXuizXMaf/k0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sv3nSJ6Ujn2CnPeHgqjL+/Zg1oSDlGTfsHA+FkgQSbJUCeAsCqdCfzmXDw75bBhGvkgkM4iOEZh9AGc/3HDZHgGJ18/GcEWUuOaIWf7ys/VqFGa8/QEdsGzchY3X+RwNKxcLMMk1UZBTlJyWAVQLrvR6iju2bbs3eLYBdFwNnn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=5nPKjafy; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="5nPKjafy"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sQXqHgnR+1pIPsUZEl3zynhZARYK4/So3jnkyAxXf8g=;
	b=5nPKjafyrabzeYMbeC7CX7CvCEf/VurO0VfLru+paC6OxT8dAUxqnA/3sDANVSIoP4gpTLBEY
	ldxw8tzmZwGk51W8BfpHKFDJJD4RLHv1UV4A24RPMjZlgVQ/YUDwP77ggmhZAPfiuKNURMSWASF
	Xqc7BvH4tV0tVjx+5FQF5ZQ=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4j7b2Q3NYlzcb48;
	Mon, 19 Oct 2026 20:48:46 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id F367C203AB;
	Mon, 19 Oct 2026 20:48:52 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 19 Oct 2026 20:48:51 +0800
Subject: Re: [PATCH] fs: rotate inodes whose page cache could not be dropped
To: Nikolaos Karaolidis <nick@karaolidis.com>, Christian Brauner
	<brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
CC: Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261016102515.111285-1-nick@karaolidis.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <9ea0c46f-a2b2-b18b-6b69-ca035b005bbe@huawei.com>
Date: Mon, 19 Oct 2026 20:48:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261016102515.111285-1-nick@karaolidis.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemo200011.china.huawei.com (7.152.185.179)

ÔÚ 2026/10/16 18:25, Nikolaos Karaolidis Ð´µÀ:
> When inode_lru_isolate() drops the page cache of an unused inode, it
> has to unlock the list, so it returns LRU_RETRY and the walk restarts
> at the head of the list, where the inode still is. If
> invalidate_mapping_pages() could not empty the mapping, the restarted
> walk strips the same inode again, and so on until nr_to_walk runs out.
> Every walk of that list then ends on this inode, and nothing behind it
> is reclaimed for as long as its cache stays.
> 
> Before commit 2a0629834cd8 ("vfs: Don't evict inode under the inode lru
> traversing context") the walker pinned the inode with a reference, and
> dropping it in iput_final() set I_REFERENCED, so the restarted walk
> rotated the inode to the tail. Set I_REFERENCED again when the mapping
> is still populated after the invalidation, in the same i_lock section
> that clears I_LRU_ISOLATING. inode_unpin_lru_isolating() now expects
> i_lock to be held, like inode_pin_lru_isolating().
> 
> On CONFIG_HIGHMEM kernels this can happen to any unused inode: a folio
> is left behind if it is locked, under writeback, spliced into a pipe,
> or still in another CPU's LRU-add batch after being read. Without
> HIGHMEM it happens to DAX inodes whose only entry is at index 0, which
> mapping_shrinkable() lets onto the LRU and invalidate_mapping_pages()
> never removes.
> 
> Fixes: 2a0629834cd8 ("vfs: Don't evict inode under the inode lru traversing context")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Nikolaos Karaolidis <nick@karaolidis.com>
> ---
> 
> Found while working on reclaim of inodes pinned by page cache in
> ZONE_MOVABLE.
> 
> Tested in QEMU/KVM on master af32da41b032 (v7.3-rc6-232), with lockdep
> and KASAN enabled. A small init program makes one unused inode whose
> page can't be invalidated, lets it reach the head of the inode LRU,
> opens 2000 other files, does one "echo 2 > /proc/sys/vm/drop_caches"
> and counts the inodes left via umount; kprobes count the
> invalidate_mapping_pages() calls:
> 
>                                without patch           with patch
>    i386 HIGHMEM, file read     2000 of 2000 left,      none left,
>    on another CPU              10300 strips, 1 inode   4 strips
>    i386 HIGHMEM, page          same                    same
>    spliced into a pipe
>    x86_64, ext4 -o dax,        same                    same
>    file mmap()ed
>    controls (no leftover,      none left               none left
>    shadow entry at index 0)
> 
> 2a0629834cd8^ behaves like the patched kernel, 2a0629834cd8 like
> master. On 5.15.y x86_64, where every unused inode with page cache is
> on the LRU, the read-on-another-CPU case blocks the walk as well.
> 
> With "echo 64M > /sys/fs/cgroup/memory.reclaim" instead of
> drop_caches, the i386 pipe case does 262450 strips and frees nothing
> without the patch, 40 strips and frees everything with it. In the DAX
> case that write takes ~400ms with the patch instead of ~4ms:
> invalidate_mapping_pages() counts the DAX entry it leaves behind as
> reclaimed, so unpatched, the 64M are "reclaimed" by re-stripping one
> inode in a tight loop while nothing is freed.
> 
> The reproducer is a single C file; I can post it.
> 
> An LLM was used to check the analysis against the code, write the
> reproducer and draft the changelog; I have reviewed all of it.
> 
>   fs/inode.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/inode.c b/fs/inode.c
> index a9d37be390a1..1614a97ce953 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -593,12 +593,11 @@ static void inode_pin_lru_isolating(struct inode *inode)
>   
>   static void inode_unpin_lru_isolating(struct inode *inode)
>   {
> -	spin_lock(&inode->i_lock);
> +	lockdep_assert_held(&inode->i_lock);
>   	WARN_ON(!(inode_state_read(inode) & I_LRU_ISOLATING));
>   	inode_state_clear(inode, I_LRU_ISOLATING);
>   	/* Called with inode->i_lock which ensures memory ordering. */
>   	inode_wake_up_bit(inode, __I_LRU_ISOLATING);
> -	spin_unlock(&inode->i_lock);
>   }
>   
>   static void inode_wait_for_lru_isolating(struct inode *inode)
> @@ -981,7 +980,13 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>   		else
>   			__count_vm_events(PGINODESTEAL, reap);
>   		mm_account_reclaimed_pages(reap);
> +
> +		spin_lock(&inode->i_lock);
> +		/* The walk restarts here: don't retry leftovers right away */
> +		if (!mapping_empty(&inode->i_data))
> +			inode_state_set(inode, I_REFERENCED);
>   		inode_unpin_lru_isolating(inode);
> +		spin_unlock(&inode->i_lock);
>   		return LRU_RETRY;
>   	}
>   
> 
> base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
> 

