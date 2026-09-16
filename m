Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8531E4457DF
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789546536; cv=none; b=rlCyXv6MTdf/e0M7G89mgLOPAwj7gyk7PmpJfdJfoTva9BYGtGPhINxo8/T09sR/8tL+v53ph6/zT8VE5gztbBCnwVwTgKzpwoAJLWSoAPIGONhigiZwDawEaO7LTqsW15cXJr/aDJcVm+Ktf6meLwFrWOJq0tl9XYH+Rs7L9v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789546536; c=relaxed/simple;
	bh=759WNgI7cuOVO1tjZvMxaSz7MJ7C+Qkx0BdJdaBJnr0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=L3v/UHNO2TuacPDNt2xf3IW7ot3fcIVdHXd1+SeGzIAgoiz/tD7yl23kG7v4vQurmSGTtRRdOxgzdRC/zUSZwzt878fUiTrhGDHnNh8ZyWYg23xVKpojcBDWOrsuyg9zUtRs3QmmqYguC8S13xn27mzNZjKBSD6e9i23d8dn6hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V8S2oC04; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V8S2oC04"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59F21F00899;
	Wed, 16 Sep 2026 08:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789546527;
	bh=M2s1S4isnUO6J4dMvi1AM/y5I4kbjy8RRO7x0/xbTtU=;
	h=Subject:To:Cc:From:Date;
	b=V8S2oC04eayqDKAhkFUKXZXX3aAqoSDsGTOKLVhyt8UAFNN3uRjNGlZwasiA8Ya0z
	 WuBKhL6o/5N7zdXL9Slc9/Cd5q0xFvxr+xdRFRxujWy2cJTfunPOT1d5yd34Y954+v
	 BrOUIs7LJm8k1ZYKEmS0KwQvGzQLRbLKdO8jotro=
Subject: FAILED: patch "[PATCH] tracing: Set the trace clock before registering the histogram" failed to apply to 6.1-stable tree
To: donggeunyoo.kernel@gmail.com,rostedt@goodmis.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 09:13:27 +0100
Message-ID: <2026091627-stylized-awry-e55f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 6ede78d0563a2a3ae3e46f9c07cedb5d79645429
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091627-stylized-awry-e55f@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6ede78d0563a2a3ae3e46f9c07cedb5d79645429 Mon Sep 17 00:00:00 2001
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Date: Mon, 7 Sep 2026 18:14:15 +0900
Subject: [PATCH] tracing: Set the trace clock before registering the histogram
 trigger

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

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5e00da2d5b1a..1889e310b73c 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6631,12 +6631,6 @@ static int hist_register_trigger(char *glob,
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
 
@@ -6649,6 +6643,15 @@ static int hist_register_trigger(char *glob,
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

