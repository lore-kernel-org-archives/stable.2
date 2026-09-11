Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F864AEBED;
	Fri, 11 Sep 2026 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150585; cv=none; b=IhCc7irqKFhmurx4Q+kePt/ZfkcrcZqqCCf4FvPU91ZbP8XO3xU7Fl2pPSx1jg9ZLt8B7TuShaJ2+vbn1vraI4Wxd9MWOwozNvKW1HxKwfbR/hKS3SbuUlC7MkpHn1rYnnwgj/amz+J0W1xzyw6Bq6EZ4P40rF77bkT5y89JMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150585; c=relaxed/simple;
	bh=dSqrCsSrWDUPxNHTVfEw2JBtCVtC4NBP/J8WxSf77w4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=njjfmUWC/bPN+Ok/yuqOzj8pe72TohJFcmVnayxnlwORCPRs7almBFcpKj7LOHAkXAmEOxNCsjQAgrlV48K07W/JGeT/L+8ZOZvQ3YCwSPGrxVCaiMYxqJvI3x1wUbjrtfIERBsyz9rqcvy6S1hsgyWEt/rMNByYpDsVlrBVVUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DO4rtOc3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO4rtOc3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2CB1F008A5;
	Fri, 11 Sep 2026 18:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150570;
	bh=e1kVkCGH9uMPrZue3dk1oxAWADU5bWLWikEXk+pClBQ=;
	h=Date:From:To:Cc:Subject:References;
	b=DO4rtOc38OZpZpKbvQvrOiJRe1hJvFfrybNc4BU+VlPJmQL9ZNSQrel8vOEBaKxea
	 KbQRLU9xUsHekZzbJcAqxuAg2/7RJlrzVydynVWhSQsasjfGyIBve0CjhF3UqMLVRZ
	 D6u5HsM9bKAuahnzUJa6TXOkewwIAH6AoA/NNRZdjDq2DgBmrQTUnZKxzAUAV0q1vX
	 oCSDrja+RRVCmUD7HtRcjia782ac3gXNqx5I+2/P8hr5rERhA7DV7p+gnOHgxSzD45
	 5YWK9kszSOEDK6WxiQLrj5Tvp49/gJEGUciLyuCTiMhydQD1+01iwz4INi/M2Nwn+s
	 iHOSzFEJReonw==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x55oZ-0000000953z-3Knn;
	Fri, 11 Sep 2026 14:17:31 -0400
Message-ID: <20260911181731.617157375@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 11 Sep 2026 14:16:53 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: [for-linus][PATCH 17/20] tracing: Restore :mod: trailer after parsing in
 ftrace_set_clr_event()
References: <20260911181636.485043797@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>

While ftrace_set_clr_event() modifies its input buffer during parsing,
before returning to the caller the buffer is supposed to be restored
to its original state.

This works correctly for the colon between the subsystem and event
but not the colon at the beginning of :mod:.

Restore the colon, so the :mod: trailer is not stripped after
ftrace_set_clr_event().

Cc: stable@vger.kernel.org
Fixes: 4c86bc531e60 ("tracing: Add :mod: command to enabled module events")
Link: https://patch.msgid.link/20260908-tracing-cli-event-filter-v2-1-05396a3fb663@linutronix.de
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9dbc2441763b..30c0ddf90887 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1489,6 +1489,8 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 	/* Put back the colon to allow this to be called again */
 	if (buf)
 		*(buf - 1) = ':';
+	if (mod)
+		*(mod - 5) = ':';
 
 	return ret;
 }
-- 
2.53.0
