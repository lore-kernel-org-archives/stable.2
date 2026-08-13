Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C5A3AEF54;
	Thu, 13 Aug 2026 05:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786598074; cv=none; b=khrkx6MzwJMnYjtZqmxaHhBT/7iRDBpuuBgAUHXE7O5KwRhDvvRcE+edNAXDAabF5su7smTzhpOmFsgJfZJEfFhw+esymQMSF2zZ1aq8d0RGR0lrTztWYQmuIQGObd1xu3dnWHusOFmzS1rkJ8FTRu4L6a3Ks4PwRMpYdebyf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786598074; c=relaxed/simple;
	bh=U359jvgB9lHxFvzrB10D/cY7D4DIMzHLKnRI9pPFbJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EEEdVvwvq1av4pqe3T2fREi/+iilCamLFxO9ZHWOSH3p/lf0649JbY74NKugPUunS2naNVoqdwLk73h6hGlR0zQBKzA+jK+TkGb3Ttjsj1LjSQt5maTSVofewikYlPfVH1TOR5spuAT1vqTWo9VquZV9Wu1G4Fu1rwF+/RsMm6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=A+C/oUoy; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A+C/oUoy"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D37hJ12061660;
	Thu, 13 Aug 2026 05:13:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=RjoX7sKAdg7B6M+YOHHZVDhjBV3ZT
	tvzwcbFoavO/n4=; b=A+C/oUoy1yFof8LfftD8EFxpN027HwjCCTUU/zY9M0GTG
	LynotjE2cq6K5GbLXV+lZLqcB/7nAl1uDd9fWTBcBKy47X+nCy6FmYDVGzALjR5K
	cdtMp078DAW6YXUWTJeQZPMKdmvkQHrs6suvdAQ0ies/etc+SMFoVZWD4L8liLSl
	iXzXRqOpv3lv+oaBofR9U9tECw/RQRiRstVSrHXvIXofAnYKzuLBdx50/AQ3KBD+
	Sn/vF0WT+yYblQimGMztN3/3j0OzHzCmS32wQE8hkVCyQnAHZ2TyW54Kr2fI+tYc
	u8/2IpJi5rpI9i2tK+KlB4cyTn06Vs0qlIq1+nURQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvhe01m1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 05:13:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67D55mpi027729;
	Thu, 13 Aug 2026 05:13:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwsjwf7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 05:13:16 +0000 (GMT)
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67D5DF9F008193;
	Thu, 13 Aug 2026 05:13:15 GMT
Received: from aakhoje-nft-test1.osdevelopmeniad.oraclevcn.com (aakhoje-nft-test1.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.248.219])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 4fwtwsjwex-1;
	Thu, 13 Aug 2026 05:13:15 +0000 (GMT)
From: Anand Khoje <anand.a.khoje@oracle.com>
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Abhijit Gangurde <abhijit.gangurde@amd.com>,
        Shannon Nelson <sln@onemain.com>, Leon Romanovsky <leon@kernel.org>,
        Eric Joyner <eric.joyner@amd.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Kees Cook <kees@kernel.org>, Mohammad Heib <mheib@redhat.com>,
        Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: anand.a.khoje@oracle.com
Subject: [PATCH net-next v2] net/ionic: avoid OOB TX partner lookup for hwstamp RXQ
Date: Thu, 13 Aug 2026 05:13:15 +0000
Message-ID: <20260813051315.430146-1-anand.a.khoje@oracle.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608130033
X-Proofpoint-ORIG-GUID: UFpWOBX7fWQiW0XTXSfV2xFXAafpASTj
X-Proofpoint-GUID: UFpWOBX7fWQiW0XTXSfV2xFXAafpASTj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDAzNCBTYWx0ZWRfX52JmoUyyir8s
 PAbp0WpWnfNY69uVOpjWSxWgP9+oa8me4DQcS+cqV3HfyqJzSkvVM7qtvjWSJlEwHyQyeZMjuG1
 av97ACgQNktbpX/1oEnfMcmmq/UMvrvLq9SEzNAY/4q5cRAwRU542LuGojZQSq0eSExeQyL5vzI
 N2mbafhh7PjJ6/O9U9+wX9QCvJ+erN8//hjhEEfeuQCfGajg3ADYYO3reU3kmI4pm65mLtFKt7P
 EhpohGW1xhVw3pwmO20cdX+3xQkay06ZIO2Z3WAbDT3pDfb+GBVxGZvz9S1vYD0rV9S5h1cAnsX
 /oAYGvSHzL1TTUJvbkOAkGF0lLWHNnVZI6MU/vfNa/Abgfs88QpppKrb6qRLiuhaIjbsvJ9nZA8
 qAiu/XSX2fIuabcDJ7LwhBVytEaMN9lcUWJz7+d/8ERi/TAtbXZXS/k3paZUqsmQRmSlFMm4983
 hqcc0L3MPC4/bFZ4KC91d5m//ciccCzt8uV71nAs=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDAzNCBTYWx0ZWRfX3NzAoW1f6zRz
 NhzGwVB++mNI7A4IZN0CPl1RnEHgnBgshiEJ9UQXDXU0XPjK2P4Q4IIsx3iMMaMddN3GYIMlWqE
 VA+oIxOxBbxAsU6MZSCovpu8hVMo1r1B3VXl4hj7qRmJe6oUMz3O
X-Authority-Analysis: v=2.4 cv=L/YtheT8 c=1 sm=1 tr=0 ts=6a7d526c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=yPCof4ZbAAAA:8 a=vHwtaBK_cnxrrt37sGYA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:12099

The dedicated hardware timestamp RX queue is allocated with q->index
equal to lif->ionic->nrxqs_per_lif. The normal txqcqs array only
contains the regular queue pairs, so using that index to set rxq->partner
can read one entry past txqcqs[] and then write through the derived
pointer.
Only link RX/TX partners for normal queue-pair indexes. Leave the hwstamp
RX queue unpaired, and make the XDP_TX path abort cleanly if an RX queue
has no TX partner.

Fixes: 8eeed8373e1c ("ionic: Add XDP_TX support")
Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
Reviewed-by: Si-Wei Liu <si-wei.liu@oracle.com>
---
v2:
 Fixed the Fixes tag.

 drivers/net/ethernet/pensando/ionic/ionic_lif.c     | 14 ++++++++++++++
 drivers/net/ethernet/pensando/ionic/ionic_txrx.c    |  5 ++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index fd3ee9820531..1822361e1070 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -920,9 +920,23 @@ static int ionic_lif_rxq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	};
 	int err;
 
+	q->partner = NULL;
+
+	/* Only normal RX queues have matching TX queue partners,
+	 * skip partner pairing for hwstamp RX queue.
+	 */
+	if (q->index >= lif->nxqs)
+		goto skip_partner;
+
+	if (WARN_ON_ONCE(!lif->txqcqs ||
+	    q->index >= lif->ionic->ntxqs_per_lif ||
+	    !lif->txqcqs[q->index]))
+		return -EINVAL;
+
 	q->partner = &lif->txqcqs[q->index]->q;
 	q->partner->partner = q;
 
+skip_partner:
 	if (!lif->xdp_prog ||
 	    (lif->xdp_prog->aux && lif->xdp_prog->aux->xdp_has_frags))
 		ctx.cmd.q_init.flags |= cpu_to_le16(IONIC_QINIT_F_SG);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 301ebee2fdc5..73998d61593 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -543,13 +543,18 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		break;
 
 	case XDP_TX:
+		txq = rxq->partner;
+		if (unlikely(!txq)) {
+			err = -EIO;
+			break;
+		}
+
 		xdpf = xdp_convert_buff_to_frame(&xdp_buf);
 		if (!xdpf) {
 			err = -ENOSPC;
 			break;
 		}
 
-		txq = rxq->partner;
 		nq = netdev_get_tx_queue(netdev, txq->index);
 		__netif_tx_lock(nq, smp_processor_id());
 		txq_trans_cond_update(nq);
-- 
2.47.3
