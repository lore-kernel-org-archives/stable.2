Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A819437E2EC;
	Fri,  9 Oct 2026 05:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791524406; cv=none; b=IP7FoS71808TRkQmn5EIaCeBuGjL/ouSM4t3ZAaVAC/vwujHXAki5GGe/Gne1dmRKp1/kW21CBgsDkJPzHlqvjF+5ljXjtZPbXwveE5FQX0s9uqOHwH6WWihcqVThvGEQKkMqun2nSiB1HC6MXD3PW6uirZyG51qnzvFs1FRI58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791524406; c=relaxed/simple;
	bh=Vo/z7Nb6ubKZoh5o/V8jSNmYKJETfCtL8FttVYl1Uco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RxKQTZysM9pM1knv65/2A7KXMvBHzPEtYTDBjvrAOiNWduCdwvOeTJ5NqUt/TyEDf54THQ4faNxc6P95As/LPAKnHAmrbNK1juH11i7CsYaudGV0lVDZHRAUrHcVwkaUEgti6n+m+4bdmijBJhsjr5bezrPBDGRTzy0pFB6QtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
Received: from escalante.csail.mit.edu ([128.52.128.198])
	by outgoing2021.csail.mit.edu with esmtp (Exim 4.95)
	(envelope-from <nickolai@csail.mit.edu>)
	id 1xF30U-0001uh-5a;
	Fri, 09 Oct 2026 01:18:58 -0400
From: Nickolai Zeldovich <nickolai@csail.mit.edu>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nickolai Zeldovich <nickolai@csail.mit.edu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	I Hsin Cheng <richard120310@gmail.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	Barry Song <baohua@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] lib/plist: fix plist_requeue() shortcut inserting the node at the list head
Date: Fri,  9 Oct 2026 01:18:47 -0400
Message-ID: <20261009051857.758182-1-nickolai@csail.mit.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

plist_requeue() moves a node to the end of its priority run.  Since commit
95d4b3450ebe ("lib/plist.c: add shortcut for plist_requeue()"), when the
node was the head of its run it skips the scan of the remaining nodes of
that run and takes node_next from the prio_list of the node's successor,
which replaced it as the run head in plist_del():

	iter = list_entry(iter->prio_list.next, struct plist_node, prio_list);
	node_next = &iter->node_list;

prio_list is a ring of the first nodes of each priority run, without a
sentinel.  For every run but the last one, iter->prio_list.next is the
head of the next run and the shortcut is correct.  For the last run it
wraps around to the head of the FIRST run, and list_add_tail() then
inserts the node in front of the whole list, ahead of nodes with a lower
prio value.  The list is no longer sorted:

	before requeue(B):  A(1) B(2) C(2)
	after  requeue(B):  B(2) A(1) C(2)

The condition is: at least two priority runs, the node is the first node
of the last run, and it has a successor with the same priority.  A single
run is unaffected, because a one-element prio_list ring is list_empty()
and the slow path runs.

The only caller is swap_alloc_slow() in mm/swapfile.c, which requeues a
swap device within its priority group.  With several swap devices on more
than one priority level, where the lowest priority level has two or more
devices, rotating the first device of that level moves it ahead of all
higher-priority devices, so subsequent swap allocations go to a
low-priority device first.

Only take the shortcut's node_next when the next ring entry really is a
higher-priority run; otherwise append the node at the end of the list.

The CONFIG_DEBUG_PLIST self-test did not catch this because it only
requeues nodes it has just added, which are always the last of their run,
so plist_requeue() returns early every time.  Add a deterministic test
case for the failing shape; plist_test_check() verifies the ordering and
the prio_list ring after it.

The bug was found while attempting to prove plist_requeue() against a
specification stating that the list stays sorted, in the MachCSL
verification of the Linux kernel on RISC-V; the proof failed at this
arm and the prover produced the counterexample above.  The fix and the
test case were drafted with Claude Code (Claude Fable 5.1) and reviewed
and tested by hand: the three functions were transcribed to a userspace
harness that reproduces the misordering before the fix and the expected
order after it, and lib/plist.o builds with CONFIG_DEBUG_PLIST=y.

Fixes: 95d4b3450ebe ("lib/plist.c: add shortcut for plist_requeue()")
Cc: stable@vger.kernel.org
Cc: I Hsin Cheng <richard120310@gmail.com>
Cc: Ching-Chun (Jim) Huang <jserv@ccns.ncku.edu.tw>
Assisted-by: LLM
Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
---
 lib/plist.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/lib/plist.c b/lib/plist.c
index a5bef38add43..20291872923a 100644
--- a/lib/plist.c
+++ b/lib/plist.c
@@ -174,11 +174,17 @@ void plist_requeue(struct plist_node *node, struct plist_head *head)
 	/*
 	 * After plist_del(), iter is the replacement of the node.  If the node
 	 * was on prio_list, take shortcut to find node_next instead of looping.
+	 *
+	 * prio_list is a ring of the first nodes of each priority run, without
+	 * a sentinel: if node's run is the last one, iter->prio_list.next wraps
+	 * around to the first run, and node must be appended at the end of the
+	 * list instead of being inserted in front of it.
 	 */
 	if (!list_empty(&iter->prio_list)) {
 		iter = list_entry(iter->prio_list.next, struct plist_node,
 				  prio_list);
-		node_next = &iter->node_list;
+		if (iter->prio > node->prio)
+			node_next = &iter->node_list;
 		goto queue;
 	}
 
@@ -276,6 +282,25 @@ static int  __init plist_test(void)
 		plist_test_check(nr_expect);
 	}
 
+	/*
+	 * Requeue a node which is the first of the last priority run and has
+	 * a successor of the same priority, with an earlier run present: the
+	 * shortcut in plist_requeue() must append it at the end of the list,
+	 * not in front of the first run.  The random test above never
+	 * exercises this, since it only requeues nodes it has just added,
+	 * which are always the last of their run.
+	 */
+	plist_head_init(&test_head);
+	for (i = 0; i < 3; i++) {
+		plist_node_init(test_node + i, i ? 2 : 1);
+		plist_add(test_node + i, &test_head);
+	}
+	plist_test_requeue(test_node + 1);
+	plist_test_check(3);
+	BUG_ON(plist_last(&test_head) != test_node + 1);
+	for (i = 0; i < 3; i++)
+		plist_del(test_node + i, &test_head);
+
 	printk(KERN_DEBUG "end plist test\n");
 
 	/* Worst case test for plist_add() */
-- 
2.56.0

