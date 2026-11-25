Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795614379;
	b=NoQl8HBaaRAlmYE6NqyM4cNW26RKM0EodFJLfF5+a/le85qZzzEsF+IobehZKMLAfmyY
	 q3NpRTlVbK8k7XgnP6ICcohFKtAj1Z8J0Gw2LTg1EknC3j/+gjsxQwEl6kmOfRiblWRH7
	 nxt/y60lh4fq7UCGqnMh1dUR6EunRH0HoVDLJEkVnUPbEfhlowOkKdTLnsefcR5P4iK0f
	 QoPUNEtyX10H2iy9HXRsPdLVPwnWl1IoRmnqrD0hDL3ZtRVb4VG+ZN1lHLgfNjJ7KL39k
	 LKpl/whC8ONA25BW+79tkX/W+HfJiiUWwMo53vGxUgbPRmBclTbr7mNwFYlmm8u/eyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795614379;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=hkC7knUlQ5bvCCnLhIKdyMONWGi8riIRNrWMCj0qGvQ=;
	b=jS3hBf8x5MtH0RKPq7MoWH0YbK7NUpM08GCnzvzG1yC5NqpEJViTZsLirXI440oEcYq2
	 1EiQznSNRFx7Sw0/0Q8qBW0/fNpWZLh7qEuXdzuvRRln8MUWXrC6UvrfduI8xB79NKV6s
	 r3O4TLfzlTKbcVXuQofTVE1P/xedfVBXbuNC5h0n4YhW7mYpd/XDCnhiRo9V2w6NJrc6G
	 f5pUs+9y6/VZ+ngVznQx1BVUM+wvmOA+tnX1bO640HLJRNWLKFD8ImRuHxoLCRLxq0MwZ
	 eulT5ATONk69XTFwfqbhwdb2BHhwkJE3JxJ81AwF7Ztl8nZskS2L4QieALGGd/OO1eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZDhQP62j;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E334B606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:46:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E334B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ZDhQP62j
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4bb9379a835so25545795e9.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795614377; x=1796219177; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hkC7knUlQ5bvCCnLhIKdyMONWGi8riIRNrWMCj0qGvQ=;
        b=ZDhQP62jtCOk4l7aNG8WaBNp/pzufubi/wHj0w/HPcpin7qDUZyx/LA3GDjdRnCk34
         winwZUoaO0YK1CHJOxUZ0nYvmp7OSWQk1aB50W75pjk/PZV8PJHc6v1AwT3f3avuyt+C
         3wjLQxURd4yr4CKeUzWr/JzTVGTXZ7Cww6D4ybrcRIsG1GVg9iepMmCVWfGDqnavqQtw
         oiDCmLpm/+iVuVF77yQindIzEjYIzb4vXVVJ84g3jYESyvtxsu/E+bUrN5OK/Oj+vzvc
         rWJpQHEtV/oHFtuPPokAd4Pjq00Xk6wlaKBgOZbXId4RPsRbFcGY86QZ3KC50ubkibLF
         e54A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795614377; x=1796219177;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hkC7knUlQ5bvCCnLhIKdyMONWGi8riIRNrWMCj0qGvQ=;
        b=KwkwEIt4J9o6CMIYq2CZZ9ysqE0o1vb2eYJllrF74dw/YNNYkPPW8MrLM3GQSxOLoH
         EfLUKhm40Ix+U72wOoAqFgWn50IiBQpO4OA5HhGxUqkBr4kAYdzxl9Et4Ec1B92VaLOs
         ElIoA/iSfOt9Vj9WMnExz4RDYb0OL8ow4ZAmRQapYFBdMLajLzTfikRtvLNMsFzY2Qq9
         3o0mEWF31VVDXhjSpVSo+RnS72gfsgetf2cFJzGL3yHoE8sjuY6iD3Fp8Wv+pxpj6UTW
         VMpmoWUEuugts0iUI2t+UjAjh3b5NLtCzWDWnQj+5WnLMs3gcJtjy/AMmNZ33Eu1hnUc
         4GTg==
X-Gm-Message-State: APuU4Z/Ij6TRb3oDF/bYHKnp2X2N8XKRqrL/oGfEUdKM2IqIjoFhpTbv
	TNDqYG/m2X/RhFWIpGX4yZRtbDIKh9zjcgo+MaOcDPU3PF5DVAmDn60RRl6fc8aG3GEXJT8M8tu
	3rxk+RhsXLz6wW3b+P7oH2UZd7iHb9g8cCt5Q8X5+p+DwfFjMvuc9EZkVjwdIudSeawG6msyqD9
	ij8vsmPWMuxiXvP3mFL9MEM3Ex5QQ0GyeH15XbN1fJxrwwTRc=
X-Received: from wmcn22.prod.google.com ([2002:a05:600c:c0d6:b0:4a1:f1e1:c6d6])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:5487:b0:4bb:5de1:e92c with SMTP id 5b1f17b1804b1-4bb88813157mr368724395e9.26.1795614376787;
 Wed, 25 Nov 2026 05:46:16 -0800 (PST)
Date: Wed, 25 Nov 2026 13:46:16 +0000
In-Reply-To: <2026112535-handcraft-glance-0edb@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <2026112535-handcraft-glance-0edb@gregkh>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125134541.3432982-1-jpiecuch@google.com>
Subject: [PATCH 6.18.y] sched_ext: Read exit_kind before flushing in scx_flush_disable_work()
From: Kuba Piecuch <jpiecuch@google.com>
To: stable@vger.kernel.org
Cc: Kuba Piecuch <jpiecuch@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Sashiko <sashiko-bot@kernel.org>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

scx_disable_workfn() sets exit_kind to SCX_EXIT_DONE before it tears the
scheduler down. scx_flush_disable_work() reads exit_kind after syncing
disable_irq_work and flushing disable_work, so it can observe DONE from
a disable_work that was queued after its flush and return while the
teardown is still running:

  CPU A                          CPU B
  -----                          -----
  scx_vexit()
    scx_claim_exit() -> true
                                 bpf_struct_ops_map_link_detach()
                                   bpf_scx_unreg()
                                     scx_disable()
                                       scx_claim_exit() -> false
                                     scx_flush_disable_work()
                                       irq_work_sync()      // not queued
                                       kthread_flush_work() // not queued
    irq_work_queue()
  scx_disable_irq_workfn()
    kthread_queue_work()
  scx_disable_workfn()
    exit_kind = SCX_EXIT_DONE
    scx_root_disable()
                                       atomic_read() -> SCX_EXIT_DONE
                                   bpf_map_put()

Once bpf_scx_unreg() returns, its caller drops the struct_ops map
reference, and the struct_ops trampolines can be freed while
scx_root_disable() is still running and can still call into the BPF
scheduler, e.g. ops.exit().

Read exit_kind before syncing and flushing, with acquire ordering paired
with the atomic_try_cmpxchg() in scx_disable_workfn(). DONE is only set
from disable_work, so once it is observed, the following
kthread_flush_work() sees the queued work and waits for the teardown to
finish.

This patch was created with the help of an AI coding assistant.

Fixes: d99f7a32f09d ("sched_ext: Fix scx_flush_disable_work() UAF race")
Cc: stable@vger.kernel.org # v7.1+
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/sashiko-outbox-195908@kernel.org/
Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
(cherry picked from commit 3133107d98057595c0af39ff907c852134926912)
[ jpiecuch: applied kernel/sched/ext/ext.c hunk to kernel/sched/ext.c;
  kept error_irq_work instead of disable_irq_work. ]

Signed-off-by: Kuba Piecuch <jpiecuch@google.com>
---
 kernel/sched/ext.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index af5828f09304..882e06a76a16 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4247,10 +4247,17 @@ static void scx_flush_disable_work(struct scx_sched *sch)
 {
 	int kind;
 
+	/*
+	 * scx_disable_workfn() sets SCX_EXIT_DONE before tearing down. Read
+	 * exit_kind with acquire ordering (paired with atomic_try_cmpxchg() in
+	 * scx_disable_workfn()) before syncing and flushing so that, once DONE
+	 * is seen, the following flush observes the queued work and waits for
+	 * the teardown to finish.
+	 */
 	do {
+		kind = atomic_read_acquire(&sch->exit_kind);
 		irq_work_sync(&sch->error_irq_work);
 		kthread_flush_work(&sch->disable_work);
-		kind = atomic_read(&sch->exit_kind);
 	} while (kind != SCX_EXIT_NONE && kind != SCX_EXIT_DONE);
 }
 

base-commit: 4700e3adf3b24b39dd4929e9c6d62811ba3ccea8
-- 
2.56.1.839.g22a8290db9-goog

