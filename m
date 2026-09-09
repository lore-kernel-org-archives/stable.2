Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10E3384250
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946000; cv=none; b=Pf+WpqBY5G0hG77hnhwQYKf4LWq23XJnJ0mnxPDpkBar4PyoWNDPCsJUklM/jggNoCqkxD+IhQ5FUBKsdpTuXtakTT6iq3XC1TVBtGEiAISrNrp8s1UGN3c3nTEucxLdcs9XoFanNYgARHMB3X8VT9e05Vc+cw1E3Ix7QZ6OW9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946000; c=relaxed/simple;
	bh=Afh5DBjD6LGu2Wkde8l1RcEglqDrGY7qFDij/VFJym8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhtPCQt+sB9s1m7C7kfB4fQchN/H3JljKVNaiAHCGH6EwzrTGIHzNVxwJMQTSR8Uehim7QTB5F2h8Umc8IGBTruywIGcYH5JylU5pHhOaFy1i7r9BUkU1eIF24ohTOOzBC3aRv5lTuXSUegiaGeoD8xpPGUhNdOL39BZymQgHvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuEk6itP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuEk6itP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F711F00A3A;
	Wed,  9 Sep 2026 09:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945998;
	bh=dSBbLm1bidNgngVN6SuBew5orb6rJn5SFv7ERS8wZpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MuEk6itPHqBGrH/55/3MmgH50MG478IydNC6eDXMpA0anQfwMNSDUTdsXxWY/Dq/5
	 7WRmvb6GLYOpQvUP9rsctVCH5DCkjnYFKpAUbS0yOR7jVreHjP5vtHvVq4Ab3TDXpp
	 tqA55Qn/+cwbYs0EcYpKYun8qTLLBc3ubLLUj7cs4n5kL2fQ7Suslo2x0s2wcMt2y4
	 fpYOzhPacHDsbaQFr1bi7YOmE3tMYNeZ58vTBimw5rGdQIF5RriBe9PPLRVIjflUsj
	 KjcoeR+NAhC72QhTgj3oSVjOguEkyhKTp33e3rCnIMwfHLaoB3WDhaYBehVmAa/bpU
	 NOvnM/xjMS25g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] svcrdma: Add back svc_rdma_recv_ctxt::rc_pages
Date: Wed,  9 Sep 2026 05:26:34 -0400
Message-ID: <20260909092636.1296906-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090343-runway-amaretto-1501@gregkh>
References: <2026090343-runway-amaretto-1501@gregkh>
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
index 186c9c12432b1..ec759cfecbcde 100644
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
index ed581c183f7c8..ec15f526ed2da 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -1156,7 +1156,9 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
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

