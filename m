Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B933D7D61
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 07:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781769356; cv=none; b=b3negSYqEFyvFA8VzXmP3tAtWRWOmquja4NSqjldx18MGkj+ES75z8HIyqUTTTXYEyQwbavc1bJoHsAIsookdvGPpMBkEv/bgO2CPmHbwtGqTD89RrUdbThKzMn09TvxGactJKxtU6+ZymylTb9DOrQsrv7ovejWE7DpHkT6z58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781769356; c=relaxed/simple;
	bh=6s9vHquvyrsTuoLIwzkNynuU8aGAJv+Ye4HARWfy2qc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gHIKfvzpMX7UnawDbIUZD8OueYxlISoDPFDhbnNxLVSZyMCyDRRTwmefkpkKUrG9caPppNhPJor7M040fi93+lD4Qau3pjb+l+jatkvK1v2qNsqPDlXa9RgPQDb5OkpXwvHjFmiyBcyHD0Rf2gk9ReA/dKuo4LT2wDyZZRg82w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=LF21c/WG; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="LF21c/WG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1781769329;
	bh=tctqlVWawdsuxnP4bC5T4IOw+WFZXrYBfMPLs5KGnwI=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=LF21c/WGMPdPmId6q8Oeh40oIHElbkdra3V83JdtWmFhFbQLZmoIIB/fFPVhI0nPT
	 eggBlYEAyDMQBwlSynK6O+GtV9LrBQks8odbitiBc9JOOWe6niAmv108hg5aPTYW1u
	 43HLZsq4+wNW9J7HB7pIx3IOHl+OKTO1iG3Q1d7U=
X-QQ-mid: esmtpgz14t1781769323t7de58de5
X-QQ-Originating-IP: G0Y92piYEjNztn+bBfime/5bcbO/bLrFAZDCJyjxHts=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 18 Jun 2026 15:55:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 818916248080913179
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
Subject: [PATCH 5.10.y v2 9/9] net/sched: act_pedit: free pedit keys on bail from offset check
Date: Thu, 18 Jun 2026 15:53:52 +0800
Message-Id: <20260618075342.1599593-10-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260618075342.1599593-1-guanwentao@uniontech.com>
References: <20260618075342.1599593-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MILA/v8A9aHmnZZOexDepKnesFB3qsURjMOYokgwFG1mEotczaTqR4QH
	NMzhqxWleMvTn2/aTVbwmzGJKQuNk3riaJFOgTcwyzeF41BLgojAuGV6E4E82cUIreWzvW/
	0quse3b2u2RuitKfOrNmSaPaieq2rTP/NBdJJ+7B5rocixrDtq4VHhPxnyg9H8VdYs3pIlz
	Hpl9FWtREnkMSarXV0Na7I0Et9XPSCGhE909sYk+9shkmquw9WfsorXJjh6T4VEtQNu/8t7
	0iVcboyJ/dGhJeiQ18GWGsQr6dJyzRX00Q4DK39bqQXMHOQ59f9bUt8P3Ao3fF959L9zCxL
	L1MjonYsfFrifOKpjli/D5rLcDSgPB/uLSfA72fe5lIMzDbM+7wI7edRxpybnZbRZqyxGTS
	kKDTZy4tPPqa+iSf32IAmUDipPYfOnH92pLFXrH0UFbvJY/W5dlz9zKe9auDa/kbdL2o44U
	0wyHZUVn0n7jUFmhqF+h+2JtSUiXyQGYeesmB0/asYF2oveZ3HKmdVjNVhXbczrC/o65St/
	dLxox87IoHnpV8he0lEHK8gxIErj4zmYxNYklvN/9DnZPf13BhB3p0FWKwA3w+DKF9zvKUp
	ktN9YQeCLW84IgYSG30Oo5a/1XJJ4FB54mSGylP3SRbZLuLwdrdUB/FJn0yiANZbsM7qO0V
	UnyYa2dIwh46ddMBhxwiUHL5QvlPM0sPloySBKoXTW4x7nEMq28wiLhP5UgJHqI0MyuxHd9
	uLV31LYXVzvoSr/qlDRVS25d19hHas000WXIpiF3b0cnpgZbezwpzadR+cmq7zxDB2efDgc
	dd5DJK3Yd3W61jujVT2yYt6yH4kOMjxGXx79O4xIGRIa0+xMLDSkI++zyRhxPINVk8L+tFV
	qa0b7F6KRq4uM0dqT8xyRppJLp5Jr5nWYus404kw/kecKV4AoYoRNU6DtUYj17vWduOm3XK
	D7DYNZLSoOmztkh92MQuxEEItKSyMEXwYBs37TxR1B1SIGec3/DjFtDUICQyxJ455U02FYT
	TeHaAxpM8eK9lYJszalfuN8FyMbG/gLHfud+lArhp6v0vHcMvsxjyYPyRhq5xskXZPtp9H5
	m6z1QBgh4dnGDo/j9nW2ItpMFHm1i6bEfa7pGv+tm9OrePPAqGTGyXTGV4AmoBqZnLtLJE2
	q3bMwKSJ/NheANQnrBDdnHgiH5A7heYXpenvKGnFHq90VkmAuyyZwCOv4A==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
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

