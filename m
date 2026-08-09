Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44542288D5;
	Sun,  9 Aug 2026 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242737; cv=none; b=TTxBjp+islt7JzDA80ViL09ouRctsImXcwY8jMXvAm4F4MFKcpJ1JQRMumUbBvAODoWpNZdbpcAAecIVcfb1ZFRaO7gTrWhdSXH3GrJP9/Ejk+aCR+MGFMoX1L/2Z1L4+T3swAdwziE/aGoLxkPWSxmKotKGgRpWgK9T7IQVoE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242737; c=relaxed/simple;
	bh=YNR0P/zFuUV7bXFyQhPjlznSIw0c98m1qcxNvY1hGMw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nfyJTYJtCcEK6Asp2ubm16ZLCHWm5lccPsI2v5FBSqSlOxYkCg8sWmqU4EY3q7JlADYK02HButZR/58cIaS+p5Yzt1o9cHWKNDlII3cOCd/ww/d00EPz/Kr4p3c0CxhojSkBoflooTojH8IFHqudK8EVCLM/XQ46Mvs7YKnVvZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0BBPO/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0BBPO/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C471F00ACF;
	Sun,  9 Aug 2026 02:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242735;
	bh=fxBXChhYmXgLyv5TgSo4dJdJjV7r0PgcnZo4WSFSkcg=;
	h=Date:From:To:Cc:Subject:References;
	b=C0BBPO/7Okfh+zHRr4IJlqcW4JbMGUl8TfDB64PVKCm+RPAh6H5FtQqKZ3yzWcxY6
	 OzOkeGNQxUjEyPxWQ+GHSdeornZVSz8FIYg1R4TyR+NlgTekIveYi3RbWkfY4uUgTu
	 jSa+0idfynVNgr7VqqpFaxNpEZFFOEKwkuTJ+NPB7E/g26pCIYP15IuVxXVyYfuSZ0
	 ZAyZfJ28Xaz2/e+HRbmlZtiYMdyfDGU+6fBfcEbYsivhzBgZ6vcDRZ1gkoG+F11RME
	 cWBTV0xyhR90BlCG1GYybbcorNMO9YpMb/Wl0tA3hg+7NiUn1alDrXahApE82UU+h5
	 q9OoJMLhIl/Gg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wstKn-00000001N3j-3VY5;
	Sat, 08 Aug 2026 22:32:21 -0400
Message-ID: <20260809023221.693441329@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 08 Aug 2026 22:31:47 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Jiri Olsa <jolsa@kernel.org>,
 Leon Hwang <leon.hwang@linux.dev>
Subject: [for-linus][PATCH 03/12] ftrace: Protect direct_functions in ftrace_find_rec_direct
References: <20260809023144.852271250@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Leon Hwang <leon.hwang@linux.dev>

Fix accessing the __rcu pointer direct_functions with RCU protection.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260730150411.88667-2-leon.hwang@linux.dev
Fixes: d05cb470663a ("ftrace: Fix modification of direct_function hash while in use")
Acked-by: Jiri Olsa <jolsa@kernel.org>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 6c47a94f5924..c5d1d0d42ccc 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2645,7 +2645,8 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
 {
 	struct ftrace_func_entry *entry;
 
-	entry = __ftrace_lookup_ip(direct_functions, ip);
+	guard(preempt_notrace)();
+	entry = __ftrace_lookup_ip(rcu_dereference_sched(direct_functions), ip);
 	if (!entry)
 		return 0;
 
-- 
2.53.0


