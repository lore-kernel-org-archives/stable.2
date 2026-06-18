Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579143B2FC2
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781792025; cv=none; b=Ol47+d9TnGghte0iYX5UrZlpPKvfPjzHWm+GOgd4UQLTlKG6YgNv4jTqI+zESouoZ88/N7fP7wMS2TKautaOD82l8F5k+X3ulCSgTIzL6u0ahpmpiurdSIzJZn2wTmwZvqKt3LxO4mvsFWzrbGfYdnfc+uU0peXi+0kxmBrz2jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781792025; c=relaxed/simple;
	bh=DwZgQ33ZS7bqms5nbl0ue8JaNS+VOe3nrHPr9k+PPVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tgnoaE2UJrfnv8B6OePJrFjlF9M8Y7k+nqv+mKVX8piuk4hapYvyyc4/05k7tl3VeoSUKP6joW+jfgtFRGdLRtt/hk0D8bOtrKHirkLJVNpvcxH+CAm1wrdLZ/blSoYDnIboFTw0mo4aOcR6XJUduqkVvO07wohJavGLjl8nIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IvSWdDCv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IvSWdDCv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7941B1F000E9;
	Thu, 18 Jun 2026 14:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781792024;
	bh=aehrTraPV6Mblmer2c6D81tWkH6Ag1jZINaxqlPSDEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IvSWdDCvgObqFrSP1DKVA87o6VKg4Jdy7+Nr1RDt0oyNt4Cgaq1B7vO9Lkh3x8Jc4
	 mWrYJeEielajx/Q5UIomUrukP5UQNSFslFrd5yc8A60K4cJcKMUTgYFkJXm9Gcibxx
	 Ev3JJ5CvRcZI7TqwplPV98cXhkS+HH7zl4Ovjwk+8Yioiz/ALdb1Ui3x91yAL0ndl7
	 gpja+bR+gNILln145O+V340tQDCVNpFweTfOJa/DWCAbGfotj3S8grRnN5g3INGO+L
	 pHjwliCAgWpwV8lgQubP/i3sbWjab5tGUdeRyiao5bhXQoDMXcsMHGp8fWnvG7sH/G
	 8ZgboPHlmxqZg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Helen Koike <koike@igalia.com>,
	syzbot+b8ca586b9fc235f0c0df@syzkaller.appspotmail.com,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] debugobjects: Do not fill_pool() if pi_blocked_on
Date: Thu, 18 Jun 2026 10:13:40 -0400
Message-ID: <20260618141340.734280-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061611-defective-unbundle-fbc8@gregkh>
References: <2026061611-defective-unbundle-fbc8@gregkh>
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
index 8c3b483a8fb44a..f9d53a0af4238f 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -597,13 +597,23 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket
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

