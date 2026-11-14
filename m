Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794688467;
	b=vsuCjlPx1bUf5cEW6eRNHaytMxOnUCOn4uyK6bZs3Y+XeYIbYMyhhgAVv9/JDh2OwikH
	 Msncz5YF0fE34botZa0R4wOFd1ZhKSHSLMDUSGfpttLpOVlea7n7Hdcw+u/x1AbNq3Rt9
	 nCkxM5dTOvbQYQkJzPb/HbqYkQb3+HG0Qw8sJ0MthQ3uRyIJsinNQAA6YcVKhJQKGRy8K
	 KDh/GUVDFpcg6JRCVs4wLimdtS2202DKMgGsSeZAGuEgPqGmoxL0on1DYTuV664ZcRsHp
	 /g6FyfFg4J1spqgZ6OTk+eFjdN/6C09YGACFfZeojK42eRhLe/cPxdv9BvBekixdQVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794688467;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7Xg81rqXsgfR3pFlxjfOvcH0ZHqxm5q1OVtcPcZf9QM=;
	b=QH6Lc5uEtayL7O0K7bcUxopgkscysoeKx3lX9jHnnzevbuRU/c13hDG9qonuC1K8KDEs
	 OSZ9n53RgM7JuiC0hJqivIMRTTih5oArp8okP6VzH8yZrkzz3ApA82D51DkP9QWhIeNl4
	 jtb6YmGNUyB953l2wQUXg3VgAJzm9Jnz8ugOG9zVRx7cWKGqJgqC1GuyocERPdHSVxnMv
	 o4NCQMm6T/QId9KAgR4nhEsiP/sAMTCjLJ1Qn2AZKa+7glBcNnfYVNe4C5q5E1M2LHVMF
	 oQjS5XGMKRBFwoHrP7rsh/6LL6NN+/vcRy0Ed/Fx7BZAIwkXQxJAxjLk5ow4fqWNewA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LUvjE/89";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25906606A335
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 20:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LUvjE/89
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B441F000C4;
	Sat, 14 Nov 2026 20:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794688466;
	bh=7Xg81rqXsgfR3pFlxjfOvcH0ZHqxm5q1OVtcPcZf9QM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LUvjE/89/OvPPy1WEaZZrxWSEP9OdHK7niBvuB3n6rdF4TKXJDzaXOYRQ6f+D/NNU
	 KJlbNpLvCYOGqVJawJDRo0nO0OiRNkLQp1Up3wiC2tp31eRj/+FpWBEgv+cN5XKek0
	 M5XfHTnrhpGo6s45ysbcChf15HwB9XVZbbE426qK6O2gL/VGEgDQ22GPe7XPs+hszh
	 /+Ql0sOSH0t77oyEnLDO5kChgyI9rGHDNmIurp4phrM0eQ64034EXoRNWF8Gxun/NF
	 sAyi8tTB6H2oWNT5Nr5evjo/FCBKBNjpy2yPiqsGhgm/MPFuuvTzEsqeGaCulznEK2
	 V/UsThXRmXFYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qiliang Yuan <odys.yuan@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] srcu: Add list_splice_init_srcu()
Date: Sat, 14 Nov 2026 15:34:24 -0500
Message-ID: <20261114203403.478369-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202445-failed-5.15-d06917d0ba22@kernel.org>
References: <20261109202445-failed-5.15-d06917d0ba22@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qiliang Yuan <odys.yuan@gmail.com>

[ Upstream commit d06917d0ba226206dbd606330d73a8eb1e3029c1 ]

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
[ sashal: adjusted insertion context to place the helper after the SRCU polling declarations ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/srcu.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index e94687215fbe1..79be23b6953d2 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -18,6 +18,7 @@
 
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
+#include <linux/rculist.h>
 #include <linux/workqueue.h>
 #include <linux/rcu_segcblist.h>
 
@@ -64,6 +65,41 @@ unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
 unsigned long start_poll_synchronize_srcu(struct srcu_struct *ssp);
 bool poll_state_synchronize_srcu(struct srcu_struct *ssp, unsigned long cookie);
 
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
 #ifdef CONFIG_SRCU
 void srcu_init(void);
 #else /* #ifdef CONFIG_SRCU */
-- 
2.53.0

