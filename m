Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD064B714F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445905; cv=none; b=l6QfdSGYw5iod1B7TSjyhJez8hPGs2S2aXKOFSE5ENt06QI3Tubo2hBV3mGV+6NBngPs817EyRXWZoWhnSfyF8loOi9mJClase2SNgC3mrFvT1ac71DGfsWYZ4DzjSYQZkoaZxGZEtZfrsClOx3nU2x+oSd+5yk5af0qQGAMZ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445905; c=relaxed/simple;
	bh=05eQA2RUPKUJnyEssRorZnCbpfvGsczg0Pim0XPtCqw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ed7Qx0ILYPoqaGGAMDc+Vj9ieY6u1mGM/B6Z7fSmf0k0iA3xmVFgFPDBhyIAbNoNlxWyVy2FuLhfBaoN7IDO5rGIQjz7gAU85sDieiTtbVhXbK1+3gXYoFrix0oMYrabWyM+cKpQlwa77QpT4thUuSFnsNK7GODPlkE4mGAZ5Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PF0zTnzw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PF0zTnzw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570161F00A3E;
	Thu,  3 Sep 2026 14:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445894;
	bh=bybqaaZWqxpGi/AjDKc9Ij2HQ1nnxSNsRmvzAxRNjKw=;
	h=Subject:To:Cc:From:Date;
	b=PF0zTnzwkV0Uk83EJ8ygE9TVvBroFWr5HVXXbN61O6ma4y84UJPtXyCQnmkMyvceI
	 D+NFkw1nvsaHH1rhgxNbl2vaQh2O1lGJmsjIVFQT7iMwI7vn1iKMe8QEuJZMwq8Rev
	 7IZghWs32b8rU1UWgnptdh4vG7JBIwYlAa1SSiEU=
Subject: FAILED: patch "[PATCH] svcrdma: Reject Read lists that exceed the page budget" failed to apply to 6.6-stable tree
To: cel@kernel.org,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:10:30 +0200
Message-ID: <2026090330-deftly-press-9fda@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0ca487abb3bdf581851664b5db21f364caf57682
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090330-deftly-press-9fda@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

