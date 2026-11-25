Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636937;
	b=5nNtNYReHwNvDkBV36B1DjrQdTt/nANx/zSnGh5rTERzw3BwZaRlE5lxwtxG1n0lLie8
	 FSTcjBSNkyN76VRSQ8EJdN/fDMxGiqB8khEvEgAupUhDNwodKRzYxNBjDmH6+zPA5KpKn
	 bnyUsgvZ5mSKlVWy9QcADYKb0ZK4J7RCDD/m/dwixf62MassCwHQmedSYtAqPX5N4asZ/
	 F7KCD7OjHEco/jThMaZnbIKt68s/weRTKeK5Q+wUyD4oR+nE+aD2wPX5OW2ObExIsEVMY
	 cjW+8JjWOV3VJecuwlidxFt+1zkb/aYiKdWVsRDpHtbIbcX1oKqkr9hD/a6Dz7XPMsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636937;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SWbFkloqod/OFmhWM+OkSfAgmc/wdrNSIOPNkPDuF1o=;
	b=OCWrLswDEz1qEN1w1EC7Zzjv8dxuk3xyQAvQDpC0a0y7xKH73kyD/QwZ3yhipu+REbn2
	 frNRAEZ9NfG/80pV/j7aOj5qbsSS6ae7zE7bwphYWdu0cIc9rilMPjvusHLDB0V9zrPDI
	 R1J27BgRu2fKaJG0ge7zwpbmRKfGHefVNvjcJbFj8Lm1XVSY/FoOC62y7EIFp8PsKrS90
	 sI6qiqliroChUzTdM0s9JrITmsfMkIPdjhBxhMWzU6BkUjxQWHVXlaCFL4yT73f/fOk05
	 qNcmw+RJRti2hofEou3XMCYQuM6v3+wA4/e5KwNLNhJDqowG7WhL2zQCWSpTWck1sOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzic7dk3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E919606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dzic7dk3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 614251F000C6;
	Wed, 25 Nov 2026 20:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795636936;
	bh=SWbFkloqod/OFmhWM+OkSfAgmc/wdrNSIOPNkPDuF1o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dzic7dk3PqpfczlQpXvRup7hajdq7XgzqQQCu72vfnu8t3Eiki2DPYR+XSj6PZK2S
	 huPjX0hIWp0j85gLSqhQSVQlvFJWqwkMlJwWn7YYA7VI2urLy/msYLskiBmcNP+uCs
	 zCSgcppv390di/xOdg5ckwtavHRd9INCkhvLIh8UQZ9qotUzrW7Txqbrzwr20vNbOx
	 1Gp+bbPgCJzGbMaEi1zhEh1HZZNca1t0eeAQw7H+Z4FIiJ8BG3cmZ5VCeK0wbAUq3d
	 g1wcNvrN+gg8d2lZWUh62OkltDcK2Y6alNN6ObGeh6Aoi5JRvszczR+1u0rs6ppWkY
	 BnDmANxat/gJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] tracing/probes: Enable newly appended probe when target event is enabled
Date: Wed, 25 Nov 2026 15:02:14 -0500
Message-ID: <20261125200142.1359038-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112511-upchuck-striking-2706@gregkh>
References: <2026112511-upchuck-striking-2706@gregkh>
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

[ Upstream commit 72d3a5cb0cd7335553549aaffecc683e3ecc0c43 ]

Unlike kprobe events, fprobe and uprobe events only register their
underlying probes when the trace event is enabled. When a new probe is
appended to an existing multiprobe fprobe or uprobe event that is
already enabled, the appended probe is linked into the event's probe
list without being registered.

As a result, the newly appended probe never fires until the event is
disabled and re-enabled. Moreover, disabling an fprobe event calls
unregister_fprobe() on the unregistered fprobe, and opening or closing a
perf event on an enabled uprobe event dereferences a NULL tu->uprobe in
uprobe_apply().

Register and enable the newly appended fprobe or uprobe immediately when
the target event is already enabled.

Link: https://lore.kernel.org/all/179455849798.403392.135678786198324285.stgit@devnote2/

Fixes: 41af3cf587f4 ("tracing/uprobe: Add multi-probe per uprobe event support")
Fixes: 2db832ec9090 ("tracing: fprobe-events: Register fprobe-events only when it is enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[ sashal: Adapted to the older uprobe API: the filter callback keeps its ctx argument, and trace_uprobe_enable() uses tu->inode with uprobe_register()/uprobe_register_refctr() instead of struct uprobe pointers. The fprobe hunks are dropped. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_uprobe.c | 71 +++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index a930ef372ef42..77f6395775271 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -438,6 +438,36 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
 	return false;
 }
 
+typedef bool (*filter_func_t)(struct uprobe_consumer *self,
+				enum uprobe_filter_ctx ctx,
+				struct mm_struct *mm);
+
+#ifdef CONFIG_PERF_EVENTS
+static bool uprobe_perf_filter(struct uprobe_consumer *uc,
+				enum uprobe_filter_ctx ctx, struct mm_struct *mm);
+#else
+#define uprobe_perf_filter NULL
+#endif
+
+static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
+{
+	int ret;
+
+	tu->consumer.filter = filter;
+	tu->inode = d_real_inode(tu->path.dentry);
+
+	if (tu->ref_ctr_offset)
+		ret = uprobe_register_refctr(tu->inode, tu->offset,
+				tu->ref_ctr_offset, &tu->consumer);
+	else
+		ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
+
+	if (ret)
+		tu->inode = NULL;
+
+	return ret;
+}
+
 static int append_trace_uprobe(struct trace_uprobe *tu, struct trace_uprobe *to)
 {
 	int ret;
@@ -457,10 +487,22 @@ static int append_trace_uprobe(struct trace_uprobe *tu, struct trace_uprobe *to)
 
 	/* Append to existing event */
 	ret = trace_probe_append(&tu->tp, &to->tp);
-	if (!ret)
-		dyn_event_add(&tu->devent, trace_probe_event_call(&tu->tp));
+	if (ret)
+		return ret;
 
-	return ret;
+	if (trace_probe_is_enabled(&tu->tp)) {
+		ret = trace_uprobe_enable(tu,
+			trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE) ?
+			uprobe_perf_filter : NULL);
+		if (ret) {
+			trace_probe_unlink(&tu->tp);
+			return ret;
+		}
+	}
+
+	dyn_event_add(&tu->devent, trace_probe_event_call(&tu->tp));
+
+	return 0;
 }
 
 /*
@@ -1072,29 +1114,6 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
 	return trace_handle_return(s);
 }
 
-typedef bool (*filter_func_t)(struct uprobe_consumer *self,
-				enum uprobe_filter_ctx ctx,
-				struct mm_struct *mm);
-
-static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
-{
-	int ret;
-
-	tu->consumer.filter = filter;
-	tu->inode = d_real_inode(tu->path.dentry);
-
-	if (tu->ref_ctr_offset)
-		ret = uprobe_register_refctr(tu->inode, tu->offset,
-				tu->ref_ctr_offset, &tu->consumer);
-	else
-		ret = uprobe_register(tu->inode, tu->offset, &tu->consumer);
-
-	if (ret)
-		tu->inode = NULL;
-
-	return ret;
-}
-
 static void __probe_event_disable(struct trace_probe *tp)
 {
 	struct trace_uprobe *tu;
-- 
2.53.0

