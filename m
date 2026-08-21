Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E783793B6
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787331127; cv=none; b=tquKcnGlyO7kavoT6xipTz0UUMucZVTv0ni+/gl4ba1KG4ddiXwNIwa6vZ6G7S381paIbJKCXQy8XCe8BKTQU+7QSLOk1YtokW33/HhiutO+3+LqBamxw7uAasPsl8ZR5Mq61TnPV9DqSKBq8n6o3JJPAP9ngFkjyuBGDHA8h2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787331127; c=relaxed/simple;
	bh=jWkFIkHo1xWz2Z7Eh6EpEzcX45PHIvimZ6TkGZGZKt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B9FWkeYivDdghgH9v5ZkH/5SVQK/wbx72S3/37uWH5udUC47cx2803bvpfomWztga7HUgFssmdJSQJB09NOSwJKx2xXkhCcP29gc7rQm09tR+JqbyyjzyU7m1RzaelPIHMtMeM1mMGeNjIbS3dnv8yxiF+NLDPRGYVkuZx8Q2w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T2o9X6Kj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T2o9X6Kj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9791F01564;
	Fri, 21 Aug 2026 16:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787331122;
	bh=PfTrkBM2bY8W3ffcfbOrFc5ZLCnTvZMnJKJ4A1lzYaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T2o9X6KjtxoNG68eSBMNQofk20iVK+J0JX5OMsyveSLHR4mlxmX5/p1bvOchHnV2c
	 SNgKXxjZIuQpKNyKh98OEuO7V2PVu1c6/s76wfQpoP+Hs1LOLPXDrnnwq+1cXZL47i
	 IRm1Jo7EpdAf07X0u3GUEYVSrMGUHlJUiVEwZAlk7opg9R/uxpTcxhfWG5+pnao3Qa
	 Lcp8URAmnhKcleHBQFjSi89jksHa1wo7gOjX+gXbLqyEa5gTW+oPBvJSMvlxnekYH+
	 WRlfDQ5s76f44AJu9ozb298e1qRUoYo0Df7a7hFXQCQZ5a+2evcub+k4sp8333epAg
	 zGsGJZqoWwdXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Julian Anastasov <ja@ssi.bg>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] rculist_bl: add hlist_bl_for_each_entry_continue_rcu
Date: Fri, 21 Aug 2026 12:51:55 -0400
Message-ID: <20260821165157.3593656-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081759-provoke-trickle-ead1@gregkh>
References: <2026081759-provoke-trickle-ead1@gregkh>
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

