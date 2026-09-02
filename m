Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC0B484221
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 12:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351996; cv=none; b=Hym0YjXKq1H5A7qMiQZKhobtsbWq2Lt3h7UwCo/orCiuGheSAavAhHbUfJDj7Pin81yQBhG5/74ioH9R/OdHjz5TuEhaACX69tbkcwtEmFpm+384RXVgwPCsZujF15NoTS9LFEcZ46qK7djubxz3/2IPti93Ciu9/62f+I7q3IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351996; c=relaxed/simple;
	bh=O0li168uWk7Sy1LrYk0EVi1WX86awysTPLKEJqeGegw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQrqJ7H4EJI738BgWYM5H2aGHC968bovIU8n53mCL9VAO9Q6qH1wsifKpbRhjGwvmxFP4j2bdV1VVv6RHMsFhZH8Sg+YDF7yEqeCGJO0UTjQlWgzE191CVUmqjKykKlC/MZTGwBCbL0GDfXC8rLvKxKthLWJyDDFOWRkKbTZlZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssJ2RR5G; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssJ2RR5G"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a38098734bso1906999a12.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 05:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788351993; x=1788956793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Za1ZVpoqbeGhlWHdKUB3tZE62Qu9g1p/b329aCWVgzg=;
        b=ssJ2RR5Gr9WJr7XvDAXYRpQOPhx2Gx+RsQliKOgooeiEUQdQwMVVx32CERLh96UsTU
         11EZlr02z0tuP6Kz+M9ja3Q0eFP24qfYGmzwMYUR4lgQxJ8ZB6c7QNFxNFFh6YQwTJmA
         MG34NXzJidfZgnZOKCos0XTZa3ZAm28mgaBBWSVCTKdzU7irE3nAhWpZCKLBlB41mIh/
         uJhOCPIpOG+Cc4L8PKe3dBblcDmeweTU9zZr4WOKIpKy1GO6NYlTne0uO5O4txqg7Tl7
         UGn0s863GpoHdO0hub5keB01LbzUE3gzVXiHS2DgE3k2HGEWSFHstRt28q0vdJfkA3Kx
         MjWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788351993; x=1788956793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Za1ZVpoqbeGhlWHdKUB3tZE62Qu9g1p/b329aCWVgzg=;
        b=fYDDvKRf4vHJdgm46V7/StErNpCpgbvC/AnL604/iuKSPxId9AbI9Y9IQ0Qop4ESxH
         votjNr+wAdRUcys6kkFNk2DNKWQREAb9QMQvQ+ymPEdEM7rzqRh3HaucDUc153IaqVd6
         PBgrljXfZqK86BwwqVn6wXXDq/Ew2uyA/eCUpWNDg9VmMn25vt3A/eZNP6OoE/crCmvv
         bkkUodpGTl1KCPnrrJzps2BhQRQ78MKT3ZoD/OPzEy1vtz4BKFQ8ohU5GEhQ/UFdEC1L
         bsfx+6c8hLf34EaDG6FogwLiJWBkKD73JbmTMCxMRyLjHJtEb7FUI9dXaZb64KLkG9tM
         7DuA==
X-Gm-Message-State: AFuF++l+bBdQLy/7nVO3tKNO1BRpLajz41vmkFoXBbQOKfvucEPbXFVC
	Vh/F/5zNBtZhqkMVQnIFStgJcW9mj0MxH6nskW1aOkgjnDZNcjzmSOCNSlKa3P4V
X-Gm-Gg: AYBFou3kFmEGRQoKhUjD/xTl6yMdCKPiUfyyrHz6P7tBtx013z/4Ehfbx7wrwX/6smW
	AoQvRbaHYms72+yVAnJWt+aYZcreORQBGoQDzmShOPjq8l17R5kwM9Y685i+73lIOFSjQNEj3UU
	jTkJCUTobqtfJT0yfp9RamaMFy5s9Ytb8DwhXRQZpag8VGGRJcCnRAiYHEkoq192vtsWSMKeUPv
	tV8Ltyc5JTLPwEeHc2j7mIFGfNt5djXvipcdYD8EvYeYySR+4aILc3GNB4ogECxdZVepc9I0mlc
	FK/QnKUZslLsakZmLU2NifzlZ3GzqWstyeGWJgkPMHLOO65fadySXouitZ2dTGewqxFIXK/m2Ou
	MH5tWoToYiHVOoNNxCCSuaka9p5Z13JUTbccOiF0I93RlHa6CxE84dzzuREqhA8BOwgrD5pC/2Y
	xihEcBoogeuc4OZeu0nAhbxTLslGAe4CbDi9H74nEiHwE7cWK/Lm+rqQI/zwTJViWfgPwBrSo=
X-Received: by 2002:a05:6402:3216:b0:6a4:ae1:333a with SMTP id 4fb4d7f45d1cf-6a682799fb3mr3468677a12.12.1788351992977;
        Wed, 02 Sep 2026 05:26:32 -0700 (PDT)
Received: from grower.astralinux.ru ([82.22.172.205])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a68a6a636fsm566521a12.8.2026.09.02.05.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 05:26:32 -0700 (PDT)
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
Subject: [PATCH 5.15/6.1/6.6] tracing/mmiotrace: Add NULL check for mmio_trace_array in logging functions
Date: Wed,  2 Sep 2026 15:26:12 +0300
Message-ID: <20260902122613.442176-1-alexevgmart@gmail.com>
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
index c523ce5aa495..f03e9f3b8212 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -296,11 +296,15 @@ static void __trace_mmiotrace_rw(struct trace_array *tr,
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
@@ -327,11 +331,15 @@ static void __trace_mmiotrace_map(struct trace_array *tr,
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

