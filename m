Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795639269;
	b=1veuHT8q/4LRL3fVpISM0sIL1hzCTm2Gsv8wfIDVi/XXe0c0/geev2it6vSiiC3R+PCm
	 PthgG3I4/hE9woiToNYTNzb3fiHKIQkMG6yTjmoDWCaTcDOje3JDhB8HKR97/vuIh3whO
	 2iP3Dj4OUAROwNJ8ezx0k22w1HUAhAQFtvXdZ8G5zDCrhGL5bUTQZSPMicTVe8NZaGSeB
	 yQciOXIDv2QlM5FbqTWv2j+E2vXBNcG0c+s+x0CPiN6reamJlJq3SViHb/k9zb/qtbD8z
	 nwnympQ6JAkCXisJApwwJ1sOIZCwhAIWyARCTOsrW+GXQnQBum1KEk1FHcQGmf7b6gQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795639269;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MjxxBFV/4nj5aIsNKxAnxMYGBYsh53kEsmBn8WIGCCQ=;
	b=N2GsPFijEpLxu6apxUoXlXWCGjwtnvOez4LZXrz8p629peNHsq03KFCQXBn8+CrhEgYN
	 pi6jFU9BTis80110zHzl0NXtpvpcEYTLh2bAupGvLA5txLJOov0PA6RX/4U20gcglk8+B
	 +VdG50i53firMGE2v6LiGcq1RdjfG5ea2GGvCgjhvB974t3UMfdt/iNSnNh2BGfhI76A6
	 1g0y6OgGInvA41ULrUI5mOB5KvtXqEC1jKaC09DqwpvBlbAvYg13xiXGSPLeFFyTiaTjx
	 70/CFnYHfWNWHzSzELtHua7Q6DfLx8ZduQlUM4YS6mozXWaxpm59wwqkviycuk8mjMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrTb7vg6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A1F606A330
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IrTb7vg6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E8B1F000C0;
	Wed, 25 Nov 2026 20:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795639269;
	bh=MjxxBFV/4nj5aIsNKxAnxMYGBYsh53kEsmBn8WIGCCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IrTb7vg6qG0lBA+NJf1/QUVmvb6PlrqNINoT/Q7J1uMeb8s9O6WwrwoF9RbA4SzQ1
	 8dX+O4mb4FpRkW+vVyolcyseCj5Z+FtLMYgjTTwdmQeSxlwx5oJ/mlTA8X0ldYEHAx
	 2pDWuxCi5AH1Z3OtbCzJfZqFC9pVqdM7XvTl837ydJHTFAah4ivykcqGKcs56ctVzf
	 Ru7r+H6K5icBaPh+kKbo6cHEKY545CNYpb9cUxRZmZvs9wPw5nNwd+2urS24B0z2pO
	 CY3e4KZkGrpAmhp733Ilc9dPxNLgEl7Tat1bowNfMkIoDjROqIuG6mKmth4bD1M19c
	 e2+GauWwSwUzA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] tracing/probes: Reject array count on non-dereference string sources
Date: Wed, 25 Nov 2026 15:41:07 -0500
Message-ID: <20261125204043.1436730-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112523-sacrament-magenta-9e1e@gregkh>
References: <2026112523-sacrament-magenta-9e1e@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

[ Upstream commit 0941144ebeaf3ce46c80711f00e935921eb28b21 ]

The runtime array loop (FETCH_OP_LP_ARRAY) for string types requires a
preceding memory dereference instruction so it can advance the pointer
address on each iteration. Non-dereference string sources such as $comm,
immediate strings, and eprobe event fields cannot be indexed as pointer
arrays, but finalize_fetch_insn() still accepts an array count on them
and emits an invalid FETCH_OP_LP_ARRAY sequence.

Reject string array counts when the preceding operation is not a memory
dereference.

Link: https://lore.kernel.org/all/179455855309.403392.4197028577158545202.stgit@devnote2/

Fixes: 40b53b771806 ("tracing: probeevent: Add array type support")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
[ sashal: Added the same six-line check before code++ in the string branch, using goto fail and the ctx->offset + (t ? (t - arg) : 0) error offset because the refactored helper and type_offset don't exist here. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/trace_probe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 4265518ce967c..b88ca1559aa2b 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1413,6 +1413,12 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 			 * For the symstr, it doesn't need to dereference, thus
 			 * it just get the value.
 			 */
+			if (parg->count && (code->op != FETCH_OP_DEREF &&
+					    code->op != FETCH_OP_UDEREF)) {
+				trace_probe_log_err(ctx->offset + (t ? (t - arg) : 0),
+						    BAD_STRING);
+				goto fail;
+			}
 			code++;
 			if (code->op != FETCH_OP_NOP) {
 				trace_probe_log_err(ctx->offset, TOO_MANY_OPS);
-- 
2.53.0

