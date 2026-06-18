Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33E03FB7C1
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781787549; cv=none; b=VZD7EYNiaVh7JFM5n4PnKkvkikZOoKyCxO7FWPxEv/Z+Ml0BeH+JCjcTx6Zkom2i6ES4nelfVwkuBB8/1caa6W4HUrC8VnrtfWVOY+jRGAIJg79ZPESotd3iYy3zkW8ZTabsPT4IKl07vKlCwpxKeEwCQYGJtD73pj/m1BVUH1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781787549; c=relaxed/simple;
	bh=3u28dOZ17z3lY2ld5kI9JAJCrBjQ8mKIKIo2A+jdFSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uSvefW0O4/VyRP2rlenKg5ZNk3PoQSN/yP73oWFIUB1RZrgu7e0Qvgvw5sezxSrQwTKnvcUIBd9kAYvwl+nuSzSQ5Q3TNl9FezX9tdGhczCR7tep5yVx/QI9WDghc7oy0R2ZAczTmrGXsdVxvma5Z0Tt4s2A3oPfT6+vlIxDuLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7rFxqw7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7rFxqw7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14A21F00A3E;
	Thu, 18 Jun 2026 12:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781787548;
	bh=VstLiPMnjfvNE/Mxd6qPpD+dL0zzEfyFsXb2dE5MLSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K7rFxqw7dsjBH8j+ifnvxPTgCEDFjmzDReGzekVf93lW74bP7Scz69m+tht3wQ1RL
	 SyDzMVvxo6yiP6evmg1pdC/Eoi0yAoVzOYZLsHOCXDAMyPI17axDB/Dd0xsjRGdDO8
	 rIgY7Dsg5lxusjrUrapWeAMauzSxNIUciCP4VMpi9YHYDfyvg9Gog7SOuCUi2ZU4To
	 qHy53p8flCHGueoGgJX4Otpv5ffHg6580yCsgBmONa6rijKP2313/fr4SVReptVPZe
	 d3YX5Vm1u/qKp/sOWHOTK4R2C/7K/GPVWxeJopbHPdHUjjkxAhlsAk/ASnWrHv6nQM
	 AYG3ziAEBMlqg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Helen Koike <koike@igalia.com>,
	syzbot+b8ca586b9fc235f0c0df@syzkaller.appspotmail.com,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] debugobjects: Do not fill_pool() if pi_blocked_on
Date: Thu, 18 Jun 2026 08:59:05 -0400
Message-ID: <20260618125905.692105-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618125905.692105-1-sashal@kernel.org>
References: <2026061609-grievance-habitat-1c05@gregkh>
 <20260618125905.692105-1-sashal@kernel.org>
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
index 9d59b797d1b507..f7fdaec4886aba 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -711,6 +711,15 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket
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
 	if (!static_branch_likely(&obj_cache_enabled))
@@ -727,11 +736,12 @@ static void debug_objects_fill_pool(void)
 
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

