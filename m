Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680174;
	b=UP1C7u66yr0FioEwRd8bwBIHw8YXuibaJZUgEXT8YEyxe8dnujA5r98spiKHCnYeFsVf
	 tDrFh1VuPoKsLr2Bwul2LkbDjgBnNrlrPN+uYDGNeGHapCIWfSh3DE8ZE6u7M6nvX40zV
	 dT8N5bfk6tI1LQtY6uv4V4hl3MddDOsvJejy+LTXFCQIqk+AqbiZQweOQEB4dj7P+q+tD
	 Iuwd7YaUlV7UzS8uSBu/LmbMp/xBlJNbeniIlrAcTK6xmmu5WHS0M2qeXwsLWkbmOvYD4
	 5Bkv29CT9+CpXZYHwo4ZYmvjYxA5k83SjCCKw4EZFWq3R67VkjEZVvSjPXgt4NV6LQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680174;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vrcWaHVIeX4mO1LrsCPWfI2eA+VxsiZCBF7UZYtiUaw=;
	b=m00lbijWXuidz4YQfSV6Q7BrPSOQ7AuQfEKfX/ehORRzShgFuzuMEAU7LrYNqBCNqWnL
	 NCCO0zXwkONzH5VldmmC3KFRoPjMpoullDHQ95dzxj9XcT5WknWywdgenieVRJH2wGyfS
	 rzmoaU/BexQtmcWaWAyTGCCZCqxMyLNF13ZQBxhJ6suTagVGprKfB4Bpz045+V6wOd/mh
	 9aqpK532DHTlEMOefhhUTn8ihCwoXOLnLmVczHYpfHZ1DWhoKYxkIeCH1mb3zw6NbTCDJ
	 ObEnaKoB7z8fFcex3CN0PbuvlQ/Yk4S33082AXKTeKwzBV6fWqxHAcT+BVk+/qKgJxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=embSkSZV;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B147606A31B;
	Thu, 22 Oct 2026 14:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B147606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=embSkSZV
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEFUHR4098306;
	Thu, 22 Oct 2026 14:42:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=vrcWaHVIeX4
	mO1LrsCPWfI2eA+VxsiZCBF7UZYtiUaw=; b=embSkSZV9AlrbM5gQ8OzDdAS+YN
	D/Up2bPy150kfYo+2v31LdDTrRwxX0LLdDbLNY6NC7+XJ9SW+K58kvHzuA3J90ON
	P8dnc5CdTwinlG0Zoeuir19Zk9NcZrtTfBO/cGtnG43QOD6GIJW/Y4krs3SedYQj
	TaE40y2qdwwu/gWg173Qp+mPBnLgHyNvqhm2JdOEi6OQEnAtFRPMS7OVmzCVPy9V
	Ho0/ley46omvlS5bjneHkZcof6s9T8cX563HJxDm3dgTZlDmW+Q+iQhMS7MXKMAC
	NdDl+1gYCTT18USg1tnbS7K2cQ6wJbAfcLGbTKvF6sxT/PjMHFW/9/u2EZA==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq337a-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 14:42:45 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEfW141932678;
	Thu, 22 Oct 2026 14:41:32 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-mohis-hyd.qualcomm.com [10.147.253.64])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 69MEfVCV1932658
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 14:41:31 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4840500)
	id D4596639; Thu, 22 Oct 2026 20:11:30 +0530 (+0530)
From: Mohit Sharma <mohit.sharma@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mohit Sharma <mohit.sharma@oss.qualcomm.com>, stable@vger.kernel.org
Subject: [PATCH 1/2] ASoC: qcom: q6apm: Guard callbacks until probe data is ready
Date: Thu, 22 Oct 2026 20:11:29 +0530
Message-Id: <20261022144130.2443667-2-mohit.sharma@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261022144130.2443667-1-mohit.sharma@oss.qualcomm.com>
References: <20261022144130.2443667-1-mohit.sharma@oss.qualcomm.com>
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
X-Proofpoint-GUID: wglhc3ftu4akMWXr7lmt-vRb-Cx85mvx
X-Proofpoint-ORIG-GUID: wglhc3ftu4akMWXr7lmt-vRb-Cx85mvx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1OCBTYWx0ZWRfXyi9Iv5zho5fa
 slWNbpk7mz7gMndP95rH5lC5JNvDH2TR1h4Z0W3uockMWR5I1k7zJXtNnjFNmcW8exgA4ZdDGk5
 Bcu8tQ8Jh5HMsFQCd2Q+szOCvgPFO+c=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada20e6 cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=CQ11ig6xNshaWAb830gA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1OCBTYWx0ZWRfX9j93riZ0B+3W
 8Av3+KRDtmgZor52WTssmqY06fVGDo1+A5sN/1+2WNKsEBIDB6j4Vms4FwsnZupvOVLRjMmperZ
 nHzVEQGbIxWdWVi+6OO0P14yyAIZB9jF4q+2A2TrbHdAN/TTjridkTgflXDz7TDKZA4a8XC5Bzp
 rqmPxRnhdxpCGU5q58wwiBExQ4f1ePrOwjwCCsDOdSDObp4ug0Fb7Uo9U8o/7mn9hBhQ79yv6N3
 Q+Kam/MW7yPNagdhChFl8nyVAVd/tdyZ1tNm+cDs2zltZ7tQik7Ury/J0OjULWR7hLRNdS2DbQ/
 Qt18jsKFViMC7CP6gNlKjbOgH0+aULt4zu2Ou9m5cnJHQNgrE8tbsZa0qMKpp0W1mKJgJVFNAAU
 ws6yXZK22nBKkt8mN3Phbss8GVsdJCgWXvJvMpSaW97YdQcTW5BJmkJ6treNtxGogiLGwc3kK5i
 Nln//3clizBc5zBteyg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220058

The GPR bus needs to make response callbacks available before invoking a
client probe because clients can issue synchronous commands from probe.
This creates a short interval where a callback can run before the client
has published its private data.

Make q6apm publish its driver data only after all callback-visible state
has been initialized. Have the q6apm and q6prm callbacks ignore packets
received before driver data is available.

Fixes: ec1471a898cc ("soc: qcom: apr: Add GPR support")
Cc: stable@vger.kernel.org
Co-developed-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Mohit Sharma <mohit.sharma@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm.c | 6 ++++--
 sound/soc/qcom/qdsp6/q6prm.c | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 3ec3c5a18c7a..dbebb643cd5e 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -872,8 +872,6 @@ static int apm_probe(gpr_device_t *gdev)
 	if (!apm)
 		return -ENOMEM;
 
-	dev_set_drvdata(dev, apm);
-
 	mutex_init(&apm->lock);
 	apm->dev = dev;
 	apm->gdev = gdev;
@@ -887,6 +885,7 @@ static int apm_probe(gpr_device_t *gdev)
 
 	idr_init(&apm->modules_idr);
 
+	dev_set_drvdata(dev, apm);
 	g_apm = apm;
 
 	q6apm_get_apm_state(apm);
@@ -930,6 +929,9 @@ static int apm_callback(const struct gpr_resp_pkt *data, void *priv, int op)
 	const struct gpr_hdr *hdr = &data->hdr;
 	int graph_id, is_pos_buf;
 
+	if (!apm)
+		return 0;
+
 	result = data->payload;
 
 	switch (hdr->opcode) {
diff --git a/sound/soc/qcom/qdsp6/q6prm.c b/sound/soc/qcom/qdsp6/q6prm.c
index 2042ff1e8ff1..5c927ebd81f4 100644
--- a/sound/soc/qcom/qdsp6/q6prm.c
+++ b/sound/soc/qcom/qdsp6/q6prm.c
@@ -194,6 +194,9 @@ static int prm_callback(const struct gpr_resp_pkt *data, void *priv, int op)
 	const struct gpr_ibasic_rsp_result_t *result;
 	const struct gpr_hdr *hdr = &data->hdr;
 
+	if (!prm)
+		return 0;
+
 	switch (hdr->opcode) {
 	case PRM_CMD_RSP_REQUEST_HW_RSC:
 	case PRM_CMD_RSP_RELEASE_HW_RSC:
-- 
2.34.1
