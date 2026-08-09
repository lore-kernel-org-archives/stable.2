Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9711A0BF1;
	Sun,  9 Aug 2026 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242737; cv=none; b=fbkcHX2dmyB5WH0HI5zp8GDo1Vr1GfpyDwQeVfS3LRhkH0cIhyAb9AgoqqR8+ePtjdbYWv8cRIoIz3RDm3ab7vd9WYtUHHehTYyhVRaVRwNWpiDKVVZA4xBA4uHYZyI0mqJFnQLCuTer6p3K8Z91vfZBzbceqXIstLrTWFZjdnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242737; c=relaxed/simple;
	bh=Nz3OSV1ZyAgSdAm0VfF9pGpSvkaRgZa2frgmYTSJLuI=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=AU6y5zX1C4QoRL11HbPzHuVprTsX193oCH3b3bnZNbuNTaWnmFm9Wxe0I2067N1yz+yzdWXY/F5yEZCL95LdNWrR6/qcxZCd2BAFLg0sUR0NKA/beokKc+N9SlsM/LKWEI/addEaTHo9lugbpPs0MOosrki3FjPsm+JpICqdFxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rfk3+Skh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rfk3+Skh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5432B1F00A3F;
	Sun,  9 Aug 2026 02:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242735;
	bh=carAygDWo2gMyBfxlUBqWt9GVu4GcVCiEGXoTXpM3YI=;
	h=Date:From:To:Cc:Subject:References;
	b=Rfk3+SkhOPL5P1fLg/+mvaxcJFavlSGy1zAD4ZxMHacz37iV+E0zq5UkXklal6KSD
	 F0vqLJQJ8rinXWV8K1tDGjUeEY7Y9ufGaq494zt5SXi5i+kG9BpuCtSWcYykRx625M
	 NwhAwS1sObZm8/7+u6t7WqceaKWIf/FxuLYCmwNbPezspYXDsLlI9grebyrScwxbvh
	 4IEy6joZEvzGko9V9BOah1LJR1lmV6cTSodM6PrqCcGVKbb1bv8PPdfuOjbTHxIxaS
	 pZeoiSM+7ryOodCgVckY38FqrhtOFC3sZeB0WtuMoipK5DF/T+Yt1o+EYHaKa6+UcL
	 Qt7+JAc6a/Qkg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wstKn-00000001N3F-2pPD;
	Sat, 08 Aug 2026 22:32:21 -0400
Message-ID: <20260809023221.529998042@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 08 Aug 2026 22:31:46 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
Subject: [for-linus][PATCH 02/12] eventfs: Use children field for rcu head and add memory barriers
References: <20260809023144.852271250@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

When an eventfs inode is freed, it sets ei->is_freed and then uses its
ei->list to add it to the srcu link list as the list field is a union with
the rcu list head. As the ei->list is used to iterate over an SRCU
protected list without taking the eventfs_mutex, there's nothing stopping
the iteration over that list to see the ei->rcu instead of the ei->list
and it will read a corrupt target.

To fix this, change the union of the rcu list head with the children list.
On freeing the eventfs inode, set the is_free and execute a smp_wmb()
before adding the eventfs inode to the SRCU list.

On iteration of the ei->children list, at the start, execute a smp_rmb()
and then read the is_freed of the ei to see if the children list is still
valid. If is_freed is set, then the ei_child read is not valid and the
loop should exit immediately.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260808094215.4252430d@robin
Fixes: 704f960dbee2f ("eventfs: Read ei->entries before ei->children in eventfs_iterate()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260806022719.375354-1-shuangpeng.kernel%40gmail.com
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 24 ++++++++++++++++++++++++
 fs/tracefs/internal.h    |  4 ++--
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 93bc4f83b73e..a52458435327 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -124,7 +124,17 @@ static inline void put_ei(struct eventfs_inode *ei)
 static inline void free_ei(struct eventfs_inode *ei)
 {
 	if (ei) {
+		/* The ei should have no children if it is being freed. */
+		WARN_ON_ONCE(!list_empty(&ei->children));
 		ei->is_freed = 1;
+		/*
+		 * The SRCU iteration has a smp_rmb() to make sure it
+		 * sees a child (that may have already been freed)
+		 * before it reads is_free. If is_free is set, it must
+		 * not use the child it acquired from ei->children, as
+		 * the list may be used for SRCU.
+		 */
+		smp_wmb();
 		put_ei(ei);
 	}
 }
@@ -627,6 +637,20 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 	list_for_each_entry_srcu(ei_child, &ei->children, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
 
+		/*
+		 * If the ei is being freed, then the ei->children may be
+		 * being used as the rcu list, which means the next element
+		 * may be garbage. The ei->is_free is set before switching
+		 * the ei->children over to ei->rcu. The read memory barrier
+		 * here makes sure the ei_child is read before is_free is
+		 * updated.
+		 *
+		 * Matches the smp_wmb() in free_ei()
+		 */
+		smp_rmb();
+		if (ei->is_freed)
+			return -EINVAL;
+
 		if (c > 0) {
 			c--;
 			continue;
diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
index a4a7f8431aff..c61481d04c8e 100644
--- a/fs/tracefs/internal.h
+++ b/fs/tracefs/internal.h
@@ -46,11 +46,11 @@ struct eventfs_attr {
  * @ino:	The saved inode number
  */
 struct eventfs_inode {
+	struct list_head	list;
 	union {
-		struct list_head	list;
+		struct list_head	children;
 		struct rcu_head		rcu;
 	};
-	struct list_head		children;
 	const struct eventfs_entry	*entries;
 	const char			*name;
 	struct eventfs_attr		*entry_attrs;
-- 
2.53.0


