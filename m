Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794685434;
	b=auaQsXGrvwDSMKiZtZkwt9EIecfJcq/yjaCHdiVM8Bl/2sY67aQjED/1SA0xEH43cTNA
	 IT/7ZYdFAKlNdOhIISORREg+ppnQVeq+9C4i06h37JiI3IcoKiBhWMegBHRUEQnbHvbD4
	 3akbL5DdAmqEpqEdA5phH3qyo+QnlVbak1n/3/1Yg1ncR4/G6r5SU0YO1Dw3iBUbT/7gd
	 0WKUxQe0Z2XxfmbuieGGJtG2NG0jjX67zgC81ZuCq8RHz4EGhUWLd4gko1EhEGwjJAQl1
	 km/7y/Df1THQyGU91iIVHH7xNT41tkMeCak1HGPaLvcTnBROfiJZjGWFZjenblKywrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794685434;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=rsXZ7d4QFn0NUg+8/La6gaeSrqv6Sy38QEAOiwgBoiI=;
	b=u+Uu6Mb67qVol1I5M7WHdALhS6wLmdiVCA01HCBkWjp2a3iGgpLH+ZWruRxsg9k+Pf/T
	 YrkbCO45PhM8Bt9yAoIfjW/bu40OFVh6bbo6rLsXnHsPNhllLxB4gXNN73JPwpw141WCE
	 u5YkKwOlvh06sfjDDHyPUwwqh/+pN5XYaAonv2144cZuZO8ezoY171n222S4y//i+7yWL
	 njGCTs1Dax7c69T+LL0vT4wJ1e4vhrvO7WDwfq/VDWa4gXW/N+h6J2CgiljOpiqjo0OLT
	 /DJBeVxbwTg5vltehdeIGo8mrcThGUWKmZQohxcX37p44CiaDy1s9JEg+MhJjfP9O/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lpm6ElOH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F58606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 19:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lpm6ElOH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5B901F000C4;
	Sat, 14 Nov 2026 19:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794685433;
	bh=rsXZ7d4QFn0NUg+8/La6gaeSrqv6Sy38QEAOiwgBoiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lpm6ElOHD0235euwr3EvfumLL96ZT2EvX6Bl+aUJNhIjqqmpLcL8EljNagOQXzGZB
	 LhIw7uDc/zBm5cKVIaRjZbuEHImrPZFAfGtHB0b8rprM0C0/bw2Ull8bJmX3ndi1dX
	 XqGdV5WAHOQmrOxyl0GAhFI2++pH+0tsBwkXVO33DQFB5JPjdY6/mRzM2tqA33blIr
	 uAukdZbjUlxJc7f4zQhpVwHC/wOCXCKiZDik7so/ZmbYONXHiHnGEA6r44tg2tJB45
	 bC6/jqW1SJMFXpgP+y5YvSOwRKl+fpxdNtxDOZAnL5Vh/LyL+Mi5B0Ao4+dHQDlKoK
	 jyJv1ySVoca+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qiliang Yuan <odys.yuan@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] srcu: Add list_splice_init_srcu()
Date: Sat, 14 Nov 2026 14:43:51 -0500
Message-ID: <20261114194327.449275-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201944-failed-6.1-d06917d0ba22@kernel.org>
References: <20261109201944-failed-6.1-d06917d0ba22@kernel.org>
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
[ sashal: Placed list_splice_init_srcu() after existing polling declarations because synchronize_srcu_atomic() is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/srcu.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index f9e1fa7ff86fc..676dc3490c058 100644
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

