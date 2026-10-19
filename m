Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEB64E80DA;
	Mon, 19 Oct 2026 12:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792414115; cv=none; b=Zl0wRtv9TP4budHeqCBebF5Dbxelqa8FS1ZIGzTfR+zMZOH5KcUQULYqnOTEansKfqmYmzEm/qkMSexktKnZnlB2V6ObdbopQyarfz1yUM+NQJAAxof0le6mwjMPTcMWeR5BDl8ekQ0dGmiaTP6uCLZ4Kjn9+gdvs8gaF9VGIDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792414115; c=relaxed/simple;
	bh=fIQv1W9cE2jsy/PTQByc3V/WDGrlc3ns7JV1QIM7UgI=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ASINJKQI+zcR7JMno4S2gc86+MihyMnV5EEIESkxb8JVqJilG/0zvUT84xu0+2QhY0yV7XdTasS1k0+LIaVNH+aaePW2FDoZzMO1WCq0Xx16EJhiP0n5Th8RlL3CDMSLnip2/EyOhvonqquT+trqAhM6XZtu7ptutQoRKbavsgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=XL9jo5vg; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="XL9jo5vg"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=MV5RrEEMJXzqIcVuqwIGkxm5V8DKAxWOFj4ELstqf7c=;
	b=XL9jo5vgq0oiKOY98nWUyAExz+PImnG2MRncQY6TXVMBppLsZwnH2pLigVPxp/5fsm1z+nmyH
	KfDit8K3iBEFZNcvnCMB/L3u3YUr/u+KzZeJgwsv2fxN1tHrOz1OHXO3yGfH71qQKhaq6STl3ag
	eblAXEeawk8ldFmWgBuMhec=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4j7b1z47GSzmVXY;
	Mon, 19 Oct 2026 20:48:23 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id B96884055B;
	Mon, 19 Oct 2026 20:48:26 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 19 Oct 2026 20:48:25 +0800
Subject: Re: [PATCH] fs: rotate inodes whose page cache could not be dropped
To: Nick Karaolidis <nick@karaolidis.com>
CC: Christian Brauner <brauner@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Mateusz Guzik
	<mjguzik@gmail.com>, <linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261016102515.111285-1-nick@karaolidis.com>
 <5b74fceb-dc8d-21ad-d313-eba7a0009056@huawei.com>
 <qNyuimLVAkP0k7luIlbuqeg7Co3gXnyrzZ2fIuFjRZiKon2IaylrG1-_tkSRE_cWyOuq6eIzU6O12OvRg8J-ZszqHBaxE0XL2uYVhQ08MS8=@karaolidis.com>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <db764681-95cd-7c15-4b04-1372018fc93e@huawei.com>
Date: Mon, 19 Oct 2026 20:48:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <qNyuimLVAkP0k7luIlbuqeg7Co3gXnyrzZ2fIuFjRZiKon2IaylrG1-_tkSRE_cWyOuq6eIzU6O12OvRg8J-ZszqHBaxE0XL2uYVhQ08MS8=@karaolidis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 whupemo200011.china.huawei.com (7.152.185.179)

在 2026/10/19 16:50, Nick Karaolidis 写道:
> On Saturday, October 17th, 2026 at 8:43 AM, Zhihao Cheng <chengzhihao1@huawei.com> wrote:
> 
>> Hi Nikolaos,
>> I find a possible BUG_ON if this patch applied, details shown as:
>>      P1                          P2
>> prune_icache_sb
>>    lock(lru->lock)
>>    inode_lru_isolate
>>     if (!mapping_empty(&inode->i_data))
>>      unlock(lru->lock)
>>      spin_lock(&inode->i_lock)
>>      inode_state_set(inode, I_REFERENCED)
>>      inode_unpin_lru_isolating
>>      spin_unlock(&inode->i_lock)
>>                            unlink
>>                             iget_locked // find_inode_fast gets the inode
>>                             iput
>>                              iput_final
>>                               drop = 1
>>                               evict
>>                                BUG_ON(inode_state_read_once(inode) !=
>> (I_FREEING | I_CLEAR))  // inode state with I_REFERENCED
>>
>> Could that be possible?
> 
> Hi Zhihao,
> 
> Thanks for looking at this. I don't think that BUG_ON can trigger.
> 
> - The patch sets I_REFERENCED in the same i_lock section that clears
>    I_LRU_ISOLATING, and evict() waits in inode_wait_for_lru_isolating()
>    before calling ->evict_inode(), so the walker can only set the flag
>    before the filesystem's eviction runs.
> 
> - clear_inode(), which every ->evict_inode() calls, sets i_state to
>    I_FREEING | I_CLEAR.
OK, I missunderstand the realization of 'inode_state_assign_raw(inode, 
I_FREEING | I_CLEAR)' in the clear_inode().
> 
> - Evicting an inode that has I_REFERENCED set already happens.
>    iput_final() sets it through __inode_lru_list_add(inode, true) when
>    the inode is already on the LRU.
> 
> Did I miss a path that checks i_state before clear_inode()?
> 
> Thanks,
> Nikolaos
> 
> .
> 

