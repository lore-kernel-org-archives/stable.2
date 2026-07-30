Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92ECF443E40
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785423904; cv=none; b=ECfZzFQykqZC+QtCCNx3RA4BLh/nggvUo9EEkHwb6St6toR/OfGndytcOqM6zHr2neg6934+KOtLq+fRYMhbGi3d8zdh3SXpZwBCgMC6r6PyHhAm0h6iGuesb32NkBzhEmneThb1Kh3wqEqSkgWm6lj/YSVOAW7DepybtUmj8f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785423904; c=relaxed/simple;
	bh=E60ym5ihyuUjZe+DUyHDaCpBRd8cyAyERRa3qBMwUEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7SNzJZy8xv6umVwHN/7hGCSxWG20aPsQpgy4h49JE6TOQNv8BjthZLwcYwZr/TL9oBR+Uje0y4bi5v9e0f033VbtAGQNykLIfzclbhNGd6IxCBkl8fZAIY67vnXGVH/Tu3KOIeuO2PC9LmoAzQzYNzKth9ZeTLUWAC9ZnIB5GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HbQgLt4V; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HbQgLt4V"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785423899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dsE2kELMPKSph4gWvp3ET+y59gkwCkJ/7ot3HF3rB5w=;
	b=HbQgLt4VNe4Shlo35BVIkTz2JepfQbjoYw3E5j+Pijk5c0HsrqwYdLG2tHO+y/ApECuj8G
	5HPwnlQ9ceb5XTqG9ZmXZ0NrJL81a4R7ehL59LgAkr6CG0CGepRIOGXtpIAqIkKsZoc6mF
	7qomyJ9WyxgxfkQnJzoDC8owTM9NPqY=
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
Subject: [PATCH 3/4] ftrace: Protect direct_functions in update_ftrace_direct_mod
Date: Thu, 30 Jul 2026 23:04:10 +0800
Message-ID: <20260730150411.88667-4-leon.hwang@linux.dev>
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
Fixes: e93672f770d7 ("ftrace: Add update_ftrace_direct_mod function")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/trace/ftrace.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9ea39110927f..414e425c2d80 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6617,6 +6617,7 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 		.func		= ftrace_stub,
 		.flags		= FTRACE_OPS_FL_STUB,
 	};
+	struct ftrace_hash *direct_hash;
 	struct ftrace_hash *orig_hash;
 	unsigned long size, i;
 	int err = -EINVAL;
@@ -6627,8 +6628,6 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 		return -EINVAL;
 	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
 		return -EINVAL;
-	if (direct_functions == EMPTY_HASH)
-		return -EINVAL;
 
 	/*
 	 * We can be called from within ops_func callback with direct_mutex
@@ -6636,6 +6635,12 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 	 */
 	if (do_direct_lock)
 		mutex_lock(&direct_mutex);
+	else
+		lockdep_assert_held_once(&direct_mutex);
+
+	direct_hash = rcu_dereference_protected(direct_functions, lockdep_is_held(&direct_mutex));
+	if (direct_hash == EMPTY_HASH)
+		goto unlock;
 
 	orig_hash = ops->func_hash ? ops->func_hash->filter_hash : NULL;
 	if (!orig_hash)
@@ -6667,7 +6672,7 @@ int update_ftrace_direct_mod(struct ftrace_ops *ops, struct ftrace_hash *hash, b
 	size = 1 << hash->size_bits;
 	for (i = 0; i < size; i++) {
 		hlist_for_each_entry(entry, &hash->buckets[i], hlist) {
-			tmp = __ftrace_lookup_ip(direct_functions, entry->ip);
+			tmp = __ftrace_lookup_ip(direct_hash, entry->ip);
 			if (!tmp)
 				continue;
 			tmp->direct = entry->direct;
-- 
2.55.0

