Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DA6476CD6
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044804; cv=none; b=cRTxl172fmhctXSn5NZ4s7FDSkQbm3rYIDKJG9ijadznP3jXvrjamX+lryvgBc26fBJeW3j7jc1elyyU0UWcrvFznvhep3ec1guxk8ak7BpcYysDJVWFP0yQ4BmemngAkjXD8N8yvkdccuH0aYwR68AD2M7dskW25NZj3ws4LEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044804; c=relaxed/simple;
	bh=SCkUA0gHcS0+3fwPgmmo12G3adHoEmDSgKrp4FnUdzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qIx2Z3UD+ZclnGIz2L/29fgmY2/sQMYPWeFJ3+JaeqPBdxMC9CZQXzdx9AoDYoJXxqwf//g6JQgp8dYh8pgMxDyqK46228Y9SIcE4pLPyxogoxIjsfXJ1JrKsD6xUcMsb3FqNpc4VgePF/sy098cZB1Xjc9mhQhHW0VfFNRzIrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dxrccxfu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dxrccxfu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9E51F00893;
	Thu, 10 Sep 2026 12:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044802;
	bh=UdwO7EVmZwYlKJL8qTL+As9L6sZ6bakwpXzXKw3n7Y8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DxrccxfuHVZ0Fqzx2scE/NHIXhNDrludsYOFpAVs3/NPBnfjmIcXOJ2ow7seC1kyg
	 hgnJZGF+cDadJA2+fbGdt9Pd5wvsgus66UI6FKV3ElQ5W8HR9jxr46pfuDbvAm19xO
	 jjj+hG04g0Nm9Gu2C/LzY1ULGSRu0x8pCEJxLeF2RLXM0csDjVu792l0QXt9+zdO5j
	 ihI+MKYd99JpJjABMOx+6Djao8+HmyFDNejtrlu+b+bODC65pubd2zxP2PjEFVjMYy
	 zWB65gv80UgOoixV82xbnOvtsDBgLuNn3goqL2HrfkVzHtRfso6wBKQ405ln2nZOR6
	 a9HEds4a1VDwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] tracing: Make printk_trace global for tracing system
Date: Thu, 10 Sep 2026 08:53:18 -0400
Message-ID: <20260910125319.187851-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910125319.187851-1-sashal@kernel.org>
References: <2026090831-flashback-racing-7323@gregkh>
 <20260910125319.187851-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Rostedt <rostedt@goodmis.org>

[ Upstream commit 1c53d781d42541adc5ba76b4f843a3ff382e01fb ]

The printk_trace is used to determine which trace_array trace_printk()
writes to. By making it a global variable among the tracing subsystem it
will allow the trace_printk functions to be moved out of trace.c and still
have direct access to that variable.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://patch.msgid.link/20260208032450.144525891@kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Stable-dep-of: f2951ebd15c3 ("tracing: Take trace_array reference when opening options file")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace.c | 2 +-
 kernel/trace/trace.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 675602fd9a41a..063e88fbe3856 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -537,7 +537,7 @@ static struct trace_array global_trace = {
 	.trace_flags = TRACE_DEFAULT_FLAGS,
 };
 
-static struct trace_array *printk_trace = &global_trace;
+struct trace_array *printk_trace = &global_trace;
 
 /* List of trace_arrays interested in the top level trace_marker */
 static LIST_HEAD(marker_copies);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 62d5a5f224c4a..cea39bbcf52f0 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -479,6 +479,8 @@ extern bool trace_clock_in_ns(struct trace_array *tr);
 
 extern unsigned long trace_adjust_address(struct trace_array *tr, unsigned long addr);
 
+extern struct trace_array *printk_trace;
+
 /*
  * The global tracer (top) should be the first trace array added,
  * but we check the flag anyway.
-- 
2.53.0

