Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF13259C80
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591682; cv=none; b=pWAHO2LLgADyhuxadezVBkmKwGdAGfu0v/271xh98jCEoln1TpRj1u+xUebdMfpqnxKtHWJ8R9sjFkWz2sYSqZjx8K/go9d27nx2M2EA5bAvM7sSmn+LfL14Zcj0BdBnSjUMcF4RKSds+G/kf/0wRWKM3/3zUh0rEA5NRVEEw14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591682; c=relaxed/simple;
	bh=kM3xBXsG/Je3LnI4+DWOSpTysUSMAF3sUx5i/l9jTME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apQ/BnVjW2/w3yarxOp+hNaj2bFCtufAtavYJgz8UcG10eMvHaP7zE4YiC8Tm+nxxcGIVd+OmYTMWNpjTa5mnsm0AvKSCPClVI4NMUP4AUNz+C+z9FSUPzWRy2lJqut8wwHa/A9eKINbdF8Gnbn1d5uWRPJdAkSpW3j4InoZqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9w/9b7U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9w/9b7U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5461F00893;
	Wed, 16 Sep 2026 20:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789591673;
	bh=QhyharcoOpeuOWIgxtbbsoihXN4y/8LiNJmgEGWuDYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j9w/9b7UNr6qDFeRfc6gRuzFFYIWSAS5Rbgze1tr8B7Or4ljXXRpHVGvw3yaPFK6e
	 tUpH+7+RNUdtLJrOstzdimWSBd8FaXAQuBaJRoRqcntpaqubIzsyJelD+5CriEtQkt
	 9EUw6GLfL4hG2ikWwBHOhBDanHoqdrhexPEhk9IFnWe59MloJINGnggVc0wxihNZ7l
	 p3Rq25ClzSKobfqYK5J9xPZLiZTnYNQtTvq486B1eILRdt2l+lNZeHcyNOVcfHdpSz
	 y5QVbXXzwMQUVePskCZZegweA6jfUJUiaPzT6+CLWXc7TFATC2t/SzIeixQiDff8Iv
	 RDfs/4687gH9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Sashiko AI <sashiko-bot@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] tracing: Undo the registration when enabling the histogram trigger fails
Date: Wed, 16 Sep 2026 16:47:49 -0400
Message-ID: <20260916204749.2726383-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916204749.2726383-1-sashal@kernel.org>
References: <2026091604-putdown-resort-2cec@gregkh>
 <20260916204749.2726383-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_hist.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 311d7f68278d7..f1a03853eaced 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6293,11 +6293,12 @@ static int hist_trigger_enable(struct event_trigger_data *data,
 
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
@@ -6375,13 +6376,13 @@ static void hist_unregister_trigger(char *glob,
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
@@ -6586,6 +6587,8 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	return ret;
  out_unreg:
 	event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
+	/* The unregister frees trigger_data, skip out_free */
+	goto out;
  out_free:
 	remove_hist_vars(hist_data);
 
-- 
2.53.0

