Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7EE1C68F
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 00:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782607625; cv=none; b=n7WKbs/AAGyRA802T3eQlO8q8K5ANdA/jbvyX3kR7qQwsIKqPH9N7j341+O1iOArQ1kHH5ixlTprJo3Z4jmadcXFYVlXPyMtVNlWER2kV7A+jSkmSU7xQo0cvcaKJX4KiHR/qqsnSh8nbgoUXTG0013NgFjwkZGQcCXamuMaG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782607625; c=relaxed/simple;
	bh=JWA380ctDhP6cb9yiDI+v1kSZBNiU/P0ELQGPGUNjQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfBxpdWBCQwW5Py/BtaHQMkkzyvH20JOn+3iH7KOX/iGcKvKKf3MH+IZ2irDwapb+M6xjlZ+HjzjG3EKnD+TShmFw6WwgNHSvYMzDGyTDpSgE6WhJMrph1ooJbop6V9tqgvTRCh0EFxG2CUohzOg24g+rV814MQNt6CCUsdPl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zg4yAB+y; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg4yAB+y"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4921eed3fa2so15608955e9.0
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 17:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782607623; x=1783212423; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lr5H8TFwybM+AlW1rdMOQH0Q1+oaaC7QfC19uDCbRGc=;
        b=Zg4yAB+yK5jIxwbJPoV0JS6WvmmpFKbf1j3pzVfrwKvj6j+pscPkCq27rGXLNlKiBO
         Y1TQKMLv/7K2r/eibKqN4pTRDHwSzizbEcqOt0YDKrGiEyHIg6F2vjPZD9/+Pj7QSjYR
         YdfpC27SXtq44wmH7IhX49Zs880oEMSTwd7cW6brOGvpQDk1uabvLf1EHYtU819x/Vp8
         h+6mKKwW//IkzltaKRj7iMoPi6xOlCMSzq6mnsAWWuUzkEsKIc7CfCOtQe2FFX4mDvVq
         1YrQ3IGVhCfzg9fJRq1Qt0IJkegd48wmO8El56e5zeds1b0vMH/3PqiTxFDxbfS+bLaO
         sxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782607623; x=1783212423;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr5H8TFwybM+AlW1rdMOQH0Q1+oaaC7QfC19uDCbRGc=;
        b=Qi9uUqjcd1AMVP7qXMPRbJlVexKoWsfnU/i1oAbRtldKieBr37JuSXNqxZd3wFcnc9
         I95vESyznWL+LoITlXAd7uurMBhAsbaCXeQa+L04h+HnPOK+ao4+S2+Th4mEZ8Yut9Jf
         Cw+2eTptGoM4KCST2ph6dFO8eeIXI2Fuf7cGRXT/U4UMbD/xTO+Fw6CvvYL5jbv4X1rv
         NjbwuYSoJCiU7GvaQjpbhpuDDTXxJzFQXo0SB3fOyULjctZMQSJ61ApePFX/OKo9soDy
         I5VE2/5GVa3n7ioTSdtcjcsfOhB1zdo5X8x5B3vYjFfpzqTcuGzFqW+ouOhRayItZLa3
         0SOA==
X-Forwarded-Encrypted: i=1; AFNElJ/rvxRks1LdXbkuNQbi8ICCG/yUMpHhzIo60U41pt8WtxvGa8puSeTLo7Loi8uiCs5InSBA1Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnVvAsCbHwhJORwhLvtNzY/N7YGfHikbbW8L9z9jYFNRViB0mf
	ISTaWmONyOnTIJOTT0Hll+JxVq2G/oYaFpE2lQqoHewj35oXKpT8otPb
X-Gm-Gg: AfdE7cmJ3BnPJ4TKyULt2SK0Ql3qQaDZFhvAu5Ae3gHG2bTvgZ1cKzJVk7EkDc0NOmj
	th6szbt2/wXjLft3YtUHQegnUZ2RA+c1JU/dlGnPV9Np6ON6b0as92h1SyvmDLBjidECg7uzcJ/
	TYLweveiJNHQNpQaALOJFZZvtni4X8SuOFWR3aBvVH87SQYBKsNFYTL56vBX4fdKegZI3SD1jfn
	etIlMUirFoQuqWj6PpGNj6JfFpVKYOp5CHXdIewrMSsLzcj8oPTRvb7jsuOhmaTYA+dGe+OMdxk
	aIUpJiC3QKA2qLabhpGv7U+00as2Gm3iUDRT5VdkF8ut4VMZrIHvH254t+9e4qelnDROO9rZrZn
	OW/0UAWGCDlh0oISHDF440tLiSTuaZPAfEqNU4grWhasajep9ojD03QH7+mhxWP1x62lKzkoSio
	z7AkBP5HwKRNcpK1SAT2aX3wd55Q==
X-Received: by 2002:a05:600c:1d08:b0:493:a607:f3b8 with SMTP id 5b1f17b1804b1-493a607f49amr14531755e9.0.1782607622662;
        Sat, 27 Jun 2026 17:47:02 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46e6167c05fsm24063111f8f.25.2026.06.27.17.47.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 17:47:01 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] ring-buffer: serialize read-page order with subbuffer resize
Date: Sun, 28 Jun 2026 02:46:53 +0200
Message-ID: <20260628004653.28065-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ring_buffer_read_page() checks that its spare page has the current
subbuffer order before taking cpu_buffer->reader_lock. A concurrent
ring_buffer_subbuf_order_set() can change the order and replace the
reader page after that check. The reader then copies a larger subbuffer
into the old allocation, causing an out-of-bounds write.

Keep spare-page allocation and release under buffer->mutex, which already
serializes order changes. Move the read-side order check under
reader_lock, the lock used by resize when replacing per-CPU pages.

Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Reported-by: syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2dd9d02f60775ce5c1fb
Cc: stable@vger.kernel.org
Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 kernel/trace/ring_buffer.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 56a328e94395..eed5d7cffdee 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6950,6 +6950,8 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return ERR_PTR(-ENODEV);
 
+	guard(mutex)(&buffer->mutex);
+
 	bpage = kzalloc_obj(*bpage);
 	if (!bpage)
 		return ERR_PTR(-ENOMEM);
@@ -7000,6 +7002,8 @@ void ring_buffer_free_read_page(struct trace_buffer *buffer, int cpu,
 	if (!buffer || !buffer->buffers || !buffer->buffers[cpu])
 		return;
 
+	guard(mutex)(&buffer->mutex);
+
 	cpu_buffer = buffer->buffers[cpu];
 
 	/*
@@ -7091,14 +7095,13 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	if (!data_page || !data_page->data)
 		return -1;
 
-	if (data_page->order != buffer->subbuf_order)
-		return -1;
-
 	dpage = data_page->data;
 	if (!dpage)
 		return -1;
 
 	guard(raw_spinlock_irqsave)(&cpu_buffer->reader_lock);
+	if (data_page->order != buffer->subbuf_order)
+		return -1;
 
 	reader = rb_get_reader_page(cpu_buffer);
 	if (!reader)
-- 
2.54.0

