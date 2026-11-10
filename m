Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273887;
	b=ij+gRfHIaJnQErcb2HgHLbqloDizMCJiKJ2XdERGNVVvPZH3+nBh+aDetQR6Bj3pn86e
	 +6l5yjA6FBmcyyS02q1OvPd3t7dBU3Lmb9u71qJ+U5GhHYbJMQ62egqXE0IEfG7rz3rTG
	 IfYsdtXQlMkrLVBUEHEXMZcMlG3NVI84BoABzUnnbghZX4wCpV0StJV//wN5nrh/gW4Ga
	 /H0qMfj5yisZ4PcfzB6fkxxa66SqzO7jwrUhc+hPZrhl1xjdc1eqbYlFRShxdcupwxUcM
	 e/+yfF4GgB1Z+AH9W28C5X/hPiRBloAuDBbtAgOIy359+tqIv+GJMdb3TzPyF3TBxtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273887;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=f/v/gWubsV3+XF7uRgOZ114b294oE/e1b5vYS6EE3gQ=;
	b=jzg8o5Sq08bCGSlSL5RfRx8fb2o0XIIw3FlYHcq4B+QLdzR8ijWiXm9KnjpTqNKAskB7
	 8h5jh6nwb6zZHisQaqIiyfGAMiKjxFfXp3JeXHjDaD+LlsMTjHAu6QGYwD2xhqP5YNbUL
	 K4t4vBaUXwTvfnnrY/g62ihNvo69Kh22SzcS/sGcc4JVnwdjNUSiDrgPfG74GGSIlGGub
	 5pwL2RN3kU5r8zZza5YI46lpiRLbMUWQN2MS3kAlUzHYwb1xQAP8CgDYFSejjOMDZmq4F
	 ArEOP+2G9JqNkgXnbxSeNpGSUaTTctb/7pp72zQODqp1N+iG1R97PABeMjSk3HFXYhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqc0BfCL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441F96071840
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oqc0BfCL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7888B1F0089F;
	Tue, 10 Nov 2026 01:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273887;
	bh=f/v/gWubsV3+XF7uRgOZ114b294oE/e1b5vYS6EE3gQ=;
	h=From:To:Cc:Subject:Date;
	b=oqc0BfCL/d15T/s1aYdSGBWPDMtmrtv2TVv/TGQFXYCXrwBVDTfCSEJ4WrUN1IutN
	 +BJMg4ux4seoQHCZ8VZUR2ou35E7r7n+ybZbiqRIGpQvWBLLpU1oHeaHbDksvdFUSb
	 7T++K1ULCWZcogruSJbmJHZAvDhDwwNKySduP35YPNpBeemaPfq8QbYiuP4JOEtNCG
	 C1ob3TmCq98l8zvJ3UbXK3jxd3BXUgOFFWnLDz9EQnGWWiUpIFLB+MDMrVPm+dfa+E
	 FrOGAsHDD3vIIJw0ONrFniZbHu6Zm573CugHlZ2yFDlJE1RTctQVocrdcLt9u+M2gp
	 ULOrUBUY73yjA==
From: Sasha Levin <sashal@kernel.org>
To: odys.yuan@gmail.com,
	hch@lst.de,
	paulmck@kernel.org,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] srcu: Add list_splice_init_srcu()" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:45 -0500
Message-ID: <20261109202445-failed-5.15-d06917d0ba22@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d06917d0ba226206dbd606330d73a8eb1e3029c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202445-failed-5.15-d06917d0ba22@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d06917d0ba226206dbd606330d73a8eb1e3029c1 Mon Sep 17 00:00:00 2001
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Wed, 4 Nov 2026 01:30:39 -0500
Subject: [PATCH] srcu: Add list_splice_init_srcu()

list_splice_init_rcu() makes a list look empty to new readers, waits for
the current ones with the given sync function, and only then links the
entries into the new list. The sync function takes no argument, so it
can wait for RCU readers but not for the readers of an srcu_struct.

Passing synchronize_rcu() for a list read under SRCU still builds, but
leaves SRCU readers on the entries while the last one's next pointer is
moved onto the new list head. nvme_remove_namespaces() does this today.

Add list_splice_init_srcu(), which waits for the readers of the given
srcu_struct instead.

Cc: stable@vger.kernel.org
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 include/linux/srcu.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 1a8a465a5650d..d4dcaeb83e2b6 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -18,6 +18,7 @@
 
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
+#include <linux/rculist.h>
 #include <linux/workqueue.h>
 #include <linux/rcu_segcblist.h>
 
@@ -118,6 +119,41 @@ void cleanup_srcu_struct(struct srcu_struct *ssp);
 void synchronize_srcu(struct srcu_struct *ssp);
 void synchronize_srcu_atomic(struct srcu_struct *ssp);
 
+/**
+ * list_splice_init_srcu - splice an SRCU-protected list into an existing list
+ * @list:	the SRCU-protected list to splice
+ * @head:	the place in the existing list to splice the first list into
+ * @ssp:	the srcu_struct that readers of @list use
+ *
+ * Like list_splice_init_rcu(), but wait for the SRCU readers of @list
+ * instead of RCU ones, so that none of them can follow a next pointer
+ * onto @head.
+ *
+ * Note that this function blocks, and that the caller must prevent any
+ * other updates to @list.
+ */
+static inline void list_splice_init_srcu(struct list_head *list,
+					 struct list_head *head,
+					 struct srcu_struct *ssp)
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+	struct list_head *next = head->next;
+
+	if (list_empty(list))
+		return;
+
+	INIT_LIST_HEAD_RCU(list);
+	synchronize_srcu(ssp);
+	ASSERT_EXCLUSIVE_ACCESS(*first);
+	ASSERT_EXCLUSIVE_ACCESS(*last);
+
+	last->next = next;
+	rcu_assign_pointer(list_next_rcu(head), first);
+	first->prev = head;
+	next->prev = last;
+}
+
 #define SRCU_GET_STATE_COMPLETED 0x1
 
 /**
-- 
2.53.0




