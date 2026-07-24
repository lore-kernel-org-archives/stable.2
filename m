Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B25B3CF04C;
	Fri, 24 Jul 2026 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935111; cv=none; b=N5sOOX0Uiil7zaVsNKR+tfd6B6KdzE1aXNCIWtcEbTCMlFNXHlkUxPMAmGWFp+/K0KedUyQM62LhGrlXL7t7gsW9BpA66l1PvrZmrTzS7myPFl29Dw74czgXoBCUyvjw6L2wpqvYDyMPheKnkRECAGUODx20aiOypFuS1oEMbWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935111; c=relaxed/simple;
	bh=uFJSMA3qYpVAa+oE3Lj/zsz7CTGbfvJkRkMRMP4ZcFQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Gd8J+OVt0RlmN+MWWFFpbq5sGZ3pBBD3OJSR7EXO87KXJEetFKRxNrbTqc8Vr2JXbFbsPx6wzD/qgDOPDJiAsJpqxLMpNYhvay9fVQyLI5/3kgbcymY9xg9ocg1gsDXFlyJYn4HZXS1rk1XR87zT0DU27dOM06yOWCcTXEbygAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epxZKD7f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epxZKD7f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84661F00A3A;
	Fri, 24 Jul 2026 23:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935109;
	bh=1zOLheDNrEZSKVgM7iDuqJEupl58RtK41Jq8kQb0uG0=;
	h=Date:From:To:Cc:Subject:References;
	b=epxZKD7fmDPNf9UHAvHoVCeg7LtocVOqHH4r8eN9E4IvE0VbxeoE10avIVCRdVsht
	 M/AMuT/4JyCUnqInICV2ZK2qcGTCgw/IYlOMFyo/dO11bMxoRi2X1a6097tJd4H/s8
	 gSLWTr7nWQO8u8ofrcHiMrZNezbcWjmWKulRTxoKYExYbwZ+xtFzp7LGXyJ+sulbVL
	 d6YNSG1eoFHhP8q/8wDki0t0j28MePJX/uHcgNULehecKNuQKmZY1ti02Dxe+X0ThV
	 pIKXoSR+3czbZzcKUcYQtrObnwTJLTOCm7CgcGGntFsd+NLkbIQDBK733pZOCIDj5G
	 vxB3g66NY3zfA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wnPAN-000000046rW-36Kw;
	Fri, 24 Jul 2026 19:18:55 -0400
Message-ID: <20260724231855.591578614@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 24 Jul 2026 19:18:41 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Fuad Tabba <fuad.tabba@linux.dev>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 1/9] tracing/remotes: Fix page_va[] access before counter update in
 trace_remote_alloc_buffer()
References: <20260724231840.483353969@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Fuad Tabba <fuad.tabba@linux.dev>

page_va[] is annotated __counted_by(nr_page_va), so nr_page_va must
cover an index before that element is accessed. The allocation loop
writes page_va[id] while nr_page_va is still id and increments it only
afterwards, so every write is one element past the declared count.

The store is out of bounds with respect to the annotation: a build with
CONFIG_UBSAN_BOUNDS on a toolchain that honours __counted_by
(clang >= 20.1, gcc >= 15.1) flags it as an array-index overflow.

Increment nr_page_va before writing the element it now covers. A failed
allocation then leaves the slot counted but NULL; the error path frees
it with free_page(0), which is a no-op.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260713072823.2668323-1-fuad.tabba@linux.dev
Fixes: 96e43537af546 ("tracing: Introduce trace remotes")
Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Tested-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_remote.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 0f6ef5c36d84..ef42d9c38b37 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -1004,11 +1004,10 @@ int trace_remote_alloc_buffer(struct trace_buffer_desc *desc, size_t desc_size,
 		desc->nr_cpus++;
 
 		for (id = 0; id < nr_pages; id++) {
+			rb_desc->nr_page_va++;
 			rb_desc->page_va[id] = (unsigned long)__get_free_page(GFP_KERNEL);
 			if (!rb_desc->page_va[id])
 				goto err;
-
-			rb_desc->nr_page_va++;
 		}
 		rb_desc = __next_ring_buffer_desc(rb_desc);
 	}
-- 
2.53.0


