Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2CD4432EC;
	Thu, 30 Jul 2026 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423900; cv=none; b=rjLL3jffp7HkzNxg1+f/0W7fMG/O/ZeL4SEp9+jX3XdlQmhE+5vQFOygZFjsZ26Y+xYlLKHdrYJe+WD2xZzlDWKTK/dn6kgFqyCmtQsQmU0mneKJjEPRY7MSlQvH5ExbTbDmlIvii1vbazuAp6OmKhNermNnEdm7y0PoVGPSXkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423900; c=relaxed/simple;
	bh=Ka3tWGe7/t12bG1gqNIwjEg/vnPD1h7rJek7NKjk9QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NGw92lJ6wH947OZUW3jaJcIFIdePc1IFmwzsGbtRaRB69/TV/Zk0EtlistazPy2J7ulnbE1OoFVn736Zz8FDgGfTIORUWQbHirRAEEhQttN0oQeJkbbttOqOyqaRj/nI+mcT1z+Pr1jrtsL1HEcP7yzYZbIZ2WAivAyLazDMRyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M1e68+8k; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M1e68+8k"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785423896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ioH8697VNO9CDWA8v8GIsw5lesb+EpXFdUst6lhYL0o=;
	b=M1e68+8k2tKwJD+1U/hYuh7YDdx8fCAd7rzEplFSJtjrkO6oyOQBLdq1BSZxhLwgVg0J2w
	w/d7YCSvndoG+E0JjM26AVxVBKepwXKPQDNWwTMit9DjVP8Rn1DofiNF+R2VX+wGc0zWHS
	VmcKDa7eITRrW9pqP4kj1S6cSVXsiyw=
From: Leon Hwang <leon.hwang@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] ftrace: Protect direct_functions in update_ftrace_direct_del
Date: Thu, 30 Jul 2026 23:04:09 +0800
Message-ID: <20260730150411.88667-3-leon.hwang@linux.dev>
In-Reply-To: <20260730150411.88667-1-leon.hwang@linux.dev>
References: <20260730150411.88667-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Fix accessing the __rcu pointer direct_functions with RCU protection.

Cc: stable@vger.kernel.org
Fixes: 8d2c1233f371 ("ftrace: Add update_ftrace_direct_del function")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
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
2.55.0

