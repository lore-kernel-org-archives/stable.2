Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794691730;
	b=XNIWoYjE3G4MP/bkgfrxMkAZhVu3ZIPtFhIS+lqDELCcIyP641iBVFb1JsliZ0HE6M1R
	 afc+n5awFlFss46C2w+mw6OZSMk6EnPykb0nCfUd08o21Q0KcVH02LQYpqLmYEHeYBZDV
	 69gfOc79ORJGslPBmKnnjbdnrx+a9Z914DtNpNjQk4SLhbgg6g4WOq7HRBSxMGKNB0/ME
	 zN7dpycukPB1tJNj/s8rIK5Ep/A2oPKkbdiDghM/tpEGenI+XZ62WWq+/ERMCFKMLnMnj
	 +zhXUiwz8lvIUohLGxr9cqq0CW69yMAKT/HUn/R7Tl9kXu/pRAEISoeprCiZ5GjcsJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794691730;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JkSSNtKwmrKzcRx1tPKCWDhC2ebbc/AhRb15uCMAGxw=;
	b=vpS1UuQTlAgLdfIA0bVFGULOg2kUpEhftLWQQeTav9eCxN2oX12oAiyUBfIyH4mx2EQc
	 ZY3BhVZPscpOAf+E+RNOdrTZklZH3NjijNVoJYjEKOodLkyOvCSNuzNfsmqWBiaJJFzit
	 4eM8QG/gPhP927OTFZzqJ6YA3smC4nFoNURiF1ZyZTXDT9jh+g+juUF/ZuD27drk3YGC0
	 xJ8iCiKVGMKSIrna97A8CTECBTyaGlb+Sqre65++jybl1Xb5Om8XImkymRjRl56Pm5TLL
	 YIb+HVm2plzn9Iw1cM+MmGrDGsISGRpX0ebrYW+iPHLYxFEHHHpHdpFQ0USwPK7G9xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8bQqJWD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EA1606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 21:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R8bQqJWD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD821F000C4;
	Sat, 14 Nov 2026 21:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794691729;
	bh=JkSSNtKwmrKzcRx1tPKCWDhC2ebbc/AhRb15uCMAGxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R8bQqJWDGvWvQsaeu7xhquHCGJmQT/32KYYBOraHihfg5Cbh6EQKVTZDdKATM3qJ3
	 CvdxG2Yd5C53iWV8acGf9c+W2FRsz98r1FCh7VanotzHyWa1Grqo8dVf7EDehvndRh
	 8El7SwmQf4Vf57oA7HSd9iXg3+6k6dAtKbY+LKR1n9Axe1o4fWiTIzw0zJMQkvF9hB
	 xnNs7K9lIZnvVVytqJ3v13aXjFtjydRlVGrsjYGaSUHyv2OX724oLiLhuSP1f1OvQY
	 2hW/GSCIvbyDzEiuFe8c7XrFXG4aEGscXex1xKlXGN0MtmqVoe5tDHo4ujM+NvTHUy
	 gQO+qD1cn77+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qiliang Yuan <odys.yuan@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] srcu: Add list_splice_init_srcu()
Date: Sat, 14 Nov 2026 16:28:47 -0500
Message-ID: <20261114212826.488140-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202910-failed-5.10-d06917d0ba22@kernel.org>
References: <20261109202910-failed-5.10-d06917d0ba22@kernel.org>
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
[ sashal: Adjusted helper insertion context due to missing synchronize_srcu_atomic() and completed-state polling definitions. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/srcu.h | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index e35168e0b9523..f61dcc59277be 100644
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
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 
 /**
-- 
2.53.0

