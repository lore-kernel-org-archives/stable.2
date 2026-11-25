Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795637158;
	b=MVqyPCoSBnahVSiOvi6EuEGJ2Oy+a27Bu+4WwRX6f3nTFy+nDUUXqb+HnSt3l4EI/icw
	 WDZJHEHS94ZtSv3bDOn3bQgWYAXprqNyxBNjlJRkWoVnm5CvYdacCR95h5HEceZks1upv
	 WgOajI2s/c3RsClty9N5dYbfx8UWjbmBKMShryFu85FROGqb9nUeLRt7vVl+CXRoUgnzX
	 S7AfeWdXnmUVpHrcgIO2boXjwYNpqrHi3jzenfJrf1qDY8kV641PBGNJAZQ8AU78KhRQj
	 SAyKQ04fvQJryRxlGjvUR2TQgnbmXt06bHCjYevQrBoZfGJLgbi+wY45bSIh/pCH3sA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637158;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QH3GZqvWuWKc4iTUhMx4/qz2punqRn2dsM9yHu8vtQg=;
	b=TSayO79rjiF/OkRzmrohk6NRHL1HxPFvgkR930ljh2CJcEfG76rEK+KLcVHsUnYDM+Tm
	 TZ+Coy0I7U7gN/43SZepcauxIeD69PORncOv3sEdcaMnAjYPAxfqHhoCPaG9BV+Q5dzVG
	 V4L5tbDP2UhcDeFqNEZ1J1ZkWIkrtgJHRi1/AF1dhTx1JOd5Fk3tm2UoaIBo7AjaalInL
	 IjekMEW4BTm8u5mDgwYKovuN9zeUDVb72XTs/vq4IBwX522Gl+WwOpHMr2dBGHSiHBJR6
	 Mv5D7agfYhvPDygaZUwx5uVBtz6k0qNYhhSVT999pyT7f0QxHpPl051Tg9dsAkQdruw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IDHT/z6n";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43255606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IDHT/z6n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101141F000CA;
	Wed, 25 Nov 2026 20:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795637157;
	bh=QH3GZqvWuWKc4iTUhMx4/qz2punqRn2dsM9yHu8vtQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IDHT/z6nuMt14zexN64TQzrFsUXbxWtoQkrK/mfG5qoio0152S4t0zHAT5jhWl3Se
	 KDqcXOzkTEQAW+AC7egGoJjzadJC3WY9MFzmTURTdfDgF8VwwfpQb0yO+Nex/ZSe4c
	 UjaE/U4rqs0JaLjzgRQhA7zSc3+tkRhEQW73WPWiA1Z4XGea9CpDPvHO2Lb2IUgq2i
	 QQ6LNtakTUbzyzVNnYynajtrJPSti3hB4G5uRG54K1rtx3xqkwlnkU/pU1q5OJ7TOV
	 wKhTlxmZiQpN+JKpq5bHZ9INEZhBUjlM9c/51Sk8q7+uMgk/LmsTy4yYa6VQWL4EaQ
	 w0SjwM5usGyeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tracing/probes: Enable newly appended probe when target event is enabled
Date: Wed, 25 Nov 2026 15:05:55 -0500
Message-ID: <20261125200524.1376447-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112511-playmaker-native-61fd@gregkh>
References: <2026112511-playmaker-native-61fd@gregkh>
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
[ sashal: Adapted uprobe_register() calls to the older API: filter takes a ctx argument, uses tu->inode with uprobe_register_refctr(), and the fprobe hunks were dropped. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_uprobe.c | 71 +++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 707c5373476ae..0f982b6df5122 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -437,6 +437,36 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
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
@@ -456,10 +486,22 @@ static int append_trace_uprobe(struct trace_uprobe *tu, struct trace_uprobe *to)
 
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
@@ -1051,29 +1093,6 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
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

