Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2824AEBD2;
	Fri, 11 Sep 2026 18:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150582; cv=none; b=lYHeIPmKuEQGCbXHsoYLTUZqa0VUR97ML9PGBXoBU91SfW4ayLf6ki3gJ/8s1xgiwtzEB7CQgUnYzZXrNLRz4EcFX+99OZ1WuH59MLYkzSjdxI+fvrKV3n2oyU5OQwRduuLE5xwFbUErbzFEqfDe1QiHOatotkYXWBgxf3AKPeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150582; c=relaxed/simple;
	bh=aiVuaL+HgNp0r2a97wYVR7TIRvdnMSxMm6JtjK7wbT4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=W8AS934NMtMXcFEEGnD7qU4I+jSMD8LWziwFlY/HjuedF80oazDlqHtuCIqaee3BY7ouZOM9eODHhuetNOhkAEuJuKH69ZO/DPwE2obgzm3Pq29I7LOFNspCdRrErMC6HHEBmXaw43PaGsFCL2EMMkk4lEm6I1WJr7+LGiQilcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imLfF9Yb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imLfF9Yb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE5191F008A6;
	Fri, 11 Sep 2026 18:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150569;
	bh=+c6xAc6jgMcoYsD9ivY2w9mrMh0m+dPswg0amAK3TPU=;
	h=Date:From:To:Cc:Subject:References;
	b=imLfF9YbZk21A077IrHBc21/Jh9rQpm9hcxoHSv32ali9wa7V13sUq5ivsRQoPpFu
	 7Y9Y5nac3KvxW8d+kKqTeN9+qgar1A6bkHC1VoPsje1h7rtjIx2B2R7keZqnY0Z9GS
	 oGbkSALe2RI6OAeaUE6Qg8R5yrvffEd9/0Ku2mdnIRCsXeNHdmC3gekqDm2Egm0QRp
	 FF3ZSh95IQUzay4IEHD73oe/8N0FIiHQJgSu3hwAlv7DYqrrb52mal66yxGBUqnoen
	 hK6u9dL9OWDhTUUIlhTQaJFLPV1zq0b01y6xM3AO5PbvBynjMrt6vqPqR0Q5klz+Kx
	 +m0YF2og0fd6w==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x55oZ-0000000952s-1hZ9;
	Fri, 11 Sep 2026 14:17:31 -0400
Message-ID: <20260911181731.228624014@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 11 Sep 2026 14:16:51 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [for-linus][PATCH 15/20] tracing: Fix memory corruption from the histogram stacktrace modifier
References: <20260911181636.485043797@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

parse_field() sets HIST_FIELD_FL_STACKTRACE from the ".stacktrace"
modifier before it looks the field name up, and nothing afterwards
checks that the name resolved to a field which holds a stacktrace.
create_hist_field() picks HIST_FIELD_FN_STACK on the strength of the
field pointer alone, which reads a __data_loc word from the record and
follows its low 16 bits as an offset into the same record.
event_hist_trigger() takes the first word there as an entry count and
copies that many longs into a 31 entry array:

	n_entries = *stack;
	memcpy(entries, ++stack, n_entries * sizeof(unsigned long));

Neither end of that copy is bounded, and the count is whatever the event
holds at the offset, so any field will do:

  # cd /sys/kernel/tracing/events/sched/sched_process_fork
  # echo 'hist:keys=parent_pid.stacktrace' > trigger
  # (true)

  BUG: kernel NULL pointer dereference, address: 0000000000000008
  RIP: 0010:rb_insert_color+0x18/0x130
   timerqueue_linked_add+0x7e/0xd0
   enqueue_hrtimer+0x39/0xb0
   __hrtimer_run_queues+0x10f/0x1f0
   </IRQ>
  RIP: 0010:memcpy+0xc/0x30
   event_hist_trigger+0x165/0x690

The timer interrupt landed on the rbtree the copy had already run over.
No debug options are needed for this; KASAN reports the same write as an
out-of-bounds read of 13835058055416381440 bytes.

Documentation/trace/histogram.rst already states the rule, "must be a
long[] type", so enforce it once the name has been resolved. Names which
resolve to no field at all, "hitcount.stacktrace" and the common_*
pseudo-fields, are refused for the same reason: they hold no stacktrace
to read.

Cc: stable@vger.kernel.org
Fixes: cc5fc8bfc961 ("tracing/histogram: Add stacktrace type")
Link: https://patch.msgid.link/20260907155045.692664-2-donggeunyoo.kernel@gmail.com
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 53100287466f..9bc829c1e876 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -2317,6 +2317,7 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 	struct ftrace_event_field *field = NULL;
 	char *field_name, *modifier, *str;
 	struct trace_array *tr = file->tr;
+	bool stack_modifier = false;
 
 	modifier = str = kstrdup(field_str, GFP_KERNEL);
 	if (!modifier)
@@ -2339,9 +2340,10 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 			*flags |= HIST_FIELD_FL_EXECNAME;
 		else if (strcmp(modifier, "syscall") == 0)
 			*flags |= HIST_FIELD_FL_SYSCALL;
-		else if (strcmp(modifier, "stacktrace") == 0)
+		else if (strcmp(modifier, "stacktrace") == 0) {
 			*flags |= HIST_FIELD_FL_STACKTRACE;
-		else if (strcmp(modifier, "log2") == 0)
+			stack_modifier = true;
+		} else if (strcmp(modifier, "log2") == 0)
 			*flags |= HIST_FIELD_FL_LOG2;
 		else if (strcmp(modifier, "usecs") == 0)
 			*flags |= HIST_FIELD_FL_TIMESTAMP_USECS;
@@ -2412,6 +2414,12 @@ parse_field(struct hist_trigger_data *hist_data, struct trace_event_file *file,
 			}
 		}
 	}
+
+	if (stack_modifier &&
+	    (!field || field->filter_type != FILTER_STACKTRACE)) {
+		hist_err(tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(field_str));
+		field = ERR_PTR(-EINVAL);
+	}
  out:
 	kfree(str);
 
-- 
2.53.0
