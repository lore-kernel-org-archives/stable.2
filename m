Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409D54A5EDD;
	Wed, 14 Oct 2026 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791973819; cv=none; b=dxxUXCQNrq/A1Ve7f8bke9shmT3OPmXJZVMpmRlqp08D7fBagaIMxkeZ+tR/s0A44/Q5dQBkcuHDPr1gy8xq76ZNRcCWg2/mFRt/a83gmQB9mImgoSAJQdH9r1bXaWytZRs31QlejCruhdj2s0vi2M3Q0phPRdoPmjSVbsnen3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791973819; c=relaxed/simple;
	bh=iWRy+RySwK9hGoK6m2irTykTpFLJKeumaG357x5XVlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kw2rz0f0ttYxMZNmmstZbr4wtSYCJRioL05gr7OINmJINtBfFLwS0hp45H4sNIsdjVFIkecZYDzArIpkkTQNLVnK4QQZIR9iTI9mWD5qcW5zscpT9p+ILo0/b3FkbQ6rAlEo4Ly2MPghZggXMfdohSG8Qe4eqEQJRleuupxmVF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZ1AyUdi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZ1AyUdi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4811F000FF;
	Wed, 14 Oct 2026 10:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791973817;
	bh=hKEEJuYS6FrXq5BrnjlC2tV9RaL6MFYIN3GFi5M0KyE=;
	h=From:To:Cc:Subject:Date;
	b=SZ1AyUdi46NP8OrpYBa5RIN64JM7lCIsyq32OYO68rshiG9tV7eJd+hVPVs3m4MWz
	 0wBjIrgRkw0XvXKtYGMm+WnInEIAU7nOBrskN/KedBQqkiNLi7LLxczDVe4XEa18k1
	 jWHp+mGQLhvJXBm+Eclet1GCoJT/h4cwcTIAMcPif00av/sGr+vDeErT5ylJpBrWPs
	 inUjaQPMRnUQ2eTIxFmgGnbjjiWvTOV/25oPvsXHLG75l5rWTk5ZnJ+M3TXuoBgwr2
	 5gmPGguOgGQC2GYHv/VqBUyAg9nXxF2TiOoy2Ez1hOqlNXvi2yphJf1Xkcj3Xn8222
	 4Po13vTvwJVdA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Fengguang Wu <fengguang.wu@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] tracing/histograms: Verify event_call identity when updating synth_event refcount
Date: Wed, 14 Oct 2026 10:30:12 +0000
Message-ID: <20261014103012.744589-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In event_hist_trigger_parse() and hist_unreg_all(), the histogram
registration and unregistration paths look up find_synth_event() using
trace_event_name(file->event_call) and adjust se->ref if a match is
found.

Because find_synth_event() only compares the event basename, registering
or removing a histogram on a non-synthetic trace event whose basename
matches a synthetic event erroneously modifies the synthetic event's
reference count.  If a histogram is registered on the non-synthetic
event before the synthetic event is created and removed afterwards,
se->ref is decremented without a matching increment, allowing the
synthetic event to be freed while an active histogram action still holds
a pointer to it.

Verify that &se->call matches file->event_call before adjusting se->ref.

Fixes: 4b147936fa50 ("tracing: Add support for 'synthetic' events")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 kernel/trace/trace_events_hist.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 00a1d8522036..71b240b609ea 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6807,7 +6807,7 @@ static void hist_unreg_all(struct trace_event_file *file)
 
 			se_name = trace_event_name(file->event_call);
 			se = find_synth_event(se_name);
-			if (se)
+			if (se && &se->call == file->event_call)
 				se->ref--;
 
 			update_cond_flag(file);
@@ -6926,7 +6926,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
 		se_name = trace_event_name(file->event_call);
 		se = find_synth_event(se_name);
-		if (se)
+		if (se && &se->call == file->event_call)
 			se->ref--;
 		ret = 0;
 		goto out_free;
@@ -6962,7 +6962,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 
 	se_name = trace_event_name(file->event_call);
 	se = find_synth_event(se_name);
-	if (se)
+	if (se && &se->call == file->event_call)
 		se->ref++;
  out:
 	if (ret == 0 && glob[0])
-- 
2.56.0.385.gd3acb90ef8-goog

