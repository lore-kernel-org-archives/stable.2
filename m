Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C79251E456
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 16:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788799190; cv=none; b=YVW3DUEsoQDqCv04whO73C+9Zz8+Z/UxE41Sz55eD8r+vJ6oUTBgnbkFzOxPhBds8oQUYcXuW/KenjVGlGVG51h3MtsTAMgoqaqXSR6latsirpTH8YHO4kRHiWS9J8k1ldiF67wPxRv0ZXNyO63ZjqiYztW1CTlPhTuu5ASIHL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788799190; c=relaxed/simple;
	bh=MxzCzsvL83HzKCDT6SQt/ioA0uxeZnY3WDoDY7NPz+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPwHui5uVamaHmmmMpQ6OwTzld0bRimNv8iMbs7ssESvlT5NhLzvBre1w2MPh7Z5ZGXCgPUS97IAlhKf5NrQ+iTev8cQ3Ra3b7+NE2fmHzdpAGx4/8F3TZXYsJZr9saaX902ewcbZBFMhgqgTVuc/SfCnmLRooAClhBwdBLJk+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVQBrwmj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVQBrwmj"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c252c7270faso536013466b.3
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 09:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788799185; x=1789403985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K7XIr1AmkuFOmy/+HyKoEnCMODUMBbTqPPqgFxN3piQ=;
        b=YVQBrwmj1wZHbs+Fl3a+jZ57MCfTxoAoyFOXlh0TPAwuDIXkHnv4am5sjAW1De19x+
         BArfdxwFNT22gCZ5km+8bKZ3W6exXWz32lACEtMoe+rTRpZB0bSjeZ4Fyesym1Hw1Vf6
         rjmNniKwG7O6Abkp9H5qEXLZj9z3/5L6r5Wvbip+X79+xcrfT2/fOq2BcIDqfcxUEGXR
         VuVfQc4IS+bHm47koo5cbGFJGDUeh81au66qFluwpMV0cx1hwuQJSl9ucGXOdQvhXApP
         QS/kWY0Kf4vXlK1uulL6v5jSI6TPvybEZlrK+RoDtaJM+GK8DE0HWm15F/NH20W4kTkU
         M7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788799185; x=1789403985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K7XIr1AmkuFOmy/+HyKoEnCMODUMBbTqPPqgFxN3piQ=;
        b=R8Wg/bZHakR8IVPXAO9DqBBJOl4HBU1AHpJkmo6Ba7kBXCfSqWOk3GF3MYTPqA08jw
         UIfrKRKGLQDWY9lgzAB95F/pKCntVlmNji5saGSRQnBVLbVMxMs//GHlrVTZBYr0aLZa
         0W6lozlxfVM9wn/epOvHY91ylradr/F3+h4VpGjFufusXH8A8/Utn4OJQa5KO2oKrv34
         noGDdBYJzh3tLLwBV5LT2S6WrQBFeOleocjOpGTZkRMY0HwjPlAPXmNMNMrWNqDOu/Wi
         HAMSbqi+CwITJAc8qeiKvHDhgsZgHy96lekBYhke/looqjcGzthTv1gfuU3ISA8Jp8Tz
         0/KQ==
X-Forwarded-Encrypted: i=1; AKwUvByfHO0ikHdZCss8G3cSzOEqxQ2ysskhX2cdDycOke9jPkRuL8isGUKLhJK3DBj/HdgUKT8aSVk=@vger.kernel.org
X-Gm-Message-State: AFuF++nc/AevE1bBa6J3c/+rAW5b3lEXWrG07IvlIHv7+WSBEwgbaZp5
	waDCRAPumJDGa1yTbDCveVcKn5keOZPp+i9/EJIftakXwUbHA+X8WSVG
X-Gm-Gg: AYBFou0pNLbruAmwXTK96957qEOVlTIQ+OYWys7NNonK8c31l6QtxiDszodUmJLVtp1
	s4EYAw7I4OQiI3LHxCkCIOAbHVf0oGfzdhk6Q2Fe3HBrU3smVTooNT4JABj4LHDJnUWZf8kTPBn
	z2F0zn0cC9nK8eTCNaOuuLTLnJJ2EgOPnUJYXikwCRMbizkT2fiWEXj7hYJaBgKrQ82mWvEzkN5
	0wYtqEJX6IrM1jk28nMrLyvkQxnKWGtUuAJHLJZfo6dnjCcpsvC+x9WaeZKBhZfnZXglWIb2W7E
	Ezv7D8CVrs5KFgO98WDejIAyZ8y0b0gj0Dz59UUZjco3ziiQWVQSZLQADHf7Rlcq4zVAbTgYN46
	WAe7o2BE3Anq8TLYfTBEG0Bmcq4YsPFAIXf/GomSvx+F5/iWwm0pXLbRStqe+BprmN2cgUqlxFl
	HV3HS+gqy1a3TF4TuKxCHObWriwNxsTiEP5IOzuUh06zTw900egyU2vXATTfPF4+fdj/N/g+Q=
X-Received: by 2002:a17:907:9492:b0:c25:ed6e:7edf with SMTP id a640c23a62f3a-c260cbd2e65mr1707997666b.11.1788799185034;
        Mon, 07 Sep 2026 09:39:45 -0700 (PDT)
Received: from grower.astralinux.ru ([82.22.172.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d4a8b89sm483434766b.10.2026.09.07.09.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 09:39:44 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: alexevgmart@gmail.com,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: karolherbst@gmail.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	nouveau@lists.freedesktop.org,
	ppaalanen@gmail.com,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	Ingo Molnar <mingo@elte.hu>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 5.15/6.1/6.6 2/2] tracing/mmiotrace: Add NULL check for mmio_trace_array in logging functions
Date: Mon,  7 Sep 2026 19:39:19 +0300
Message-ID: <20260907163919.183961-3-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907163919.183961-1-alexevgmart@gmail.com>
References: <20260902122613.442176-1-alexevgmart@gmail.com>
 <20260907163919.183961-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

commit 12b80cdbc54cf615b4717a4e8180063408091ea2 upstream.

mmio_trace_rw() and mmio_trace_mapping() retrieve mmio_trace_array into
tr and pass it to __trace_mmiotrace_rw() and __trace_mmiotrace_map().
If these functions are invoked while mmio_trace_array is NULL (e.g. before
initialization or after disabled), accessing tr->array_buffer.buffer will
result in a NULL pointer dereference crash.

Fix this by adding an explicit NULL check for tr at the beginning of
__trace_mmiotrace_rw() and __trace_mmiotrace_map().

Link: https://patch.msgid.link/178524300062.56416.8362487250709962380.stgit@devnote2
Fixes: f984b51e0779 ("ftrace: add mmiotrace plugin")
Assisted-by: Antigravity:gemini-3.6-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-80689
 kernel/trace/trace_mmiotrace.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index 74f378fca518..f4ebf7d9cc25 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -295,11 +295,15 @@ static void __trace_mmiotrace_rw(struct trace_array *tr,
 				struct mmiotrace_rw *rw)
 {
 	struct trace_event_call *call = &event_mmiotrace_rw;
-	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	struct trace_buffer *buffer;
 	struct ring_buffer_event *event;
 	struct trace_mmiotrace_rw *entry;
 	unsigned int trace_ctx;
 
+	if (!tr)
+		return;
+
+	buffer = tr->array_buffer.buffer;
 	trace_ctx = tracing_gen_ctx_flags(0);
 	event = trace_buffer_lock_reserve(buffer, TRACE_MMIO_RW,
 					  sizeof(*entry), trace_ctx);
@@ -324,11 +328,15 @@ static void __trace_mmiotrace_map(struct trace_array *tr,
 				struct mmiotrace_map *map)
 {
 	struct trace_event_call *call = &event_mmiotrace_map;
-	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	struct trace_buffer *buffer;
 	struct ring_buffer_event *event;
 	struct trace_mmiotrace_map *entry;
 	unsigned int trace_ctx;
 
+	if (!tr)
+		return;
+
+	buffer = tr->array_buffer.buffer;
 	trace_ctx = tracing_gen_ctx_flags(0);
 	event = trace_buffer_lock_reserve(buffer, TRACE_MMIO_MAP,
 					  sizeof(*entry), trace_ctx);
-- 
2.43.0

