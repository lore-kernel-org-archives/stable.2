Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED66937F725
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 18:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891652; cv=none; b=cJ6QMt9C9z8eJWFlRh1s9liYXWkCX0MpzX42/UBqqmAIf8JwnVa0ATypDsV9jqvvv77DdJPLDilNFZJA0qNdXPigxj4cP6MzHlsgdpjMD0x51guQj+qaQd48ps3njVkfY7j2ZuqTBZaqDnkbVFG4tpzp2TVc1izWqKNKAh3xxzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891652; c=relaxed/simple;
	bh=L0W1HPoMNTBGs2az8bBBaSc0+/lJgxppuk36ruAnDjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oP7qGnsO7Yq1uaZ2ySo7gZn+97404MTeSEporrQfjXXkS8AI/04uLoiVRCBuuuuC7R2iWGlyKDzelA3IRnXO0ykhC1g9yh9OsiJXI6jRcXijwPr/NGwi0Az4Eo1Ryc/zIQTQ48O8FFExpcRagynq+mvMMne6nNR1ZO6upi3AAYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcLU8bRU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcLU8bRU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CAB1F00ADB;
	Tue,  8 Sep 2026 18:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788891650;
	bh=4g2xpPJWsXhuto5tHCXDhrTuARkdFjrYTQtnLaInUxI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KcLU8bRUV5tijekCYgerCmcETn++JysN3zPto/dUh5Fjrf7YLVsu0hn+UFe1OzrbL
	 /lK9b7snmkgYUCj9B+WSEW87WaJiJvEPDkifjCr6Jjox/zfDT7wRH1aF5nmrVZjjxN
	 6AUGfxoVHCsuE/EDKFbwuP6dOeoEJrUtGhHJ29FagdJDUX2zJia553pySbX7Sm0ee1
	 w5j9hUIp0iCgIA7GTGBMhRtQsk8tfhXSQu201u/NqbzT4YsE5ZUCgc2BAyNhMdQaco
	 rBAZKRI2ad6oh4d5+k4BYayNFbzcy9vtwC2kgLqjsm/p+5gGldg7lth66uF8fgFhqB
	 N3ACuFtFaDfJw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] bpf: Disable preemption in bpf_get_stackid
Date: Tue,  8 Sep 2026 14:20:47 -0400
Message-ID: <20260908182047.200457-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908182047.200457-1-sashal@kernel.org>
References: <2026090354-evolution-kitty-6754@gregkh>
 <20260908182047.200457-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Olsa <jolsa@kernel.org>

[ Upstream commit 15f1bd8574662f1b7b26aaa2e23ebf4066f0117d ]

The get_perf_callchain call needs disabled preemption plus we need
it disabled as long as we access its returned trace entries buffer.

Note the bpf_get_stackid_pe function is executed already with
preemption disabled.

Fixes: d5a3b1f69186 ("bpf: introduce BPF_MAP_TYPE_STACK_TRACE")
Reported-by: Tao Chen <chen.dylane@linux.dev>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/bpf/20260803210149.296496-6-jolsa@kernel.org

Closes: https://lore.kernel.org/bpf/20260206090653.1336687-2-chen.dylane@linux.dev/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 7d316386a7480..ef5102d0bf5a3 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -378,20 +378,22 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		return -EINVAL;
 
 	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
-	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false, 0);
 
-	if (unlikely(!trace))
-		/* couldn't fetch the stack trace */
-		return -EFAULT;
+	scoped_guard(preempt) {
+		trace = get_perf_callchain(regs, kernel, user, max_depth,
+					   false, false, 0);
+		if (unlikely(!trace))
+			/* couldn't fetch the stack trace */
+			return -EFAULT;
 
-	err = stackid_fastpath(&stackid, map, trace, flags);
-	if (err != -ENOENT)
-		return err;
+		err = stackid_fastpath(&stackid, map, trace, flags);
+		if (err != -ENOENT)
+			return err;
 
-	new_bucket = stackid_new_bucket(&stackid, map);
-	if (!new_bucket)
-		return -ENOMEM;
+		new_bucket = stackid_new_bucket(&stackid, map);
+		if (!new_bucket)
+			return -ENOMEM;
+	}
 
 	return stackid_install(&stackid, map, new_bucket, flags);
 }
-- 
2.53.0

