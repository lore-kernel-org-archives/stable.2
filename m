Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7903B3A0B13;
	Sun,  9 Aug 2026 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242739; cv=none; b=ab1cSJMu3/IZ4abSoeLdxL/c1Exa8+76LqzPQr900a6G9cb4ow89g/w4JdjNmSpGh39qM6tHr90g1Yhv9s9aqsIStBUi5MYaPsZ+YKAqd6JCi+cmSvW+O5tvi0VIDO3fch7As13WFcMfReMizzggzubcfF9GC3VmvGA/L8DILw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242739; c=relaxed/simple;
	bh=aKVMLffV36JJyvmlxsMLg1QEYQKPju/acbqSOYLKtnU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HDsVeCjdBy0ANxrT0+nOeHIqR02kA+SxjCY13J5SsyrkT2/pKCMwSFti197g4Lx9t1547RmKzg319+Ct0iKDQzD39lOPzgxBBOPSLFJkPRdkjxSN4q/D3qLJtvp/FQWeSqJinEYhzGYhjCcFFyYxpQB93IhWBmNMMUcOT/JEX+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTIi23l8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTIi23l8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E0C1F000E9;
	Sun,  9 Aug 2026 02:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242736;
	bh=vrM2+TD+0MkuWqm0kWaBZvs35CJnjmmoRSUJZIkU/3k=;
	h=Date:From:To:Cc:Subject:References;
	b=YTIi23l8zxd0bZTQ+AotYTkZ5w+lp4pe2P2ZGI7pFj9qgUPBdigGN2afvd4oy56B7
	 vvWSSktG9zdh1Xxfj0pm7deKtN1edEoK6QMlsmk6WKTyvdmX6M61sPGMC2ncDp+gG/
	 AJvxsEnlgC5D87fOFvKYEB5uuh5AQdPGuqy+bWB5BXDjG2+W6awK0sTSePVhZj7Gkz
	 yZ0VXdrqPTsK+Q+5V6Qu4hBIY1XM9IhSc0qWlBmTGpf8RdqYKeaKSfaUSmFMFmRS5W
	 TABROXsGypppdIbrATQkCz2yd3apKJUTo7fQ7o+Sdv19Er1AFWvZyyMSOuww7iCfbn
	 CCUsTQZ2Ag9nw==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wstKp-00000001N8B-0vAX;
	Sat, 08 Aug 2026 22:32:23 -0400
Message-ID: <20260809023223.100369362@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 08 Aug 2026 22:31:56 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Hui Su <sh_def@163.com>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 12/12] ring-buffer: Fix crash passing ERR_PTR to kthread_stop()
References: <20260809023144.852271250@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Hui Su <sh_def@163.com>

In test_ringbuffer()'s out_free cleanup loop, the check
`!rb_threads[cpu]` only catches NULL entries and misses entries that
hold an ERR_PTR.

rb_threads[] is static, so unassigned slots are NULL. But when
kthread_run_on_cpu() fails for a cpu, it stores ERR_PTR(-ENOMEM) (or
-EINTR) in rb_threads[cpu] before the creation loop jumps to out_free.
That entry is non-NULL, so the old `!ptr` check does not break, and the
cleanup proceeds to call kthread_stop() on the ERR_PTR. kthread_stop()
then dereferences the bogus pointer, crashing the kernel during the
late_initcall self-test.

crash logs:
  BUG: kernel NULL pointer dereference, address: 000000000000001c
  Oops: 0002 [#1] SMP NOPTI
  CPU: 1 PID: 1 Comm: swapper/0 Not tainted 7.2.0-rc6-dirty #7 PREEMPT(lazy)
  RIP: 0010:kthread_stop+0x2e/0x220
  RBX: fffffffffffffff4
  CR2: 000000000000001c
  Call Trace:
   <TASK>
   test_ringbuffer+0x1ec/0x650
   do_one_initcall+0x6c/0x2c0
   kernel_init_freeable+0x21d/0x420
   kernel_init+0x15/0x1c0
   ret_from_fork+0x21b/0x320
   </TASK>
  Kernel panic - not syncing: Fatal exception

Cc: stable@vger.kernel.org
Fixes: 64ed3a049e3e ("ring-buffer: make use of the helper function kthread_run_on_cpu()")
Link: https://patch.msgid.link/20260807154145.2846521-2-sh_def@163.com
Signed-off-by: Hui Su <sh_def@163.com>
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 760a00e8505c..2667992f0aa2 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -8217,7 +8217,7 @@ static __init int test_ringbuffer(void)
 
  out_free:
 	for_each_online_cpu(cpu) {
-		if (!rb_threads[cpu])
+		if (IS_ERR_OR_NULL(rb_threads[cpu]))
 			break;
 		kthread_stop(rb_threads[cpu]);
 	}
-- 
2.53.0


