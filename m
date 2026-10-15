Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5788A5293F5;
	Thu, 15 Oct 2026 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071247; cv=none; b=GkrnLmz8b80tZ2EW2Sh7w2U+PDhHuj2fwwzbjTl4YYSHZAO233yUEYe7htp9AUO7xSfixU2jzhtkD+tkBZXfWGER2nNwUEsnZDBCof+RUwOV5qE3pbE2TqUKxJTjpCVKX6my2eLODHXeOKETQO8yc22YkvxwegCprEwWQPX4kDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071247; c=relaxed/simple;
	bh=rcfRsx7LEdxRhrGtezYRSm+SwLdx1r/Lme9jB9R13OA=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=Pb4icB11JC9IuN5qI1CyZRaTR5D+8dB19TuhtV5dpWGHR7S98cz/wT9VumYtrnMjZNgct2Pg2c13FsrjGW8Moe7WTIDbbDRhBjfDr9JwTLFx0pQai84vhub7oUhS68v+JO49ZUY6oZiM2j+neG6eukEe/3PzBNr1J1D5GY5IMYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chNBVFq5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chNBVFq5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37ECB1F000C8;
	Thu, 15 Oct 2026 13:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792071245;
	bh=l9B/7o7n2DtyxOUWTTRobPNHi4zoypaTePmPaqFwEFg=;
	h=Date:From:To:Cc:Subject:References;
	b=chNBVFq5ZIErpcRmu3I69zBg0s6pdanV3Rf84U9TI4Vo44isnhvYGE99ePsKjcqTa
	 dEXtLzHJFLBGRHfBKkiWVVbzyJGY9DKRcN4T2b2RIIKAuF842HBIQsFmxf47mCCd4Y
	 B2Wx/n/KAJAgtCT28Dx/oWy+8lr1YvCwSZvF2Q2od88/NTqemmfM74tzjNxq5U62tw
	 L4r8nmVoWTVBkU8hye2q/R6ggmaBTCWmqwocYTU8K5mDcU03Ae3v1emlAT7QxGCpbB
	 KVxxASegIHhDYi+nMGIPtgZyXYbw5Wonz2lXKwGqhsls8/njW0yA11ozC8kaLiP9Ii
	 jgrB/9lRggIzg==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xHLau-00000000Mg7-2D8q;
	Thu, 15 Oct 2026 09:34:04 -0400
Message-ID: <20261015133404.350085126@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 15 Oct 2026 09:33:22 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
 Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: [for-linus][PATCH 12/16] tracing: Do not initialize tracefs work if tracing is disabled
References: <20261015133310.731003448@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Amit Machhiwal <amachhiw@linux.ibm.com>

If trace buffer allocation fails during early boot (e.g.  in
early_trace_init() -> allocate_trace_buffers()), tracing_disabled is
left set to 1 and the global trace array events list remains
uninitialized.

Later during boot, tracer_init_tracefs() (invoked via fs_initcall)
queues tracerfs_init_work asynchronously without checking if tracing was
disabled.  When tracer_init_tracefs_work_func() runs, it calls
event_trace_init() and init_tracer_tracefs(&global_trace, NULL)
unconditionally.  This leads to __find_event_file() dereferencing an
uninitialized tr->events list, causing an early boot NULL pointer
dereference Oops:

  BUG: Kernel NULL pointer dereference on read at 0x00000010
  Faulting instruction address: 0xc000000000485be0
  Oops: Kernel access of bad area, sig: 7 [#1]
  ...
  NIP [c000000000485be0] __find_event_file+0x70/0x3c0
  LR  [c000000000448874] init_tracer_tracefs+0x274/0xc80
  Call Trace:
   init_tracer_tracefs+0x274/0xc80
   tracer_init_tracefs_work_func+0x50/0x320
   process_one_work+0x1e8/0x5c0
   worker_thread+0x1dc/0x3d0
   kthread+0x194/0x1b0
   start_kernel_thread+0x14/0x18

Check tracing_disabled at the beginning of tracer_init_tracefs_work_func()
and return immediately if tracing is disabled or failed to initialize,
preventing the crash.

Cc: stable@vger.kernel.org
Fixes: 6621a7004684 ("tracing: make tracer_init_tracefs initcall asynchronous")
Link: https://patch.msgid.link/20261009163557.88467-2-amachhiw@linux.ibm.com
Reported-by: Michal Suchánek <msuchanek@suse.de>
Closes: https://lore.kernel.org/all/arYskzbiaNzBR9MD@kunlun.suse.cz/
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Tested-by: Michal Suchánek <msuchanek@suse.de>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8645298579c3..3b22e70c6016 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9287,6 +9287,12 @@ static struct notifier_block trace_module_nb = {
 
 static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 {
+	/*
+	 * Do not attempt to initialize tracefs if tracing was disabled or
+	 * failed to allocate
+	 */
+	if (tracing_disabled)
+		return;
 
 	event_trace_init();
 
-- 
2.53.0
