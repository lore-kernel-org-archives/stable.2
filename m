Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109D7431E4A
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784804998; cv=none; b=Nd8vtFk6RAK2z5r0XlB2GYFwuP5rG42ME2ETh9nrDDQfwIKIS4klLjUvQaNmDuaeYaFOX4NLf9kRGzAuJ5BHvxoY6SGalwdScJ8T2DIn4o7NLRcE9sCXUM3p3XnYEqJ6mDhg+xDrj+FGvoSv2a9AYw8qmD473FEomXLYlnbBhAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784804998; c=relaxed/simple;
	bh=SKWhPK9r/CD2ee55hEiraz82UixFWuEJolMCsudUorI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GDVxd2mrfVCPDDhNxSuDPEX1N4ntC2yVmvnIUS6nZJf/6Ogw+slUOpv54zZyVIJevTVASKvJvE9VmXnkHsw7KhJIEyI9wzlSpRhX5STU9SjSDkuuESFXWlQyOr8oO3TRYvmvBMrsgRrnJ7Zexo/MOycHPVxyBVAhB2EQ8d5I6A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Lc0onpeF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Onnklhw8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Lc0onpeF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Onnklhw8"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N8qWBQ3260957
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=CHoRBXMfdQXDX9QzatQyMVjO8U/itkAz0C0
	aNlKdJAc=; b=Lc0onpeFNzuvujB/ZpSyTlb1FCZPn6ECdlBXgCgIS9pzotGKgCo
	jHAo+QfMFL1sDwfZi265kTlydW9+BcnagLYZUS6GmFtA6pvbitbG2+oVkDmy6bsk
	GzCBfneHky9vuO2wMmVQnAIeJekCz0OTO783zh+1zXXtXnXhlMCECpZ67o7fnj10
	iEs0xfTdCxVZEXQraq9vCDkHjgE4pvvaOfATs1QRc5uMzTxQHG3FPWIw7PvzbFoZ
	Ux0gUJKr4gsOwjeuUWNWSFzqCI5N/T3Z8d2sGa6Ul+iLj0A4O1PA2KrdTegSImEr
	0Oyc8igR4bU/QDfEBn1p/Hwm3MVMEDayh3w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkafw1tu6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 11:09:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ef31cd429so84475485a.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 04:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784804995; x=1785409795; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CHoRBXMfdQXDX9QzatQyMVjO8U/itkAz0C0aNlKdJAc=;
        b=Onnklhw8dXsvtszNQ4nLtgsudqrEvcFScod4XchZuX8dDopJN0C+yhuV0BB+SHublM
         zB8Zs0ezjNSyMsipC1a4ivcRDH63cCQeHeFR1NoY2jnzjwM7romStF4WMHgLwl2Jlhj+
         781E/ULlBB1BagA++Prz9Op7yYp/6En3TN0N12qNgL5e2TQhWDZt/L2fvGzxdCfzLGeh
         Jbjmno6pXLMxIo5GNG4ViSzmDYjDqL2ySznrcHl4YalbeR5FlfKWWc6A/cnrnsmHfchC
         hsePebORmDhXq9SuiF8S1ZczX+ThgebXVUmfSdv3bGCh5oOgsOdWPdarqT7qbCDb9BIR
         whVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784804995; x=1785409795;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CHoRBXMfdQXDX9QzatQyMVjO8U/itkAz0C0aNlKdJAc=;
        b=orgB1vuPn8WNMEvPpBZ5x7c6w3Cv7g8v6eCXHZlUjp6/sOWrD9jERc72gOnxrVmjOU
         M6qhHQ5QHqvu3uU3Nv8zaApHjIj5cIw6xjM05djMK2JGQlo/Y8wrSOZtP4FeNbzmkFkQ
         dsRQKjfMnt9Ce3JZl0rYPA9wzL55s392FHxfZ10qIO7qpB7q5Bb7ucLgXjs64wLV2wGx
         lFsQMjjQ2iwJfovJZr0Z3Zt2tTP1a56gxWVS3dL7NsKjmerUBkK/2OtQ2vzUqDJ81Djp
         QriRurY3gKN4d76Zqfc75AasKL85BQwcd1qrkSiAT8Ymu/quVqTcmVxNmpV8/M8FXPaN
         ySqA==
X-Forwarded-Encrypted: i=1; AHgh+RrA+9MwfJolgv8H8p+3a1ehAEzlXzVwbDXyiEfMWsm7G3QBDaijLPt6MfqhCK62HaY0vU+Pw5M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys14aMbra+GhuNjwO9eCibdoGjbxET2eAF4/GbxKg+msnq+DYi
	wb3pgajFB6q4ZTasWO3VuZD/TQRd+waaU1YHOm9agQBnGYgerx1Kp8ivDyOUwHH6OJlgrW1mzQj
	CHeGxHPt4kVjtjVrGQ7KrnEGxmhkmoJjfll4SfUnmH00fZLsmFVjbpUoXGYzvqK2m3/E=
X-Gm-Gg: AR+sD10nWlfCaqtb7OV3m2iCcTQrA7qQ4QLJXrFTeX68n/6qxRtdX8wBSYRWKvpSll0
	7ihJ/SdwyWtx53oteeuo+/kFJisL3BkGQzxfffPjGW7rzXVHiPS4p8qriz8w0++0oK1KrNKnG82
	33CQzEadb6fh4WWuwxdwNFXV7frZFDaSc/P9I38sOT+TrJgOQm0UPHd1tSQSgQWJq16/26f2O2+
	pkVXxQbBzJEdABUFA+irF75wS8Z3c3kKZXhjVk3Jllf8nV2mUABtpXlxKsUr7AWK38WYHhWkUCc
	HKZS5ti9TQIBhi5qVt+d0FokPj3SvAiAkXfVVvt5w9KYNVe2K1L3bzUBGdSO3IX6TKN49AGzeMt
	xIBmwV7fCKMGCDCjJLV+u/lxJoBm+NZew56ZZP/pO5erWpQbqJv8C0ah/p2kGh+k6yk0BZqwkWv
	uPMpdwRtblx1gcEyw=
X-Received: by 2002:a05:622a:2307:b0:528:1dd:628 with SMTP id d75a77b69052e-5283dfbfe5fmr21224301cf.72.1784804995014;
        Thu, 23 Jul 2026 04:09:55 -0700 (PDT)
X-Received: by 2002:a05:622a:2307:b0:528:1dd:628 with SMTP id d75a77b69052e-5283dfbfe5fmr21224021cf.72.1784804994522;
        Thu, 23 Jul 2026 04:09:54 -0700 (PDT)
Received: from shalem (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32f11af2sm214176466b.57.2026.07.23.04.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 04:09:53 -0700 (PDT)
From: Hans de Goede <johannes.goede@oss.qualcomm.com>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2 1/3] media: qcom: camss: Add "gcc_axi_hf" to 8775p VFE lite clock lists
Date: Thu, 23 Jul 2026 13:09:50 +0200
Message-ID: <20260723110952.55597-1-johannes.goede@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XNkAjwhE c=1 sm=1 tr=0 ts=6a61f684 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=qncfPZRv0pdA0gtCnvQA:9 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: aCSJsnHu8H7dOPG6QNQKBL6aM55pZvBp
X-Proofpoint-GUID: aCSJsnHu8H7dOPG6QNQKBL6aM55pZvBp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDEwOSBTYWx0ZWRfX8h4OaGmQzj+J
 TmRFyU5WtSxE1E3LkgIr5PNzX70PH5dZaFIJYnnYTMGNjCHLHBghdFSbyVJ9+yYjMUost413w1a
 UHL07O8RHgZwoz6oHfdq9IlKK5Q9TgM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDEwOSBTYWx0ZWRfX2xz/xu8zEoWd
 6PSESf3fog5RunY3R1AgqwiZsUHS6MgYqI/smgaueLJSFKBAGXGo5BIXufITQED4K+k7tOfGi78
 Y4fLTFofz1lL2SlLv9kXLp6B+VNU8+Et+8+Gpk3PbOJLiX2axdfge4PR0F6WisGlQJKBrZf6Bu5
 t/bUwE3YngAfU4CBdi9DsN6ZkSV3pywvMZ5S6go70933/uDYPOD88XV1NvsZ4NyTYh4kUvChdNk
 V+N/ZHpnVL9PRxZKQbOvC+zBAvKPMzz3kuGXZoI6Vt33Eo2oEht18a+6g4vQ3WjtT58qDGu0IFB
 xDq8P/xPr13JSYXbfaULQtzVhiEc4AFFXN80+bhFlFVF416Ytu/ruUcAmVci4xqAgVhEWlILr4v
 5AIww/uOaIowvkOGOJO+y0Pg0/0iS2+QGRWwivM52n/Ofhg2RZCsuJshyHIvfRpjNLMD/DCVGVO
 jDaIVFeXCbujOIe/Crg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 suspectscore=0 bulkscore=0 clxscore=1011
 lowpriorityscore=0 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230109

The "gcc_axi_hf" clock is correctly listed in the clock list of the
8775p 2 main VFE-s, but it is missing from all the VFE-lite clock lists,
causing these to not work on platforms where the firmware allows turning
off "gcc_axi_hf".

Add the missing "gcc_axi_hf" to fix the VFE-lite blocks not working on
these platforms.

Fixes: 924f45e58b1fe ("media: qcom: camss: Add missing clocks for VFE lite on sa8775p")
Cc: stable@vger.kernel.org
Suggested-by: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
---
Changes in v2:
- Also update clock_rate lists
- Add missing Fixes: tag
---
 drivers/media/platform/qcom/camss/camss.c | 25 ++++++++++++++---------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
index 2123f6388e3d..68491b16d647 100644
--- a/drivers/media/platform/qcom/camss/camss.c
+++ b/drivers/media/platform/qcom/camss/camss.c
@@ -4037,10 +4037,11 @@ static const struct camss_subdev_resources vfe_res_8775p[] = {
 	/* VFE2 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
-			   "vfe_lite_csid", "vfe_lite_cphy_rx",
+		.clock = { "cpas_ahb", "gcc_axi_hf", "cpas_vfe_lite",
+			   "vfe_lite_ahb", "vfe_lite_csid", "vfe_lite_cphy_rx",
 			   "vfe_lite", "camnoc_axi"},
 		.clock_rate = {
+			{ 0 },
 			{ 0 },
 			{ 0 },
 			{ 300000000, 400000000, 400000000, 400000000 },
@@ -4062,10 +4063,11 @@ static const struct camss_subdev_resources vfe_res_8775p[] = {
 	/* VFE3 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
-			   "vfe_lite_csid", "vfe_lite_cphy_rx",
+		.clock = { "cpas_ahb", "gcc_axi_hf", "cpas_vfe_lite",
+			   "vfe_lite_ahb", "vfe_lite_csid", "vfe_lite_cphy_rx",
 			   "vfe_lite", "camnoc_axi"},
 		.clock_rate = {
+			{ 0 },
 			{ 0 },
 			{ 0 },
 			{ 300000000, 400000000, 400000000, 400000000 },
@@ -4087,10 +4089,11 @@ static const struct camss_subdev_resources vfe_res_8775p[] = {
 	/* VFE4 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
-			   "vfe_lite_csid", "vfe_lite_cphy_rx",
+		.clock = { "cpas_ahb", "gcc_axi_hf", "cpas_vfe_lite",
+			   "vfe_lite_ahb", "vfe_lite_csid", "vfe_lite_cphy_rx",
 			   "vfe_lite", "camnoc_axi"},
 		.clock_rate = {
+			{ 0 },
 			{ 0 },
 			{ 0 },
 			{ 300000000, 400000000, 400000000, 400000000 },
@@ -4112,10 +4115,11 @@ static const struct camss_subdev_resources vfe_res_8775p[] = {
 	/* VFE5 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
-			   "vfe_lite_csid", "vfe_lite_cphy_rx",
+		.clock = { "cpas_ahb", "gcc_axi_hf", "cpas_vfe_lite",
+			   "vfe_lite_ahb", "vfe_lite_csid", "vfe_lite_cphy_rx",
 			   "vfe_lite", "camnoc_axi"},
 		.clock_rate = {
+			{ 0 },
 			{ 0 },
 			{ 0 },
 			{ 300000000, 400000000, 400000000, 400000000 },
@@ -4137,10 +4141,11 @@ static const struct camss_subdev_resources vfe_res_8775p[] = {
 	/* VFE6 (lite) */
 	{
 		.regulators = {},
-		.clock = { "cpas_ahb", "cpas_vfe_lite", "vfe_lite_ahb",
-			   "vfe_lite_csid", "vfe_lite_cphy_rx",
+		.clock = { "cpas_ahb", "gcc_axi_hf", "cpas_vfe_lite",
+			   "vfe_lite_ahb", "vfe_lite_csid", "vfe_lite_cphy_rx",
 			   "vfe_lite", "camnoc_axi"},
 		.clock_rate = {
+			{ 0 },
 			{ 0 },
 			{ 0 },
 			{ 300000000, 400000000, 400000000, 400000000 },
-- 
2.55.0

