Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC0643F8C9;
	Tue, 21 Jul 2026 22:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784672112; cv=none; b=Kth1Z+gIeOV3/fx6kQLVNzV+htOZqPmLpPkNNaCymSALgtBuYMa7OIDD4RLabEEkznlW2Vu3gUFN8n/Cm44RWJSc+SpVzVaPuz0n0RXLF+n7ZtWK8aXMzzY4P8rEyCpuW1KMHXxwvPOE8X6p7OEx68OFg2jXR0/dJzhFITXDfqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784672112; c=relaxed/simple;
	bh=ZtaW8oB5hy7mvoPP6JzZWBB7H//QrhxnvarhkX8e+Gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ffmu56Tk5e632Nv/2IaOcedtCJtFNfYtwKKpVIRppvaCuU/OhmIOAXANzVCA5daQ9662M3wCidV0XqQEAorzrvryPjuPxKGWkmETXmm99Kyw8XcvXMW+oO5RFhamo2CvrstjdrKzinhHJ4u/w6xHcI4HqeF3hlzsT0CIzvAUhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k/jIsuIm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k/jIsuIm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9CA1F00A3D;
	Tue, 21 Jul 2026 22:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784672111;
	bh=CMinFyqr5njRocBeZqP8BIJeE385Om6zUZZvJdLn7Ns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=k/jIsuImzJNPitK2Pwg2zK45BxZ568L2PwSSRa85MJiRmPdDOZQDiHwZMOcLoXQ3v
	 6412Saz4X6Phcz++YT8h6R8lXXiMBu2QXlMMYHShmsVluLTYuyat9cqMsKUwjUOlAe
	 haVLfbUBhvOKmo4pdIb4gALMHWEADhc9SjgY24qV/1+eKoVQGm9B84+SGYyFFTZ41i
	 LqB/BGvWCnZSk+8Jl/rU07wvwo1V919f5u9bl3IXokB8pyu8SnAPhAeIs5PgYBdsFf
	 K5BFKtwvF9vkXMtpblhfUDheOoy0OxfaKYbsyox7v0LS14ZC0PI71J0ShiWPKTYdrn
	 3vARhF8QjJeWQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 22 Jul 2026 00:14:39 +0200
Subject: [PATCH net 2/5] mptcp: pm: userspace: fix use-after-free in
 get_local_id
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-2-6fb595bc86ef@kernel.org>
References: <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-0-6fb595bc86ef@kernel.org>
In-Reply-To: <20260722-net-mptcp-misc-fixes-7-2-rc5-v1-0-6fb595bc86ef@kernel.org>
To: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kernel@vger.kernel.org, "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 stable@vger.kernel.org, Xuanqiang Luo <luoxuanqiang@kylinos.cn>, 
 Geliang Tang <geliang@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3322; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=8DCHTVbUXEUEAILN1E701JGgPjN3FeF+obur5MPG3d8=;
 b=owGbwMvMwCVWo/Th0Gd3rumMp9WSGLLi36coqCntjvt3U3L1Of5ZThJHXghrPeSWTJ/o9GmV8
 H2V0vbojlIWBjEuBlkxRRbptsj8mc+reEu8/Cxg5rAygQxh4OIUgJv8kJHhkelupuXsB+t2GfdY
 78tRcbj91Vnq6Pn0cOunR8/f0zpSzsjwxris9bSH8Z8V2aYP7n2amHFbZppGYH+fGHOVVGOqrAw
 zAA==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

In mptcp_pm_userspace_get_local_id(), the address entry is looked up under
spinlock, but its id is read after dropping the lock. A concurrent deletion
can free the entry between the unlock and the read, leading to UAF.

The race window is narrow. It was reproduced only with a locally
constructed stress test that repeatedly overlaps an MP_JOIN SYN with a
MPTCP_PM_CMD_SUBFLOW_DESTROY request.

However, the KASAN report below confirms that the race is reachable:

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

Fix by copying the id into a local variable while still holding the lock,
and use -1 as a "not found" sentinel.

Fixes: f012d796a6de ("mptcp: check addrs list in userspace_pm_get_local_id")
Cc: stable@vger.kernel.org
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Tested-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/pm_userspace.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index d100867e9202..945aa5afc2dd 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -132,12 +132,15 @@ int mptcp_userspace_pm_get_local_id(struct mptcp_sock *msk,
 	__be16 msk_sport =  ((struct inet_sock *)
 			     inet_sk((struct sock *)msk))->inet_sport;
 	struct mptcp_pm_addr_entry *entry;
+	int id;
 
 	spin_lock_bh(&msk->pm.lock);
 	entry = mptcp_userspace_pm_lookup_addr(msk, &skc->addr);
+	id = entry ? entry->addr.id : -1;
 	spin_unlock_bh(&msk->pm.lock);
-	if (entry)
-		return entry->addr.id;
+
+	if (id != -1)
+		return id;
 
 	if (skc->addr.port == msk_sport)
 		skc->addr.port = 0;

-- 
2.53.0

