Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4928F3AEF50
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782497346; cv=none; b=OZOMs7Ib0YJw/l+cMaBptJnww8gcMIVfzGyrDCNFCV387hSvUfum2Q1OgiYJkJWsBVdM27bFMiF5QOsnfH/P1bdoogf0xN2BG5e7Pj7pVCCzqTQ7f3ycdt5B8KkpFB95ENIfhU4Mz29IybMhixn2Sr7XaQ4DZ6ZVJyFzx248ips=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782497346; c=relaxed/simple;
	bh=6s9vHquvyrsTuoLIwzkNynuU8aGAJv+Ye4HARWfy2qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JCFNiq0WtjRBXiGkbii0MHSFOXbO7R1Titd9YeW7tZVGclSYtyk8HyDCPZrpd09KNJCL1lnVIuFP5/c6M0A2edwO8MDqlxbixVVrS6p+KQbHnpMYWZzeEhZhJ0FOm/ZsbIGo8D7U5WDQH2/NpyxBgE5wJAMhtsj4YRXpj0SgHXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Nyg2SeN8; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Nyg2SeN8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782497317;
	bh=tctqlVWawdsuxnP4bC5T4IOw+WFZXrYBfMPLs5KGnwI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Nyg2SeN8eD6XIrWRHa4ihDf1boz4ZcDeXB3kNxCqWbZsbVBbGt/cFq0Uw28uW3wmq
	 Xm6nFvR7HvKFjU1u8AdA/EfbmbZl+DfdMuWpvYw0NgDpOzyoCf60LrBlr+J+8oLSxD
	 6dw0Ci6W26UQMoCQmz/xE0xaYV+eRZbHLxBbnPbo=
X-QQ-mid: zesmtpgz6t1782497311t9c746437
X-QQ-Originating-IP: +qLxtJDNATYuMIZsmzebBcp10GhiZSnawk2JIvNuFaA=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 27 Jun 2026 02:08:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11171785821266662638
EX-QQ-RecipientCnt: 20
From: Wentao Guan <guanwentao@uniontech.com>
To: sashal@kernel.org
Cc: 2045gemini@gmail.com,
	davem@davemloft.net,
	dcaratti@redhat.com,
	gregkh@linuxfoundation.org,
	guanwentao@uniontech.com,
	jhs@mojatatu.com,
	keenanat2000@gmail.com,
	kuba@kernel.org,
	pctammela@mojatatu.com,
	rajat.gupta@oss.qualcomm.com,
	rollkingzzc@gmail.com,
	simon.horman@corigine.com,
	stable@vger.kernel.org,
	toke@redhat.com,
	victor@mojatatu.com,
	yimingqian591@gmail.com,
	Ido Schimmel <idosch@idosch.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y v3 09/10] net/sched: act_pedit: free pedit keys on bail from offset check
Date: Sat, 27 Jun 2026 02:07:34 +0800
Message-Id: <20260626180735.297017-10-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260626180735.297017-1-guanwentao@uniontech.com>
References: <stable-reply-item001-act-pedit-510-20260626@kernel.org>
 <20260626180735.297017-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NF7bsBlIjskbhzKisjWG6HVb6yuVoqxIPXxn6Qv6XG6gv12vPbRN7+i1
	9j7l0hvj6urQUhhE7sOnNZHxb/ZpBlbPHlttmm/x5H9JkkTCzCV3HP+fDVDmDqytQEKwb8J
	SkqqfL8RUGPfgXntNmcW6fvVMj8FNRP1AMst4EmdAiUtBlDNXROfzlJ58IvqvrzJGDm5tzm
	mo65JjpB6LDqp038gX4ch6LN1iwZFmpSV9gOjhlNAiMvK5qH68oYzUeDmcZAaIt2k0t6x0m
	dZoWQh9YTo/v1mw/QGbjodWfpZ7MdBAUNdhBaa3hn/wrxcI7B2Qy8dbxY0DwVqyNyMJ5Qw7
	GYoji/ImPgcMO7AWty4ICUdhi1ANdd+q+/5soODi6Y0sQr35OF2iUNgsKDaQ2JWtI+N5Sht
	E5aUug4m3zANztf0hXVFno25K4m6uVkp9HIVAmG5bL7T+s0gSgJ4PlG6e3mVq23Ukt0HLcx
	IYlPGe/LqOZWYOHn8gg4VaMAkBI2xvpl01E7RWF/niwrPnifNJWbaCYnXNik2FRM9wy3XQ5
	5vM57gXjMefB2LmPD+2a0V5wAN6TdmQ9wMY1iD38kWBLBwfDINSKbCcPfBo6Sq6O7Bdw2WN
	Dtj7YVyAbgLPz0ItrgKIhr4bILMhklMPyI4ft32t2hg4cfb6ZCgVsqOiXc6MzDwroFCgdD5
	2QojwMwVGQVmm4Vc9wO4TsxwQsD+3RltKC2Xod0LZbwptXw9tlG09bCSyDLDDuHYu0Q71mH
	67GBU2zc73ugdlyh+O1Llyyn5W5c9HFLKmMj/5ypejgltZlzMPxFs1QjZrcMR45Q5DavV1l
	Yvngyvg0p+4Fr36/xBxoKq41ny4uJrBlKRlXGIJbwvSylexufUzJdyNU5F2+LMgruDvK2c3
	6o/CIGRtpRogAJIdBHacNXagpefq+jwZEg4oigV/YjAmcu/F23GAFEuKZEwGoeiCWi7Pgtd
	zLpy0EVsjyBQ6sTeAzKwUar7l5gNJIvvmiJQ2OL6zRTmUyyR29IUBFzfgS+bJfq0gqxoB8t
	abKyTANhtiRXM0AwGqtOz8Mw+vn8KvPXLYqTgd6q94tyCKyVqCVkl7PiDrahESWVd4fnUcO
	BKpQRJpWQSRO7EmFZ0d1OkmflBf/InQtOpVhHboFKfYTiNQLM1eEVpRWM45KLdGWu4tKG+O
	zglD
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
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
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 net/sched/act_pedit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index 35fa94ba0edf8..0601deea04d72 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -250,7 +250,7 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		if (!offmask && cur % 4) {
 			NL_SET_ERR_MSG_MOD(extack, "Offsets must be on 32bit boundaries");
 			ret = -EINVAL;
-			goto put_chain;
+			goto out_free_keys;
 		}
 
 		/* sanitize the shift value for any later use */
@@ -275,6 +275,8 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 
 	return ret;
 
+out_free_keys:
+	kfree(nparms->tcfp_keys);
 put_chain:
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
-- 
2.30.2

