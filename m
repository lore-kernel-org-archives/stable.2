Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671582;
	b=FsGz2wZTLI4oI8WI1Gi70ILdEDpG37L89yG0bpGuGwR73xcu5g4kxtlm9+cMjfYWHneq
	 drka9r3UJtQWOjd1co/cDlaOBsLRAaSJmYpDIbBUW8GE3Y6gByfDQyIg7VbMauMy3kx27
	 q/3IB6muilYxWt4/1dxeRjra0YBdZ8uTqqJkY/fnVTalGVIj5jM8q38nrwN7l3qwpL3iz
	 8svQVoHNma+Gyk55vKJuJWhTSppy7XzS2G85Ge585vUZr2ORSErfONk6xV6vezk8mKXdN
	 +X/9TSbDXa3axMm/uM5BhQMFZ2FHJI9l40h7ESMPp/eck2uZwTHbqb8nWSiHSVo0ULQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671582;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=9eQOyo+IfoykMUCBNu9pw763kypSfDmJgqjlvxDApw8=;
	b=pyWFPH+UHyLFSB8ontOe+n1GNOzztUFlUpXUeO+enK6b/zahiF0jaOO4UvvAsK1BhWB4
	 6xmKUUKRJNxPRuC+UcI5qA4WoEBTXm4Qwq0cFkvGaPb0gdbtVk5KMAwsLMToAnHOAe74m
	 0khMQejGf1TsJxV77F31EXrpMQMgwFAfg/wye70o2LJjSwlvAuIoOyYy9vRzWEimqDsPk
	 LN+Zk8vgs79fsbWGw6A0YzCJuddn09a4cQ4wjZ6shiOqxpxjqul3AL66A0wNYk55uD0V+
	 FadSrZnzqXX3Q8fyGR6g+VDxIW1oqpWA8vWxzbTI5qM9IkwUaE+6RP4GnupThcwILVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72719606D806;
	Tue,  3 Nov 2026 02:06:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72719606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=9eQOyo+IfoykMUCBNu9pw763kypSfDmJgqjlvxDApw8=;
	b=MOlk8Ovrnv9M2b6BANy190osKUGXiWsJJOzVOm0oroqq5uoDB3X7pN20VxheZXXwz3OPMe8wQ
	SQRfOVI4ocTcN3t/FvzX2c/v4m7/cpY47sU+DM1IEusYB1zjKs9Mj5+6jm/MbOGajjsp1YJh+d0
	DGKJLq2F4tcCTj/RY7FUYbk=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jJX4663p8znV89;
	Tue,  3 Nov 2026 10:06:14 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 6DF674048B;
	Tue,  3 Nov 2026 10:06:14 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 3 Nov 2026 10:06:13 +0800
Subject: Re: [PATCH 3/5] ubifs: reject master nodes claiming a too small inode
 number
To: <shao.mingyin@zte.com.cn>, <richard@nod.at>,
	<linux-mtd@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261102214935612btR10gHRJy3yrzqeLcnE9@zte.com.cn>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <6ff71dd8-84e0-dcef-01c7-1bb7e341ccff@huawei.com>
Date: Tue, 3 Nov 2026 10:06:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261102214935612btR10gHRJy3yrzqeLcnE9@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemo200011.china.huawei.com (7.152.185.179)

在 2026/11/2 21:49, shao.mingyin@zte.com.cn 写道:
> validate_master() only rejects highest_inum values above
> INUM_WATERMARK.  A master node whose value is below UBIFS_FIRST_INO is
> accepted, and ubifs_new_inode() then allocates inode numbers starting
> from that value, i.e. from the range reserved for special inodes.  With
> highest_inum = 0 the very first new inode gets number 1, which is
> UBIFS_ROOT_INO and is already used by the root inode, so two inodes end
> up with the same number and the index is corrupted.
> 
> Check the lower bound as well.
> 
> Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> diff --git a/fs/ubifs/master.c b/fs/ubifs/master.c
> index a148760fa49e..8a1ba81c10bb 100644
> --- a/fs/ubifs/master.c
> +++ b/fs/ubifs/master.c
> @@ -191,6 +191,16 @@ static int validate_master(const struct ubifs_info *c)
>   		goto out;
>   	}
>   
> +	/*
> +	 * Inode numbers below UBIFS_FIRST_INO are reserved.  If the master
> +	 * node claims a smaller value, newly created inodes would reuse the
> +	 * root inode number or another reserved one.
> +	 */
> +	if (c->highest_inum < UBIFS_FIRST_INO) {
> +		err = 24;
> +		goto out;
> +	}
> +

This check could be merged into previous check:
  f (c->highest_inum >= INUM_WATERMARK)
>   	if (c->lhead_lnum < UBIFS_LOG_LNUM ||
>   	    c->lhead_lnum >= UBIFS_LOG_LNUM + c->log_lebs ||
>   	    c->lhead_offs < 0 || c->lhead_offs >= c->leb_size ||
> .
> 

