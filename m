Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636475;
	b=AEqbfmNekeF49Np1UA8Ku3OP4P3Yq2Rh3P42EVW4sQc/JDXNhy2PhMttgqmqJlUMvqIi
	 TjJnrh62/CNWb5mdAttQPWsyqQd7gapTGiXz6GX/gY8zECICqSlq6YbeBenxItxDu90QJ
	 L1ItZowpS1RqftMgJ7kQxkALf4qZ3PrZB6aOcK1YEN25KbR79oH3xF1wy6KUjVxttsaV7
	 COJIT6oWLd8Hc0xtVzujzgi/uCfWuiVpZilkfRlyJ4Gqu3l8ZsNiuIUaFygWcfMNTPP//
	 VI6+T4ab2OjC98L/EfFe5qxV2BwcihLXzF6A8Ci2k5jmP6/I7DjEHnPi2lQJOM0ZRFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636475;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UNwQB8461AhD6x2R7lL45j6ZhPY4NjdrvePf+wcvVDY=;
	b=Qz4zHB+h4t4zZBiJNr+Q394NI1AufjXiEn5JeY9MfMZBGlO/0wbE1RYjBd4XwkqUYenf
	 fGAND7jeHSXcJ9fxzygNO8wlxBQWOdWzcEw+mUVBKtf4RmM+RHdLSgD1lHhvzyogyd6Gp
	 0Z+A82TAp6OIxmjweJtb/C+Gfkj6ifIL6vGtrCkuiLZlDf6tDkIggI2dFxeELgiv02JG4
	 3FnoM+Twivoo0krCh7U43Zjnbn/TcBih1CY7ux02fhu4nT6+pAMSepyCeX8LFgbFf0L2Z
	 3r0h35gk3diSMpMatjg5jk2ARS7q2QyElfAgqrm+0eSioFEYei18gowsRWiZZYmFZtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIH3B4XL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97309606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TIH3B4XL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 896561F000C6;
	Wed, 25 Nov 2026 19:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795636475;
	bh=UNwQB8461AhD6x2R7lL45j6ZhPY4NjdrvePf+wcvVDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TIH3B4XL1/mJOV31O0ZqOIMtsz6HOVVyweDORovNAePq4s8Y1tClO3IcnasOMfyjn
	 8E76pps4+POCBrFhUnbdwjp06LmwNeUdBK/ibqo1vOORu9vDeV8kCc0YJnCZEvH1Kv
	 LIvoMYhXD//r6IzXNmaI+QdPRz0LsxNzFMcUdOb3XIfMQL1G0J9v0oi0aEERXqNPdT
	 oXCGQwzV2U1qjkeukpy1oHIRwX0QNHklyCzZBO7trBtOAXdq7vWVnYYGZ0juTsO26Q
	 a3d8Ur+oxgNd+B2J3HSP36m8Rt3WUQqkSsO05aOAm/yqfBZB8YyaBA+vB3bF8FX/oe
	 vBfftL2KANz3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tracing/probes: Check enabled and busy state before unlinking sibling probes
Date: Wed, 25 Nov 2026 14:54:33 -0500
Message-ID: <20261125195420.1320547-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112557-discourse-shopper-85ca@gregkh>
References: <2026112557-discourse-shopper-85ca@gregkh>
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
[ sashal: dropped the trace_fprobe.c hunk because that file's unregister function doesn't need the reordering in this tree, leaving only the eprobe and kprobe changes. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_eprobe.c | 12 ++++++++----
 kernel/trace/trace_kprobe.c |  8 ++++----
 kernel/trace/trace_uprobe.c |  8 ++++++--
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 0bc8c1b4f4704..3bcdaea53dc7e 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -80,14 +80,18 @@ static int eprobe_dyn_event_show(struct seq_file *m, struct dyn_event *ev)
 
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
index 354ad90ceb68a..3e70b1541c092 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -532,10 +532,6 @@ static void __unregister_trace_kprobe(struct trace_kprobe *tk)
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
@@ -544,6 +540,10 @@ static int unregister_trace_kprobe(struct trace_kprobe *tk)
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
index 707c5373476ae..409130c303d43 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -388,13 +388,17 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
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

