Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72313AAF70;
	Fri, 25 Sep 2026 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790359590; cv=none; b=P5ApgaVZRXjKCTcE5VwPSUc7DLY7GLoeUMCPn1qzYKg7LH8D2+aknTfkgkN7m1eLRtOO8YxThywiHYR9Q3+716irtbE6ucG2XxPiBvar0s/NywQxNBt0Viksezr08Aj5DTW0DKwn4vEkkxUoJRUAN8ZYaEWQf/Db7YFeuN5kgT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790359590; c=relaxed/simple;
	bh=SNYO7NVs+GgNeAgty8lb4AO6zDODG2MfSjdu+pOxETM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hec57e1gAhVLbQqVFDlY/NsByzlLVRgaFs5PfMCnMaUdJRVu0Vv7UFuIsuFXmwMjNbwvrNxCE/7Q/Wa/bOyD9eRzeLdUWC6Be+39SzEFIKtKoPhROrW0rBmQd7Sa6YX+kOqQ3Fg7cKsHMb/aRX4mDQojpyBhOAYwvsBouPh5e0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hgyMjH9o; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hgyMjH9o"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG5SAS1556318;
	Fri, 25 Sep 2026 18:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DiRC9dA2hvXehvHrZ
	LvtGNleHCVhLG/kEjs+ZK0uOrk=; b=hgyMjH9oS6QGMCxS0OOs461To1BlE9wzs
	pTTF5BtMPkjSy0XnlKh7bxYCX87jZPCNotuJk57sJDp58iCYPgfrFGwJi/PGdBOc
	BLXM6NFcTL6zHN5l3gXh0/B/biiPNEcZSd1zEJQCZ6zYhyw9XwxkK4qScALEgNaw
	7Wxm8blKoX9QDKIVAWTaLlZnZYn4GHX/o+wk5XceFlaVF0q68fni0xHqWbb0o0LI
	PcYLQQNFRXbUrvQfsPUz2tmft3XyCwvsUSCDDJZmvPXlQ2TpPuOkT3eecL7wzmWX
	7z9FS7eXrkg9hy9ymZQAR/XHPxp+u2Bcx9pLEM5CyIYqjfewUzIcA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvqfwk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:06:10 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PG39au4186670;
	Fri, 25 Sep 2026 18:06:09 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe23fyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 18:06:09 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PI67iA64291276
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 18:06:07 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 91BD258055;
	Fri, 25 Sep 2026 18:06:07 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B560A58059;
	Fri, 25 Sep 2026 18:06:03 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.6.174])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 18:06:03 +0000 (GMT)
From: Mingming Cao <mmc@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
        edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
        nnac123@linux.ibm.com, maddy@linux.ibm.com, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, davemarq@linux.ibm.com,
        bjking1@linux.ibm.com, Mingming Cao <mmc@linux.ibm.com>,
        shaik.abdulla1@ibm.com, stable@vger.kernel.org
Subject: [PATCH net 1/2] ibmveth: h_free logical LAN on open-fail after register
Date: Fri, 25 Sep 2026 11:05:29 -0700
Message-Id: <7a56fbfb9e0674f011f4e310fbd7dfd8e67c30aa.1790357373.git.mmc@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Mg0Z59Vwzm7Hzb2OoMxJYJLsDltQwhk6
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA3MiBTYWx0ZWRfX6TdMairycIER
 xWW0ISja2//HVLFX4euVaJjOjpAbvoyAI+1uRGEMhBJZGcfwJVew8cVQtoWdEC8IhG6Om7C5f5s
 DG1XYnyqAGAn91XULB41/DRZeshom9o=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab6b812 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=YwJyo6ll96k2yfcBO2wA:9
X-Proofpoint-GUID: HeVpEW0a7N1XleYYX_tLGJUGRYZfPjXs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA3MiBTYWx0ZWRfX3t1pb+K2xYpT
 g8brkhKqOW3n06EAqFdD8Iscg/hbneJy43aELnpTC/EksGB+DN0gcayn1IouEba9LWvxpNgsRO0
 yagWlzWmaZK2MQtvbSMCEWaM9JrdB4wUekWPeTYceyYSvgSWizO0nBEvyy7WRx0dw2E7Uyr6hng
 3im7AOxNNd6r6ULMCMF/CaCJ+JT1NAFTkIBpD5lDtd+L7y5a60U68MzECRU4coFwmd7gBr2PLih
 pgxehUIgjzgZnDGWfsBtXEzjw/I0h853YgH8L6KLoB59LAB5fUjZJIg8fsU8w4oby6oeweAyVsd
 +HQItrtYMu0JhnQEnivNCtQjXBKOWuaATpvVdBs8TvuWf20qzlNP6zC/gPBQNxAz4uSkxnrXfpI
 IPP75csCTdZKXUflJ5RoynI/GbwjJqD1ovIYWfzeif+hRYfJ4hDXyiynatZzXhUa7WXq3Xsva5v
 T/u/N3cozZfmaLhHZXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609250072

ibmveth_open() registers the logical LAN, then allocates the RX
buffer pools. A pool failure jumps to out_free_buffer_pools without
h_free_logical_lan(), so PHYP still owns the buffer-list page when
it is unmapped. request_irq() failure already issued the hypercall
before taking the same label.

Move that h_free to the shared post-register unwind so both paths
deregister before the buffer list is unmapped.

Fixes: d43732ce021f ("ibmveth: properly unwind on init errors")
Cc: stable@vger.kernel.org
Signed-off-by: Mingming Cao <mmc@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmveth.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 73e051d26b9d..3e44f6b714d4 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -718,10 +718,6 @@ static int ibmveth_open(struct net_device *netdev)
 	if (rc != 0) {
 		netdev_err(netdev, "unable to request irq 0x%x, rc %d\n",
 			   netdev->irq, rc);
-		do {
-			lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
-		} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
-
 		goto out_free_buffer_pools;
 	}
 
@@ -737,6 +733,9 @@ static int ibmveth_open(struct net_device *netdev)
 	return 0;
 
 out_free_buffer_pools:
+	do {
+		lpar_rc = h_free_logical_lan(adapter->vdev->unit_address);
+	} while (H_IS_LONG_BUSY(lpar_rc) || (lpar_rc == H_BUSY));
 	while (--i >= 0) {
 		if (adapter->rx_buff_pool[i].active)
 			ibmveth_free_buffer_pool(adapter,
-- 
2.50.1 (Apple Git-155)

