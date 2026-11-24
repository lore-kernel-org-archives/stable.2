Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534986;
	b=qq+hz/4OqGxTtIQcC/ttnDsbHb/hYo8BiUkvV4dNaJAmVMJ41E4INfptWnAsA3GXVxHI
	 MV5qRp8PPszjCOdHzyryRvGzYbi4LjsCEM7uqVMPri/Uc1/FTQw6iAWQ5tOE6tzuWai18
	 k5ZzNy8MiPP20HQFi47lIyJvQ4gCzxlgeSwvk/OzhONVuv6g9c5WJfQ0TXmNBXS2Hgxz3
	 99szCDXVrCABqxoxqyb9+q1Tuxg7oliR9ZqM9fYem9UYZhfmifJ/HpmKmPEM06gGcLt0u
	 xalWBBDhHLEtlCc2ZghaFq3w7ptTn9HomkDr9NI9x/7p6mmCS4bCEWhtf4H5E4oDmqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534986;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=AU1Qu7gdA/sqwFBXgQo8pGhRwe8E/cG9kUQFAmNhMrU=;
	b=kiAYHYUBv1E9lcu13GEBOO3ltYeHIV5+JHkw1IzB4sF1MDACJJt1lVn4BXCX5d7qtwnt
	 0zOrRtbK//iCzb/trWJCWmcAWFmPubDF+ZikFaPazk/uxZfFdO3C51o0wnFhunKp8sKIg
	 IwOhP7i13tu6oKQU35CX4hHm40102HQbDvzY+ZhcRhZpcSPHVSkBmspgU/gxqzT0Ga1eG
	 MUCD6wCOnODu0pfM0duWnQpdnP4uKyYWs7khG1t4LymHpSDyzaVIVum8k+4mTD5iLQAHE
	 /f8MeAqCjdUq+0TiKjsOisrlqZ/emIuRp1/7HDTrl/lslkDi/arqktCrOPvJ8Jb7soA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7BX5mRK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E819606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L7BX5mRK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09A2F1F000C4;
	Tue, 24 Nov 2026 15:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534985;
	bh=AU1Qu7gdA/sqwFBXgQo8pGhRwe8E/cG9kUQFAmNhMrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L7BX5mRKyJYC5zE7NSQLHt64FvPYoTRBNby+rwltstjkvYb/mqQPrOLW3mdvOcNe0
	 MRb7AtISR2WOhAoH2ozL2en0MlTEX5uqh4iL3ZjQ4PW+B8nG/Kkb0+tGa2P/QhtYAS
	 3FNE7GUWg901U8JtKI7hbNYA7/m3H2xUMjliJPadVBk7/gOxbTQj6z6n2wLCDFDpGe
	 8vOqnD+cUw+aicFOX7a4UFaXrAIagMS/5eck0xvn4S8XaBMw10QLT0RgvnFihaSCOD
	 g/9TUzpUk8JhbiiTdDk57O6uUP4gjFKr6JPRSla59Kd6/CXf8aRHC32BRnA51xVZhH
	 jkDwZWu7Z/gMQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] tracing/eprobe: Install the trigger for every instance that enables the eprobe
Date: Tue, 24 Nov 2026 10:43:02 -0500
Message-ID: <20261124154254.4181285-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124154254.4181285-1-sashal@kernel.org>
References: <2026112427-galvanize-pointed-f15e@gregkh>
 <20261124154254.4181285-1-sashal@kernel.org>
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
 kernel/trace/trace_eprobe.c | 56 ++++++++++++-------------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 161afacb5c7ca..4a8c4c08de788 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -746,37 +746,32 @@ static int enable_trace_eprobe(struct trace_event_call *call,
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
@@ -789,10 +784,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
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
@@ -804,33 +796,21 @@ static int disable_trace_eprobe(struct trace_event_call *call,
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
+	if (!trace_probe_get_file_link(tp, file))
+		return -ENOENT;
 
-	if (!trace_probe_is_enabled(tp)) {
-		for_each_trace_eprobe_tp(ep, tp)
-			disable_eprobe(ep, file->tr);
-	}
+	for_each_trace_eprobe_tp(ep, tp)
+		disable_eprobe(ep, file->tr);
 
- out:
-	if (file)
-		/*
-		 * Synchronization is done in below function. For perf event,
-		 * file == NULL and perf_trace_event_unreg() calls
-		 * tracepoint_synchronize_unregister() to ensure synchronize
-		 * event. We don't need to care about it.
-		 */
-		trace_probe_remove_file(tp, file);
+	/* Synchronization is done in below function. */
+	trace_probe_remove_file(tp, file);
 
 	return 0;
 }
-- 
2.53.0

