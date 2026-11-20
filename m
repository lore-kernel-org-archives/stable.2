Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795196477;
	b=eztKZ+pPTJvkJhLv8a4Cmwm6VMSBnW0BoT+Sx0S92+TAFNyHVJ8FhnPEpr5SNmuHh1AP
	 DmPMQ8vN5kndxy6EIrV7K2GuWFId9pZWBTFAyte71K+WsqqenbzsCLmw1I9f1MfY6zmnz
	 RUnmLyQSwpPEAJ5XhLZjqs5T+09f8XGiyGk6EuSgI/IikhuBkm24gpqCEh56xl84bcl2m
	 GKU2FvMfGmi8OSDs1NnMAnC+JWvYNy4/w8JW7eTfpdbGnJWZMR5hl41MPwbO32qB6F6C0
	 qGtjFye9wOECOVOA+t1MVFb891BxyxyVzDz8EIrUdGLrDxbUFj8GpLNMuwVxwPop+Sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795196477;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=+hivQkWkwsXw6ffnb1JFd6cVa3KGraN+oktHE9qI/eg=;
	b=zkrvkqOINO2jG585vj9ax8pMXbxIk0KRq3YSWvTNycxeEgi/kdj2D1WLRIFqWw8OfL8V
	 2D9h5M+GNk+vrDQUvoOcusxuBcgmG7GwqRkP3lJzvvbrdEx4OVH9rIKKjlll1Z+3a1AvW
	 7cSPRZakDcjEuA38IydDtOFlz8iqepJwMoXGi1Gv3tXEUOz+pOI+xzzfpDpK5O7mLm6V9
	 XxmFF1B2NYSOL34QxDhtIqVjZ0psYONk5idQRy+UkFjL77Pys1YhiYWMCNaCYB1N+dAX8
	 FtPweCbQsOa6ppSw4BnzacdbqRc8YEMPfAL4jXKRsZFob+ddAokVU3XV0dwpWz15Tjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoW25w4y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA3560A3830;
	Fri, 20 Nov 2026 17:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AoW25w4y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1B11F00AD4;
	Fri, 20 Nov 2026 17:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795196477;
	bh=+hivQkWkwsXw6ffnb1JFd6cVa3KGraN+oktHE9qI/eg=;
	h=Date:From:To:Cc:Subject:References;
	b=AoW25w4y4SX919sLbr43k33bF1E8VxqlnyQRPjkaVRyaaOjyk+RWnlGY7Q8nm3YmJ
	 afEz7BqBSeFJPKsjnhhyT2i7rLvAmYrl4RSicaZZ6/hbkCqjsHsiMl6zFLuJHOImDF
	 F4Ypep8mp4QcoEKJL3A8PNuPRW8tJs9n+T93hdPo1WFOyGzFJUDVUaT8WrLAt+Jzb6
	 2AtI/2TliTYZ9o/H+4jIPZzV5OUM54QpzbENzQ7Z3MBKXHg4hphFKRhwblNf8pXKVY
	 fCclZ8ueva7xGKKBzIVRBL6JPJGeumoTtb23oQkIAG2rlWx4DbDhZ1s2NYKvgMynJB
	 CZrgFHlS03fcQ==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xUSbs-00000004aKL-1H4v;
	Fri, 20 Nov 2026 12:41:16 -0500
Message-ID: <20261120174116.138138564@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 20 Nov 2026 12:39:03 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 11/32] tracing/filters: Fix false success return in process_system_preds()
References: <20261120173852.687189370@kernel.org>
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

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

In process_system_preds(), "fail" was initialized to true to indicate
whether any event in the subsystem successfully applied the filter.
However, "fail = false;" was placed at the end of the event loop outside
the error check, unconditionally clearing "fail" on every iteration even
when process_preds() returned an error.

As a result, if every event in the subsystem fails to match the filter
(e.g., an invalid field), process_system_preds() returns 0 (success)
instead of -EINVAL. Consequently, create_system_filter() considers the
operation successful and silently resets the subsystem filter display to
the default global filter message instead of reporting the parse error.

Fix this by clearing "fail" only when at least one event filter succeeds.
Consolidate the cleanup logic in fail and fail_mem by using ret
initialized to -ENOMEM, setting ret to -EINVAL in fail, and falling
through to fail_mem, freeing any replaced filters via delay_free_filter()
if !list_empty(&filter_list->list).

Cc: stable@vger.kernel.org
Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Link: https://patch.msgid.link/179324101176.752804.17624386967710135045.stgit@devnote2
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 32fcc6215d24..a1c298210059 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -2352,6 +2352,7 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	struct event_filter *filter = NULL;
 	struct filter_head *filter_list;
 	bool fail = true;
+	int ret = -ENOMEM;
 	int err;
 
 	filter_list = kmalloc_obj(*filter_list);
@@ -2378,9 +2379,10 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 			filter_disable(file);
 			parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
 			append_filter_err(tr, pe, filter);
-		} else
+		} else {
 			event_set_filtered_flag(file);
-
+			fail = false;
+		}
 
 		filter_item = kzalloc_obj(*filter_item);
 		if (!filter_item)
@@ -2394,8 +2396,6 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 		filter_item->filter = event_filter(file);
 		event_set_filter(file, filter);
 		filter = NULL;
-
-		fail = false;
 	}
 
 	if (fail)
@@ -2410,19 +2410,18 @@ static int process_system_preds(struct trace_subsystem_dir *dir,
 	return 0;
  fail:
 	/* No call succeeded */
-	free_filter_list(filter_list);
 	parse_error(pe, FILT_ERR_BAD_SUBSYS_FILTER, 0);
-	return -EINVAL;
+	ret = -EINVAL;
  fail_mem:
 	__free_filter(filter);
 
-	/* If any call succeeded, we still need to sync */
-	if (!fail)
+	/* If any filter was replaced, we still need to sync */
+	if (!list_empty(&filter_list->list))
 		delay_free_filter(filter_list);
 	else
 		free_filter_list(filter_list);
 
-	return -ENOMEM;
+	return ret;
 }
 
 static int create_filter_start(char *filter_string, bool set_str,
-- 
2.53.0
