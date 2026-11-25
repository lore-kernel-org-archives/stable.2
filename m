Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636709;
	b=kyo7Kq17QMD9Udrd0bJLrZtgOPE6yF8rAXxcGzU1w48kDU0rKFxyAASpzn24fDHtRZaH
	 uLpSIFokbgnEFPFNSCYPOHtnZNfS9T5oBMCC6hYn5BDeEPgvc85vXqAMN/dxtXwKGyuqx
	 yUQsQ4VHfJTqat+cKgk0c9yyQDNl9220+mVxfJQFw9bLlASAbVgdOJpLdMFGIbAQsst9Y
	 ByhiHH8C6tq6xI/N5lPWpzPrXZJKVd5wj0F7nHvXwRCgrIaBjIzgzKEVI05NeD9lbdFs4
	 peUnoGHQGTmDGwt/GI8wv3QMsBRILja0pCJwlG3A/gVSkrFS1YX2SCPbbPB2khf6vmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636709;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RWVrQHt7N1I1MKBgZhBZVo0T2tkQVTcS9VuLZGQ4yPw=;
	b=H77j+prRHBuk0AWYOpGy9JFmxb8t/O331BdljlkpKXXcA12nnnlWad/QF8i71NOubOoH
	 S9vXpDPgYC2eFiQEdNH7lHOHrMTnGGtkklB8KLeSPbL53SNFcE71J7EHq/XFll07Gs26J
	 /dUtDw/7SVkwZZwW7ukwfL3h0ZuwVyPypZttqYhuJOsMmTKkCUpzSuriUz/P7NmIaUKal
	 Aep+r47BO2JRfrU2ApzG5fvgU8rnvVlXHZMz9IO/evf8onsObNYElclSIvXQCaOS99O9+
	 0Nez3OooBAYk/f6Ny15BnHyO7aLtKUKdCY324HBYwBUU6HUqQ3+MSsowROmSDseqtBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPy1ItaH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8721606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PPy1ItaH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BBB1F000D3;
	Wed, 25 Nov 2026 19:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795636709;
	bh=RWVrQHt7N1I1MKBgZhBZVo0T2tkQVTcS9VuLZGQ4yPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PPy1ItaHu82YphrvbRCrHvplDyrCrkxdCbNkFGIDctCA0qIg/CixmamteHOtgcvYC
	 FH+TjigltZcToNIPMvdfs4VU2oOpQ6QuLfMP1nJ65x7gXWQ3OMNuv5cPq+PAGWcdq6
	 0Mnrt+G0V7flOccxVerZBlPCCOI06giFtMDAvk+Diw6NBMo1t2g/nWeyadB0S/mQoc
	 CStkfPxE10mrY86ombsPwWKGq0jii16SAbnaMqi1/IWsebeUQIUYVtdYqGFyGQa2Ia
	 bBW2B/4/f3EqDxLvT9VlsmSmdFoBSlSC3CQEn5ICcLOPQrOBF7Hs4FENiog0WAL2xL
	 O9lkDVKT8PWKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] tracing/probes: Enable newly appended probe when target event is enabled
Date: Wed, 25 Nov 2026 14:58:27 -0500
Message-ID: <20261125195748.1326022-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112510-womb-harsh-6516@gregkh>
References: <2026112510-womb-harsh-6516@gregkh>
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
[ sashal: Dropped the fprobe hunks, which fix code this tree lacks, and hand-applied the uprobe fix using this tree's tu->inode/uprobe_register() API and three-argument filter_func_t. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_uprobe.c | 71 +++++++++++++++++++++++--------------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 9b2348bcea154..3adbf674fca24 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -434,6 +434,36 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
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
@@ -453,10 +483,22 @@ static int append_trace_uprobe(struct trace_uprobe *tu, struct trace_uprobe *to)
 
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
@@ -1087,29 +1129,6 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
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

