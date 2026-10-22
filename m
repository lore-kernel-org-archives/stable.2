Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792680471;
	b=sYD59j4/Y4L/5idVJyYjjuF1l46bJetZv0gdIGnVmygKe/HO7Q3KJmBayDRWtWXuSAYM
	 sj4zqLnQQNFTRjzrKi//OKvkR9IGvhjGwwHXLtcqE1VOJDgc2PxmQKGCpLFafelokqI+7
	 FF+4uZd2k8bhdOnCtR3uB+WdEvsgnAS2NvaJqdPOalM5mpnBRS9zR5V7w02GN56b+0BhR
	 ZLxGSkMpI0pni+guXrI89YQBZzYvVFloSHDBYMHXQJlG0IbU6kJgZ+nN0W2CVpyj2B5eu
	 xH84VpxFrL1QqHQWN8IGK87r1tdI+4Jgdnfd2ScTZ3a/QjOqBAx7kZB2eYvkQytVIyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792680471;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:
	 X-Proofpoint-Reinject:X-QCInternal:X-QCInternal:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UUSDmlVMcwhr9iutDz3uUlfo+9Wxwrfjom0SeIArEXE=;
	b=S462VJHJcFiOU61tmzmNMRaVATRJNb07WqhkB5WSRcps5S3AM0cYBmmeGzY9AbVFA10z
	 dh2M9a2/2edHzL8gNDom+hvAlwWPSeDkXtOVmTSGPkjEAsGwki5bLGRhZUgFO6cC1v3Gc
	 eA5eDY20K5qCpBN4oD4eftLME0JjWWoPnRLhs+YL91T6F6n6LcPzn7ywDLv9JY175cPnd
	 Vpp6xbk8p4wdvVUzoSKEdXXojakhzSsjwvYFHkIzkSVyVpz7lRSmYmcK5GVulADbRbdJr
	 xULniTvtzzycLlU4BUAzDOMBvT62ELmT3SjHU7p2b14Lzk0mcJQTK0hdcT01zUFFkUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f4Ma57WR;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A0B606A324;
	Thu, 22 Oct 2026 14:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6A0B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=f4Ma57WR
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEFUmR4098301;
	Thu, 22 Oct 2026 14:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UUSDmlVMcwh
	r9iutDz3uUlfo+9Wxwrfjom0SeIArEXE=; b=f4Ma57WRIqhZSzt46TiyC57qZhX
	S5RyeQJhuHdIcAeXzQnZ+0fIo3zCQTgEPFWqgl4hEfHKxlDSt9lBv9cuUuGSK+dr
	wbK2j2kbcZttbP5suPr4DMUqD880VspjeKFGMGlNZotnAtZ+Xwb+QkvKS83QZiO8
	ptmhsVMJ2GngEpzVc2JB0Dj8IWRUeTai03KTRgfzMUHILSA9DUIFmLm54hoVwMOI
	NqZCGizVueor6qyYOZ9GOMn/+waXldVQ29d6tq0a3dnnGQjkwLI5i4RGt381sRyB
	BE2jkdWNp1adV9Pi4rg06r1H5nctBEOQIpcNKqljHIuQ147hKwiI2LbpqrQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfewq33w6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 14:47:43 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEfWbj1932677;
	Thu, 22 Oct 2026 14:41:32 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-mohis-hyd.qualcomm.com [10.147.253.64])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 69MEfVmS1932657
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 14:41:31 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4840500)
	id D4F8065A; Thu, 22 Oct 2026 20:11:30 +0530 (+0530)
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
Subject: [PATCH 2/2] soc: qcom: apr: Publish GPR callback before client probe
Date: Thu, 22 Oct 2026 20:11:30 +0530
Message-Id: <20261022144130.2443667-3-mohit.sharma@oss.qualcomm.com>
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
X-Proofpoint-GUID: DN5y412NKtRmmEGG_ZXkBzbD-ZOv26nM
X-Proofpoint-ORIG-GUID: DN5y412NKtRmmEGG_ZXkBzbD-ZOv26nM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1OCBTYWx0ZWRfX2/Oe6Hy2TyLi
 C8HapLbTFBMuVe41S3s5QFJNX6ql3TQ8XS1WyMa2Gj5ZJfkJarzISF33B+zN9epLdzdDpuqmk8T
 LLgHr+6V+i0OZeYqvQKmCbAxxZkR8jw=
X-Authority-Analysis: v=2.4 cv=G4OJgNk5 c=1 sm=1 tr=0 ts=6ada220f cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=gUX7mVKeEC_5i4-4ascA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1OCBTYWx0ZWRfX/GtrjWmIuFVZ
 l0tFg/iEG90uzx3nucTubDVlwdGsKw6/x2YjX1+2gZwI/AeoFSNh9Lz8DDZZWg6Toq1h7Gejiv7
 wa+LT7VxjPPXx5FLc32ctQKk7cGcCLCwphDtkFBMllbrc2BuGnLgjVfzEEWcv/NZQXoaKoRrc5o
 +XKfI2XWJLO6HbmiqvR03Dh+rM/FAgD24QZjW0Cr88AYO7PQ3ZVUPyVF3GWd3H9w7ckALGv8oN/
 6bdIhNbdmzUIk4DwZgZyr45t662vHnGk0F2e9JV7zsoyOXieW7Yo+C/F/hh63JlDowt0FMbbyiJ
 CCs4tPkZQLsfBAY2mevkn889Qa98jdu/81fnMQGOyCWT+yONczurOhic+qZWsgrCtuKaRNoOI5V
 zt7cCHn/XJmWzEWBRPkPk/Z/Qh9shFoQ8jkNSlNnqJN6tHtShTcKceIdJULSTUBAihdkcwj41H1
 cVZ3zax9IFCQ0tpvX6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220058

A GPR service driver can issue synchronous commands from its probe path,
or populate child devices which issue commands before the parent probe
returns. The APR/GPR bus currently installs the GPR service callback only
after the service driver's probe has completed.

If a response arrives while the client probe is still running, GPR finds
the destination service but cannot dispatch the response because the
service callback is NULL. The client waiting for the response eventually
times out.

This was observed intermittently on Qualcomm Lemans and Monaco platforms
when q6apm child probing sent an APM shared-memory map command before the
parent probe returned. The failure has the following signature:

  qcom-apm ... CMD timeout for [100100c] opcode
  q6apm-dai ... Audio Start: Buffer Allocation failed rc = -110
  snd-sc8280xp ... ASoC: can't create pcm MultiMedia1 Playback :-110

Install the GPR callback before invoking the client probe so responses to
probe-time commands can be dispatched. Clear the callback again if probe
fails, and preserve the existing callback ordering for APR clients.

Fixes: ec1471a898cc ("soc: qcom: apr: Add GPR support")
Cc: stable@vger.kernel.org
Co-developed-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>
Signed-off-by: Mohit Sharma <mohit.sharma@oss.qualcomm.com>
---
 drivers/soc/qcom/apr.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index ea7f83916d8d..829e5c8fdf98 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -365,13 +365,24 @@ static int apr_device_probe(struct device *dev)
 {
 	struct apr_device *adev = to_apr_device(dev);
 	struct apr_driver *adrv = to_apr_driver(dev->driver);
+	struct packet_router *apr = dev_get_drvdata(dev->parent);
 	int ret;
 
+	if (apr->type == PR_TYPE_GPR)
+		adev->svc.callback = adrv->gpr_callback;
+
 	ret = adrv->probe(adev);
-	if (!ret)
+	if (ret) {
+		if (apr->type == PR_TYPE_GPR)
+			adev->svc.callback = NULL;
+
+		return ret;
+	}
+
+	if (apr->type != PR_TYPE_GPR)
 		adev->svc.callback = adrv->gpr_callback;
 
-	return ret;
+	return 0;
 }
 
 static void apr_device_remove(struct device *dev)
-- 
2.34.1
