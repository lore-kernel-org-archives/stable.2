Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3165E3DC4B6
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791234752; cv=none; b=do8LuHWeU37L0sIPFBdMWjSEVKaKWNSL+3T1tQvhy1GhVoGZF3fGqlv0fxZjh5FQyw2sKPHh7W1/JtXuknRRlgyZ+psod0NmMYP++xYt1rXcuYrLCJfUNNV6gWk/hHudKeumF1lHvpq0MT3snSIKVnScS+stxQwqOuyS/c7tEzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791234752; c=relaxed/simple;
	bh=+8P9N6kJjJm1mZRRoJM78zckOSDn1Bl5DPhHk7pF3w8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ifz7EmQ5f13AABzK9K3q/h0A4OCWbS6npLg7ezsTt9hWofLWPJxOSN7o4g5HeHUoCj0qLChSLRzRMidfgM80+9r0hybqgbZZ+ZUFTgtm3jsSsqYPHCJBI1Y64Bd9bbsLNLMoLzs4htiLbZD1o9ShWe/q+7eYztVEML2idj5i6xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKLerwqD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKLerwqD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E781F000FF;
	Mon,  5 Oct 2026 21:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791234750;
	bh=jbx4YGhLgjdDwdWoDaPASXP54CyyYN4aPNQkT6rldr0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fKLerwqDPc1MDlrQfoqEMIQqUoJmvk5Oau2blkXUjbOAXj/pZf7teVQg3/XgWdY3N
	 n+/SZ6D+2185nRSf91kozH+2vjRj6Grh8RBWZmEe5gCpS2QH0HOYc2szXN9agn1mBo
	 av0IqGfl28IjFt/kJc2QsTEsNZrLuajmSgPVnr0VO1txl00Cj0WzYOwBMg+qvhGCZV
	 Vs0CgOciIBxCMsXLvzQ0K+PUTgnTS8YegtpuLvdC7kQR7I9h7+PpneY9FXmYuoM4b9
	 RqK4H8U0DHT6Kf0uJU2GuZv1Bd/uQIFyPL/HArBb/dafGwiNKpoXnPfGb34jbxrQWE
	 Hts3JJiEEJsRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] unwind: Shorten lines
Date: Mon,  5 Oct 2026 17:12:24 -0400
Message-ID: <20261005211144.3318946-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100506-cough-hurled-681c@gregkh>
References: <2026100506-cough-hurled-681c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit c31b9d2f589463a7cb286467a618b3b598654890 ]

There are some exceptionally long lines that cause ugly wrapping.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://patch.msgid.link/20250924080118.545274393@infradead.org
Stable-dep-of: b9d1fdc6f4ac ("perf: Replace perf_event_header__init_id with full header init")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/unwind_deferred.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/linux/unwind_deferred.h b/include/linux/unwind_deferred.h
index 26122d00708a2..25f4dffebd1bf 100644
--- a/include/linux/unwind_deferred.h
+++ b/include/linux/unwind_deferred.h
@@ -8,7 +8,9 @@
 
 struct unwind_work;
 
-typedef void (*unwind_callback_t)(struct unwind_work *work, struct unwind_stacktrace *trace, u64 cookie);
+typedef void (*unwind_callback_t)(struct unwind_work *work,
+				  struct unwind_stacktrace *trace,
+				  u64 cookie);
 
 struct unwind_work {
 	struct list_head		list;
@@ -68,9 +70,17 @@ static __always_inline void unwind_reset_info(void)
 static inline void unwind_task_init(struct task_struct *task) {}
 static inline void unwind_task_free(struct task_struct *task) {}
 
-static inline int unwind_user_faultable(struct unwind_stacktrace *trace) { return -ENOSYS; }
-static inline int unwind_deferred_init(struct unwind_work *work, unwind_callback_t func) { return -ENOSYS; }
-static inline int unwind_deferred_request(struct unwind_work *work, u64 *timestamp) { return -ENOSYS; }
+static inline int unwind_user_faultable(struct unwind_stacktrace *trace)
+{ return -ENOSYS; }
+
+static inline int
+unwind_deferred_init(struct unwind_work *work, unwind_callback_t func)
+{ return -ENOSYS; }
+
+static inline int
+unwind_deferred_request(struct unwind_work *work, u64 *timestamp)
+{ return -ENOSYS; }
+
 static inline void unwind_deferred_cancel(struct unwind_work *work) {}
 
 static inline void unwind_deferred_task_exit(struct task_struct *task) {}
-- 
2.53.0

