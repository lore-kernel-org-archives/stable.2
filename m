Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DEB3AC0D0
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791238366; cv=none; b=QpnRlWELjFGX94cR8w4hnRGL+N3HO13k5554o5W1byzf/+1bs+Kd0zrAlpae2DlXJdvPEP02qkOSJ5ETgi5omegv+rnrGZPifjxsqzibhGReUabGjrrNt8V3UvGxhSn4afHE3bbbZSdDzn2LjjEv7rgj5qk91qZJ8MiaPrkAJFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791238366; c=relaxed/simple;
	bh=XA9vyd8rXaRSJvtR0v1YPTxnDPOs6LqLzEQ1Css16uQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQiBFMHcI3yr5GeFRbBm1L/ybCM84ArIguPWAiCaMX8zjuSLnhRR5P7U1prNpdsTBxag+uSQ6UWoNXK7/FYSDG3M9litvxrcDjaI/Iv8/7SKtjrw+4UCpJIQcnr7EqD586RBwdMvgMZYcRY916ZEjq4I8aMjxXCu41EmBKiadO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUxwl0t/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUxwl0t/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBCE1F00893;
	Mon,  5 Oct 2026 22:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791238365;
	bh=w+4RjG0cBsTb8izqz6gdZED/hHJYvgzxLdDjDIXKwZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gUxwl0t/pRwy2qJDfYOSjl5kxPXgSYkhK/JJ3YFRPyHoDCFhi3zf4u1YYzGg9PkjT
	 96IpZZ0wNhajk9Vri4Jw6UhmeeXzL+kgs9H6yYO4OJGIXtuOLI/9YmKxETQLjyyfCY
	 /fcMZoA5UOf/F0Q5dkv1btxP0Rm5Uy72dq5xe9xcOpLRr1UM3RDuIkbuFgUhFgzLNW
	 yvCN43G7hazRwHsNfh2H04LCzTe0nJpUNyzRXdVa5bWkv97xsC4H+V5zZ3uMdWK6LS
	 s1LfjR7FnamMp5KH1PuPAfRSNcCfTdC7K1uN7/+y1ZexVuJygBcsf02ViAUfFNZBcC
	 D1ORkPqA+BvGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] perf/core: Check kernel access when kernel callchains are requested
Date: Mon,  5 Oct 2026 18:12:38 -0400
Message-ID: <20261005221222.3426405-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005221222.3426405-1-sashal@kernel.org>
References: <2026100517-flask-antiviral-2fbf@gregkh>
 <20261005221222.3426405-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

[ Upstream commit a4573a3838ae4fc73b70019cfa1dac9aaea7cc2f ]

perf_event_open() currently gates perf_allow_kernel() only on
!attr.exclude_kernel.

However, users can still request kernel callchain collection with
attr.exclude_callchain_kernel == 0 even when attr.exclude_kernel == 1.
That still requires kernel profiling privilege, but the existing check
does not enforce it.

Update the permission check to call perf_allow_kernel() when either
kernel sampling is requested or kernel callchains are requested.

This keeps permission checks aligned with requested data and prevents
unprivileged use of kernel callchain capture.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260616044654.3468742-9-dapeng1.mi@linux.intel.com
Stable-dep-of: 357e8a77a501 ("perf: Require kernel access for text poke events")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ddabdc16e3880..3791c84ffe2cf 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -12893,7 +12893,9 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (err)
 		return err;
 
-	if (!attr.exclude_kernel) {
+	if (!attr.exclude_kernel ||
+	    ((attr.sample_type & PERF_SAMPLE_CALLCHAIN) &&
+	     !attr.exclude_callchain_kernel)) {
 		err = perf_allow_kernel();
 		if (err)
 			return err;
-- 
2.53.0

