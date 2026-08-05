Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B665F3F7886
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922489; cv=none; b=j5ZtkGJ7jQraraDnxHdokrDYsR1JDI1+tjqkT7cBlSkIdGjGG3bBHqSG/MlCnJG5O6lfAJqWkH48Ny4NrC1L90oncDq9TkShVjrWzMetj3lv7UaG6SJLia5wtlfNXKfKVnF/vpw/k+KnTTE4D3mKaujHXDG+3PSEvdrLegsz8wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922489; c=relaxed/simple;
	bh=mddboOSO3LAHug6LY3Hor5XSRq8DZZKVoPkqRlkY5K4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MUXp70QLA4D53vD9MLHvJvLz75Fq3rLTvWxEBcVXDY3cVE+06PY3kTRPC8yxEU6n1kjHUgV3Dx80BBT08xg+AlRxT4EvVAfPk6Z3Tum/XSmZNQPMgsSF++GZu6Aha5QewVStJvZg1gOPK6zmZESWUBpcAF4lA7LzID0+lErCHjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UJrrkV8S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UJrrkV8S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C323D1F000E9;
	Wed,  5 Aug 2026 09:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922488;
	bh=Puo0nPGduh1yHH+Gx9t+pG4hN27XehuP3t6S2iRj7jY=;
	h=Subject:To:Cc:From:Date;
	b=UJrrkV8S7g38weWHfiK8mvgg5LcT9cCqPndhCWFElHLXYKjrFVOzFOao3VkY3FFlJ
	 TYc1CPmhBm11WSuo6pqmYXbeXhxDsBjNIlyYIgHOwhOHhhvOXxLxRqXZchbgAfcrt1
	 gaX+Nm+fhVhIYVbU2YoLZzA7RelYyTOLEHAXBBV0=
Subject: FAILED: patch "[PATCH] tracing/fprobe: Roll back on enable_trace_fprobe() failure" failed to apply to 6.6-stable tree
To: raushan.jhon@gmail.com,mhiramat@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:34:23 +0200
Message-ID: <2026080523-posting-goldmine-ec8c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x aca0cd1bf16574327ef64f3178e5f5e37a61ef0b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080523-posting-goldmine-ec8c@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aca0cd1bf16574327ef64f3178e5f5e37a61ef0b Mon Sep 17 00:00:00 2001
From: Raushan Patel <raushan.jhon@gmail.com>
Date: Fri, 24 Jul 2026 12:12:08 +0530
Subject: [PATCH] tracing/fprobe: Roll back on enable_trace_fprobe() failure

enable_trace_fprobe() sets the file link or the TP_FLAG_PROFILE flag and
then registers each trace_fprobe in the probe list. If
__register_trace_fprobe() fails partway through, the function returns
immediately without unregistering the trace_fprobes it already registered
or undoing the file link / flag it set, leaving the event half-enabled and
leaking the registered fprobe(s).

enable_trace_kprobe() already handles this with a rollback path. Do the
same for fprobe: on failure, unregister all probes and clear the file link
or profile flag.

Link: https://lore.kernel.org/all/20260724064208.480030-1-raushan.jhon@gmail.com/

Fixes: 334e5519c375 ("tracing/probes: Add fprobe events for tracing function entry and exit.")
Cc: stable@vger.kernel.org
Signed-off-by: Raushan Patel <raushan.jhon@gmail.com>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 9f5f08c0e7c2..3120403a5b60 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -1481,11 +1481,21 @@ static int enable_trace_fprobe(struct trace_event_call *call,
 		list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list) {
 			ret = __register_trace_fprobe(tf);
 			if (ret < 0)
-				return ret;
+				goto err;
 		}
 	}
 
 	return 0;
+
+err:
+	/* Failed to enable one of them. Roll back all */
+	list_for_each_entry(tf, trace_probe_probe_list(tp), tp.list)
+		__unregister_trace_fprobe(tf);
+	if (file)
+		trace_probe_remove_file(tp, file);
+	else
+		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
+	return ret;
 }
 
 /*

