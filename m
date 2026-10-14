Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B343515F1
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964687; cv=none; b=gOxoBTtgfGjGa1QUUCwRFJWDs1+ZB0wiqlQ3uoIJzJYa/mmUVRveTYKFrO+mEpNuvCzClQr5laOYrkMoSmtHNlemV6C3Fw+00sR/0IrUQv9shi9oWW63ebgiTseHmq7NaLSvvskuEkAmjO1ZIrXVtZMYSjvvNWs8ikXhWLlDWhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964687; c=relaxed/simple;
	bh=jUm0m8EgnS6itBHM8a0BbrV6BM5DlTOQUU/3rDyLGWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s2tye6ds/Loj33Pb10x+o4r5+6nrtLm0pb10DzjBphm/i0O7b3bgoMl8N/NWjptDMwLL4vIOtw8vthd7k2cRA5u9pq9JpjdSGqiUzcc2oPANSiVh0bK4ugS2niuBPBSqiauFwmwhKKXIuRyqTYJOnAtW5gV9CjAjfS9I01KDuiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8zLkUju; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8zLkUju"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8A61F000FF;
	Wed, 14 Oct 2026 07:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791964685;
	bh=xDY/H2f+wkxmACOdLDejpcV92oDBXKSy4oGVvY4trL4=;
	h=From:To:Cc:Subject:Date;
	b=Z8zLkUju0pjX5ZgNJSo1sKdXOvsSa6ea86vLU89EIKZnT6XN5rXw6YdawCJg9qIAM
	 tEMQncn2XVEHxh+uxRqMWU+mRfeaWhn8F4RGFm9asG8f4miIY9V41mBak7WKZFiDhW
	 Qli9MzUwCEJAIut4+Wi9ehZpe0SWFIQzgqv7gJOPVOPz5gGrSb4DwlFQruRyTX/J0A
	 RerWRl8ceR0ddNyTjoQBA1nchnL+OJTwGsYtkJSYtYMewbmQEOzskbqbK0DKwDpzsU
	 AUfYcjXoP5waCQ9z6sjWtNO7iQNOrjL0Z7AHFBu2I8XyPpGbZ0oMMCAWvMuoh81aKd
	 VQrrwmd37lRnw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: stable@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [STABLE v6.6-v6.1] tracing: Set the trace clock before registering the histogram trigger
Date: Wed, 14 Oct 2026 07:57:35 +0000
Message-ID: <20261014075735.27678-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.385.gd3acb90ef8-goog
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

[ Upstream commit 6ede78d0563a2a3ae3e46f9c07cedb5d79645429 ]

hist_register_trigger() puts the trigger on the global named_triggers
list in cmd_ops->init(), and only then sets the trace clock:

	if (data->cmd_ops->init) {
		ret = data->cmd_ops->init(data);
		if (ret < 0)
			goto out;
	}

	if (hist_data->enable_timestamps) {
		ret = tracing_set_clock(file->tr, hist_data->attrs->clock);
		if (ret) {
			hist_err(tr, HIST_ERR_SET_CLOCK_FAIL, errpos(clock));
			goto out;
		}

The clock string is not checked anywhere before that call, so a named
trigger using common_timestamp with an unknown clock fails after it has
already become findable. event_hist_trigger_parse() then frees it
without taking it off the list, and the next lookup by name reads the
freed object:

 ~# cd /sys/kernel/tracing/events/sched/sched_switch
 ~# echo 'hist:name=foo:keys=common_pid:ts=common_timestamp:clock=bogus' > trigger
 bash: echo: write error: Invalid argument
 ~# echo 'hist:name=foo:keys=common_pid' > trigger

  BUG: KASAN: slab-use-after-free in find_named_trigger+0xac/0xc0
  Read of size 8 at addr ffff88800915d760 by task init/1
   find_named_trigger+0xac/0xc0
   hist_register_trigger+0xc1/0x900
   event_hist_trigger_parse+0x3146/0x6af0
   event_trigger_write+0xce/0x160
  Freed by task 63:
   kfree+0x154/0x420
   trigger_kthread_fn+0xfd/0x160

Set the clock before the trigger is registered, so that nothing which
can fail runs after it is published, the way commit 6f86bdeab633
("tracing: Fix bad hist from corrupting named_triggers list") moved the
registration below the rest of the setup.

tracing_set_filter_buffering() is reference counted, so the init failure
path has to drop the reference that the clock block now takes first.

Cc: stable@vger.kernel.org
Fixes: a4072fe85ba3 ("tracing: Add a clock attribute for hist triggers")
Link: https://patch.msgid.link/20260907091415.554535-1-donggeunyoo.kernel@gmail.com
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[Lee: Call data->ops->init(data) as b052d70f7c9c ("tracing: Merge struct
      event_trigger_ops into struct event_command") is not present]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 kernel/trace/trace_events_hist.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 3ea423c62448..3e2304b641b5 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6564,12 +6564,6 @@ static int hist_register_trigger(char *glob,
 		data->ops = &event_hist_trigger_named_ops;
 	}
 
-	if (data->ops->init) {
-		ret = data->ops->init(data);
-		if (ret < 0)
-			goto out;
-	}
-
 	if (hist_data->enable_timestamps) {
 		char *clock = hist_data->attrs->clock;
 
@@ -6582,6 +6576,15 @@ static int hist_register_trigger(char *glob,
 		tracing_set_filter_buffering(file->tr, true);
 	}
 
+	if (data->ops->init) {
+		ret = data->ops->init(data);
+		if (ret < 0) {
+			if (hist_data->enable_timestamps)
+				tracing_set_filter_buffering(file->tr, false);
+			goto out;
+		}
+	}
+
 	if (named_data) {
 		remove_hist_vars(hist_data);
 		destroy_hist_data(hist_data);
-- 
2.56.0.385.gd3acb90ef8-goog

