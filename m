Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B531E2858
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 19:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781809705; cv=none; b=RNyoK6SipUb6QFAEmYfRfjZXFV/jxwWx/3eewjCkq0u1NNGfr8xIuThJsRDc0s1qs1z5E6+bgo2xnV26jQGubMr9LlRSLeKHXJr0EirLjdGAjpLz+virmUxOaQsrRrULFIs3XAUfS0kPPFxpKSUGRNKRszmCtxNSWy4Dq802klk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781809705; c=relaxed/simple;
	bh=uWwOFvwEc45Hrb3GxEXn1zAZJItEeuuxA+gHvapbv40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PqvcG6Bhu4qX8PN+keF+0gvc0fD7zP1nPFm3ClEstKh/pQv9D3wjs4AMMPnPbUSs2GKd2SszCJZVbR/LnVOt9wt542Lp/P0/MCvNytweoCj4XtU+jd5EMXOQScHn3H6Hd6EVlfAMXrT9ztlrMkuRzXfKHmJvye0m6H20/OBL+G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wl+1BwnS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wl+1BwnS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB341F000E9;
	Thu, 18 Jun 2026 19:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781809703;
	bh=yb0UAf/yqEzSFlgCt9l1ukkfO49DR5r46K8a0+iuXc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wl+1BwnSaF0e1zPO6Hjz4pqyhMobWPmZX/O1DE6yfrOmyuQCwsjZeKTxP6nFWh/zj
	 zEBbfGD79ACdQi5pWitRwY8yua37p0KlzWlIpqDnaFqCgdGFMLJJaCLfLuiAna0kq4
	 UMDE8u57nleVTTyGFUq+CR7vKvICdBmGHNKIKmgXp/zf2AOmLZrlRBLIfK6vIg5SYy
	 ulsMP/bha+qtM986outmHJ230gXBzJrP89mEcdS8VBdCTmDM1RDeVq0KLl77qO7Ecx
	 3UX0Pdprha1vI6hiwiw01pO+obEA3z/WjuDWY9rViresaaQnyy3T5Lfi5guaVj1OYe
	 pH6KJ7vb3VOCw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Helen Koike <koike@igalia.com>,
	syzbot+b8ca586b9fc235f0c0df@syzkaller.appspotmail.com,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] debugobjects: Do not fill_pool() if pi_blocked_on
Date: Thu, 18 Jun 2026 15:08:21 -0400
Message-ID: <20260618190821.985317-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061612-grievance-elm-4367@gregkh>
References: <2026061612-grievance-elm-4367@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Helen Koike <koike@igalia.com>

[ Upstream commit 5f41161059fd0f1bbf18c90f3180e38cc45a14eb ]

On RT enabled kernels, fill_pool() ends up calling rtlock_lock(), which
asserts if current::pi_blocked_on is set, because a task can obviously only
block on one lock as otherwise the priority inheritenace chain gets
corrupted.

Prevent this by expanding the conditional to take current::pi_blocked_on
into account.

Fixes: 4bedcc28469a ("debugobjects: Make them PREEMPT_RT aware")
Reported-by: syzbot+b8ca586b9fc235f0c0df@syzkaller.appspotmail.com
Signed-off-by: Helen Koike <koike@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260511215359.3351259-1-koike@igalia.com
Closes: https://syzkaller.appspot.com/bug?extid=b8ca586b9fc235f0c0df
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/debugobjects.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 49fc61c08ee34e..17ece4d67d929e 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -600,13 +600,23 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket
 	return NULL;
 }
 
+static inline bool debug_objects_is_pi_blocked_on(void)
+{
+#ifdef CONFIG_RT_MUTEXES
+	return current->pi_blocked_on != NULL;
+#else
+	return false;
+#endif
+}
+
 static void debug_objects_fill_pool(void)
 {
 	/*
 	 * On RT enabled kernels the pool refill must happen in preemptible
-	 * context:
+	 * context and not enqueued on an rt_mutex:
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) ||
+	    (preemptible() && !debug_objects_is_pi_blocked_on()))
 		fill_pool();
 }
 
-- 
2.53.0

