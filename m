Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2760157F747
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 22:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907007; cv=none; b=tTyiN+ZiVJSixjYJSJ/KsbcexKlMUyKw9oPwm14CN+QXJLNWu+A2AoVWuVQN6njtPiTcEeKn8S60pw007idhfZtVCE7WHBtU8k5vMxqpwLG/bYhaFHA//Jx6Ch7pDmprK4IaVy//VTi+xZbUrkZhXeiSXIn//2EFfprcJz3UwdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907007; c=relaxed/simple;
	bh=EF0+a4hzDEUu6B4wEUAOFjmGgeKk/3t1PPufSyFuR4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pE56XzgsqOzCM32WJ470B8BVOXqlTLMDiV+yYRiBC8SEMEoPqYmxJ7n+KM7BhwSEm4mFMg+H0jGrdxqZr5jziRDhkhWDuLqzD5XuesX0r5ik5Q9e/6BshDL2Hj+4kHIfwKm++cOQx0NxrCsBCUk/M+1FLfstL69s2qjYshya/Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GcRF/XHv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GcRF/XHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0ED01F00A3D;
	Tue,  8 Sep 2026 22:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788907004;
	bh=q5fY67EB41RtvkqaTnaFFTtNBiXxWk9Efm3sl9vMi/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GcRF/XHvCc4eoKfIZ1H8QWtQNYhWK9B5PzmnX8bZd49V6KmBkKWxL4B3l3eHFzXvy
	 MKNWX0ugj58x2MZf1AYDnGd4Fc+bA5W4iubX1SJ6Tm9ZBShj6+Zl+oMC9IrSObLQPo
	 01Q92XqZFMbzNYq5sI8tQdt4/8v5n8ylPLxfZmm3rGMXx3VQheLP0/cOHkSq/Qwoei
	 b0zhE0QmNe/cGm/xpfzD9+Av0SP5dPutqKYtYFzqZ17cTLnz6Z+V3Ms6QmSa2poB5+
	 2ECIvntPfe/JSiknyJwrz7ITZvf+/nu9a9lOWg5AhpuZJESy19lmtSM9Ge+mqdLPbh
	 rpqK6Sq8TVhZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] bpf: Disable preemption in bpf_get_stackid
Date: Tue,  8 Sep 2026 18:36:41 -0400
Message-ID: <20260908223641.501474-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908223641.501474-1-sashal@kernel.org>
References: <2026090356-only-legend-2a89@gregkh>
 <20260908223641.501474-1-sashal@kernel.org>
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
[ replaced scoped_guard(preempt) with a nested block using guard(preempt)() for GNU89 compatibility. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index c91e6ffa99dde..056acad851a6a 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -412,20 +412,24 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		return -EINVAL;
 
 	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
-	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false, 0);
 
-	if (unlikely(!trace))
-		/* couldn't fetch the stack trace */
-		return -EFAULT;
+	{
+		guard(preempt)();
 
-	err = stackid_fastpath(&stackid, map, trace, flags);
-	if (err != -ENOENT)
-		return err;
+		trace = get_perf_callchain(regs, kernel, user, max_depth,
+					   false, false, 0);
+		if (unlikely(!trace))
+			/* couldn't fetch the stack trace */
+			return -EFAULT;
 
-	new_bucket = stackid_new_bucket(&stackid, map);
-	if (!new_bucket)
-		return -ENOMEM;
+		err = stackid_fastpath(&stackid, map, trace, flags);
+		if (err != -ENOENT)
+			return err;
+
+		new_bucket = stackid_new_bucket(&stackid, map);
+		if (!new_bucket)
+			return -ENOMEM;
+	}
 
 	return stackid_install(&stackid, map, new_bucket, flags);
 }
-- 
2.53.0

