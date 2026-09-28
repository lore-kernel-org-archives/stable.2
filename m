Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E9445D18C
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583022; cv=none; b=r9QCcphHPRpJEuGbpp7WB1sjv1hlHBZFP2USWIZdOFNrFv4QCigPHBDOKC8BkC9/D6P6L2TYWdaQ2m2T4YijuOtBoOTUm98Wi2wWaW90t2vCgJS1HLYMZA6/qZ4BTyjENwi6/Cj+3fOa5xOOdarw+SAKR1eggVgWrQeTKqZbY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583022; c=relaxed/simple;
	bh=7b4bXIbvya7cES8jMYykFgJbMsLy+TMWpoxwPbfwtnU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/QCB83l30c53p7NZERdBwMzn+ay11M1HCJzI6NXAc8QQo/6ygyylDiCaSBbe1FeUX4mBGKOkQF9sKht8KuQKFiDC3nDu+DvoszsbGgO5qaVrKDJ0ZTpvYDv6sbAnCvDCeZEY6w8BykRLhUBC87775ycYKX4wP/hK7qZczlUVo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UVcHw8pj; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UVcHw8pj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 155FCC5CD4F;
	Mon, 28 Sep 2026 08:11:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 04577601BD;
	Mon, 28 Sep 2026 08:10:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7E235102F1E57;
	Mon, 28 Sep 2026 10:10:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790583018; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=qfb9zISarg9hFoGxoc6psjQWkn5i7Qpgp6Xp4X060wI=;
	b=UVcHw8pjDGx8VESu50WtnA6L3w+MGQfPWEijZGB+ylzdBUDzF/OIcSYnYtOK1/5EkRg82m
	prPiw3EBRohFFQBiXIdRrv3jnc/ukLSLFI8xY3Xe0Yj5VQTM8Nb6nJI2RTN8/+DW2qsPkJ
	9rh98FJHHoJIlWqDKYdHnviey1vzpScQwUK07WntP9Y4BbnvRWPXt0wmfzMirsZY2H9wCi
	QC1xaJE0f8jexU8eTk6EVHYPjEV41UuwMLcOvrlAwvzyC4QhpqSy/DXlSeSeQpwRCdfNA9
	sOWkjbcI0plhnmNGLmqHhAmw4d1EKdXjHeWKtNFxCTtGTgPoU0HUGvpr5Xx+pg==
From: "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Date: Mon, 28 Sep 2026 10:10:12 +0200
Subject: [PATCH 5.10.y v2 1/2] rculist: add list_splice_rcu() for private
 lists
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-cve-2026-52988-5-10-v2-1-d44de149a5ac@bootlin.com>
References: <20260928-cve-2026-52988-5-10-v2-0-d44de149a5ac@bootlin.com>
In-Reply-To: <20260928-cve-2026-52988-5-10-v2-0-d44de149a5ac@bootlin.com>
To: stable@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>, 
 Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Sasha Levin <sashal@kernel.org>, miguel.gazquez@bootlin.com, 
 thomas.petazzoni@bootlin.com, 
 "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit f902877b635551513729bdf9a8d1422c4aab7741 ]

This patch adds a helper function, list_splice_rcu(), to safely splice
a private (non-RCU-protected) list into an RCU-protected list.

The function ensures that only the pointer visible to RCU readers
(prev->next) is updated using rcu_assign_pointer(), while the rest of
the list manipulations are performed with regular assignments, as the
source list is private and not visible to concurrent RCU readers.

This is useful for moving elements from a private list into a global
RCU-protected list, ensuring safe publication for RCU readers.
Subsystems with some sort of batching mechanism from userspace can
benefit from this new function.

The function __list_splice_rcu() has been added for clarity and to
follow the same pattern as in the existing list_splice*() interfaces,
where there is a check to ensure that the list to splice is not
empty. Note that __list_splice_rcu() has no documentation for this
reason.

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Benjamin Robin (Schneider Electric) <benjamin.robin@bootlin.com>
---
 include/linux/rculist.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index f8633d37e358..5be4dd041f98 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -213,6 +213,35 @@ static inline void list_replace_rcu(struct list_head *old,
 	old->prev = LIST_POISON2;
 }
 
+static inline void __list_splice_rcu(struct list_head *list,
+				     struct list_head *prev,
+				     struct list_head *next)
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+
+	last->next = next;
+	first->prev = prev;
+	next->prev = last;
+	rcu_assign_pointer(list_next_rcu(prev), first);
+}
+
+/**
+ * list_splice_rcu - splice a non-RCU list into an RCU-protected list,
+ *                   designed for stacks.
+ * @list:	the non RCU-protected list to splice
+ * @head:	the place in the existing RCU-protected list to splice
+ *
+ * The list pointed to by @head can be RCU-read traversed concurrently with
+ * this function.
+ */
+static inline void list_splice_rcu(struct list_head *list,
+				   struct list_head *head)
+{
+	if (!list_empty(list))
+		__list_splice_rcu(list, head, head->next);
+}
+
 /**
  * __list_splice_init_rcu - join an RCU-protected list into an existing list.
  * @list:	the RCU-protected list to splice

-- 
2.55.0

