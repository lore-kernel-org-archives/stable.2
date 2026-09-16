Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972784A2A58
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789598813; cv=none; b=uMTalWM1MbsEGBhTw9GV/9KKIrQv61/Tca116ZQwUVljIirm0iJjPuxPXkMpRqu9fpNXODOWzZVDAOdZIWHz/AJ+7XeCsnx7dJc/t86ox3ijUR5d76g94EQVxWtlMhbIawlKi6SK+d6WRB1fa47csL5CgVJGQCUMfZLAVkbY3yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789598813; c=relaxed/simple;
	bh=q/ONyTjg7HZXYhrEWB+lnbkajoNVd4eYlZJcoRgSMac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8mKuUcXVrzr+AH63idKop8IhBjbqqMcQUSg0mk0Xj1l04tQpD7rwFefZM0081XDHjh1Ys/lbi5yKzy26cV89HHIj6axfdLzOw5aXZD9KGDy8mgmimK4jhSwTaHeW0Hmci9D0WMy5s8l0O9AEzV8MRT6RNUdTXIf6DlwWgMnm+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsNpuDm9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsNpuDm9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A891F00893;
	Wed, 16 Sep 2026 22:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789598800;
	bh=dJX+VM3osdkdzkR4l62B88q+VDg+sRgZuFRzYdxWgLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dsNpuDm9biw22jdeoIlqihWcpBixWCqWvF/iuiLtoi3pxrt55iBZ7HxxMELbgm1XB
	 6u0hB26YF1zjv9DbeRoCbUhxRSbqgBFcKHnirI76h6Ab7Ng4osIOQo+UfjHGL6BJ1n
	 aU3D2TjDgVNeyCPADXRP+/ea+9JvULFLEoCcnIolg6iwhQA1dkMVOCsYvIZoiSJOBZ
	 d24ErTvk7ev0FqrSlAqMsvmB0hYu/kIaTncc+fJpJfHihBNsNARziTFX53FJTPppva
	 OgzG074Vu0WloElGmjnkDwo5BnhkytPYFglC/lGNv3quFrlV/lBinzwt5Vm6L+jJhj
	 mv1Y9Z15FIUag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Sashiko AI <sashiko-bot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] tracing: Undo the registration when enabling the histogram trigger fails
Date: Wed, 16 Sep 2026 18:46:38 -0400
Message-ID: <20260916224638.3198228-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091607-wriggly-finite-bb4f@gregkh>
References: <2026091607-wriggly-finite-bb4f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

[ Upstream commit 92383cef66791a0c63a2f27755cadbdb2fbf270b ]

Commit 6f86bdeab633 ("tracing: Fix bad hist from corrupting named_triggers
list") described how a trigger that is registered but not on file->triggers
ends up freed while still on the global named_triggers list, and moved the
registration down so that hist_trigger_enable() follows it immediately. One
path still gets there. hist_trigger_enable() adds the trigger and takes it
straight back out when the event cannot be enabled:

	list_add_tail_rcu(&data->list, &file->triggers);

	update_cond_flag(file);

	if (trace_event_trigger_enable_disable(file, 1) < 0) {
		list_del_rcu(&data->list);
		update_cond_flag(file);
		ret--;
	}

so the list walk in hist_unregister_trigger() matches nothing, test stays
NULL, and the ->free() that would call del_named_trigger() is skipped.
out_unreg falls through to out_free, which frees the trigger anyway:

 BUG: KASAN: slab-use-after-free in find_named_trigger+0xac/0xc0
 Read of size 8 at addr ffff8880091d3160 by task init/1
  find_named_trigger+0xac/0xc0
  hist_register_trigger+0xc1/0xa00
  event_hist_trigger_parse+0x3146/0x6af0
  event_trigger_write+0xce/0x160
 Freed by task 69:
  kfree+0x154/0x420
  trigger_kthread_fn+0xfd/0x160

Leave the trigger where hist_unregister_trigger() can find it and let that
undo the registration, which is the only code that knows all of what
cmd_ops->init() took: the named list entry, the hist_pad reference, the
reference on the trigger a named histogram is shared with, and the copied
cmd_ops. It also pairs the failed trace_event_trigger_enable_disable(),
whose sm_ref and buffered event reference are otherwise left behind.

Since ->free() releases trigger_data and, for a trigger that does not share
its histogram, hist_data with it, out_unreg can no longer fall through to
out_free. For a trigger that does share, hist_register_trigger() has
already destroyed the caller's hist_data, so the fall-through was reading
freed memory there as well.

Move the enable_timestamps check in hist_unregister_trigger() above the
->free() call for the same reason: hist_data does not outlive it once the
trigger being removed is the one that owns it.

Cc: stable@vger.kernel.org
Fixes: 067fe038e70f ("tracing: Add variable reference handling to hist triggers")
Reported-by: Sashiko AI <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-trace-kernel/20260907092944.3950E1F00A3D@smtp.kernel.org/
Link: https://patch.msgid.link/20260907124420.607097-3-donggeunyoo.kernel@gmail.com
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
[ adapted cleanup to 5.15’s older trigger callbacks and registration order. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5ecc78916431d..2fa1bc786f2a8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5676,11 +5676,12 @@ static int hist_trigger_enable(struct event_trigger_data *data,
 
 	update_cond_flag(file);
 
-	if (trace_event_trigger_enable_disable(file, 1) < 0) {
-		list_del_rcu(&data->list);
-		update_cond_flag(file);
+	/*
+	 * On failure the caller undoes the registration, and
+	 * hist_unregister_trigger() can only find the trigger here.
+	 */
+	if (trace_event_trigger_enable_disable(file, 1) < 0)
 		ret--;
-	}
 
 	return ret;
 }
@@ -5759,13 +5760,13 @@ static void hist_unregister_trigger(char *glob, struct event_trigger_ops *ops,
 		}
 	}
 
-	if (unregistered && test->ops->free)
-		test->ops->free(test->ops, test);
-
 	if (hist_data->enable_timestamps) {
 		if (!hist_data->remove || unregistered)
 			tracing_set_filter_buffering(file->tr, false);
 	}
+
+	if (unregistered && test->ops->free)
+		test->ops->free(test->ops, test);
 }
 
 static bool hist_file_check_refs(struct trace_event_file *file)
@@ -5964,8 +5965,11 @@ static int event_hist_trigger_func(struct event_command *cmd_ops,
 		goto out_unreg;
 enable:
 	ret = hist_trigger_enable(trigger_data, file);
-	if (ret)
-		goto out_unreg;
+	if (ret) {
+		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
+		/* The unregister frees trigger_data, skip out_free */
+		goto out;
+	}
 
 	se_name = trace_event_name(file->event_call);
 	se = find_synth_event(se_name);
-- 
2.53.0

