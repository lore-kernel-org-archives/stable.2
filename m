Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4803E49D7
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791964720; cv=none; b=B+w2aAsED1QQ4v6N9+ni/NDg7VEATOG+Jhw+qpnDb++ur6N9VqQZ+dsJhmwVC1xlO6QGaxZmAhY77tMuNNFJ5djQVICcwr4s/BQ9buNfFHlDR1epIKt6lyuOh+KixesUzqW8mW63psVj6rtxcjVrHdZkNr6yW4+kkDoYkJtwoMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791964720; c=relaxed/simple;
	bh=o0x8hRNZ+MfM9pwiGPibV9yexNxTjyu6ED3iok1NqJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VxLHK0WdXZKva6SFuOBKFNA7RwUKsLjBsLjvfEbSCRyGXyue2IMYxMHtDBKpGrSrjzJ15tsilmnLt3stlhdg0g/SZUQeJM+BSxjrO7a3ciZq2J7pGbPaxpsEXICC4Jb7oWibXjhFxDUYdPYWgV/WCXcSBje57zTQ2OXi9HFasBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gJND0YXi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gJND0YXi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20DE1F000FF;
	Wed, 14 Oct 2026 07:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791964718;
	bh=DAQcsWjb5xf/laSor6R4w5+RmUO5Fc4930qF74g5/mg=;
	h=From:To:Cc:Subject:Date;
	b=gJND0YXiCTUY6wdmfh6LBw6fEuLVrAyITCthQvr8+W8DNGz9j2ZkeFGuYriduR6MG
	 vi2BhZLy5SZLVGNRa/ogpnYBHw2F8Ec9vfin9mfiUkwMskDNcWKuGOSN4Le7LqQTDT
	 C2LxuZEVCX9bcubuPV6bSZLkBcO5GC1w1ogluh2eslSYPvAvCj6sZCcMZCfLOwN2uS
	 SwqoRWD22qjI8TxoL+dtOkCvh19+sKjmF3tThEtF5YKGMVTzuqM6Ul5Zdc3L+8iWM0
	 4/SUH/LWtWn3zrvi0VZqXiW90McNunWRAUKvubXTs2uuAUCabjb8I30BgQy0SWh0me
	 b5IojHeZ08YhA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: stable@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: [STABLE v5.10] tracing: Set the trace clock before registering the histogram trigger
Date: Wed, 14 Oct 2026 07:58:23 +0000
Message-ID: <20261014075823.29994-1-lee@kernel.org>
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
[Lee: Call data->ops->init(data->ops, data) and
      tracing_set_time_stamp_abs() as b052d70f7c9c ("tracing: Merge
      struct event_trigger_ops into struct event_command"), 476705419518
      ("tracing: Remove redundant trigger_ops params") and b94bc80df648
      ("tracing: Use a no_filter_buffering_ref to stop using the filter
      buffer") are not present]
Signed-off-by: Lee Jones <lee@kernel.org>
---
 kernel/trace/trace_events_hist.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index a3556edc5904..c439605bb12e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5510,12 +5510,6 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 		data->ops = &event_hist_trigger_named_ops;
 	}
 
-	if (data->ops->init) {
-		ret = data->ops->init(data->ops, data);
-		if (ret < 0)
-			goto out;
-	}
-
 	if (hist_data->enable_timestamps) {
 		char *clock = hist_data->attrs->clock;
 
@@ -5528,6 +5522,15 @@ static int hist_register_trigger(char *glob, struct event_trigger_ops *ops,
 		tracing_set_time_stamp_abs(file->tr, true);
 	}
 
+	if (data->ops->init) {
+		ret = data->ops->init(data->ops, data);
+		if (ret < 0) {
+			if (hist_data->enable_timestamps)
+				tracing_set_time_stamp_abs(file->tr, false);
+			goto out;
+		}
+	}
+
 	if (named_data)
 		destroy_hist_data(hist_data);
 
-- 
2.56.0.385.gd3acb90ef8-goog

