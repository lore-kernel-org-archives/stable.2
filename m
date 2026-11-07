Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046357;
	b=LAFtNk6EbaaGWoQxPDRL0D0n6elzeH8bD5kjIwhdCdtcRReJTw0XO2G1IXcGoi742x3l
	 rYFj8yPZqCFs7pPMFXKLdGroCQdiwsRYEsyJx1a4fZlyPwOJHAuaRs1OJnWc4E9J9P29f
	 qqDcsQhddM8nKEr//SKKxKTvG8W/IS8izvokJoZSSsXlJUD6LSr4a9looVWR7zJyo8G3w
	 /+TVcgT34LiJmavhBM0qiE1NAPU1n8zMcLqGbbTxs7rCmucWZWzMXtDqlDbKzP71HDP93
	 khQR4iEYqYlrMXjLuPLXqPs6Qa/hy4AniPGb7UEnj+MlCm7bAo3pc/pDo0iJwxN0cpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046357;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zYHw9i1ZC99ijVtSzd1tMuXGmwLLIqBi0BtOpLZ+XZ8=;
	b=Kczcg3ycUbMawOMd7nVnbM0cKZybDHXNYoFQsjg8mkT9rZXxQgUKNd+kPcBVG0K6Ra9a
	 aUtUObbThJTgqMDKpDqg2pqtUj5ddeTT65XJu5NyNSFL3vLHQ5ILiKZ61kUX15qHA89Se
	 xFV6XQIxVVeYpSixflHq4tTg1VHc4IxdGhmC9f0bV2vtq+jxbXG5yaHgJUteqmcjgu/zz
	 bbdQUY0Vmy8nECmvypFMRc2OXbK3z87UssmRp9T04j4621yxPyUVxDRaiNb/NK7cf121Q
	 oPQ+SPS0PDjzYGyLAEN6HF1KNU5Oa5SqGzEdSIVLVQp8maWKm4Jdmc3j30aFhX6jGMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ucYlb/Gi";
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B655A606A33D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B655A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ucYlb/Gi
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so8840075e9.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 02:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794046355; x=1794651155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zYHw9i1ZC99ijVtSzd1tMuXGmwLLIqBi0BtOpLZ+XZ8=;
        b=ucYlb/GiDfxsWgg9M/Iz4Q+U/thZllsvDF7Z2ByNB3WxUi+ecuFDfrXCf9XpYZRCIO
         gbBRiBGqxjSlT+fGQJZlOnszjgl229YjhCllryN5bm19UqZhLKqY1EmyogvbzhGA6xPI
         85tT+rMqC2jPdYXMZJC/cs0PsrdyFHyQyCtVLpnDAtn1BmKGCUNrq+H9D4j4MF02M4ko
         4tgh40wFRA9D4AdMQudpkuJF8e8QlEElefGu+Dg+Ov/Ar6df0JBcMvotWUN21ZxfJSAz
         dYsCsOewknBbupnSrxrUD/nQAwgDDor9t29imyxnLqvil1kfUBNxFQVRDwIyHaRw+oXC
         uoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794046355; x=1794651155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zYHw9i1ZC99ijVtSzd1tMuXGmwLLIqBi0BtOpLZ+XZ8=;
        b=Icq6HrResYMOWAKVnRBjob5OA2DvaYLFVkNHSvPhcF+APt85xaweMARsZgLMhjYtbV
         LmBhUKJfKnuaC8kEJDWrRyFdwFomW4M9scIfSO73wsTmMJXjSrRvHB40Yp2bQgdu5trw
         6I/C/9v21baaqJkPrvpxxaRo6bx78zcUTn9Kd+bDmoaQEVswnNXCWGPU5gg7RtQ5jd26
         Yvz3vT2GOmLHXP2SzQBTLQCKeSztxGJkWLqCM6z8Ge0ErxwUP6qaZEeumyWtAvtAwQTE
         KwO/o3dx7cc0jNDU29w9i2nk78lXBpvKcNW7tje39Xdossd1K/KFKEnJFlG8LF0dOZp6
         quSA==
X-Forwarded-Encrypted: i=1; AKwUvBxXJYW5JgHshdJbVEXmUGowd39dHUvaFxma2x1LItdxm2H+PLb39HHDiWy7heETCdY1tacyXqg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iBPApv34loybUGL1JDIacftn5f2E9y0zXjkwxeSoNIvZ2Hxec
	SsGENMd6Ed41XhDk8qpkfTKTrAqn/zCAIkgbD+5T8l8q2o3bwHWg55NY
X-Gm-Gg: AYBFou295BPqMntEa7tSMPFeMFMtXbukgKmfu7HE9zOJ/kUvhO3zNSOKBQhtsWNbd23
	z314CCpSJQ7MAZ4mIJzGLPxhKgyYp3BdXtUA6UEvSl7NI8Ho9E4udcKnbsua+YSbiCVTOTXNaHJ
	5OWI6KwqMvYHINTC2Hpr9tbKsdipLttm1RRb6OkdTscbBMshmQJs+Mo0w2bRHNfqARLcoELAAFK
	VJlNLA9Gh5DS2wza55lBAgZpefypBLc6mLB8VerMLsl3Ph9W7Mw83mDEMZes4hhKbM+mrdEeYpz
	8Tw1KkKyyq522XOfIAUTPj4r4km2Qx+VsGcbFlK6TNyhiesD9WngjDq+yUhzGqxDt4HU6UyrPmV
	9AHNWXfNyf5Bz7bRAuDU9EozsjjcBPxQDyMQb50Ig61P09OmpS4M595FtJZeEmXPCr9aCd1fryj
	w1WndOXPRR9v5XyRQMCjQ/ouWB6pFgyNYKWisdAucrv5RPX2PAKV8GNZJAfTubhW9oWPP3vyblG
	f59h+AJvxmm27M6q5f6L3AsA+0E+Kvsg5SSt1O8TSSnCkO47SokEBYkP9wW9T3U8f1RrQPTB6fo
	uQOlj3XeU4t4+b66YF6jMK02GOqTzZuGvAshjEHdTKqsqV7GRB1K0FbuPcXUPR4PMuLgBgVGdQ/
	UFZlOaCj/yOQycA==
X-Received: by 2002:a05:600c:4fc9:b0:4a1:fcfa:2a07 with SMTP id 5b1f17b1804b1-4b6e007beefmr92278545e9.30.1794046354653;
        Sat, 07 Nov 2026 02:12:34 -0800 (PST)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7e3283ec3sm51270025e9.12.2026.11.07.02.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 02:12:34 -0800 (PST)
From: David Carlier <devnexen@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] tracing/eprobe: Install the trigger for every instance that enables the eprobe
Date: Sat,  7 Nov 2026 10:12:32 +0000
Message-ID: <20261107101233.151434-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The eprobe trigger lives in the instance of the enabling file, but it is
only added when the eprobe is first enabled and only removed when the
last file goes away. A second instance then records nothing, and the
first instance's trigger is left behind once the eprobe is disabled
there, so the eprobe can be deleted while that trigger still uses it.

Add and remove the trigger for each file. The file is never NULL here,
so warn if it is and drop the dead perf paths.

Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
Cc: stable@vger.kernel.org

Signed-off-by: David Carlier <devnexen@gmail.com>
---
Changes in v2:
- WARN and return -EINVAL on a NULL file, drop the dead !file paths (Masami)
- v1: https://lore.kernel.org/linux-trace-kernel/20261031203915.491866-1-devnexen@gmail.com/

 kernel/trace/trace_eprobe.c | 56 ++++++++++++-------------------------
 1 file changed, 18 insertions(+), 38 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 998e6390937a..474be2f5ccd9 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -644,37 +644,32 @@ static int enable_trace_eprobe(struct trace_event_call *call,
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
@@ -687,10 +682,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
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
@@ -702,33 +694,21 @@ static int disable_trace_eprobe(struct trace_event_call *call,
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
2.55.0

