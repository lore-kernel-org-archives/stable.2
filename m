Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793612894;
	b=FULZDp6A3kdM3AWirJ1njFGLz450llJG5yg8fm8GZ8+d2vEBIOS5ycAttnZvoowNcubM
	 vap5TLT5MpvYMPYzFFLz7mCwELykDzOujbISJ9K6h/P9piL5t+TDM4HPlq2eOXszMjacF
	 K5LMPTjDg/ghMoSK9LdY9TBbnxlU2YNsm7ElES92CGl/jeYgcn7T9lSDwgbB5GUyIevu6
	 E7ilj06qGyFp/lxX08DQlPRPwNgv7O4izE0n0sUjYqQ7DiLIlVDjk9RBewC+gWmjRO678
	 If7w3CAPzuwlimEAmR5p4UK+tlBiXmNw1f1juRjZRb/jihsPRN/AEgvqRDGtL0ytmZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793612894;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Reinject:X-QCInternal:
	 X-QCInternal:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=y99IFQU1Z/zGZnStXTf6TTTZ1kfP+dHEP9lO3wSWaEw=;
	b=VnmcJTYHINdbTMeNO6idw8jLgPSgvucs45fMFiuD5hfuAM8g+E8VY7db0d0M9Wyv4F+N
	 v1ZPSlWigRKLDi7cK6TYvtVEoOKi6/Vvj4AkZ2VGMoRr8Av/vbkVV6UeAb9PHjwBONxxg
	 sXSMHAXSuSDR2jUOqCJyoahhMUH0+TQgOkjGWb4x5xnNo6m+QcA9rySJwsbEmkpiLvrUu
	 KmgXdZeHbsjUNd3UAVPiIGtrbJoYWUOovY9GG8MA4jFC51aKqzHCXeXz41t2WmBzo/nQZ
	 akKwIvQQuD1oyN4AUYNfgLQi0Bc75Rjbds2I+jjOlslLOb90bcCGX/1YVgwnCxrnIrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CXIH8Kzk;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCE2606A327;
	Mon,  2 Nov 2026 09:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CCCE2606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=CXIH8Kzk
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29AQmo3086616;
	Mon, 2 Nov 2026 09:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=y99IFQU1Z/zGZnStXTf6TTTZ1kfP+dHEP9l
	O3wSWaEw=; b=CXIH8KzkTO1VRrOHwyBIFcHrrPAixqmzWMcOUITuTuNeyyewWzn
	VtAed7E5UyxIejohHkZ7T/qYY/BeR4r5hPa/evH/9jUXG0I1e7jdFHVcn7XfaoE3
	jIU9zCeJyxUtx985ybJVZg+bINo/YwU2g+ztALIuuR6E5DM+RYv22zPIciCIJOp7
	OOWTRhUHTe1YCSuv0nbSWCYfXkIn/45g9k8ZZgNziRtqA0Xd3GEdDZJUK5Il4Gvy
	/oHTI74PYfMBPZMOwVRMk7MY9PpcNphF0fgnDoGoGVfAjk6593KxjXYGWLN9vwLc
	8+1zb0v6t6Ra1rgko2mXbPLdejPzcHqATCw==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpka616eg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 09:48:11 +0000 (GMT)
Received: from pps.filterd (aptaippmta01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29m8gx3436119;
	Mon, 2 Nov 2026 09:48:08 GMT
Received: from shuaz-gv.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 6A29m8I43436112
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 09:48:08 +0000 (GMT)
Received: by shuaz-gv.ap.qualcomm.com (Postfix, from userid 4467449)
	id 8A282671; Mon,  2 Nov 2026 17:48:07 +0800 (CST)
From: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        chejiang@qti.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, stable@vger.kernel.org,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: [PATCH v1] power: sequencing: qcom-wcn: increase WCN7850 power-up delay
Date: Mon,  2 Nov 2026 17:48:00 +0800
Message-Id: <20261102094800.3225454-1-shuai.zhang@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-ORIG-GUID: 6iWzyB_znUzkD8RYYlCAUl3ORHK0DJU1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfX+D0J6sTAJ9hP
 km9cQ69FH6eGLxsWDKDT90Cg5YSwkXBFmSdTRRNVP5/erdydrQeHFAPSJDfzxoXhTXRJ8aRb2RC
 5x0vFEgnewKIBdNBVvkaIreuEE4tx4Q=
X-Authority-Analysis: v=2.4 cv=ZbyIpcVA c=1 sm=1 tr=0 ts=6ae85c5b cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=v_2pxYgQTzMkBfL8lxYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOCBTYWx0ZWRfX4o43CnkcceWv
 QqMvCtLaW+kqqk7ZGdJ/UNPnZxsmH/h2nDSuMfd3351YGW9rK9uugOrYxQMcwfmfuJnuF88LUsd
 8YNYXC2GE779n4yiDBxMFCVvY1UfJ3uxTK5sjElglQUtN4OlwS6Ds9QhXKMWXJXdYLfRkl8voED
 5GhsqNwE/OsNrEsm0MqQUhvf/k6HQ2gAXToW0pLYC6HxGwzyrEloIIzHXvAjqxFlPHntpCgd2X4
 zhpXMyeEt1exnoM0LkBEXhjCZNESws1+DN8i5lKPzHSMkGCmDuU7lI0jnVSx2lcESyLz4yWaKJd
 5sVYYG9Bw8TMTi+NQ7m4nNRE+68y0ppc4kyy2COZPmbpKo/LQuritxWZXREofiSkXz1cyqC7Bvw
 Uo3gRUNV0sEhEOijA0NbawlxXlR0O5mkM67x3eh+Jk14/312fLhVvdicJPe0tw6gKd5WbxTI1Ln
 JMQStDfzFjkbRWzzeOQ==
X-Proofpoint-GUID: 6iWzyB_znUzkD8RYYlCAUl3ORHK0DJU1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020038

When the WCN7850 is powered up from the Bluetooth side first, i.e.
BT_EN is asserted while WLAN_EN is still low, the chip starts from a
cold state and is not ready to accept the first HCI command 50 ms after
BT_EN goes high. The first command (0xfc00, read QCA version) is lost,
hci_qca does not resend it and fails after the 2 s command timeout:

  Bluetooth: hci0: Reading QCA version information failed (-110)

When WLAN is powered first, 50 ms is sufficient, so the failure only
shows up in the BT-first ordering. Measured on the affected board by
which enable pin rose first:

  pwup_delay_ms   BT-first boots   with -110
  50              9                9
  75              23               0
  100             21               0
  300             20               0

Raise the power-up delay of WCN7850 to 100 ms. The delay is shared by
the Bluetooth and WLAN targets, so WLAN power-up also waits 50 ms
longer.

Fixes: 2f1630f437df ("power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets")
Signed-off-by: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
---
 drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-qcom-wcn.c b/drivers/power/sequencing/pwrseq-qcom-wcn.c
index 636dd7e63..05ee1785e 100644
--- a/drivers/power/sequencing/pwrseq-qcom-wcn.c
+++ b/drivers/power/sequencing/pwrseq-qcom-wcn.c
@@ -427,7 +427,7 @@ static const char *const pwrseq_wcn7850_vregs[] = {
 static const struct pwrseq_qcom_wcn_pdata pwrseq_wcn7850_of_data = {
 	.vregs = pwrseq_wcn7850_vregs,
 	.num_vregs = ARRAY_SIZE(pwrseq_wcn7850_vregs),
-	.pwup_delay_ms = 50,
+	.pwup_delay_ms = 100,
 	.targets = pwrseq_qcom_wcn_targets,
 };
 
-- 
2.34.1

