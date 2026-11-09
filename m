Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239882;
	b=vhVsNMQbRL5LN7Ln2GJzj0WDPLzklS/pydtkZNi6WSke1WocWfFGvIUysmyNBVih1n/G
	 jZKODdM9nyb49gdOyG2/aTmX96qEd/xtZBYzAhtmfLaNwaEbaQHWMiG8/JJJQvGG4QNRN
	 74TzM+fXdikkj2CnFm4f8eHpWjOceaUsQkkDeyAQCd3K9ONH0xHhPDeRQyxzRVWu1gcYd
	 pm7pBXzg9frxOV4yv6AByWBPcNfr26wBZ24i0yCDDjxVaX20FysA0rm8k546VdnXyVQO9
	 6ueK1AdOVzEVPWk5eqaQUG9mlJgsUMN1xKyC3WAvfTGKlUNcWUQsPHf9qW/WBOFIFGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239882;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QetFUXmQTvTi5GhM8dae69LgbFNxC2nIrR2jqhJISIs=;
	b=gxO0bPzxMOKYxwWmCbQBtFHYn7ZCf2/j72AbH719J1SuAgx06zjE+BfONYj7O4yIxZCD
	 L6SvabNV41foslykHgo4W+PcB8dQNYJd3/6HZVQANGxKo/ZVHn+h52FBctyUWSMXIibB8
	 bCFTlf5wWx1YCjNjP4nFU5m1K9u+7OHGVK2yP9X4EgAMlip8RtYT2OlpWtmXhvrPcihzj
	 UuQC/UJ12W/y5qXMOofAh8PZlCMkJULMTCy6Qr+1xYr3dAHjmkX8qkpsLeZhGMGuL2nXF
	 1SCsU9QtFBV/Esdi++LMSEfMemkFVvIIlyNQAJVIoC5juWGg5zA8lHtlo/mWn9fShew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KW6NHFkd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73361606A326;
	Mon,  9 Nov 2026 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KW6NHFkd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6BF31F00921;
	Mon,  9 Nov 2026 15:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239882;
	bh=QetFUXmQTvTi5GhM8dae69LgbFNxC2nIrR2jqhJISIs=;
	h=From:To:Cc:Subject:Date;
	b=KW6NHFkdw/EK4toqHu1A9mnBCL4CdufpHWuxD3BbYCLyGBzZH8KLacD5kGPZzNGn2
	 vqfXoe/tCUS0BCE/2hlMC3+sxCFncHwzxSKRYmClmob6Y19v9C5CpLLzI37uz8HygM
	 pjrQ03d7z2mEZGaUpTNx5gb1idd/YwliON+aaewYpo2oRcUJt1OQVbwtHUWd5zdqry
	 zNKtvERBphHQttvFYnfLNWnoygjtER+Dl0i2lb+/XCknrmNxbJLLuz/9tRpGHAZfpp
	 OFd3np5L56z3n7dxVoCkrxnHg3A9kuL0HWBTitR/YKnYRjPXJ86EiwDIC0uo+87WEL
	 uB/67u5LzdhLw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [RESEND] tracing/synthetic: Handle dynamic string read faults
Date: Mon,  9 Nov 2026 15:57:49 +0000
Message-ID: <20261109155758.3330810-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
2.56.0.506.g506a7eabc5-goog

