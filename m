Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274152;
	b=XI7/emPzio9JS3yWCH1IWFIpSxUk+EOZKXzglcZp6nfTSDAb2LMheD31awdF/jQ6koNg
	 E+blMAYeAQ+HRFXf44TGTehgODkq55g0DbmyJypnn11a07L23FAHyEDUOtl6mjnV++bGL
	 KEatiL+OutDC2BtBYxeDScJlCjmS7qDJYW4UrGD9ced3sWvIYtG/GVz+h6tl0Au/GaMdq
	 N21tKnKu4X2Tb0Br/vki2PD+espkk5IWCSrwZuRNBqNnfV2TPlHwP8obCsLzC8PdJbHiO
	 GyvPMbfyBK7L7SPlm5q0xwE4PuVN0ybdcg5u1lsUhUaVJYVad5BVxZK+wpNZri9Uu8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274152;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=vm37KwdAHLnVqPeTEF5uhTgE6pnEbEunLqd0dTHDp7A=;
	b=qD5tU7X6008TE6ddhPDoi77wpvfPH+0lRzn6JMBoSn8EMHzeLc1bfsEu/ZmSdpvGzrTI
	 FEm+XsgKnLuGYChioOrcQWWduVzC8bnqv0L7ZI07sARtOCi1tYU9NWePO7q3DZmyS9q5t
	 JaAxelaoAAglG8OfTm5K7vb8ZOgZIc61gGIgif2DYnPcndzuWpNaisAxi9rzEJH8XTcQJ
	 tqa4J+ygS66S8mQduVLMIymYH2296Tzj/jMvIBeVe00k4SEg0YzWKBJPqBzKeODxCIaFf
	 ecU1iP9Ee0xTiq9ZAuGhAUHQggOoUKoNxwEhtUB7cXfNhdHEtlZWsZMR2CZcu5lPHLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+whmNPn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E01F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+whmNPn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A8291F0089F;
	Tue, 10 Nov 2026 01:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274152;
	bh=vm37KwdAHLnVqPeTEF5uhTgE6pnEbEunLqd0dTHDp7A=;
	h=From:To:Cc:Subject:Date;
	b=S+whmNPnBJDLTWl906fMrHiiMaFXANNnmaEGtaLFWkSex/5LLDvsDJfL76aqVGsMI
	 9AzKUdPuUJ3IPJZ2rQAimcNW4Hi9S6LdzRFqElROe506AWn7neuwDDnaW0YRYUGD1T
	 69SqJfb5nJSFrPxHAz9Sdvfh4HSxM07TVmR4g4k6YKN4RpGzXxsdiQolU+Ko7bx/N8
	 M8JOxxwPi6TLuSrznJnCH0It0zDcHDBsP3ZFpT4CaGfUgf+baqrT7Jx+u9FyvkOO8z
	 5KPNcOmGkuKfUyAXHSwt2y3nh0C4vJS6XfJcq009CxDk+NROnkNJHPSfAButyn9tVs
	 0JNTeihSxSBHA==
From: Sasha Levin <sashal@kernel.org>
To: odys.yuan@gmail.com,
	hch@lst.de,
	paulmck@kernel.org,
	kbusch@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] srcu: Add list_splice_init_srcu()" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:29:10 -0500
Message-ID: <20261109202910-failed-5.10-d06917d0ba22@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x d06917d0ba226206dbd606330d73a8eb1e3029c1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202910-failed-5.10-d06917d0ba22@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




