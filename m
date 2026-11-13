Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583656;
	b=qmLM872McJMDWD5sISNMTgAss05xyaRqDWMPJ60GrjrwX+tyLlDCqivOwMfp5B7zmQaT
	 1zFornalaO7dPEcjiBrzjaWCCnrUCBYH71n8lO0beCdOwYTsjKXT8wWwP1qWK2if2fQ5T
	 pnxK/vFNwqGtOMe2H8x1O4IXGinlhzWPHMCnAodo8FDvZ2vOff6GpMyASPbsbiKTEA6GP
	 gfS2KuQgUaGKQaHNTWx7HCG8mhyLF24AI3LqwajQhihWwoWz0WwnrBkQkYN+ESnulbr6j
	 yUqB/3z1tlZZkdVcxGEBAKNAuO56YJ1Tz//S8L0Wmq4RzdctZ4JwRaRtkyd9Nr7t0cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583656;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=FrGK4LQCQBqx0hUtkMsYYjxe3VECT+KAsWnhnUDOZDM=;
	b=gSeSQLld2qlvobWu4UmAtgUC0tBk/FEsCafBykI1yLwlQeM5hk8R9SZu70GnxuYrkKDV
	 FlS3cHlXckmF+Kyc0p2TwmuEuthwynfe7I0PMIDTxoeFUWw4svs4GyITh8it1uEdX0sVc
	 j2XJid6paRIJjTJkP0RJtE5FCd29qKlGji+xIz8OeN2+u++tuet+UnDOpZIVQWCt0r45e
	 fQIc15sgIuxrdiidYj86l1CZROGUmK1OVGM2KBSDF/neM7J5gRLibQeKwyzexQ7KaNByx
	 PVvCRBK1N4B9hmS8fE5wfcoag1DCBaxeC20A4PTAu2Lwccxhx5Ml7m0iwU4Ybr9A5Tg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lbGQVyka;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92382606A89F
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92382606A89F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=lbGQVyka
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4b0a307487aso4854265e9.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 07:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794583655; x=1795188455; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FrGK4LQCQBqx0hUtkMsYYjxe3VECT+KAsWnhnUDOZDM=;
        b=lbGQVykauPq3rzPl+rYk4kEwNYQrN/P4fG033HJrEKxLSymRIV+nR2A0z67u7F+1PW
         vZlF0WX9pVUANdVwBtolDAbdNeaLB2eXYIU8GoZzR3+6lTCUsrJfSwlw5fkkPYQuSGYC
         rrbPKT/ZIFjXQlqQDk9t/UYO62wGzMAiLO3Ej6gTzW7QF9F48hR01asi7RQLjcchiKpW
         mmAzUVBlVgCmRilly/l4ik1UsdOO7SDMtY2ZgUfKfNdYYGyTKFJNa1nFCQL3enIhGXW3
         qVD+YewRBkpy8v0ERnp5zgLq9zhdKwELXSDqwfjkV+sCQz8O5pIAIDIoTdL6f+VCJfgM
         4b5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583655; x=1795188455;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FrGK4LQCQBqx0hUtkMsYYjxe3VECT+KAsWnhnUDOZDM=;
        b=RDO7nTX2jY3RHI/BfcEpILXtUF5+7vOAvOe8SZbREbJhxApp8RDV/atu4qWez20kei
         K7Vr+YdBWez4JgRUInkKxOX+55GR9T9MxCNJH22vzvKQ94EXOmqMHAv39ku3/Izwkqvc
         GWd/q8bKKgnDrOm4ww8sKp6iUU0QDUtPtYk64P3uoH+uZ0LzdqorlN3C8+JUoh3BzIEa
         L3yDvGKx4SaqetgcgruKSkCGXVSuVAibxh9Zl3/rsQAGC3QHJWxgsk47mwljGCliYj2s
         RJD7CuQ8uY0YiisAFi9PgR7ot+GUNuOo6K8u8NL5ySJkOJuJPba8C8A9kJnemeTDZp7S
         Lkrg==
X-Forwarded-Encrypted: i=1; AL+hErH89AW6xMr+yiOFYdcWkI7P0hblF1yWUurCPO6yG+ybtFKUITxPz+7kuOny3KxHfqI6A9fF/6Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ChIQb5Lxl82KrOHOAvCNP3bukLTLVFgIITgUMc+N6DmTy3/EU
	MuxXpVcl6TlzYqLACo6cHVISWW20RywjP2GGcx8DN0ohkvOQyyQucTwtv3Xwirabn+BhS49/wiA
	mLFm6tkcDcUNNY66WLDdp4w==
X-Received: from wmfv1.prod.google.com ([2002:a05:600c:15c1:b0:4a1:fe2c:3323])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1c0d:b0:4ba:59f7:9032 with SMTP id 5b1f17b1804b1-4bb55c5f60dmr71390435e9.10.1794583654644;
 Fri, 13 Nov 2026 07:27:34 -0800 (PST)
Date: Fri, 13 Nov 2026 15:27:12 +0000
In-Reply-To: <20261113152729.837429-1-vdonnefort@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261113152729.837429-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113152729.837429-4-vdonnefort@google.com>
Subject: [PATCH v1 3/4] ring-buffer: Order remote page commit with data and timestamp
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bgrzesik@google.com, 
	Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

__rb_get_reader_page_from_remote() uses page::commit to check if more
data is available for consumption. However, it needs to make sure that
data and page::time_stamp are not stale. Enforce page::commit order with
page::data and page::time_stamp, and defer updating read_stamp on page
swap until rb_page_size() confirms committed data is present.

Cc: stable@vger.kernel.org
Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Fixes: 34e5b958bdad ("tracing: Introduce simple_ring_buffer")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c        | 23 ++++++++++++++++-------
 kernel/trace/simple_ring_buffer.c |  5 +++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f70010e2ede7..6016d16d1566 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5832,11 +5832,8 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 	smp_rmb();
 
 	/* More to read on the reader page */
-	if (cpu_buffer->reader_page->read < rb_page_size(cpu_buffer->reader_page)) {
-		if (!cpu_buffer->reader_page->read)
-			cpu_buffer->read_stamp = cpu_buffer->reader_page->page->time_stamp;
-		return cpu_buffer->reader_page;
-	}
+	if (cpu_buffer->reader_page->read < rb_page_size(cpu_buffer->reader_page))
+		goto out;
 
 	if (!rb_num_of_entries(cpu_buffer))
 		return NULL;
@@ -5883,10 +5880,22 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 	cpu_buffer->reader_page = new_reader;
 	cpu_buffer->reader_page->read = 0;
 	cpu_buffer->pages = &new_head->list;
-	cpu_buffer->read_stamp = new_reader->page->time_stamp;
 	cpu_buffer->lost_events = cpu_buffer->meta_page->reader.lost_events;
 
-	return rb_page_size(cpu_buffer->reader_page) ? cpu_buffer->reader_page : NULL;
+	if (!rb_page_size(cpu_buffer->reader_page))
+		return NULL;
+
+out:
+	/*
+	 * Order page::commit read before page::data and page::time_stamp, most
+	 * likely paired with simple_ring_buffer_commit().
+	 */
+	smp_rmb();
+
+	if (!cpu_buffer->reader_page->read)
+		cpu_buffer->read_stamp = cpu_buffer->reader_page->page->time_stamp;
+
+	return cpu_buffer->reader_page;
 }
 
 static struct buffer_page *
diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index 5f14ba152fba..2dddaef638dc 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -307,6 +307,11 @@ EXPORT_SYMBOL_GPL(simple_ring_buffer_reserve);
  */
 void simple_ring_buffer_commit(struct simple_rb_per_cpu *cpu_buffer)
 {
+	/*
+	 * Order page::data and page::time_stamp before page::commit. Paired
+	 * with __rb_get_reader_page_from_remote().
+	 */
+	smp_wmb();
 	local_set(&cpu_buffer->tail_page->page->commit,
 		  cpu_buffer->tail_page->write);
 
-- 
2.56.0.611.g1030f0b940-goog

