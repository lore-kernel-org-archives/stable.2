Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28483A5E65;
	Sat, 10 Oct 2026 03:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602280; cv=none; b=c0nN0U9nAf84znQ9N70of/91ZlGQ1S60q4L8Uh+qSpss0ThjTaYKwX5NM9g9vas9xMfpT/93l/2EV7ug7rmtJSOPFT1WzzqWIe/7MFgBBiQiKXN4W+6V90QBwdEt22gvPGmZY4gUQhbe8Ut8HSLlweP6LjOItucJ6K7c1ivixTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602280; c=relaxed/simple;
	bh=LDZdbw9sqXJMJMy9myDvRAtQwHq4XOgDSsFjCMlweio=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ACDyDdvipvfnP9Dd6jG7KmSB2Pi+4JmPkIA7RfmBLhkRmlutqPrjE5tiiDytVym7zAQ+hZtkHuFys5BVQz9OD1lPb4QyMuEmRPd3XolfjEkaW85rMVruvQmPPSX5JIltoPnPMZt0cmGEj1OCa4IvVQTCZ8f7j4M4bER9uF5qo0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gY0VFKM3; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=gY0VFKM3; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gY0VFKM3";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="gY0VFKM3"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=f/Ss9u7ffm+Ms/aS7WwUlqIogB4GvdVPTjeht4umbEc=;
	b=gY0VFKM3coh0tcV+ulsYg4AicFqE9u5p5h83kZbsVbIQMpVvThTXxGRqPkrfbpLjyb5R3tVTG
	gAxAOmcQOhwcbRfhcqGuaqVmK1bHYGjIsh+C3jes7E+BycvsGkvxHF7xzeo5ASH9TcE+NSejIbX
	rlMQUkeOVbLxP83KDhQamYU=
Received: from canpmsgout04.his.huawei.com (unknown [172.19.92.133])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4j1pn21Zvkz1BFrQ;
	Sat, 10 Oct 2026 11:17:10 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=f/Ss9u7ffm+Ms/aS7WwUlqIogB4GvdVPTjeht4umbEc=;
	b=gY0VFKM3coh0tcV+ulsYg4AicFqE9u5p5h83kZbsVbIQMpVvThTXxGRqPkrfbpLjyb5R3tVTG
	gAxAOmcQOhwcbRfhcqGuaqVmK1bHYGjIsh+C3jes7E+BycvsGkvxHF7xzeo5ASH9TcE+NSejIbX
	rlMQUkeOVbLxP83KDhQamYU=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4j1pWb6xDTz1prN4;
	Sat, 10 Oct 2026 11:05:31 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 20AA84057F;
	Sat, 10 Oct 2026 11:17:49 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 10 Oct 2026 11:17:47 +0800
Subject: Re: [PATCH] fs: don't lose inodes that another LRU walker is
 isolating
To: Nikolaos Karaolidis <nick@karaolidis.com>, Christian Brauner
	<brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
CC: Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261009142431.713875-1-nick@karaolidis.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <a2f5f4f7-b1ec-bf23-d990-aebbdf6de177@huawei.com>
Date: Sat, 10 Oct 2026 11:17:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261009142431.713875-1-nick@karaolidis.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 whupemo200011.china.huawei.com (7.152.185.179)

ÔÚ 2026/10/9 22:24, Nikolaos Karaolidis Ð´µÀ:
> When inode_lru_isolate() finds an unused inode that still has page
> cache, it sets I_LRU_ISOLATING, drops i_lock and the list_lru lock,
> invalidates the page cache, clears the flag again and returns
> LRU_RETRY so that the restarted walk can free the inode.
> 
> Another walker of the same list can reach the inode in that window.
> It sees a non-zero i_state and takes the inode off the LRU, as it
> would an inode that is in use. Page cache deletion requeues the inode
> once the mapping is shrinkable, so this is harmless if it happens
> before the last deletion. If it happens after, nothing puts the inode
> back: it stays in memory, unused, clean and without page cache, out
> of reach of the shrinker and of drop_caches, until it is looked up
> again or the filesystem is unmounted.
> 
> Before commit 2a0629834cd8 ("vfs: Don't evict inode under the inode
> lru traversing context") the pin was an i_count reference, and the
> final iput() put the inode back on the LRU.
> 
> Skip inodes that are being isolated and leave them to the walker that
> pinned them, which restarts its walk once it has unpinned them.
> 
> The window is reached by any unused inode with page cache on
> CONFIG_HIGHMEM kernels, and otherwise by inodes whose page cache is a
> single shadow entry at index 0. On an i386 HIGHMEM guest, eight
> concurrent "echo 2 > /proc/sys/vm/drop_caches" over 2000 freshly read
> one-page ext4 files leave roughly 400 of the inodes off the LRU per
> round; on x86_64, with the files' pages first evicted through
> memory.reclaim, 3 to 4 per round. With this patch, none in either case.
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
> Tested on master af32da41b032 (v7.3-rc6-232) in QEMU/KVM with a small
> stress program: mount an ext4 image, read 2000 one-page files, run 8
> concurrent "echo 2 > /proc/sys/vm/drop_caches", drop caches again
> single-threaded (2, then 1, then 2), and count the filesystem's inodes
> still in memory via how many the umount frees:
> 
>    i386 HIGHMEM:      ~390 of 2000 lost per round without the patch
>                       (3 runs x 20 rounds), 0 with it
>    x86_64, pages evicted through memory.reclaim first (single shadow
>    entry left):       ~4 per round without, 0 with
>    x86_64 with KASAN, PROVE_LOCKING, DEBUG_VM, DEBUG_LIST:
>                       6109 lost in 50 rounds without, 0 with, no splats
> 
> The reproducer is a single C file run as init; I can post it if useful.
> 
> I went with skipping the inode rather than requeueing it on unpin
> (which would be closer to what the final iput() did before
> 2a0629834cd8) because it avoids the remove/re-add and leaves the inode
> where the pinning walker finds it again. Happy to switch if preferred.
> 
> Jan, this applies cleanly before or after "fs: Basic infrastructure for
> offloading inode reclaim" (v2 3/5); happy to rebase onto that series if
> you'd rather take it there.
> 
> For stable: 6.18 and older need inode->i_state instead of
> inode_state_read(). I have only tested master.
> 
> An LLM was used to check the analysis against the code, write the
> reproducer and draft the changelog; I have reviewed all of it.
> 
>   fs/inode.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
Good catch.

Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> diff --git a/fs/inode.c b/fs/inode.c
> index a9d37be390a1..74dfc379b377 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -942,6 +942,12 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>   	if (!spin_trylock(&inode->i_lock))
>   		return LRU_SKIP;
> 
> +	/* Another walker is dropping its page cache, leave it to that one */
> +	if (inode_state_read(inode) & I_LRU_ISOLATING) {
> +		spin_unlock(&inode->i_lock);
> +		return LRU_SKIP;
> +	}
> +
>   	/*
>   	 * Inodes can get referenced, redirtied, or repopulated while
>   	 * they're already on the LRU, and this can make them
> 
> base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
> --
> 2.55.0
> .
> 

