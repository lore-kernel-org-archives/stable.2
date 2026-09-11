Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEEE4AEBF5;
	Fri, 11 Sep 2026 18:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150580; cv=none; b=fJBAfGlk1fw7AAuFvEWKMKY1yVEPldkuiQK6Dw0ScEdTdhD+1Pgtc+7mE9IImDoOrjCIZyFl/ShTz1REIIP4fcU/6POCSeQtIjVRnkPASBAGAujiW8ysz4Eu1VP68fs8Dxku16VfbFMdOLwfbrpWjXqsmzHgj61pA5mQ4ULDRig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150580; c=relaxed/simple;
	bh=QSD3eMCLrLuQgTXh7gAKcKxBIwLo7qPxGf2rRAEPZEU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JhZWqJktRH0JVHs820j3LXFgzFuHwmhjJwenO237pIvFB0/4TO7weRi73iaux93b0PN7D4DSVgPChuO3uPNeGy6UgQ+ZtE5CC9r1FZqEvr98WmF7kw4To1RIi0+q1E35PB4gcPC5sLk9PRTrWF6HS5bm1d09sGRQpi87PMyhCg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3IUTb76; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3IUTb76"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3105B1F0089C;
	Fri, 11 Sep 2026 18:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150568;
	bh=bL/rSYTIGCPz2ML0qUfMnK6Kt8ZSclOopkEza4Oddx4=;
	h=Date:From:To:Cc:Subject:References;
	b=h3IUTb76WsZKGoO96+ZL26cjzLbvlgRpKICsFfxBuC346VMm7qBdNfDQQLk/giFKW
	 AjSHpinvkDzHwWOAV6n+mvwNYl74tDrXbIScd32Z/od7RHI4O14JbfYHI+o2YXfrcc
	 uPpK4r12aQqE3c4L9U10cOY3w0TbMd2uWXoM68FpI27Ae/zAJkEd346WECBqdMtsOz
	 V4Dzpk4HO5qJFiAJvKw+cSYz4u4VK1KXjjaj6p4yXs/Pm2jTG+T7X5+DkT8HtEcDxu
	 LvQx84EoycGvgnJDKiR/6x8336TQzbBUlv0m89C+dsIT8LnFCjAaxPLQz4fO3rl972
	 D8h4B8Wzoz5+A==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x55oX-000000094yM-3NFq;
	Fri, 11 Sep 2026 14:17:29 -0400
Message-ID: <20260911181729.623284631@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 11 Sep 2026 14:16:43 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Subject: [for-linus][PATCH 07/20] tracing: Free histogram the field rejected for a bad modifier
References: <20260911181636.485043797@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Writing a hist trigger whose value or variable carries a modifier that is
not allowed there leaks the fields that were built for it.

__create_val_field() takes the field from parse_expr() and stores it in
hist_data->fields[] only after the modifier checks have run:

	hist_field = parse_expr(hist_data, file, field_str, flags, var_name,
				&n_subexprs);
	...
	if (hist_field->flags & HIST_FIELD_FL_VAR) {
		if (hist_field->flags & (...))
			goto err;
	} else {
		if (hist_field->flags & (...))
			goto err;
	}

	hist_data->fields[val_idx] = hist_field;

Both checks jump past that store, and the err label returns without
freeing anything. The error unwinds to create_hist_data(), which calls
destroy_hist_data() -> destroy_hist_fields(), and that reaches a field
only by walking fields[]. A field that never got there is unreachable.

commit e0213434fe3e ("tracing: Do not let histogram values have some
modifiers") set ret to -EINVAL and fell through to the store, which left
the field owned by fields[] and freed along with the rest of hist_data.
Splitting the check into a value case and a variable case replaced that
fall-through with a goto that skips it.

With CONFIG_DEBUG_KMEMLEAK, 200 writes of

  # echo 'hist:keys=prev_pid:vals=next_pid.log2' > \
	 events/sched/sched_switch/trigger

each correctly rejected with -EINVAL, leave 332 unreferenced objects
(63744 bytes) reported at create_hist_field(); 200 install and remove
cycles of a valid trigger leave none. A '.log2' field is two
allocations, since create_hist_field() puts the plain field in
operands[0] of the log2 field, and both are reported.

Use destroy_hist_field() rather than __destroy_hist_field() so that
operands[0] is freed as well. It returns early for HIST_FIELD_FL_VAR_REF,
which is what an operand owned by hist_data->var_refs[] needs; the
rejected field itself is never a var ref, because a var ref never carries
a modifier flag.

Cc: stable@vger.kernel.org
Fixes: e30fbc618e97 ("tracing/histograms: Allow variables to have some modifiers")
Link: https://patch.msgid.link/20260907034948.240387-1-donggeunyoo.kernel@gmail.com
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index bbdd56208eff..8cad99a8d01e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4317,6 +4317,7 @@ static int __create_val_field(struct hist_trigger_data *hist_data,
 	return ret;
  err:
 	hist_err(file->tr, HIST_ERR_BAD_FIELD_MODIFIER, errpos(field_str));
+	destroy_hist_field(hist_field, 0);
 	return -EINVAL;
 }
 
-- 
2.53.0
