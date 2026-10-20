Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498812;
	b=5ZisMPikl9xVP4LYTVVuyc0kdToXAQEPLDpxBWTrB4zcS0zT6ZIdjgb8qN+MEadyhvrA
	 ngf24QXmcPrDwSCwWGAUceZBbinBNxViPN9naJ6sNCrNmqCMgfN0OsXvDYYr5+WxzuLtI
	 SAJ6TPzn+rR2AH5+12tGBaqw2Q1Eh8jDZBqfTVc03p/xhzykGUwqV8Oy0KpOWUVM69BBE
	 G6LoRw8g7adYLA4zHx9CV4X5h3Zz84n1BIKUrdGVnXy447KMCKUJ6GCtMkdUwY4prd2o5
	 x/3kFmjtunQbsnbN2NdSfaX+OWUlg1zAqWVWnb00CTHSulJfT7YQcf2JJ+YI3gOZ0nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498812;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=/JGYzef6dwMvvb10/mgZWVLJcuT7basMHiyCATUSdG8=;
	b=mXpRYVVLk4XHcEJHx2lFPqgHEGHRFHo1isScVtnlvuZvtFPTFN/BnTyXWiQgygTKg7ng
	 rIvgWr9MbKDXfWYMoR5kGF6DtOMY3WroROL2bI7wa1X/PIqmyrETVAL2kctE1W/TwnIAj
	 sHUoThtbqdvO05SYNdd8OrNNtSMHLwyyK9v7AZE/3Nfvo1nMl4HanzxXAO6ygtk2rBFJW
	 QFzAU9SzqWM5EaePjireifZx6QaIsSNh+ACAjQOjyM61N5wST3xuIuPqoJWZOyKCCtuJk
	 SksmPR23I1j5HUD+4STK58pvTiI9t/Cg0idM3QlzFOHNK/eBNiA6EhcWwagONgTbbhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxGtE6Ps;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1234606A339;
	Tue, 20 Oct 2026 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxGtE6Ps
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1931F000CC;
	Tue, 20 Oct 2026 12:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792498811;
	bh=/JGYzef6dwMvvb10/mgZWVLJcuT7basMHiyCATUSdG8=;
	h=Date:From:To:Cc:Subject:References;
	b=WxGtE6Ps/mVUShnIy6NiipRGWEiAAJtchYhCu5McTi2jGk0w9RagIuUgNlzfPEa57
	 23H9ZNTPHOCwDminl4iUf2L42BWaiqif7fyB7QszTkcPox4ln32JZijL01sKg6/kDT
	 NeV/3Ale8BglSwFeB9H9JJx4Raj0w0Xk2aYsZodrK6+pLgxaOG4mCEn+9WDkiFYm4I
	 5AH4u5flpqomsK+xJewegERc2Npk16Lvv71BuMdOZI4LMD0rYJsDPTWTB19uIt7Jet
	 rc9ZCQtQgltaVyIJaV2aatQacZBkM9i0CBTVLZeXXrzMNL5rM1rSUubJtK8H9mh5lj
	 Qw5hAhHPMuT5A==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xJ8p8-00000001y1j-3LDl;
	Tue, 20 Oct 2026 08:20:10 -0400
Message-ID: <20261020122010.604719885@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 20 Oct 2026 08:19:57 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Haoran Wang <haoranwangsec@gmail.com>
Subject: [for-next][PATCH 1/6] tracing/syscalls: Use copy_from_user for the faultable syscall buffer
References: <20261020121956.600452831@kernel.org>
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

From: Haoran Wang <haoranwangsec@gmail.com>

syscall_copy_user_array() copies the buffer argument of faultable
syscalls (write, pwrite64, ...) with __copy_from_user(), which skips
access_ok(). Use copy_from_user() instead so a non-user address is
rejected and the entry is recorded as faulted.

It could be a security concern for machines that trust perf a bit too
much.

Cc: stable@vger.kernel.org
Fixes: baa031b7bd2ce ("tracing: Allow syscall trace events to read more than one user parameter")
Link: https://patch.msgid.link/6ad19afd.a938ce27.16851e.3440@mx.google.com
Signed-off-by: Haoran Wang <haoranwangsec@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index e35744049e3f..d9190fdc030d 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -683,7 +683,7 @@ static int syscall_copy_user_array(char *buf, const char __user *ptr,
 
 	for (int i = 0; i < args->uargs; i++, buf += SYSCALL_FAULT_ARG_SZ) {
 		ptr = (char __user *)args->ptr_array[i];
-		ret = __copy_from_user(buf, ptr, size);
+		ret = copy_from_user(buf, ptr, size);
 		args->read[i] = ret ? -1 : size;
 	}
 	return 0;
-- 
2.53.0
