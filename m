Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B00F3AC0E4;
	Fri, 14 Aug 2026 20:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786741198; cv=none; b=UjGs/ZXlYuimyQg4MATT2GmWGNx6PDRkMX7GabAVJ21FHI5YLnn1r4ztQSYpowm06P8yOzqdTi/eQyKyA7sdyhEOAteUBJN/MzIgoxhTmGNnIv82OIpjgFHZWEfU/dyObeY7fEizYkTgfGCLr4x6YkL18dFdAr/7ZTIB1HD2F7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786741198; c=relaxed/simple;
	bh=cMg1Q7GRBqNbHXc7Qy12PM98vMkr0pekGWvr/PWcShQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W1vtdnyNlRR33Y1enfzsveaWryiLZtidrPGz2sc9oPy+KsuTM7nFB2LuqJ0DSPgZceDe6QdyTSTRuEoIIBWlqDwjaGc+m5MkCVgbTyjsjjSis9e9nv8S7iQgtiZdsCQhF7OYibbb6du45iTfz18CVj2DUGi0v+BAbbwbChu7NlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDdqiGau; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDdqiGau"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7544B1F000E9;
	Fri, 14 Aug 2026 20:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786741196;
	bh=XfZ3zvAf48nrw/U1UbvjPQIbhDynwPIlnx3hYV4qDhQ=;
	h=From:To:Cc:Subject:Date;
	b=QDdqiGauhUDv5nSdHJmwJZurSLfgK5AgXbu7FVxNBleTYlx0dvtLGxWGnp5Zr2wXa
	 zgSL9g9su7byvdZ168lXqRslJ1PZdTiqnR+Bv7mfandtEOaJy9ZGg9/YDn0fhtZT7U
	 qTdI7H4nMC4XE84a442CTf6XEp3pmuE0ZtwBAkrBU0nDzjFiUuZtGnDie/OO5B9Iob
	 WG7XCRTvjw2auGgt2R/61zj/MYPZCR6uxRk6+xmX0ooJJK3ycNIpZ/prjgQsRMmJv/
	 g8gjd2yL/f6dEZJF7/qgPXOuiPkNarTKZQfIyFSY7pRNMSd9fuKB8Ob6Rr6a+sBjUN
	 Wf09nsXhG8g3g==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH sched_ext/for-7.2-fixes] sched_ext: Fix scx_bpf_dsq_reenq___compat kfunc extern prototype
Date: Fri, 14 Aug 2026 10:59:55 -1000
Message-ID: <20260814205955.3490381-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_dsq_reenq() is registered with KF_IMPLICIT_ARGS and its kernel BTF
prototype omits the trailing bpf_prog_aux argument. The ___compat extern
declares the argument explicitly, so libbpf never matches the prototype and
the weak extern silently stays unresolved on every kernel. The wrapper
always takes the old fallback path, which disables generic reenq users like
scx_qmap's lowpri mechanism and fails non-local reenq with "kernel too old"
even on kernels that have the kfunc.

Drop the explicit aux argument. Also correct the stale v6.20 reference, the
kfunc was added in v7.1.

Fixes: 9c34c5074d1b ("sched_ext: Introduce scx_bpf_dsq_reenq() for remote local DSQ reenqueue")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 tools/sched_ext/include/scx/compat.bpf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/include/scx/compat.bpf.h b/tools/sched_ext/include/scx/compat.bpf.h
index 505ddd8f2fa4..bcc0b4c84fc0 100644
--- a/tools/sched_ext/include/scx/compat.bpf.h
+++ b/tools/sched_ext/include/scx/compat.bpf.h
@@ -414,10 +414,10 @@ static inline void scx_bpf_reenqueue_local(void)
 }
 
 /*
- * v6.20: New scx_bpf_dsq_reenq() that allows re-enqueues on more DSQs. This
+ * v7.1: New scx_bpf_dsq_reenq() that allows re-enqueues on more DSQs. This
  * will eventually deprecate scx_bpf_reenqueue_local().
  */
-void scx_bpf_dsq_reenq___compat(u64 dsq_id, u64 reenq_flags, const struct bpf_prog_aux *aux__prog) __ksym __weak;
+void scx_bpf_dsq_reenq___compat(u64 dsq_id, u64 reenq_flags) __ksym __weak;
 
 static inline bool __COMPAT_has_generic_reenq(void)
 {
@@ -427,7 +427,7 @@ static inline bool __COMPAT_has_generic_reenq(void)
 static inline void scx_bpf_dsq_reenq(u64 dsq_id, u64 reenq_flags)
 {
 	if (bpf_ksym_exists(scx_bpf_dsq_reenq___compat))
-		scx_bpf_dsq_reenq___compat(dsq_id, reenq_flags, NULL);
+		scx_bpf_dsq_reenq___compat(dsq_id, reenq_flags);
 	else if (dsq_id == SCX_DSQ_LOCAL && reenq_flags == 0)
 		scx_bpf_reenqueue_local();
 	else
