Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4CD1CD1E4
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582938; cv=none; b=lhMFYmi+jKQ0CbuPon6tHHMsun0+D/nhCTzxftw/rB425aQkwSQUOA14eZlGIdXrrg2sGZZhH0MLwWKUvNd4+/4GrhWvB1kwq1aVht1X7s6gpiSRJ7pQAhx10WPVUHvKHdEbQSfRDG5RRqYEuhW6x5EOtYSpjq6BAs/TpZZb+IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582938; c=relaxed/simple;
	bh=F1SDKxvW39Xfts3CCGkbruTkDPnGtIEuPP5ZI0CXH2Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YRFQG7BAgvZJGv8V1yJaYIdb3Djfy5fCw7OO5RxUY997y9sVh3P+BRFHG7Z+vs/FYxC03seuhBI+6UosXlnCGp4y2euPPapRrTi8nEWDDO/fM+RmriLIhAMiN/i0oF5hQ0ouXZFcms4PyWh8yEfmpliD3Np0LSkjqPMmyTXGEhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YFuXX9jm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YFuXX9jm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 77D0E1A0FDB;
	Mon, 28 Sep 2026 08:08:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 43B4D601BD;
	Mon, 28 Sep 2026 08:08:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4E660102F1EA2;
	Mon, 28 Sep 2026 10:08:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790582934; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=N17WfrwaT8JFq2g8OrV+z5QMuqdT9X2Hthg0tk5gBPE=;
	b=YFuXX9jms9ekuglkDR5W6j0wB3MM356hp9zlwzz+8KkfBttaj+tvl9vh+S7b8ugTpdeHbr
	ohaIXzTOHnHeK9DbJJzxQtTBqiRHKJJSzNMYbSzGB+0m2gzwQo1DNyyS0HOdshbAa/sAFA
	+tPNMWYezpnpHym86+ynwaofveHNCGk5c5WofTu1tLUlGtw78V1A/knBoekqTi+UnlXLYL
	WruegtG+DGQD7mWFLRg05oczJNfyIHDWDpa4xZL44cEUofhpjiHQSx27SOdf5NnSQW/vCP
	ShlefIPOopZaSw222QrDXfcns0AR2INdkjVm/92zKu3vjKbOnyN4fV4E+3/TUQ==
From: "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Date: Mon, 28 Sep 2026 10:08:49 +0200
Subject: [PATCH 5.15.y v2 1/2] rculist: add list_splice_rcu() for private
 lists
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-cve-2026-52988-5-15-v2-1-519003db6b26@bootlin.com>
References: <20260928-cve-2026-52988-5-15-v2-0-519003db6b26@bootlin.com>
In-Reply-To: <20260928-cve-2026-52988-5-15-v2-0-519003db6b26@bootlin.com>
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
index d29740be4833..ad37c0584c23 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -204,6 +204,35 @@ static inline void list_replace_rcu(struct list_head *old,
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

