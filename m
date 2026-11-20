Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196481;
	b=ma93kHQfHbqw5PvvnkbLPwYdzm3FlliYTUdPPMxRvUh4O616aDSC59es02EOru82e5vv
	 VdYBjVo6MtjPIyCMHxuZyj34ZIN/ye0WiyyUzT2mOi3qIizHGWZ85A8DlOUji2HJyr+l3
	 tigXqKXVvEvr//sEx5HgqTz59GA22MoCPU7Q6XeI3I7LyPjZpwleVvU48wjK8tHh8f9DX
	 41MVNGc06a7dRKN/NBS5rY47dSoxgG0niyU4whSI5guVbCePvtquDA9HhVbJk+uJR6nps
	 dvlPVcZKXV07syJtYVx0DgJ5gGckFuUxz+z9cLTxqqFuwhcvncA3TeNg9TsiqBaEnWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196481;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=uOJr7K5Zk6N5xNtKPyLaKIikrpeZdMJldtew1Ej6/Fg=;
	b=wne142ZWFjFIBh93PRfEyGwsPNFQAAY0MN3AmXH2d/oFgdqz/qc8ezYjWj0MiCh/7yQy
	 qBGR874jKKCJ1fYbxS8dxnqgkD7H6qk3RE9moqnAubMnqFBFp5W2t3mo9PGxlJ5Z8Oieq
	 JfaMhrZO7DiLbCe/GBg7z+z6r3zDRr8BbYGjIxE3WXaWDpoOq/KCnyxjwPo8NERW+Z/0k
	 YvLlp8gf822yZPNJeLVOXX4KVtcEzrxV8X/PWFT2CbeMvrXgx79zTLS8o9YCAqFIXoner
	 oOSxNrii+341qoLXjJPpelQbotQz1LGgXCSIDsvr0qochIEvBA1hqGDp0O280Jt9y/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqEyi0oQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0957606C2CB;
	Fri, 20 Nov 2026 17:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SqEyi0oQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9CF81F0093C;
	Fri, 20 Nov 2026 17:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196480;
	bh=uOJr7K5Zk6N5xNtKPyLaKIikrpeZdMJldtew1Ej6/Fg=;
	h=Date:From:To:Cc:Subject:References;
	b=SqEyi0oQ1NkNIQcGZP1FDXHKXY92qXb/OE6Biz7lsf90sSaJNHkrn2jtDkYjbKStT
	 h8twG0IxmxNZRCWx6FBJhLYJ0Nivymkuh8tteixsiYIVriGjGb1P6RW32cKoGoBmIt
	 c54r3tjmDwINxK5iIXxaga6h37YNSD3xezFC4vS8Vmtw7CROT0dq8h0xaDW32eDPYf
	 /Qml0UGfkK137KrvDIqySGwllUF39gSqF0iNJer23ds5NxJEgPGSZaqXLyqjjVOIXE
	 /eWzmTZidubEwFLCZt/WbDyYgEwS7UhOnYxHZVJkxPSxDBkQmkvYaDUmliY/GQ1Rwt
	 UOs0UJXhMSJ6g==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbw-00000004aWE-0k7J;
	Fri, 20 Nov 2026 12:41:20 -0500
Message-ID: <20261120174120.014537869@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:24 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 David Carlier <devnexen@gmail.com>
Subject: [for-linus][PATCH 32/32] tracing: Ignore .function on the function trace event
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

From: David Carlier <devnexen@gmail.com>

For the function event, parse_pred() handles the .function suffix
before the ftrace_event_is_function() case, so "ip.function == schedule"
builds a predicate with no regex. Setting it through perf then
dereferences the NULL pred->regex in ftrace_function_set_filter_pred().

The "ip" field of that event already takes a function name, so ignore
the suffix there and let the function event case handle it.

Cc: stable@vger.kernel.org
Fixes: cfb58e278c6a ("tracing/filters: Dynamically allocate filter_pred.regex")
Link: https://patch.msgid.link/20261119080139.131834-1-devnexen@gmail.com
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 7018964c94fc..a9d77df3e19a 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1737,7 +1737,9 @@ static int parse_pred(const char *str, void *data,
 
 	/* See if the field is a kernel function name */
 	if ((len = str_has_prefix(str + i, ".function"))) {
-		function = true;
+		/* Ignore if event is already a function */
+		if (!ftrace_event_is_function(call))
+			function = true;
 		i += len;
 	}
 
-- 
2.53.0
