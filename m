Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1453EB0FD
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 13:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781788068; cv=none; b=c4PNpYjePerycDuvcJWdtW7mKPLE2h+2c+f4gfFvXpl5ffkHFm5DKXu1tVjiXlLihD9BKBTb47UdeYznTewt+VDbhxg5g45LZhGCKOCdV75FzGKv1Ot0hnsCycyVbR8T7Is737iDO8fItQC7s7ntsW3+LgOEET20uu7zStgIrGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781788068; c=relaxed/simple;
	bh=hYE5Xcrz1mus+/4ZJzj86fcps2RafD1ZMa/1jh/fyTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMsg8ZuTqhjOoNZkf+Nn+HXaspQj/cRYAaD2onlAHNd2B+5NvFv2n+g5DC/fUsLk1zClICE+9yVLbKftssVfSWSC4jXqSVesBmPn2dSScPJpDtZN6EP6QzvZPhnBK+YPQvJ0taguKdbrKQzYrSSdPTT2yIxlgGPmpJC5B69rG7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYvWsBhA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYvWsBhA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D703D1F00A3D;
	Thu, 18 Jun 2026 13:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781788067;
	bh=tDER9sCYxQ81+/oFf6dg7osjFmwW/E/0DyKWfr5TzhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PYvWsBhAi4wlJLEqQY5RAofNI4+30/TM40Oo0MmRGcXgrE9l0cTbMsPzmGNcedjGz
	 boZMmBD0Mso6kblOM1Y1++TE9KX2l9YjofTb8e5hnG7/9Ut1Ciqi+ntCGre1l1mbQ+
	 dYjtF68PixSlV30nZ/oItewycKuMpk/sj+NEl8uOS7gKwbM85HZamq2oyITIYpQtzF
	 JH+kuXNKgpe8PGtp0Td1tKepbsD32mRyLzLmlRTCEP4fwfzWl7fn6PVz4xlq5vCpIQ
	 EQ/ZYWeBmfsRPc2Qk0X+OzcgypRBbjYZ3JMxOH4gjo5QH/V/56M3SqnAF/Wgn/T3r2
	 03yu4AQWO1ezA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Helen Koike <koike@igalia.com>,
	syzbot+b8ca586b9fc235f0c0df@syzkaller.appspotmail.com,
	Thomas Gleixner <tglx@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] debugobjects: Do not fill_pool() if pi_blocked_on
Date: Thu, 18 Jun 2026 09:07:44 -0400
Message-ID: <20260618130744.699242-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618130744.699242-1-sashal@kernel.org>
References: <2026061610-brunette-clasp-5eb6@gregkh>
 <20260618130744.699242-1-sashal@kernel.org>
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
index d69721bb78b797..dfb859995f29db 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -596,15 +596,25 @@ static struct debug_obj *lookup_object_or_alloc(void *addr, struct debug_bucket
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

