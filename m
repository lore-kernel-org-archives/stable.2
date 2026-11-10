Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304705;
	b=L3s4gqCgTdgcPO38XbwDXvJ7OMfGcM9R1/rdYakoGQc1zuPZkWbxLGSqz6eqSk2vdhKo
	 DR1oXqXTQpuKvu0nVx+xAz4AFO5y2kT39Xd3m5xtmw2t4/bg+/+BI6A20YZRWO7vuGofZ
	 iXV/uNMa9F/2YyzHeAIQDTPcmHYkNtRFWaaBzGcK8tBoM+ng7gbmQEND+15on5jcOe4qn
	 vLYPQnALy5vyVXeF7GfH6BFjrPY29S0k4092FT+gpxjUyvM78DeEys5PNX0peCqlEr5Rs
	 l87aiTfvoFKq84a0SUYSaAbfEpFKXbO7Z9OeLTLQCcAKl/ryh4Yku92r1pHAB5J9s0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304705;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=riYYaHAqjeIdiWCPuLdbc8hgds290pjODW7RjCbA2ow=;
	b=Fw21f/02ZjJqveY9sGnsuMe1QpNATaYrXOmOGnCSq0yyD+iza4bYplACfuV6duYRnqhD
	 c7ARKe5FWyWAmxAJoulQkhO/JxN/c7eWysqC1iaY3poU8qg81CGE2cMp+5J9IpmOJ6zaX
	 Ykhbpw3irNOveHNsTirtO++wfuW3cnsEw+NdouCRkVrU8mSa0rZkz/9XMWkPEth+lM0LN
	 tJsk85iXLO8wRNNkkcE1bCIGbDUCavmzsMHThojPBFtHZMg6p0imYgvi+8416SwxGaoid
	 hnXZdviyNbckAZAYPBPntvLAV8k/GJM6fHuS+9MCnMcn/Inntbi2x7lgEZSNC3piOBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YwYiODmX;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PTZfyE6v;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2360A2610
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:58:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19F2360A2610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YwYiODmX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=PTZfyE6v
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7kkKg2779814
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	riYYaHAqjeIdiWCPuLdbc8hgds290pjODW7RjCbA2ow=; b=YwYiODmXjRJmEA/T
	q6P88I1GJDSo4yWM9K4B4cXdQPe4Sup3CKQdQ/kwbqzIKkiDN/H+NduBKs40F19E
	izpTQjJq6+VS6SwjIYWQ3WjRcSkshwVOgQnfMWFFSYSug+Q4RzfYO9sNI/Vx90/O
	Jr36nEk2KAK/FdAfD/W17tDBGC0nsTc5yEzzo9yTjA/nF3mkYgibEwQfjPtMLzGt
	G2fjK6hdJ0rKUSmoXjxEcHrTxRTSxpVhvRgqwQAlm0tfhMH9Fag9jE9OxlLIU4ek
	HTb4YprNc3AGKWKZEwWDzZ4ZOJCci/6nSQsW/mFuEabjNh+IoNFtHheqkXvU7ZMo
	XjtcXQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huy5d8gw2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:58:24 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so4538225eec.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:58:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794304703; x=1794909503; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=riYYaHAqjeIdiWCPuLdbc8hgds290pjODW7RjCbA2ow=;
        b=PTZfyE6vLAGpYykXJnn/H+E6YOIyof3iQ/a5YHG8rxsRpgN8kWOxC7tY6q4d0ds4KU
         z8BtmJmwyiPYDAMj7qdFk8X+2fD62a2RsUr4TgxJUghfhX7kq+s5LU2W2i2fGHlXhNS5
         rIN1H8nzAp2JDvgQaDuBYe66CbV8la29BpMOWWIOrtrwWYhvvmSFolZe8lHEUwpEK58/
         nsSGA/7qLatRa73y6e1Z7Eo45gi2hOykGjOkrDrQqy4Ty5ZzPIlrnsEZrZITU0FO5buD
         S4FyOwJO4NqRgVI8PL/EwYCXobpApN/CH8Lsy7UISTvaV9vCpMp0EJ1DphC2CbLPAXpm
         3POg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794304703; x=1794909503;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=riYYaHAqjeIdiWCPuLdbc8hgds290pjODW7RjCbA2ow=;
        b=WTpMEkSJTmrHDsGea6b+yhFYvW4ot0O84mALjmo6X4M+ou9VoDau3+ZYMo5pF5KXnh
         dBpf1U8z0qPIwyBSuSBgm1rfP9qbmMAvkqi0FSA8Ung+YUvIN/4NAeQnqE1FrEowKrbc
         o1Aqd2SG11BjPOKjw/oh7wJoXkkzTVDJAuOspK+GBW7/ZsV7k+rwu5DpD+hq+9f9AnIT
         I6b+ayrmZcaS+iX55abdAxAjf5NhwuWBlDytQiQAoN3HGyP1uf9MinQlO4xKEBPTb8qr
         EpIPBxyIqQaeOkU9RbcmInDEtURRd2XdzInbXI/QrjwdJfpiKSPw2FCoImvc1W7n0wkI
         YzBQ==
X-Forwarded-Encrypted: i=1; AL+hErF2XJJS3agUISnURcIK0576glSz0FJqCjLv+lsCpSb6znXUXpVN1PD5Lmv67K52EpjqMxqC18Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Nx/BOIbYUqLUOWL+i7PpOfbrQNqQ/wENKE0tlN3hoOyHB2/6V
	dHRZZWizx51m9v5eqbHVNbgEtSpAabdUooQksbG+koIxtuBfCCRqz5r7F+qM8mjZ9C/9TDy4+Mw
	pPinNu6aBQTd37Bz2VF/IEnjNFo8XtFPyvkbYdAUPo8XL2gxlshrNzSotV2s=
X-Gm-Gg: AYBFou2V5c4J156c6a2ix/yV5v/8aJE/X/S9lLY3KdjhBfFOZHsNIicq3FFPeF8JT9B
	liDfRk0vhsm5G2QjGhsA2dqjEUGHPXkpa39k5mytJhmjTtiUN5Fqbn1g0/VjbUOYC1fCFgI9KtF
	b8IlF5LMfLYJRQo3rga1rPAuzt19pUMa+EgBCJtki/EkpcS8gW1CmV2Rv7sPCmCbW/B9eDir2rT
	W25vdqUI69lXqVtFNPoSFP4gK3HZwtLv9VC9xxLCIwb6VSQO+X6cSA5thrAoD04Z4QJTVmEhNMt
	fRLwFqThbP+PYBSQmgmFxC8QUueA0N9i2uEQIHv3xskHo4/LI8Ri5P3sE9OAhM9gUl9KDC1qJmz
	+jEMUG9FKgdAmvxOsmd+DKF7cZ5xCniROi+udiQ6bDHxlXV2WED+pWWeSwd/5fRMM1pPQYH/cWP
	BEYN5Jww==
X-Received: by 2002:a05:7022:e884:b0:144:e535:3ef6 with SMTP id a92af1059eb24-1b3b6046680mr3319740c88.41.1794304703484;
        Tue, 10 Nov 2026 01:58:23 -0800 (PST)
X-Received: by 2002:a05:7022:e884:b0:144:e535:3ef6 with SMTP id a92af1059eb24-1b3b6046680mr3319695c88.41.1794304702767;
        Tue, 10 Nov 2026 01:58:22 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11346sm7333141c88.7.2026.11.10.01.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:58:22 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 15:27:14 +0530
Subject: [PATCH v2 2/3] media: iris: Skip redundant HFI_PROP_TIER updates
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
Message-Id: <20261110-fix_dec_seek-v2-2-210d8c4fc31b@oss.qualcomm.com>
References: <20261110-fix_dec_seek-v2-0-210d8c4fc31b@oss.qualcomm.com>
In-Reply-To: <20261110-fix_dec_seek-v2-0-210d8c4fc31b@oss.qualcomm.com>
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vedang Nagar <quic_vnagar@quicinc.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794304687; l=2849;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=9rwHDwJH30YYpsnnhv+f/V2usq3fbaNIKrsSLkQDhUs=;
 b=/hEgDVf0nOZwuvoFSkD+o+esSMm6hLP37P8CLEsIJ4lphz70b+4odMYDw+Mvb/WXrlMsy3EuC
 lUHQYXtKKdrB43IWEaQLOuNGVEpIYEmbKzlXHgFRcEWad89f4p03qSs
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: agR70t0XxfSBHXiSFo08_wRNhvVPa8s1
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzOSBTYWx0ZWRfX8ZPN1Mzqi94a
 JrX3CD2qGDXjAepK45419Cy95FPe8UqGS2VqseFbXWMzAW186otSQ9evk4I387rB5syzqQ39UnQ
 D6uTxYv/em+d7g4RY4UzOrWwrINTrGs=
X-Authority-Analysis: v=2.4 cv=d+9gWhjE c=1 sm=1 tr=0 ts=6af2eac0 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jJqbJ-F1a0nUChmTeA8A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: agR70t0XxfSBHXiSFo08_wRNhvVPa8s1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzOSBTYWx0ZWRfX/iyD2G+5urzl
 pIscv7oFkVvNYOJmp1rWg0cZhDTh5F1HOuYAxd92bpUN1gHbmUB87kOoyyjZwN3n2WAoUBhQRX5
 0HRVuh1W1liS5aTZ/VqXiclf1vCwCz0D7s5DovtOigWMc6Ng+jE1lkyvifnuZUkpj1M98xaUVnM
 HAQ04KmDt6cw48D2bNcCYnT4ZIMG1RLpfJVvCTHcgI2/YdYMMTTzJyIz+wN1/X9xcfvQBpjteOf
 R+6e2YEPvyWZ3U40UXp/D974Kls7Sjes/YPON55s7ieMkgffeZDC1alrbIwQEkBFpB+mXeK1LGV
 NqlHHZSVC+tbPWwuz5PeGpvRW9cqO+EOEYqRtegjBoUimLB9ARvrG6QWGTp7vCqmvfNf7go9WDh
 I8E/pGVrvn3N62EGNakt/mlf+eTKW2fWjVJ7Aq9stNfyX5w240svr9u13zUN4yLS/d9YAKcrpml
 T8LTTXr0mG/AOY9uDCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100039

HFI_PROP_TIER is applicable to HEVC decoding. TIER and TIER_AV1 both map
to HFI_PROP_TIER and both define a .set callback, so iris_set_properties()
programs the property twice. TIER is programmed first and TIER_AV1, with
its default of 0, is programmed last. For HEVC, TIER_AV1 value overwrites
the tier selected through V4L2_CID_MPEG_VIDEO_HEVC_TIER.

AV1 does not require the tier property. Drop the TIER_AV1 cap and its
enum, and make iris_hfi_gen2_set_tier() read the value from TIER cap.

Fixes: 2af481a459a4 ("media: iris: Define AV1-specific platform capabilities and properties")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen2.c         | 10 ----------
 drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c |  3 +--
 drivers/media/platform/qcom/iris/iris_platform_common.h  |  1 -
 3 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2.c
index 79bbd06ef8d2..706698201c17 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2.c
@@ -999,16 +999,6 @@ static const struct platform_inst_fw_cap inst_fw_cap_sm8550_dec[] = {
 		.flags = CAP_FLAG_OUTPUT_PORT | CAP_FLAG_MENU,
 		.set = iris_set_u32_enum,
 	},
-	{
-		.cap_id = TIER_AV1,
-		.min = 0,
-		.max = 1,
-		.step_or_mask = 1,
-		.value = 0,
-		.hfi_id = HFI_PROP_TIER,
-		.flags = CAP_FLAG_INPUT_PORT,
-		.set = iris_set_u32,
-	},
 	{
 		.cap_id = DRAP,
 		.min = 0,
diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
index fac61ece177e..9464543836c0 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_command.c
@@ -603,8 +603,7 @@ static int iris_hfi_gen2_set_tier(struct iris_inst *inst, u32 plane)
 {
 	u32 port = iris_hfi_gen2_get_port(inst, V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE);
 	struct iris_inst_hfi_gen2 *inst_hfi_gen2 = to_iris_inst_hfi_gen2(inst);
-	u32 tier_cap = (inst->codec == V4L2_PIX_FMT_AV1) ? TIER_AV1 : TIER;
-	u32 tier = inst->fw_caps[tier_cap].value;
+	u32 tier = inst->fw_caps[TIER].value;
 
 	inst_hfi_gen2->src_subcr_params.tier = tier;
 
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index cddab9a9c375..973a6f91a49b 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -135,7 +135,6 @@ enum platform_inst_fw_cap_type {
 	LEVEL_VP9,
 	PROFILE_AV1,
 	LEVEL_AV1,
-	TIER_AV1,
 	DRAP,
 	FILM_GRAIN,
 	SUPER_BLOCK,

-- 
2.34.1

