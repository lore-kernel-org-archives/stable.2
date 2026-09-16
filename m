Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C844E2349
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568472; cv=none; b=XfV8d11cnrjw4VJ4AylSYP3g8uYgb4DMeljHnxrqRvSBgMruDKYQ9F9uMFXFptmMoBjHKE9eVjBqnv1yxdvqjfsjE+D4dIkwhEYxaS8P8YJUHRGpv2sSxEyy6uSsap9Xg4x3w6E257AfQTYqd1b037GhP83Ay2af8iVL08VM+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568472; c=relaxed/simple;
	bh=YFF4+J1tOqUpoWnoKfNqWVuhCBrZZHGPBqkjN/+6kWo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S73NTHcefXtoBnQklmyIqL2iZQ2+tRDofffSY+LGdnfYgDr5UCqwR/7fQR2iD+HBkzbQhMDR9b1B6hOeKMSZ4cwyGUCFUX5DoI1CpdLccpcqDFcjV86SsfxCQhK+VLLO3Ui83DwziwYniKc5IcZRYQmiXn2kwXEebDNz1hJP6O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wcy2PsjS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wcy2PsjS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B9D91F000FF;
	Wed, 16 Sep 2026 14:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789568471;
	bh=sQsMx9K8hdvUapackjQpYR6kBlwQkbaiRG4Ebfwrhvk=;
	h=Subject:To:Cc:From:Date;
	b=Wcy2PsjSXv5Zd2ywJxcI5SsFWAhe93qK563/wIoPJMJLaj9jB5wrnGrHtFqdXxYWW
	 bEH+K0BRV8IaYqmPVubVne5zfcnbj1fReoJocg6tsjck4ZK9tzDVjx1oquB4bcwIjn
	 KQ15Ln9squI7UEqRm0SkdTVepWL989UZEfj5vftg=
Subject: FAILED: patch "[PATCH] tracing: Undo the registration when enabling the histogram" failed to apply to 5.10-stable tree
To: donggeunyoo.kernel@gmail.com,rostedt@goodmis.org,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 15:19:12 +0100
Message-ID: <2026091612-blazer-ambiguity-e8df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 92383cef66791a0c63a2f27755cadbdb2fbf270b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091612-blazer-ambiguity-e8df@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 92383cef66791a0c63a2f27755cadbdb2fbf270b Mon Sep 17 00:00:00 2001
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Date: Mon, 7 Sep 2026 21:44:20 +0900
Subject: [PATCH] tracing: Undo the registration when enabling the histogram
 trigger fails

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

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 54c95f9bd0a3..53100287466f 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6670,11 +6670,12 @@ static int hist_trigger_enable(struct event_trigger_data *data,
 
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
@@ -6752,13 +6753,13 @@ static void hist_unregister_trigger(char *glob,
 		}
 	}
 
-	if (test && test->cmd_ops->free)
-		test->cmd_ops->free(test);
-
 	if (hist_data->enable_timestamps) {
 		if (!hist_data->remove || test)
 			tracing_set_filter_buffering(file->tr, false);
 	}
+
+	if (test && test->cmd_ops->free)
+		test->cmd_ops->free(test);
 }
 
 static bool hist_file_check_refs(struct trace_event_file *file)
@@ -6963,6 +6964,8 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	return ret;
  out_unreg:
 	event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
+	/* The unregister frees trigger_data, skip out_free */
+	goto out;
  out_free:
 	remove_hist_vars(hist_data);
 

