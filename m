Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050154AA032
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054675; cv=none; b=UlHgRrT1hh+yayfHKJ2IDe5F+Uzp1JIzhakB284nQQhDDms7BVqfYX2L3akGnuuqYfngffPAu8ECFwPs/guNkiFue+xpXyDYBVtpSbeanHYeB0fqxxDus9m+Mw4E5Nk05mmxqxZ72bFo8YV1DDwiQ2AfgfosF659t6HO4365Mec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054675; c=relaxed/simple;
	bh=JxwQMqbKlfDI0qQc2hMcmXYYirP3vcz21Aw2y1gyAkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DkjFzhhjCLC07Cn8jzEqqdNSNRqy8dpVcI8lUOB0TXSeDr7zpACXN9Ig68IcFOZe15eCdkRNf9wCa/FbFH6tYwGlhM0Cro/xj2O+eHK7uLY1rOzKA0G+R4c1Danko9BPnv3F4CB2m7d81zFDVi8YUUeDFh8qNF4mL98IizZFF68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrWYByX4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrWYByX4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E329B1F00893;
	Thu, 10 Sep 2026 15:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789054673;
	bh=fci03vZG3+np7ibwY/iJ+NsHRj5F1sWnOcdXX5suwkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BrWYByX4kjSPi2Uv35C3KEl8f8Lb11/D5aZ1KThwxarmObXxzG/lIglvp2pzFiZIT
	 mYQN3TfHO2Q+Nc1pFxQzv4tzDAbpXPo1l4GtUvnaFcy2OJZDU4NNmgoVyUSBTJA2M1
	 b8loOXkcfudBYwo5ImA9Xb5N8cejnJb/FYDj7L+nB1IsBj1Xr9aDOa55HnhPb3YCIv
	 GznaFzlE1HPRF6+MaN/sHbfozJDmyNOeJXZvlV76UDpz0oMrbZPB4uXO1Rb7hfdnpf
	 a0k4j9/5tF9+6G0MW1cZslPxNOCethwVX+nGAnlHC/qYeH4q7PoKESRAc/Q8K446PC
	 TzcTbQ2CaDQLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] kprobes: Protect kprobe_blacklist with RCU
Date: Thu, 10 Sep 2026 11:37:51 -0400
Message-ID: <20260910153751.993932-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090833-aptitude-antibody-c550@gregkh>
References: <2026090833-aptitude-antibody-c550@gregkh>
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
index 24b0eaa5de307..e5262feff8267 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -177,6 +177,7 @@ struct kprobe_blacklist_entry {
 	struct list_head list;
 	unsigned long start_addr;
 	unsigned long end_addr;
+	struct rcu_head rcu;
 };
 
 #ifdef CONFIG_KPROBES
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 0d463859ad329..69d166f42d04a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1427,11 +1427,20 @@ static bool __within_kprobe_blacklist(unsigned long addr)
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
 
@@ -2258,7 +2267,7 @@ int kprobe_add_ksym_blacklist(unsigned long entry)
 	ent->start_addr = entry;
 	ent->end_addr = entry + size;
 	INIT_LIST_HEAD(&ent->list);
-	list_add_tail(&ent->list, &kprobe_blacklist);
+	list_add_tail_rcu(&ent->list, &kprobe_blacklist);
 
 	return (int)size;
 }
@@ -2287,8 +2296,8 @@ static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
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

