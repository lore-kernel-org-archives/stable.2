Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732907;
	b=cMl2GpnM7hKco+P4IRhqECeVSh6N89Y8+aDoygzIkJk/1NVzzo0ePFm+7ssA3ViAf2my
	 x3up8XUuzA3i1TPPsO6BcOmTAajmpC8V33JOJU4BTkEWkxJSFxAdIlElubGisTzwZnBcu
	 sPrsL+VlRB6I6b/GM02Vgo004NX3EaI/yTNeIrn3aHBH2tF/pvz1wkt8ZLkfEJgV9v5ph
	 3d7Lsg1xRtnHmJesuwwhvTyO1G65fOQYqSjnVGudgRcJ4jHtaqJbXRKD3d8E/ArN8WRZ3
	 gLXrfvjA1dKdbU2/M1C3P2wcQHmXkMqUBiJTEO0/zQ7Z/ba51bZ6pqv2Z2IipxKmz5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732907;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=p83s1UZrudYzqyiix38FzmFWnzl/cng77PjrgFldiOE=;
	b=sNl8xfdd/Jqvr/V6aJTA5RCX/CsGCn5Iwei5pfmiAF43rpT6v7dbYiyeA0cQwe4i1pde
	 nnp0u1TddBd8yW4SE1hXCfas0H3NBhz9zJUmLrl7eL52KtLn7+Vw4PpEaqX3AG9c4vs4K
	 VNdw+u0XdwptA4dzrKb4XOCyX94tsW8SQgPV9wRTtcO9I8IdWKg4v84Uag9MhLBGhCd50
	 PvbfC4oVt4L8kczJOM6D3/2YlSnWEYDX5eao4tsyHUNT7F3gPfUA1WmJ7NRI0b7/gXkeR
	 ji9GvhxilIf4jtBNa/FGYISWw/xzDHkza+i79S0t0B3okBIwvLSYNCEdtnmKUoSOlQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cLIkfmDj;
	arc=none smtp.remote-ip=209.85.221.72
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38003606D82C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:08:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38003606D82C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cLIkfmDj
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48df730c035so3171610f8f.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793732906; x=1794337706; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p83s1UZrudYzqyiix38FzmFWnzl/cng77PjrgFldiOE=;
        b=cLIkfmDjGsSuCrmmg2ZWaGOTpRSSABoNhz2phGvGqCGlO6/br8+1UXKv7Oxiu9R4YJ
         VtH3diId+kHz6PbEFrEsuVVr/gFIWoJmf/goMfvYCUluwwsM5G++hRHqMl5fEednwEk7
         B4SF0sGBbddwTWabYdil9Vz4y3XvIxokMQ2dzzTvrjxhkmVbR6DdFV4LueZFeqxPC327
         0yHvl09SOlohkXJySmiU2PlfhVaq9kMpJZzgN52l5CJzlM39u8f92xhEBOGIu0kjpoa1
         8m18xTsAeEInazWKkbskhmHMjjMY15unjuzLU5vEx5SOLLdP3xky61VZk/5YO3GPAtpW
         pHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732906; x=1794337706;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p83s1UZrudYzqyiix38FzmFWnzl/cng77PjrgFldiOE=;
        b=k9J9HCz31s4gNJnpPVQrf/i6U5cs8v88EwCEAkgnyHbRCfehikDIeES62yjKNMeMLZ
         bTw37pZxDXvlLyL3aDHqdc83foh6gvgnGLZnoVi2+1v/MNOE/S8se9z4LqKCVS3t4K63
         bcRlIecHjmCrP++kqqdVOtTN2u5bXgVI/zzVMBEpIiVLIsaFKO/9LP9lEJkqxguJzXTV
         PZIqmqnl3zxhXWr5hGIm8Ddd5Z7a8HBCA/t6dIvxubmQYqjU67zqVpUtrsgFF9qzVgor
         v3lrUQw0ccDzDC+NIHVBTM0PIt9en3qK0VLGinR/eAQkxu+iwp3jEHV9wZFhEsrl6w48
         IRYg==
X-Gm-Message-State: APuU4Z9JSiEaxKKMOz7XsxF+h5j7qOVx2bvar8MO48NDB4jPKjkM2oDd
	hp/dgig2gZ5mWpqiMjdLjE9Fq0my18WqTQNTakbuJcdCPofPHXs/KuXmdTTkQSe1bM7PCDZwemG
	SCXZbR5Ef7OsTv0+IBkl3DP1bPhLHUsSCAt7kVX5oF30lPyn+Kho3dT9qOnH57WlfxLttz4cwLx
	o1O5y6wuFBQ++GsGM8hNiJBmp84qdlSQWJj6x/coqLUnJkJd0=
X-Received: from wrsq11.prod.google.com ([2002:adf:fecb:0:b0:48d:ee1f:7396])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:f24b:0:b0:48d:dc6f:219a with SMTP id ffacd0b85a97d-48e6e2ff6f2mr25928011f8f.27.1793732905092;
 Tue, 03 Nov 2026 11:08:25 -0800 (PST)
Date: Tue,  3 Nov 2026 19:07:49 +0000
In-Reply-To: <20261103190805.3487350-1-jpiecuch@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261103190805.3487350-1-jpiecuch@google.com>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261103190805.3487350-3-jpiecuch@google.com>
Subject: [PATCH 6.18.y 2/2] sched_ext: Fix scx_flush_disable_work() UAF race
From: Kuba Piecuch <jpiecuch@google.com>
To: stable@vger.kernel.org
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Andrea Righi <arighi@nvidia.com>, Richard Cheng <icheng@nvidia.com>, Sasha Levin <sashal@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Kuba Piecuch <jpiecuch@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Cheng-Yang Chou <yphbchou0911@gmail.com>

[ Upstream commit d99f7a32f09dccbe396187370ec1a74a31b73d7e ]

scx_flush_disable_work() calls irq_work_sync() followed by
kthread_flush_work() to ensure that the disable kthread work has
fully completed before bpf_scx_unreg() frees the SCX scheduler.

However, a concurrent scx_vexit() (e.g., triggered by a watchdog stall)
creates a race window between scx_claim_exit() and irq_work_queue():

  CPU A (scx_vexit (watchdog))        CPU B (bpf_scx_unreg)
  ----                                ----
  scx_claim_exit()
    atomic_try_cmpxchg(NONE->kind)
  stack_trace_save()
  vscnprintf()
                                      scx_disable()
                                        scx_claim_exit() -> FAIL
                                      scx_flush_disable_work()
                                        irq_work_sync()      // no-op: not queued yet
                                        kthread_flush_work() // no-op: not queued yet
                                      kobject_put(&sch->kobj) -> free %sch
  irq_work_queue() -> UAF on %sch
  scx_disable_irq_workfn()
    kthread_queue_work() -> UAF

The root cause is that CPU B's scx_flush_disable_work() returns after
syncing an irq_work that has not yet been queued, while CPU A is still
executing the code between scx_claim_exit() and irq_work_queue().

Loop until exit_kind reaches SCX_EXIT_DONE or SCX_EXIT_NONE, draining
disable_irq_work and disable_work in each pass. This ensures that any
work queued after the previous check is caught, while also correctly
handling cases where no disable was triggered (e.g., the
scx_sub_enable_workfn() abort path).

Fixes: 510a27055446 ("sched_ext: sync disable_irq_work in bpf_scx_unreg()")
Reported-by: https://sashiko.dev/#/patchset/20260424100221.32407-1-icheng%40nvidia.com
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
[ Sync error_irq_work instead of disable_irq_work. ]
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index d2460a88fba3..78f15ddc0aa5 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4217,8 +4217,13 @@ static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
  */
 static void scx_flush_disable_work(struct scx_sched *sch)
 {
-	irq_work_sync(&sch->error_irq_work);
-	kthread_flush_work(&sch->disable_work);
+	int kind;
+
+	do {
+		irq_work_sync(&sch->error_irq_work);
+		kthread_flush_work(&sch->disable_work);
+		kind = atomic_read(&sch->exit_kind);
+	} while (kind != SCX_EXIT_NONE && kind != SCX_EXIT_DONE);
 }
 
 static void dump_newline(struct seq_buf *s)
-- 
2.56.0.385.gac671c819a-goog

