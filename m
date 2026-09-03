Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A4E4BB5A4
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445899; cv=none; b=LLBQ6+pRzNfJsESZVqc3/6GuyDteLHaeI8cbCisWEG8uJTg7WD6Wjg+vQ+vASGVAZW5JjS95paoqBcHNKrqXsYpMO8YV1GBX8RbP6LM8eEXtGO736lpZejaPnlIIhoMNBIQiavgwh1EtB6f6wtY8AybCklL9t//MzDhiTZ1eFcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445899; c=relaxed/simple;
	bh=bfJYs3ACYia868fmLyC1kbZvqzvAG+CqWlZ3cYszW7o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kKtYb9/vL5JDmlws0/p4WFAdUjMFenyIlIL/qumA8XIUt5Swkq2PdmlYG0RqBMdSfwU7PTKrzaw3rBR4thz/yVaMlQIRttQaLbodjStU7CrS5yoFin3HlWYfGVa8vukvoJ8sUuVTWNgU8A/JEGS0i0sJ59EEO0wOgqrp9kUIPEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uxWHKdKZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uxWHKdKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFA41F000E9;
	Thu,  3 Sep 2026 14:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445892;
	bh=wJtmw+s+OL0RL5ck0xHcsQ2BdIGpamlzHA+F5xI/XkM=;
	h=Subject:To:Cc:From:Date;
	b=uxWHKdKZF0T6UYshAYzq7w3h7o4v5eyBceiXWGr15dzswO1ScH4+kq6+GwpNdVuxY
	 rcptskhovdwzI4u1sslOIWy1HCCvOx+97pdXoEGNhGvFEumWkg/zJvjqtYsJe5Z0HK
	 LdH+gcbDRcr+n81cGPqPQm2HXHoqCHCAHti9e2IU=
Subject: FAILED: patch "[PATCH] svcrdma: Reject Read lists that exceed the page budget" failed to apply to 6.12-stable tree
To: cel@kernel.org,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:10:30 +0200
Message-ID: <2026090330-enigmatic-unsaddle-2252@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 0ca487abb3bdf581851664b5db21f364caf57682
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090330-enigmatic-unsaddle-2252@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0ca487abb3bdf581851664b5db21f364caf57682 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Tue, 26 May 2026 13:34:54 -0400
Subject: [PATCH] svcrdma: Reject Read lists that exceed the page budget

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

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index d64b5f78ce8a..fdfed1be97da 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -440,11 +440,14 @@ static void svc_rdma_build_arg_xdr(struct svc_rqst *rqstp,
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
@@ -458,7 +461,10 @@ static bool xdr_count_read_segments(struct svc_rdma_recv_ctxt *rctxt, __be32 *p)
 
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

