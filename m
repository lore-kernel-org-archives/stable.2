Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794681972;
	b=o2dEHeuI4fGyMktIwLr3CdWrrAWKg/+EGNCzWtNgJJBTzztRF4ANOrPalPZj0RI20GjD
	 9tjAnCG/dg1jPFwnFsVXVKae7dOT7SMf5qOh6gba/5CCeomz8xPbZjfVKH2SG0ZRbMtz7
	 v9un+L5wgkXslzKqQtqsyMUkLG+scNYsV9LpQI4Bk73R9kHqeJ0R8F8ZEcBKYiOyN8ekr
	 vv4Q0jsF6Lk+0YSwl27rxYT7cFPGdkgJoQuPH5Ak985sydevJZpPg4Jk4yQA9v12XwhsY
	 iKrf+tiDJ8x2NOX+lIjNKVpuNoUAripr87QR+u6Aedlatv/zsPIo2gyOW6Ru/uBfd1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794681972;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XGbbjkNmSZUpCU01+r6dxta9Jyu8/XGvQryK5VL8oKE=;
	b=gSKV/zCeXL6+r6CNQnkXB5gdTlj3M9aj688DBdaWfrhUWM+eN3xcgst//YYQTX7Yq/ly
	 AIETSPb2AXssZ2yRwy2UHBtXLoCEPixRM6nU26uOAXW6mwG75vxMuuiEjH7WAQb4gV4xG
	 InfepWj3qmwTyeb4IU3ce3sVQPQolwDDnSA+T9/xMfGDNSz6etQsWtcFSRroJ06aD7U38
	 wV6pywJM8WX5PwOBxf89uACdwAXebR2u2iMbU28eqo5c5dQYPctWozpgukERpEZcais+n
	 O0em6I2W+I4Jnb8AQZHutgtaBQTZ+NkwFoSlsnoZf2HMkbJaaCX8kxkpui3UU5ib76A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dn9il0zL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18B6606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 18:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dn9il0zL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C7121F000C5;
	Sat, 14 Nov 2026 18:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794681971;
	bh=XGbbjkNmSZUpCU01+r6dxta9Jyu8/XGvQryK5VL8oKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dn9il0zL0X7KVWNLUUDzn6aqMeOvnmD/NmhnzBvVOCfNrcSeEjsBX0Al/PXhZNTm6
	 GTJ0xInZMM5OhGww8GjOwAbCxv3F4cvZ4FjsHxczfSRqWdCN0Xq4v5+ut2g4UwlKWq
	 r/hJh6U7xdmouspS8ZZxw39acMDhFSBnqcIPfgs5e1KNBRIqdy7xFMxGqSHChwRLGi
	 QhMG+E/QpL/UVF6U/pcXD+A0r2wUKtI7F4Umz30knyQLjVTFMP8ws4iFOZdTn8tneS
	 Ib0BpnlgMTurkgxjX5ALF+NOsGux3b/qgJutgbHLDA9z8D0HAubMN6bIey9YPdcAqG
	 fuvYIP/0k+ZpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qiliang Yuan <odys.yuan@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] srcu: Add list_splice_init_srcu()
Date: Sat, 14 Nov 2026 13:46:09 -0500
Message-ID: <20261114184544.402778-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114184544.402778-1-sashal@kernel.org>
References: <20261109201443-failed-6.6-d06917d0ba22@kernel.org>
 <20261114184544.402778-1-sashal@kernel.org>
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
[ sashal: Adjusted helper placement to follow existing SRCU declarations because synchronize_srcu_atomic() is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/srcu.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index f664cba7a80c2..7b5be712a79f5 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -18,6 +18,7 @@
 
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
+#include <linux/rculist.h>
 #include <linux/workqueue.h>
 #include <linux/rcu_segcblist.h>
 
@@ -61,6 +62,41 @@ unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
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
 // Maximum number of unsigned long values corresponding to
 // not-yet-completed SRCU grace periods.
 #define NUM_ACTIVE_SRCU_POLL_OLDSTATE 2
-- 
2.53.0

