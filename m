Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3173921D8
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789429685; cv=none; b=gYvwChGmP1PKowcbM3N1HtbrcdplvR1fVTNU3jSFtnNh7+AUrLtXjZAJuii9gYj1/CH0pscRXsKr5Yk1HJGkhboppFaIOjlvy5Y94qPn2IAno+jIjyXXShqBSe3NbQHnOedQ/U+f/EoiJ8DtXpikH6UCxV4/rzGQHfirIv2fDUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789429685; c=relaxed/simple;
	bh=tUORdNhrHwcWgp/YbkquRctE7GdPcEM18x4s7AbvUVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jpURNxWj5RohWbYCdAw+y8f3VqbzwANQThES4b5OlZuFiwL+RuGZ82ZvIgjHHAbG6QNIiG1iMtt3sNAIhXbT8pkkwTzaMBUxLLbGs5EaUmVZqIvTAuDRMQDI5avpSmhq19v8DVNfdJEyfYmYiRR5yU4fCMzrMJM4KCoBiWQWHO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CexfMKi9; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CexfMKi9"
Received: by mail-pz2-f43.google.com with SMTP id d2e1a72fcca58-85469e25187so1980211b3a.2
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 16:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789429682; x=1790034482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JyCNMJxkTrShME/DIcrG5BOzzpAUEE889vj8TyhVyz0=;
        b=CexfMKi9RbWBmLaj9nMBqSky0LVtCcxLwEdh6f+YoPtKtZKi8mSRDD6n98CjdJEJTM
         80yYCWHNPs79FYKOK1tBc4tSJQd4gvJ//Uo3dVIP37Biql6haVxeyFJUETd8Jt6NX2MC
         nUS1d7zde+1EKR8KcHOnRrswIHRHafVi+OlQ4q5YXSAvGHhLmdhX/gAekJG602X2nH/D
         soyLFnDCQPU6IgYhiJDoTYOq84SBHpuAzRLePlqis4sfoPWaDKrzyjMHSFSfWcgqYa8H
         o75q3e9FwpSwaA7bwVPuRU52cuDazADDriL9xcpirVXtMAwpYhCKdlylpq1UYoIHyGOg
         uMnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789429682; x=1790034482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JyCNMJxkTrShME/DIcrG5BOzzpAUEE889vj8TyhVyz0=;
        b=fZACxg3T8bSBFXfjcMkO8c9KlAePEk+zyO47+rBYQI6eznDcRQW84yTLp2Z8dhvjIX
         1mzZQ87Rv3JwoVz+0QGQ3f52Tnzy/zVZbdqrxzpPPnpIst1AN317lk64qruvPvtSBOTU
         9/ZmU4ZFyOHGowqFK2ZpsSGwDphh4s+k47MJsUqgcACP1yMKa7tltLUj/8vpqgV6JTdG
         gDczaQZbiK2DfJaUgiEQ/5zQipE3cu7lcaUFWDypbXL8aVnZBGRdkOP93gETvrdj54LF
         6I6hPi+OiuoL0H+WauUKPuReermgkwteIJALpMMny5dsiz/99oYKgyPqdZua9S0gQtpV
         TF+w==
X-Forwarded-Encrypted: i=1; AKwUvBzC7URYh5ScXsrLpMIsf32p1vT+Gv2y65WwQKUy2Da+JNUxDJ9BMTy0ClwOaO/8j2RDkeMH+gs=@vger.kernel.org
X-Gm-Message-State: AFuF++kLf2ugWxSQ8m6ufjwaaodWn194Sqbb+k43Scr7ZC24ETgKJO4o
	hGfa9X9lXU/OI3dwGN6qz17IstHUaHdlGRHv5JIwjhDtaswjMSqzDFg=
X-Gm-Gg: AYBFou0thqZ2+HwpFuX3lmCkfIiAGA6bjGcLtkulboXkYy+wlpGC+ByAPyfiI67fMuz
	YsFdpo5sj2zZ83W5DUXu0o95ePTpKIgRQURT+ScKYhNoSyqvWhVImNARaDCCcqxILBxsGUnc2BP
	a/T9+X70rj2EPmJkDbQpAaaVEfyrB6vqMvZdNg85yJ7L5kG1LgrCv7rlqy4I2FszuJUowVO31dm
	tH2OuoILljwAXcPsAllkjyRmNpWppK30BF9ZV+1xcGDl7wgIAbXnEA2H/3A5lnI34gmj510zVNG
	h5PBxJ9/KC3/XdphWBu/PZgsIrORyXzAjR2hojw5mhRF76glyigYiLTSaooNpkGj13rz3CWSiqV
	BezAVKGA7weHeS/HPXKZ79Uwt3sXnOmqXfiAaUmknBvXAEcVkYMJnfMgQhRJN3hMMT14J064kne
	SiFrTSlD8wilRERzQTDfsSDZyfutG3RXApTZQRJJa0ku9JZkvc2e1w2L1qvJnAXSBD+4buPcXvW
	OlaYDN+8iVI5CleoLwdfcMG5GyVrU6FdBD/eg==
X-Received: by 2002:a05:6a20:4323:b0:3d2:df:1854 with SMTP id adf61e73a8af0-3db4044754dmr8579967637.6.1789429681864;
        Mon, 14 Sep 2026 16:48:01 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:556:537c:f7cd:8a1b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f5833fsm34777608eec.23.2026.09.14.16.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 16:48:01 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Save the event file instead of the compatible histogram
Date: Tue, 15 Sep 2026 08:47:54 +0900
Message-ID: <20260914234754.3676905-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

create_field_var_hist() creates a histogram on the matched event to
supply a field variable, and records it on the target so it can be torn
down later:

	hist_data = find_compatible_hist(target_hist_data, file);
	...
	/* Save the compatible histogram information */
	var_hist->hist_data = hist_data;

hist_data is not the histogram it creates. It is one that was already
there, whose keys the new one copies. The saved pointer has a single
user, unregister_field_var_hists(), which runs when the target is
removed:

	file = hist_data->field_var_hists[i]->hist_data->event_file;

find_compatible_hist() matches on keys alone, so it can pick one with no
variables of its own. check_var_refs() then returns false and the user
can remove it while the target still points at it:

 BUG: KASAN: slab-use-after-free in event_hist_trigger_free+0x2b2/0x320
 Read of size 8 at addr ffff8880093b90e0 by task init/1

 Freed by task 1:
  kfree+0x154/0x420
  event_hist_trigger_free+0x1d5/0x320
  event_hist_trigger_parse+0x35f3/0x69e0
  trigger_process_regex+0x1a6/0x250

Save the event file instead. It is all the dereference ever wanted, and
it does not go away when the user removes a trigger.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260914110753.221E61F000FF@smtp.kernel.org/
Cc: stable@vger.kernel.org
Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
x86_64 under QEMU/KVM, CONFIG_KASAN=y, 2 CPUs, base 587858367581.  One
kernel config; one initramfs image per arm, differing only where stated.

A compatible histogram on sched_waking, an onmatch() target on
sched_switch naming sched_waking's prio so a field variable is forced,
then the compatible histogram removed, then the target:

  echo 'hist:keys=pid' > events/sched/sched_waking/trigger
  echo 'hist:keys=next_pid:onmatch(sched.sched_waking).my_synth(prio)' \
       > events/sched/sched_switch/trigger
  echo '!hist:keys=pid' > events/sched/sched_waking/trigger
  echo '!hist:keys=next_pid:onmatch(...)' > events/sched/sched_switch/trigger

  unfixed                        1 KASAN slab-use-after-free, above
  unfixed, 3rd command omitted   0
  patched                        0

The second arm is the control: the other three commands are identical, so
the report is the removal and not the harness.

The read is on freed memory rather than a pointer that is reliably wrong
-- whether the '!hist' still reaches the right file depends on what the
slab has handed out since.

trigger-field-variable-support.tc covers this path, and its removal step
goes through the line this patch changes.  Run by hand against both arms,
since the initramfs carries no ftracetest: inter-event histogram PASS,
field variable created PASS, field variable removed PASS, on both, with
no KASAN report on either.
 kernel/trace/trace_events_hist.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8af97fd4ee2d..cc22bba011b2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -549,7 +549,7 @@ struct field_var {
 };
 
 struct field_var_hist {
-	struct hist_trigger_data	*hist_data;
+	struct trace_event_file		*file;
 	char				*cmd;
 };
 
@@ -3118,8 +3118,8 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* Save the compatible histogram information */
-	var_hist->hist_data = hist_data;
+	/* Needed to remove the histogram when the target goes away */
+	var_hist->file = file;
 
 	/* Create the new histogram with our variable */
 	ret = event_hist_trigger_parse(&trigger_hist_cmd, file,
@@ -6344,7 +6344,7 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
 	int ret;
 
 	for (i = 0; i < hist_data->n_field_var_hists; i++) {
-		file = hist_data->field_var_hists[i]->hist_data->event_file;
+		file = hist_data->field_var_hists[i]->file;
 		cmd = hist_data->field_var_hists[i]->cmd;
 		ret = event_hist_trigger_parse(&trigger_hist_cmd, file,
 					       "!hist", "hist", cmd);

base-commit: 587858367581b9c55c3690f4e63382ad622719d4
-- 
2.53.0

