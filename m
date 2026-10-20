Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498812;
	b=MTNreIeZTDoRHmyeItmMWpysBcF+n3zgy3qt0gjzZhjhZozI0Cz3lsJXQXCpVyO+EeHn
	 ymN0zTaHIcmKZhhuHZQEMSnqoB2IUn/wkkAvsNoJfYF+zWW6bK3M5+XHMSJc7xZWil7i/
	 truPTd9/dc53qfR+t7C1G4q/yqkc91oMY7X35ohqVMuq5J8sCZ20ayjumqUDsIPxSFD8v
	 GlbHrqdM5uTOH2NmfIjcHCNBeXXBjRPrDx7By1y5FW+Iy4hfLQKQCuBo28clnWjxEQo9s
	 isM2agE6/OqFN9tzLiYs/5Ps0Q8eNI4kC/qFMwmHICs0NUww8eInY6GqJLK+a5uYzYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498812;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=cwPu/4Bvn+cy6Kjc8M5qgzi57uIGkE6roO72sf9FkWs=;
	b=qiecgmNACGPF5p1tvZI51jNxZQCyfA3FKsd4vXsnXBm9WPIcLrZSdSmrpzUg5KDbUhV6
	 RYPq/gsCjBlPh0J9mNsNaawu/iXhpqMOdvYAaGkCQrsryRS2p3UmwIsPWi0JMjdzTjQTZ
	 yka6fnBZ75u7PzbAeZ4LbcceRSkZMKhhFZDGjuEL4iPf7H3HPZ+rDRjuzZ36zmvZywvb6
	 FPePd1zgkB4NTT+pX9UDXqjEW/UXoPHDT/vIqaJMAKn0omZgUrO3DftJrjzqpJI6jxq0f
	 Y1Uf2oe6ViDptO4tF0y0CFDbhm+UvrJCtQwQm3/iffIVsrgNPjM0RxnAKyZCUMnX7Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xd1O9+xj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BAE606A31F;
	Tue, 20 Oct 2026 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xd1O9+xj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C5B1F000C4;
	Tue, 20 Oct 2026 12:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792498811;
	bh=cwPu/4Bvn+cy6Kjc8M5qgzi57uIGkE6roO72sf9FkWs=;
	h=Date:From:To:Cc:Subject:References;
	b=Xd1O9+xjRNJ3Eo69kCHCq8A1LkA0dv8e/JXVYi62Ezz7w1s2HgOYUIOQ5J5F8yS/Y
	 KjUm3hKYk4R1/J03lP4jDYOn68f8Qq/0HsaZS4UFiJuWxHBp+6iwDP5Slj54+/vb8K
	 qz2VsM4rXsAU4zfOZZW1PGGcJc9xokyFfJr4dQ5Al4i2L3P390inNNGMnXGB5JexiL
	 AFQsuFZklLrXhnUVf0abXojyZ21OXNK7Q/HFTYDL+Np81rTxSQ7jIW2B184owB8P9N
	 2Mdv8sQukljgUis7NOWJAU133XItTu3dQTRrAyooiHJVqbIKJksrkSppuDugyL9yGv
	 AzN1/CMq0dw+A==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xJ8p9-00000001y2H-02Vk;
	Tue, 20 Oct 2026 08:20:11 -0400
Message-ID: <20261020122010.817062532@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 20 Oct 2026 08:19:58 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 David Carlier <devnexen@gmail.com>
Subject: [for-next][PATCH 2/6] tracing: Hold trace_types_lock when updating modules in persistent
 instances
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

From: David Carlier <devnexen@gmail.com>

trace_module_record() walks ftrace_trace_arrays from the module notifier
without trace_types_lock. A concurrent rmdir of an instance removes it
from the list and frees it under that lock, so a module load or unload
can walk into a freed trace_array.

Cc: stable@vger.kernel.org
Fixes: 5f3719f697c3 ("tracing: Update modules to persistent instances when loaded")
Link: https://patch.msgid.link/20261016061638.214847-1-devnexen@gmail.com
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 48ecc4bb55e4..96005a930b25 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9244,6 +9244,8 @@ static void trace_module_record(struct module *mod, bool add)
 	struct trace_array *tr;
 	unsigned long flags;
 
+	guard(mutex)(&trace_types_lock);
+
 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
 		flags = tr->flags & (TRACE_ARRAY_FL_BOOT | TRACE_ARRAY_FL_LAST_BOOT);
 		/* Update any persistent trace array that has already been started */
-- 
2.53.0
