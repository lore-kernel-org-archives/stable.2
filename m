Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80934D0CE1;
	Fri, 25 Sep 2026 18:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359592; cv=none; b=dLhB/pf81nWgXq/nqlu363FyOpbPw08XvyuaQe0Tg6XAQ2Viym81f5s2PEkRoIxVIKbE+q10b0FCgxJbGah53dNNQakSCIsjy0eInLUc1vZOBzNQ5qdiQceQ+DLt8hf0mBzf5nutZdg8OAtXXITZjEbjhn6y5tKGhzDFvEIt4+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359592; c=relaxed/simple;
	bh=jxLM5he2QdFIqXe6uWLU4HkdwLIfgqAXOLo/DeH8T/0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uMI9fxijJJxmUh2ceTWJIjpvQaI6lkXPH1a9r6XVgUwPh1P+ekT/yoN8+AF+hBdM+YzQmB9OhhHIFoSKaH/9wAnc3XmqYutssPaCVFWAIiVbFWEk28ZETrvWjim/k5O3FTxVC6VFtd4gT4n0LW7jdD5MxZx1cjNW+nUtXiKDxOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QlzNcIc7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QlzNcIc7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG5Q7U1513469;
	Fri, 25 Sep 2026 18:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Tr1wRnlJSSblAHWdX
	9jLq0PeMJPxvFseSvgLSm0TABE=; b=QlzNcIc7GZpkb/t8El1bXu4bvXpp729/l
	JnL/drSwBbeFPp+K8vGpP07kxWQEKZidMbHGcM/9vC7b2qAYCM8m0cXpNMWdX6+p
	8X4YeQ7yg5fT0HabmJe7WxML+zIo8qFdRxOaph6bazP3i4Shv13u5uOi9gaS32Ab
	7kC/7E43UTlM5Q6a9dE0GbmiGePA6rhGqYnDl2UCD2sCLz1EP8a2ZwcsG8poIIyo
	QCCsjsdjyTZxupjHZ7d7GbzdbSSkTBCn93dgIsLhaDnotb3KZUDXbAgq/mka93dZ
	CCwNOuMetXRfwfqEqitSAw69ZAzFO/M57+afH1ffaQTc6xrzCs0Xw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsreuj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:06:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG35RY2859248;
	Fri, 25 Sep 2026 18:06:15 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvu7efpct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:06:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PI6DTZ29229626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:06:13 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D6CA58065;
	Fri, 25 Sep 2026 18:06:13 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD5C458059;
	Fri, 25 Sep 2026 18:06:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.6.174])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 18:06:10 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, Mingming Cao <mmc@linux.ibm.com>,
        shaik.abdulla1@ibm.com, stable@vger.kernel.org
Subject: [PATCH net 2/2] ibmveth: fix TX LTB and filter unwind on open-fail
Date: Fri, 25 Sep 2026 11:05:30 -0700
Message-Id: <d14314c2b10f125f5e578782484ba3cc50564d53.1790357373.git.mmc@linux.ibm.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <cover.1790357373.git.mmc@linux.ibm.com>
References: <cover.1790357373.git.mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab6b818 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=AH3WPYaT6UqvX0A6lMAA:9
X-Proofpoint-ORIG-GUID: iLJTvf4xjBErxaFqs6pbDS2hrACzou3m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MiBTYWx0ZWRfX2habhu6s6pCI
 ot/T/GWC00o6aY3/aHJv39dkA2uX8sqGEYe2XiGv5b/syaGD9Z+7ZqvmWSUj6Yi5mjBgp0Z/Iq9
 HBclFuz5PYNypL4EfseMxdRxcDdcslY4C7vBT3o/b1c0gIrhQHDX7k0c0zGHuc/glfrl3pzXvoL
 48uQsRHwGDZlSx89VUeeFW0UUtHKbt5e08MdtgrCMPr0ZGgtSRxoj+bBWuYaoOrvK2hYe9WziOa
 YdSaxTRDrbkbQxRnl0Z4of1WQcqr4Ml6Mp2a41Yk3diSmO+8MwxC7lKYK8jg9YGVUEV5HbfKwvj
 iDHhfhc7Zolu/w2HIgi/VmaqCizYyTjwWcydU7tkutnPM4NxC83lSoydtIsIo6sqa/V7W/uMgpB
 qNfPV1ylNZV9kCbnAG4zUqWolUgKpvPjwfsYUsB22WsSDAOHzxb43t2oIke6PvWFCas2na9Jd8q
 1/qoGvMPdBXI45phjzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MiBTYWx0ZWRfX7cvWag620ZId
 vBzUkNdH+OVA7MDvTghmGnLwKScQ4DIGb8W2GmbuS5kAey6rie808VfeAG65cU3As/Or8b802Ca
 TyGiHex2e1SBcSxKDUspMNCQoulq9V0=
X-Proofpoint-GUID: pdW0s0SLYHtIMs_2NBtG-hMIHT7Coz89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1011 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250072

out_free_buffer_pools reuses open()'s loop index for the TX LTB
walk. After the pool unwind i is -1, so the TX buffers allocated
earlier are leaked. request_irq() failure has the same leak.

The TX-fail goto on that walk also skips dma_unmap of the filter
list (pre-existing since the LTB was added). Rewrite the TX walk
to real_num_tx_queues with a pointer check, and unmap the filter
list before those frees.

Fixes: d926793c1de9 ("ibmveth: Implement multi queue on xmit")
Cc: stable@vger.kernel.org
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 3e44f6b714d4..abebdb1fc262 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -553,10 +553,15 @@ static int ibmveth_rxq_harvest_buffer(struct ibmveth_adapter *adapter,
 
 static void ibmveth_free_tx_ltb(struct ibmveth_adapter *adapter, int idx)
 {
+	void *ptr = adapter->tx_ltb_ptr[idx];
+
+	if (!ptr)
+		return;
+
+	adapter->tx_ltb_ptr[idx] = NULL;
 	dma_unmap_single(&adapter->vdev->dev, adapter->tx_ltb_dma[idx],
 			 adapter->tx_ltb_size, DMA_TO_DEVICE);
-	kfree(adapter->tx_ltb_ptr[idx]);
-	adapter->tx_ltb_ptr[idx] = NULL;
+	kfree(ptr);
 }
 
 static int ibmveth_allocate_tx_ltb(struct ibmveth_adapter *adapter, int idx)
@@ -667,7 +672,7 @@ static int ibmveth_open(struct net_device *netdev)
 
 	for (i = 0; i < netdev->real_num_tx_queues; i++) {
 		if (ibmveth_allocate_tx_ltb(adapter, i))
-			goto out_free_tx_ltb;
+			goto out_unmap_filter_list;
 	}
 
 	adapter->rx_queue.index = 0;
@@ -745,10 +750,8 @@ static int ibmveth_open(struct net_device *netdev)
 	dma_unmap_single(dev, adapter->filter_list_dma, 4096,
 			 DMA_BIDIRECTIONAL);
 
-out_free_tx_ltb:
-	while (--i >= 0) {
+	for (i = netdev->real_num_tx_queues - 1; i >= 0; i--)
 		ibmveth_free_tx_ltb(adapter, i);
-	}
 
 out_unmap_buffer_list:
 	dma_unmap_single(dev, adapter->buffer_list_dma, 4096,
-- 
2.50.1 (Apple Git-155)

