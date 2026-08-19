Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170A3932DC
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787151403; cv=none; b=HED+lnvZTqaPZNMzdIGMvTddRL9Dnf7dCLdSLHhUcj69fAvAAqmO0Pj8QFY+EDCio0ZcGjUqUOi8Gk3rkB4jh5afqvLkanFBVMKqNOnJ19pMVcI5Yp2O3djiagjDEW+R01+I8MG+1SIYIBOrwyTrZRCuWlKKc7owBBxFLC1DAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787151403; c=relaxed/simple;
	bh=j+hepk3nt7tN0jjjtNNbUX9Con6lDO/iNQitcTTyinA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BzzU0Di/dgO7bxRTtmV119NFCtFV4UAAhrVBRDi2EeG927BoPHICgx+kYbIQv+pjCzmWDg1VzyvBg9gmDcmizSpyB+u6+ZduUZY5UCabAG8gpnrUhGdgC3SlGoctt0YIc4OlYHz6byNWZ49OsPP9p4SU9pauVkH2PBVkQYuRrgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLT7fykg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLT7fykg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DAF1F00A3A;
	Wed, 19 Aug 2026 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787151392;
	bh=RATOM4PEPoYWMB4eVPnhMls+ZRKqhJ5e9JazmHGtxPE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cLT7fykgCy+KstXuzGPYcZKXAS9Lpg4QH7M9b5y9qYyhqQnzkf4ZDJ/QNNNPSyw8A
	 iE5xRd9bQYf8mMZ1pI7C6DbmCrdWlTTbO1FLN+Yll8koLPOQcMqDGQ6AVNTlttUcmK
	 dek6c8Daub3hoxI/8d1l7sGH/oPuuvKyjusl2tLfE7c7DgURt32ZEnu8uDHOLk+uOq
	 K+XtnqNvoe/6mzr6GJakyWDCV7YvzWGXxXi4zagonMveJWC/nDeLPEwtT69wi7+Ax2
	 RWFvcmQaOArYqMmi+z2WR1e6POGhW3Rh86gDD3CjobQq+QyY9GVbS+pBNbG+GHNjip
	 8Q0VN5Qs7MBeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] ring-buffer: Make ring_buffer_{un}map() simpler with guard(mutex)
Date: Wed, 19 Aug 2026 10:56:27 -0400
Message-ID: <20260819145628.3900889-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260819145628.3900889-1-sashal@kernel.org>
References: <2026081709-tank-childcare-2caa@gregkh>
 <20260819145628.3900889-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 60bc720e10eac397b3adae975095df77bc368b88 ]

Convert the taking of the buffer->mutex and the cpu_buffer->mapping_lock
over to guard(mutex) and simplify the ring_buffer_map() and
ring_buffer_unmap() functions.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Link: https://lore.kernel.org/20250527122009.267efb72@gandalf.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: 7c727dfce6be ("ring-buffer: Prevent resizing of persistent ring buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 35 +++++++++++------------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 93f5c8326aec..d11bdcfad94e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7105,36 +7105,34 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long flags, *subbuf_ids;
-	int err = 0;
+	int err;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return -EINVAL;
 
 	cpu_buffer = buffer->buffers[cpu];
 
-	mutex_lock(&cpu_buffer->mapping_lock);
+	guard(mutex)(&cpu_buffer->mapping_lock);
 
 	if (cpu_buffer->user_mapped) {
 		err = __rb_map_vma(cpu_buffer, vma);
 		if (!err)
 			err = __rb_inc_dec_mapped(cpu_buffer, true);
-		mutex_unlock(&cpu_buffer->mapping_lock);
 		return err;
 	}
 
 	/* prevent another thread from changing buffer/sub-buffer sizes */
-	mutex_lock(&buffer->mutex);
+	guard(mutex)(&buffer->mutex);
 
 	err = rb_alloc_meta_page(cpu_buffer);
 	if (err)
-		goto unlock;
+		return err;
 
 	/* subbuf_ids include the reader while nr_pages does not */
 	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);
 	if (!subbuf_ids) {
 		rb_free_meta_page(cpu_buffer);
-		err = -ENOMEM;
-		goto unlock;
+		return -ENOMEM;
 	}
 
 	atomic_inc(&cpu_buffer->resize_disabled);
@@ -7162,11 +7160,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		atomic_dec(&cpu_buffer->resize_disabled);
 	}
 
-unlock:
-	mutex_unlock(&buffer->mutex);
-	mutex_unlock(&cpu_buffer->mapping_lock);
-
-	return err;
+	return 0;
 }
 
 /*
@@ -7194,24 +7188,22 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
 	unsigned long flags;
-	int err = 0;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
 		return -EINVAL;
 
 	cpu_buffer = buffer->buffers[cpu];
 
-	mutex_lock(&cpu_buffer->mapping_lock);
+	guard(mutex)(&cpu_buffer->mapping_lock);
 
 	if (!cpu_buffer->user_mapped) {
-		err = -ENODEV;
-		goto out;
+		return -ENODEV;
 	} else if (cpu_buffer->user_mapped > 1) {
 		__rb_inc_dec_mapped(cpu_buffer, false);
-		goto out;
+		return 0;
 	}
 
-	mutex_lock(&buffer->mutex);
+	guard(mutex)(&buffer->mutex);
 	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
 
 	/* This is the last user space mapping */
@@ -7226,12 +7218,7 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
 	rb_free_meta_page(cpu_buffer);
 	atomic_dec(&cpu_buffer->resize_disabled);
 
-	mutex_unlock(&buffer->mutex);
-
-out:
-	mutex_unlock(&cpu_buffer->mapping_lock);
-
-	return err;
+	return 0;
 }
 
 int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
-- 
2.53.0

