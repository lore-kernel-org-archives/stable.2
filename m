Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C68A3A9624;
	Mon, 20 Jul 2026 08:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784537688; cv=none; b=KxxWnmnLxXsEreH/Cqc7TNGl4qXqyy31qHdB1vcBUrYvraRpKJ4D9QE1tJte+qig1gqf5yAL/MEQuNuS9P8dWGPNPsVi5ftkmkUBjO6D3vx7/bqu3Pj5hSNZiz5ThRPQV7LlkKIat9Gbtf3x2KVuvvgIJh0M4p5c+wJbbL6yaUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784537688; c=relaxed/simple;
	bh=ER4h41nxh8wOjXQ1MeCGfCWy8bVkDsfbe9Wje8dQ3sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lOJPxHE742XZQUS+35xYtQiIL33IXZYc9nRFOm/JnQv4suKYMtviBPT9UrExK9gXh+WWkpNP8Ke8eL7UDVQ6w53KkWZ78Q+LgBcSoNC4Tvbbs5NPMs6a4r+69XWeMQG0i5dvjA7UGK+WKnVNG+mXnUqEev1g3GtOHeLHtfKPXkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhDzV2UF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhDzV2UF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9321F000E9;
	Mon, 20 Jul 2026 08:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784537686;
	bh=fup5XMJ6sgb5lXCta8odLe0ofoInKtEBXBWu3QUMy3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HhDzV2UFaZ+VCm5IHOFQVbwGmrbdqIHhvxQJVBgqxFBa1RUCcltaUdELdpl2+d9oL
	 oiR4YELsB2kfQU+4VSXn2vfODPSPTZ4ZZGYRw7NRaNWMWAXtdsEOsNuCoD0e67WPcY
	 CuvU7TS2VPrVu4HCnFrke7/e/u0OijUka+zM9cnH3nGc64SNmrLAodsfteh5kTN2xo
	 LjfnzuCGCoPmfJ+mmZ+1vqKXIjXBQomDk4K9Wfd7JR7dzDP13btP1iX1Eeuo4rtBSL
	 TVlAzfQtKQK9kXxhbnPL2ivh2EgztodCse6ouRTvNB0P6RVEgzm/ZWFRfR5crFQ7Tc
	 2Vt7G9Cf4bptw==
From: Jiri Olsa <jolsa@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: stable@vger.kernel.org,
	Tao Chen <chen.dylane@linux.dev>,
	bpf@vger.kernel.org,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	Quentin Monnet <qmo@kernel.org>,
	STAR Labs SG <info@starlabs.sg>
Subject: [PATCH bpf-next 5/9] bpf: Disable preemption in bpf_get_stackid
Date: Mon, 20 Jul 2026 10:53:47 +0200
Message-ID: <20260720085351.655075-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720085351.655075-1-jolsa@kernel.org>
References: <20260720085351.655075-1-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_perf_callchain call needs disabled preemption plus we need
it disabled as long as we access its returned trace entries buffer.

Note the bpf_get_stackid_pe function is executed already with
preemption disabled.

Cc: stable@vger.kernel.org
Fixes: d5a3b1f69186 ("bpf: introduce BPF_MAP_TYPE_STACK_TRACE")
Reported-by: Tao Chen <chen.dylane@linux.dev>
Closes: https://lore.kernel.org/bpf/20260206090653.1336687-2-chen.dylane@linux.dev/
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/stackmap.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 83efd5892d90..a64b14ffd1e8 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -625,30 +625,37 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	struct perf_callchain_entry *trace;
 	struct stackid stackid;
 	bool kernel = !user;
+	int err = -EFAULT;
 	u32 max_depth;
-	int err;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
 		return -EINVAL;
 
 	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
+
+	preempt_disable();
 	trace = get_perf_callchain(regs, kernel, user, max_depth,
 				   false, false, 0);
 
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
-		return -EFAULT;
+		goto out;
 
 	err = stackid_fastpath(&stackid, map, trace, flags);
 	if (err != -ENOENT)
-		return err;
+		goto out;
 
 	new_bucket = stackid_new_bucket(&stackid, map, trace, flags);
-	if (!new_bucket)
-		return -ENOMEM;
+	if (new_bucket) {
+		preempt_enable();
+		return stackid_install(&stackid, map, new_bucket, flags);
+	}
+	err = -ENOMEM;
 
-	return stackid_install(&stackid, map, new_bucket, flags);
+out:
+	preempt_enable();
+	return err;
 }
 
 const struct bpf_func_proto bpf_get_stackid_proto = {
-- 
2.54.0

