Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE82B2D0C7B
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 04:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781757445; cv=none; b=J16dXfLAenqcbLX4ET3efOFvvNWAsRzOgr5e3DQB/4t7duHBraTfBlJlLYIH7PsGOJVj+A1GnqgJJ4HQyg+Fh7kR6/bAjGK94lGPUCDL4j75koI1RD24G8bCAvGOyImAiciN62Ji7wrMwN6TTvLIbU14l/iwgBB+n8EOTIpaV0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781757445; c=relaxed/simple;
	bh=J6M1+G57SdDxIbpa/TNyJmYbgpzB7hWOH4hVGYNSaDA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=leiBcmDN1SmJWC7+XuzqY82A8qsHNhWM3h/AwszTj+gR6y3xSNly7UW9lngFSWtTG3jS8/Ww9+MJXA/HGYe1zxjso/48mHlhoIEPJx6VqeQ4SqcRDhNk4gl2oHz3BOz3duHrAULKe2IeVX78nn50/JNIJjpC2gpWWaP28y6d1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=XyOLVhWt; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="XyOLVhWt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781757405;
	bh=sHRDXDoa7m2c+QUwr+QPltnfug7RdU8fDOZaZ0X8gQE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=XyOLVhWt0rbTIU5+FUNGJYMa2LG/jL00MwPOoeeIDzGKfFgc0NBMDTchCcwe7Fexv
	 oR9agyA4Y29ZOxreLMrxt9JCPyBWKTQcGBDP4sHMm7P3LqlmkSCcnUo5mrTiRqWgyQ
	 1jnBLsTBdhFF5xNh0ygRsvoD/BEYjeymAQ8nk3lQ=
X-QQ-mid: zesmtpsz6t1781757399td8270fb4
X-QQ-Originating-IP: A01eYbD4wgkBj0zZ4xxXAdg3H1Fh3OMadHmq+nBxhnI=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 12:36:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 771141314634641624
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
Subject: [PATCH 5.10.y 8/8] net/sched: act_pedit: free pedit keys on bail from offset check
Date: Thu, 18 Jun 2026 12:35:41 +0800
Message-Id: <20260618043539.1557035-9-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618043539.1557035-1-guanwentao@uniontech.com>
References: <20260618043539.1557035-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: N8RLcQ8dzVhjA66qWVPVa92ExhA2Pa1aJWlYC+DwfIIPWNVRDxlINgAw
	JNcJfHoEomOmnFnWGSAMu4TGbxq99t0p2Rind1FNVymV2bfsNByxBVdSAE1GBtBl1bl3WXj
	4wLG8BLSIMSOjHMrZnMfa9mejRcyMdcd+1trzjayR3tZ59bpr8s2Eis1f5aVvkPznK+Qakf
	CIrLiPmRZRH7ZA5r35UCngYahqXZ1Lr0iIQ9DrSPr7OcFqyQi9JtuEVPVPB5HHf+JAiDuRc
	mptF8S/RIV0WNemZcso7e1wQxLBrhQWNJnpzL2CIeELUmO75lyxMB18ufdIcHQW46f6y8wM
	TLgCGWMqwxrEKi8jXv5XlqWRnqbAyfMdWq0UQVIuaSyOZxufM2SOf3wc/seDc+GF9lqMyRP
	XaTuxT13RY5Q/ZN7pSCn8b9sQGWDdzY26AaDmkX8lr6bRzMeFwFxAMelYFG8iHMt5s+vlz+
	WxyQ+jRPZGsVkZrK67AVNuQuwcVLX2XsUDgRmkIRR1HTvLeFWILl6P5uAJmWrgdDIL36MKF
	KmWjH3q9FT2JlEdPKGfxcfj+bojD8Gjo3AHixsTSH/KK/yaRqzxg+oBw7RFQ1KnfqrdzWks
	wNEtusiHi+ILDZ9X04rQ6Oe09ub/vD1M6Cae/GcXIudVh9Vf5bz4t/9YMZe45f8MqKhw6D8
	GsTUz3kXtmi9ZkjIf5HLnqoNbXjne31n/MjniilQjk1EMi0u177OhurMfcTA+dXeGGjxbuR
	zBZVSSeZsn4etBQ/jkT1KWN/d0zD9Nr8grrRVxqQp0aGzh5J/fKsWgOjj0tLECHxzb4h/q2
	ElrYDvHLVXliG+/hKeCJK3cH6ykwF3hLFSAg2gtDWzq6NJjkxjJl9J3kJaKwW2tO596W8um
	jClXvQjzVRP8/tZ6A9uYNbu7w3YkQ7qXAibpUbL+SZQ5I6zZNo4qhS34OTuTBMVYyuPhHF8
	CnlT7LE6fVowJNub7hTaIopg4ebDlWy9vL8MICSVyyHDdZiZJMxQQTf85uRl/xlLydAx4O1
	mZ1qHzdFjomQq6sHAaoPhhjLUg5cISfnnVu67s95SaWM02U3WJfGVeTAOgO6GJdOa1fOs2o
	p3sf5ulrqwrKbmCUwFsWrPSdjRk4eMb2AtpFLbgqgUSe3nB0f1XFSsp2+wTKLYAEMOSjYkI
	yXU5HBiwEZNyo8Op0Qgn0XrBkBlIxRMEovz8
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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
index 250f4ffa48371..78dddb1a21a20 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -247,7 +247,7 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 		if (!offmask && cur % 4) {
 			NL_SET_ERR_MSG_MOD(extack, "Offsets must be on 32bit boundaries");
 			ret = -EINVAL;
-			goto put_chain;
+			goto out_free_keys;
 		}
 
 		/* sanitize the shift value for any later use */
@@ -272,6 +272,8 @@ static int tcf_pedit_init(struct net *net, struct nlattr *nla,
 
 	return ret;
 
+out_free_keys:
+	kfree(nparms->tcfp_keys);
 put_chain:
 	if (goto_ch)
 		tcf_chain_put_by_act(goto_ch);
-- 
2.30.2

