Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407564BFE85;
	Thu, 15 Oct 2026 13:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792071244; cv=none; b=hgAHGrhvfsn6xyUl5ZHwYhvMhsFm+c0KJ6zYuBmcaTQpuN1S7l56kcAyij25pXg8JAoJCjQA83M4uHIAqOFGendqbuz4EXU3cevGtd1rdWFrJAIvN2MctUUQEO5f6XUIa0tigldeK5pNYOWKYoF79XndM9xE1frx7FuoagRUXac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792071244; c=relaxed/simple;
	bh=RaRPyiBTVb7ygczOjtK6ROtK1IXRmSX4FclBiA9v0Po=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nz67Vf2Z/sosKumNNdY4cjDRbtQbhKPbC0url/LGo4MM4S7GR9rxkGXlIP/86H9FOMHeDudxTUFk5e0CrV+aKAQ1mEkDOFZGe4I3fWC6+KIyy1ZqHSQomzx5fgLJV46qTFyEwrXf4HUxM0w05FqzT8Tk36UsD/6y5sBkZ6Z/qI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKAjJ5Y9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKAjJ5Y9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F07581F000C8;
	Thu, 15 Oct 2026 13:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792071243;
	bh=l9EFewnGPLccbjXQyYm7qD3A2XhPE7KwpzC6WMoPnWM=;
	h=Date:From:To:Cc:Subject:References;
	b=gKAjJ5Y9sEun0YHCEAqA4A4FQk/qb2KEwkATRWXI29n4cyDYDCZKMW5jMr6pMpO63
	 w0NOAABVePXsquwTT9zBR48hVixIVJfbNJA/MTBjSXRh146ZJFNkt9SDd3Q5Kn5/bj
	 67Z6Q6t+2lZjyrhPwHev1nzUGJOt0jOfQiyPgT4eTJyt/zLUY9H7wXWkxKRWVXwDI7
	 4zuO/7I13JWqY7+Ab0vjAs8dv4QSQ0FvgTTf3wiBwZtvTyCK+lMz9HvULuH4GCE+B7
	 lBbglOK/dHqHQwlIrBBd0J9O0nmRh1CZIZYP0yNAaVnDl5wmxJnh0s9fgapTVUAoA/
	 KnAUm4H0FO88Q==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xHLas-00000000MZx-19Om;
	Thu, 15 Oct 2026 09:34:02 -0400
Message-ID: <20261015133402.081360715@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 15 Oct 2026 09:33:11 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [for-linus][PATCH 01/16] tracing: Fix NULL dereference when copying keys for a field variable
References: <20261015133310.731003448@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

In event_hist_trigger_parse() where it needs to create actions like
"onmatch", it calls:

  event_hist_trigger_parse() {
    create_actions() {
      action_create() {
        trace_action_create() {
          trace_action_create_field_var() {
            create_field_var_hist()

Where create_field_var_hist() does a loop on the hist_data
representing the keys. The issue is, if the keys uses one of the
pseudo field types (like common_cpu), the hist_data field element
will have NULL for its field member causing a NULL pointer
dereference when accessing the key_field->field->name.

  # echo 'hist:keys=common_cpu:ts0=common_timestamp.usecs' > \
      events/sched/sched_waking/trigger
  # echo 'my_synth u64 lat; int prio' > synthetic_events
  # echo 'hist:keys=common_cpu:wakeup_lat=common_timestamp.usecs-$ts0:\
      onmatch(sched.sched_waking).my_synth($wakeup_lat,prio)' > \
      events/sched/sched_switch/trigger

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:create_field_var_hist+0x771/0x1380
  Call Trace:
   trace_action_create_field_var+0x360/0x600
   trace_action_create+0x393/0xe80
   event_hist_trigger_parse+0x3e47/0x69e0
   trigger_process_regex+0x1a6/0x250
   event_trigger_write+0xce/0x160

Instead of accessing it directly, use the proper handler
expr_field_str() to get the name.

The three previous patches are prerequisites: without them a .buckets
key and a common_stacktrace key each render into a command that cannot
be parsed back.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260914053443.981201-5-donggeunyoo.kernel@gmail.com
Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8af97fd4ee2d..b3df8862855f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3090,7 +3090,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		key_field = hist_data->fields[i];
 		if (!first)
 			seq_buf_putc(&s, ',');
-		seq_buf_puts(&s, key_field->field->name);
+		expr_field_str(key_field, &s);
 		first = false;
 	}
 
-- 
2.53.0
