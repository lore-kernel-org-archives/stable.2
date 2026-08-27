Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B9E483BD0;
	Thu, 27 Aug 2026 15:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843366; cv=none; b=mPaUvuwFFPwLIRxvKYrtVcpV8eRqVjRUTC9qFwvI//feduwwwvn0Rkq4e+jjQS7izeTjFmkYoHscAgH6I7044TVg0PrEdMzDkRqZ5YcMqukKmz18XzKdrtAOm+KMgoVsdS13tvCqYuFPlppDP8ufPD7Am1L0frN5CC+dQN+n8sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843366; c=relaxed/simple;
	bh=kyz2dtWICwa7+Pyo/t4DfHeokFCJ25WI2pLckoWiW1c=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JDjTcgg6En79GohHo0fC4qXdIfxzYp+QRaa4lp3YVGz2gk2Rj5RqY0Am4YdlxrILR1Fffvuuj2Vtn1G83RbyGoPE44Oc1kY7kjf2Daz02Q2xzITnVtzuir+ACnKIV0bD/ADA7CurHeZcQSWYW3+t1PAu9gbKhMuVUfr/MFi653s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+vYhec+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+vYhec+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64BD01F00A3E;
	Thu, 27 Aug 2026 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787843363;
	bh=6/5YtY7kTxdIotP3/iaXXG+tvNSlRhJ1vz2QoNLsBNU=;
	h=Date:From:To:Cc:Subject:References;
	b=O+vYhec+QDe6tmChCFszDHwFHqr9pNe954APZp4RJhDTkUXBnJ33QHe+HCwKFcKhG
	 ok86UbA/x1jGB/tnbCN3eqQMVuxWlkysy+IwfhHW7kGTaM6BfoTz0GFwOC+6yGcfyN
	 2lrTqxof0O1odZ7JuDKms9ofSp78XQv9MsRiknu62D/fpY61iy770LB7TtRL7yZXMB
	 ZYi7LGoa/AocK3+CgyPLr5NB2YTwzfoVu2H5sj/mjDh98cMqvwbs98htz2W2jlYtRq
	 gKfZ5baz0l+Xbe85JNhyWTNIeI6bqc/t8rEc4HIDiaM4fHJwrZkLXSXboZVzGGjpgg
	 7af/JEB2IHRWw==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wzbk3-00000008PFW-0teQ;
	Thu, 27 Aug 2026 11:10:11 -0400
Message-ID: <20260827151011.069475087@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 27 Aug 2026 11:09:52 -0400
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
 stable@vger.kernel.org
Subject: [for-linus][PATCH 3/7] tracing: Fix crash passing ERR_PTR to kthread_stop()
References: <20260827150949.304280511@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Hui Su <sh_def@163.com>

event_test_stuff() calls kthread_run() and unconditionally passes the
returned task_struct pointer to kthread_stop(). kthread_run() returns an
error pointer such as ERR_PTR(-ENOMEM) when kthread creation fails, for
example under memory pressure during the boot-time event self-test.
kthread_stop() then dereferences the invalid pointer, crashing the kernel.

Check the result of kthread_run() before passing it to kthread_stop(). Use
WARN_ON() so that a failure to create the self-test thread does not go
unnoticed, matching the ring-buffer self-test fix in commit
91542863abad ("ring-buffer: Fix crash passing ERR_PTR to kthread_stop()").

Cc: stable@vger.kernel.org
Fixes: e6187007d6c3 ("tracing/events: add startup tests for events")
Link: https://patch.msgid.link/20260817120642.668375-3-sh_def@163.com
Signed-off-by: Hui Su <sh_def@163.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9f8f2d02276c..1d39eaf6a0f7 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -5019,6 +5019,8 @@ static __init void event_test_stuff(void)
 	struct task_struct *test_thread;
 
 	test_thread = kthread_run(event_test_thread, NULL, "test-events");
+	if (WARN_ON(IS_ERR(test_thread)))
+		return;
 	msleep(1);
 	kthread_stop(test_thread);
 }
-- 
2.53.0


