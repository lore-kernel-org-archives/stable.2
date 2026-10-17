Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A9A2D1F7B;
	Sat, 17 Oct 2026 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792222995; cv=none; b=RwiKxFKldoRHPGdvwZYhBWwxVTk/li3+1MQ55ZQaaMCnpyh4q7p60nyst8X8vdtmqDrqGrGVc0PovoXT5nFM8llfzx824ONc9q0zApqwWj2GAKuHhMxs7s+QW3Nk1fmopJ1d9ni1dn35Yj7N+WsnLyGoBpba1hJVKzgy8b+c7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792222995; c=relaxed/simple;
	bh=L1ZzRUNO15Wcq1tW/lxQLVisoqfwoeeNEieUCfi5fnM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oXzd1oPQxDt9iqsvmclb1LPXm2g+DUpHMM4Q089bnZ5GxNvw5N1cgE5ocmXM/Z7wHIm0hn+VCPvMNSqYTGdbkhS3h6THc1TG7xlEpDLPPvdcMl9rfHaq9uVr1JgTC6sv28DDVGqiAqY6MvdC9mS4+xfDmW/jA7uHS++LKoH9d2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=bTUs22iq; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="bTUs22iq"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7Xa7wrZpzGbe9BZSoSeuK0FiGnGIBL2+6xHOdQnRNAQ=;
	b=bTUs22iqp5UbfqcN34dlQW0hyXCkj7jsdSLiCwtJ/Sqb6zcv/sL3UkABoANOlHV4e2rRfbDtQ
	KdJuFxM0q1yldyfqhBEuYM9Piwkkfrwl6SuIkBguAm9AjUSilKqI/wH3Lv+s2QHem5nzpONuDD/
	0/l4+xyy9StCYPN8VGC4Tn4=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4j6DLb6T7mz1T4LX;
	Sat, 17 Oct 2026 15:43:03 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 144ED40537;
	Sat, 17 Oct 2026 15:43:06 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Sat, 17 Oct 2026 15:43:04 +0800
Subject: Re: [PATCH] fs: rotate inodes whose page cache could not be dropped
To: Nikolaos Karaolidis <nick@karaolidis.com>, Christian Brauner
	<brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
CC: Jan Kara <jack@suse.cz>, Mateusz Guzik <mjguzik@gmail.com>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261016102515.111285-1-nick@karaolidis.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <5b74fceb-dc8d-21ad-d313-eba7a0009056@huawei.com>
Date: Sat, 17 Oct 2026 15:43:03 +0800
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 whupemo200011.china.huawei.com (7.152.185.179)

ÔÚ 2026/10/16 18:25, Nikolaos Karaolidis Ð´µÀ:
> When inode_lru_isolate() drops the page cache of an unused inode, it
> has to unlock the list, so it returns LRU_RETRY and the walk restarts
> at the head of the list, where the inode still is. If
> invalidate_mapping_pages() could not empty the mapping, the restarted
> walk strips the same inode again, and so on until nr_to_walk runs out.
> Every walk of that list then ends on this inode, and nothing behind it
> is reclaimed for as long as its cache stays.
[...]
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

Hi Nikolaos,
I find a possible BUG_ON if this patch applied, details shown as:
    P1                          P2
prune_icache_sb
  lock(lru->lock)
  inode_lru_isolate
   if (!mapping_empty(&inode->i_data))
    unlock(lru->lock)
    spin_lock(&inode->i_lock)
    inode_state_set(inode, I_REFERENCED)
    inode_unpin_lru_isolating
    spin_unlock(&inode->i_lock)
                          unlink
                           iget_locked // find_inode_fast gets the inode
                           iput
                            iput_final
                             drop = 1
                             evict
                              BUG_ON(inode_state_read_once(inode) != 
(I_FREEING | I_CLEAR))  // inode state with I_REFERENCED

Could that be possible?
