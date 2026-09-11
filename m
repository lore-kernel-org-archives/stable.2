Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAFC4AA004;
	Fri, 11 Sep 2026 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789150575; cv=none; b=VV26Au9RTPCVSR3fOsDUMCjRsJzwkHEqkH062B029Vf1mmaWBvsyd0XcNLYorKPZvt+sEnkIjPswknpOgLJVUP+AMYHQlHqMOD6SYodaUeYP5UXXan9W3BH6hyZqb7JvAZW6RS2ZIfQCEiH8iZ7DimJEUPRvdhdlwUp2cDLFGpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789150575; c=relaxed/simple;
	bh=qYLMiVKK6zjyD8bmH8Esu0n7Bl8j8Sp9pi3Bihw0Fkk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=b5aW8Lxott8zZGNQwXw7hwkgf46vtBqlQdVbluSXHnwn3fViXYrYIiEiGtrwaVIehlZ3NJOZz6deaWsTMT4CqDOp7Ai8Q7XLDD7wRnREQHqxoqxFUIAVr2ELwNIbR4Y2mpxW8eYj85fTK79B+g2Ap8dZ2mQFP2jfW3Vq1d74sZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CnOPVoyt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CnOPVoyt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7BA1F00898;
	Fri, 11 Sep 2026 18:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789150566;
	bh=+nf/HO39DONnuB58jcSRhWKK+JCveE1e662v4bfwgsM=;
	h=Date:From:To:Cc:Subject:References;
	b=CnOPVoythMVBeMBYbw5yxugxvYMT0nHnwUnTPh/qcORd0jizMVGql91ItpAFZEPIs
	 gqTZLmEsDuXrubX4OhZLYa7E2EMoyEtig5WeNhvwqCr2i1pxAGbGSac8QlW1L8rwbQ
	 xMCihn7qQpPxJA02S6vDCSwLoP/eSO3O/NQWeDDrmUb5iLZHwf669NIdM9PYKrwGSz
	 T4xC8GlDe1Zyg2Wn9dly4Z+u4d+U8MFp94QEOn3Fq0/r9UZdIuoQj23tXE+CYLK3D5
	 e7wH4QS1wa4lQNytnFKGojDIswDudJyxhoUgzmd6oVM/eRfVqs73p/ij31oGJknkoy
	 MsSB+xzINloFw==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x55oW-000000094v1-2Ahp;
	Fri, 11 Sep 2026 14:17:28 -0400
Message-ID: <20260911181728.313951151@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 11 Sep 2026 14:16:37 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Henry Martin <bsdhenrymartin@gmail.com>,
 Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-linus][PATCH 01/20] tracing/user_events: Dont destroy fields when event removal fails
References: <20260911181636.485043797@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Henry Martin <bsdhenrymartin@gmail.com>

destroy_user_event() destroys the event's fields before attempting to
remove the trace event call. If user_event_set_call_visible() fails,
e.g. because the event is still enabled and trace_remove_event_call()
returns -EBUSY, the event is left registered with an irreversibly
destroyed field list. Any subsequent interaction with the event then
operates on an empty field list while it is still fully visible in
tracefs.

Move the field destruction after the call removal, and splice the
field list back onto the event when the removal fails so the event
remains in a consistent state.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260904115223.2976446-1-bsdhenrymartin@gmail.com
Fixes: 7f5a08c79df35 ("user_events: Add minimal support for trace_event into ftrace")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
Reviewed-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 93cda2f6f269..f658c3a77aa7 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1122,10 +1122,9 @@ static void user_event_destroy_validators(struct user_event *user)
 	}
 }
 
-static void user_event_destroy_fields(struct user_event *user)
+static void user_event_destroy_fields(struct list_head *head)
 {
 	struct ftrace_event_field *field, *next;
-	struct list_head *head = &user->fields;
 
 	list_for_each_entry_safe(field, next, head, link) {
 		list_del(&field->link);
@@ -1502,17 +1501,32 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 
 static int destroy_user_event(struct user_event *user)
 {
+	LIST_HEAD(fields);
 	int ret = 0;
 
 	lockdep_assert_held(&event_mutex);
 
-	/* Must destroy fields before call removal */
-	user_event_destroy_fields(user);
+	/*
+	 * Detach the fields before removing the call. Removing the event
+	 * frees the field list memory (trace_destroy_fields() is run on
+	 * successful removal and kmem_cache_free()s the fields), but the
+	 * fields here are allocated and owned by user_events. Destroy
+	 * them separately once removal has succeeded.
+	 */
+	list_splice_init(&user->fields, &fields);
 
 	ret = user_event_set_call_visible(user, false);
 
-	if (ret)
+	if (ret) {
+		/*
+		 * Removal failed and the event stays registered, recover
+		 * the fields so it is left in a consistent state.
+		 */
+		list_splice(&fields, &user->fields);
 		return ret;
+	}
+
+	user_event_destroy_fields(&fields);
 
 	dyn_event_remove(&user->devent);
 	hash_del(&user->node);
@@ -2212,7 +2226,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
 put_user_lock:
 	mutex_unlock(&event_mutex);
 put_user:
-	user_event_destroy_fields(user);
+	user_event_destroy_fields(&user->fields);
 	user_event_destroy_validators(user);
 	kfree(user->call.print_fmt);
 
-- 
2.53.0
