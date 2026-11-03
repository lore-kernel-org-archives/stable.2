Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671594;
	b=3ZU74XmDi/OSslSmZDeoD1TQ6XCgEiVo96lgbzzO2jjke3eQF+rkTyQjZQ8JIOVPqB9r
	 a79vTpI85Kw5U87NqiMppRGolhm2PnWure+GXmZirEpTrvpXZEEbUC09WEPHqqw28UmwE
	 2puVVF+ihsWh3cJjUTRN6C4+b7Z1YfFCmzeHVZoBZVhjT5PG5LpRtoAkCfQe+fM1JkIBj
	 76GSQzJxmlONSdfnDyIkh4EswzJ41Ht4PYbSwuCzczoGx7vb8KMUw+QNYO/2tlm3CRaR2
	 OF54dOu6dqORsrHf7VAVYVWgSSQc6oq+oQNWFAAzrlWsthIWcu2DvbSG3Beo6+bPNfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671594;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Subject:To:CC:
	 References:From:Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=v4u4F2x/nKEXI6K51t5Y4udoO7BBBbN73aqid42YOZ0=;
	b=0PRL6rvCOAqrL7+RDJmIxZtxeU6UqQFxAnxC/CVbW1NiiSgXYPdM2dIkrzu9Z5l1BMJ+
	 FZhVab0Jdjp3Ir2gWW21Tmj0SS83gCQ83UI4rZ560nz5kzw5tkroYNCQfcEhTLVRuBb/H
	 Emg3KFyUmgqAaiFAWrVQ3nVOOjTVKvSm1HZzk3IzjrkqwlPmJvr4KNyx1QfhWAaL4b4Lt
	 W1d53o/sMC4uYPMEgtZdjuRKpRxrXjgO0e4uURdpVHafMXG8iGAAaKCIRICmK6NEOuJaY
	 lb64RRHILwugzxGY5sJRk0jS9Ie8ZWP0H3eOwQxrC0nXAvzVrzD/oHLnsKetcVynuxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=gNV88AdX;
	arc=none smtp.remote-ip=113.46.200.220
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE76606D820;
	Tue,  3 Nov 2026 02:06:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EE76606D820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=gNV88AdX
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=v4u4F2x/nKEXI6K51t5Y4udoO7BBBbN73aqid42YOZ0=;
	b=gNV88AdXjFtCeALe7w+67uOqRnkXP0NvgdmDlFeVL0HFWsUtuSinEHD74eDZucPNHZhrkvcaM
	TRCRsnQvW1kZBAPJf9ko6PpN1Ar4KreivOQg37LzxesmUP+wEfyNmwZnID/e5U00oQzS7uarW9L
	+/BEAf0Uokr0K0Kp4jSR/+I=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4jJX4D3Rshz12LdL;
	Tue,  3 Nov 2026 10:06:20 +0800 (CST)
Received: from whupemo200011.china.huawei.com (unknown [7.152.185.179])
	by mail.maildlp.com (Postfix) with ESMTPS id 6472D40561;
	Tue,  3 Nov 2026 10:06:20 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 whupemo200011.china.huawei.com (7.152.185.179) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 3 Nov 2026 10:06:19 +0800
Subject: Re: [PATCH 0/5] ubifs: harden validation of on-disk inode and node
 metadata
To: <shao.mingyin@zte.com.cn>, <richard@nod.at>,
	<linux-mtd@lists.infradead.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20261102214531231UAVA89ay_BDVcwFmrv8cq@zte.com.cn>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <49cebc00-3827-e24c-3e0c-74ea6ca8c7e4@huawei.com>
Date: Tue, 3 Nov 2026 10:06:18 +0800
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
In-Reply-To: <20261102214531231UAVA89ay_BDVcwFmrv8cq@zte.com.cn>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemo200011.china.huawei.com (7.152.185.179)

在 2026/11/2 21:45, shao.mingyin@zte.com.cn 写道:
> This series tightens the checks ubifs performs on the metadata it reads
> from flash.  All five patches are about size and accounting fields that
> are taken from the image and later used without a range check; an image
> whose CRCs and node tags are intact can therefore drive the code into
> state it never expects.
> 
> Patch 1 rejects inodes whose size does not fit the signed loff_t the size
> is stored in.  A 64-bit value with the top bit set becomes negative and
> passes the max_inode_sz check, and the read paths then do size arithmetic
> with it, for example (i_size + UBIFS_BLOCK_SIZE - 1) >> UBIFS_BLOCK_SHIFT
> in do_readpage() and (i_size - 1) >> PAGE_SHIFT in populate_page().
> 
> Patch 2 rejects xattr inodes whose i_size does not match data_len.  ubifs
> keeps the two equal for attribute inodes, and ubifs_xattr_get() and
> remove_xattr() assert on the invariant; with assert=read-only or
> assert=panic a plain getxattr() or removexattr() turns the file system
> read-only or panics the kernel.
> 
> Patch 3 checks the lower bound of the master node's highest_inum.  Today
> only the upper bound is validated, so a value below UBIFS_FIRST_INO is
> accepted and ubifs_new_inode() allocates numbers from the range reserved
> for special inodes.  With highest_inum == 0 the first new inode gets
> number 1, which is UBIFS_ROOT_INO and already in use, and the index ends
> up with two inodes sharing a number.
> 
> Patch 4 validates inode and data node sizes during replay.  replay_bud()
> trusts them, and ubifs_recover_size() may then extend an inode to a bogus
> size.  The normal read paths already reject such nodes, and truncation
> nodes are checked in replay_bud() as well; do the same here.  The data
> node end offset is also computed in 64 bits so that a large block number
> cannot wrap.
> 
> Patch 5 refuses xattr accounting that cannot be decremented.  On an image
> whose counters are already zero or smaller than the entry being removed,
> the unsigned counters wrap and ubifs_jnl_delete_xattr() writes the bogus
> values back to flash; the next mount then rejects the inode because
> xattr_names + xattr_cnt exceeds XATTR_LIST_MAX, so a single removexattr()
> makes the image unmountable.
> 
> To keep the severity claims honest: mounting such an image needs
> CAP_SYS_ADMIN in the mounting namespace (or access to the flash), so none
> of these is a non-root attack.  Patch 2 only turns into read-only or panic
> with the assert= option; the default action is to report.  Patch 5 is the
> one with a persistent effect.  Patches 1-3 are mount-time validation,
> patch 4 is in replay, patch 5 is runtime accounting.
> 
> The patches are independent, have no inter-patch dependencies and can be
> applied in any order or as a subset.  All five carry Fixes: and
> Cc: stable.
> 
> Testing: each patch applies to next-20261030, passes checkpatch.pl
> --strict with 0 errors/0 warnings/0 checks, and fs/ubifs/ builds with
> CONFIG_UBIFS_FS_AUTHENTICATION, CONFIG_UBIFS_FS_XATTR and
> CONFIG_UBIFS_FS_SECURITY enabled and W=1 without new warnings.  I did not
> mount crafted images: this machine has no mkfs.ubifs/ubi tools and no
> mtdram or nandsim setup.  I can put together an image for any of the five
> if a runtime check would help the review.
> 
Hi,
 From my perspective, I'm not really interested in the problem scenarios 
triggered by malicious fs image, let Richard decide whether to merge it.
This series does not seem to introduce any issues, there are two small 
nits in patch 2&3.

> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
> base-commit: 7649ba73f9e7e1e04d0b46213e39c79ae09dd55c
> .
> 

