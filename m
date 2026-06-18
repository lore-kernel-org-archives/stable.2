Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CD33BB670
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 13:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781790242; cv=none; b=r1gE9MZh2IuIDGMhyyh6u+JK12HwrDWA/r6/q2O+WnoOMU2YcDUgbSR1bvf6KkQazFyyVkGf76PsyS2euW7aDAV4PWPq1DBWySpOFBaEe4EH6u6xcC7G8hp076rJZrqOPgW50NxkAVctiNdykJXS9Gk0914EPc3LHRB+HyBWwIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781790242; c=relaxed/simple;
	bh=6us9x1NiOmrT2gzilkCLY77Ifw/wrPC8vsi8LdIKMrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmG6/3lgNwVXR9ed5sxa5LFFc9whJSKtnSvQSWvbhpls/WRzpTUupNWV2t5H+CDzrWTgwmPdFjGU5zhA6SQM1yfqzuB3hZ8j+xmNGY4iwrKxq2xmdf0NV5GvzQJqDy3GDNyCCrf5uEQqTXHzvfPJmCyl0gmRatd6qF3kKZhF+z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9Clib0h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9Clib0h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903B71F00A3A;
	Thu, 18 Jun 2026 13:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781790240;
	bh=C6mOq1VflARWvG8uWvrc7oqxqhV2YHUW4TaURv6VtiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z9Clib0hbZr5dHhwvJJufQTyCd3AsHe5oeqO8gbtjoPCwNKzx9NADc/00qbH0y9T/
	 S7FFa6Ih/0BG9mWSSAcQ2L4yDvwopOP4yXUklwqBv/dgrBe5RwzafAjqzaCf/wr0WK
	 QSCsJ31ET6kmvRb6/FjYHLMUQG1/kIxPdLFq5Q8o8jmT1nSPgHo6P+QXULL5V1i3LM
	 q9YfjN4pMp04S/+S5k+Q/Tl5xNvX3uyv8R8RL6HbaIuystIdqVQJjE6vLfMAoNUz0W
	 9jAbGpvoX8rv5l5pydIu+/K6mwLn9sYs766N9LpsTnQgt+WuVJxJXohxzN65FDRnxe
	 SyaZXlJRTBu3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Helen Koike <koike@igalia.com>,
	syzbot+b8ca586b9fc235f0c0df@syzkaller.appspotmail.com,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] debugobjects: Do not fill_pool() if pi_blocked_on
Date: Thu, 18 Jun 2026 09:43:57 -0400
Message-ID: <20260618134357.720470-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618134357.720470-1-sashal@kernel.org>
References: <2026061610-amber-humiliate-b27a@gregkh>
 <20260618134357.720470-1-sashal@kernel.org>
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
 lib/debugobjects.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 970b310a2ac44a..4094899ef6102a 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -597,15 +597,25 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket
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
-	 * context -- for !RT kernels we rely on the fact that spinlock_t and
-	 * raw_spinlock_t are basically the same type and this lock-type
-	 * inversion works just fine.
+	 * context and not enqueued on an rt_mutex -- for !RT kernels we rely
+	 * on the fact that spinlock_t and raw_spinlock_t are basically the
+	 * same type and this lock-type inversion works just fine.
 	 */
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible() || system_state < SYSTEM_SCHEDULING) {
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || system_state < SYSTEM_SCHEDULING ||
+	    (preemptible() && !debug_objects_is_pi_blocked_on())) {
 		/*
 		 * Annotate away the spinlock_t inside raw_spinlock_t warning
 		 * by temporarily raising the wait-type to WAIT_SLEEP, matching
-- 
2.53.0

