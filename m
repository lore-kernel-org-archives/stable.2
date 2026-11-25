Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636758;
	b=xMM0WLgJos/nLwYSZIjeR5tufqpbJyD9DhxlE8koEBMpbkA5gPkuMa6XEfOSXfqytZAH
	 ZbGnolwYYk9NRZkiYi5PF/TSvgweSXL0hxDwze5h0NsMpXh2GgBESyxs0yR5k/quCXJ0H
	 XnPM+4kVZuGJXmSQlWD+juC6k4NfOWqQ1jxdaHR2PgrCT2/O7R3igYSmCZcvoJOkmoepP
	 cXQauHzEIq8GVC43Ktcuhom1vArDW8/1Vs/y8HVsTnigVGKZokkSbHu4SbLkiDZCnRAUR
	 eTcMRTJehBdMwKXBQ6w/LqdxfCYbthvrfZpb50EMMSHH3Gg6+r3UfV7vN7O6xe1lzSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636758;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m3MbHcE0k0JbRjKynp98FG5LrO3AylSxKri5vxIgC0k=;
	b=FkgAA8LP5B8RBJqCmmCU2Iu/+oDvKlgFKPPv3HTPItHQjtjCHaC7mLsNL6CdFvfc57TS
	 g1wWGUy99YAsoNa8y9CCHcwMgPXTlR+NRBVh5Vyxf3cEwkHGJ5BoWGaN69HI09fz0pTVA
	 wpdi3pzPXCFkCTF+RcdPAxaknH7Tds9JbmYSGxJphw3LNvGAV+h68h36znzrXRxhaN7qv
	 OXHPgOhK/obpQVtXR5WN/pxxT2wncLt9+usIpDPE24N7ao2PhkGeqAZ4tSogvy8Vr+2qO
	 5aYaK+GYH8Rn4vvO0NBBd8ZvtHCumjmyZU7RpNqOoyzVICCoxmqSYLV57PPqkaw0Bqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFCIA045;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E0D606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JFCIA045
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0DC1F000C4;
	Wed, 25 Nov 2026 19:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795636757;
	bh=m3MbHcE0k0JbRjKynp98FG5LrO3AylSxKri5vxIgC0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JFCIA045LgpisWV2FKGgcQZygACX7hH6zRgeWAdtmvb+N35pTk6lT/3bckEpiQX9q
	 poyZ51Oezsiwzdzw+VjPgYzuFnhRcJmurkWx3N9hyfKTXUI1c+BtJOz2c+MqHJxabw
	 QvCJ57L2xbiuYu6FXZI+pgbAyoJWBWM5r2WewNFVZnwK+jspMFAuMtWTlXDGrmvkvO
	 W/5s+a5v9f3tkgBOtzOxx8RGQTZrU0oc2O/AhRlfRLm1bIjagW5J4iXZm5MFbyRzdT
	 8f/kzime+ZEL+3N2m0vyIXhNIWD7S5ucXvbrSR7TyG89ey3WwKSwPPjfD4qIBdeRVL
	 /DRsi/oHG5i1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tracing/probes: Check enabled and busy state before unlinking sibling probes
Date: Wed, 25 Nov 2026 14:59:16 -0500
Message-ID: <20261125195857.1335120-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112558-factsheet-baked-a5dd@gregkh>
References: <2026112558-factsheet-baked-a5dd@gregkh>
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
[ sashal: Dropped the eprobe and fprobe hunks (files absent) and omitted the busy-reference check since its helper is missing, so kprobe and uprobe just run the sibling shortcut after the enabled check. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_kprobe.c | 8 ++++----
 kernel/trace/trace_uprobe.c | 4 ++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index cfba33f74813c..6494c168cd45d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -535,14 +535,14 @@ static void __unregister_trace_kprobe(struct trace_kprobe *tk)
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
 
+	/* If other probes are on the event, just unregister kprobe */
+	if (trace_probe_has_sibling(&tk->tp))
+		goto unreg;
+
 	/* Will fail if probe is being used by ftrace or perf */
 	if (unregister_kprobe_event(tk))
 		return -EBUSY;
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index fd40018813557..201fa7a443630 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -391,6 +391,10 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
 {
 	int ret;
 
+	/* Enabled event can not be unregistered */
+	if (trace_probe_is_enabled(&tu->tp))
+		return -EBUSY;
+
 	if (trace_probe_has_sibling(&tu->tp))
 		goto unreg;
 
-- 
2.53.0

