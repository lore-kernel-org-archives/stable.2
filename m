Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D730C16E
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781755018; cv=none; b=HeqRWcucK34QRomtcqdJkW6r+KVLTyb4UEVmqfjaS4ACS3xS2tBJIIEJfQy6Yd+zmiziPJu1On2FbXBmgnUUjiC3+wxVTtlocPtBtU4IJOKghrFvajJL+j5oRBEQHsqmhCupEdkSLyNpoPY/WM6eG+Qf+b2FAKFfWlaGJvv3EX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781755018; c=relaxed/simple;
	bh=zbPROUNfE8eb9oMXq0TXpBckWMhiS9wMrYukS+DhGQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OpBwPyZkNxh6zMO4eJnTYFK95tb/dNKPQDmb0qxY41Cm03j9tVuSVXKH1+6PhiB9sDO38sOeD1lzzcFWbzZY0jJ9CW+eXJFn4t0za6lcDLpMSY/uwnL2wLlnjqPC57v/rpBLCUG1EXBwMv/32r+aRfcis50BlEYzEp7fs+IignA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=PGrVrKZM; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="PGrVrKZM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781754988;
	bh=fEpuy4pNjhdO/MPVRp4P1LcXJ+iQ8DiQDJ9JSXFOK3I=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=PGrVrKZMArcHf7Bxs69R2wTwCLXVAbvKsvCm+ScnTUy3BQDB6DWNMI8n+RMUdcJXv
	 VBj3J9cVEQiLVE8/n2adug7ETpcO7Yrc+vbWfPwJfn7nFcF9O6aiCH6jrLfy9v/l/4
	 MNV7HhIHgIAySQXVe94VAGtyMJbJxwiotnHioW/8=
X-QQ-mid: esmtpsz20t1781754982tc18e05d1
X-QQ-Originating-IP: XRAtMcXPTLOHjkSEU29M0eHsUgnWHem5Hw+2puGSA0Y=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 11:56:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4366698399062964425
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
Subject: [PATCH 5.15.y 4/4] net/sched: act_pedit: free pedit keys on bail from offset check
Date: Thu, 18 Jun 2026 11:55:10 +0800
Message-Id: <20260618035504.1536870-5-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618035504.1536870-1-guanwentao@uniontech.com>
References: <20260618035504.1536870-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NYycj1u5Q6Lzk6/cFAPgSbeuPVArUqulMTUPfRXYbyEV7O7WJRcZfPAE
	OhlfSC52mgehlJP6w8z5sGPM6C0KYd38FAqQiEN/fozf6HBwbsHi5phEHHUeA00hEy3JHJ1
	aFDrWrakyPigeLXSC6nUi5dqZY3ljlAEnX4+Xx2W6SLININUgXECmxe5K2G65UxHAR64/0y
	dVY2d05gplajs2zno4X5gWDj3OVUtrClJ6DSs3bqQS8GC/Hl4VkWQe0PjEAW2H+nGH3up1N
	1PuH7E+A4uXKSPpOh3L0EuZ4WITtZzL4Hdo92grYb0Jys6aZsOwHUNT5pTPp1Y0lHQYMD1A
	ssTihu8n+1lC6Q2VxLh285VuH0oPXUvOjSvnkNGdJwr1JyKzMNSHBXgz8cWS02gd5fM0v0s
	2UXC2+y0a3bF4KgdbTEsd0VhqlIKHVw/ytU7enGGzwOZOiGEKd65vP6jycCKlkEBVhGWz9o
	h5+Sy8emvkXkvSiQhao9M5e5rbkt+vHrTmFXYuetDhAC2vJ5/FdaoaM2pKwxyYg4cSH0LAs
	N/DWDabiIxLQf68BsI/y4CVc+BVhjbJnWH+xDAHaSUXHRbvbhCzhOdEfhqvAEbg7nlt9qtu
	agGpY8SjUpLjkZ90ALDHukZc/CTZBA1fbTlZhm/efHW/6j0tWnO25vMTmxB0GgmW33vnZP6
	JMoLbMhSsMiO4C4nPNN8Cb1t0SycYeyy4N5QcZCWRsMlYVPLZAlQVjzlMKsh7PyWxR9Jd22
	SkgiBJDU9oi5qbDGnX4VJtL0kQdXCxGYN5zuyiJAVrkgxg4JT2ege1kD1+ZZpTWzddn7gEC
	K+6y2dK3Nn3iWu/yPx92InBpp3LFeoWq3WMTT2fxCEA4GVOYUa/x4yRDH48E9eBqnpoaa7v
	Qtx8PmZz/bUOKJSvDiWkI7yVevqiBbuUbH2rzEQlYaFAcKYQ2ZIFHGTzwTof+al22XlNXC1
	vf29p1WfOQvxz6j1F6mCAaRKgQZZwvyhRDsDDOoKNLlqZZ+d+rWT5BVXnK6Ps9TapZ49CO9
	k3Y9KUA3bImHH/FQJA7GE54/hNGrnmi+KCiEVOA/y9ig8T88GATaOmxxLlIC50hYzZq7yqb
	kRVoHEzCVZPcTFUKujsP32Z9324IcRXp7UsUe9Nojiy6DLnd7EJG/m5m4f6TRmVcaxsZwVV
	mAPfD+CfgoFurWSTwvM8GtVXTo75Sj9PZ+oz
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

From: Pedro Tammela <pctammela@mojatatu.com>

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
index 8f50cbdd5aff9..8e69b6120b28f 100644
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


