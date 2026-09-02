Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C44F3750BC
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352124; cv=none; b=WoBVp43B1fjbB3VeaGTNB7rtbUEcJtRDizV3A28hU3bFPcLpNCGdeiqEP4FL2Jl+3heH+LRsqb+p8khJ0I3CfcACGw0106l/gevF3uItw9GKy3mYL1MqOapukVVk4ssjZxSl+dB2dZcZzAA9katKlCEipU/1A96RLpqqcGJ9rN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352124; c=relaxed/simple;
	bh=hmh8EjF3HLSYa/gyqj5gS2rSugOb8h1KFM42D3FVfyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MaxbCzAk+8kfb9irYQhL/Be27twPGlQEH0Urc+urdAXL48iyNwiWf3BFCw8oP54nJRWivl57psj/F2x6wOreNqQexbWDSDDcMDxcp0wS4l8uZRRouBO1pKvIyrh/hf+0XX6j9q077VysfcZXcCT2S0iM/KirWdWqEXdftqp0v1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPwMJsjt; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPwMJsjt"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c25b661d37dso144580266b.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 05:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788352120; x=1788956920; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6NzEuOlmG1N6RZ+zTmMfDE2f0Li6dNShSm/jiydeaI8=;
        b=pPwMJsjtchOiCSnZc5BSTQ1TD8eQJI7YEbNsutyuKV0aGRWHQaPRHsoXygmCcD8oZ3
         5QWYzURRSuGsh/bYQQi4gvhxpEHHJzFgjpMNPqti0xkAFvVza4lsXfd39R+/rmu+6B6X
         S95ShdHj0c34pE6ZB4OIBfwMAtz08AbAwri9DHm1ogAQL4tIDjogL1+R9je2t9S5DhPY
         HANJlo3q2bBflzRXKbF666+Qop8In5E2CKc1W4TiMHi54JjlQ2dlouxPT0dwg4XvOsHN
         5r6ugtQJBWGIBVy92grArIkmaAW1NLZwvYvgGnnPI4f+6jLSq6P6uhTOFTWkTiqgpyx9
         yGKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788352120; x=1788956920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6NzEuOlmG1N6RZ+zTmMfDE2f0Li6dNShSm/jiydeaI8=;
        b=JK8JxLiOk7fEmOOi+3BjkZY2pgkCBaA8nbWDxkE+XusRGKVn9YjQRGOmfiibqSZDVu
         Tld8CrisoRxpFlNge64X5lkKEqjwMuduDRWzAWDQG2DDYFdY7W4L9PICAYTf1kmqEacp
         1bhZwWadbpsZ4t6xc3nN+KHJTmcBiNeyGM3bolKC7R41YnLuvrO0rc9rmNIhhLg+iMeH
         cgt8f4aFfJul/ftQmMx12Ggc3WM8jOUypGvBrXgG9fCy+htGM5RdEwTGViO+Scf4eGe3
         +YCwkaqDwCcGPf8PDmn9m9jJOEj1fTSS6WNPd0MBGnNsPXiwWwIat7P4S6X3XS490FG7
         pCYQ==
X-Gm-Message-State: AFuF++nT+mFck68rd5IZjvwND7AYUFp95iCSgC7tfLdjTEnY0qCgCben
	rOgOLSKV7IaSh18pLTXICrC2OJhTX7k5FHbwAu2FU1Vp887jfsxGi48rNotPrl8P
X-Gm-Gg: AYBFou3vJGL7WHXIFO4IElIPikq60piCgc7IF1xX1m6QJ/CdTRZRTILaFZLAP1/Nga1
	ScW7ov3U0lDYbyJA2vHdBm86qDFmZbpaoZq+Tgi/wI9K3xbYicA1uTn6205YQacBofoQ4ARRdu7
	mYC1SGlxWX469j84NCQDaHc2lIGrzUwXxXiBnimTf/SBr1Ld5aWfkk/7Eoo5n50ztozqrfCbExN
	hvVgpY4PrR4RGOZj5uTiENq15XCE+oOYLu/58anFLYDQIliUJoqzedPhGGdjteNqmh9iEg7v2W2
	CTcr6mJFwYNpltcOuWeMIFOJ8nWxW93yWgn30FB87HqCft61s1tRuWsREBvWnIGQs/4CxGPADQT
	2azhCuXpa1KBosjbtBke/f5LBv0MCXMY61KsnUmzHwiNwvsjpGXNd9rn2yMtf47g3963gmSF1d+
	7mtuia7NYD4+cxdQHlxOTe5LOC3bCPXIRNWgVmDBoC7I1euSbToswODnH5IRP4RZjkmGmqXdo=
X-Received: by 2002:a17:907:7247:b0:c25:c54d:d1a2 with SMTP id a640c23a62f3a-c25d54fe6e3mr285533466b.18.1788352120261;
        Wed, 02 Sep 2026 05:28:40 -0700 (PDT)
Received: from grower.astralinux.ru ([82.22.172.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25d03fbb75sm123305866b.49.2026.09.02.05.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:28:39 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Martyniuk <alexevgmart@gmail.com>,
	lvc-project@linuxtesting.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	Karol Herbst <karolherbst@gmail.com>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 5.10] tracing/mmiotrace: Add NULL check for mmio_trace_array in logging functions
Date: Wed,  2 Sep 2026 15:28:29 +0300
Message-ID: <20260902122830.447370-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
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
index e8ae2d92a678..da63add45faa 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -298,11 +298,15 @@ static void __trace_mmiotrace_rw(struct trace_array *tr,
 				struct mmiotrace_rw *rw)
 {
 	struct trace_event_call *call = &event_mmiotrace_rw;
-	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	struct trace_buffer *buffer;
 	struct ring_buffer_event *event;
 	struct trace_mmiotrace_rw *entry;
 	int pc = preempt_count();
 
+	if (!tr)
+		return;
+
+	buffer = tr->array_buffer.buffer;
 	event = trace_buffer_lock_reserve(buffer, TRACE_MMIO_RW,
 					  sizeof(*entry), 0, pc);
 	if (!event) {
@@ -328,11 +332,15 @@ static void __trace_mmiotrace_map(struct trace_array *tr,
 				struct mmiotrace_map *map)
 {
 	struct trace_event_call *call = &event_mmiotrace_map;
-	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	struct trace_buffer *buffer;
 	struct ring_buffer_event *event;
 	struct trace_mmiotrace_map *entry;
 	int pc = preempt_count();
 
+	if (!tr)
+		return;
+
+	buffer = tr->array_buffer.buffer;
 	event = trace_buffer_lock_reserve(buffer, TRACE_MMIO_MAP,
 					  sizeof(*entry), 0, pc);
 	if (!event) {
-- 
2.43.0

