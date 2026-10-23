Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792744049;
	b=yi80igUGXzaWRErAIGEyqe4IV+EIP8GenwQ4Sjos7R6w+psBeVX0gY0wLozqjCTP9uoZ
	 gD78vyh9z7TzZk7lsCM0hF4Ip8FXXHaJwfP4NMzSRgTIzLfjo0mND+xx1kKbpEGtgNdAN
	 hCmBwVvI8o5ng6enWMXzs6DAOjpQEYyZ0lXf7pnXfKgqoaB8PnDKn31HFFDlFeIyL7/pb
	 F47sgzRuc3q8CYrUGF+lefND4qIyKGsueXGED9uqkYy2EaYowftqsZ/UJdAHho11fvp6E
	 ftYZrL6YkS0qFAAuKsBnxD/7QzTOXhA5dtU3LnT7siWBbbhRCIODNFZAxVOqqctiJOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792744049;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=A+8sjnjyCG/D5KCtBy1/qNiT6sKxNkDnINIvcENVECE=;
	b=hXL5JLSa32W2O+LA4+ltraBBmFUOi+S3UBgFUJHM0DdgDAWwCnwua+Ap8+3pLNA8wXdq
	 W/H7AQ0HVf7RkhHmrV3C5llK2/YaJ8Tw42UVQG3ThPSDo3E2ilpSpECxllTWKNfsuNTMz
	 6/P0sYfHpGySIeS5NUh+lATXECJLT0Z7N8u5wedNim2nKyRKjcqZpmGHfmQyrsPo4ViPk
	 PCN4yVyKGUq0ZvXIX4vHR+PmPfNkAKuiP8FmjZ4Up3iic+RMv4dwPbn+b1EfklNlN/dZ1
	 9O3Vob3aDJN88BmEmK/brq1tjohOLIarH90/EG30WU9KpJj9MUn9wOqjibJbO3FBHTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fu2sDrjK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YFg3u3L8;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06495606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06495606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fu2sDrjK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YFg3u3L8
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69N7FEtZ2068118
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=A+8sjnjyCG/
	D5KCtBy1/qNiT6sKxNkDnINIvcENVECE=; b=fu2sDrjKovPwIC07C+X/Mp4HcRm
	CTct049FVEbAQaceBDnCEHYuX1FBkgm2t0fwfeZNkK0M9V3aT6QBslkZXmtkfhep
	+FgRwesqgOD1fq7QxTWuixBZeTkVEY5lyNx1YHL4xnGTh83MPNr4gSuynMl+cAvY
	82+aAuDRXKuQcxQM0lyl/29QkYlGfVGjkuU2417Bo3HW6fPS4yID1J+eLQBx13Y4
	zT7KloMOf99DQLgd2UuoIpc9zvuup4Fs9Utynk71mi5xZMBkUUJhhAetuAcyrACc
	qdNT7UfIoGVa4RPB3DJBQzLFcaRhu9YIJy7sMKr2QdMT5bBdrnxkPfTn9DA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw37y7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 08:27:28 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3a46f0f158dso1066915a91.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 01:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792744047; x=1793348847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A+8sjnjyCG/D5KCtBy1/qNiT6sKxNkDnINIvcENVECE=;
        b=YFg3u3L8IoMLgsDph9Nda6vB42WFVNQAtaPTSvtCdlQ6Zmc0bH+FgpDQ958qNn9AeN
         UkvFeUMj/YlMX9SIXa35PbzlYVTLamj5gY98S3Y3v5WF19lRhUYxNkvNnvczVyO8dzyn
         jwBCYlRNhlw1PZl+aKn+MgT296SN8qtN8dxuoFTX0iDOd8yHersUBf2mCY1HS2Q6lT7t
         kKfRlnhN+jLE5tG4wFlC0i5fgQt660V6KSZkIbTpmQNo9Ym0cnj8MHEaCAHtbqLjVoFb
         yhEybZFyTuRtDivaGOX2b4CpQKTZ1Qli4we72Igg9ZvCVDwIbJwZ7yhAr2S7Ou9WHtk4
         1tvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792744047; x=1793348847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A+8sjnjyCG/D5KCtBy1/qNiT6sKxNkDnINIvcENVECE=;
        b=d5o09tWbMOwwHz/pjdjxH/+v6M4Un9KDCsszmymyibXqbDJ+c4mBQJAJ6WA9dzFYz1
         p6TBoDqKo1cJf34sAk2BZL9jBHsbtmN11tWGkxoM+vb5dApWq/ySt2j/NOnlZ2CLZ4NS
         CB9+l/j3Lf5K/c/PiuTacbIbFzYDsN6J/nSp4/mStdlsrzGiibPoirRURPnBItjC3IUz
         PTBaGTuIvc41uYNnK1WNek6U1GmseSE3veRuYFJNZlHxMSmU9ted2Oq6chi8hksPkrU2
         iHxmfEdX2sjPw1dX07xg4mecSYnFNK7ZvJrHscUnTZJOZud+YKez1sXS+QmYiPIv12tQ
         k74A==
X-Forwarded-Encrypted: i=1; AKwUvBxJXkneq6d5Bz0zeTMn+ihLjiTdnIQbryehC4ewmKnu0EYMhw9wXuR9boWTcPEywP6KdNaWbd4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKFdX9aScQir8B0lQnWfz1RFkIOBwMb/C6DZ6PI5CIHA8ozn7zx
	m+OBSe4nJ9Iy/RTwJAEprdLVrv9PSzXr9YSrlUoNhW6FV3qQml36ADKHwlHPkvjtySuBnBtqzBS
	HP/uBbgR21Fy8ZggLz8TMUSab3HhcoZM+P0Wa8TJuiLjrJ2xi+LEJ8m8r2Fk=
X-Gm-Gg: AYBFou3/UupwFCPl82GfyZUHbImi/DwU76vrtZRCwmiPcXz5U8QE2XWNpwINW1IsDij
	7fvLCNeN1atWR4MFxPogX56WesWJOeq3b2azw+vJLblJo8bEHTSq+JjLWH6w7SJFPio7I8tXR9C
	fIs1m1G53IBXBM/V+5H1UgRCe9xRpo7cSUrLJycNuBK0vPyTh7SPQgnhuvAE6yfY3rX1C2QvwOy
	OdAfbITuftPjeN8MDSP5ec4qdUrys3djhT3qQXwVjWcPDOEzHUPD6VG99L9teFtk4BsOah647qc
	VYyrruwZaimQRA0KmUzet4ewKu4AC+VMOvgLaeZGaxnVoyFbdPIYNYsfqzrsWHBAzYreYMhtPCy
	R2Ty8+psO0Cs8P8muE2fWKh9eZQIGUj0FRQ==
X-Received: by 2002:a17:90a:fc43:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3adce0cbf64mr832696a91.3.1792744047049;
        Fri, 23 Oct 2026 01:27:27 -0700 (PDT)
X-Received: by 2002:a17:90a:fc43:b0:3a0:d7f2:5a58 with SMTP id 98e67ed59e1d1-3adce0cbf64mr832683a91.3.1792744046525;
        Fri, 23 Oct 2026 01:27:26 -0700 (PDT)
Received: from hu-parihar-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adcb0a27basm2692616a91.6.2026.10.23.01.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 01:27:26 -0700 (PDT)
From: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
To: fastrpc.upstream@qti.qualcomm.com
Cc: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>,
        ekansh.gupta@oss.qualcomm.com, quic_bkumar@quicinc.com,
        stable@vger.kernel.org
Subject: [PATCH v2 4/6] arm64: dts: qcom: sdm660: Remove FastRPC compute CB9 entry
Date: Fri, 23 Oct 2026 13:57:02 +0530
Message-Id: <20261023082704.2859978-5-abhinav.parihar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261023082704.2859978-1-abhinav.parihar@oss.qualcomm.com>
References: <20261023082704.2859978-1-abhinav.parihar@oss.qualcomm.com>
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
X-Proofpoint-GUID: ijqVpnvN_YU_ZxwXgcLUuRR9fALQ6TPA
X-Proofpoint-ORIG-GUID: ijqVpnvN_YU_ZxwXgcLUuRR9fALQ6TPA
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb1a70 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Bp0rkiFJIKxNgHgNeN4A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfX5j6Zm0Yfubca
 PDSiaCl4aIziU/x5o6qbP9QzaK9v1ZmGlruW2SPRQRLbjknslTEz/zoNWTj3LUH0Ic1yOz3Af0s
 qjhBxn8X0RhlxKdpov0YyDJbepdsPaU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDAzMyBTYWx0ZWRfX3IUt7IHwd8DD
 0gL49/mV7WvoP6NlncsL4XjFnnNppk28MtZijNx3kJ5RVbrucQAycgVDtibiVz4bdNoS53QD6cX
 KV/zxiMTZN6UpnO3Vnwgi3cnaWWl2Bv4CcJZaplK9imaS98PSgd9/9BlnuixCb5b2tED/+/Eokq
 JU2X1I1cT4H7deW/01B18ie7iOZOKDyDmMVrUkr+PeZ7oQxnbDcqmFfBTSt+KeDZbzUa6gNSnCK
 wR0FpcuHaLj3flDatiVMyVhjEy2qTxJ2XXEzfXIMzOm43I1PHk3Wnbp6FkzJQgRKnLuSwYzNYQn
 ein/91eWPw2218GcH5pCJMGD+yEbAP4xIeMQtZch2vaD8J4bchQjMAaV6+KSSN3wTYLCUM2zW0V
 BZQOiZK8bmBu/ynS/36DrMYP4VekRI9tCvPg8THUlkfz6cTBI+veqIEdwNwqHV7TF9Vl3mmAkJz
 2BwVVE1cZnVFpr2LzQA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1011 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230033

Remove the compute-cb@9 nodes from sdm660 device tree to
prevent clients from selecting a secure context bank for normal FastRPC
workloads.

Secure use case support is not currently implemented upstream.

Fixes: 708ab9d3bc5b ("arm64: dts: qcom: sdm660: set cdsp compute-cbs' regs properly")
Cc: stable@vger.kernel.org
Signed-off-by: Abhinav Parihar <abhinav.parihar@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sdm660.dtsi | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm660.dtsi b/arch/arm64/boot/dts/qcom/sdm660.dtsi
index 0fca9662c64a..723bffc99b67 100644
--- a/arch/arm64/boot/dts/qcom/sdm660.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm660.dtsi
@@ -386,12 +386,6 @@ compute-cb@8 {
 					iommus = <&cdsp_smmu 8>;
 				};
 
-				compute-cb@9 {
-					compatible = "qcom,fastrpc-compute-cb";
-					reg = <9>;
-					iommus = <&cdsp_smmu 9>;
-				};
-
 				compute-cb@10 {
 					compatible = "qcom,fastrpc-compute-cb";
 					reg = <10>;
-- 
2.34.1

