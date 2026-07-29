Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6154494A1D
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332135; cv=none; b=gGK1V6Tdf1Ajmgmy1y+ir27MxlJyju45oQdv2ARgjYOY1N2207uS+l9qK9CM3ZXP5Rh9vlPmtYlqexVdsTSuqYH27kOBp8vEwxKv4GtIyk3yhNts4aj4QuU2Ya0NZDlKm0Yl4xQ9PQa49rZ+nWBMEEFRs1Dfdc5kKkZouunp4lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332135; c=relaxed/simple;
	bh=s53m4k+Ku6yQn39dymiiOuaMOuxVwbc9gqQnLgagw6s=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KSXDjWj/7ST8JcPGvhR6WQ83vZq0mIJaXynqsczGD7bbcA2W98VBHL+nJsaAvkjhDy8BaMXJUUH5kNCaRXxqUq4jlmaNdhWjfvYfKIQx1pmyfTNb6WVtj42tcbDMkbrKL9gnsDwb/DiomWoJEfC91FltOjlgaOAiSuXz0zDT5eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uHboW/gp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uHboW/gp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F131F000E9;
	Wed, 29 Jul 2026 13:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785332132;
	bh=O8X7D8XQLEQbGWv63CoFBMdsnVeOcTtr8XImmW3cBOk=;
	h=Subject:To:Cc:From:Date;
	b=uHboW/gpin5Z2tZTGm2iBzmVwm0WR74H6VPbNMCPjHAi6tTnd1p8pkyeCqu5ihoTj
	 q0VCwWGJu7V+yMauWwwgX5ZOhSuMXPz7ICx0734Yr0GKZZZzikYkOIloNw1UdcispM
	 yX+MEgrBqCc+1A2o4nHYFWcQ8+7iCWa+Fee/E5Pg=
Subject: FAILED: patch "[PATCH] mptcp: pm: userspace: fix use-after-free in get_local_id" failed to apply to 6.12-stable tree
To: geliang@kernel.org,kuba@kernel.org,luoxuanqiang@kylinos.cn,matttbe@kernel.org,tanggeliang@kylinos.cn
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 15:35:19 +0200
Message-ID: <2026072919-slouchy-backpack-abaf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 9bc6d5e4ca9f3cbb41d43400b3a31cb0403796c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072919-slouchy-backpack-abaf@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9bc6d5e4ca9f3cbb41d43400b3a31cb0403796c9 Mon Sep 17 00:00:00 2001
From: Geliang Tang <geliang@kernel.org>
Date: Wed, 22 Jul 2026 00:14:39 +0200
Subject: [PATCH] mptcp: pm: userspace: fix use-after-free in get_local_id

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
Link: https://patch.msgid.link/20260722-net-mptcp-misc-fixes-7-2-rc5-v1-2-6fb595bc86ef@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

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

