Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020612D8DB0
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 13:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787233998; cv=none; b=P0WSmclfyi1skifDUJUaFsgEsNZZMAThNUv/SZpl+W+TBSk2dOtXBJpwMPzercqDUiRv/GidvF0I8uuSL5fjndqQK77C5d5YzmjE6cxWlLHFUmK6dG3ZvZyWoBsIUur9Zxd9Zp9m0x74dXuBMTPBtey5I/9vZvclHu1W9QjEOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787233998; c=relaxed/simple;
	bh=kXx2zdzvSIY49Fjgc2wmVr6P5f1223+BrvQCsCnfHL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOfL0irsaiA56m/UNUAKFT6ruzcHMCgtCv20QTcyC/+DOrMwQgBHxmnRnIdc5QkqagKvqtQUOYWJJKaP++iCIqog5jCQBRXjfKwQOVlDVD6Ogj388JMPVpi60ss6PXDZ3fxiga0q81BTWwIDNFPit8efr40PM8g/OUg4oKdipCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SP5cSzJU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SP5cSzJU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABF01F000E9;
	Thu, 20 Aug 2026 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787233996;
	bh=NAeJKTBtiUPVj21qFe4cvRehU6cqTAN6oi0vVINN2Hg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SP5cSzJUS3JN+hqjdDjFEZQRdubH4ZYIDcNNv1kSfs3rI/PFc3sHv5x6reXtBm7Vp
	 +FvxUnL2+3yPwM5YkFek47X9cSrR/yOKM7UOPrpxm8sJMKX4EBG0LiFtpfcekvWsJR
	 GxKNBLVdWhBQr8Hxom/qE6f9Na6/Ir9bVKeA68nw+lTEUVMa8ugz+YjZpVoURwLt5d
	 uz2/eSWb9Vs3bysIGoQjfVOogGPGdjXNl4kcIxzETfRESZuAk0WCEpxbDM0hKizB/m
	 zS4ymXJcPdbtxcyHe5F+ytXdXT6n+2qECyQVRfBWxW82yY2GoSHNJojvExnGLkurVJ
	 sxTQec9UfqrHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	kernel test robot <lkp@intel.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] net/smc: rdma write inline if qp has sufficient inline space
Date: Thu, 20 Aug 2026 09:53:13 -0400
Message-ID: <20260820135314.1705359-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081711-stamina-rebuttal-bfcf@gregkh>
References: <2026081711-stamina-rebuttal-bfcf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangguan Wang <guangguan.wang@linux.alibaba.com>

[ Upstream commit 793a7df63071eb09e5b88addf2a569d7bfd3c973 ]

Rdma write with inline flag when sending small packages,
whose length is shorter than the qp's max_inline_data, can
help reducing latency.

In my test environment, which are 2 VMs running on the same
physical host and whose NICs(ConnectX-4Lx) are working on
SR-IOV mode, qperf shows 0.5us-0.7us improvement in latency.

Test command:
server: smc_run taskset -c 1 qperf
client: smc_run taskset -c 1 qperf <server ip> -oo \
		msg_size:1:2K:*2 -t 30 -vu tcp_lat

The results shown below:
msgsize     before       after
1B          11.2 us      10.6 us (-0.6 us)
2B          11.2 us      10.7 us (-0.5 us)
4B          11.3 us      10.7 us (-0.6 us)
8B          11.2 us      10.6 us (-0.6 us)
16B         11.3 us      10.7 us (-0.6 us)
32B         11.3 us      10.6 us (-0.7 us)
64B         11.2 us      11.2 us (0 us)
128B        11.2 us      11.2 us (0 us)
256B        11.2 us      11.2 us (0 us)
512B        11.4 us      11.3 us (-0.1 us)
1KB         11.4 us      11.5 us (0.1 us)
2KB         11.5 us      11.5 us (0 us)

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
Tested-by: kernel test robot <lkp@intel.com>
Acked-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 5d9686af2976 ("net: smc: fix splice entry lifetime imbalance in smc_rx_splice")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_tx.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 2429f9fc7e0e7..3a2748bc4beaf 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -320,12 +320,20 @@ static int smcr_tx_rdma_writes(struct smc_connection *conn, size_t len,
 	int rc;
 
 	for (dstchunk = 0; dstchunk < 2; dstchunk++) {
-		struct ib_sge *sge =
-			wr_rdma_buf->wr_tx_rdma[dstchunk].wr.sg_list;
+		struct ib_rdma_wr *wr = &wr_rdma_buf->wr_tx_rdma[dstchunk];
+		struct ib_sge *sge = wr->wr.sg_list;
+		u64 base_addr = dma_addr;
+
+		if (dst_len < link->qp_attr.cap.max_inline_data) {
+			base_addr = (uintptr_t)conn->sndbuf_desc->cpu_addr;
+			wr->wr.send_flags |= IB_SEND_INLINE;
+		} else {
+			wr->wr.send_flags &= ~IB_SEND_INLINE;
+		}
 
 		num_sges = 0;
 		for (srcchunk = 0; srcchunk < 2; srcchunk++) {
-			sge[srcchunk].addr = dma_addr + src_off;
+			sge[srcchunk].addr = base_addr + src_off;
 			sge[srcchunk].length = src_len;
 			num_sges++;
 
@@ -339,8 +347,7 @@ static int smcr_tx_rdma_writes(struct smc_connection *conn, size_t len,
 			src_len = dst_len - src_len; /* remainder */
 			src_len_sum += src_len;
 		}
-		rc = smc_tx_rdma_write(conn, dst_off, num_sges,
-				       &wr_rdma_buf->wr_tx_rdma[dstchunk]);
+		rc = smc_tx_rdma_write(conn, dst_off, num_sges, wr);
 		if (rc)
 			return rc;
 		if (dst_len_sum == len)
-- 
2.53.0

