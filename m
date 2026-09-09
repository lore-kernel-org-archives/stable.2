Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CF8492E5D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913516; cv=none; b=f+IBsvSNtxZFmtt59ktrrql586ctSuyTov8mLel1QIC+ztcWf5uPqAToQEsEEisQNYfM8YxOfodWLUmoTd8DCQsOtRLBtPTB7YJxZhrjBHa18U8GUN3kJQfl0YKQgGaT8zoJSHhN7GjuHxj2ALMnxYQX0yDpHQZTdc/suKH3Cco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913516; c=relaxed/simple;
	bh=WUp0Hu50K482oqeI0FKmdCRGkDhmf4nSMlqRVL36PTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=klEEAIx1RFtUmf1oKruqKZ0C6IzwP6odiiUSCqv4wy9qCaism5Y9G32Pg/eCUU3dWXj0LbfqeUZJuWuIdmLycOfT+rpEa2Tyw44OCrRTdiHEdZ6C2CFivKngdKYnIxkQ+ziQAtVF3pSf8vUAWvf21xQ8+zhD6unzzOHp+Llj8hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqhTfNvH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqhTfNvH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3E21F00A3E;
	Wed,  9 Sep 2026 00:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913515;
	bh=CAslp9CwyUz1BZAwdM/1LMnLJnaziIK4Bod0EJdagb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dqhTfNvHb9/SeYroSJox3y2ZMWZ9dKVNbad/u9a3OGowyTScuZiHxqqII9YkvOP5c
	 dYxCbKQQVb0WFmKn0cLwhsddXdt46KXhDPRJnI3R4RHYmuKaAyNseWzz3u1epKqXpj
	 2Ap8Olkf0lQqyzaJnCqTLEXcKKuExq9QiSTAHjU7hUKgUraj2No4ci/rG8qNMkoLOt
	 s3KHXCgXXoUft23jSS9yDOBdXckQxTnY/yneL3niaBe2ND01+WgPstVw06tK1Uio2M
	 moqNcVkquRpEQBRG+MKJkoqeYRYjqMCyPh9a/WLDCGSTyiuWC/M48/zdFYq03i+GTV
	 +Pt9tx3aHBivA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anna Schumaker <anna.schumaker@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] SUNRPC: Update svcxdr_init_decode() to call xdr_set_scratch_folio()
Date: Tue,  8 Sep 2026 20:25:10 -0400
Message-ID: <20260909002511.725380-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909002511.725380-1-sashal@kernel.org>
References: <2026090350-comment-projector-6988@gregkh>
 <20260909002511.725380-1-sashal@kernel.org>
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

