Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909284A8A35;
	Fri, 16 Oct 2026 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161100; cv=none; b=puQnDUnqL3CUP3U+1kS1w9ct8ia1zhILKPhN/q65yN5DrUku9KcegTl5Ru2K0q1JUSHRE3/FmDKmC5XztUByN3Q8ydonHr1+mbQ/11Ylt16XVf5/9zZ6/vAjMgxthYm4dE/tPxQdmuoUOlvEll/NceTXjXIKp+mgnH4CxzpqgHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161100; c=relaxed/simple;
	bh=s149q5lWcbJ2oheIIA43o1i++6KRYq8IoWAv2epDeNE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=f8XSpLvnBBbK2QCUZ9xfN2dMIwl+rt0weUwWB19F7wY+ya7QbRPviHFVraXgo2SQ8dPC7UqDbg5HdLQYkSp56UC48KWkEXtIBOx5k3wC4nfj4MPDrybLeQ3HEjTqvRQEKGbVv/Z1etQIaletXrTGuLxQ28RHF8G6JpjDq7e8Tjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zs9kuQR4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zs9kuQR4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 760191F000CE;
	Fri, 16 Oct 2026 14:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792161098;
	bh=NgGg2N1RGi/J1xseMXqE0YNV7H/R1hrK7DhCiwyg0ww=;
	h=Date:From:To:Cc:Subject:References;
	b=Zs9kuQR4EtlL0vmEmhDvF+Qk38vv3w+FlaDJSKD6R0is1ubV3Ynhrvp6x1Ai7l5QZ
	 QO67GEgiuoBvXObGZt4AMhyV050PiLQv8EqdQpXR9DtIft0k076Owgf6PCmE3uCcS8
	 1LYbbOKRwtgoet6r91S9xetlyL4scsyWH5Quk48SwZdIihgfxKb1v138+M5NGTD8H8
	 xuSIkBczDtd3CLSzWIq3MG1OQdBspbjlR9Z14ceLFOJVDFJ8/pjs6HRfOntj/DRR7C
	 NUWsjgAgxObuSHxb74KeY9jGyipbKgw9Ey4uR2tICqDwaWgjHvohRw8T1EOQRp7q35
	 uN95eZ1yfiVVA==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xHiy9-00000000Xpv-36mc;
	Fri, 16 Oct 2026 10:31:37 -0400
Message-ID: <20261016143137.562970476@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 16 Oct 2026 10:31:32 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 sashiko-bot@kernel.org,
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [for-next][PATCH 17/18] tracing: Fix 64-bit and signed histogram fields on 32-bit kernels
References: <20261016143115.392980228@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

DEFINE_HIST_FIELD_FN() reads a trace event field and widens it to the u64
the histogram uses as a key or a value:

	type *addr = (type *)(event + hist_field->field->offset);

	return (u64)(unsigned long)*addr;

unsigned long is 32 bits on a 32-bit kernel, so the intermediate cast
discards the upper half of a 64-bit field, and widens a signed field by
zero extension from 32 bits rather than sign extension from its own
width. Five of the eight instantiations are wrong there: s64, u64, s32,
s16 and s8.

The cast came in with commit 79e577cbce4c ("tracing: Support string type
key properly"), which also added hist_field_dynstring() and
hist_field_pstring(). Those convert a char * to u64 and do warn without
an unsigned long in between on 32-bit. DEFINE_HIST_FIELD_FN() converts an
integer and never a pointer, so it gains nothing from the cast and only
loses information.

Drop the intermediate cast and let the usual arithmetic conversions widen
*addr according to its own type. unsigned long is 64 bits on LP64, so the
two forms are identical there and 64-bit kernels are unaffected.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260917015532.103081-1-donggeunyoo.kernel@gmail.com
Fixes: 79e577cbce4c ("tracing: Support string type key properly")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260914054614.82A9B1F000FF@smtp.kernel.org/
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index c150e1130a5f..7d3bb7da4dd1 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -466,7 +466,7 @@ static u64 hist_field_unary_minus(struct hist_field *hist_field,
 {									\
 	type *addr = (type *)(event + hist_field->field->offset);	\
 									\
-	return (u64)(unsigned long)*addr;				\
+	return (u64)*addr;						\
 }
 
 DEFINE_HIST_FIELD_FN(s64);
-- 
2.53.0
