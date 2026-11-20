Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196480;
	b=KVYiDSU2iB+kw5ZSnMacFl8Ac9r48a/wZI2SBMf71LhJlbyuhI8G1X6I7yKSCZkMR7mW
	 XieznhDICbIfcwhWnaBJ+/b+J9FR28YtwBriMFjWTPdCbXl3qw+yooD/MB4KNZ6/vKF9c
	 /2Fplwg8m7RUeudin67ljdK63ez21hpkS4AZOxpVudRucEtNs/l2sr8jn/X4+tXLuP6Rp
	 kRpg9JnV0m2TrfzpA43NzLnGnXPBy+0qWpOR5T6RSyyPQUC3KjFkDPntHPj5/RumHZnlG
	 JTIbGKPahq97ApaVK3X5YFYDhzBesnPnZ0/eOVj3sASVSKbUCNzI/qTjiCV0z6q9qjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196480;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=dTORwJjh2GP/tQDSNXGaR6IiHSyQqUXOWpgsZOvmQSs=;
	b=RObq/ZF2+xR0OwOXEhIqVPBTv8HVZlFCaNwI76GjX+q+tyCzzrF4+fmXYUNmenF4GDP1
	 NttO6sR4tzziQpEebqMjjh+oXsA0HlAXmSCe8C1+851YllySw2U2DFOwWWO7OozV2Dirv
	 OxmtJPJk83zXB6xyxDjmrTAckdwYV6+Hc+rYqmn8ZOqc/GLl1kdxK5f/nA6I3tqmj3gHU
	 CKldEU8g8m/ja8LkpOgna5FBQiP4VSSAfVS9vgZGIVEqLWhHqMzwftqp3KTf0tiRl3ubx
	 yHr93WjruX3gyBeBSwucMMxSbLt0bd+HVfz7zMBkjmG1NdpbHkm7geLk7nPOVynxPgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsQwJL+q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCEA606C2C1;
	Fri, 20 Nov 2026 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WsQwJL+q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822CF1F0281F;
	Fri, 20 Nov 2026 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196480;
	bh=dTORwJjh2GP/tQDSNXGaR6IiHSyQqUXOWpgsZOvmQSs=;
	h=Date:From:To:Cc:Subject:References;
	b=WsQwJL+qYgjcEGrIrQ2A48+MWcjGLREUZXun+HeC6TassfAFwKfkwwyiJAnAFCCPs
	 AH8EPfwWCbQeXdcYD3yA+rCRvcujk2AHOCFVf4HBYJE3RkcuKJD4bhQiqe6ECE5LmP
	 jW1zqddL3B8fyRYW1ssokwevroIgaOsEuaeybwgbZJdG3fdsEAmXO2ctZOxptJsXFg
	 IFvKMrn+fj5cEx/M37uWnrekhG9zQDlROQCb66pq5mqTMH5kgVFSH7GfrVn/AAOcHR
	 KUxHEXxWMAC3KdonRw/Q7zHLe3YIU3zvvmRDse58WZoSZC21rxkxZ0OuVgXq4qKv60
	 nyNUSZqBtISkA==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbv-00000004aV6-3P7h;
	Fri, 20 Nov 2026 12:41:19 -0500
Message-ID: <20261120174119.651825409@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:22 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Vincent Donnefort <vdonnefort@google.com>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [for-linus][PATCH 30/32] ring-buffer: Do not check si_mem_available() before deferred init
 completes
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

From: Amit Machhiwal <amachhiw@linux.ibm.com>

With CONFIG_DEFERRED_STRUCT_PAGE_INIT=y, only about one memory section
per node is initialized early in boot (16 MiB on powerpc).  The rest is
initialized on demand by deferred_grow_zone() when an allocation would
otherwise fail, or later by page_alloc_init_late().

Until then NR_FREE_PAGES can be close to zero, because early allocations
(SLUB, vmalloc, ftrace records) use up the first section.
si_mem_available() is derived from NR_FREE_PAGES, so it under-reports.

__rb_allocate_pages() returns -ENOMEM when si_mem_available() is below
the requested size.  This check wrongly fails the buffers allocated for
the boot CPU in early_trace_init() and for secondary CPUs in smp_init(),
both of which run before page_alloc_init_late().  The resulting boot log
shows:

  ERROR: Failed to allocate trace buffer
  ERROR: tracer: failed to allocate ring buffer!

Skip the check until SYSTEM_FREEING_INITMEM on
CONFIG_DEFERRED_STRUCT_PAGE_INIT kernels.  The allocation itself still
fails if memory really is short.

This is the second half of the fix for the early boot crash reported on
ppc64le KVM guests.  Commit b3b974008388 ("tracing: Do not initialize
tracefs work if tracing is disabled") stopped the NULL pointer
dereference in __find_event_file() that followed the failed allocation.
This patch fixes the allocation failure itself.

Cc: stable@vger.kernel.org
Fixes: 2a872fa4e9c8 ("ring-buffer: Check if memory is available before allocation")
Link: https://patch.msgid.link/20261118183235.63310-1-amachhiw@linux.ibm.com
Reported-by: Michal Suchánek <msuchanek@suse.de>
Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 0a1c7f98159e..a5a0adc934fa 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2468,8 +2468,17 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		 * memory. It may not be accurate. But we don't care, we just want
 		 * to prevent doing any allocation when it is obvious that it is
 		 * not going to succeed.
+		 *
+		 * With CONFIG_DEFERRED_STRUCT_PAGE_INIT, si_mem_available()
+		 * will reflect the actual available memory only after
+		 * SYSTEM_FREEING_INITMEM.
 		 */
-		i = si_mem_available();
+		if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT) &&
+		    unlikely(system_state < SYSTEM_FREEING_INITMEM))
+			i = LONG_MAX;
+		else
+			i = si_mem_available();
+
 		if (i < (nr_pages << subbuf_order))
 			return -ENOMEM;
 
-- 
2.53.0
