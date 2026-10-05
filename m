Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547A73DFC6D
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235442; cv=none; b=SRTxDwXZwR4dDv4wDtLEG+Z5oNRJ/TAdx2BD5IIO0Z5Z6F6+vR+rmmfA+v9UcqQRMck+Es3/Vq6k877Vm9tT2YXqcq/iuJnmrySGg8mNNvmCVq7RpiB2GAOFVVE2k6r8YHQtePjNJ5N9v7zvz8t13qloEauGUkymGIOlP+5veCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235442; c=relaxed/simple;
	bh=60sOS/L6aP0bQbCdUHYjg21bVXdU+MHMtKhGa4axjEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lqrfbi2U8t975AuLE/RUesoPqlevd97SXA+oqBZxyAMhjXL9Q80IYQ3DO/t6AfzkN1DnrT+2Yin2y5Cp+fHMMM6S+mbQZgZYFCtwOogmhxpBUUChIPlzL3V0gh/17CWnPPYJqbmXs++LPWTuNNo1NItYEBefNE3bewHKMW1sx38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqJkC/74; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqJkC/74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01691F000FF;
	Mon,  5 Oct 2026 21:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791235440;
	bh=6igb6aNqYjvedIw0OhYNtHac/CDMGH3QWeYMCRKe1n4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OqJkC/74+ItMQb/7FgS4eLAgFcvQJgTxFVT/hl0D/+ZrWKjhyOn1TYoQ4LPGgofST
	 c6e7j78b5Pffb//zub1I04ugJbyX8NNp7B2AQWpTLioBNbfwekYUmzgXrVx18Nz2Bp
	 BYo98LTBgXx+k/2mDZVwU4OZYqA2GSRA5l/n9qXDaHulfwQpBkE8KLYUh7mdxHpxm8
	 SnJc+aOOA8oP4ZZWOWKPCSiuhKRVsGGldetf4SVOYKuB/9cty9iDuoJlrUZcFpgcbW
	 Bl6lfXwBJwBIxsFTfx4Jr6bjZg2Jf/zWFTTxkoL5nPc/2YW9j8+TlM/v9+fE1i+LS5
	 17aBnWPC+LstQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] perf/core: Check kernel access when kernel callchains are requested
Date: Mon,  5 Oct 2026 17:23:56 -0400
Message-ID: <20261005212346.3373480-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100516-douche-preview-30a6@gregkh>
References: <2026100516-douche-preview-30a6@gregkh>
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
index 8a7fcb902a9f7..3c3166d50ec7b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13882,7 +13882,9 @@ SYSCALL_DEFINE5(perf_event_open,
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

