Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1BC492E4C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913537; cv=none; b=gdpfCMicmfzEOuCuMttfLvNmUd6f+Caxw9RAUgdWI7dwHXzazT8PIsfo7/onMnzGr2TiIvtF7aPv7ep7y6pPIMpIKbHE8dkRbJVpZ/DVKSmBOvW5RAnrEj7SThuRvColqeE8vmK3/6NWpPTbwCeXz8j4oCCFc4h5zlSpPLxgViY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913537; c=relaxed/simple;
	bh=WUp0Hu50K482oqeI0FKmdCRGkDhmf4nSMlqRVL36PTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CnPbfIfsefoyGy4tNN9I17W4FoHkAXiq1Olj0MY9+ado3686jSbZwyV52uc+rwgsUZ/iAORMmDR0IRPNc26J8iVKQgriN5MreTUfkrmG4E2BJ4/SZa9P5iBSeXSvBUAiHJnSJMlXgBwJjV4yzPwUQL+db9h6zFMvwu2VfdhElKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbiAIK3A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbiAIK3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D811F00A3E;
	Wed,  9 Sep 2026 00:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913536;
	bh=CAslp9CwyUz1BZAwdM/1LMnLJnaziIK4Bod0EJdagb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mbiAIK3AhGFglU7qR50CvNTCfQ9//LSdmLpfbn4rdSs9ApqnPytMGQ/TysznamyKl
	 7AuVgepzE86z9xlK0se4Y7IpWguoZO0bfGPFgJHN2p7cvOjx6OjTxgjHgLWY60ubV+
	 +jpzpL+wqrpkiCdHP8I7LRrehKhC5yI585bzAmn8ot66e2BDKTDoMgWmnRNeBc39N/
	 h2XUFwRs6kPhfWz4/6SZf5UzJPE7mFUfDH9gx0pNDT3TIpp15cyK2oR+ZVOKt8JStD
	 3h5e6KwB1zOdYhXbvc/EEAexmxjPdi+xTeU+H3Ggm7RKb9mmTOnoatkzW0+I2k/QE+
	 fxE2obKKZ3X8A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] SUNRPC: Update svcxdr_init_decode() to call xdr_set_scratch_folio()
Date: Tue,  8 Sep 2026 20:25:31 -0400
Message-ID: <20260909002532.729106-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909002532.729106-1-sashal@kernel.org>
References: <2026090350-comment-projector-6988@gregkh>
 <20260909002532.729106-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna Schumaker <anna.schumaker@oracle.com>

[ Upstream commit d57e43b72bf2071caac90da323849c3983a695f0 ]

The only snag here is that __folio_alloc_node() doesn't handle
NUMA_NO_NODE, so I also need to update svc_pool_map_get_node() to return
numa_mem_id() instead. I arrived at this approach by  looking at what
other users of __folio_alloc_node() do for this case.

Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>

[ Stable backport note: Earlier dependencies already converted rq_scratch_page
  to rq_scratch_folio, including allocation and release. Keep those changes
  and switch svcxdr_init_decode() to the xdr_set_scratch_folio() helper added
  by the immediately preceding dependency.

  Drop the svc_pool_map_get_node() change: svc_rqst_alloc() already converts
  NUMA_NO_NODE to numa_mem_id() before __folio_alloc_node(). Preserve that
  fallback and the existing pool/thread placement policy.

  The resulting dependency changes only the existing decoder helper call;
  no functions are added. The scratch-folio release and surrounding context
  required by c479bde671cb are retained, and its patch applies cleanly. ]

[ sashal: Reduced backport -- upstream d57e43b72bf20 touches 2 file(s), this
  backport carries 1. Not backported here:
  net/sunrpc/svc.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: c479bde671cb ("sunrpc: defer rq_argp and rq_resp free until after RCU grace period")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 4144a256fc255..40ab44b993cf9 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -545,7 +545,7 @@ static inline void svcxdr_init_decode(struct svc_rqst *rqstp)
 	buf->len = buf->head->iov_len + buf->page_len + buf->tail->iov_len;
 
 	xdr_init_decode(xdr, buf, argv->iov_base, NULL);
-	xdr_set_scratch_page(xdr, folio_page(rqstp->rq_scratch_folio, 0));
+	xdr_set_scratch_folio(xdr, rqstp->rq_scratch_folio);
 }
 
 /**
-- 
2.53.0

