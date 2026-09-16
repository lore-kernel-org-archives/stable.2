Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35114E8E04
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 13:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789566502; cv=none; b=thPWiy8rygwN2NawMuLgfpqhNobb+ChPsYI4jTUS3u37jIUsSEBqD7hKl/G88IDCde2X7LsaW6ouBdzsC0YcmyrlImJz8BtwwBF5oGlKRHe2fbk17QBVew+pFlkBxe5u88Tt7r9n/RJoeCxfl27qAMieEHQ5ZZvWDqXcdr+S04k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789566502; c=relaxed/simple;
	bh=VbZ90R75fh2Y8pr5eDPP0rKObzb1Y+gK/9uuuCspbv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SlW5NYYuobsYXuo0hR/ezOKyLLXQvE4YEUHiTN2qyocXVsOa2+RnHbm7rbuEK/Le4qoividpFGYpM5VdZzhgDCLtUIEl+KmkpCGJzzb6G2SApcBnMUWvbrbEpTqDCEZwgTSdj9seaHFrt/Cq/x7TKRV8OTVwFvDuw+xwDRugwbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS2gM1K7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS2gM1K7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1AC1F0089A;
	Wed, 16 Sep 2026 13:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789566497;
	bh=FoYCaSK10d4z3ChIQt2pH7aLJZJzhF2yieNThkKxU0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JS2gM1K7+XcpzwZhKmTQ44O1LL+4QCE8tw9Yu7jjjKJrcTMgfecxWQbzAK+PDBMqn
	 wBJY/gzboukNzxlC+GjG3GKOGWQscQzggCrm1irnoJ0QsWIaktYLhEsMlM+lflER9T
	 L74nXXXPW1Oaj3O4heDFFpFAx+njCh0ktsDjKe+qWyGOtNzMJ2txcFdlvstE8DZBRA
	 LUjP1h/LeY64B2bJCrf3e2DQlhPosRM+IdB0vxvTZ+d9Y51zaGcW9wrm/C00yG36gG
	 F+Jd/506Krz5eimDfzci33lIyf2e+eTB1cAWz/uSKsaxKXhYaWnZ6nlKqfvEdByjxK
	 7auxDZoja2ecA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] tracing: Set the trace clock before registering the histogram trigger
Date: Wed, 16 Sep 2026 09:48:13 -0400
Message-ID: <20260916134813.2723709-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916134813.2723709-1-sashal@kernel.org>
References: <2026091624-amusing-exorcism-4490@gregkh>
 <20260916134813.2723709-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index aa7736dcbb545..4318ba3ff29dc 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6597,12 +6597,6 @@ static int hist_register_trigger(char *glob,
 		data->cmd_ops = cmd_ops;
 	}
 
-	if (data->cmd_ops->init) {
-		ret = data->cmd_ops->init(data);
-		if (ret < 0)
-			goto out;
-	}
-
 	if (hist_data->enable_timestamps) {
 		char *clock = hist_data->attrs->clock;
 
@@ -6615,6 +6609,15 @@ static int hist_register_trigger(char *glob,
 		tracing_set_filter_buffering(file->tr, true);
 	}
 
+	if (data->cmd_ops->init) {
+		ret = data->cmd_ops->init(data);
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
2.53.0

