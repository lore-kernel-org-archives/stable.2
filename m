Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8C63932E3
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783928955; cv=none; b=gQUJzYpQlH/1VY9VSCTe9+OW4DBVMKRANy1aZADsp9cIEv3bp8eKKLzmyyhF1Y+YXooOOusFvbJPvt+aJS8Kq4t5/JDU2Jr1fK7ZZBz88rVPvEcC50MWExH1iT8S+wFfCD8RA90MlrqDd2xsFyKlL5Y2jT2vOtpghWADAvB9lTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783928955; c=relaxed/simple;
	bh=2n+dYW2fLiiihhjQLvWQ/E9v6N6d5+ppDnJL2OOQWCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwR1VW6FlGe1YXOhOEdQgIT6zp5ryosx1Gi3kbzTvzbud3shSNwRIg49bCJdXYZKmtjY6Tuo5EOTf4yDEXTHfB9jQXSdU+03109ZghQQdmn3k0pvSQPe1IqHDQfKfaMVo0Bc5cjHUuNSwuv5e3GqsAiRkzvV10johIR0uvXaWMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lTPI9zt/; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lTPI9zt/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783928941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8XQ7D2c2pe32qfx1N7E397Gh3r4n4PmZEhbDOAq/Knk=;
	b=lTPI9zt/vwPUa56eNId5rCDp3kusAOuh0q1lSympqIJSjKKrf9kkIalcac6zH04dIOxz7k
	wnXUpBLnUtI/FMghlfKzOS8zYNKgxwC6j+uz0NrlpitqrQ5rIc3XTiBEzLa+57ErQ0X/6F
	YuxjDrdUVkkazB2WEjk04i4fbq1AfJs=
From: xuanqiang.luo@linux.dev
To: mptcp@lists.linux.dev
Cc: matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net v1] mptcp: pm: fix use-after-free in userspace_pm_get_local_id()
Date: Mon, 13 Jul 2026 15:47:22 +0800
Message-ID: <20260713074722.47921-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

mptcp_userspace_pm_get_local_id() looks up an address entry with
pm.lock held, but drops the lock before reading its ID. A concurrent
subflow destroy command can remove and free the entry in between,
resulting in a use-after-free while processing an MP_JOIN SYN.

Read the ID while holding pm.lock, then use the copied value after
unlocking.

Fixes: f012d796a6de ("mptcp: check addrs list in userspace_pm_get_local_id")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
The race window is narrow. It was reproduced only with a locally
constructed stress test that repeatedly overlaps an MP_JOIN SYN with a
MPTCP_PM_CMD_SUBFLOW_DESTROY request.

However, the KASAN report below confirms that the race is reachable:

[  666.319362] ==================================================================
[  666.319376] BUG: KASAN: slab-use-after-free in mptcp_userspace_pm_get_local_id+0x1dc/0x1f0
[  666.319386] Read of size 1 at addr ffff888124845610 by task swapper/0/0
...
[  666.319401] Call Trace:
[  666.319405]  <IRQ>
[  666.319408]  dump_stack_lvl+0x53/0x70
[  666.319412]  print_address_description.constprop.0+0x2c/0x3b0
[  666.319418]  print_report+0xbe/0x2b0
[  666.319421]  ? mptcp_userspace_pm_get_local_id+0x1dc/0x1f0
[  666.319423]  kasan_report+0xce/0x100
[  666.319426]  ? mptcp_userspace_pm_get_local_id+0x1dc/0x1f0
[  666.319429]  mptcp_userspace_pm_get_local_id+0x1dc/0x1f0
[  666.319433]  mptcp_pm_get_local_id+0x371/0x440
...
[  666.319821] Allocated by task 45539:
[  666.319844]  kasan_save_stack+0x33/0x60
[  666.319855]  kasan_save_track+0x14/0x30
[  666.319858]  __kasan_kmalloc+0x8f/0xa0
[  666.319863]  __kmalloc_noprof+0x1e7/0x520
[  666.319867]  sock_kmalloc+0xdf/0x130
[  666.319885]  sock_kmemdup+0x1b/0x40
[  666.319888]  mptcp_userspace_pm_append_new_local_addr+0x261/0x500
[  666.319910]  mptcp_pm_nl_announce_doit+0x16a/0x610
...
[  666.319967] Freed by task 45560:
[  666.319988]  kasan_save_stack+0x33/0x60
[  666.319991]  kasan_save_track+0x14/0x30
[  666.319994]  kasan_save_free_info+0x3b/0x60
[  666.319998]  __kasan_slab_free+0x43/0x70
[  666.320000]  kfree+0x166/0x440
[  666.320003]  sock_kfree_s+0x1d/0x50
[  666.320007]  mptcp_userspace_pm_delete_local_addr.isra.0+0x157/0x200
[  666.320011]  mptcp_pm_nl_subflow_destroy_doit+0x51d/0xea0

 net/mptcp/pm_userspace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d100867e9202f..27fa8dc757b4f 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -132,12 +132,15 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
 	struct mptcp_pm_addr_entry *entry;
+	int id = -1;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr(msk, &skc->addr);
-	spin_unlock_bh(&msk->pm.lock);
 	if (entry)
-		return entry->addr.id;
+		id = entry->addr.id;
+	spin_unlock_bh(&msk->pm.lock);
+	if (id >= 0)
+		return id;
 
 	if (skc->addr.port == msk_sport)
 		skc->addr.port = 0;
-- 
2.43.0
