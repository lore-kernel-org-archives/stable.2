Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3486F524B00
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950523; cv=none; b=JCspYRphTli131koziTXQXo8Anv5GL4KLRTWV0CGX2p0Z5SAMs6fvgwdMZymf3SOaB/UjR/k4hKLDRCXqYyUUeQF6xOu7+UH++4SivrGCnFTCOaCwitAepzyryk/hlWv+dDBSSSlzvVCNxZlNCbxs/uhMnGCPeK/1B9Z3KSkW2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950523; c=relaxed/simple;
	bh=/iHnloLgNB3WjPISgTtwbxq/zlY4IpZdeo8ltEEJXYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ez85d+5al3GN5RiiWrl1Wb3I1b8cvDnWZYpQtfWWZcJD7UVMUQVdlg4BU9crA+0GVgINDXASKQeuigYQN2TFJi9dHnh7BNRg5s/tNfhQOFl0lGnHP4XCVLS96jrmVw3UEgVJuIHFcnoOiXQiY3RFdUErqoag3MvOz1e6/pAHi3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIUdS3uO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIUdS3uO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778631F00AC4;
	Wed,  9 Sep 2026 10:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950521;
	bh=Wo0OyP5GL3aCpJrJ22nsuQfuiYlcf0C9jp2jy9u6Eto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VIUdS3uOYpTUYQfX3CUFlgvUOhZ6xvy7kzqZxWYAvgAvUdHXReRcCp5rX1zj/h2rN
	 Z90bBWu2A9jKlH/jUnAvIcihOI39cNn610n96Dbw6U2qSP8Fb6YVk1wPehWVaWZkb4
	 ZptVK0gnVcDkDQ4no1sLExntYHZcC6tipPx9IoumN3owU95ktElDEgt8dEm4gB1GkM
	 ANvsXrpFpXu+guFcnQZ/6y1khO6etx5r/sSx/x4LTyCZA5Or4Pjkl8bAqct4vInHNi
	 zGpB1Hp4V1Mr+7EzX/Js2+jjIROHt4HLu+sOHOjMx7pPoee67dmzlJTmBCG+G6mCVk
	 Wgn+xqdnc5gmQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/5] svcrdma: Add back svc_rdma_recv_ctxt::rc_pages
Date: Wed,  9 Sep 2026 06:41:56 -0400
Message-ID: <20260909104158.1554268-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909104158.1554268-1-sashal@kernel.org>
References: <2026090310-onto-impotence-7944@gregkh>
 <20260909104158.1554268-1-sashal@kernel.org>
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
index edf6955295fc8..7f75c3a652c28 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -152,7 +152,6 @@ struct svc_rdma_recv_ctxt {
 	struct xdr_stream	rc_stream;
 	bool			rc_temp;
 	u32			rc_byte_len;
-	unsigned int		rc_page_count;
 	u32			rc_inv_rkey;
 	__be32			rc_msgtype;
 
@@ -169,6 +168,9 @@ struct svc_rdma_recv_ctxt {
 	struct svc_rdma_chunk	*rc_cur_result_payload;
 	struct svc_rdma_pcl	rc_write_pcl;
 	struct svc_rdma_pcl	rc_reply_pcl;
+
+	unsigned int		rc_page_count;
+	struct page		*rc_pages[RPCSVC_MAXPAGES];
 };
 
 struct svc_rdma_send_ctxt {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 29bfbd8b72089..020573c0f8e7e 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -228,6 +228,11 @@ struct svc_rdma_recv_ctxt *svc_rdma_recv_ctxt_get(struct svcxprt_rdma *rdma)
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
index ffe7d4a54d5f0..6586dc7ddc5df 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -1087,7 +1087,9 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
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

