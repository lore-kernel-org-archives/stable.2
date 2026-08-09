Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED8B2EA173;
	Sun,  9 Aug 2026 02:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786242739; cv=none; b=b+tMj2Ap15+4Rov3CAyECmxa9h83jCrxfUjFQ3QxOhP9TcTbABuF0PHJ95Wn+iWuCT5EVUp1npNnkULXYQGDjbd2wqMRV9RlD+CpChJ08vk2/EJCdhKWaLoCgJLRlRhrDO62l5ME3+fdrMpnkCub+pzCB5csEYYzNXdV0mrdPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786242739; c=relaxed/simple;
	bh=4tHQQ/TC9Ps5V52OnJO9ZG5HWaloPksoqbBdYg+QS4k=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ebWArXPVUtdFrgfA7OZIrDhLPkh6xxApdUpGGs8tu6kPhzxia+UgNnBuQRzgDJssGcn7E0JPpMuolLhUolNOlGRksYVTPGP/GfhK9oVpEHbIPnRUDJnnsaoGWSRHAUHrFDqHJQPAbmWouhG4Z6TSOZQF1+nSl+cMCVxT0MyUtTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIm8LoBc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIm8LoBc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13AB1F00A3D;
	Sun,  9 Aug 2026 02:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786242735;
	bh=3oqIcwX3j3haPT4xkNNwGbJOelqgOzMzs+rDkN86LB8=;
	h=Date:From:To:Cc:Subject:References;
	b=WIm8LoBcLrH64DCLPxvPojFXT2Gj4wOc1RSZlkH9LQjzVlQmHzZtps2CBd324z/ze
	 u+Gs8jvFQ/AQWHPIRcpypO4cXo4EBMy4HVSt73Odk6NWlOcFaRuFtXHv7bQPKN2fcT
	 oz0cGgrlAxfXwK8Z9UqS/qiIt+hV2lpl5l/7vovBGmA6QbGkcrt7shleAgibiN+HPO
	 RueJRson6BFxQLQUKdKXGrck8FcY82pX8LUeYuhOHMelhGhFhj4D3VIe+FiPFejzBm
	 mZyFjHc71UjLxCpDtvll24elc2ETZ4Hh/AzcbsTrGy4XHL1ImNoA0q7n3KMVgmM7Rb
	 Sy5mfApmuuH5Q==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wstKo-00000001N4h-0fFm;
	Sat, 08 Aug 2026 22:32:22 -0400
Message-ID: <20260809023222.015703108@kernel.org>
User-Agent: quilt/0.69
Date: Sat, 08 Aug 2026 22:31:49 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Jiri Olsa <jolsa@kernel.org>,
 Leon Hwang <leon.hwang@linux.dev>
Subject: [for-linus][PATCH 05/12] ftrace: Protect direct_functions in update_ftrace_direct_mod
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
Link: https://patch.msgid.link/20260730150411.88667-4-leon.hwang@linux.dev
Fixes: e93672f770d7 ("ftrace: Add update_ftrace_direct_mod function")
Acked-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
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
2.53.0


