Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E1447427E;
	Fri, 24 Jul 2026 23:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784935111; cv=none; b=YmP1HchaxQSk+RouvVPIBT+11031eBTRNdBO2ElTNLYHt3GoVOF8uW0VG/sYi5AtYCeGY6cELwL6RPd4ztjOUWJvs7AQx1cRNwY4Gd35IAQcZVLzWF8RBzZ9f+YK7vCT/+UJVR9WhbwzkCRDAnUR46styUz9NQ4SPuttOlhiY6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784935111; c=relaxed/simple;
	bh=F2tOvf5WD4E8NO3UV1aGiMKnBAAKeygyXub8ARPV0M4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=HLIEUbdTkNqoPso7NiE5ZkkAZ+0l+RqOorKREZtHJHrPQAZNHlGyQJr2Q2f2NB4IQFG9r1yTpLAhAViLwT3iQuYWAaY81tP0kjesyzy+kuKNZrLXC+Aa54mPhN/TBt7a4FZksd1FDQfBJANelwLmzld5CjwPGxyEneWCrCth03k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YlFNjxl5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlFNjxl5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8D11F00A3F;
	Fri, 24 Jul 2026 23:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784935110;
	bh=5hSA46R/NCpekSUYTMDGIBZjpTxT9+AGiLZ4O7dJxk4=;
	h=Date:From:To:Cc:Subject:References;
	b=YlFNjxl5VeXzAP/RrpA/rexYXXLgf8P82FxUTOlPF1c3bNkvBR8Nj3EHoglPmXijj
	 gm9+xnzhvr72vEp3Erq/IfBT7fTV/AdxeMY35KzzUpbNQtwvuxX2eV6UmQ3yvSTPxP
	 JxYWRXf8wwlrpbyVCxmnxysZ4EwTJmPH4xI4Ef+YgH7f91WCkVR05KDCeDY4sqE60K
	 9+CpzLaeXyFrKe2atGIzddwPdOPp10FmV2MzE/olVRN84o2frwCKoTR0lEGsDpq4QK
	 7lRphaNBvtndxnXrBQqdYARCtqE19oVNSIBiG1ftEcHVUjArq0rkVTJUf6cM6DPY6X
	 hNeo48Gi/XqQw==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wnPAN-000000046s0-3nVd;
	Fri, 24 Jul 2026 19:18:55 -0400
Message-ID: <20260724231855.758081600@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 24 Jul 2026 19:18:42 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Jackie Liu <liuyun01@kylinos.cn>,
 Vincent Donnefort <vdonnefort@google.com>
Subject: [for-linus][PATCH 2/9] tracing: Propagate errors from remote event bulk updates
References: <20260724231840.483353969@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Jackie Liu <liuyun01@kylinos.cn>

remote_events_dir_enable_write() ignores the return value from
trace_remote_enable_event(). If a remote rejects an event state change,
the write therefore reports success even though the affected event remains
in its previous state.

Keep trying all events, but retain and return the first error. This matches
__ftrace_set_clr_event_nolock(), which permits partial updates while
notifying userspace when an operation fails.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260715074455.3897-1-liu.yun@linux.dev
Fixes: 775cb093bc50 ("tracing: Add events/ root files to trace remotes")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_remote.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index ef42d9c38b37..e6724f947170 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -1149,10 +1149,21 @@ static ssize_t remote_events_dir_enable_write(struct file *filp, const char __us
 
 	for (i = 0; i < remote->nr_events; i++) {
 		struct remote_event *evt = &remote->events[i];
+		int eret;
 
-		trace_remote_enable_event(remote, evt, enable);
+		eret = trace_remote_enable_event(remote, evt, enable);
+		/*
+		 * Save the first error and return that. Some events
+		 * may still have been enabled, but let the user
+		 * know that something went wrong.
+		 */
+		if (!ret && eret)
+			ret = eret;
 	}
 
+	if (ret)
+		return ret;
+
 	return count;
 }
 
-- 
2.53.0


