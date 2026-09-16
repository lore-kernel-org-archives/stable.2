Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69662529403
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580112; cv=none; b=HDSOkfyNeZfUvjiqgIL+tONHuzLSRuoa1Ui23I4OM1bmcaMa0RWAgTkQ3uIF6A5MzaYVjNt0ReQ6LV5VOauRDi4Pp8Rhs4mUA+znAo7xdhBPdQBoB9K5Njpxnkf2ndHxWIArZyhyv5l9PznPG4Y0MC7xbLoc+gcByrU+Be8dLfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580112; c=relaxed/simple;
	bh=KWCpG34KyqAnvyuRqbNnwyRXDlC20SikAHO8mzPoWQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJq6ekcgISqM4rCfp4ZtgRAir1CCG8VOIqfbF1gB04k3j3VIc1pu2sDI7HHVc2PDCP1hucbj28kUWH0ehtumphXDSfa+H+TpHfRjL2u51OYstqSIFXzfOgVtWfHKLj7QlZZU9uySuHR1tHYuoIfI7j9MS6aCIvbzFO1zx0bpCjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AOcLYAdK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AOcLYAdK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CEC1F00899;
	Wed, 16 Sep 2026 17:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789580109;
	bh=ig9KDk5xY+NfQL06sm+eOH4YHYtF3rR1wssIeJsTK3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AOcLYAdKxHkenmMRdJkkicntTaGN6dvkx+SimrUetiX/RRsC+IDRfDu58zzcSCps6
	 Z/FfvujgBxCYNxcxdzdo+6rAh+C3eftQLTVuNm6eP/t3cTZ0ACcQimWU7uzDo7S6PG
	 RPtjbcmevjhhpQIVD32v+7sKZRj7RikzWBrXtW24i28UiD0c+QmVHrn0JTpUt2RTCE
	 jW/bbm9pm7FeFFXXA2WdOEeLWzf3m4wtDns9YHmB+khpuKEPrpdPSfaG74IrSHXOk8
	 qFLrOCpAbv55r4TOFma6hVzVY/vzuKvzR5mrFNvFst6rZR62u58blnUrU7yGJo1v/0
	 dJQ0fkmTRhXaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henry Martin <bsdhenrymartin@gmail.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] tracing/user_events: Don't destroy fields when event removal fails
Date: Wed, 16 Sep 2026 13:35:07 -0400
Message-ID: <20260916173507.1134396-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091633-hardening-washed-5fd8@gregkh>
References: <2026091633-hardening-washed-5fd8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Henry Martin <bsdhenrymartin@gmail.com>

[ Upstream commit 2deb753127d7b7035e893955c5e91875e767d1f8 ]

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
[ Adjusted context for the missing lockdep_assert_held(&event_mutex) in destroy_user_event(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_events_user.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index bff699fe9e712..6186474c027fa 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -430,10 +430,9 @@ static void user_event_destroy_validators(struct user_event *user)
 	}
 }
 
-static void user_event_destroy_fields(struct user_event *user)
+static void user_event_destroy_fields(struct list_head *head)
 {
 	struct ftrace_event_field *field, *next;
-	struct list_head *head = &user->fields;
 
 	list_for_each_entry_safe(field, next, head, link) {
 		list_del(&field->link);
@@ -821,15 +820,30 @@ static int user_event_set_call_visible(struct user_event *user, bool visible)
 
 static int destroy_user_event(struct user_event *user)
 {
+	LIST_HEAD(fields);
 	int ret = 0;
 
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
 
@@ -1360,7 +1374,7 @@ static int user_event_parse(struct user_event_group *group, char *name,
 put_user_lock:
 	mutex_unlock(&event_mutex);
 put_user:
-	user_event_destroy_fields(user);
+	user_event_destroy_fields(&user->fields);
 	user_event_destroy_validators(user);
 	kfree(user->call.print_fmt);
 	kfree(user);
-- 
2.53.0

