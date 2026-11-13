Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587672;
	b=2Q6f8zNVTIfqGg+ZXLUZGhoY71pjAmzUGdH/YRkI0FfMzHBhVJh2asSpovCqTq3SW324
	 fKecEyrZa1lURZOymgyvKcBIG0uovLWL9ZeiGHQ07sN8Y+uy7Nw6SEf868MqJ1GLRbrKa
	 zVZx7M3M1ZPhoVEe0p5bVS///VgOx9D6pn2yPjg87UlqyVAHbA9Rck2K4Ws+FlfJmQ2Qc
	 53rSIjdwmGciCV7+9EStOUKrG//87D44ZYEJemtkKZZDYEJuT3xa1UBTHofMDBjT0USGF
	 3Rix4D0NiIEKAkuA0cL8rz1t8aadKkqHDNUgq727khX7YeAx8W78nD6gdTy5qiRzzKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587672;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dhiSWbZrH5OiWO6dYqNdk8inHhYmtU51NVqMM3WAJFI=;
	b=Kc00BKwiCmiZEtKgrkh5n01FpxzFAAdUahgqve1vvo9Aoy91oIe6iU00l1ArwlAPrHoP
	 4/ogwgyFm+WIoTBSVWq4IzX0RA0hIlZo4y4LcqrRANILUR/FZliUHalFNrzr10w1zdL33
	 k8VbCygo7bNIi0osUMkJNhlvab0mNwxsbhaXPflQftBMjgBxh9anJHj3n+6c268TFqvdy
	 cvnFmJFSuUDrGKVNYtAzQy3qJgQUOz7HEHUB9i28ldxvXyKO5x5MVzOgxt5ILw/qg7b+f
	 qlmbpU5HCNgbMQ058PJ4/K7CB3Dy5lFiMzVP3oWLtX37piqpRoqaeUHbkTY+blCUEBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mt0YfDw2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6D3606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mt0YfDw2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8671F000C4;
	Fri, 13 Nov 2026 16:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794587672;
	bh=dhiSWbZrH5OiWO6dYqNdk8inHhYmtU51NVqMM3WAJFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mt0YfDw24levOU71OROtrCa6j54M1PpLtJgZTHKuB/n8IkgwlZIdPMhOu4w9JDrfp
	 S+GwxPZA2hktds3KetzdjmQTbaDCf25QPdkNt3GH9z4ZbdoLiZXhLP1SBSzk9/bB4N
	 7WBxK+uQVu5LSg3+bI4TvSovO/9OP+pzmETM+JLzFmu9XhGdPWvLIiThT1ZqS0QJjA
	 GwHa7S8CG/EO9mJk5uHVJW75uGzQSML6rJGvQWjzF5vKCdTVhwIVH6ZTZEgYN1bckL
	 Iqta3g+3b4LTapfczAuIfx3swPXHmIpIswtFy3Z6XaEbIctgTYDFrloGV8TvR6PomR
	 Kw4eqyRn61fVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Tejun Heo <tj@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] sched: Re-arrange the {EN,DE}QUEUE flags
Date: Fri, 13 Nov 2026 11:34:28 -0500
Message-ID: <20261113163420.2086653-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200556-failed-6.18-c282051fc2ca@kernel.org>
References: <20261109200556-failed-6.18-c282051fc2ca@kernel.org>
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

From: Peter Zijlstra <peterz@infradead.org>

[ Upstream commit 376f8963bbda5fee838eb1823b07562368104024 ]

Ensure the matched flags are in the low word while the unmatched flags
go into the second word.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Stable-dep-of: c282051fc2ca ("sched/fair: Clear throttle state when leaving the fair class")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/sched.h | 45 +++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0f29def72877b..2e0604b3a337f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2377,27 +2377,30 @@ extern const u32		sched_prio_to_wmult[40];
  *
  */
 
-#define DEQUEUE_SLEEP		0x01 /* Matches ENQUEUE_WAKEUP */
-#define DEQUEUE_SAVE		0x02 /* Matches ENQUEUE_RESTORE */
-#define DEQUEUE_MOVE		0x04 /* Matches ENQUEUE_MOVE */
-#define DEQUEUE_NOCLOCK		0x08 /* Matches ENQUEUE_NOCLOCK */
-#define DEQUEUE_SPECIAL		0x10
-#define DEQUEUE_MIGRATING	0x100 /* Matches ENQUEUE_MIGRATING */
-#define DEQUEUE_DELAYED		0x200 /* Matches ENQUEUE_DELAYED */
-#define DEQUEUE_THROTTLE	0x800
-
-#define ENQUEUE_WAKEUP		0x01
-#define ENQUEUE_RESTORE		0x02
-#define ENQUEUE_MOVE		0x04
-#define ENQUEUE_NOCLOCK		0x08
-
-#define ENQUEUE_HEAD		0x10
-#define ENQUEUE_REPLENISH	0x20
-#define ENQUEUE_MIGRATED	0x40
-#define ENQUEUE_INITIAL		0x80
-#define ENQUEUE_MIGRATING	0x100
-#define ENQUEUE_DELAYED		0x200
-#define ENQUEUE_RQ_SELECTED	0x400
+#define DEQUEUE_SLEEP		0x0001 /* Matches ENQUEUE_WAKEUP */
+#define DEQUEUE_SAVE		0x0002 /* Matches ENQUEUE_RESTORE */
+#define DEQUEUE_MOVE		0x0004 /* Matches ENQUEUE_MOVE */
+#define DEQUEUE_NOCLOCK		0x0008 /* Matches ENQUEUE_NOCLOCK */
+
+#define DEQUEUE_MIGRATING	0x0010 /* Matches ENQUEUE_MIGRATING */
+#define DEQUEUE_DELAYED		0x0020 /* Matches ENQUEUE_DELAYED */
+
+#define DEQUEUE_SPECIAL		0x00010000
+#define DEQUEUE_THROTTLE	0x00020000
+
+#define ENQUEUE_WAKEUP		0x0001
+#define ENQUEUE_RESTORE		0x0002
+#define ENQUEUE_MOVE		0x0004
+#define ENQUEUE_NOCLOCK		0x0008
+
+#define ENQUEUE_MIGRATING	0x0010
+#define ENQUEUE_DELAYED		0x0020
+
+#define ENQUEUE_HEAD		0x00010000
+#define ENQUEUE_REPLENISH	0x00020000
+#define ENQUEUE_MIGRATED	0x00040000
+#define ENQUEUE_INITIAL		0x00080000
+#define ENQUEUE_RQ_SELECTED	0x00100000
 
 #define RETRY_TASK		((void *)-1UL)
 
-- 
2.53.0

