Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2E8434E55
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 23:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787353883; cv=none; b=Mj6RkqVu5jkInEu8LomplDZFaAhdBwGDVFB1sUXCW9sBB6YcSlQESGBbc1r3y7JGQUqycgu2/mjlxIofaVf1ZaLRi6r0sXTpSLOnn3ngPSehkZ27spG1KRInSYkXNTwhOZvI6SFO/cSaQWZLpmNbFKgDoit72vSr1VMWWV6v04g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787353883; c=relaxed/simple;
	bh=jWkFIkHo1xWz2Z7Eh6EpEzcX45PHIvimZ6TkGZGZKt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obwh8MXiyEez77pPSNfUXM6Lb8i5sgQuCW5X8KEoO65gAKDKMiECAinG0K0JkRLxD3adUCemOYRFOJ40HRmDzVXLqBTYAWvy6Yk4F/x9t3yR/HYfgkqnU7Yk04DwpJtP/QZMrg5JQM35KOCP3WAZ+PewHJoEpFhNQF1mHV0KcEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF3nIX8Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF3nIX8Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89871F00ACF;
	Fri, 21 Aug 2026 23:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787353880;
	bh=PfTrkBM2bY8W3ffcfbOrFc5ZLCnTvZMnJKJ4A1lzYaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lF3nIX8Q3NEGs2wADAyBBHiel+jcd/AiBx+8pGQVGIE+9dkV0rwpBAgnX5eIO9gLt
	 1nvB7dJ1wOljOxKUXX0FYadX19sgHDbcBbnEJGTLgfMZozgRDc14aYCSG033GJ8G/R
	 WCcHAf75lKxP2mdEkeNJZwuQsXc0gV/Js2s7x62BNtVP7ORyZ8wUzk1uR9JLrvaIWQ
	 EYrxP+y7h/cxO5tT/4MOGZAh0A09zQtJqMc4x9iaqlV/4MXAsPeHgnlwa+QJsfUNWW
	 DT8Gwfwo9iWWIc7+HhNZME0v6h9RPwA1WPBG0snR1DF4yV/xtLx1CmGOaui0PNDRDn
	 b6rm8WqGI1T6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Julian Anastasov <ja@ssi.bg>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] rculist_bl: add hlist_bl_for_each_entry_continue_rcu
Date: Fri, 21 Aug 2026 19:11:17 -0400
Message-ID: <20260821231118.122991-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081700-require-division-36c1@gregkh>
References: <2026081700-require-division-36c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Julian Anastasov <ja@ssi.bg>

[ Upstream commit 1ac252ad036cdb18f5fb7f76bb6061adfed9cedf ]

Change the old hlist_bl_first_rcu to hlist_bl_first_rcu_dereference
to indicate that it is a RCU dereference.

Add hlist_bl_next_rcu and hlist_bl_first_rcu to use RCU pointers
and use them to fix sparse warnings.

Add hlist_bl_for_each_entry_continue_rcu.

Signed-off-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Florian Westphal <fw@strlen.de>
Stable-dep-of: cdcc4e46180d ("ipvs: separate destination availability state")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/rculist_bl.h | 49 +++++++++++++++++++++++++++++++-------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/include/linux/rculist_bl.h b/include/linux/rculist_bl.h
index 0b952d06eb0b0..36363b876e53d 100644
--- a/include/linux/rculist_bl.h
+++ b/include/linux/rculist_bl.h
@@ -8,21 +8,31 @@
 #include <linux/list_bl.h>
 #include <linux/rcupdate.h>
 
+/* return the first ptr or next element in an RCU protected list */
+#define hlist_bl_first_rcu(head)	\
+	(*((struct hlist_bl_node __rcu **)(&(head)->first)))
+#define hlist_bl_next_rcu(node)	\
+	(*((struct hlist_bl_node __rcu **)(&(node)->next)))
+
 static inline void hlist_bl_set_first_rcu(struct hlist_bl_head *h,
 					struct hlist_bl_node *n)
 {
 	LIST_BL_BUG_ON((unsigned long)n & LIST_BL_LOCKMASK);
 	LIST_BL_BUG_ON(((unsigned long)h->first & LIST_BL_LOCKMASK) !=
 							LIST_BL_LOCKMASK);
-	rcu_assign_pointer(h->first,
+	rcu_assign_pointer(hlist_bl_first_rcu(h),
 		(struct hlist_bl_node *)((unsigned long)n | LIST_BL_LOCKMASK));
 }
 
-static inline struct hlist_bl_node *hlist_bl_first_rcu(struct hlist_bl_head *h)
-{
-	return (struct hlist_bl_node *)
-		((unsigned long)rcu_dereference_check(h->first, hlist_bl_is_locked(h)) & ~LIST_BL_LOCKMASK);
-}
+#define hlist_bl_first_rcu_dereference(head)				\
+({									\
+	struct hlist_bl_head *__head = (head);				\
+									\
+	(struct hlist_bl_node *)					\
+	((unsigned long)rcu_dereference_check(hlist_bl_first_rcu(__head), \
+					      hlist_bl_is_locked(__head)) & \
+					      ~LIST_BL_LOCKMASK);	\
+})
 
 /**
  * hlist_bl_del_rcu - deletes entry from hash list without re-initialization
@@ -73,7 +83,7 @@ static inline void hlist_bl_add_head_rcu(struct hlist_bl_node *n,
 {
 	struct hlist_bl_node *first;
 
-	/* don't need hlist_bl_first_rcu because we're under lock */
+	/* don't need hlist_bl_first_rcu* because we're under lock */
 	first = hlist_bl_first(h);
 
 	n->next = first;
@@ -93,9 +103,30 @@ static inline void hlist_bl_add_head_rcu(struct hlist_bl_node *n,
  *
  */
 #define hlist_bl_for_each_entry_rcu(tpos, pos, head, member)		\
-	for (pos = hlist_bl_first_rcu(head);				\
+	for (pos = hlist_bl_first_rcu_dereference(head);		\
 		pos &&							\
 		({ tpos = hlist_bl_entry(pos, typeof(*tpos), member); 1; }); \
-		pos = rcu_dereference_raw(pos->next))
+		pos = rcu_dereference_raw(hlist_bl_next_rcu(pos)))
+
+/**
+ * hlist_bl_for_each_entry_continue_rcu - continue iteration over list of given
+ *   type
+ * @tpos:	the type * to use as a loop cursor.
+ * @pos:	the &struct hlist_bl_node to use as a loop cursor.
+ * @member:	the name of the hlist_bl_node within the struct.
+ *
+ * Continue to iterate over list of given type, continuing after
+ * the current position which must have been in the list when the RCU read
+ * lock was taken.
+ * This would typically require either that you obtained the node from a
+ * previous walk of the list in the same RCU read-side critical section, or
+ * that you held some sort of non-RCU reference (such as a reference count)
+ * to keep the node alive *and* in the list.
+ */
+#define hlist_bl_for_each_entry_continue_rcu(tpos, pos, member)		\
+	for (pos = rcu_dereference_raw(hlist_bl_next_rcu(&(tpos)->member)); \
+	     pos &&							\
+	     ({ tpos = hlist_bl_entry(pos, typeof(*tpos), member); 1; }); \
+	     pos = rcu_dereference_raw(hlist_bl_next_rcu(pos)))
 
 #endif
-- 
2.53.0

