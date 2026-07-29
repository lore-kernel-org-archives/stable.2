Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EB03B3C1B;
	Wed, 29 Jul 2026 08:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314342; cv=none; b=Cl5ojN9SUWrtsX49u13H6VCWCO/wpLnXid/o8sxtIGwLfTebTami3BCrsKnkCPcooMG6xQS6Nz31S8rpQrbWtwrmOkCLHVaResqF398C/f3uHn6yDz0bRF0JAsERBEFRT9og1h/too/3f59a3eBZgk/0RoXHQNo4MX2Hxt+/8+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314342; c=relaxed/simple;
	bh=Zzn8/d4hNjykzc3sXEh25uHHiYsPJvqM1wzUmErM9WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pp5kFDcjowQ+l6LmUQXFTkThPYjxlCMo/8NJKWoZN5iwoe6BaoHwI8c7dMe+caOo8nOrJ9CLeHPzC4bAuvRlX01VO4SV9NcbyYo2sPdDK6wEFETUKF2Ug9a0+QuR8RVbwFTfrpUZcG3xE07aXZGD2T5Rfsbz1OMsIqDEwpRqLvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JS9nNeUL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JS9nNeUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692C71F000E9;
	Wed, 29 Jul 2026 08:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785314341;
	bh=5Q4UGzlomPFCPXamNt/pAQ8sQGZroXdo1OK+O4aRSJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JS9nNeULK7VoXVAJlMo70gUUgC6LKKluk9iGdmF3aLalNOmheW+z2aDSnlorx9gYj
	 YbNHlsfbZKk4DLlBLRJpP84+roA6W1Y2dthit4vBCqt/6TFCaiq0Sq8x1siHm2ieBF
	 yHshvN2Fi9LXDar0HTyu8eMhRzQU2hIC4vv7u6WQNgBn7NH2JUIkTgFen+X/XkUdjE
	 j2xETn4FgoCWfMpvwCNPMgABPs9YvDrlWrxqPCB5Be5YQkx6KplskaTO2h2CXh/hMt
	 kAoGN7M5YRB4YgdC03B+xGVhfUN5pJUoNq7WeH/TCxieDVaD6cNZyN3D1JWDVv6bxx
	 bLYAFRq9Oc0WQ==
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
	STAR Labs SG <info@starlabs.sg>,
	Arnaud Lecomte <contact@arnaud-lcm.com>
Subject: [PATCHv2 bpf-next 05/11] bpf: Disable preemption in bpf_get_stackid
Date: Wed, 29 Jul 2026 10:38:01 +0200
Message-ID: <20260729083807.1588544-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729083807.1588544-1-jolsa@kernel.org>
References: <20260729083807.1588544-1-jolsa@kernel.org>
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
index 43b1e5436047..e48ddb4edd47 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -624,30 +624,37 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
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
 
 	new_bucket = stackid_new_bucket(&stackid, map);
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

