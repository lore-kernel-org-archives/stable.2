Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F02D9484;
	Sun,  9 Aug 2026 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242737; cv=none; b=TyWajyd4qS7Uz7F0NOuY7e9ASTnAf95grv02oKySbr/GTgmVX/HwFyM+WiQR85ctKMgoAeVKTbXdkfhKiXwSDv5v5kG9escUhpbTA/EXh/5JnrIiN89lDlvHD0lUvJc+9rCmpapr5jiiFAofqlj+749bFcXvHFmekx4dNU6KLO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242737; c=relaxed/simple;
	bh=oiqWJDC2i3077dMUP6JnqZ64oRUCFp35NaNbNec2s6U=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=b8aYcXJtvjjnJQmKywKthe3TAbCmCQSxH61dOgZ26kYqbl3mBZ2n+Lgq4wS7WYHpbjQHuFphiA+A6emkGqtrf3msRxpnR070Sf9Nwmg8eGlhC9Ftg5sMVj3goWr2irUFamoZ0IK3DGv/OkVGPlTIU6mvAguc5Bf8z9EX68+1xN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVbK13Ow; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVbK13Ow"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5871F00ADB;
	Sun,  9 Aug 2026 02:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242735;
	bh=PGNsOxfqDTW8bFGdBdNdVIBp6Eh0qzmzMbRY+9D8jJc=;
	h=Date:From:To:Cc:Subject:References;
	b=YVbK13OwH0iis+bCQhTOas5moKgfbeKqTezJe3A3WWK+H2jrOLwXpEloj3U6Eq6vr
	 FS+f0RROLAn+YanT1P4kMZWqn9+AjjhoyPZHmE55syMy8DVc+1ZfgeLGQaHc/Ku2TP
	 csIbIZtydQRREF7pZBGk85g+zfwWI1TpifHN6pyCWu38HbJNu+rdXelnS2y0JMkvGe
	 zXSJeySqDwhmSTOMNVcJJcFqCxVjbPs8JDZ5p2a1sv7XFDW+juprI3J0dRtDBOq1FE
	 TndFR6KuTRSawT5lOxcUgWwQNzVQ6+h5ZpJ2G8ZKG3FefRfW8aheLLbiX8ncaN6wuv
	 SADX57NkWDs3g==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wstKn-00000001N4D-4BNk;
	Sat, 08 Aug 2026 22:32:21 -0400
Message-ID: <20260809023221.854869492@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 08 Aug 2026 22:31:48 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Jiri Olsa <jolsa@kernel.org>,
 Leon Hwang <leon.hwang@linux.dev>
Subject: [for-linus][PATCH 04/12] ftrace: Protect direct_functions in update_ftrace_direct_del
References: <20260809023144.852271250@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Leon Hwang <leon.hwang@linux.dev>

Fix accessing the __rcu pointer direct_functions with RCU protection.

Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260730150411.88667-3-leon.hwang@linux.dev
Fixes: 8d2c1233f371 ("ftrace: Add update_ftrace_direct_del function")
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c5d1d0d42ccc..9ea39110927f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6512,6 +6512,7 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 	struct ftrace_hash *new_direct_functions;
 	struct ftrace_hash *new_filter_hash = NULL;
 	struct ftrace_hash *old_filter_hash;
+	struct ftrace_hash *direct_hash;
 	struct ftrace_func_entry *entry;
 	struct ftrace_func_entry *del;
 	unsigned long size;
@@ -6523,11 +6524,13 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 		return -EINVAL;
 	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
 		return -EINVAL;
-	if (direct_functions == EMPTY_HASH)
-		return -EINVAL;
 
 	mutex_lock(&direct_mutex);
 
+	direct_hash = rcu_dereference_protected(direct_functions, lockdep_is_held(&direct_mutex));
+	if (direct_hash == EMPTY_HASH)
+		goto out_unlock;
+
 	old_filter_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
 
 	if (!hash_count(old_filter_hash))
@@ -6537,7 +6540,7 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 	size = 1 << hash->size_bits;
 	for (int i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			del = __ftrace_lookup_ip(direct_functions, entry->ip);
+			del = __ftrace_lookup_ip(direct_hash, entry->ip);
 			if (!del || del->direct != entry->direct)
 				goto out_unlock;
 		}
@@ -6548,7 +6551,7 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 	if (!new_filter_hash)
 		goto out_unlock;
 
-	new_direct_functions = hash_sub(direct_functions, hash);
+	new_direct_functions = hash_sub(direct_hash, hash);
 	if (!new_direct_functions)
 		goto out_unlock;
 
@@ -6575,7 +6578,7 @@ int update_ftrace_direct_del(struct ftrace_ops *ops, struct ftrace_hash *hash)
 		/* free the new_direct_functions */
 		old_direct_functions = new_direct_functions;
 	} else {
-		old_direct_functions = direct_functions;
+		old_direct_functions = direct_hash;
 		rcu_assign_pointer(direct_functions, new_direct_functions);
 	}
 
-- 
2.53.0


