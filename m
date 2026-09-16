Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2958641D202
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 19:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789586889; cv=none; b=oXN5Cu3B7yGuMy18FNFzILnQVzuqVdnYEsDhIgts/M60PAndVynlgz2nHXaAFjVw3ms/77fgKy71dRnJ0BUsdHwxGQdRZkYxqLoHDgnOvcLYW0ygcZ956xDQtMgW01ntuuroUgwK8xTSNSnZyK2gWDRdC53UAfL9NrMXX/yKNT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789586889; c=relaxed/simple;
	bh=j0Q0MXYSHDHq/FaG30993XpiKK9tT6x6vIQBTMmq5Wk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AWqo2nfUwSR5uqGdBzm3IK22MeoFc4FJfEgKASWnVg8smrOeqcHjhi+fLThLKVIpIK29fxYPulGdYZ8oBQXcpLX2B/0OszI3WjSzn08ttaG2Dt5XvjemFjwljpn6ll60mexbJYc74hoKxTWo1h7En+HeHa4ix9XRNByOBPkOVDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gS7vnO+b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gS7vnO+b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5801F000FF;
	Wed, 16 Sep 2026 19:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789586870;
	bh=QqJ4jX0ww00dw89zr6KwVzoGK6edUetj+hN4FmO9Ei0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gS7vnO+bO5Y4SYy/gOS2yD4Qcdc3oZ538o7PweIkeGmEOcTvqf3k4N0pT4Y9Q4RGq
	 KdrKnA7zQMj5+INcSdSvSWJD13LNlzo5qHKz+/ztCFu8jmWpNjKrQBkAkCpmvfqoyx
	 AQCvLhuDSzQ+NjguARvMCGEmyRLJoGj3ryRg9LhYR8XI3ZLbEgasSmYq92brebGJvl
	 dlDyRisONADe5L2SYgl082HYUMVqONxKSb9Xsh2JwQST2wzOX7QOx96JP83WnbiXfu
	 ne1fDoDWd9QBPlerLYKVzN1tVTkdhdU4mvvWe4heIJZDKBTKEH9KAKLsOkIZ+403Jm
	 yB2ztkf30LFnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] tracing: Set the trace clock before registering the histogram trigger
Date: Wed, 16 Sep 2026 15:27:48 -0400
Message-ID: <20260916192748.2142911-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091629-pennant-heroics-00ec@gregkh>
References: <2026091629-pennant-heroics-00ec@gregkh>
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
[ adapted newer tracing API calls to their Linux 5.10 equivalents. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 32f9ab82a8810..556a6224aca48 100644
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
2.53.0

