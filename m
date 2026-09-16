Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2F04CEE48
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 15:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789573765; cv=none; b=JDRiB6p1+2549eQttYxreH99hvvrkK7abku8F/65RL8JOU2gRh4iRpWHvG64IAOzTkCIhNBic6mn5bGRO/7J8M++st5ENopFrdplE28S8Cyyo0efI1TSdGTQakBPyMUUvmOktAK8Y0bcZcRtPfs6XZ3MvbzlUVYBGmOJCx8z9pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789573765; c=relaxed/simple;
	bh=6f3Ag/shIEnAUI/aKzaVFTJjqlB8pbBg461TV4njXVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkpif8fQsaPZbLHprQD/VtBk7ku7KEGBj4X9PcEpSn8sWk8qcsDR7dJl5bt+yRzn/fy9pAmqUngx7PZUYBtfocQlYDYrARLhCP6Xv8hRP4BMW+eryDVFT3SzEowytWrR+h23WH0N9AsqvkZ1n8A3kCiED7oKkxGceLkXQU5HRCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZis5UEZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bZis5UEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679C01F0089C;
	Wed, 16 Sep 2026 15:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789573762;
	bh=hghPobAGZONG8SLtPZn/q5ZLFbjP29sUg2E/PunhLmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bZis5UEZhQwKRYzoJhWGP+Mx7gsYD5gtYkwXBcLVN2jcXlv5NKe1AKr/cqPdfAGxA
	 l7M0150WJ2iaMJX0IYp4SmSZ07AUMuT/cQIRKoka80eccsyFd+1J4ENjKUETWUE+Tb
	 ki+arhlWJLPybazfWfx0QuO5HEwIY2/pct2fU3J0g6PH12gV7zmPwb/SnYfutYEYCt
	 KYmq1Mo3ARAwOyjaWOZIG4rfMCogX0iGkBymfjGcHSEJunVGtZH05Gf5i9oEcvgEtW
	 Ctb44LyeWdjfZ/pfLQt6vVXTuM5s1HeKfQteAfxxn4NgK6QnFsm5h/yLK+59dSLXlb
	 vhKf3Y4nx9C7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/4] tracing: Set the trace clock before registering the histogram trigger
Date: Wed, 16 Sep 2026 11:49:18 -0400
Message-ID: <20260916154918.4168110-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916154918.4168110-1-sashal@kernel.org>
References: <2026091625-wrongful-sensuous-63b5@gregkh>
 <20260916154918.4168110-1-sashal@kernel.org>
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
index 7b0fc0bb62f0b..864b196a08058 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6569,12 +6569,6 @@ static int hist_register_trigger(char *glob,
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
 
@@ -6587,6 +6581,15 @@ static int hist_register_trigger(char *glob,
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

