Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196479;
	b=g5vZu2lKJ556ld8PGSF9Hf5GYg1MpcNrSdDclQhT7gtB9aiMG/qqqn5hS8rTZg4pOSP9
	 Bl9sBUqcAkerhOouOLTVNdXpVJD4YVifeS2WBy9T56ulMXgjdPufb4QrdPBqmX8phnIFO
	 KgzlTglFcuYG2TzRfERIX/dI9YeCQt5fHnV76YgWYgw/Y0eQ5f1ISBQlydczv36Nor6/W
	 Hj6quC9vDj762aPQLKC24dd3x/eXr6up5lGr9+Bp7tNKOby7oEvixlJIUyLBmXmDS6Q20
	 tAhm9mhfMb/3XqLnSItOfj5xZSO8MmwjwvnKOudsMNW1Sw1/xB2rOkV1uDnYp2hTS0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196479;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=DJkyN6Aue57IyO1NSosFytaJPpJlcjh6E0edkfQkchY=;
	b=c35ClrN/6yyu7euI7TOTjbEw/DtklWmxCYI5Nmqwa+/suDeEd7jPOwsQDFtQFMFVV4ht
	 wOkA1x2irZBwtd2KAy0JSf7iIdvowB98oEhhp54ymipcj7szpHyYLGA+T3rA7mMs5jqPT
	 o2AUP3krn68LUJMVjJ9nv9KYr57JlxQ3LO7ddXrVm4HJ8IPc7geMUp4Pb42q5Y17uCSjb
	 7a4blor2Sfr9KdxvyRBRTLsEPs/vn1Yzliy/bvV/J48FSO8mtzRDeiG624Lf+oRn0MxdH
	 ze1Q2OAvpddBzAIP9914MFTpTy3CirwEPwuQM3v6tl6Sah+1Hsx2aOnB/YnRR4JpdyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CIGfr/PE";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D7D60A5BE7;
	Fri, 20 Nov 2026 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CIGfr/PE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EEB1F01570;
	Fri, 20 Nov 2026 17:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196478;
	bh=DJkyN6Aue57IyO1NSosFytaJPpJlcjh6E0edkfQkchY=;
	h=Date:From:To:Cc:Subject:References;
	b=CIGfr/PE1pIgcop1hzKJR5Eea3K76s8NhhXOUgfINUwwIngYcw97dAQMYvNmuvw4V
	 8YAff6wNCqmOkWFqgZ+3+V5BTmv0SQAMyu7pEgmfUIJ8xyi5R5utD/W7YBYHe2SSAo
	 VnsycvSfUXhEVSap5TpVjOi7e62HVs8F0+apc5tIS4Jy+bMAXCLdGUVMVBs81Ngq1Z
	 ZHQhfERzGBmU26VK7NuMCGEHAWCMfmkpJRuQ+TOPR1YIoMpeHWLoc0hObi52YuAmV7
	 r/RzDja787dHGFA1dZrwxr0UGBznGOMHg+ytGXWxXIr639kyxEKCKSeRxpIrUc7U6a
	 s5u0PzevctheA==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbt-00000004aPQ-42Hr;
	Fri, 20 Nov 2026 12:41:17 -0500
Message-ID: <20261120174117.794466041@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:12 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Breno Leitao <leitao@debian.org>
Subject: [for-linus][PATCH 20/32] fgraph: Do not mark index 0 in every shadow stack frame
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

From: Breno Leitao <leitao@debian.org>

We are seeing this warning on an arm64 host:

  WARNING: kernel/trace/fprobe.c:676 at fprobe_return+0x260/0x2c8, CPU#16: FuncSched/3281330
  Call trace:
   fprobe_return+0x260/0x2c8 (P)
   ftrace_return_to_handler+0x2bc/0x5a8
   return_to_handler+0x20/0x48
   futex_wait+0xa4/0x218
   do_futex+0xb4/0x1d0
   __arm64_sys_futex+0x15c/0x278

The theory is that function_graph_enter_regs() sets BIT(0) in the bitmap
of every frame, a leftover of an old tail-call check, while the return
path calls the retfunc of every set bit.

A reproducer on linux-next supports the theory. On a fresh boot, with no
other fgraph user yet:

  cd /sys/kernel/tracing
  echo 'f:fpexit vfs_read%return' >> dynamic_events
  echo 1 > events/fprobes/fpexit/enable	# fprobe_graph_ops: index 0
  echo vfs_write > set_ftrace_filter
  echo function_graph > current_tracer	# function_graph: index 1
  echo x > /dev/null			# WARN on vfs_write return

Removing the bit was agreed in the review of the series that added it
[0], but the line stayed. Drop it now.

[0] https://lore.kernel.org/all/20240527093436.7060d358a64cc2ea3213b07b@kernel.org/

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261112-fgraph-bit0-v1-1-695ad14f4b1e@debian.org
Fixes: 7aa1eaef9f42 ("function_graph: Allow multiple users to attach to function graph")
Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/fgraph.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 1d900445d23a..d1f79a85ed2e 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -698,11 +698,7 @@ int function_graph_enter_regs(unsigned long ret, unsigned long func,
 	if (!bitmap)
 		goto out_ret;
 
-	/*
-	 * Since this function uses fgraph_idx = 0 as a tail-call checking
-	 * flag, set that bit always.
-	 */
-	set_bitmap(current, offset, bitmap | BIT(0));
+	set_bitmap(current, offset, bitmap);
 	ftrace_test_recursion_unlock(bit);
 	return 0;
  out_ret:
-- 
2.53.0
