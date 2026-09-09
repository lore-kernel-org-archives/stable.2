Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96284492E5D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913505; cv=none; b=cEtZuib8fN4iMhqSeOVIw+EQXCGPFp9zJN9OrqFCp14iEDuzOwkzPvUeKy17N5thwlDewNV0SLtJxvzERxU2ZgP1QQ1iCsGvsvrz/viefizoCaJNk21DQzC0tUCR8M3L1chUwDsowkDx7ttOH6Rvtr7AJgStrGjjKqBJFEjLvP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913505; c=relaxed/simple;
	bh=3kdmV5os1VhnoJklLtuD5YisGNo2xTP0uIkQT1hkFnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H4wP7mjFes4Z2Rs5nIRFyXgQbDZIXpEx9xmzZ4utSyBp/FmNYA8fEltTSDvD8Gd8KCxQw9irUNU3QfcwA0nX1qdrlHTfXf2t/DYj3DdPg8rvocuMIkzjLUTXmZrJl+72snApzFcAP/5m5JB0xnqcH76U9PrXVRNmcwGLY0rdSU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2R3bIAd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2R3bIAd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C6801F00A3E;
	Wed,  9 Sep 2026 00:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913504;
	bh=m+FXUuZ0vxh/2g3eT0sc8WaGIf2FQn73+mmvxrY+G0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g2R3bIAdlyHdnYYv1xGuksZG6J8vncS+t8oAFfToj5Ixb+7kUMehQJoahGbQrZ6cW
	 4B6HOM62acRUr1YcpPx4CwjnwHmvuDVDwEKDCdF5Zi2KsRMPAE5En5rwGo5OEs2S/0
	 9sRnsg2RzPEcSWipb/CRq6gUMox8eCDIrL8bgcmObgZfP8Y7XJ2thajrd9zXrj7Hl3
	 4fvKlVGgNrDmsUWM0zHhh76+dupWq+UgSTdWHQoy4tqALuTiHxMoaAmOjLL/cM2M4g
	 LHUQr+pBZ4Cld6+6yw3x+HfwWHye9WtsGB8HaPeV1RlUEgph5KWkstkJCKXdzB09m4
	 cVUiPaj/2VTog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] bpf: Disable preemption in bpf_get_stackid
Date: Tue,  8 Sep 2026 20:25:01 -0400
Message-ID: <20260909002501.724832-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909002501.724832-1-sashal@kernel.org>
References: <2026090359-enhance-frostbite-43b5@gregkh>
 <20260909002501.724832-1-sashal@kernel.org>
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
[ Replaced scoped_guard(preempt) with explicit preempt_disable()/preempt_enable() calls for GNU89 compatibility. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/stackmap.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index 2373b7e3b222a..42bd187ca3182 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -500,6 +500,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	struct perf_callchain_entry *trace;
 	struct stackid stackid;
 	bool kernel = !user;
+	long err = -EFAULT;
 
 	if (unlikely(flags & ~(BPF_F_SKIP_FIELD_MASK | BPF_F_USER_STACK |
 			       BPF_F_FAST_STACK_CMP | BPF_F_REUSE_STACKID)))
@@ -509,14 +510,18 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
+	preempt_disable();
 	trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
 				   false, false);
 
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
-		return -EFAULT;
+		goto out;
 
-	return __bpf_get_stackid(&stackid, map, trace, flags);
+	err = __bpf_get_stackid(&stackid, map, trace, flags);
+out:
+	preempt_enable();
+	return err;
 }
 
 const struct bpf_func_proto bpf_get_stackid_proto = {
-- 
2.53.0

