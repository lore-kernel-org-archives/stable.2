Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420A04AF149;
	Fri, 11 Sep 2026 18:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150587; cv=none; b=niTHflyrRlLV8K1iyE8tFMxv2MMqaWLKJqx9FgaFEXVdmagvC6iRobu0d98guLI5en8AUzH+lpzLv2hTj1SrFejm6z8Nz2OS6bGmJE6RKs2Flt7CV2XNQo3PC2JI8FaCDuaS770QCg2e1bEvqPkBqKXzte84Py1ZLx2/7oI+Cqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150587; c=relaxed/simple;
	bh=qpgQMbI319t5JAx84XjVZXwQAy/SR0qzr4NEOs8NxXc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=sCL3iDwodyIEaSqvkUYhUh9eq3fQaTi854OW+ss5LD8FBURrLsG7GEgSWQw1s/taEQJVGhaVdMu2Yn49zDPsRzsxTxFJCY7oulSEqJXRsNp5Sag8mfkXF2d4LGgfUxJAoZ43vi9MSwvSBe7ZViFMhxZ5X4nTJt7cQSvo9rY141s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFBzDTL9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFBzDTL9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E7C1F008A2;
	Fri, 11 Sep 2026 18:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150569;
	bh=seZXANT79DbnVtGgHNwdlFiY9xg5fwxpTHirr7vIpRU=;
	h=Date:From:To:Cc:Subject:References;
	b=XFBzDTL9LiO7GVpAIeAWd4uYn51A3oS7KrPNu64E9QnmQ1QBpAd1Ng+ApTKtD3v1s
	 3iGws0s12oZiExcA4P1gfbqAjcFI1yCR0s3SsiCBJUZVvZwpbpvbQwHSJdhTRCbcZ4
	 ifi7FXFkNaIn/FQt1WeUufe6nfthKQGr8E3LjLbPvK1025Ccq9wlh6lvF+aO7f9INS
	 Z0wBIR+WUVDUSMFP51mqzHL4QM5c4DIN8ANEOg/B8ZpXs1cwxOtgt8JMJoWDc65EGO
	 8aS6hpC3Db+uE3PQObfoJbg447J7O6RptOVpb+gKKbboagXVi6FTB7Sgw9xMkvXJTm
	 hO8Aol2wTEDvA==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x55oZ-0000000953Q-2W2w;
	Fri, 11 Sep 2026 14:17:31 -0400
Message-ID: <20260911181731.424682594@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 11 Sep 2026 14:16:52 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [for-linus][PATCH 16/20] tracing: Fix memory corruption from a "STACKTRACE" histogram key
References: <20260911181636.485043797@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

"cpu", "CPU", "stacktrace" and "STACKTRACE" are generic fields, defined
with an offset and a size of zero so that the filter code can match them
by name. parse_field() maps them onto their common_* equivalents for
backward compatibility, but unlike the common_* names it hands the
placeholder back to the caller instead of NULL.

create_hist_field() takes a non-NULL field as a promise that the record
carries a stacktrace and picks HIST_FIELD_FN_STACK, so the __data_loc
word is read from offset 0, that is from common_type, and its low 16
bits are followed as an offset into the record. What is found there
becomes the length of an unbounded memcpy. Pick an event whose id is
small enough that the offset stays inside its own record and the length
is a kernel text address:

  # cd /sys/kernel/tracing
  # echo 'hist:keys=STACKTRACE' > events/ftrace/print/trigger
  # echo hello > trace_marker

  Oops: general protection fault, probably for non-canonical address
  RIP: 0010:rb_next+0x23/0x60
   </IRQ>
  RIP: 0010:memcpy+0xc/0x30
   event_hist_trigger+0x2e7/0x12c0
  Kernel panic - not syncing: Fatal exception in interrupt

Leave the field NULL, which is what the comment above the branch says
the code does and what common_stacktrace already does. FILTER_CPU and
FILTER_COMM are left alone, their create_hist_field() branches never
look at the field.

Cc: stable@vger.kernel.org
Fixes: 4b512860bdbd ("tracing: Rename stacktrace field to common_stacktrace")
Link: https://patch.msgid.link/20260907155045.692664-3-donggeunyoo.kernel@gmail.com
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9bc829c1e876..8af97fd4ee2d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2404,6 +2404,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 				*flags |= HIST_FIELD_FL_CPU;
 			} else if (field && field->filter_type == FILTER_STACKTRACE) {
 				*flags |= HIST_FIELD_FL_STACKTRACE;
+				field = NULL;
 			} else if (field && field->filter_type == FILTER_COMM) {
 				*flags |= HIST_FIELD_FL_COMM | HIST_FIELD_FL_STRING;
 			} else {
-- 
2.53.0
