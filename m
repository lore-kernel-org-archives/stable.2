Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D22B3BCD16;
	Tue, 13 Oct 2026 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791882033; cv=none; b=polg0g3tQE7QwJpJQIkfAt5nop1WCNepFR7MEe2ZJnOy6Pm+Ly1jsOVWBYehAeimrEiY9EqP2biBWQmyGT8xUsaeVe8i7AVeXynM8GFymz8NFJalODKw7sXyjy4hePFOVnm6/ljwNCo03+aKzzboJnB5CXlfao1KuRIeVRsV0Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791882033; c=relaxed/simple;
	bh=GRE6ERaWL+Ad+SdPNiy47nxXkJAumlHKORcVMihtbi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rMGgUyRktOKLHMVlUiCKdYkuCx08jPZEbikKTbH4A8ATSr/Z3Fl2SIYuh16m0nXRqxUPjh/AEzJKYETvfmDcU7kVh+TMZqihWq/R0WjvTh32zovPtf2RABVFK4NmJrqJeePIaZu+gLr54lkSYXootf5VsEoX22VA/kHAP46Pveo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STblXv/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STblXv/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B9AF1F000FF;
	Tue, 13 Oct 2026 09:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791882031;
	bh=eKmb89Y/N1R79MXrWMtUJkPTpf2JG7q7c2wsunA5liM=;
	h=From:To:Cc:Subject:Date;
	b=STblXv/1mp8oATNgOhdan4MxbVF3StuxgixVxfdU4MUrqnaOW5nnbOPeGfW3N/Uee
	 ybUmMDzwURNusmAlaEGZY9ovk68JAvJ0MeyfCea+OPbiQ7E75kIb3jGP+mAdCsSVoH
	 oygx8Drk9ZFnvXCFs6y7dAk/zpTLe9g2wv/DY1DEGD7raRThmPtusOBwS1zZtNw9xZ
	 CB3ARoUuF4fjyJQV2+bSdh50wVjHj70wJRFDLD5TKQ6Prr2RVmPaQJ/iQqjiOa4AwS
	 0auo2JOFmM9nLCc/jC2tENF78Cf3zYu2GbwQoXc5UrbCM/2X8x0ZQlYnSEYB3AJSrQ
	 7lsF6yUFK4kfg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] tracing/synthetic: Handle dynamic string read faults
Date: Tue, 13 Oct 2026 08:44:38 +0000
Message-ID: <20261013084439.487647-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 0934ae9977c2 ("tracing: Fix reading strings from synthetic
events") switched synthetic event dynamic strings to use
fetch_store_strlen() and fetch_store_string(), relying on commit
2e9906f84fc7 ("tracing: Add "(fault)" name injection to kernel probes")
to reserve and store FAULT_STRING when a string address faults.

When commit 4ed8f337dee3 ("Revert "tracing: Add "(fault)" name injection
to kernel probes"") and commit 797311bce5c2 ("tracing/probes: Fix to
record 0-length data_loc in fetch_store_string*() if fails") later
reverted FAULT_STRING injection in favour of recording a 0-length
data_loc on fault, synthetic events were left unchanged.

Consequently, a faulting kernel string address causes get_field_size()
to add a negative error code (-EFAULT) to fields_size, under-reserving
the trace buffer entry, while trace_string() casts the negative return
value to an unsigned length and passes it to fetch_store_string() and
write_synth_entry(), corrupting the ring buffer.

Skip non-positive lengths in get_field_size(), record a 0-length
dynamic field in trace_string() when fetching a dynamic string fails,
and print FAULT_STRING in print_synth_event() when a dynamic string has
zero length, matching trace_probe.

Fixes: 4ed8f337dee3 ("Revert "tracing: Add "(fault)" name injection to kernel probes"")
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 kernel/trace/trace_events_synth.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index dc15658a887c..7506e2e1f64a 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -376,7 +376,9 @@ static enum print_line_t print_synth_event(struct trace_iterator *iter,
 				union trace_synth_field *data = &entry->fields[n_u64];
 
 				trace_seq_printf(s, print_fmt, se->fields[i]->name,
-						 (char *)entry + data->as_dynamic.offset,
+						 data->as_dynamic.len ?
+						 (char *)entry + data->as_dynamic.offset :
+						 FAULT_STRING,
 						 i == se->n_fields - 1 ? "" : " ");
 				n_u64++;
 			} else {
@@ -438,11 +440,20 @@ static unsigned int trace_string(struct synth_trace_event *entry,
 	if (is_dynamic) {
 		union trace_synth_field *data = &entry->fields[*n_u64];
 
-		len = fetch_store_strlen((unsigned long)str_val);
 		data->as_dynamic.offset = struct_size(entry, fields, event->n_u64) + data_size;
-		data->as_dynamic.len = len;
+
+		ret = fetch_store_strlen((unsigned long)str_val);
+		if (ret <= 0) {
+			data->as_dynamic.len = 0;
+			(*n_u64)++;
+			return 0;
+		}
+
+		data->as_dynamic.len = ret;
 
 		ret = fetch_store_string((unsigned long)str_val, &entry->fields[*n_u64], entry);
+		if (ret > 0)
+			len = ret;
 
 		(*n_u64)++;
 	} else {
@@ -522,6 +533,8 @@ static __always_inline int get_field_size(struct synth_event *event,
 			len *= sizeof(unsigned long);
 		} else {
 			len = fetch_store_strlen((unsigned long)str_val);
+			if (len <= 0)
+				continue;
 		}
 
 		fields_size += len;
-- 
2.56.0.385.gd3acb90ef8-goog

