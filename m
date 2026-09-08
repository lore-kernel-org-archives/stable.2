Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3AE355F22
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788883298; cv=none; b=CSOYhaNLtDr7sTSUK49T7breut7b2mMgkjmxc2G51lzNlmnKKr0uaA/RXjaDE/KgXhJhw02Q/fZVcnPHxCiciRkEcAqcrg30L5fFPNZiEyjOPsr/jlRV6kgYPsIyYV2HdAVKk8CsqWvQqjLZvOSqVemVsFMcO91mKDvPUGXAKjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788883298; c=relaxed/simple;
	bh=pB+w7h7ZmfSzfKMAikSqDWKJHSwvWPZCVp0j13ggCAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPAGa/GS42ngcbsW91xlCXyKWOklHAeBRqnqiOGyawbpIm2wWNbQRorW8Bgn00eKqaPjAitrz2glimpGla1vH//QIEOTO3u6Pz4BAKEL5PwCXdBN0ExicJMkPU2AiMCwbW/uexM2qwwPNv3XCbpYpt6KGGxeRsgT6Kz6bZVRjd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzEO11BX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzEO11BX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DF21F00A3E;
	Tue,  8 Sep 2026 16:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788883296;
	bh=erNiyDyJ84H0S2L3SCOajkCdi8tNT16VUTba4X8y9to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LzEO11BX1xAixIx0W3nKmI1XFsvKrbYL3ubuxgSZl/xmq16KmhD4npP1Z7Np2Xawv
	 2UOLptQ1PyqKyaw0vvnojzHM+pjX2A5DbdTqMmlGXzlqlV6Qs4dEYR71LRHxmAaASA
	 5dEq1acZL7u//mEtMphm6hu0u72c8F6hujFXUYoDvj0yqtTJ41/mi+ovoRyoPelmeX
	 5PlmqigYqWjpQ2TBO+E5CYf7U2TgUXjZJ4EuGL3/Y9MoVHVVeZcnavMDV+ekJGijBS
	 8N/pdhL0AqwJkf6anqWmNogj3ljC/oS084cEBEh7EK+uP/rAlqfOsg/qdPxg86MTtn
	 1NJUKYgjSVUGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] bpf: Disable preemption in bpf_get_stackid
Date: Tue,  8 Sep 2026 12:01:33 -0400
Message-ID: <20260908160133.2548881-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908160133.2548881-1-sashal@kernel.org>
References: <2026090352-pry-antelope-9018@gregkh>
 <20260908160133.2548881-1-sashal@kernel.org>
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
index 2081e62c4dc63..152639c55a1a5 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -370,20 +370,22 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
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

