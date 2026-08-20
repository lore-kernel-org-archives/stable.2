Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE5142A7BC
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787229558; cv=none; b=FMoofd7Id8OVyihJQmXSzwxerwJLRBrFWWeP56lGpb7y6lK9ZB5MSCWUvEJcX7QiJFk3Tj6/w/AH4t6gUI6XWsbu/Lgkv4gOtRoSQjuJgEZUJovSvDc+HmMMV+OVUUN7UEU+hb1qnI1vHV3Rnlwj9dLNv4355P24Nm4qcrEClrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787229558; c=relaxed/simple;
	bh=3J+tdXkGlev+fbhl4HW1jEMmfHe+6NR1I3/DkToWCog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1jgw5hhkVprksIxPMz0TzkMExTDljx+Qaa5iGrrUCWSgvV9u6ihGPkDkVeJtA7gV7dl3wKTy9IK99OewuGNg5nNmQJRj2ez5mCI8IUmY2722v0tmmD5g39GTICEP738pa4w6Kh2BCnhTpuziqCgXYhABgo6YbEi0EP580hF0Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sj4CoxzU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sj4CoxzU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0A21F00A3A;
	Thu, 20 Aug 2026 12:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787229556;
	bh=Oi5mQJ/98/arNBwVJveIlokeuJIHhvWkjEYp1FmuhyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sj4CoxzU8dBF9CKn8XxKA7c9DUIYe39DNj5hfmZvqVZI0/+9rPfP2yyoWSc9njb8I
	 RHLm/V5dxd/Pya8Pz1H7StQbD1pe1my+q6+7UfVCL8cMo25CM4K2nSq7oBriwNYzik
	 BSIql7cEnj27irz9rtfiEwrC7SjYO8gx/Y+2KJorlmLSFWugmA2r5nTO3qgSwl1hgJ
	 Ps7xN8xeHiETxYPPwCZM6pHYSxLk436ti/nWx/KXpGTFA/lXvTh9t32lEit63pV1CE
	 Lwa9hZbZMgGFJlsI2I7ZEHPgH+RdA6bHZgb8/C9YRnqnJZmXT7KC9LSpYoo+TCM3nf
	 iiACRCQ0IMs2g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangguan Wang <guangguan.wang@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	kernel test robot <lkp@intel.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] net/smc: rdma write inline if qp has sufficient inline space
Date: Thu, 20 Aug 2026 08:39:13 -0400
Message-ID: <20260820123914.1615169-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081710-untie-barn-6dcc@gregkh>
References: <2026081710-untie-barn-6dcc@gregkh>
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
index a878ea084dbd6..eb03fd0f6dc8d 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -333,12 +333,20 @@ static int smcr_tx_rdma_writes(struct smc_connection *conn, size_t len,
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
 
@@ -352,8 +360,7 @@ static int smcr_tx_rdma_writes(struct smc_connection *conn, size_t len,
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

