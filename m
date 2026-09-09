Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B293D567E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945970; cv=none; b=U/f6s8Np7RtGFGFBaBv6WBuwwv89bQHRUHnhqHuB1HB1epMebZaKeRc3ia0EJXGuW3ISgB/IDQjryxg6FMrLrtvlL/a6+6sZtXeDRWH/2q0et6/l6fbHoZdhnWy1V+h2Mln1jiu1eL6eASB4g3A9Cqv6kU8z12c/rrUJ+cLRiWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945970; c=relaxed/simple;
	bh=X5uqLqqW3jjEer1RBfPIP2Z2OW1he7I8iwPZu/cfPEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikNZu2uaUORvgOoZO7M1bNHZx6mptv2WdlT6Ucwzye0P9dBtUOAyeu7SzXxJhg70KuckEump80o6GPFAv4QAhXKwevOWZnOnyMUYCUB9iWJoHZyXHKf1uQj96wJjrX3eCBTmLUnGIOGuM/2tk1eqo8iT36iPJyc7vs/ntcgPWdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOs/Ylo0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOs/Ylo0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE2C1F00A3E;
	Wed,  9 Sep 2026 09:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945969;
	bh=oh0DjY9qvT9+pDQqS08zd27QtyHVT2W/msJK0eF2RUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cOs/Ylo0FzvMcQAsuTN6KTCgy3I9QkcqkhuULSDUssqDDT7JSlX5919F2MDc4X93S
	 Gk5fytJ9irVGcf7RmSMXoMBZqDyq8wJ01lFtw+JqBloKoPQcmE17nOKyibAwNJJmVG
	 NKegjvg82tcNxnLUf3SZGaIGZLAh3egWNLhR0AgrGA+oeHP0GKPNwA8E34pudJXPBJ
	 DFxztJBhcFG+h4njwWPWAxcmFTWsiqz2qS8qtXloyb+DZXaGmblTq9AZyglEJNIJWf
	 2pWQHHPPe+fMXl/cU0nMkl/wFlwYCQqYNtRLIMH09EE/uMfX/L7TItbimyz8fflIKZ
	 hxEfpeseYgL9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] svcrdma: Add back svc_rdma_recv_ctxt::rc_pages
Date: Wed,  9 Sep 2026 05:26:04 -0400
Message-ID: <20260909092606.1293505-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909092606.1293505-1-sashal@kernel.org>
References: <2026090309-wooing-reassign-9ecf@gregkh>
 <20260909092606.1293505-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 4d9d69db898d05bd063548eee65d16a020676fec ]

Having an nfsd thread waiting for an RDMA Read completion is
problematic if the Read responder (the client) stops responding. We
need to go back to handling RDMA Reads by allowing the nfsd thread
to return to the svc scheduler, then waking a second thread finish
the RPC message once the Read completion fires.

To start with, restore the rc_pages field so that RDMA Read pages
can be managed across calls to svc_rdma_recvfrom().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 3779b7b9e7d1 ("svcrdma: Validate Read chunk positions before reconstruction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc_rdma.h         | 4 +++-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 5 +++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c       | 4 +++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index f8754f77e8d8e..12ffe6d43b9dc 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -136,7 +136,6 @@ struct svc_rdma_recv_ctxt {
 	void			*rc_recv_buf;
 	struct xdr_stream	rc_stream;
 	u32			rc_byte_len;
-	unsigned int		rc_page_count;
 	u32			rc_inv_rkey;
 	__be32			rc_msgtype;
 
@@ -153,6 +152,9 @@ struct svc_rdma_recv_ctxt {
 	struct svc_rdma_chunk	*rc_cur_result_payload;
 	struct svc_rdma_pcl	rc_write_pcl;
 	struct svc_rdma_pcl	rc_reply_pcl;
+
+	unsigned int		rc_page_count;
+	struct page		*rc_pages[RPCSVC_MAXPAGES];
 };
 
 struct svc_rdma_send_ctxt {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 9cec7bcb8a976..a6eecdc592412 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -227,6 +227,11 @@ struct svc_rdma_recv_ctxt *svc_rdma_recv_ctxt_get(struct svcxprt_rdma *rdma)
 void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 			    struct svc_rdma_recv_ctxt *ctxt)
 {
+	/* @rc_page_count is normally zero here, but error flows
+	 * can leave pages in @rc_pages.
+	 */
+	release_pages(ctxt->rc_pages, ctxt->rc_page_count);
+
 	pcl_free(&ctxt->rc_call_pcl);
 	pcl_free(&ctxt->rc_read_pcl);
 	pcl_free(&ctxt->rc_write_pcl);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 07904944d70be..e2d64fffb9011 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -1138,7 +1138,9 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 	rqstp->rq_respages = &rqstp->rq_pages[head->rc_page_count];
 	rqstp->rq_next_page = rqstp->rq_respages + 1;
 
-	/* Ensure svc_rdma_recv_ctxt_put() does not try to release pages */
+	/* Ensure svc_rdma_recv_ctxt_put() does not release pages
+	 * left in @rc_pages while I/O proceeds.
+	 */
 	head->rc_page_count = 0;
 
 out_err:
-- 
2.53.0

