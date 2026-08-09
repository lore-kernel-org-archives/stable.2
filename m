Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187B037DAAD;
	Sun,  9 Aug 2026 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242738; cv=none; b=lEh0lM3Hu+DwOhpviLZSgGl8CdRRiYTSF5UFqdSOgx8MXjrvrud340UpGQ2KvKJIrM7k3+Lf0MAKikmCQIetdOLeerwj7W3FHnUCezz233GjJHBypJeHzV/lAbeQQqJv/X8QPXfwFsbniRSHPH3YyDWx+vF//oda6BiKcQgkYUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242738; c=relaxed/simple;
	bh=I4DN6ZYjV/wENBq9wuCDrz5eYZLp+C048DJDjL/cBwk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=fiP+nF+bsRmiTIuwIHDdstrmHmDJcZ9w1GNJqvUWGGq13imxP80lT7/rspIlsNL8LAO4B+L6XFw5NXVDCnA4b7Lc56oELFUt+AUDHcYL4HIbPNcKwVhVTXIwwmW2QXDof/KQx/5KGKJMGJinSBt93+wDvYcY/uUrgKregaHQnkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIuSuHgU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIuSuHgU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3F31F01558;
	Sun,  9 Aug 2026 02:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242736;
	bh=Q817XsXLmkmpVcUhbLOK+pXdDdo488E7ve87OMODTEU=;
	h=Date:From:To:Cc:Subject:References;
	b=HIuSuHgUqFZFe21QtpTtP/SSDb8nrIng1FbgAZYCsNe9G9Q7Bn6v3kv/EatGpqJwu
	 PAxFUqS548JpxzVKlvrpqcLWsEXT2H0KHadYx+tr2pLy2t2ZsbjawkqJg652fOv2Q1
	 iKNJJtquQQK5ZEH4YrXMD9EzLMwhb6wRP+7LxMocMNHO0QNBAMCVuNXuH4LcwcsZsS
	 I23yanFHniFtTI6o5tSamb7H3EYdhNvhYdXevgdpXFvd3Logcz3CPKholyOvT/gW9F
	 rXDM5eRbLD9osuAgaTNSgIGkct1zIrebcq3YO37EFVoaGD0Dgdzk9KYqVBDY7ItNGo
	 1wHgte5Nk7lZA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wstKo-00000001N6g-3H4Z;
	Sat, 08 Aug 2026 22:32:22 -0400
Message-ID: <20260809023222.657322893@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 08 Aug 2026 22:31:53 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 09/12] ring-buffer: Prevent resizing of persistent ring buffer
References: <20260809023144.852271250@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

Dynamically resizing a persistent ring buffer is not possible. Disable
the feature.

Cc: stable@vger.kernel.org
Fixes: be68d63a139b ("ring-buffer: Add ring_buffer_alloc_range()")
Link: https://patch.msgid.link/20260806211306.3704194-2-vdonnefort@google.com
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 58dc8995a88d..09d502ef4c55 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2528,6 +2528,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		if (cpu_buffer->ring_meta->head_buffer)
 			rb_meta_buffer_update(cpu_buffer, bpage);
 		bpage->range = 1;
+
+		atomic_inc(&cpu_buffer->resize_disabled);
 	} else if (buffer->remote) {
 		struct ring_buffer_desc *desc = ring_buffer_desc(buffer->remote->desc, cpu);
 
-- 
2.53.0


