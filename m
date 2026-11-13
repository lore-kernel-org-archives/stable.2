Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583654;
	b=bq0HsT2MQRfXGNsc6QKBAq/IDmKpYUqVG1f83RIz254xtVUFWCms787mCHvdjd94DCMj
	 clWGmD6IdxbLkJUn6xUy3iYdcIiTIzjrJwOxadYSVGJS6nf2vmiL6lZjDvW3eBwQK0gvi
	 zWBBb9jsw09dEZhq1gNxg/AxiwH+iHn4QRrY6clXlwzXv+QDaz+4TMLw4mA6EBNSx/7KJ
	 BjW7Sw9Ig5T258fXUeMYF/zgDtDluZFhNApZUJWSAQrGh454N1OIJUjJa7BXOQJyeROVx
	 6rqoipLVd+J3lp2L4tnx0ita68fWBWZnAtkQtQqSEOOEVETYmSWYuebTBo+7bFCLVtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=Kb6BNBHWUZprPI1vwsmUapLJRh7sJ5t4OJsDs7YS7EQ=;
	b=uj1eQzCdc7QJ9LFW61+w+PWggb9242I0PVV9gDrVBslbzMMcJrKzoR0k2zV06CwZ7nJc
	 ZGGmsc3ZskADPQGOZ5Wx+42ExH36iyIgB5VwnkAi7W4SwTdmfterJIvD5J5c5bEpGJ7vI
	 JkXQ2zQLdl4zrS7xKw+N/85HDYOIa5ugzJFndLpJnAHCZZwtO7zvk/0E2pbeacyA6GVxE
	 TF5rmiCPn9WT0RA7IlylVuhmf2cxKFy6JTIxML3oi+F5A9nN4yy/Irqep1arhnGMMEQMt
	 J9ABwMhro89c6Ba78GDoyn0zclIaIVp9Y1K+SIDZkXwuRcBXVLdvNU6TVHYwXP/sxMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QOzMZnPV;
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31385606A336
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31385606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QOzMZnPV
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b56a350f2aso1376941a12.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 07:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794583652; x=1795188452; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kb6BNBHWUZprPI1vwsmUapLJRh7sJ5t4OJsDs7YS7EQ=;
        b=QOzMZnPVto8tgdXcMbvPKEhrJUGqQbsXRc7uAdZ+tx0cvxcmT1cuJCd7iVsAodAN7I
         wUP69KTYU+WcrQycjo4OiMGFAuNNTJA2ACmhz5FVbOCdhl2ItdvYbZENmxS5Mknz6QN7
         odB0LC/3drK4ReNgAwDGidlLv2C6q+cwi37HFigDF9fjRtSXoDNERz+bsyr/9xIJcxRj
         rnZ8QstDHWA5+HsG4otQIoWpOqrlEU3VAcnWut8co2Nck7L2+2FcqvEkRdr75vcHJu8l
         3hLKnVYqkoVzTx1cZsFlbprplA+5GfW+1Y/6vkiq6QEtS7vwptF3PvAGEfgSSjckntMI
         IGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583652; x=1795188452;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kb6BNBHWUZprPI1vwsmUapLJRh7sJ5t4OJsDs7YS7EQ=;
        b=nTX4nOaLaSpHyWU66APMjJWRfBS0NxggTxJmOB3APcyB/Q6R91HVfjULDkj3iY5SKW
         uSwQIa3VIMlktourbzJKoQ5uPUgmeVR98pohScnx3u9OXBUYjEmYyHuUmJm6QqXLWvsq
         Bo8xlf8xmxE0rnj2rJ4Sr3MnhMYIi+R2Z73jO+YFMdVJz51ozrTxGz1ByYkcVkAcEsxQ
         sX9Z/3HcfF+GeFQw1lHUiiTLKojPTtYmeq/45WBvDs6zdBx3AxPr5p/7N63ezmWIn7W6
         2AyxFeZrgNKmi6RXt3gdBWuUXPqV0MjvMg7/uCUX40YL9YoDtuPlN1H63PMWdrOkDoRo
         G5MA==
X-Forwarded-Encrypted: i=1; AL+hErFj1SbfWVG8uwYmYH+keem1jyLw0bxKkZF2jWidImFsS1MBNiY4E3jMFzoIQ9I0EbGZDZHzZEg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/enM+wRYgGa/hyPJrXNyO1rkjNEWY9frx1T6IS0SxVVOiRIBg8
	cs3I8k+jVLMYa/3r3Os5Vg6HTV1tLFQe/Norc9VRAEfEc+oOgjm2MJp898kxXHJy/+zsUagQTyz
	lNt90i5firCwly5/+CrFmTg==
X-Received: from edgd14.prod.google.com ([2002:a05:6402:a50e:b0:6b5:7fe9:bce9])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:1511:b0:6b4:be3f:51b3 with SMTP id 4fb4d7f45d1cf-6b7c0958100mr1868438a12.12.1794583652187;
 Fri, 13 Nov 2026 07:27:32 -0800 (PST)
Date: Fri, 13 Nov 2026 15:27:10 +0000
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
Message-ID: <20261113152729.837429-2-vdonnefort@google.com>
Subject: [PATCH v1 1/4] ring-buffer: Skip remote reader page swap when on tail
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, bgrzesik@google.com, 
	Vincent Donnefort <vdonnefort@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When the reader page is also the tail, swap should not be permitted or
it would insert the tail behind the head, breaking the integrity of the
ring buffer. While __rb_get_reader_page() does correctly prevent this
situation, the simple_ring_buffer implementation misses it.

Once the reader catches up with the tail, make
simple_ring_buffer_swap_reader_page() return 0. The remote reader now
can expect an unchanged reader. When it is the case, there's nothing
more to read.

Also, when the simple_ring_buffer writer moves the tail to a new page,
it resets the new tail counters and more specifically page::commit. As
moving the tail unblocks page swap, order the page reset before the
tail_page update. This ensures the reader can't swap the reader page
with the new tail and observe a stale commit value.

Cc: stable@vger.kernel.org
Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Fixes: 34e5b958bdad ("tracing: Introduce simple_ring_buffer")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c        |  3 ++-
 kernel/trace/simple_ring_buffer.c | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1fd28a72e6ee..3c7aa982d43e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -5848,7 +5848,8 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
 
 	new_reader = cpu_buffer->subbuf_ids[cpu_buffer->meta_page->reader.id];
 
-	WARN_ON_ONCE(prev_reader == new_reader);
+	if (prev_reader == new_reader)
+		return NULL;
 
 	prev_head = new_reader;  /* New reader was also the previous head */
 	new_head = prev_head;
diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index abfaf9bee12e..d5c84af01925 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -139,6 +139,13 @@ int simple_ring_buffer_swap_reader_page(struct simple_rb_per_cpu *cpu_buffer)
 
 	reader = cpu_buffer->reader_page;
 
+	/*
+	 * The reader is already the tail page. See simple_rb_move_tail() for
+	 * memory ordering.
+	 */
+	if (reader == smp_load_acquire(&cpu_buffer->tail_page))
+		return 0;
+
 	do {
 		/* Run after the writer to find the head */
 		ret = simple_rb_find_head(cpu_buffer);
@@ -196,7 +203,13 @@ static struct simple_buffer_page *simple_rb_move_tail(struct simple_rb_per_cpu *
 	}
 
 	simple_bpage_reset(new_tail);
-	cpu_buffer->tail_page = new_tail;
+
+	/*
+	 * Setting a new tail may unblock the swap in
+	 * simple_ring_buffer_swap_reader_page(). Ensure the reader observes the
+	 * page::commit reset.
+	 */
+	smp_store_release(&cpu_buffer->tail_page, new_tail);
 
 	simple_rb_meta_inc(cpu_buffer->meta->pages_touched, 1);
 
-- 
2.56.0.611.g1030f0b940-goog

