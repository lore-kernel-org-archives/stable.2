Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9A62931C5
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 12:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784206027; cv=none; b=C5vWwzyPu0uS+UuWY2cJPqAV7DtB1Kkg962dBFZ1hsRrUj43SuckfkD3Kt4EKoYjhKL60PQSGjdBkGo4XrdbArFiHcGCt7FjDoqyvPmASGjKNeObHtnqHzAwJtraENRaY3MExzwnfJgGnCNfErBIAZRFFNGIW7HDmiMtX995jIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784206027; c=relaxed/simple;
	bh=TXpl6XrTo2u1RMC9H/TQc0G/a4g6RohRr0AClW0qIdg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uPM9UKpePSvgPj7jW+REP0FsOhpPOzLrixz18TBREBm61IMGbrRmqGiQW1c53QER5bUW7gd7mw/i5WZ1MOUr9AvS3P+xkmBTz2GK3Ehte6m2jy1T5CVfhPuTGNSPy4r/erTI2fVggT55QmyazEeIJFVML3CmkmNOneC3e1CvL90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2u5LhBsG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2u5LhBsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178FF1F000E9;
	Thu, 16 Jul 2026 12:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784206025;
	bh=Ban+JBJVplb3rHDbfDuVnKW+ypfuwRuKTvf4sDUh664=;
	h=Subject:To:Cc:From:Date;
	b=2u5LhBsGEHG1B8+iaFhG3Z7dT1WfRk+vVOxVMT6Gf9LfQ55rq0mCpNSEAkTYt+Huk
	 CdlPr0zCSpWYqfUeE6VUIv9HlXD82sTW2ioKRmqNLpkUAVDPFopjfJVYlOe38AS+kY
	 cswwD37Ja0Pe8wo7Jp9kvY1IDBZxm0Dgv/zsE/DE=
Subject: FAILED: patch "[PATCH] RDMA/rtrs-srv: Bound RDMA-Write length to chunk size in" failed to apply to 5.10-stable tree
To: whi4ed0g@gmail.com,danisjiang@gmail.com,haris.iqbal@ionos.com,jgg@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 16 Jul 2026 14:46:58 +0200
Message-ID: <2026071658-gone-jawless-67b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 963af8d97a8c6a117134a8d0db1415e0489200b1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071658-gone-jawless-67b1@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 963af8d97a8c6a117134a8d0db1415e0489200b1 Mon Sep 17 00:00:00 2001
From: Zhenhao Wan <whi4ed0g@gmail.com>
Date: Fri, 12 Jun 2026 01:15:54 +0800
Subject: [PATCH] RDMA/rtrs-srv: Bound RDMA-Write length to chunk size in
 rdma_write_sg

When the server answers an RTRS READ, rdma_write_sg() builds the source
scatter/gather entry for the IB_WR_RDMA_WRITE that returns data to the
peer. Its length is taken directly from the wire descriptor:

  plist->length = le32_to_cpu(id->rd_msg->desc[0].len);

rd_msg points into the chunk buffer that the remote peer filled via
RDMA-WRITE-WITH-IMM (rtrs_srv_rdma_done() -> process_io_req() ->
process_read()), so desc[0].len is attacker-controlled and, before this
change, was only rejected when zero. The source address is the fixed
chunk start (dma_addr[msg_id]) and the source lkey is the PD-wide
local_dma_lkey, which is not tied to the chunk's MR mapping, so the verbs
layer does not constrain the transfer length to max_chunk_size. msg_id
and off are bounded against queue_depth and max_chunk_size in
rtrs_srv_rdma_done(), but desc[0].len is a separate field that was not
checked against the chunk size.

A peer that advertises desc[0].len larger than max_chunk_size can make
the posted RDMA write read past the chunk's mapped region. The resulting
behaviour depends on the IOMMU configuration: with no IOMMU or in
passthrough mode the read may extend into memory adjacent to the chunk
and be returned to the peer, which can disclose host memory; with a
translating IOMMU the out-of-range access is expected to fault and abort
the connection. In either case the transfer exceeds what the protocol
permits and is driven by a remote peer.

Reject a descriptor length above max_chunk_size, mirroring the existing
off >= max_chunk_size bound in rtrs_srv_rdma_done(). Legitimate clients
do not exceed it: the client sets desc[0].len to its MR length, which is
capped at the negotiated max_io_size (max_chunk_size - MAX_HDR_SIZE).

Fixes: 9cb837480424 ("RDMA/rtrs: server: main functionality")
Link: https://patch.msgid.link/r/20260612-master-v1-1-70cde5c6fdc9@gmail.com
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Zhenhao Wan <whi4ed0g@gmail.com>
Reviewed-by: Md Haris Iqbal <haris.iqbal@ionos.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index f2fd80c8a044..7d8e4422cc57 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -225,8 +225,9 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	/* WR will fail with length error
 	 * if this is 0
 	 */
-	if (plist->length == 0) {
-		rtrs_err(s, "Invalid RDMA-Write sg list length 0\n");
+	if (plist->length == 0 || plist->length > max_chunk_size) {
+		rtrs_err(s, "Invalid RDMA-Write sg list length %u\n",
+			 plist->length);
 		return -EINVAL;
 	}
 

