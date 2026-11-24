Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795535875;
	b=1oGH4AwmeK/y4d13PZrxg86eGacYElNmQmJWol+85ilfYvo5VX6PwNzfu2TvOPUbtB44
	 tLrQNj0KGLPd+1/XpndjUjayhu+4dVyLNoPl+iIpn26NkLmj1KH9vhcd4EWbLE7oYG0k+
	 TqSRPUTUi9tCRnX1vl751aoP620VS0tqsT29K/fFrVxP+qKTfi72EyQCum80nSOWS1aVk
	 5gZeincVjzYra273B9oVQafRShHktk550zadDDv0280gLmBaT5A96ET43Ttun1CxQ0+nI
	 axopuROftD0ti3lA+ORSJb+bZY74Ww+FoUA6IbzsIYTtPfGWgNxt1kqFv4K/9RdvctQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795535875;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dCI7TNMm0h9zoAFk0uEb1nGBRwzBnd+A9rom7B4XlRQ=;
	b=31z9XDbNNwz7u1G0FK6B7gnQrVR8YNa3TdCTiQDEYXF+G4+Yjp4Kb2J0l0KWBRu7IEYf
	 t8txqPS9RG7M06pD+ffID3O5jzm6+ajKDpHTVNBGb6dSf7pNKa622WTZUdWdO5dMQt8Ix
	 bKyQFIseGWgG2queqEllybWImiVFWwRwOEit9xPkW7n837wwx5xhHlItg7yHNucTW8cQX
	 QeCu82FVgGi/8B30qlmT5PWV3+v+2HhdlM8cW/1iVpcEdllgfkg6NGCMMFbxwB3B6Jk15
	 zbIVlJlp2bEq9AqJcS5VpFj6f5bFV4HIRQsvuQXk/gGZKp/UXIb3NF+UtB+969Uvfxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsn2Ss4v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4D606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nsn2Ss4v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304F91F000D8;
	Tue, 24 Nov 2026 15:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795535874;
	bh=dCI7TNMm0h9zoAFk0uEb1nGBRwzBnd+A9rom7B4XlRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nsn2Ss4v5f4kxzfFSEzls4MBKpiGCc3rJfAARuuzxyZcYksb6OCdgOV+78Hu5VbaT
	 71NOX7TxcrzQF2ASJuJALBmUDFAVmM9JJ/Ibdz6PSLpACH1rgPkRPzgrpBXxiOF2Nt
	 F1Vsanj1+HrG+BSNZmowvoucQH3G0RHFvkHUjYvJiBX1Y97+3KQ++0bwurYGYbP2rt
	 DRdb7k47zKMi+1iFtPfwu9MqjJYRhBo50XO7fWHk0onS/z/bAcXZcnfE0q5NrvMywN
	 mMCFoEMjmaqARObhQRVjQ5iZdoiJ8M/iZCa5PRR38zPpWsE219gwutbNimQUT+IlUC
	 UJjpIJQBHXfDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] tracing/eprobe: Install the trigger for every instance that enables the eprobe
Date: Tue, 24 Nov 2026 10:57:52 -0500
Message-ID: <20261124155735.795316-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124155735.795316-1-sashal@kernel.org>
References: <2026112427-vastly-starter-c2ec@gregkh>
 <20261124155735.795316-1-sashal@kernel.org>
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

From: David Carlier <devnexen@gmail.com>

[ Upstream commit be94710b1f6ba1bea33e73129c110af80e999b2d ]

The eprobe trigger lives in the instance of the enabling file, but it is
only added when the eprobe is first enabled and only removed when the
last file goes away. A second instance then records nothing, and the
first instance's trigger is left behind once the eprobe is disabled
there, so the eprobe can be deleted while that trigger still uses it.

Add and remove the trigger for each file. The file is never NULL here,
so warn if it is and drop the dead perf paths.

Link: https://lore.kernel.org/all/20261107101233.151434-1-devnexen@gmail.com/

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_eprobe.c | 58 ++++++++++++-------------------------
 1 file changed, 19 insertions(+), 39 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index d0afe3250d5ce..7ec4fe34675a5 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -728,37 +728,32 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 {
 	struct trace_probe *tp;
 	struct trace_eprobe *ep;
-	bool enabled;
 	int ret = 0;
 	int cnt = 0;
 
+	if (WARN_ON_ONCE(!file))
+		return -EINVAL;
+
 	tp = trace_probe_primary_from_call(call);
 	if (WARN_ON_ONCE(!tp))
 		return -ENODEV;
-	enabled = trace_probe_is_enabled(tp);
 
 	/* This also changes "enabled" state */
-	if (file) {
-		ret = trace_probe_add_file(tp, file);
-		if (ret)
-			return ret;
-	} else
-		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
-
-	if (enabled)
-		return 0;
+	ret = trace_probe_add_file(tp, file);
+	if (ret)
+		return ret;
 
+	/* The trigger lives in the instance of the file, add it for each file */
 	for_each_trace_eprobe_tp(ep, tp) {
 		ret = enable_eprobe(ep, file);
 		if (ret)
 			break;
-		enabled = true;
 		cnt++;
 	}
 
 	if (ret) {
 		/* Failed to enable one of them. Roll back all */
-		if (enabled) {
+		if (cnt) {
 			/*
 			 * It's a bug if one failed for something other than memory
 			 * not being available but another eprobe succeeded.
@@ -771,10 +766,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
 					break;
 			}
 		}
-		if (file)
-			trace_probe_remove_file(tp, file);
-		else
-			trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
+		trace_probe_remove_file(tp, file);
 	}
 
 	return ret;
@@ -786,33 +778,21 @@ static int disable_trace_eprobe(struct trace_event_call *call,
 	struct trace_probe *tp;
 	struct trace_eprobe *ep;
 
+	if (WARN_ON_ONCE(!file))
+		return -EINVAL;
+
 	tp = trace_probe_primary_from_call(call);
 	if (WARN_ON_ONCE(!tp))
 		return -ENODEV;
 
-	if (file) {
-		if (!trace_probe_get_file_link(tp, file))
-			return -ENOENT;
-		if (!trace_probe_has_single_file(tp))
-			goto out;
-		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
-	} else
-		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
-
-	if (!trace_probe_is_enabled(tp)) {
-		for_each_trace_eprobe_tp(ep, tp)
-			disable_eprobe(ep, file->tr);
-	}
+	if (!trace_probe_get_file_link(tp, file))
+		return -ENOENT;
 
- out:
-	if (file)
-		/*
-		 * Synchronization is done in below function. For perf event,
-		 * file == NULL and perf_trace_event_unreg() calls
-		 * tracepoint_synchronize_unregister() to ensure synchronize
-		 * event. We don't need to care about it.
-		 */
-		trace_probe_remove_file(tp, file);
+	for_each_trace_eprobe_tp(ep, tp)
+		disable_eprobe(ep, file->tr);
+
+	/* Synchronization is done in below function. */
+	trace_probe_remove_file(tp, file);
 
 	return 0;
 }
-- 
2.53.0

