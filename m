Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155293546F5
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236284; cv=none; b=ToZzh7GHDB9ytaG8qe+0XxzpQdUUOU8mguAtSHeZUUPcRL21F+3qgpoYxEgYCun2t5hArxXsmXGftiRFrQexLgN7Bll7CXZWbIJFw3DdeZZzl/z0UrexBd+RNE1abIr758G6FlrfSzIcJ90iwwJUx01LhxlyNcRC05ttBmi+1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236284; c=relaxed/simple;
	bh=BhkOYK28pMRgnAFg3axElJ/0jV+SlRNGNmaeKhCabOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hzWX7UBHyi0wNc0LcCxXPf15sU+aW1IvcCVe3XLVxX7Ml56d6uu0D34xXNGVIqdj5+L5HGY9juU6z5qk3ApyKnTQSb54ZRRew8AdeVQWO9ZNRnOk52j3gLY4SLIDwcdWnLDfzb8Ded1aXxXwHdjckChSWuBYLqMNndAquCH/dxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k+HO7BtV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=V42sX6/8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k+HO7BtV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="V42sX6/8"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KE7rcv2444662
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:31:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	w/t5DVoi7TH5Cdgh1wqQM1FGHTFp6QNHPSNcYTK660k=; b=k+HO7BtVyOTPCX5k
	vngtbsUGCspDYm1c3h3K++oGDzn3zab9VMva/c//EuPvz4e4G1/qDWH3Q1JdWpud
	1tqhJ+72fMQqfRCIAoeptvXHpJ7HxqnJjaxIjiRK8Y1qoooPWAJXdiSLmuMEXndh
	t1cNF1vBekOT3e9UQAB7pmz2Jsl+s6zN3ny7+2pFaG3vuqZM92+9nPuMae9Airx0
	oBiALQPwmNVMeM8PTwzHb7/JhuELcE0ZJoZGG3A0xsIGsA/I9qDrTeerhZs/pm1i
	EiVC7bDEiZFzLWIWlZIS7iDyskfKATj3HTSXfcb1fBbcZllpowVDiCuAQVu0LSB2
	aq6arA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x05sfjb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:31:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-934979ee9f1so294788685a.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787236281; x=1787841081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w/t5DVoi7TH5Cdgh1wqQM1FGHTFp6QNHPSNcYTK660k=;
        b=V42sX6/847e6JiAhdzGNjWo1fu9kt9X8ipzvnkXVgWCYjzjC/ZHFKHW9DtpA+KS+0T
         QqK1MlpoBirh0JgDnESoJigQjU+TmDUFV7RGyPmdqUrljlnCs6tGDwYAFQ9BBLMOakXO
         9lCg6O+HpK6ipeMy5GlaBAdg9H+PGHpNr9IqAPlg+ZkFOdegHckpDKRjf3bTithgiDfc
         MSAKkKvScgkIgEu9o3421ZmCkSyFbzlqNDasccs7HvTHpULXEH9Soc5ft6LEfea5LynY
         7YiwbtfpSH+h8L0oy9DsvS7HZBqMHxK3r+ZQTeyhGMIKNrIeY7Iy5vI4tT8ln17Op/aZ
         EE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787236281; x=1787841081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w/t5DVoi7TH5Cdgh1wqQM1FGHTFp6QNHPSNcYTK660k=;
        b=O7wWzHhSUF76tkWma6e7ivLaVbubigh4hEHijinOtVCQjiihr197RT2wrvL1wMBvrT
         U00BceaWbbt8w+jsI0hdQ2kcmFMpXj/aPJjMqAhCd5HWPCwybo5Z/Jo3CmvjQIcJL/s7
         v/tOxpgcf5csz6ACqzvqIJeDpxaKjE65j8hXeesGxxcsS71JiDGhgPSGBLSa8xVr5iod
         +mZx48dB3ShZd9VNbjWJihirw6zUFRB/JhuJ/A4vCbsAxhnNRsIww1dodG/OqeRhrQJ9
         y+yy1zS6XDiFsuGQCQXiO3aJZlLZZTNYf/8vYkKEYYcLMTHt2IvgLMLSXclkdm/1syjv
         jmxg==
X-Forwarded-Encrypted: i=1; AHgh+RrS3OEV2J2f4D7Jreyo7luF1fH5WZas4jE4XYTfnYUOlztUBUC6OChH4E2KJ/MoGZ5k5cJgjP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlGKSo8RYox41YXEyFPvx2HSPGoASWr126Y2UNT6g1eCk/wYxi
	c2rfMMYcxNi50Exhusa4vmrcOWsYLzXZJanlHOmpk4Yni75fCNFsmvPKaFvi2jYlorJmt0YqpaR
	HeG+T+9kL7MwH/Bg/UDXw1ZWvzzBh4xm2SYmX7YfgCFL3jT+bZLXoor9k8uA=
X-Gm-Gg: AR+sD11pEBFKtvrIARJG7MlJk11ARCeUXpemyh35gsnNIHPLF7wf/Cy4L8xcG8p6iwK
	zML2jbQepUGWBsCS1jJ7T6JXOiJIILtn0dbE2aGZk7qg2IfV8MLAwasEq+sii30GorGupFx+5/T
	xKfOHi+h3kDc8HHirDiv2duY5x884Sf0iAOdtphSH76BMYjGFACDuqk8DrL+RzFXOcl6VsHc9hI
	+n7OxFeG5pmWcpeZOAgLbx7ikve4CDfyX1Q0rcpQxlKeuma8/NS7AI/iC/5op7ak8CK/F2hX+8g
	G2XkdAEr26uZltIuXAxru6gGVJAke+64SR+Ppx3TZTURhhdbf42PHDbPs74slnhRBgGj/yighIW
	+BR+eJASxBJfme+0BbY/k94WU6CTuLuTmuPHs
X-Received: by 2002:a05:620a:4594:b0:936:f984:bbb4 with SMTP id af79cd13be357-9371e2cfc85mr1067602085a.3.1787236280240;
        Thu, 20 Aug 2026 07:31:20 -0700 (PDT)
X-Received: by 2002:a05:620a:4594:b0:936:f984:bbb4 with SMTP id af79cd13be357-9371e2cfc85mr1067593185a.3.1787236279786;
        Thu, 20 Aug 2026 07:31:19 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b145c9d7sm15226618f8f.15.2026.08.20.07.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 07:31:18 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 20:00:58 +0530
Subject: [PATCH v2 1/4] soc: qcom: geni-se: Fix endian conversion for
 serial_protocol comparison
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-fix-write-to-read-only-firmware-buffer-v2-1-7badcdc455fe@oss.qualcomm.com>
References: <20260820-fix-write-to-read-only-firmware-buffer-v2-0-7badcdc455fe@oss.qualcomm.com>
In-Reply-To: <20260820-fix-write-to-read-only-firmware-buffer-v2-0-7badcdc455fe@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787236268; l=1170;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=BhkOYK28pMRgnAFg3axElJ/0jV+SlRNGNmaeKhCabOk=;
 b=iJQJCCKhcAJMSKaI/4t0HLYDUFkDFGoH+1Fm9791WNrlxjwkVegDOzDLJDcZDypTHk9xeZRgD
 Ne7/j/jUjpwCwijydn0HDlBgTrxIKdzDDAFvzu0z33ZAcMbQ6w5EQJr
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-ORIG-GUID: 1cekfsSwSmPzynBqU5UH22D408sDBUgp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwOSBTYWx0ZWRfXzlLSc07o8Szs
 0KK+It3Z9nYsArpuWcLuVjrZBhX5QJbmqY5QrNqppk+Wytmjc64dAnE5l8ulDNQt0RdJ7k6Ky0q
 Jgcv1KsgXIeO1G5VrzEyvPQgfWeIOQ5Jz7YvWWOmzweW8RadaEBEVIllGDifv4TXQRgKXL9LMCy
 0G2u/mffrQqTOw74VeQ16/RcH58A0Xknz1EGEFdbSPSFKIfJhDvTxep2ZB1nuTFLU/mqazoWArE
 mNUz+fXPXN2aC/Dxfnb0DboCs8XlzFfBfn7jBgrkp5lcxwrtqdQeucwww29ro7s0l3CK1flb+ZN
 x7hmLBVAIHYHueqUoACzlwiLtf9K3GUjpt150w2TYPFx7mMtw7FMcm67XnBmWJOokrTx3CG/qXJ
 /4NhDgy81g6rCxiIdq8cmM3IcywJ6MVyt9h2sqTenx1dgAfn2A9Dae/9ihTSn75rq9B2NmUpTvm
 PYwUCuARWA+LNyYUVqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwOSBTYWx0ZWRfX1eYukhY4DmPO
 zRh1W/SmVFYBTpuOvXAaOGuAnPJbb2h1DL/TNCCj9xJJiSB4P7Bb9k/voNhIj+8UPJWcDiusr3D
 HakmNpmr4bPr15NXxg3G234H6I5O8is=
X-Authority-Analysis: v=2.4 cv=VfPH+lp9 c=1 sm=1 tr=0 ts=6a870fb9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=BdrV15eiT15NMrSX6N4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: 1cekfsSwSmPzynBqU5UH22D408sDBUgp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200109

serial_protocol is declared as __le16 in struct se_fw_hdr, but was
decoded with le32_to_cpu(). On big-endian systems the extra byte swap
causes the field to always compare unequal to the protocol argument,
so no firmware segment is ever selected.

Use le16_to_cpu() to match the field width.

Fixes: d4bf06592ad6 ("soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem")
Cc: stable@vger.kernel.org
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 drivers/soc/qcom/qcom-geni-se.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom-geni-se.c b/drivers/soc/qcom/qcom-geni-se.c
index 873bfbd6b2b7..1d6e6611441d 100644
--- a/drivers/soc/qcom/qcom-geni-se.c
+++ b/drivers/soc/qcom/qcom-geni-se.c
@@ -1298,7 +1298,7 @@ static struct se_fw_hdr *geni_find_protocol_fw(struct geni_se *se, const struct
 		if (le32_to_cpu(sefw->magic) != SE_MAGIC_NUM || le32_to_cpu(sefw->version) != 1)
 			continue;
 
-		if (le32_to_cpu(sefw->serial_protocol) != protocol)
+		if (le16_to_cpu(sefw->serial_protocol) != protocol)
 			continue;
 
 		if (fw_size % 2 != 0) {

-- 
2.34.1

