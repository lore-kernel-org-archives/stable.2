Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699BE49BD89;
	Mon, 12 Oct 2026 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820724; cv=none; b=qleqmtH5lVWq1bZJS6jKZHOxVRI6zrA9a03JezPZGxxcCva8g12JQWtr5Opkux5ULbE1l4eLSzN0OO08k2xKFtjmpdWJbikC6Ndr9L+SMdFVa6dn1pTsAiLcGeYmOnP7n1m1bhBKwg8mD7uSmRpFwJi7cNsr8dbGSVVX7PU5d8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820724; c=relaxed/simple;
	bh=Ghw2Too6nsTSB0gyFqwTAFmBrb8gX4+m1BBjTTGdCdI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p8ifX4pc2CYLnfGpWBy+vpkonXoaRThA7HpECJnPH6gPMuuF3mo2Gp2Odudj1nw0uA+Pws6OEBo+kutqWHajX5/Dc9VQGxZv6IHC4OMg/DRcbS6BfU2cItoYXzEVjZK7qhry0caTH47gPeRVxs7FJhYz0cWhUdRLJrPdR8Evo8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DM5Mkfyo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DM5Mkfyo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4CB71F0089B;
	Mon, 12 Oct 2026 15:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791820723;
	bh=OqVGB5nmZcsRJQmL7nMbGCi0tgj5U0FC8/4mrmlHcSU=;
	h=From:To:Cc:Subject:Date;
	b=DM5Mkfyo2jyGDn4ofWtPcyhTlNJ+wtZHsBhM/2PZWoKU4fTGZ1pVTsAlvb1DlQT+A
	 KCARoAycdrpFMyzCsKZ7InjuQPMCy4lNB4iBCb7shiYOKxHnWLTv4DvD6xYDxj7Vxc
	 I3PuN7YAmlIcGR7LnxuZpK0X5kUMg0Tivh9VAWASUAKQ9XbROFAWbetu6I32IdVGmG
	 YVxGWxlvPN+Ov49x2P5H7MfvRDfvMCeYfu/VaM21lsGaXm23Q9oS98Gjv6V8xbk+Wd
	 IJRsbP/oY9Dv+hJGOBdhH0zEtuMkP9pW2dsAdWPuUiXe4+VtpXjUd+ZW8WajlXjcfm
	 1hPp0ku4Ebg/Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] tracing/histograms: Reject non-stacktrace fields for synthetic stacktrace fields
Date: Mon, 12 Oct 2026 15:58:05 +0000
Message-ID: <20261012155805.1103972-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In check_synth_field(), when a synthetic event field is a stacktrace
(field->is_stack) and the histogram field is not a "long[" stacktrace
array, validation falls through to the generic size and signedness
comparison.

Because parse_synth_field() sets a stacktrace field's type to
"__data_loc unsigned long[]", its size is sizeof(u64) and
synth_field_signed() marks it as signed.  Consequently, any 8-byte
signed scalar histogram field passes the fallback check, and its scalar
value is subsequently dereferenced as a kernel stacktrace pointer in
get_field_size() and trace_stack().

Reject any mismatch between field->is_stack and a "long[" histogram
field type in check_synth_field().

Fixes: 00cf3d672a9d ("tracing: Allow synthetic events to pass around stacktraces")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 kernel/trace/trace_events_hist.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8af97fd4ee2d..b09f5043e154 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3946,7 +3946,10 @@ static int check_synth_field(struct synth_event *event,
 	    && field->is_dynamic)
 		return 0;
 
-	if (strstr(hist_field->type, "long[") && field->is_stack)
+	if (!!strstr(hist_field->type, "long[") != field->is_stack)
+		return -EINVAL;
+
+	if (field->is_stack)
 		return 0;
 
 	if (strcmp(field->type, hist_field->type) != 0) {
-- 
2.56.0.385.gd3acb90ef8-goog

