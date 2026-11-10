Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333953;
	b=kdIaISHYJ1/zRGgfxTxtD9s7FegUHZ2bxwnJtIUXOw/RhFkbgvc2pWwFYjM3yNPGEA1Q
	 qelKn9Cw5ievQ+dOLxNklHyFAcLizDUaPVsZ5iE7yyUh4/MeH1WyrVtRXirrJ0le/MQpw
	 fDbYUtpfvJw/liTz+zEzYxYQA6o9jH9ISN0tqMDBPHphazts13NFXOcHvzLcDQqKjB8Ak
	 2SZLCL11RtXugPRaYGJVEE2trwABDGuHqhtwoBPeNSP0njiNpfKhPlb0eoy666tMHxjV6
	 jZ+GwXJB3pXsasHrMObju50tzRyNfDEoGwSz1tSffJJ8tXDXxtfgTCzeGIzzsjA3pSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333953;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kPqZkjaBhvNJd/6TU9R9f4m9WrBiHIVQSW/DDwaq4R4=;
	b=Ce0006GvYADfCr5l8UldGizGhKdDHjxlmWxuFpHHaj/UJBMyZpNQNTMcXA2QDLnxpl2A
	 a0dp+N5FjNNjlIPIsm+UCGiHhGjnZ7M2Pkaww4ReFQTZ63mfUTQCBS4vej7T2udAaCVMX
	 qdnYNoo00JppKMLl6amwamcen1gyL4TJMOUOFKo7FoQgfVU8Pr8412PlH+sLo0kqeMvwv
	 Ay4CXDwoO6K9Vmz/izauYU6RXMHq0+OaTdMyCpMXq+AtytEesXqTE2T2UVBxSN07wQyvT
	 +GSs+N6pfi+9bYOBTT8vOGGbDHDGndD9PuIT7xSBOwW8PODFiDrJO14rjIowNbwEskg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rb3Cz2Uj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27213606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rb3Cz2Uj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5DB61F0089F;
	Tue, 10 Nov 2026 18:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333952;
	bh=kPqZkjaBhvNJd/6TU9R9f4m9WrBiHIVQSW/DDwaq4R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rb3Cz2UjYujUNJdbzmmxw58U6oXi5BIvB+aFbijOhtpFp2zWaQNQIoyGTNzI9s9fp
	 gRhtwOEloQ1lWp0EUaO+cUhsuQPdeNkLAk5NEPTP9RxK3XwsLzQFFyyN8kQ+TJxpRI
	 WFtB36z0F5yn1HdpLJdM/+Q/2xZu+8LfbstyoJeife6f+KpE5JYvxgE/aMcOS3aFN9
	 CTq/iHq0QXyCyiDnqgdYVx1MRZtFJVeJImmBkPTsPMFt2/WgOCLPMfDsVAfR2Hq3AS
	 tNZo/bvnOORt9ufFwnBnoQwxa5SKRz5IVAI80e5JcvaSa6g6sdLLb3ZjttERTU+3/K
	 cg8NXPDrx2N2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] rculist: Add hlist_nulls_replace_rcu() and hlist_nulls_replace_init_rcu()
Date: Tue, 10 Nov 2026 13:05:48 -0500
Message-ID: <20261110180142.3004034-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051220-failed-6.18-2093bc7fa500@kernel.org>
References: <20261107051220-failed-6.18-2093bc7fa500@kernel.org>
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

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

[ Upstream commit 9c4609225ec1cb551006d6a03c7c4ad8cb5584c0 ]

Add two functions to atomically replace RCU-protected hlist_nulls entries.

Keep using WRITE_ONCE() to assign values to ->next and ->pprev, as
mentioned in the patch below:
commit efd04f8a8b45 ("rcu: Use WRITE_ONCE() for assignments to ->next for
rculist_nulls")
commit 860c8802ace1 ("rcu: Use WRITE_ONCE() for assignments to ->pprev for
hlist_nulls")

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Link: https://patch.msgid.link/20251015020236.431822-2-xuanqiang.luo@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 2093bc7fa500 ("mptcp: fix MP_CAPABLE token migration when cloning reqsk")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/rculist_nulls.h | 59 +++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/include/linux/rculist_nulls.h b/include/linux/rculist_nulls.h
index 89186c499dd47..c26cb83ca0711 100644
--- a/include/linux/rculist_nulls.h
+++ b/include/linux/rculist_nulls.h
@@ -52,6 +52,13 @@ static inline void hlist_nulls_del_init_rcu(struct hlist_nulls_node *n)
 #define hlist_nulls_next_rcu(node) \
 	(*((struct hlist_nulls_node __rcu __force **)&(node)->next))
 
+/**
+ * hlist_nulls_pprev_rcu - returns the dereferenced pprev of @node.
+ * @node: element of the list.
+ */
+#define hlist_nulls_pprev_rcu(node) \
+	(*((struct hlist_nulls_node __rcu __force **)(node)->pprev))
+
 /**
  * hlist_nulls_del_rcu - deletes entry from hash list without re-initialization
  * @n: the element to delete from the hash list.
@@ -152,6 +159,58 @@ static inline void hlist_nulls_add_fake(struct hlist_nulls_node *n)
 	n->next = (struct hlist_nulls_node *)NULLS_MARKER(NULL);
 }
 
+/**
+ * hlist_nulls_replace_rcu - replace an old entry by a new one
+ * @old: the element to be replaced
+ * @new: the new element to insert
+ *
+ * Description:
+ * Replace the old entry with the new one in a RCU-protected hlist_nulls, while
+ * permitting racing traversals.
+ *
+ * The caller must take whatever precautions are necessary (such as holding
+ * appropriate locks) to avoid racing with another list-mutation primitive, such
+ * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on this same
+ * list.  However, it is perfectly legal to run concurrently with the _rcu
+ * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
+ */
+static inline void hlist_nulls_replace_rcu(struct hlist_nulls_node *old,
+					   struct hlist_nulls_node *new)
+{
+	struct hlist_nulls_node *next = old->next;
+
+	WRITE_ONCE(new->next, next);
+	WRITE_ONCE(new->pprev, old->pprev);
+	rcu_assign_pointer(hlist_nulls_pprev_rcu(new), new);
+	if (!is_a_nulls(next))
+		WRITE_ONCE(next->pprev, &new->next);
+}
+
+/**
+ * hlist_nulls_replace_init_rcu - replace an old entry by a new one and
+ * initialize the old
+ * @old: the element to be replaced
+ * @new: the new element to insert
+ *
+ * Description:
+ * Replace the old entry with the new one in a RCU-protected hlist_nulls, while
+ * permitting racing traversals, and reinitialize the old entry.
+ *
+ * Note: @old must be hashed.
+ *
+ * The caller must take whatever precautions are necessary (such as holding
+ * appropriate locks) to avoid racing with another list-mutation primitive, such
+ * as hlist_nulls_add_head_rcu() or hlist_nulls_del_rcu(), running on this same
+ * list. However, it is perfectly legal to run concurrently with the _rcu
+ * list-traversal primitives, such as hlist_nulls_for_each_entry_rcu().
+ */
+static inline void hlist_nulls_replace_init_rcu(struct hlist_nulls_node *old,
+						struct hlist_nulls_node *new)
+{
+	hlist_nulls_replace_rcu(old, new);
+	WRITE_ONCE(old->pprev, NULL);
+}
+
 /**
  * hlist_nulls_for_each_entry_rcu - iterate over rcu list of given type
  * @tpos:	the type * to use as a loop cursor.
-- 
2.53.0

