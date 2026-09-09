Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8229329B77E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915125; cv=none; b=hdVEaLdrYVWgrsus/cM5cBrXxiB0I1cW3ia21E8+O+xTBzw+j1j5RabTN3M735lsQhntWnCEuno5ccCBuJux13OVIw0D0ZchgERCZd537lTMW1RTm6oThBP800YHnN6TFMVXfAm7ABTbU7saoL0x+8xVyStpQFGoFK0nWrzxagA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915125; c=relaxed/simple;
	bh=PPUicMYlmx5BRS3/NZjOXiP7oi3GPLx+/p/OttojhuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoOMUvffkrHkqzo3YQAIw/40oBSPOvz0Te+Nt9xc/g6Ha23AGsdLQZLOykH0/CB7VXtypA0Kazcq3JrHvOrkadB9Fn8u0Yo0AU+cgd2WaQEdLC2UQ4BVHJLtaDmoZAud+TZoAVNw/r9bOASdkAWJpIAb9hAJnHUtgoG/b/XVXeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFtf3qrL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFtf3qrL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60DD1F00A3A;
	Wed,  9 Sep 2026 00:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915124;
	bh=B1VTfR1jn4ORUMe2JedriWle9vcnW9hlWdZNDRIdO5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GFtf3qrLBjO9erE88PQnyIk9j4uDFTK0kUBnymC7ACTgLP+RRQayGIvCbJN84CPWe
	 uluEfFGf3BF4CrfGqP9p70rFHsBDgR34anVH+qFDbWwjMZ7Vqe5GDNUwWE6k76swog
	 UhEkZSYijsRPkF/eiZ+svaH01uxJk3b2TrGbYC+yQ+wyoj3c0UA746Bu0l1RsJ2NzH
	 K7YsbXJOGc5DZsy8CIWjkfjGZGY+fI/HqI5wpjgdgD5lInUQULTF+lKvbbGY6fe/Pi
	 7UJK7Zsgl2T08ZDmfjidjr+d3rl4kOkb31EWpOnIr+43NE6ImgzGXhV3R8fgGeJyjr
	 T6d/oJEbURcwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] svcrdma: Reject Read lists that exceed the page budget
Date: Tue,  8 Sep 2026 20:52:01 -0400
Message-ID: <20260909005201.804311-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909005201.804311-1-sashal@kernel.org>
References: <2026090330-audacity-nutcase-5491@gregkh>
 <20260909005201.804311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 0ca487abb3bdf581851664b5db21f364caf57682 ]

Individual Read segment lengths are validated at decode time, but
nothing prevents a requester from sending multiple segments whose
cumulative length exceeds the rq_pages array budget. When one
segment fills the page array exactly, the runtime guard in
svc_rdma_build_read_segment() is bypassed because len reaches zero.
A subsequent segment then accesses the NULL sentinel slot at
rq_pages[rq_maxpages], resulting in a NULL pointer dereference during
DMA mapping.

Accumulate pages across all Read segments and reject the message at
decode time when the total would overflow the page budget.

Fixes: 026d958b38c6 ("svcrdma: Add recvfrom helpers to svc_rdma_rw.c")
Cc: stable@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 30157636288eb..1075bfd9fed61 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -430,11 +430,14 @@ static void svc_rdma_build_arg_xdr(struct svc_rqst *rqstp,
  *	    to the first byte past the Read list. rc_read_pcl and
  *	    rc_call_pcl cl_count fields are set to the number of
  *	    Read segments in the list.
- *  %false: Read list is corrupt. @rctxt's xdr_stream is left in an
- *	    unknown state.
+ *  %false: Read list is corrupt or exceeds the page budget. @rctxt's
+ *	    xdr_stream is left in an unknown state.
  */
 static bool xdr_count_read_segments(struct svc_rdma_recv_ctxt *rctxt, __be32 *p)
 {
+	unsigned int maxlen = rctxt->rc_maxpages << PAGE_SHIFT;
+	unsigned int total_len = 0;
+
 	rctxt->rc_call_pcl.cl_count = 0;
 	rctxt->rc_read_pcl.cl_count = 0;
 	while (xdr_item_is_present(p)) {
@@ -448,7 +451,10 @@ static bool xdr_count_read_segments(struct svc_rdma_recv_ctxt *rctxt, __be32 *p)
 
 		xdr_decode_read_segment(p, &position, &handle,
 					    &length, &offset);
-		if (length > rctxt->rc_maxpages << PAGE_SHIFT)
+		if (length > maxlen)
+			return false;
+		total_len += length;
+		if (PAGE_ALIGN(total_len) > maxlen)
 			return false;
 		if (position) {
 			if (position & 3)
-- 
2.53.0

