Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B75833ADBA;
	Thu, 13 Aug 2026 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786610256; cv=none; b=ZBkSLVGDOfCHN+genHRcclZXDJI86L0UCp0KdnF/Q1AYK8w3iLgJF24km17CCTJMS77TVPlCIJqu2eou/k0e8DT5dunzXmaGYsGv/uiC84W4ZYjipUN2zkTFdkHw6xREfH6m6kPrIaokrl49kAiHVglvYLSSYgdY1SSBFqj1GZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786610256; c=relaxed/simple;
	bh=TTn9Eda849fkaIBj/9PhbfrL3/6oQwM3GhpIjnDjYJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tCXKDOj+XguMt9XgJ6JVob1fD3wkop/M5J4Jk2s7SJ0H8+LHw+S1xqMgiGU51uNLDO9rTbgK1EtozQAD6tlX49wnBUtpdbJrULNFbfUzp7UDyYI9G7loRiC7apCTGVrPBIj2+T1vAoG2wDqJE1qkU8HH3giqc16DiHTsncOJTr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sDBJydZM; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sDBJydZM"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D55QNm882217;
	Thu, 13 Aug 2026 08:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=/oF5rSZLPWg0nT8/VhsIgwjfhCf+V
	Y0gXY97O6C+2Lo=; b=sDBJydZMj5OABLaX5rEGUOvC5dkY0U2XC8cw3S3eIZP31
	3RZCNaYsdEwv06yUxxXmWQSfEewBDYT3eVbfr+gBcB1iYl3hiCbu8wSN8v7G6Dmx
	5022WxDmIq7OKb0u1doHbosPlrmVL87Sur9ZpqpJv4Gwl0N8yXvg/8Vei5N6j26k
	9hpj/2JO986vvpXYsCvEM79Wtwim3sCspZZ4hBn8Ba+0BTOpcYeO12NZoRkiE0LB
	4sHLLfrb/SHlE5f8EqqisygRXbyFAJx0RSkwWRZF3xSDzozJgmOsmtVkM2UsDybP
	9qmpuAPIMRQEfgfAob6iZ1a9P374JRXeXA5Fd+Duw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fwvfy0462-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 08:37:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 67D8ZAl6004086;
	Thu, 13 Aug 2026 08:37:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fwtwg30sx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 08:37:08 +0000 (GMT)
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 67D8b7X7013083;
	Thu, 13 Aug 2026 08:37:07 GMT
Received: from aakhoje-nft-test1.osdevelopmeniad.oraclevcn.com (aakhoje-nft-test1.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.248.219])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4fwtwg30rp-1;
	Thu, 13 Aug 2026 08:37:07 +0000 (GMT)
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
Subject: [PATCH net-next v3] net/ionic: avoid OOB TX partner lookup for hwstamp RXQ
Date: Thu, 13 Aug 2026 08:37:05 +0000
Message-ID: <20260813083705.454897-1-anand.a.khoje@oracle.com>
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
 definitions=2026-08-13_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2608130059
X-Proofpoint-GUID: lK10jHfvO7KXX4oQ4YQEpLPW8KE_DNzP
X-Authority-Analysis: v=2.4 cv=K/sS2SWI c=1 sm=1 tr=0 ts=6a7d8235 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=9UgsCzVKAAAA:8 a=VwQbUJbxAAAA:8
 a=YaXOutoC15Oxm4UVQk0A:9 a=rjeGxHOXENzEDeilVzgO:22
X-Proofpoint-ORIG-GUID: lK10jHfvO7KXX4oQ4YQEpLPW8KE_DNzP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA1OSBTYWx0ZWRfX3PAnMUZ2XCy5
 Aoe8TcSBk9WZJb0gpnEH2TIzS14r7nYruRITunXOV0AdCahfIGGk27ToJeankRxNNQTdWSMvwyJ
 j8ky7TBdnV+PLAE5lwUa1rCsSG/9hRTEFzL9IXSOLEZ1i7M3KqMPhq4vaWlazKM1htSJnfisg97
 CjbPz5qY2Y6MKJXpAKoqq8Vqhqy0fj3ydcKTIhe5Efm150z2RDbNOpYwuAmAN4+U3FN7NoTzOWp
 4zqFCRyfrmhfd2jEDiiFM1aYiAFPMqb5RuzwYSPMmUOZYlMvHGVYUkyVqz8hGTmzEZZNeRUe02t
 7NnlwGbIf2eY2eVlSOPjuEp1uKzXcrFe482X8ZK4QApj7QRrTwjwte5Ki6C/tC99lWn0TXPMgFe
 GkH75X0/OFFDNir8TUFkNsesyVbNYiVoXVk3L3d9KYAG5s2gM2wl6lYuP1EpYF6/wvOIz0zdfX2
 ev9Rj1ML9a4EPpjoTUg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA1OSBTYWx0ZWRfX38ZvCpbOb4g5
 RypC2nol0cEkL+vKDBf5zz/VjYdazBS702sGyfGNOKjExF46Pbp5nulkAtJvd2G6sD3W1TO9RYa
 FnxUU1WE+BMswtm7BQi+ZO4dwQHcs4kjKVheMOXEQ8z4eszr4bwK

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
Reviewed-by: Shannon Nelson <sln@onemain.com>
Cc: stable@vger.kernel.org
---
v3:
 Use dev_err() and return -ENXIO for a missing normal TX partner.

v2:
 Correct the Fixes tag.

 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 17 +++++++++++++++--
 .../net/ethernet/pensando/ionic/ionic_txrx.c    |  7 ++++++-
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index fd3ee98..abc8e35 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -920,8 +920,21 @@ static int ionic_lif_rxq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	};
 	int err;
 
-	q->partner = &lif->txqcqs[q->index]->q;
-	q->partner->partner = q;
+	q->partner = NULL;
+
+	/* Only normal RX queues have matching TX queue partners. */
+	if (q->index < lif->nxqs) {
+		if (!lif->txqcqs ||
+		    q->index >= lif->ionic->ntxqs_per_lif ||
+		    !lif->txqcqs[q->index]) {
+			dev_err(dev, "missing TX queue partner for RX queue %u\n",
+				q->index);
+			return -ENXIO;
+		}
+
+		q->partner = &lif->txqcqs[q->index]->q;
+		q->partner->partner = q;
+	}
 
 	if (!lif->xdp_prog ||
 	    (lif->xdp_prog->aux && lif->xdp_prog->aux->xdp_has_frags))
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 301ebee..73998d6 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -545,13 +545,18 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
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
2.52.0
