Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720B921FF2A
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784716925; cv=none; b=MKL44RykMNX7QL1G9j3RKigaaMmBBuw4ZGZ8bOhWeOzlXhEFQY6Sc8EJubinIDjWCFOv9sb+8dBvKaBUwYwo7w7q/lk/oO1dtgqyzUArvcTyPw34zN7ZLDSDZgql4qnHtkeLAf17bE8dm6FUy+5+6Ea+MQrO5mEoBMVcAELpfuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784716925; c=relaxed/simple;
	bh=DDu9P+Z8IomcdWTGfBjWibiG8t/ldKELset+6ELt6M4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7ezQQZTAYO7s9UTORt5IODLhnFmM2rhPUQRBAu9jjrRblLLjpIGIWOOAF+MlLnhjKdX2yoqYPcBeLtZRzpGMml3mQlaYKbDAM3gMZIjsatC/SCelxh0Yi6krdJmKG0s2caTK8VryCUksjmMNgZHpJ95ViQoZ/RfSCIL/la25zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kkgxpx6i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kkgxpx6i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACDC1F000E9;
	Wed, 22 Jul 2026 10:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784716924;
	bh=KBFxEBFONdfozYRC3z/v3ZM1F6nBXICR2ZlGhIIXVqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kkgxpx6ie7VxFPPtwjCcLTk1netcduCkRQuN0WO8ZeBWPzSNRcRJWVjD3wtn8UpfA
	 47NwVzEnX3qZHRNLzVjzW5JfShRHcMbvFaYvF8j0ykjQTRCNfxc/LZg/3A/q3Y5UXb
	 MMKXCye/9LG522luxXEeigLiESR8muXAGmIX+cf8Go55g+Ug+WOPNJaC+KwOizfrzF
	 PjAFWvp/CCPqBtmiHU5Hxy9YpoDztW1UPAQnVAM9OlVE5PkEQcS8GlwPGCzIxBL5yO
	 +yA3EPW9wiyyLMTt0KPI83VLR8VUOPll0XFOSqc/9VWQwyHAobAyuEXbxa2js//+fN
	 1ICMH7DnEbw5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhenhao Wan <whi4ed0g@gmail.com>,
	Yuhao Jiang <danisjiang@gmail.com>,
	Md Haris Iqbal <haris.iqbal@ionos.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] RDMA/rtrs-srv: Bound RDMA-Write length to chunk size in rdma_write_sg
Date: Wed, 22 Jul 2026 06:42:01 -0400
Message-ID: <20260722104201.934949-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071658-gone-jawless-67b1@gregkh>
References: <2026071658-gone-jawless-67b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhenhao Wan <whi4ed0g@gmail.com>

[ Upstream commit 963af8d97a8c6a117134a8d0db1415e0489200b1 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/ulp/rtrs/rtrs-srv.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-srv.c b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
index bb19bbc5644131..0558ea8f874c55 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-srv.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-srv.c
@@ -258,8 +258,9 @@ static int rdma_write_sg(struct rtrs_srv_op *id)
 	/* WR will fail with length error
 	 * if this is 0
 	 */
-	if (unlikely(plist->length == 0)) {
-		rtrs_err(s, "Invalid RDMA-Write sg list length 0\n");
+	if (unlikely(plist->length == 0 || plist->length > max_chunk_size)) {
+		rtrs_err(s, "Invalid RDMA-Write sg list length %u\n",
+			 plist->length);
 		return -EINVAL;
 	}
 
-- 
2.53.0

