Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237A14AEBC7;
	Fri, 11 Sep 2026 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150581; cv=none; b=GNgUHIZ+OhO+QmssRap+1gD5FjjarBKD0+od/ZiIpsNDlS5p3NEwT50Sm0/SsA4mRhFX08xFaRB8jhfPCLTYMbXFv0lO9LF69d6SXoEnv18CkQ+cUEiv9jfLcfBhWb/H+BmYHn2RJ6s0O0Tfe1I2bMUuEuuUzUVzSMe4iTwjf8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150581; c=relaxed/simple;
	bh=17r2nWJ5mCq+EFjYU2BJ5Lxcj5QjpWB7Y/ORj51hwCo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NRZdbK0N9wuXzHO5GlbvEdz2lTAsdzFh8GvBHa6y+p7xtehiGrZFliWnu3wZ5k1/6NxkL1XYZ0FODzxMp+uQfKKsXpgPw+A/mglap6zBkXrEVS9sOy7RJAInkPoCTeaHsjisdbKa6VZM03wJATz/uz1K1V2De39GzKrn2J+e90o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSFKPLhk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSFKPLhk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FCAD1F008A1;
	Fri, 11 Sep 2026 18:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150568;
	bh=BWMk4V8JLtyQmWkVA48S35Mwq6afgptAi/twnA8Jxz4=;
	h=Date:From:To:Cc:Subject:References;
	b=JSFKPLhkBB0r37eFZZGUgSyuyzBa86OvECJQDaWSujNS1+gsNzYXLpKHM9nfHOvzM
	 3O+UyPXqW3+5ZhSWg9iQnG8nvcudctHWB+Zqrt50jr8fKX+uceKLF0IpCbTTZOIdJl
	 tGDZ5PxeyddlEaB7MxMWZcEVoL6Uv66GzGlT2D0x9jKHvgVSTzXm5snC/92dpWFFe+
	 kNSqvXZ6j/0K3ZYQBMcn5zF9GiSXKeZhPVM2Gql0D3pEmKr+d+iXL04Hq2KFQjGCdH
	 2EQKP2rTwH8uT9z9d7OwtV/IEo7+4ZxeJ6aqVcK5sI2sZI6+7Hw8xllLBz26EzPj94
	 8ERuY5lWJravg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x55oY-000000094zU-0s6e;
	Fri, 11 Sep 2026 14:17:30 -0400
Message-ID: <20260911181730.028349834@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 11 Sep 2026 14:16:45 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [for-linus][PATCH 09/20] tracing: Let histogram values keep the percent and graph modifiers
References: <20260911181636.485043797@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

The .percent and .graph modifiers exist only for histogram values, but a
value carrying either of them has been rejected since v6.3. The example
in Documentation/trace/histogram.rst,

  # echo 'hist:keys=prev_comm:vals=hitcount.percent:nohitcount' > \
	 events/sched/sched_switch/trigger

returns -EINVAL.

parse_field() sets the two flags only when the field is neither a key nor
a variable, that is, only on a value:

	} else if (strncmp(modifier, "percent", 7) == 0) {
		if (*flags & (HIST_FIELD_FL_VAR | HIST_FIELD_FL_KEY))
			goto error;
		*flags |= HIST_FIELD_FL_PERCENT;

__create_val_field() then rejects a value for carrying them, so no field
can reach hist_trigger_print_val(), where both are implemented.

commit e0213434fe3e ("tracing: Do not let histogram values have some
modifiers") added the check after a value with .buckets oopsed in
hist_field_name(). That happens because .buckets and .log2 make
create_hist_field() build a nested field in operands[0] which
hist_field_name() then walks into. The percent and graph flags do not
create an operand and are not read by hist_field_name(); they are only
used when printing a value.

Stop rejecting the two flags on a value. The check for variables is left
alone, where they are unreachable anyway because parse_field() rejects a
variable carrying them first.

With the two flags removed, the trigger above installs and prints as
documented:

  { prev_comm: rcu_preempt  }  hitcount (%):   0.00
  { prev_comm: init         }  hitcount (%):  99.98
  Totals:
      Hits: 237896

Cc: stable@vger.kernel.org
Fixes: e0213434fe3e ("tracing: Do not let histogram values have some modifiers")
Link: https://patch.msgid.link/20260907052113.430818-1-donggeunyoo.kernel@gmail.com
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 8d80562fb502..5e00da2d5b1a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4299,8 +4299,7 @@ static int __create_val_field(struct hist_trigger_data *hist_data,
 			goto err;
 	} else {
 		/* Value */
-		if (hist_field->flags & (HIST_FIELD_FL_GRAPH | HIST_FIELD_FL_PERCENT |
-					 HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2 |
+		if (hist_field->flags & (HIST_FIELD_FL_BUCKET | HIST_FIELD_FL_LOG2 |
 					 HIST_FIELD_FL_SYM | HIST_FIELD_FL_SYM_OFFSET |
 					 HIST_FIELD_FL_SYSCALL | HIST_FIELD_FL_STACKTRACE))
 			goto err;
-- 
2.53.0
