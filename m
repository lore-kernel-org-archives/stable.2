Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636292;
	b=gEoSdlRka6Wfqzf9jSOapB/zX0XHUqB1ThzBGRL826d0k2SqD+oMS7qnrUaPtScDz03k
	 pzqLlKzLnc6u5XtYYJ3S0+pW9Y2fRugJ7OtKm0VGRcY0rU5xTTu6DC1Puw2XRQbo/iUYL
	 9mxMPANtVEMHeikkbTu1N9Ux5MYDG3UfIkZR3kgCYfwHwRYRyVOkd3EqfIlRRNjvFtBLI
	 CnyniLZN5o3qpRRF+w2U+de5T7tUo7j2Ipt/QLccSgHvkMV7/8q0b6mH3VBQoZroJAwal
	 W/9gCJG0S0g3NOYD+EmSrVOI5ef454MxM/Zdcdj2Nl64GV8UK6uSoaYRnCkqcyr3eLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636292;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TP4sSgtrQaPdGKO+jewno5/M2X6iSdLMjb/WbXhX1ns=;
	b=xxaNtmadsxdsBkp0FFHupBjst1PqtHpxtd3z1GXyTmnFrf2kJpmt3MHdGyE+kBzhUxln
	 MLpUlr9LyrQTJOuIZ4pnETxQ2MMnNMbPyiK6B63rwIrkTidiGI/HZvKCwgDheuf44NjVr
	 K0BqAz2O32qKTFnmQ28HZN6NL6Z+FKQ7Kr3amN1rQo6PN+iGUfIG/oLnEdYPAl4llbX/U
	 +7mPDCFmAHNPI89h/7pkwDfn4kh8rL9QcbL7YLD64jSsglLhYFYyoV58ckKnhU1CUFSy9
	 kJ0aFsoLERpSXtapjpbPAE53jbyCg2DPBpuHnxnO4YcpaxINwaoXw9sGfypzIP5AEzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4+pleML;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB001606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O4+pleML
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD901F000C0;
	Wed, 25 Nov 2026 19:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795636292;
	bh=TP4sSgtrQaPdGKO+jewno5/M2X6iSdLMjb/WbXhX1ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O4+pleMLwNS6TDBfMJdeLpHbWqpqlLEPn2u3EabIDJ8hhfE69PIMGvfKNeFbRfIn/
	 nly9i4Oum2fTOoXVEygiwSCUT3i8m4c3o9cmb6iaGI2AT6BpHvv+4ANeFRmtw9B+r7
	 DYQgH/kPmVYWflnloqfyVj+O7URYtoZJWNUDMLayenOmhRPS2jAeH265YFqOoVybLb
	 iQYIIPvClFcIJLYaf80JwR6qMksgfqgSN37SYYhhNszIldJu05djpPwGRonR6OHcfV
	 Y9EoBuROyJOXv/m1lrDMDYxaEUv3+HDxCDc//0VFaEonFVIMDlDle5vfR4EoWeVkGE
	 f/NCXl0eJhedQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] tracing/probes: Check enabled and busy state before unlinking sibling probes
Date: Wed, 25 Nov 2026 14:51:30 -0500
Message-ID: <20261125195118.1297012-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112557-mutual-apple-88a5@gregkh>
References: <2026112557-mutual-apple-88a5@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit f1d9b7a3fe99b4228acdbab3c744c29f7ffe86ef ]

When a multiprobe event is enabled or referenced (for example, by an
eprobe, trigger, or open tracefs file) and a user attempts to delete the
event or one of its probes via dynamic_events, checking
trace_probe_has_sibling() before the enabled and busy checks allows the
first probe to be unlinked and freed while the event is still active,
only returning -EBUSY on the last sibling probe. For uprobe events,
unlinking and freeing an enabled sibling probe without unregistering its
uprobe_consumer also causes a use-after-free.

Ensure all four probe types (kprobe, fprobe, uprobe, and eprobe) verify
that the event is neither enabled nor busy before unlinking any sibling
probe.

Link: https://lore.kernel.org/all/179455848898.403392.17675270675769076596.stgit@devnote2/

Fixes: ca89bc071d5e ("tracing/kprobe: Add multi-probe per event support")
Fixes: 41af3cf587f4 ("tracing/uprobe: Add multi-probe per uprobe event support")
Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Fixes: 334e5519c375 ("tracing/probes: Add fprobe events for tracing function entry and exit.")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[ sashal: Dropped the trace_fprobe.c hunk because this tree has no fprobe trace events; the kprobe, uprobe and eprobe hunks applied unchanged. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_eprobe.c | 12 ++++++++----
 kernel/trace/trace_kprobe.c |  8 ++++----
 kernel/trace/trace_uprobe.c |  8 ++++++--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 19116ed205da0..450dcfe11e1b8 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -84,14 +84,18 @@ static int eprobe_dyn_event_show(struct seq_file *m, struct dyn_event *ev)
 
 static int unregister_trace_eprobe(struct trace_eprobe *ep)
 {
-	/* If other probes are on the event, just unregister eprobe */
-	if (trace_probe_has_sibling(&ep->tp))
-		goto unreg;
-
 	/* Enabled event can not be unregistered */
 	if (trace_probe_is_enabled(&ep->tp))
 		return -EBUSY;
 
+	/* If there's a reference to the dynamic event */
+	if (trace_event_dyn_busy(trace_probe_event_call(&ep->tp)))
+		return -EBUSY;
+
+	/* If other probes are on the event, just unregister eprobe */
+	if (trace_probe_has_sibling(&ep->tp))
+		goto unreg;
+
 	/* Will fail if probe is being used by ftrace or perf */
 	if (trace_probe_unregister_event_call(&ep->tp))
 		return -EBUSY;
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 4dbc2d8bc69c8..f8ce7fe47699e 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -531,10 +531,6 @@ static void __unregister_trace_kprobe(struct trace_kprobe *tk)
 /* Unregister a trace_probe and probe_event */
 static int unregister_trace_kprobe(struct trace_kprobe *tk)
 {
-	/* If other probes are on the event, just unregister kprobe */
-	if (trace_probe_has_sibling(&tk->tp))
-		goto unreg;
-
 	/* Enabled event can not be unregistered */
 	if (trace_probe_is_enabled(&tk->tp))
 		return -EBUSY;
@@ -543,6 +539,10 @@ static int unregister_trace_kprobe(struct trace_kprobe *tk)
 	if (trace_event_dyn_busy(trace_probe_event_call(&tk->tp)))
 		return -EBUSY;
 
+	/* If other probes are on the event, just unregister kprobe */
+	if (trace_probe_has_sibling(&tk->tp))
+		goto unreg;
+
 	/* Will fail if probe is being used by ftrace or perf */
 	if (unregister_kprobe_event(tk))
 		return -EBUSY;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index a930ef372ef42..4e50f405dc4d9 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -391,13 +391,17 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
 {
 	int ret;
 
-	if (trace_probe_has_sibling(&tu->tp))
-		goto unreg;
+	/* Enabled event can not be unregistered */
+	if (trace_probe_is_enabled(&tu->tp))
+		return -EBUSY;
 
 	/* If there's a reference to the dynamic event */
 	if (trace_event_dyn_busy(trace_probe_event_call(&tu->tp)))
 		return -EBUSY;
 
+	if (trace_probe_has_sibling(&tu->tp))
+		goto unreg;
+
 	ret = unregister_uprobe_event(tu);
 	if (ret)
 		return ret;
-- 
2.53.0

