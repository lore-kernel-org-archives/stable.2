Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE173090E8
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788874645; cv=none; b=JGP4fgzgu2sZphD8HW6CDYEm1K+4nRbHT5gXNAUh+lHdWD3UkYqMQS0DErBwfkrxtrNU8upXYVoR69mvZPfPEDIndynIvvKGNfmq3w3eVy4FbT689YndpLtshGoezPRh47kKfF+L9bQG9C9/CiRZF6/a8lKXFPKV0xvXCR3dSfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788874645; c=relaxed/simple;
	bh=4NpvQBSkBiw2B2mGZ825+l/G79Q2DPDPhAzkg0AOaR0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=o7zuOyz7OVu1eJ3cz9VmQvX9/iMOpVPkFNVYmwJ1sGwjJv3PWW+RZg+yqeievitZ8c4feYYIwAyB5b57oSeuHoUIJ/A811nLriC0mm2BiZU1mGODQbWNeheszGIlxzshdai5m6bEvzO4CI8fNd75cwk+QFkAxBiLXwZkXdtxy4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nRg+aMXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nRg+aMXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD061F00A3A;
	Tue,  8 Sep 2026 13:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788874634;
	bh=jv8vqTbS+bQ0MdADVSzR0LRyUN2PM0u7xOe2XrFcSUE=;
	h=Subject:To:Cc:From:Date;
	b=nRg+aMXbTqAMa9zr8hR4czQPOASwYzcu/6ZFfVS4CC2qojCFXagnqpCRw11RhUYez
	 6cUJtPvpU1QSDMvJScq7aRlKgmSa+XgqKkqzIaQAjJ9ydk3JBSRwYLXyHIV81E/uYe
	 kUAi2Y7JVefQ2pW+T83HJ35/KjkY5jW9PhVEleR0=
Subject: FAILED: patch "[PATCH] kprobes: Protect kprobe_blacklist with RCU" failed to apply to 5.10-stable tree
To: mhiramat@kernel.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Sep 2026 15:32:33 +0200
Message-ID: <2026090833-slinging-thesis-77c0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0c4256196b3a105307e2235fbfd85e768bbcdd0f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090833-slinging-thesis-77c0@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c4256196b3a105307e2235fbfd85e768bbcdd0f Mon Sep 17 00:00:00 2001
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Date: Sun, 30 Aug 2026 23:27:23 +0900
Subject: [PATCH] kprobes: Protect kprobe_blacklist with RCU

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

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 8c4f3bb24429..e6de7ae55bda 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -181,6 +181,7 @@ struct kprobe_blacklist_entry {
 	struct list_head list;
 	unsigned long start_addr;
 	unsigned long end_addr;
+	struct rcu_head rcu;
 };
 
 #ifdef CONFIG_KPROBES
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index bfc89083daa9..6337da5cab9e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1447,8 +1447,14 @@ static bool __within_kprobe_blacklist(unsigned long addr)
 	/*
 	 * If 'kprobe_blacklist' is defined, check the address and
 	 * reject any probe registration in the prohibited area.
+	 * Note: this can return true during transition period where
+	 * (start_addr, end_addr) in the black list is shrinking
+	 * but old entry has not been removed yet. This is acceptable
+	 * because the worst case is that we reject more probes than
+	 * we should.
 	 */
-	list_for_each_entry(ent, &kprobe_blacklist, list) {
+	guard(rcu)();
+	list_for_each_entry_rcu(ent, &kprobe_blacklist, list) {
 		if (addr >= ent->start_addr && addr < ent->end_addr)
 			return true;
 	}
@@ -2509,7 +2515,7 @@ int kprobe_add_ksym_blacklist(unsigned long entry)
 	ent->start_addr = entry;
 	ent->end_addr = entry + size;
 	INIT_LIST_HEAD(&ent->list);
-	list_add_tail(&ent->list, &kprobe_blacklist);
+	list_add_tail_rcu(&ent->list, &kprobe_blacklist);
 
 	return (int)size;
 }
@@ -2603,8 +2609,8 @@ static void kprobe_remove_area_blacklist(unsigned long start, unsigned long end)
 	list_for_each_entry_safe(ent, n, &kprobe_blacklist, list) {
 		if (ent->start_addr < start || ent->start_addr >= end)
 			continue;
-		list_del(&ent->list);
-		kfree(ent);
+		list_del_rcu(&ent->list);
+		kfree_rcu(ent, rcu);
 	}
 }
 

