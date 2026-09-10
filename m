Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6B64A3F25
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789055089; cv=none; b=DMqs1e1VSp6Ay+jA3L/HpwufW/EFMInCSqCItijvw14P8thSlz5LeKW3kycwoKoWshLcIcWI43kHwegjITxlBUar3DOXITrBt1m2yckM6egvMd2IhTNP2TJElpy0xVdBwUltgSmTIrPyTCeMKJm8P8eMo5ETFqeoYGr+JT9eoNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789055089; c=relaxed/simple;
	bh=gp2RoKk+MBhaSAs3n0MBgUyA9gjGA4o9L39proy2iMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oqVz8X3F1nSeEYp5mztfZ29Q1FgmycMree5ejjRB9zsWw/36T3rCHOEr4ctOyebuEf3Uv9Zhcy4GsWZe9K48Y2DDsEpsdXskbQauCbShMwIXvVBLi4vFQBm1EWRWxBjIgh+VbLmU+ZbPqCkvV+t9ONpnuPqKP7ZFZFcLaNWhtVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQduFc1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQduFc1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 115BC1F00893;
	Thu, 10 Sep 2026 15:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789055088;
	bh=x+P3BUlE/ZjR8LEph9Mlhbrq0YuFiixgNmIduHjVpyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QQduFc1gv78FZ54bm4geRNJUCqeQqX42QDmk65TTpJY/gzAIpyoZTVtdd13NPCyDI
	 7gwQyNvq5V1k82H81J/EqGaIDPBL8Y/4NndcjSk4rHiS2YiTSpOgkMrWo9qLsq0Ip+
	 YkPbuLmF5zADVjNKpjPqR9zwqtfNW2/nSP5hJHkj1xw7ghW6h2UvZcZxVMFEQcTaz6
	 Q5dr69ugsB0w0aTmABAst3SaSWfkapDW044cnAIP+jdYtbWfEDSI2ck6Dig7VAJrnw
	 MXbk8AAbcutFBCDRJWU965f1OpC2dtMRAqC3ZY7Amn93v3/dmhrFVT6U/CUvDbtSdH
	 CHV2yYqeKKrlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] kprobes: Protect kprobe_blacklist with RCU
Date: Thu, 10 Sep 2026 11:44:46 -0400
Message-ID: <20260910154446.1032841-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090833-slinging-thesis-77c0@gregkh>
References: <2026090833-slinging-thesis-77c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit 0c4256196b3a105307e2235fbfd85e768bbcdd0f ]

__within_kprobe_blacklist() traverses kprobe_blacklist without holding
kprobe_mutex. When a module is unloaded, kprobe_remove_area_blacklist()
removes blacklist entries and immediately frees them with kfree().
A concurrent call to within_kprobe_blacklist() can therefore dereference
freed memory.

Furthermore, within_kprobe_blacklist() can be called in atomic or
non-preemptible contexts where the sleeping kprobe_mutex cannot be taken.

Protect kprobe_blacklist with RCU. Use guard(rcu)() and
list_for_each_entry_rcu() for traversal, list_add_tail_rcu() for
insertions, list_del_rcu() for deletions, and kfree_rcu() to reclaim
entries safely after a grace period.

Link: https://lore.kernel.org/all/178810004323.64882.16493230858653316962.stgit@devnote2/

Fixes: 376e242429bf ("kprobes: Introduce NOKPROBE_SYMBOL() macro to maintain kprobes blacklist")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260807155802.F06041F000E9@smtp.kernel.org/
Assisted-by: Antigravity:gemini-3.7-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[ Replaced guard(rcu)() with explicit rcu_read_lock()/rcu_read_unlock() to avoid declaration-after-statement warnings. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/kprobes.h |  1 +
 kernel/kprobes.c        | 19 ++++++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 18b7c40ffb37a..71b15c923077e 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -178,6 +178,7 @@ struct kprobe_blacklist_entry {
 	struct list_head list;
 	unsigned long start_addr;
 	unsigned long end_addr;
+	struct rcu_head rcu;
 };
 
 #ifdef CONFIG_KPROBES
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 551ac118159f9..46398072b5bea 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1513,11 +1513,20 @@ static bool __within_kprobe_blacklist(unsigned long addr)
 	/*
 	 * If there exists a kprobe_blacklist, verify and
 	 * fail any probe registration in the prohibited area
+	 * Note: this can return true during transition period where
+	 * (start_addr, end_addr) in the black list is shrinking
+	 * but old entry has not been removed yet. This is acceptable
+	 * because the worst case is that we reject more probes than
+	 * we should.
 	 */
-	list_for_each_entry(ent, &kprobe_blacklist, list) {
-		if (addr >= ent->start_addr && addr < ent->end_addr)
+	rcu_read_lock();
+	list_for_each_entry_rcu(ent, &kprobe_blacklist, list) {
+		if (addr >= ent->start_addr && addr < ent->end_addr) {
+			rcu_read_unlock();
 			return true;
+		}
 	}
+	rcu_read_unlock();
 	return false;
 }
 
@@ -2388,7 +2397,7 @@ int kprobe_add_ksym_blacklist(unsigned long entry)
 	ent->start_addr = entry;
 	ent->end_addr = entry + size;
 	INIT_LIST_HEAD(&ent->list);
-	list_add_tail(&ent->list, &kprobe_blacklist);
+	list_add_tail_rcu(&ent->list, &kprobe_blacklist);
 
 	return (int)size;
 }
@@ -2417,8 +2426,8 @@ static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
 	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
 		if (ent->start_addr < start || ent->start_addr >= end)
 			continue;
-		list_del(&ent->list);
-		kfree(ent);
+		list_del_rcu(&ent->list);
+		kfree_rcu(ent, rcu);
 	}
 }
 
-- 
2.53.0

