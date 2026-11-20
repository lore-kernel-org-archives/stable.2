Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795198824;
	b=slQoi0P2DkrlrxDqtMC/SHUC+HzpuSn0VsF/2Yk1kkiTuOlao1Nl6piViDt7NIbP6dsi
	 OZ5YsuloGFppXmTAq6Rptfi5f/s7KCi5rEHhhtMCQc2mE6guSnhok9E79KpdBt8eWBjXH
	 +KgkawUFQ+MXSXkAsm5HTr2NZ7xrkv4SNgyIJxNdXg8Da6sqdp1LBtw2YAcMiNbG4r2jV
	 AHL6jxFhMLyfTjtvTKi7PQpX5/UaFoxGe6ESh5XCudtcjrtvnoJkHj8S2nWu7qNSZKIw/
	 cWI5H8vg4+vi9+kHtaPnyRKtm8bkpnGdxkIuLVem21tA10erxo+mjSUYBxynSBpAeyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795198824;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qHyHugXT8A3gMhSG4ut0su7T08sNPi7lup8ky8aAdYA=;
	b=KhaQmeCNs/4rD5PASiANefxNtvuJPfsyfFTFlOg5c8832785vi6FjJVlyZYVGKedJfTK
	 JJmTsfeeUUYpwJLk6wUHw/Sv09V39FgGZLeu+DaKMe0BMdyPKX4kcIYLqPR5PxlKmv5va
	 +auFJCCltxYctzo/DHBPEgVv5ACJeEZqJNq0XTTBGhPEYm5uEJkxEONwDfXKuk3XwUwgf
	 hLZeNFtTO122poLaFX8SZqDodyU29PPO8BHUo5AKGGfG+/10AoxHHD4N23wNQPhrWIcjU
	 lxcYqu4lPQxLxp2Qlz4NF+Zbc+vdLu35JIZkUQSm65/XuhNoeYGKSP8DIqr8l48aj5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SIqoiPHl;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6FC606B223
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 18:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B6FC606B223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SIqoiPHl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-497614c95f0so761708f8f.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 10:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795198817; x=1795803617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qHyHugXT8A3gMhSG4ut0su7T08sNPi7lup8ky8aAdYA=;
        b=SIqoiPHl4PvkvH3uNUmWwM+jmheKQz3gILJ8Bof2Xhfc/jlWKFryJC7rR+YUM7AwFy
         3WI23dfrODgmpMtus3eKndATKXoncXM0853HMuJlAmDxHHpHDaEL9O+GQjIliaubfDYu
         SkJjEODQK47/wialIiZ0TThDTPpnIv+yp6RE7VgaqmfBD0/hXzFJG6pdlrboDGYCZbuQ
         M7t8NcUWjsGpeeLfkVc8X+6WQErPsUoM8aaI3Lru1ezHaPlXJZ9jGLYbAf79JkrgCzos
         QZqwfLMoWdrW4SYE8C6uEkxect7i6LirnNeLgnb81xSrtmP2TXSNwvI/rId9TG7Tb567
         WXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795198817; x=1795803617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qHyHugXT8A3gMhSG4ut0su7T08sNPi7lup8ky8aAdYA=;
        b=OLzygpMFYP9wjiZKiEmJ+LgMMiRvnRYpqsK+lae9xtYthjuePBPB1d3YPBY5PwOzBT
         25AOJodWqNqfI+dBnoY3arDnFlqpxW5JeLXHqxmy+LjqIggp9a8dT74Mee1MP3pXTNz3
         aNaaJrwC2zxehZSpPwIPGr6ji0lkd10P1vOZHEFGDnv//y+TFCVTs9PLLFmXv1/YHqtm
         lr4kOGaDoVXw0vbtGfTib3+Z4fAtrMYzuQgL+sFDf5i0eIJpKSV54vozvCEcwh5mQW4M
         /R/Q6D9ZI8ABT05hwKoenQORvPauzbHl5wNxItEaH4ZUkRJZbtW51BiigEAEdwioPJma
         LYKA==
X-Gm-Message-State: APuU4Z85Te0Gp0qBdwjMzc2idcG0KPUisDv1eJMT/abbYh//f3ByusKb
	h464uMiw54orEidRSMIOMlkTXGiK05LWtvDkqmkDGgjSCoo6NlCgS0U+U5WCSA==
X-Gm-Gg: AYBFou3rGkBjNxPVm2Da47eKMjqpEQ/iZun7UY3qzmaclBw6cTGocG86lO3sHULXAXB
	jxTb5bZswqHISxMNSpPhmmRGbrciTyUcaYywGEjUoDQySda3z8vkJuiPnq1fGgj8jufk2UX/xUV
	TRg5i0GdgE5+1Oh+I9N7Od4Yn4eaJywZtNWaEfI92hk6LZLYcqi+a0QIrn31FfL0MgyWLRxggtN
	ud7npTTMnVInB31YOsVHKMLopueVPoCniDTLd9KopN3DOkb1kTMKTJcsHsL6viW0W12K9mPpDUu
	CbXH07jbnF+4KQ3GCaEWbqvkZTbIsnvEjyqvrICV/eE1aC/cO/zV71hccF2VYRqTsgvJ+xSQ+HI
	3a8He7E6npWrrb59S+rElFymbMgzUdij/hj97k2IlPT/qbliXru9TKq6yNqTkWwJoFs3TFPgPKs
	l6e2F5mkx3lZNMcPOsYoQjzD4UCKMWDZ28VnQaS0eSPCSrpospNXnFC2dK4hnh+l3fq6RzsHBE6
	xQ19xslL6OVuWFtmihdnw4mi8PSU2dJTvpilygEd7F+R0237Ntbzdf1MsVMl/KOJxtx0yhP7dF8
	gKO3p9cpdj8wnVzGE+jKFFfhsHjgeZftRtHl1u8TJ40v41qpBwT7rraK1HZEOX4LphHjAFg33Nq
	opSAiD00nFegryC+ClFoeP5fk6i6GN0G8mBr8WSExNbTtMrw=
X-Received: by 2002:a05:600c:1c28:b0:4bb:867b:f0f0 with SMTP id 5b1f17b1804b1-4bb88810708mr105298155e9.15.1795198816718;
        Fri, 20 Nov 2026 10:20:16 -0800 (PST)
Received: from mbp-de-florent.lan (37.170.0.109.rev.sfr.net. [109.0.170.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895eec06sm34789565e9.2.2026.11.20.10.20.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 20 Nov 2026 10:20:16 -0800 (PST)
From: Florent Carli <fcarli@gmail.com>
To: stable@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-rt-users@vger.kernel.org
Subject: [PATCH 6.12.y 4/4] sched/deadline: Fix server stopping with runnable tasks
Date: Fri, 20 Nov 2026 19:19:49 +0100
Message-Id: <20261120181949.7528-5-fcarli@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20261120181949.7528-1-fcarli@gmail.com>
References: <awB-5usPb2QZXt37@jlelli-thinkpadt14gen4.remote.csb>
 <20261120181949.7528-1-fcarli@gmail.com>
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

From: Gabriele Monaco <gmonaco@redhat.com>

commit ca1e8eede4fc68ce85a9fdce1a6c13ad64933318 upstream.

The deadline server can currently stop due to idle although fair tasks
are runnable. This happens essentially when:

 * the server is set to idle, a task wakes up, the server stops
 * a task wakes up, the server sets itself to idle and stops right away

Address both cases by clearing the server idle flag whenever a fair task
wakes up and accounting also for pending tasks in the definition of idle.

Fixes: f5a538c07df2 ("sched/deadline: Fix dl_server stop condition")
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260113085159.114226-3-gmonaco@redhat.com
[ Florent: context conflict in dl_server_start(), which still
  initializes the fair server in 6.12 ]
Signed-off-by: Florent Carli <fcarli@gmail.com>
---
 kernel/sched/deadline.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index ea64ab436..2da68de70 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1482,7 +1482,7 @@ update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se, int
 
 static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
 {
-	bool idle = rq->curr == rq->idle;
+	bool idle = idle_rq(rq);
 	s64 scaled_delta_exec;
 
 	if (unlikely(delta_exec <= 0)) {
@@ -1663,8 +1663,8 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
  * | 8 |       B:zero_laxity-wait       |     |    |
  * |   |                                | <---+    |
  * |   +--------------------------------+          |
- * |     |              ^     ^           2        |
- * |     | 7            | 2   +--------------------+
+ * |     |              ^         ^       2        |
+ * |     | 7            | 2, 1    +----------------+
  * |     v              |
  * |   +-------------+  |
  * +-- | C:idle-wait | -+
@@ -1709,8 +1709,11 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
  *   dl_defer_idle = 0
  *
  *
- * [1] A->B, A->D
+ * [1] A->B, A->D, C->B
  * dl_server_start()
+ *   dl_defer_idle = 0;
+ *   if (dl_server_active)
+ *     return; // [B]
  *   dl_server_active = 1;
  *   enqueue_dl_entity()
  *     update_dl_entity(WAKEUP)
@@ -1825,6 +1828,7 @@ void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
  *   "B:zero_laxity-wait" -> "C:idle-wait"        [label="7:dl_server_update_idle"]
  *   "B:zero_laxity-wait" -> "D:running"          [label="3:dl_server_timer"]
  *   "C:idle-wait" -> "A:init"                    [label="8:dl_server_timer"]
+ *   "C:idle-wait" -> "B:zero_laxity-wait"        [label="1:dl_server_start"]
  *   "C:idle-wait" -> "B:zero_laxity-wait"        [label="2:dl_server_update"]
  *   "C:idle-wait" -> "C:idle-wait"               [label="7:dl_server_update_idle"]
  *   "D:running" -> "A:init"                      [label="4:pick_task_dl"]
@@ -1850,6 +1854,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 {
 	struct rq *rq = dl_se->rq;
 
+	dl_se->dl_defer_idle = 0;
 	/*
 	 * XXX: the apply do not work fine at the init phase for the
 	 * fair server because things are not yet set. We need to improve
-- 
2.39.3 (Apple Git-146)

