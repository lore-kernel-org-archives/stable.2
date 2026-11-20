Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196479;
	b=2i9hyKhgCjEtYfdCzcLAwrjg31nHpYUOiS2+HAAwZxsDh+JskJkOlalV123BhXpWXL31
	 XDHWVGpWQFQe/p+JdvNnWXLBMCBmLpTKlTeZVfNwKzUYAfwsrJtk+DYtDO4LOnfxrZWpS
	 XH88QCOdXVWUzU4EXS6VJy2UludiAfxwKRcogCJ2dHbllt3ZJ6X7kHHLoDVzvHXehvYRj
	 hq/5R49bnlkeV0mMJqV8lQe4vvufdC/W48meSbH7k4ADwlH/Cm2OLbsv/IDFmGVgi7qgt
	 Sldp2YRL8T8z6/5Kzb3/HSOSaeuQRmX+9aIDiyCCbkX6e2nfPyzONuyvhDiQ02ldZYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196479;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=+UVLnGH9CvEKZ4XPKs0y9uE/RAF4Ar0eRVe9ikvQQRw=;
	b=OcORBxYWcz7pDCvAOZMrKe3DHzClFVMRWY9SMtwos9DLAb8cuDYTsoXUyxMNKtJxHOgi
	 eqgHPj9OHtQm/xAlETLe7pWAIh14xQuT+2tm3zB5ZXgGqBY1CisEZSW9N3vHl8IxW7+IR
	 Ze5ENjXKJXp/EK8awPZeQE510Ejwx5GamcRDpOdq0yTJiQ9f15lwAaroM6anyG+d46hiF
	 /KkpAnt1fjdUZkROkLci7lH4hwqqDDiUCTL3CoMouYpqgqSpZTJKX8vbM/oW/zPUuh3Gx
	 pPGcbWuY65NGHWABcZvNyw9h0uTK+32me6B3mQm0D+jkH1aZYMhFqKCTU5ZL7IN7DBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W30pZHPU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B4F606A332;
	Fri, 20 Nov 2026 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W30pZHPU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E1B1F0157E;
	Fri, 20 Nov 2026 17:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196479;
	bh=+UVLnGH9CvEKZ4XPKs0y9uE/RAF4Ar0eRVe9ikvQQRw=;
	h=Date:From:To:Cc:Subject:References;
	b=W30pZHPUf6lwWosf3454VtCjlXC2Vf2Dhtj4aPuwSNSoJJUgaA86bhCjtCks3kIY1
	 1RtU4VMrsMRTpggnS/xf3T8GSlZH8CsvmCr5rAokD1VjDxevXcDOaAz6znejFWUPXJ
	 uO0Z/0mICxKE2KAupUJpiMu3sGOUYgR7tOlHXddIqFu2Dt0m94J2cCyO2C285osd7w
	 DS5DINuif3/XP/6xFzGlxJTypCR7Ok+1lRgC1B93NdbupN1YNfqFnbKfY/UYZOwfcK
	 yOjQIxoPTVn+VmdCxE+XrdRavnBpNDqxpxm1Y2ZqTS+Roltcnl4Zsozee4Xd/hA5eX
	 UUa9Zj5mtUKQw==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbu-00000004aR9-29gK;
	Fri, 20 Nov 2026 12:41:18 -0500
Message-ID: <20261120174118.344694678@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:15 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 23/32] ring-buffer: Order remote page commit with data and timestamp
References: <20261120173852.687189370@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Vincent Donnefort <vdonnefort@google.com>

__rb_get_reader_page_from_remote() uses page::commit to check if more
data is available for consumption. However, it needs to make sure that
data and page::time_stamp are not stale. Enforce page::commit order with
page::data and page::time_stamp, and defer updating read_stamp on page
swap until rb_page_size() confirms committed data is present.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261113152729.837429-4-vdonnefort@google.com
Fixes: 2e67fabd8b77 ("ring-buffer: Introduce ring-buffer remotes")
Fixes: 34e5b958bdad ("tracing: Introduce simple_ring_buffer")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c        | 23 ++++++++++++++++-------
 kernel/trace/simple_ring_buffer.c |  5 +++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f728ee82cf54..158c7c75688b 100644
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
2.53.0
