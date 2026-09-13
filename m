Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7B338655D;
	Sun, 13 Sep 2026 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319851; cv=none; b=dlEKoqwjPc1qL/kCRvoeaOZduyE9gj+k99YLZ9ZgojUlaupVATz1Pqv+I4075iKhGzqMlDGF/2ZREQDt2NeVNhCuadWW6wbxPoPiEHbgigyR9TJdxgxFXzAPMx68S1Z6O5dPvJISfManRwE82/sKhBh0Tt6H6e5/CFp8E18guOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319851; c=relaxed/simple;
	bh=Hjb3jb3USV71UqUDGp095Qnz40Hf9kgKYHVuv3k5n7s=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=MLMwOjEZFpJdg5/KMCXeVxz+cckVAzNJsNPfWjuAVWs6KrMqlX1+xC1IF4p/U9XASNIwCGLd58wAOololuwdE+PnrPXe22tNwslsk+IbISDtxRVJ17GGu2jb+5gWJWIYZthBZ1k77kKGoWdzQHlHnPUaHz2C0/5jlNpkd1G6GDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nL2fkYtQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nL2fkYtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BFE1F00898;
	Sun, 13 Sep 2026 17:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319843;
	bh=Raxewkw96Z82Y9nRPZmzJgCe1hQ47cf/cMMXBMB6o0o=;
	h=Date:From:To:Cc:Subject:References;
	b=nL2fkYtQ8ohLg8H5gnFrc29W83XppU0ipP2Riu+6c88MNitCroygteSukxj/cqAKr
	 94lMk263pDoVyHIfRW2O5VATDjVFjAq43EvYrihLWCrtddTcH3Gq7ttSIIgMYpGy/g
	 ZSDCV/QK/m5zUU6UTpLx8YDHcDguRUc1g0+ldFs8eY5zS27IFzedrnXyQ2pMkSc5O9
	 8K1OLQ8wpmrlHWikZOjBKsIHxkNW72favqWKn5GQ5+7SbCt3qHm0s5KwXh76kJP+ce
	 rm73oyPzU8xk/LSbM4TQPL6N/P++5D0qYwgYSz2R7V1mp5ObTI6EUiBed8KrFTUucN
	 Olr/y2IsT3u2w==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x5nqr-0000000AQZc-3fRE;
	Sun, 13 Sep 2026 13:18:49 -0400
Message-ID: <20260913171849.676672435@kernel.org>
User-Agent: quilt/0.69
Date: Sun, 13 Sep 2026 13:18:01 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>
Subject: [for-linus][PATCH 2/5] tracing: Dont dereference trace_event_file in deferred trigger free
References: <20260913171759.469375546@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: =?UTF-8?q?Ali=20Ahmet=20Memi=C5=9F?= <aliamemis@disroot.org>

The enable_event trigger defers trace_event_put_ref() to the
trigger free kthread, but the trace_event_file can already be freed
when the instance is removed.

Keep the trace_event_call directly in enable_trigger_data so the
deferred free does not access the freed trace_event_file.

Cc: stable@vger.kernel.org
Fixes: e091351b3881 ("tracing: Delay module ref count for "enable_event" trigger")
Reported-by: Alexander Gordeev <agordeev@linux.ibm.com>
Closes: https://lore.kernel.org/all/20260828134340.2501683A24-agordeev@linux.ibm.com/
Link: https://patch.msgid.link/20260911155650.354844-1-aliamemis@disroot.org
Signed-off-by: Ali Ahmet Memiş <aliamemis@disroot.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace.h                | 1 +
 kernel/trace/trace_events_trigger.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index bd3c8f80300f..3749485a7d85 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -1953,6 +1953,7 @@ struct event_trigger_data {
 
 struct enable_trigger_data {
 	struct trace_event_file		*file;
+	struct trace_event_call		*call;
 	bool				enable;
 	bool				hist;
 };
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index 149300cc5e8a..4d2fde996c0f 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -1728,7 +1728,8 @@ static void enable_trigger_private_data_free(struct event_trigger_data *data)
 {
 	struct enable_trigger_data *enable_data = data->private_data;
 
-	trace_event_put_ref(enable_data->file->event_call);
+	/* The file may already be freed here, only the call is kept alive */
+	trace_event_put_ref(enable_data->call);
 	kfree(enable_data);
 }
 
@@ -1801,6 +1802,7 @@ int event_enable_trigger_parse(struct event_command *cmd_ops,
 	enable_data->hist = hist;
 	enable_data->enable = enable;
 	enable_data->file = event_enable_file;
+	enable_data->call = event_enable_file->event_call;
 
 	trigger_data = trigger_data_alloc(cmd_ops, cmd, param, enable_data);
 	if (!trigger_data)
-- 
2.53.0
