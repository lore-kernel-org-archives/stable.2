Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C8A4B8DE8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445907; cv=none; b=jfTD2mBZMCy+oNrxqsEFA5PPsYIbr8RlR6mI7UCtyr+KxTurxO8CQ7G9a0CAIycc8cSGslBlwWEh83/tbF5wZPyY0I4a1EuptQc+vJ8Ab27evXjMy6yuTjBCF+joWRgtymjC1WDnXipzd1huskyVmxX/iR6UuMLSRLgGEDeWrGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445907; c=relaxed/simple;
	bh=k4xRRuocmEmBVBJwarXlBKFMjF/iqwDiET98KMvMjK8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GxHWG0D82D8Dqfrx/0x6sDiaxGMauZupvj7Ny88uNeuJOPyVo/sq4bit8mxU8BWQ0muAM6kuDMEOOYZLvKWsNdS+NeltS9+8s/kPQ9lwAe9KdekuhWHsi/r3af6Xq+MD1Rvs4+smUIxgx+/TPRca0E56H/TLG/Bh3nFKqG2Q+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LVSUf4Hp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LVSUf4Hp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 037391F000E9;
	Thu,  3 Sep 2026 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788445900;
	bh=umFvRwYvrFgGSH77FeJcshbd9SRdOCubbiGB00QoReA=;
	h=Subject:To:Cc:From:Date;
	b=LVSUf4HpO7sRByl9p+RoXsZ0gPTKMIcfnYlqYjp3meKy1W3eq1/e17QjVvAV26p/X
	 XH671daZQfZdSkunQ2ZBfb91NHOKzgu2FxQCL1X/CLnJqGtBRPV5dun3TwhJTUdZCE
	 1nhei/jpILGmWHAYyCzGtKObQYXxu54CiAaZzIMQ=
Subject: FAILED: patch "[PATCH] svcrdma: Reject Read lists that exceed the page budget" failed to apply to 5.15-stable tree
To: cel@kernel.org,chuck.lever@oracle.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 16:10:31 +0200
Message-ID: <2026090331-desktop-guidable-9468@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0ca487abb3bdf581851664b5db21f364caf57682
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090331-desktop-guidable-9468@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

