Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795637469;
	b=J2ssno+OFqgQ3DvEM9yMVtB3dWI9ft7sDYFt/vcY4eIEm7eKcXrJ1raKqNld2Yvlkyzp
	 kOum2Q0/X3gLVVw5cfldptyzXkYu9xD/HsVx1Vr+QiuTtLBSmJtdNNWLNPiFQCgCy95Lr
	 ozknIrjLcZioeg7Ru5yDCHEXrgwbLc6OMVrdS/eSEdwMSa7VvT1h4cq7vYfoHQVTYBWf4
	 v7SDclqVfvw+OhwHUbMCiuoIld3W9gznTEtqt2wjL/OlulCxwp0emVmQsxfNOy1byPgq+
	 SUhjOSEt+GP4SkfPkuX4R6m/lwlKqvEYcSQMaanSdYz6j7MiRxmBfSvKnEo178coXvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637469;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=J4NI+KL4D8v4aC4SHOEOgQxpFjPC/zIcQvSkhvectcM=;
	b=sbHgRWT+h7N5IKBD+YIB6YETDRkLty1wY60CrLkBbqPjC78sTL0vDrCIaXMRtrknksL9
	 bUKJu+eNDfA3g7ZYPIJQBjCvYYwjJFpx2np1ELzp97t74VF6e9rfTzeHDLfE3pWLqWMEj
	 hRo70fxHY6UGCTp33BkHF/rQJrf/ghxmix3W4swMhRI+31YE8urK0jyv3MdZJ07h/Gdya
	 KwPxlLJJ7ChjH4fgta4GPd3k0mvanifaUboWck/fV8K0csSvoIfhea0UfxEHzecCDuqeo
	 yyUeg3lreR0D5PV4Qb2XZMHjWjrZnf+7Lbis/+ibAh6YewyUecdIT3iSXviHQr+HvWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHkQiCXw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E395606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dHkQiCXw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053231F000D1;
	Wed, 25 Nov 2026 20:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795637468;
	bh=J4NI+KL4D8v4aC4SHOEOgQxpFjPC/zIcQvSkhvectcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dHkQiCXwDj+MyUw/xvmgpCfCEfzJHnxkWaQYROxwQtE7t9rzC7je/O1805z6MkQ0t
	 6l5B1ZJ9xRlz5HMWYPb3m8A95woNPAaCtwt0r6yh4Nm3QBgt01y2k+NeeURpfItWiR
	 4IYNLWEEX3l9rSXpQnXXJHwBUlM7CQXFZ8tE/yAfbJBvfWReT5NS/TMjfQCuaYor7d
	 hNhWuyvsc9GssjUe0uZ/T9mA0BVpHhS6P160vNtXi/El0S+HBD+wGlbhQtasUVUuUe
	 pVbNON2z0WOPMC0W5XgwxK8RaMkhWwtq/rGCc7J/bp5G13rFaMD7vTr93cky8dUoZ9
	 xdqJ+9qY5fJcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tracing/probes: Enable newly appended probe when target event is enabled
Date: Wed, 25 Nov 2026 15:11:06 -0500
Message-ID: <20261125201039.1393663-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112513-snack-retry-39fa@gregkh>
References: <2026112513-snack-retry-39fa@gregkh>
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
[ sashal: adapted to older uprobe API: filter callback takes a ctx argument, uses inode-based uprobe_register calls, and dyn_event_add() takes one argument; fprobe hunks dropped as that file is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_uprobe.c | 71 +++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index fd40018813557..b3955b2791b46 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -436,6 +436,36 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
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
@@ -455,10 +485,22 @@ static int append_trace_uprobe(struct trace_uprobe *tu, struct trace_uprobe *to)
 
 	/* Append to existing event */
 	ret = trace_probe_append(&tu->tp, &to->tp);
-	if (!ret)
-		dyn_event_add(&tu->devent);
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
+	dyn_event_add(&tu->devent);
+
+	return 0;
 }
 
 /*
@@ -1050,29 +1092,6 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
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
 	struct trace_probe *pos;
-- 
2.53.0

