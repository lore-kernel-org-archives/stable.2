Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD484A5C42;
	Fri, 16 Oct 2026 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161100; cv=none; b=G79tXOg7adTbL5gtZDrEl0dzqY01ogJVvdShEx2qyLCwETpUum92OI2B7xl4M126hFPu88CL3HsEiCRMe/6Wpb8GZ5QNzafWRQJogagZLSRfnHNBDXrNONjrLBqS36uSbkA0OTjmLkE1dG9MIy2QWcGIb+zVp/vskoVOvTmbc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161100; c=relaxed/simple;
	bh=fKZz8eDcPaYBOhyFt8zTVVi1XEGsCga5c41nAyFcjFE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IW6E7gXOL1TTBK5NE1vQS4zVTDtRky0GH6yyJpPSOA1l8l7Ah8uVI7oFi8fln+SLMpetKswW8ZLOBPIyACLUahhmxqi9bTZHjhe5mWMSAOb7t9foAzbN+pCHz2FsqvMRaQE2R/FA85QRBAGYLGfWEvNjcj7cM9DktTif4q5GGEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzWHB/tU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzWHB/tU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 175DD1F000CB;
	Fri, 16 Oct 2026 14:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792161098;
	bh=6zHPOiiZft8qbX6TerRzYwd6JL5qMOEUciSET/TTF3w=;
	h=Date:From:To:Cc:Subject:References;
	b=BzWHB/tUZEOMPtUgd77oFPJRZqhzFKqIwV74NXNkzkjT0tw7aX9NrfvWrwBM8aWMa
	 2SYXkGj47kyMWwh7fRycRjlMboVq5ZvzHTKHDQT6s7TRPltyXiZ5YT6kOoBvp8y8B+
	 sfr8w6yLGDIvE+gnG7tR7PE8tJ4fIhXzhxDVrMAKg64PjF7PEzKQKaiP0bFqt/VNww
	 z5t/Xfo2fkxVjLchKVlQiTyoJcAU92vk3DaetnlF7m911m7pzhnWizaIdxARJ46jRf
	 Wj1yYZOTr7pBXJ/vtAIrOj6VpF8FO6BV86EOAhmgJ8bqspmav3qSsfniDibp6/FH6n
	 FDBqTqkQBy5mg==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xHiy9-00000000Xon-1Ukd;
	Fri, 16 Oct 2026 10:31:37 -0400
Message-ID: <20261016143137.182901087@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 16 Oct 2026 10:31:30 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 sashiko-bot@kernel.org,
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [for-next][PATCH 15/18] tracing: Unregister field variable histograms when the command fails
References: <20261016143115.392980228@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

An action that names a field on another event needs that field as a
variable, so create_field_var_hist() registers a second hist trigger on
that event to provide it, and records it in
target_hist_data->field_var_hists[].

If a later part of the same command fails, create_actions() returns an
error and event_hist_trigger_parse() jumps to out_free. The write fails
with -EINVAL and sched_switch gets no trigger, but:

  # echo 'hist:keys=pid:ts0=common_timestamp.usecs' >> \
      events/sched/sched_waking/trigger
  # echo 'my_synth u64 lat; int a; int b' >> synthetic_events
  # echo 'hist:keys=next_pid:wakeup_lat=common_timestamp.usecs-$ts0:\
      onmatch(sched.sched_waking).my_synth($wakeup_lat,prio,nosuchfld)'\
      >> events/sched/sched_switch/trigger
  # cat events/sched/sched_waking/trigger
  hist:keys=pid:vals=hitcount:ts0=common_timestamp.usecs:sort=hitcount:size=2048:clock=global [active]
  hist:keys=pid:vals=hitcount:synthetic_prio=prio:sort=hitcount:size=2048 [active]

The second histogram is the one created for 'prio'. It is still active and
still counting.

out_free reaches destroy_field_var_hists(), which frees the
field_var_hists[] entries, but never unregister_field_var_hists(), which is
what removes the triggers and runs only from event_hist_trigger_free(). The
entry is freed and the trigger is left with nothing tracking it.

Unregister the field variable histograms in out_free as well, and record
each one as soon as its trigger is registered rather than after the lookup
that follows it, so no exit can leave a registered trigger untracked. The
entry then belongs to field_var_hists[] and is released by
destroy_field_var_hists(), so freeing it on that exit would be a double
free.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260914104036.1768529-1-donggeunyoo.kernel@gmail.com
Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260913204302.DB2551F000FF@smtp.kernel.org/
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fdd097abb0d6..972804709b14 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3137,20 +3137,18 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 
 	kfree(cmd);
 
+	n = target_hist_data->n_field_var_hists;
+	target_hist_data->field_var_hists[n] = var_hist;
+	target_hist_data->n_field_var_hists++;
+
 	/* If we can't find the variable, something went wrong */
 	event_var = find_synthetic_field_var(target_hist_data, subsys_name,
 					     event_name, field_name);
 	if (IS_ERR_OR_NULL(event_var)) {
-		kfree(var_hist->cmd);
-		kfree(var_hist);
 		hist_err(tr, HIST_ERR_SYNTH_VAR_NOT_FOUND, errpos(field_name));
 		return ERR_PTR(-EINVAL);
 	}
 
-	n = target_hist_data->n_field_var_hists;
-	target_hist_data->field_var_hists[n] = var_hist;
-	target_hist_data->n_field_var_hists++;
-
 	return event_var;
 }
 
@@ -6983,6 +6981,8 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 
 	trigger_data_free(trigger_data);
 
+	unregister_field_var_hists(hist_data);
+
 	destroy_hist_data(hist_data);
 	goto out;
 }
-- 
2.53.0
