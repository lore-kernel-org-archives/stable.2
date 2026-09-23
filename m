Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452E39FCD7;
	Wed, 23 Sep 2026 03:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134191; cv=none; b=c1xvxyFbqDGzDzxwnYPmqtzKxu3yNu05BCq8jUOocYAbNZPT2xE1Sc1A1IzygwVaYK+NzYw5THNtwVf7yd30vJ/0EbfpoS3qH7M9fgKn/NJbeQXd3p7M0CSPEKyWLDwPlTrDvTLmIgPGn62DsKIKgREqVJwEXCnsHLfNwBsdLK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134191; c=relaxed/simple;
	bh=w6DQ4RJQhPhEBm9oLXn3mz5wuxNd0Nf9dWJpDo9xT30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gvIIEt00jlrUuln+2ftJqLR2FGKOodKfUNyMELpfZhbEifdtDx5q25J86oxUpIX7zHItnzJpa8mcl0695eUVQNw5hOZP/WQhTmngy3TEcPqkxGYWbrS4lZFuF6nT56pHLFTtzE5Qz1S32rfOqhv9gu1tOrjSeZl0KVh4U3coGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=HUS0xO/o; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="HUS0xO/o"
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4ecf5a4a4;
	Wed, 23 Sep 2026 11:29:42 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH net] net: gen_estimator: protect seqcount updates from hardirq readers
Date: Wed, 23 Sep 2026 11:29:36 +0800
Message-Id: <20260923032936.2020902-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0cc4fe13a03a1kunm8907937bb6f55
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSE5PVk9OGk9NTh0YGU8fGVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=HUS0xO/oE2Wn8cLs419eqK5Bxcrn30w5WMrVKTuoHQktvOThpPcVgYwmvMWBInWTCL2pTMJRcGM3o6p+oRZGpJPS5Jt/8slMAR94mp2U4hl4+x8km2ZgxSZeY8gQwxomlsmTdoC9qzv64j39e8Zm5vjrJThBHvyXhHT37xlUlJ0=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=wHsnoqiVRE2EsOKHreTjUZFaARYXYqFzxs8nTS61rdI=;
	h=date:mime-version:subject:message-id:from;

est_timer updates the estimator seqcount with preemption disabled, which
does not exclude hardirq readers on non-PREEMPT_RT kernels.  A reader can
observe an odd sequence and spin while the timer is interrupted.

Disable interrupts around the seqcount write section.

The failure mode was reproduced with an x86_64 kernel under QEMU. A
test-only hardirq injection invokes gen_estimator_read() on the same CPU
while est_timer() is updating the sequence counter.

On the unfixed kernel, the hardirq reader reports the seqcount lockdep
warning and spins until QEMU times out. With this change, the reader is
deferred until the writer restores local IRQs, then returns and the guest
shuts down normally. The hardirq context is deliberately injected to
exercise this interleaving; ordinary userspace traffic does not guarantee
it.

Fixes: 1c0d32fde5bd ("net_sched: gen_estimator: complete rewrite of rate estimators")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 net/core/gen_estimator.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/gen_estimator.c b/net/core/gen_estimator.c
index c34e58c6c..6aba5916d 100644
--- a/net/core/gen_estimator.c
+++ b/net/core/gen_estimator.c
@@ -79,6 +79,7 @@ static void est_timer(struct timer_list *t)
 	struct gnet_stats_basic_sync b;
 	u64 b_bytes, b_packets;
 	u64 rate, brate;
+	unsigned long flags;
 
 	est_fetch_counters(est, &b);
 	b_bytes = u64_stats_read(&b.bytes);
@@ -90,12 +91,12 @@ static void est_timer(struct timer_list *t)
 	rate = (b_packets - est->last_packets) << (10 - est->intvl_log);
 	rate = (rate >> est->ewma_log) - (est->avpps >> est->ewma_log);
 
-	preempt_disable_nested();
+	local_irq_save(flags);
 	write_seqcount_begin(&est->seq);
 	est->avbps += brate;
 	est->avpps += rate;
 	write_seqcount_end(&est->seq);
-	preempt_enable_nested();
+	local_irq_restore(flags);
 
 	est->last_bytes = b_bytes;
 	est->last_packets = b_packets;
-- 
2.34.1
