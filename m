Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72513544893
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788873142; cv=none; b=M3opSqJlny1xiU8e6rv9YmhaKapgqmElLyg1dtkUk1btEnM/9RMDPO4B9QuebcfkP3xv3JZ1MexjV/hQr+388ltSnWzhYstEG/Cf4c9SfDHM5SgeFv/BnjJHCyOVY8CkFWQbTNcQJg604JSimCU/S1yImRRUR7ZTbvEalNzSzLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788873142; c=relaxed/simple;
	bh=q29PK9NQF57CavbDemSfEi9d2mufXnI9PoUnJHpgsFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GrWRkcgeeIVF/wKAttWRY0sgd6XO4bFAmK7Hz8AMVy2H6phe6IYdrqNns+I1n1iZ/84azQjl4J52wVfN/dk5Owj/MVtvhMJOUmKnN8lTXTJYEdDrjLt67MK4gwQb2Xx1bgkhWmVO5mrBqyYwR+6w69V2fn7O4jzYIeMtcPlOL5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFOytHvq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFOytHvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD66C1F00ADB;
	Tue,  8 Sep 2026 13:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788873134;
	bh=6i/ByINDfY2Gvu0Bft5NGuqZL7VTcp04tLiaiAnzpKQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DFOytHvqVRTiML0oH9UNVxvv4azRrH+7dfNX+HCjuqxHyEfGrUVyYy2TjO3vLJbQI
	 HWLF23KMt3HNfuS6NXXl3x7cPsjLi4PxzGyslbnioJBE3Fa52ItM6qhJq/2gjY/3wn
	 ttV+ljSqtRevVmOBzTrL+v25Qi3NJdIbfq6mLAn5n+J7aYdB9oxc7dbbMzDKN/bImo
	 PbB4ASy9SbFRi+MOXuiSH2xu8RHTFbnlAVsrpRO0rPINKHIDyebXpxz0cy/H4eFXC8
	 D65iuckb2J/x0WmKtrsviJ1e549t07p9F+EO0rzQiYJOkbDlPaFpFXPq1CQbEmmMbU
	 n5i9sW+OjMOEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 5/5] bpf: Disable preemption in bpf_get_stackid
Date: Tue,  8 Sep 2026 09:12:09 -0400
Message-ID: <20260908131209.2236373-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908131209.2236373-1-sashal@kernel.org>
References: <2026090347-bodacious-studio-93ee@gregkh>
 <20260908131209.2236373-1-sashal@kernel.org>
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
[ adapted get_perf_callchain() to the older six-argument form ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 0634eaae48702..49ef03ab0595a 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -374,20 +374,22 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 		return -EINVAL;
 
 	max_depth = stack_map_calculate_max_depth(map->value_size, elem_size, flags);
-	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false);
 
-	if (unlikely(!trace))
-		/* couldn't fetch the stack trace */
-		return -EFAULT;
+	scoped_guard(preempt) {
+		trace = get_perf_callchain(regs, kernel, user, max_depth,
+					   false, false);
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

