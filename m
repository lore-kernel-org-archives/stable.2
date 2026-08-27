Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94271483BC0;
	Thu, 27 Aug 2026 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843365; cv=none; b=P7BFmadwPDWEp7Y4rvD4K/SAfnVLaP9vI6xslabs7QfFdXCZXJvmD04kzly1oNy4fgETKRxeav7bKQV8I1U627EUBAd8Bmzu6e4QGTkgWGov3HR+OEUV9GHjHNaE260RZ9bvV9THzERJw/2jAhI75Pqgudmik6ibSmnwszXRYA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843365; c=relaxed/simple;
	bh=rE9ONnbb64DmnGnBJPTYkqY0J4giVPlIuQ5Z+fpA4+g=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SL65XPJG76UUANvW22cMAISbpyFKO7nQFS0joPlrH4MhOw5dnYgPYCjFhCQfApXDtVrHnJaJ+Vvl0whYrzLArB9Ij58VQcx+YDgABqgi5O+N2aHwRHGNg0dbfRuO4a+XjZvSeyldKiNzs3s+33PSRys5WAhTSp66w+Ho9caTJxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkfPyTx9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkfPyTx9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778EB1F00A3F;
	Thu, 27 Aug 2026 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787843363;
	bh=zyjyAs9XuohXcWHmBc/uGuYEOCdR4P0MDF3YsN/etfQ=;
	h=Date:From:To:Cc:Subject:References;
	b=gkfPyTx9Rm4YIxdb+n+U6v8o5UD4k//4Hjy2Unt5WkmBglKjo24E6DmZJmJLLILL1
	 Sst4R7kz0LpKU42qyItGkz3A27chHcP3LAGjBMuM1C/a5517wvVa99AqJnuoRRlBcL
	 c4UH1Iie/gxhzxTCdqG+gKT0Ut3pEAhsuMt64upsqBGZU504mEro83FvprHeJTbeTw
	 V2ROIXtIdxyN9XZ4HqsTMWUcHc5I8tm4pn/ZX7/06vq+hnzK4n6O6J4BGU+KBFiMLp
	 FVcQ+hQjqBiq7+aovssRNC31XnmzAU2eRc//64cK5IjE18NA8wdbWHbGDhNcflR3kL
	 TO+7+JhgosH/Q==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wzbk3-00000008PG0-1ZBc;
	Thu, 27 Aug 2026 11:10:11 -0400
Message-ID: <20260827151011.232932653@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 27 Aug 2026 11:09:53 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Deepanshu Kartikey <kartikey406@gmail.com>,
 Haotian Zhang <vulab@iscas.ac.cn>,
 Hui Su <sh_def@163.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 stable@vger.kernel.org,
 syzbot+685955db58555575fdd2@syzkaller.appspotmail.com,
 Bradley Morgan <include@grrlz.net>
Subject: [for-linus][PATCH 4/7] tracing: Fix use-after-free in trace_pipe read on sub-buffer order
 change
References: <20260827150949.304280511@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Deepanshu Kartikey <kartikey406@gmail.com>

Writing to buffer_subbuf_size_kb calls ring_buffer_subbuf_order_set(),
which frees every sub-buffer of the ring buffer, including the reader
page, and replaces them with newly allocated ones.

Readers of trace_pipe hold pointers into those pages. ring_buffer_peek()
looks up an event under cpu_buffer->reader_lock but returns the event
pointer after dropping the lock, and peek_next_entry() then calls
ring_buffer_event_length() and ring_buffer_event_data() on it. If the
sub-buffer order is changed in that window, the reader dereferences
freed memory:

  BUG: KASAN: use-after-free in ring_buffer_peek+0x3e0/0x430
  Read of size 1 at addr ffff88802a4cf010 by task syz-executor989/6002

  Freed by:
   free_buffer_page kernel/trace/ring_buffer.c:398 [inline]
   ring_buffer_subbuf_order_set+0x1325/0x18e0 kernel/trace/ring_buffer.c:7444
   buffer_subbuf_size_write+0x182/0x280 kernel/trace/trace.c:8221

Take trace_access_lock(RING_BUFFER_ALL_CPUS) around the order change.
This is the lock trace_pipe readers already hold across their entire
peek-and-print loop, so the swap can no longer race with a reader that
is dereferencing a peeked event.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260817140655.5694-1-kartikey406@gmail.com
Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
Reported-by: syzbot+685955db58555575fdd2@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=685955db58555575fdd2
Tested-by: syzbot+685955db58555575fdd2@syzkaller.appspotmail.com
Reviewed-by: Bradley Morgan <include@grrlz.net>
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 740c5f358b75..60c87977f1e3 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8214,6 +8214,8 @@ buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
 	/* Do not allow tracing while changing the order of the ring buffer */
 	tracing_stop_tr(tr);
 
+	trace_access_lock(RING_BUFFER_ALL_CPUS);
+
 	old_order = ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
 	if (old_order == order)
 		goto out;
@@ -8253,6 +8255,7 @@ buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
 #endif
 	(*ppos)++;
  out:
+	trace_access_unlock(RING_BUFFER_ALL_CPUS);
 	if (ret)
 		cnt = ret;
 	tracing_start_tr(tr);
-- 
2.53.0


