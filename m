Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792498813;
	b=hmbuNDJQbtvDpjxGPftT0jHd3zAOdZg2E58HHa8lUVE1o9wBEY+kQifplxE+QwWXq6a6
	 0qdERTOw8eqc4JkYL+XxdwUnh/kzf4hUdi/77Hw97PZj9DA7q6wmV7HtbEjYUWWJHdfXT
	 gjkhhgCks09KyJ772tVYGITXYH7BsYy1a15BG6ECShbYKjsfTK6nbMorWmso/3LqvNxTz
	 hUbP2qcjf+5BClOVVT6r+2CKdLGReeqxIWXXwlLzinlK2UxMjLBKaMCXDma1kltGNO9jc
	 XrJM84Win1EXyDDWSZOfSfTRaBVikud5PPKU+ESwkRnm/ovOOrTh08wjNQ6QxEUQJww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792498813;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=1bX3LhI/tU8AszsfckVEOh+0Dxk/I+jSEHqnFcRwNcY=;
	b=Ehb1oMZhMBYdl+Jkk9dwmZOqixLEX6an/1f9g0OyvEhOoM2LRU98Kj4eoSKCbUVT+q3a
	 Hu65GdMxJ1Lplz8i4TGoG09hJgYxCcKyhE56tjzjX+GDXEN+3a+BgEZ+2SLCaWHoYEqOU
	 ZWvBdLn+y9u5xFiuYKI4bYoCIBv5UToqwNSBptfvM7PTEGdvgoUaL5R2Mx/e7R2Zn8tw3
	 TTmXNnfRt/s96b9JQlhwnc3J6RsQSEHagoVMOAYbKDZMrsPn5PMk8XHz9ZSmVW3IedSay
	 LDY1oz8OrIMsTPJvagk9huta9GaKDwJE7zG7rBxdJxoMxebSIrbCnGq3GHQ5vJdQnMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XH3TQ+i8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF4D606A323;
	Tue, 20 Oct 2026 12:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XH3TQ+i8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162A41F000CD;
	Tue, 20 Oct 2026 12:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792498812;
	bh=1bX3LhI/tU8AszsfckVEOh+0Dxk/I+jSEHqnFcRwNcY=;
	h=Date:From:To:Cc:Subject:References;
	b=XH3TQ+i8sNvp+f9DNGuM/gQcCTelqL+n7OnRsZ2IuugI3fTa/eP7xaACIin+wgXMa
	 Pfz58xKhT5GJWc7M7H1kt9uybEv5ZCN/aXzc6DV0uMx0o4vKEtlRycU+7hhQiCNqki
	 D1UFbVXgXiTHXpbCWM+1vPqSW//1yuvR0u4NWjaybTEdCgxohyBxHcs8u3ACPkNWW5
	 EXC2/XO9kZcwqV6t1w/S/0SsO5SrkV1PBOui44DYnbW2pgbMEAk0sg8zZ4wzKAhPFP
	 Vi3/X36pqtl9SmTTy6745sbX/d2DbHhF1RPLTbnsxWiVdY+6//X7YQVXFCrV9QMGwy
	 7D9FbqDa/5zqw==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xJ8p9-00000001y3N-1qtj;
	Tue, 20 Oct 2026 08:20:11 -0400
Message-ID: <20261020122011.246739609@kernel.org>
User-Agent: quilt/0.69
Date: Tue, 20 Oct 2026 08:20:00 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>,
 Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
 Tom Zanussi <zanussi@kernel.org>
Subject: [for-next][PATCH 4/6] tracing: Save the event file instead of the compatible histogram
References: <20261020121956.600452831@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

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

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/all/20260914110753.221E61F000FF@smtp.kernel.org/
Link: https://patch.msgid.link/20260914234754.3676905-1-donggeunyoo.kernel@gmail.com
Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
Acked-by: Tom Zanussi <zanussi@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5527605758cb..42b89171134d 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -557,7 +557,7 @@ struct field_var {
 };
 
 struct field_var_hist {
-	struct hist_trigger_data	*hist_data;
+	struct trace_event_file		*file;
 	char				*cmd;
 };
 
@@ -3129,8 +3129,8 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* Save the compatible histogram information */
-	var_hist->hist_data = hist_data;
+	/* Needed to remove the histogram when the target goes away */
+	var_hist->file = file;
 
 	/* Create the new histogram with our variable */
 	ret = event_hist_trigger_parse(&trigger_hist_cmd, file,
@@ -6362,7 +6362,7 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
 	int ret;
 
 	for (i = 0; i < hist_data->n_field_var_hists; i++) {
-		file = hist_data->field_var_hists[i]->hist_data->event_file;
+		file = hist_data->field_var_hists[i]->file;
 		cmd = hist_data->field_var_hists[i]->cmd;
 		ret = event_hist_trigger_parse(&trigger_hist_cmd, file,
 					       "!hist", "hist", cmd);
-- 
2.53.0
