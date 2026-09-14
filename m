Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4817243CE77
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382445; cv=none; b=l+eGV/LEC1+AnR/clQ+rqVhe7Kf8Ko3sBpD2luw/gb8MTGcHMXR7/ymdmWdsVps8NX/fTmHkCDFR1mNWpgNXWqFamud+dyoty8+NakGBhKEPraI4L3joSAfTDk+EhzNr6tNgzsOQgFg1pNBpQmzAo6I4dJu//2TbUrmOh6uMcoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382445; c=relaxed/simple;
	bh=GoNTHpmWIseG1FgYRLB02Ui/Fmpaj1eRK8oQos1DfcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ia4ZuviSkkr1a4hZv7DzUADAjvReV+udsKRVLTSm4ZUL9UUbJ/WyQubppMN7NFwzo7B/hoifqj2chPndoQaVQu0NInHYY/Fl1h3oiyumftloY0jlKJhAKYvWtDPC4TO4NWRaVE9zU05e/iPFXaAANRcj1NstyZzpiodTYelyb6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZDkgCcKY; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZDkgCcKY"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-86309e1a213so1276277b3a.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 03:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789382443; x=1789987243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ITP8YnoGoJGYNciFDsIfLG4MQrrfwApvPNq3/p06wBI=;
        b=ZDkgCcKYs1VUyzgmiCOjTl1/8zgJfzecGHV3H4HlNzAmiE6LQyodAo+ocFoLzap1DJ
         0YNfWAl9UNMsUJCrhAQDX21t3FsxINNdRGVT3F7uOhKopatHFkA9MlRZ7VWcjYHDcg43
         fPcbNNDa9DsTsO510qu9xnuSZi9OSt/WyqPD3a9Q+WAz8orhrNuLPfu1BClGx18Ol54y
         ClikhAmhOKsGebdLYfr36AlWCZGWbc6anjvVW2b78A4M59mee5PXDbjUb/7SmC8MamjD
         SYbYaOvelhIGAwjIqjrY3CYK1exue7LBLX2QCoXZ0hkQaSTOiwjfym9LXxFcK5HBu9/O
         2EEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789382443; x=1789987243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ITP8YnoGoJGYNciFDsIfLG4MQrrfwApvPNq3/p06wBI=;
        b=Cp194Hf/yNAO8PphpzMu6+D6N52+2CJ5h6cE6d5tUJ8Sq/yo1aB6C+33YEDg97eCv7
         VaUgrkxo6+JeCg0M18RRDutVuVxapu10v7lsRChV9R20BJ1DLOMbNYB8LlnhWKp3NBuA
         yt7gZCg7cvQyRNW0J6XuwHeiNOY1leOloECvalcyMYJJ2N6MpGmTM8lggLat39urUf4l
         LJBu9QPzUFZul5r0CDvf5Do6AAeeWncDimK1b5oR3ZPz3tzKupDm8wkTlWjQ5KA9t4xN
         ORJbJXG6ekdEyc8I3uHn/15tEdjpPEAOH8ROVrVwm5Xx/b4D/yHVpLCz88uQB7KY/iTA
         a1VQ==
X-Forwarded-Encrypted: i=1; AKwUvBwb+CXwxBzfM+d0PM20NJnHBbQrlrH5KcXteIvhJiGqsqVl+IobxFqvnjzFWLlRSbQgF+kZ8m4=@vger.kernel.org
X-Gm-Message-State: AFuF++m6XmpBI9cA/KCZNQYdWNhcuHv6BQonqpqXMlcNq0pmquyWPg2d
	K1hfAM+/TfJv6dcwMD0JNd16YWo6J2C2GN6vJ3Alu/1dwiYGzZdDamG6mUob4a0=
X-Gm-Gg: AYBFou39Hfal9qLpSt6fF3wHRYolclO2HI5e7/ZiB/D9ND+hsineD9RmtlulOpk8xai
	bw7x+kcevEL7ka4ZEpKL6JjYJ7lfnyK/b3X/lHg4s6hMR1YT46006NXZgailT9ZtahEMaaqgt1A
	ncrnDt2eY2NfAQgrDiJP6loBKW/+o1Ttciisa3JRkKO55Y4FMOjv2+EvjCMAxusnI7sbZiCC54p
	2wUlBrwVfiXfvgtqttbNj/B28MxkcRTSDzKPEEtYJJBHgUpSNAN8fjXaXgCax48S1zXVEPVM5Sd
	EhiyvCWHOSrx7IagOS83jvjHguc1ndc215uYuPvRxWXidzZ1328eYJ+zM7QRPMARZif6ueU1qOa
	ixQv2LzWKgFBdQVIQMmw7LiVDUtJFLbaGGDvQ3dUY9y7V0tRFhLepQFV5QErytSBBkCAJns/WU3
	uQe/JREBMIceSTs5RapUZazd45l/wsQH87qoHiJkqmkdBuYPvGZgTRNnMCT7S1CvsmaUPNqB63C
	D/tw/IrpeBRDJO2g95C1GooxGQ=
X-Received: by 2002:a05:6a21:d83:b0:3cc:c7cf:5a44 with SMTP id adf61e73a8af0-3db4037ccfcmr4309572637.2.1789382443334;
        Mon, 14 Sep 2026 03:40:43 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:3b80:bc61:4619:5346])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c652aa9asm4632560a12.9.2026.09.14.03.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 03:40:42 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	zanussi@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH] tracing: Unregister field variable histograms when the command fails
Date: Mon, 14 Sep 2026 19:40:36 +0900
Message-ID: <20260914104036.1768529-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260913204302.DB2551F000FF@smtp.kernel.org/
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
Tested under QEMU on 704340f1cd0d, x86_64, KASAN + PROVE_LOCKING, 2 vCPU,
unfixed arm first.

  command                                      before     after
  valid onmatch on another event's field       works      works
  removing that trigger                        works      works
  onmatch with a trailing bad field            orphan     clean
  the same bad command, five more times        orphan     clean
  two field variables, then a bad field        2 orphans  clean
  '!hist' that matches nothing                 clean      clean

orphan = an extra [active] histogram left on the matched event.

ftracetest test.d/trigger: identical per-test verdicts on both arms.
trigger-synthetic-event-dynstring.tc fails on both because busybox execs
its ping applet as /proc/self/exe, so the test's grep cannot match.

The exit that reports a missing synthetic variable is not reachable
through onmatch, so no run covers it.

 kernel/trace/trace_events_hist.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8af97fd4ee2d..90e6e3990c25 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3134,20 +3134,18 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 
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
 
@@ -6980,6 +6978,8 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 
 	trigger_data_free(trigger_data);
 
+	unregister_field_var_hists(hist_data);
+
 	destroy_hist_data(hist_data);
 	goto out;
 }
-- 
2.53.0

