Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47309370D41;
	Sun, 13 Sep 2026 17:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319849; cv=none; b=N86BkyKy8bqdcCp3DqGCcxlQISguxAFslQGVxFJrSDP8JJQjKpmEeaatCrLJwHTBHFfCzcXemovPEMHrGoGI7Lmlz1I7rpTqbhY4xUognXtq27qVeIh3p+93uKE4HR6xa6wQ8yRl2j9Aa+CpDKAafelQazzR+IMMznKdmNdKY14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319849; c=relaxed/simple;
	bh=LWejCjAZqJWklyv2DB7hafpF4LepG0wucncy9KBYSUE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=DmJvfL3Ah9QFYKnv5hfuYN6S5RXpekO+x8Ln5N1oK4iwLx40drXCBWmcYSmcgMCWq2GCqT3IeROyUo4OFaMugIEKdYl/ZGGiGxbut9YOLdKOi8hrKkHt52ePRHNS1SOXBz0A58UcFESwjuc1Ze4ARqEHFyRA1xhDBI/R53SQBNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sly3kvFF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sly3kvFF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672861F0089C;
	Sun, 13 Sep 2026 17:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319844;
	bh=JL3u3PskqYHAUCtact9lBPOcYoii5FVMGre3nlXY8EY=;
	h=Date:From:To:Cc:Subject:References;
	b=Sly3kvFFmi90eFduiQdlZtWLKK7+QDPVtE12bzwTZhTfgpzcuEMjkbpOKQey7J/Y3
	 Mj3gR5a5YFLZmuKrxW+CyZ80aDQ2keotTzW0DpAmVm0nwBET/Bcu4EjYLd3dQDPB5/
	 TC50I/+oNvAwqdjTr5Se22e+zyRpi7GwxkE2yg9eVVHg/AXV/7cK/jNX5Aj1CsfoYT
	 Eqftq4OSVHpHVyNLRopZf+g1US30KT+e93sAd3R5h7u45qMpvVvp139vVTNIjWGwbC
	 wghIrx/3u6114gqs+LNtBUdlQ/fi5QAMsKtnGbEuDKX7j+d5gMEvRDzkOlB0iKz4Uv
	 hQ1V9DU/vMrCg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x5nqs-0000000AQbI-2B8j;
	Sun, 13 Sep 2026 13:18:50 -0400
Message-ID: <20260913171850.328757114@kernel.org>
User-Agent: quilt/0.69
Date: Sun, 13 Sep 2026 13:18:04 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 David Carlier <devnexen@gmail.com>
Subject: [for-linus][PATCH 5/5] ring-buffer: Check resize_disabled before publishing the new subbuf
 order
References: <20260913171759.469375546@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: David Carlier <devnexen@gmail.com>

ring_buffer_subbuf_order_set() stores the new order and only then walks
the CPUs, returning -EBUSY if any of them has resizing disabled. A user
mapped buffer has resizing disabled, and __rb_map_vma() reads
buffer->subbuf_order without buffer->mutex, so an mmap of an already
mapped CPU racing the failing order change sizes the mapping with the
new order and inserts pages past the sub-buffer into the VMA.

Check the CPUs before storing the new order.

Cc: stable@vger.kernel.org
Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
Link: https://patch.msgid.link/20260912103938.1127021-1-devnexen@gmail.com
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9bc8ce8c5676..04bb94c29f58 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7473,6 +7473,14 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
 
 	old_capacity = rb_subbuf_capacity(buffer);
 
+	/* The mmap fast path reads subbuf_order without buffer->mutex. */
+	for_each_buffer_cpu(buffer, cpu) {
+		if (!cpumask_test_cpu(cpu, buffer->cpumask))
+			continue;
+		if (atomic_read(&buffer->buffers[cpu]->resize_disabled))
+			return -EBUSY;
+	}
+
 	atomic_inc(&buffer->record_disabled);
 
 	/* Make sure all commits have finished */
-- 
2.53.0
