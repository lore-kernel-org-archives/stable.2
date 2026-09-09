Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC32BFC8F
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948944; cv=none; b=PmO/NtKEnnneo0eyST2U6OgwaNvy3Zad4qZ6cjHyQEWHblaAIpRJCNy+q48J0E2XGUZ4YNrduMSJql12pVtS7w1LvbOHdwhCWpDtxXCEIop16dSwfJPkc9USWchovnQlH/N0+dF726Qh9ZgfP/meHHt7K/gfSo5BQFISFFxYJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948944; c=relaxed/simple;
	bh=TsaQhD/bACDGBgTyAoyVPAOq4lnmmNjHFaYFFDR2Ikc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCSgAi6If2lR/ldT4FOW/tKMIwm+L2EVKwpSnKGw9bDTSrY6iKCTaKBgJ7HF60GATJCgJVjYeYvGM8lfXukTwHqesO1wufuvudqUW4fAM/C+2idMXuJisoiy6E/dF8edMQu4YntSZnMtFGxNG62SWFoWsk/fqlzT03mXQ4Yr4lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gqb/wecx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gqb/wecx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67E41F00A3F;
	Wed,  9 Sep 2026 10:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788948938;
	bh=Qt4E4E/ssq4dEtIC1R7EkVPKhHURSnXf3LlAlJJtLyo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Gqb/wecx+avtvpntuClvjuqJJdPrDsu5bVBNbr6Xuacz38oMruztMzdWzFHtt9zuG
	 JANHL20hTfMU/uCuzzmSYkz3YuUSwLv6JZO3phoLFzofS2dwrdccOqCMFpaF5QTC16
	 eFeaoI9Ahurm0ZNWzmh80PeUOXF3WdAj0BtD7DAB2cSe5LVztISPpps+UA7E3G/4E3
	 0EPZK974LNIdee8U/0SRnMyZrRYzrN41/inlFTI+gzKCSDy2g+lWMUaNMNlJVDPlWZ
	 ycB9mSKiMtPDFr2CaCIhI+fAsqcQdm9SbySoY7y+YQvWPmp2TZMaoVBFM+9rBNF/M+
	 gP+Xca3hVY8gA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] svcrdma: Add back svc_rdma_recv_ctxt::rc_pages
Date: Wed,  9 Sep 2026 06:15:34 -0400
Message-ID: <20260909101536.1481226-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090344-perfume-python-398c@gregkh>
References: <2026090344-perfume-python-398c@gregkh>
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
index fbc4bd423b355..2bfc32337bc2e 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -137,7 +137,6 @@ struct svc_rdma_recv_ctxt {
 	struct xdr_stream	rc_stream;
 	bool			rc_temp;
 	u32			rc_byte_len;
-	unsigned int		rc_page_count;
 	u32			rc_inv_rkey;
 	__be32			rc_msgtype;
 
@@ -147,6 +146,9 @@ struct svc_rdma_recv_ctxt {
 	struct svc_rdma_chunk	*rc_cur_result_payload;
 	struct svc_rdma_pcl	rc_write_pcl;
 	struct svc_rdma_pcl	rc_reply_pcl;
+
+	unsigned int		rc_page_count;
+	struct page		*rc_pages[RPCSVC_MAXPAGES];
 };
 
 struct svc_rdma_send_ctxt {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index adfe05f19060a..cf673cf9584d5 100644
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
index 5791c26cd916b..732f9ac137749 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -1137,7 +1137,9 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
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

