Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E3F4D90A8;
	Fri, 16 Oct 2026 13:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157567; cv=none; b=U6o8xMWUFocUFWk28eD9i37GNurM2tb7A3GrWADOplL9ANXBWkY8cGccE4swgteWc97Sq9HEvaYPZP86SVBv1h5oRvGRCjbe9mjl4a2kpIcpLbTPaHDN6thwjBdnsAgcQIDLHJwpR/j6VMcxKbKbpdfGObrkPOwp+0cW5RpOGC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157567; c=relaxed/simple;
	bh=hGqodRoGCI5YE+oT4vhLHnafio1aXirR+ORfsDJ48tU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=GPpmAzZI+hkKU+iVVLgh8iDPiVhGOL2dPjDZ3GeGk0dq6676sEQrtC3dWeN2uIHvv8FvMEs5gj+eNAi2PSQoUojPP55NKuQu7ETxslA9Qq+bFizFTC1sjijomks3R4hqQV7TXzlI4QYMOIm4qTjtWW454T//g5Fx/6ALjnZgWC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJAH01C1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJAH01C1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B181F000C5;
	Fri, 16 Oct 2026 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792157566;
	bh=W+C171zRxj+umQS5nKNAEPQiGxGvZ6J+WQhyegwQ3sE=;
	h=Date:From:To:Cc:Subject:References;
	b=WJAH01C1sGUu72JSkhRI0UsnTyssQgcGKQ+/l8PDtiaJvGNuF1NaW7Ak2MYhAfhOt
	 sWvrI2SEkOQHB6cmL6BfCAkbPuKObBP0917/gSYNhPxiosGDfHd8qpzBtMVWiIkUoQ
	 tjMpgMB524iy4RMb0ly2nCL5QV0VgsmPFyj+u0eahUjL9hntNQGTDHNCIqm7i90XSh
	 kivYv0fYfk8dlN4RFvUbDXpvkibvvKKQMZDIwKA6PpotQR313g6G8sFuwvlW5slN3S
	 CJuGuABEYTkfbrWX7MfFLUaSoPI/rm03Ya7zvrZQk1j08nH8oefkvsbdjsSrldJWno
	 JFSOlN/31ZbWg==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xHi3B-00000000WVY-10St;
	Fri, 16 Oct 2026 09:32:45 -0400
Message-ID: <20261016133245.046502357@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 16 Oct 2026 09:32:21 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Taeyang Lee <0wn@theori.io>
Subject: [for-linus][PATCH 3/3] tracing: Check operator stack capacity before pushing
References: <20261016133218.800011513@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Taeyang Lee <0wn@theori.io>

predicate_parse() uses the first operator stack entry before processing
any opening parentheses. A push then increments top before writing.
The existing check still permits that write when top already points to
the last allocated entry, which can access beyond the operator stack.

Reject the push when top reaches the last allocated entry.

Cc: stable@vger.kernel.org
Fixes: 39f7c41c908b ("tracing/filters: Enable filtering a cpumask field by another cpumask")
Link: https://patch.msgid.link/atELO9L0I9kg5CpC@Taeyangs-MacBook-Pro.local
Signed-off-by: Taeyang Lee <0wn@theori.io>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 781416ba6bdf..127880ebe83f 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -511,7 +511,7 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 
 		switch (*next) {
 		case '(':					/* #2 */
-			if (top - op_stack > nr_parens) {
+			if (top - op_stack >= nr_parens - 1) {
 				ret = -EINVAL;
 				goto out_free;
 			}
-- 
2.53.0
