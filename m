Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5588B1A680E
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781754601; cv=none; b=NordDO+aWKncb3mb3hXZ+Rlv0tFPBVCNASa45Tv3K3GY7DcVftMiWX9EmR6L4MOZHkncWwH5Zz5SrKzwFIbxpZ9ewpq5Sm96uMqjzxHPD5IZGQ7ZUvY9UBuN3Z2LpH/tR8R2KDhEVhK8UBueo+dBjtAQCLYZeeWSo31UJ3klAIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781754601; c=relaxed/simple;
	bh=wexEebWdkDrMMnBg/3ymJYA3AWzFit5J/7J3k54mqaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O+aJxrgj41yS9g/zlGB7hN9GcUPeC0RTDqZbt3K+/BUj7abLxST3p95sdD+arHwe6bIX4RknuDqoEKhqwPEuepspO53ySyLJeucfFnD8KevUaa+r26FKL+BZyEa61/qBOX9QSdBG4R1g1jiI9tLbPs6TU0oI6EwQObm2E9rl8d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=HEjdnyg/; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="HEjdnyg/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781754541;
	bh=6gIuklN/s4TC1OioqeNHu+88iOtV+GMmUfXhOqdFTlw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=HEjdnyg/13LgbZhSAAoKEfAVC693e8b/vCTqGLXOc5ci6baCm+1Cfj/NVGe6yWJtP
	 BhPhCIYYQXzZSUviv0WP2zvZj6BxyJBKdTa4WFQ5/P4YC1OeewuroYblAo62f481nl
	 jRK3FdEAq61wkOezrQQOtk7XTYvtIgaSK8BXJc04=
X-QQ-mid: zesmtpsz4t1781754535tfeb5d88d
X-QQ-Originating-IP: Acfc1CiqLpOCY2YOVjmBTWBPcclbLBnA2Zq17jJLKvE=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 11:48:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11939741252422597626
EX-QQ-RecipientCnt: 18
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com
Cc: stable@vger.kernel.org,
	2045gemini@gmail.com,
	dcaratti@redhat.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com,
	Pedro Tammela <pctammela@mojatatu.com>,
	Ido Schimmel <idosch@idosch.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.1.y 4/3] net/sched: act_pedit: free pedit keys on bail from offset check
Date: Thu, 18 Jun 2026 11:48:48 +0800
Message-Id: <20260618034848.1526846-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618034034.1525175-1-guanwentao@uniontech.com>
References: <20260618034034.1525175-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OOlOVjkwwwrs1Ssqv/twtbl1gfOHQD2IUnzhvEZFPa/u5c41PNUqvpoL
	O41az1sy2XERLOD9xccs7mRkEioNhHCiZpx47j15HGQkNNc7Q2jTgycVtuxvB0oqZfDKqnH
	C+syuDxjc3KMNRE4Vvlj6bMadeWFJVGskPeawsxEXqmX+UHZl1BdlhnEHKPm6F7x86eRNLc
	il4NVMp0gYDBJOkgWwNUBvRkyiGqcylB8B0uCfMtFHUFCxgDr9lerZ7tCae3g6QB0y/bHke
	AdqWn9Wk/hXL0pevGEcVOqI2f+kRuEIfIMRsTGVQlcTjdnT1eQP3CGmyXxAU+tURiC9betW
	kvlNC4MGwUPhyxrSc+2DWsYjq9UOTj284u6oxC9EyIG5igJkvrgij4jn+6eTtfjL8jjlHZ1
	ol2nlKrKOZ6q/YbCmGl5Y9QAUZa8x7T18yDYWHwlHD2NL3SMzlqnzicHxU+MLjUBim05EvS
	jxHAVHqDZG59/AD3pyM9tzaSEwTEji6RQyoYd+WGq3MQXCP7XKYTApLsIFcjkvV6SWURQ9N
	9MLRGHDBU5KmYMpB/0k1RQA8M4DJi1HafIArLrIwxFxMBBBeYJKl6VKTpRvseAFbkoevrjP
	fqjAx6cJ/WZJJ/4EGsPcv0XAjbJy43t3pk91L1b34LtYg8aT8AN+TOmbkVtCLLCfiAq4/Ve
	dwnvNQif+IE7aWEC9es/HwhE7akcV+5Bm1yJM36Zpq3gBVMAiJXfklWyy0Rftm7sQV5l6Bk
	M7gs1jLnJ5Wspb4SxK+2qlIWoG+guQ3OZMtmV0zy3sBaIDogOd1f9werlJ2QVo237xm8fNC
	VcsHHiD24s8zBLg5gXpYPWXl2XPisXtdP4iIW7RQVIwcm2sTPEQ5oOfkYvxO43i65JyQ5OO
	kQ0XYL8B55aC3aSsjWxPYOMDjGR8LrldyUu9zu+6EFNnDeiO8rUgy3274LX4vMK5q44mSha
	R5zcsecJ5P7ld1EabOFDYRZSGcbt/bc/od/222NeuDGKU4zkz3ccWPhrlY07sCv9A9XcY9Y
	lPzglgdh27hR1refmz6t3o6QTQOwid2EQDusiicpqdot3tYclCBTqOevgLrETRvKFMiTG6n
	+uLfoZP5bI8g8+INm4z47dc5gX8sBE3bQ==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit 1b483d9f5805c7e3d628d4995e97f4311fcb82eb ]

Ido Schimmel reports a memleak on a syzkaller instance:
   BUG: memory leak
   unreferenced object 0xffff88803d45e400 (size 1024):
     comm "syz-executor292", pid 563, jiffies 4295025223 (age 51.781s)
     hex dump (first 32 bytes):
       28 bd 70 00 fb db df 25 02 00 14 1f ff 02 00 02  (.p....%........
       00 32 00 00 1f 00 00 00 ac 14 14 3e 08 00 07 00  .2.........>....
     backtrace:
       [<ffffffff81bd0f2c>] kmemleak_alloc_recursive include/linux/kmemleak.h:42 [inline]
       [<ffffffff81bd0f2c>] slab_post_alloc_hook mm/slab.h:772 [inline]
       [<ffffffff81bd0f2c>] slab_alloc_node mm/slub.c:3452 [inline]
       [<ffffffff81bd0f2c>] __kmem_cache_alloc_node+0x25c/0x320 mm/slub.c:3491
       [<ffffffff81a865d9>] __do_kmalloc_node mm/slab_common.c:966 [inline]
       [<ffffffff81a865d9>] __kmalloc+0x59/0x1a0 mm/slab_common.c:980
       [<ffffffff83aa85c3>] kmalloc include/linux/slab.h:584 [inline]
       [<ffffffff83aa85c3>] tcf_pedit_init+0x793/0x1ae0 net/sched/act_pedit.c:245
       [<ffffffff83a90623>] tcf_action_init_1+0x453/0x6e0 net/sched/act_api.c:1394
       [<ffffffff83a90e58>] tcf_action_init+0x5a8/0x950 net/sched/act_api.c:1459
       [<ffffffff83a96258>] tcf_action_add+0x118/0x4e0 net/sched/act_api.c:1985
       [<ffffffff83a96997>] tc_ctl_action+0x377/0x490 net/sched/act_api.c:2044
       [<ffffffff83920a8d>] rtnetlink_rcv_msg+0x46d/0xd70 net/core/rtnetlink.c:6395
       [<ffffffff83b24305>] netlink_rcv_skb+0x185/0x490 net/netlink/af_netlink.c:2575
       [<ffffffff83901806>] rtnetlink_rcv+0x26/0x30 net/core/rtnetlink.c:6413
       [<ffffffff83b21cae>] netlink_unicast_kernel net/netlink/af_netlink.c:1339 [inline]
       [<ffffffff83b21cae>] netlink_unicast+0x5be/0x8a0 net/netlink/af_netlink.c:1365
       [<ffffffff83b2293f>] netlink_sendmsg+0x9af/0xed0 net/netlink/af_netlink.c:1942
       [<ffffffff8380c39f>] sock_sendmsg_nosec net/socket.c:724 [inline]
       [<ffffffff8380c39f>] sock_sendmsg net/socket.c:747 [inline]
       [<ffffffff8380c39f>] ____sys_sendmsg+0x3ef/0xaa0 net/socket.c:2503
       [<ffffffff838156d2>] ___sys_sendmsg+0x122/0x1c0 net/socket.c:2557
       [<ffffffff8381594f>] __sys_sendmsg+0x11f/0x200 net/socket.c:2586
       [<ffffffff83815ab0>] __do_sys_sendmsg net/socket.c:2595 [inline]
       [<ffffffff83815ab0>] __se_sys_sendmsg net/socket.c:2593 [inline]
       [<ffffffff83815ab0>] __x64_sys_sendmsg+0x80/0xc0 net/socket.c:2593

The recently added static offset check missed a free to the key buffer when
bailing out on error.

Fixes: e1201bc781c2 ("net/sched: act_pedit: check static offsets a priori")
Reported-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>
Link: https://lore.kernel.org/r/20230425144725.669262-1-pctammela@mojatatu.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
(cherry picked from commit 1b483d9f5805c7e3d628d4995e97f4311fcb82eb)
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/sched/act_pedit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 1b076c4f2d1af..09310b56b45be 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -258,7 +258,7 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		if (!offmask && cur % 4) {
 			NL_SET_ERR_MSG_MOD(extack, "Offsets must be on 32bit boundaries");
 			ret = -EINVAL;
-			goto put_chain;
+			goto out_free_keys;
 		}
 
 		/* sanitize the shift value for any later use */
@@ -283,6 +283,8 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 
 	return ret;
 
+out_free_keys:
+	kfree(nparms->tcfp_keys);
 put_chain:
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
-- 
2.30.2

