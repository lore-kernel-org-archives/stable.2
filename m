Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C6B2E764D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917479; cv=none; b=TfSyt2U7ZgoiMdPRk/CXj9xL58/L8PziOGWjT1+KS47Op9FBgUjOtQ70mGb8plfvcnWmJWGn+vckyLvRgLfBKVx6UA6PTILoMV8fGVP0NiYrtxsR86n6E5QSPWA6B/dMl2mkDt0eLgqiZaogLZLrxVvJ2KP16pK/hI22IEWUCpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917479; c=relaxed/simple;
	bh=MOn74a7U/0dAGvm/TcwXj+2/DQyAl41pW3ieet+GX74=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4RqxNTOwxzpGbtSr+PV+xhY0QCDplPZQDY/tzbDTrQKv+cwmrXolQtb9Y5uiQJSRrSZs3VPhYRcCBPPkP5ZfOc3XFIkzs++n1bTsqntXnW6Al4VVA3hAXe27xQrny1crpagijKqYsIk3p7U9tBZeiBLR4XZEuVaS8wlg8E5jZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DdWcWw40; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DdWcWw40"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFC0E1F00A3A;
	Wed,  9 Sep 2026 01:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917478;
	bh=5BFR8mYAZD2o/iv8ItC83D5srmk4yQsJ520vdaipQ/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DdWcWw40As/2PUX6r+t9eSk4CWGilofCMD2bvLGE6x3dVmNXnQk3zGM3UzkyrsC5Y
	 8DATp99ZBB6FBcroJ3wnio9/p0WwfrWIUBNWgjuDeHsYE0oX3CCzDQp7qWAoGWEaEp
	 aUTke/7wzYhdjIC8meH2d2eWxiX9DFs/e1ynyLhCfWMJKD6TPj82Nay2oNlAcChert
	 3oRT5OHZSs5/M4YGVU/bPZdSMcM94yr7eNA7Rk0BoQTzcfYYbPQoqen7ANCSwZ1G8s
	 /AunTmCPtZOMmasK7guBktZI6pud4YtLx7RNgmbbQEMuPeLv1wmjsoU8spA/H/6kaB
	 Dv3oFUpFzmblQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] svcrdma: Add back svc_rdma_recv_ctxt::rc_pages
Date: Tue,  8 Sep 2026 21:31:13 -0400
Message-ID: <20260909013116.888180-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090343-customize-gorgeous-909c@gregkh>
References: <2026090343-customize-gorgeous-909c@gregkh>
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
Stable-dep-of: 9808eb765666 ("svcrdma: Reject Write/Reply chunks with segcount 0")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc_rdma.h         | 4 +++-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 5 +++++
 net/sunrpc/xprtrdma/svc_rdma_rw.c       | 4 +++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index a5ee0af2a3103..4ba48bccb7993 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -136,7 +136,6 @@ struct svc_rdma_recv_ctxt {
 	void			*rc_recv_buf;
 	struct xdr_stream	rc_stream;
 	u32			rc_byte_len;
-	unsigned int		rc_page_count;
 	u32			rc_inv_rkey;
 	__be32			rc_msgtype;
 
@@ -146,6 +145,9 @@ struct svc_rdma_recv_ctxt {
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
index 82c4202fa3c15..1f54465404c01 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -1163,7 +1163,9 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
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

