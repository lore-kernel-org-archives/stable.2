Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB4F46AA9E
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790582438; cv=none; b=HPfFWBcvvblG/7mQ7xK4s6gcxOyvikdEQ0sBMDUxAqIgyndaMJjOPGTcoWU8CbISlh8a+kXkgyODXCgCWWBOYef7S8F26z6VVI+jFz/VjXP0KB5arS2m09DLv1++O7hezTCQpuOc0lxfKB2ImVLQnWp6IP8S6LOu5oYfUHDfsoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790582438; c=relaxed/simple;
	bh=4McGC7+kPWXXLacBdooocm1vpZvozYX9dnyAvqbLFP8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XklEav/aP9CouFCZf2wTU4gf1a2p6evSSPeWcVVZmu1iAV3BdwuIN+2TEfyXzIRduIRYABzTBQL3yScJfRHaqG9/RiV0p4qBxeJLKzcj8+BUqMNAIgufF8sinWPHkzqwOmBqdwnujNRTWPEZxkY2emmGJfbusfutX7AayAaWazk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tQHjme50; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tQHjme50"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 05996C5CD52;
	Mon, 28 Sep 2026 08:01:22 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F0DDF601BD;
	Mon, 28 Sep 2026 08:00:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 98F53102F1EA7;
	Mon, 28 Sep 2026 10:00:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790582432; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=9tfvcfmSXOyJ30BVpA1wLl8pMXQkYFsudYJxA7gUocM=;
	b=tQHjme50Rv4lprmqFVvt/MNaNuV7ReHQUk/phM8wnW5gAvEB49EwutBAw1BXbSVy1vb68h
	3nZPOlnqc/Zz+OLxFV54Yz5jpN54kow+aEEDK+pYyPAu9pMCkHMsnFEKCXxqrQ5Sh5erO8
	dfsm4wWqoZmpDmI3ifSzxid4bPORot+MdYai9O+2Hr5Nfe6eRfErCIzYbY5tc4+fGnyg5G
	vDEc52xKB0uKk383glCnkr0Aj9N2stH4vgUQ9nQBwHZtyBoM/10NLCmnnRhG3hGOaVtLcG
	LX2Pp+sCy9G0QRNinFhbTULZQ0cTZKPxc0jQF97wTyiO6NrihGO0XsA9Fxk5zA==
From: "Benjamin Robin (Schneider Electric)" <benjamin.robin@bootlin.com>
Date: Mon, 28 Sep 2026 10:00:21 +0200
Subject: [PATCH 6.12.y v2 1/2] rculist: add list_splice_rcu() for private
 lists
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-cve-2026-52988-6-12-v2-1-74d198e65cb2@bootlin.com>
References: <20260928-cve-2026-52988-6-12-v2-0-74d198e65cb2@bootlin.com>
In-Reply-To: <20260928-cve-2026-52988-6-12-v2-0-74d198e65cb2@bootlin.com>
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
index 14dfa6008467..2e4d990f07ad 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -207,6 +207,35 @@ static inline void list_replace_rcu(struct list_head *old,
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

