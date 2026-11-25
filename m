Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636372;
	b=oiITnOm/beIhNeLyFtqEIigi/CVC1A6DAZ6ijB7od3E2h3JseBTuBYQOYKtmqI+bGcSc
	 U8jbpzs/hRTg6R/RUUEwWKEChrL4HFWU4DHqbHWsqThRyPgTjLkDEbAupCpt6x8FMQHZU
	 yOALnBsdpPyGnKx7r5HDVDNOaGsCnI4mSYWV/itVZ5u2LhEd+rDX4hpELKlcYyM6Fq1aa
	 x2uyBVZeYievRPLCTbYKM3+uCqrT0HVYGbL/2ZARxZfkcfSfw9nEJj7JbFiss2RrtA3Fq
	 atHWosCvYv1bn+JQu+eoWWymB55LFW+wrnyQAZy3/IaIfkMJI9+UEno1/mC7fH+av+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636372;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=771LoipZJO/8ERQ1PZCD3ey20RmJy0Hxd1wuy7sH7k0=;
	b=ED/tl+UskGh4smMzxd48p/4tO7JbVtuUSYLYg71QaB1bix7xRIUteF9jYUJd08d+IxdO
	 OJxzH5BDI85GOTYeKkHXQhIG5dkbExEt5vRza7UVmMj8XXI+FxGABl52nkmKwHFVemaZz
	 EOdbMq/ggO+yGzoPZU9PtOoPBvga3lYyUIkpM/d+u2SeGmUyUIoPqatpFl7tMMYrJCFPh
	 YDOcYp/se/iVCjs36IKHghVfBBYxJ6O7Rnjp4ioTuGQx7xZHWjqRGq0lFurHOHyekZib5
	 tuqN4PUD4pnrYO+Uwg8V2q9F7dndEf41K2ZOQ6aO2RHR1OfSd4xXPzofK75ngs/uO3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h/Ulaqop";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E06606A333
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/Ulaqop
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548F11F000CF;
	Wed, 25 Nov 2026 19:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795636371;
	bh=771LoipZJO/8ERQ1PZCD3ey20RmJy0Hxd1wuy7sH7k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h/UlaqopGe7p7jqcpjBS7ML8tV5Bvz6nJr8E6gK7H1hE8PCUp3a1oiHExuCET20Hg
	 pZZxjpzRc2Savqfv3XoB3X79g2nIeyrWjOUFp1sHEu8D7ZOIUMCrit/WpYABDvH70h
	 u97X5yIvDesUN9lHiOjbOF2l5c/IsSR89b2mVyK6MmYy+EogG5TpiHhORZBYzCFqZ8
	 EpdZ87uE+ueeUKjPazKnNQlzAGoVWjygjCEBDWcqE6LLCdtXzMW/KVQmvQGvBEPEMx
	 ZR10v8QMh46GjGtBaiT5BynTl7E20iCA4LZpEWJIxGfi7wWvgevhd50aUcith6Tjiy
	 gDK2XsHLOn/+g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] tracing/probes: Enable newly appended probe when target event is enabled
Date: Wed, 25 Nov 2026 14:52:49 -0500
Message-ID: <20261125195221.1297809-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112510-straw-prozac-0c98@gregkh>
References: <2026112510-straw-prozac-0c98@gregkh>
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
[ sashal: Dropped the fprobe hunks, which have no counterpart here, and kept only the uprobe changes, moving trace_uprobe_enable() and filter_func_t earlier with a forward declaration of uprobe_perf_filter. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_uprobe.c | 56 ++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 19 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index cf5dc4b456eee..d18669586afab 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -443,6 +443,28 @@ static bool trace_uprobe_has_same_uprobe(struct trace_uprobe *orig,
 	return false;
 }
 
+typedef bool (*filter_func_t)(struct uprobe_consumer *self, struct mm_struct *mm);
+
+#ifdef CONFIG_PERF_EVENTS
+static bool uprobe_perf_filter(struct uprobe_consumer *uc, struct mm_struct *mm);
+#else
+#define uprobe_perf_filter NULL
+#endif
+
+static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
+{
+	struct inode *inode = d_real_inode(tu->path.dentry);
+	struct uprobe *uprobe;
+
+	tu->consumer.filter = filter;
+	uprobe = uprobe_register(inode, tu->offset, tu->ref_ctr_offset, &tu->consumer);
+	if (IS_ERR(uprobe))
+		return PTR_ERR(uprobe);
+
+	tu->uprobe = uprobe;
+	return 0;
+}
+
 static int append_trace_uprobe(struct trace_uprobe *tu, struct trace_uprobe *to)
 {
 	int ret;
@@ -462,10 +484,22 @@ static int append_trace_uprobe(struct trace_uprobe *tu, struct trace_uprobe *to)
 
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
@@ -1104,22 +1138,6 @@ print_uprobe_event(struct trace_iterator *iter, int flags, struct trace_event *e
 	return trace_handle_return(s);
 }
 
-typedef bool (*filter_func_t)(struct uprobe_consumer *self, struct mm_struct *mm);
-
-static int trace_uprobe_enable(struct trace_uprobe *tu, filter_func_t filter)
-{
-	struct inode *inode = d_real_inode(tu->path.dentry);
-	struct uprobe *uprobe;
-
-	tu->consumer.filter = filter;
-	uprobe = uprobe_register(inode, tu->offset, tu->ref_ctr_offset, &tu->consumer);
-	if (IS_ERR(uprobe))
-		return PTR_ERR(uprobe);
-
-	tu->uprobe = uprobe;
-	return 0;
-}
-
 static void __probe_event_disable(struct trace_probe *tp)
 {
 	struct trace_uprobe *tu;
-- 
2.53.0

