Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1A4BD0FB
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788793678; cv=none; b=WqaqSIemo/M/3Er50wTNJX6vs//yIYOYQBsMGJt3ZJ5Mv3lDOop5JbVJZZonph3NQfn/nMkQMOXrU0/fCbD6ynL/IaMdFyhgxO/QVr2rmVu1yX5vTS3O2iQTQuItkOFjry+W9ZkTb4R5DUKq4uFghNorfMCTAl9RJNHN99KW/u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788793678; c=relaxed/simple;
	bh=QIW325cnNhaMcdbwLES3qKrrKOmDydBwFAQQk6R+p10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KXebgVkf15xUIhOJK7yHGtTPe/YOnl9wr1h8CzfKRKX1AKXAOjczjfLcq6libyFfsbi8UNmjco+tkmLaFW4wQIwFvkV/bAG8xFjTV2hKNFb6wfjIBXGNoV1Q26saz/f7T92wYRggDcAvWfGmF5oEgpzdFtqH+wgbRzP9o1Fcij0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPQjYbIy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPQjYbIy"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6a82c103580so726013a12.0
        for <stable@vger.kernel.org>; Mon, 07 Sep 2026 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788793672; x=1789398472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t0UFyMkj4yYcM7C9qagjMJD0/AtaB8gajsJEK2CwTCQ=;
        b=iPQjYbIyxf73OTYkMOoCUR6O/68sStd2SWgDycwrJOfwuz85JadFOBl44GBZ4sgaER
         DsPpT8R7dRjdthk3/ndAbKTvFSxvd+fIb8uYmgc2b/ghM17vWBibG7H+xaAm9+BlIZcV
         uqO/0dfl94FIE19W4eGFq3QkxJnRSUTvTb2DAmy0OGQPkaLBxqk+coyzID1lqQ7vjOLY
         0dYGoFlO0pIqT29rT038tAtbEMKSLVypSFipfJMYIIWl9iOFguhu/Ie86HUP0/aH8OpM
         54rEeXIxOXIB4zXDPor8Uuuqp1q7OpFPnl9MT1fG0IQDV+IK4wB/AxypEAZlqka4fsSB
         9Tcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788793672; x=1789398472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=t0UFyMkj4yYcM7C9qagjMJD0/AtaB8gajsJEK2CwTCQ=;
        b=UfyyyYL0SohztPrFcKzgD60jzHBdVB1SmlAZ4RUUULvwuOn1hgC2H5XmxW0IGnPHWT
         WMEFQPGKQe92TNd7eXOORy5DgQjpbS+XkmpDIo4ctzCIgID6ygYhLHWC8mLuaSGT+q+C
         mArPo30hpmuM599OfWjKfragPZJjztbygvf8wftHS1rZuixnELN6oN/uP9U7LKENlG85
         763ihYVPShA9xOJjNQI6Mx4fPmlQJoK7wrOUnRGRGpWfebjiCaUZy26eFdvsgOJbDriy
         RwCW3thcJ2ohxyg6sWxdYQnNednrQmhI92A4BLyJDH9Pf4jh6bgefnsSUI05v5ycvZXy
         shFw==
X-Forwarded-Encrypted: i=1; AKwUvBw6Edv0Gy/ZFRyv2ObOvqREjLlCv1DbTsXGNbON/odZYtmTKp2AxgrM+WH1gY1FxAzBaE1I3ic=@vger.kernel.org
X-Gm-Message-State: AFuF++nQ9k6Oy6YkHa4lMcgeQefl0wW2Kz0laOA6LBCAx/sgbyLZSOJ0
	A4n0MH2GEbWG/XV/nNhUS/Z32tzyUVPcsqhU/7lT8q5HozadpBhk/Xbf
X-Gm-Gg: AYBFou2ojxqKVgYkQ5GhYy2kCjRd478f4bc0m5L9ixUJFwcTtyN+kqr4oEe9V0Mx5g9
	9F1fBubuN9IXb51vDQEkgy1tQY9oCSSVVes21PMMiyLCqUCEqAqEUIige74ZLyIYCU/lZrygntc
	jn+0bN4sjceLptCJ6+x/dBvoHqfpZgloz8hTELB8Shgc43ARYcdM7xGfKL8kQaQ4+0LmlxBf6kr
	Re3XfBu7XRz8jlVTt1yDQfXDV+2ej7fMnLoRtcFR9SkyoLfaDjGFVIf5BALbjQLiw4zAY9ldKHT
	2LYPkmBEFkVfJKeThfUsgcmsbl2dXnaidWhBy/OqVPmwTi2NTd0DXKS+L43wFqXHI8D4E4oAdxE
	xYl/8owRKQ7Jre1w+rWOkcTevm7ft5+45bmw83X89U0sC+UGAlfUVWm6yVchnykuOiyahwYKD0d
	lSZQk/GtuHc4yDcU+3dvEeo3Fi38wG9s8H3wRUaCyjJGpWH8GDi1kYiXNL
X-Received: by 2002:a17:907:3d44:b0:c27:420b:7c90 with SMTP id a640c23a62f3a-c27420ba0camr424931166b.48.1788793671549;
        Mon, 07 Sep 2026 08:07:51 -0700 (PDT)
Received: from grower.astralinux.ru ([82.22.172.205])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d5773c5sm478376566b.40.2026.09.07.08.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:07:51 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: sashal@kernel.org,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: alexevgmart@gmail.com,
	karolherbst@gmail.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	nouveau@lists.freedesktop.org,
	ppaalanen@gmail.com,
	rostedt@goodmis.org,
	tglx@linutronix.de,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 5.10 1/2] tracing/mmiotrace: Remove reference to unused per CPU data pointer
Date: Mon,  7 Sep 2026 18:07:25 +0300
Message-ID: <20260907150726.168416-2-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907150726.168416-1-alexevgmart@gmail.com>
References: <20260903-daily-reply-0001-re-mmiotrace-null-check-5.10@kernel.org>
 <20260907150726.168416-1-alexevgmart@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Rostedt <rostedt@goodmis.org>

commit 6936298393d8d8bc3cec6b704f6a774162cf9bd3 upstream.

The mmiotracer referenced the per CPU array_buffer->data descriptor but
never actually used it. Remove the references to it.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/20250505212234.696945463@goodmis.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
Backport fix for CVE-2026-80689
 kernel/trace/trace_mmiotrace.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_mmiotrace.c b/kernel/trace/trace_mmiotrace.c
index e8ae2d92a678..55ba76bea98b 100644
--- a/kernel/trace/trace_mmiotrace.c
+++ b/kernel/trace/trace_mmiotrace.c
@@ -294,7 +294,6 @@ __init static int init_mmio_trace(void)
 device_initcall(init_mmio_trace);
 
 static void __trace_mmiotrace_rw(struct trace_array *tr,
-				struct trace_array_cpu *data,
 				struct mmiotrace_rw *rw)
 {
 	struct trace_event_call *call = &event_mmiotrace_rw;
@@ -319,12 +318,10 @@ static void __trace_mmiotrace_rw(struct trace_array *tr,
 void mmio_trace_rw(struct mmiotrace_rw *rw)
 {
 	struct trace_array *tr = mmio_trace_array;
-	struct trace_array_cpu *data = per_cpu_ptr(tr->array_buffer.data, smp_processor_id());
-	__trace_mmiotrace_rw(tr, data, rw);
+	__trace_mmiotrace_rw(tr, rw);
 }
 
 static void __trace_mmiotrace_map(struct trace_array *tr,
-				struct trace_array_cpu *data,
 				struct mmiotrace_map *map)
 {
 	struct trace_event_call *call = &event_mmiotrace_map;
@@ -349,12 +346,7 @@ static void __trace_mmiotrace_map(struct trace_array *tr,
 void mmio_trace_mapping(struct mmiotrace_map *map)
 {
 	struct trace_array *tr = mmio_trace_array;
-	struct trace_array_cpu *data;
-
-	preempt_disable();
-	data = per_cpu_ptr(tr->array_buffer.data, smp_processor_id());
-	__trace_mmiotrace_map(tr, data, map);
-	preempt_enable();
+	__trace_mmiotrace_map(tr, map);
 }
 
 int mmio_trace_printk(const char *fmt, va_list args)
-- 
2.43.0

