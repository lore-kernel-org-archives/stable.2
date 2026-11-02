Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793634423;
	b=0RiVnGpdhGYeiWgLIcNuOTNrQVygSpDZ6F4qqggQEl60xIGdFavdIbZvS77OZSBg1AeS
	 zrZkbT9wl8UELpSJkj6YjCwDvKvogl++fdjbKXJ7OwqYk00+SuxsiZfAGh+cVu4JOCbB7
	 DaKC1QbEO8Jlvnv3fJHvQLAFExoW38eOPPn6CI9QeKXCiZDXyNGvL3Le2GD3ajJ2BaZwO
	 lwfMquGVtJNs9yezBoM2qP2nKl8W70iN3U5up+lZ3epbQmZgiqOHKmYFJOSCJodmPVeHK
	 0vnhVSaRFf7iYBLf8kw3mJPwNJENNRyTPz8BK1DUirIV70rvNS2mPRjbc82S3yyDPig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793634423;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=qvxyFfT+1WtcGMNXj2kJ54v/fT1oTx7k4iipSG48O6Q=;
	b=telYd5NSq8MGi+gRQo8HlDaXpPu0tRwLYIn24HbOqFXV50BnsjhLHgBNOBmQY5MNsErl
	 G2mPvzhBSSk0Z4stTSrp1NSit3ZTVadbnngHMke7/VeV5F0pkpwht32XCKt8XpE8jJ2/i
	 5P7F7Ws86QbYVlPWDeGgHi3ZXTs2DT72eA47c8IRxzHuIfSucLkaw7Ncfy42DV4laa4YZ
	 vr3KgBbw9gMew6OAmGKVDWiWUg722k/KM2e+ZPbuiTcqdatWNbmVOWx1MUszz4BQ6WcU8
	 qxv76V9YsUQ697VvKXMCVhPFdoUKmrw+nCuXORKHxNa/61iHM6KCdqhfYmVvG7J6sHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PvOv0C49;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WYiBPTYR;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65D9606E02B
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E65D9606E02B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PvOv0C49;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WYiBPTYR
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpAdt4033872
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 15:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=qvxyFfT+1WtcGMNXj2kJ54
	v/fT1oTx7k4iipSG48O6Q=; b=PvOv0C49IDBAtPciWNGjrm5Uf1qGrFsXMrYQrA
	vaPBPJY0CnD94OePY3ChK9jQ6QbpX2b8LGzyzb3UzxQZ/DWMYJpwFRsD+Mxlxkon
	STuU3vReHljBTPoTUpPnnlqP9FK7AcR7/VuRit0ONZI9fLa5U29kaJAG2ABfcIwe
	qF/nBtOlvbwBUpr2B1Bx5r7CWmc8e5EGiL7CHkpN+k24tv+ssUcFOZ/CGJEASI3p
	78PpbeKMisrmWdJMEpemmbFp0vqAD5cciSF8huHi9pGNzF6eZ3GzcFjnFEh24LcN
	XHy2BVZnGW+8vGdG39JkMfdbhmSX+RLWKAUfMfeaAJOSW7lg==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hppfe9x6n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 15:47:02 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93ecdc701a2so353686085a.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 07:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793634421; x=1794239221; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qvxyFfT+1WtcGMNXj2kJ54v/fT1oTx7k4iipSG48O6Q=;
        b=WYiBPTYRaBZEU1Pfo3wd6dGxK7ocF43/6hpcZ/jvhv2dSSIX83a87zhEnGN5PDY7Db
         5FXWJUNFnr1GasHqbnRHNgYPZqBcP7IOu9P0jFOSG4EQFEKRTAzBckBOV6sqbXOd9qqT
         R3+AimkutQbkfu8RVrNEOFG18e5Rm8qciKVsNyhx4IdzCXwrmdpYXD75+Spgv3PELFQS
         GsSU/nszE0tX9mLBW6Xh1Rt3wIRwyJ2G7K0GTS6pGqm0FA8fEma+BXvx8EimBvYJZDQG
         SyQCUtVchouha1JEWx8qWWj5cR5GiEjfIoDceGOBfXKFy38ICHe54k2rWY7ni6zLVCDH
         +YOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793634421; x=1794239221;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=qvxyFfT+1WtcGMNXj2kJ54v/fT1oTx7k4iipSG48O6Q=;
        b=q8GvaiFI3CWQ/JilZGPmK2luxD9SQ8Hy70lBmdJZDJyKEShjgsoPDz1F50t1znTMup
         CCRalNMe5bQqwp4ieyvSzCQr4FKFFFRRvzei8xAbL61hf4tKDKv8r7Kh5xObzB03Drcd
         3qO9jH+on3c+CKkALSDtXqSwZvlp9GdkAxMiYRH8xzZ1zQlLVSulgSy0sdz1PNQr4wW1
         YeAbMOPXEUmrIIuMYMnp2m8LLoMi/9VfQSbD1ySm6tbkY5/yR3mD6wdopsPnsLMUubdB
         Zcbjf0xTGSgzs4sDt71uUW2SvQhXDARxasw94nRtgqKZSbur5WGDE6i9XWjFsXu3Ftpz
         G/ow==
X-Forwarded-Encrypted: i=1; AKwUvByhfyzbmaUz4j00512OCIynKZAIO9ihe06kppHL0AX5YkShJeAuucb2ypCHOdE5ufB03W2ppUI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIxMTvGjkXTIskAqshUwawXbwaXDYKNdhailmI2XXBEKhjBigyr
	JRy7Y/OEE8M0DzyJFO+AlF5TpE/QCnComZgTamNYCWvgw3R9ES48RLSWVwTvJrLQ/Wbc4piNJpb
	7ZKJrbYdJZWo2U3KhDQ/MP5lTVAyIZwCeU6zbUs/ozg8qMvIUFrdDY4Jd+pHtGD58bnoDbw==
X-Gm-Gg: AYBFou08kUz36Z6p7nh6d6wNR+5Qy+dxov1nrQ0kzJ++r+aG/b1F/zPLVElWWqAdlbr
	efoDo2JyysZPXh5Am+3X/7LixY55v0ILpZegkZqNZwXdEq7ZQzBwoWuo8npV0fyIZLujWLe1w7+
	MI3bgGdd90tzUqbv1pHss91jaKn5cncACmEkjBBf24jBqaJwn+757khn6+PLmr24exNpreqawBb
	+usdDYPj2d2q+fWtmQP4ZZCB44AKFncepMneyjMiBB9QCnmKFHKYxrrVz8UpKCtt0tmAjRuQxu+
	o0a/xLtLcDKDLH1KNv1D4UZ6k+PLFOL11mstNTvTyzN0nEz7lX/FMzONLZLWvp/7wDZ7Lht5IB6
	hIWsGXtqs7hPotjEU+dyeUz1Nzwt/z7qYZKWVGnlCT0g1Ec3T2/wuWYsFYA==
X-Received: by 2002:a05:620a:649a:b0:93f:ca9:3ee7 with SMTP id af79cd13be357-9442174f31dmr1616363485a.57.1793634420954;
        Mon, 02 Nov 2026 07:47:00 -0800 (PST)
X-Received: by 2002:a05:620a:649a:b0:93f:ca9:3ee7 with SMTP id af79cd13be357-9442174f31dmr1616358385a.57.1793634420218;
        Mon, 02 Nov 2026 07:47:00 -0800 (PST)
Received: from [127.0.1.1] ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa81b7fe80sm398196295e9.11.2026.11.02.07.46.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:46:59 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Mon, 02 Nov 2026 17:46:56 +0200
Subject: [PATCH] spmi: pmic-arb: Fix the driver data used by non-data
 commands
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-spmi-pmic-arb-cmd-drvdata-v1-1-2e5ec8035b85@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAG+w6GoC/yXMQQqDQAyF4atI1gZmRhDtVYqLOBNrBK0kVgri3
 R3bxVt8i/cfYKzCBo/iAOVdTN5Lhi8LiCMtL0ZJ2RBcqL13AW2dBfMikvYY54RJ90Qb4cAtea5
 c4+oK8n9VHuT7az+7v+3TTxy3OwjneQGcIRYPfQAAAA==
X-Change-ID: 20261102-spmi-pmic-arb-cmd-drvdata-fe9a1e308063
To: Abel Vesa <abelvesa@kernel.org>,
        David Collins <david.collins@oss.qualcomm.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dan Carpenter <error27@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1907;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=T7kfTC58UyyOEU3z+I6l/tcxF+983zx+bMBW6NyeQFo=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBq6LBx6ofZLDC4wtLxTu08yJE+9/KZRYfs2i5tV
 BeyyszFsC6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCauiwcQAKCRAbX0TJAJUV
 VltHEADHHunqw9s84JXtkoZ70RQ1HUgKC/k4wwLt2i8o572POqM86BX5Y3Yph4m5QjG17c9TGsF
 6m0nuPyhrzHf25bFoXMWKoHi8Lo6VKqpYjtvNDoU7kcO89P8gpdsGCJ+/73XEXarCHf2FmvmXZV
 8A81dJ1tY8afP2G0nvCOTdVrsJfhlkvyWwsVxkk3gX+paYLl9ISGpg68qPIeGO9uSXxRWkSmChi
 dpCojTAbm1H9hMeQ6/bmL1zMOc+LWTGkjBTYgs2xSDLy9LjPxmBizZ5TISgvTj7dkYtfw8LERsz
 QGYTqb4qyP3al3jpvcfT2gbVGDLgXsRyH74QBVzdkSV2WcAuDBL4vd+t/bco1gC8hJLxMWx7KjA
 tmRnecQ4dI66M+H/eaD0TILgnuMeRWYIAFdRc/566dkfDSKViw/XiRIJnn265Jpcu0YKNaF4IKI
 Xc+IiAQle9Grj43Gi2W2EgeNi+jIZ/oRS5IcRvNIWT+tDUgkriLbN26w9yEdHhdzDuHfkQs7A2B
 uYfc4uKNDAnvmm5l0hjYnH51lCLuUEKazz7RlTIB8Hck2KOu0phvexIdCM4oj5lsRV4D7tihpXf
 wmQ4kaOwd3CuLd4Orzxe8qeJY9dqi39qx0v8yLrT4jMVWawOVHD3X8BaEKy2b2vc6olxLGCspv1
 pLmOhctgvhScp0A==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Authority-Analysis: v=2.4 cv=SeZi5fRu c=1 sm=1 tr=0 ts=6ae8b076 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SMQwI9SyXOPf9XZ8ltwA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2MiBTYWx0ZWRfX+Vr0Xt3JgSV+
 1NXrs0jgU6uYMRws490rt6EiNUDGBBOD5iMhWWwRPTFhGYSM9oCybl3fZD4smaEVMbcPa8SbCc6
 ffL+ly/d+kd/un6g0yyB/mR/4i0SjuBfAXLCvgHNmU7UfGjNLvL+s80En3SQj8M4Mnn3stMvAsa
 CU3QEy9UY4L3ldj45jP/gDWfvVCIjrPjGGwOPKcWOQFb51w+04BXw3Wf6VLC/eitNNPx+icgW5b
 dqN04w9ddVhQY+7zbLB2d7ZX0hmllUndkayEOCT+J8sRzIHgq8/EEXeLUNmxV7IPtJ53lvipI7U
 WlDQFrsH6bGfPQB34FfC+4ENLROAPZKky/PiSx28G0SL/o+H/mT/1f2pVrh2E3XALn/X/6S2pWu
 mdcIj4e33rzY5K7rYpqAGF6uPsUQeH9P/6EK0uYqvT0fLOB+RcxqYJEtB1tW/8WKbIbUqg9oSYG
 iz7M7o18m70iMoV+tdQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2MiBTYWx0ZWRfX78oHAE4fKe2r
 iz51Wl1R9kN4bN6xj4mtgAJQGN12vR9niC5ZcjGhGxDIZ3BsFPFgAdsGqleBBXXZfTnu1MLSmZ/
 /BRxbQa7nT2o7bTyL+vsa9+3AnbPi7o=
X-Proofpoint-ORIG-GUID: R-JJTzOLkDtmaKMenN3Uh9MJdjD9zKYo
X-Proofpoint-GUID: R-JJTzOLkDtmaKMenN3Uh9MJdjD9zKYo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020062

Since commit 02922ccbb330 ("spmi: pmic-arb: Register controller for bus
instead of arbiter"), the driver data of each SPMI controller is a
struct spmi_pmic_arb_bus, which points to the arbiter. pmic_arb_cmd()
was not converted along with the other controller callbacks and still
takes the driver data for the arbiter itself, so a non-data command
reads ver_ops from the wrong structure and calls through a bogus
pointer.

No in-tree driver sends non-data commands at the moment, which is why
this has gone unnoticed, but spmi_command_reset() and friends are
exported for any SPMI client to use.

Get the arbiter through the bus, like the other callbacks do.

Fixes: 02922ccbb330 ("spmi: pmic-arb: Register controller for bus instead of arbiter")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-29e1d31a-8d20-42c9-a5b3-41a90553d799
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Prepared with help from an LLM-based assistant.
---
 drivers/spmi/spmi-pmic-arb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index 402ffeaff8e2..9ce404ed5272 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -448,7 +448,8 @@ pmic_arb_non_data_cmd_v2(struct spmi_controller *ctrl, u8 opc, u8 sid)
 /* Non-data command */
 static int pmic_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid)
 {
-	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_arb_bus *bus = spmi_controller_get_drvdata(ctrl);
+	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
 
 	dev_dbg(&ctrl->dev, "cmd op:0x%x sid:%d\n", opc, sid);
 

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-spmi-pmic-arb-cmd-drvdata-fe9a1e308063

Best regards,
--  

Abel

