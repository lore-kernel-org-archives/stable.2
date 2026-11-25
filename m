Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795585276;
	b=pcYLhTo9I/+p6Dw+mWV5XoXcpbQf+6MiW6efrqCpfRLV9puVqKQsm2sCGosZYuLnkYVl
	 Avr8ebQxaLd3TIFvdAzJMDEOr1Z/W8BrN1vDMypN3kYLT00DDmN0FsDUY6qbfSZHO7IE8
	 qWDyBZEBR9WMT7qv06SKTdhN8yM0Es0OWJxjS4eV9k3N/vjm4xFkn8mkYyRehbrGvIAwr
	 TOXagkmeo+jYTRbYaCX+PbbvLGbNKno3MEptYwEacrf4Rj/2HWHMOapaQyC9KG2OhiQ8j
	 XIKrs0r8ZEQYy28p8iU8EiLXubiSlJ6dZRNoakXZP7B4F4DYq8ajYAKwjmglRGsZEig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795585276;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=3pM1+ScPXqw2BSd7iFdjCVQ4DP95QrCl2A1gDu8xmMU=;
	b=U08A995BRT3p0fTI1wolks+JpPpuk1tPeKu6p3WN/wN7QTZ2rNuDxTbR+XmvrDQOp5nu
	 mtPjibc2y+bNSUe/af0Nl5dfmvW1r55+kZCSxyiZaHJ3rVoPP9LEbjN4cKlRbAPN/CltL
	 jixqjl0w4rsH+hlsClDIejjIJ5UNOkDOKy39CbE7mded7MRp1hwkR5pZ4XihxutrjIe9V
	 iLQB8Uu9QLnlRvJ+AA3fQMp8NIJaZnh7nKPeCZOxQWzPrfmKYmrbVYznyHFHpOP/68Is7
	 EmnOjGLlAmCaJhLPm6QLpdBQzu/tDkgwfHvoZCCFTJ9zbXdvAzRp270ZtcV4Y4RptOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AusBAkfM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LCBoDKKl;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7758B606A335
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:41:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7758B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AusBAkfM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LCBoDKKl
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP2Avn01342532
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3pM1+ScPXqw2BSd7iFdjCVQ4DP95QrCl2A1gDu8xmMU=; b=AusBAkfMHl1r+Pey
	GwvG4cf7cTlD4JHKr+tNZoG6HHX9yxfzpFOuCDkuNM8T+LVM2t5BQ1dDgWmAQMIB
	i1ISQEv60vTzZ0MgncFv9DhcH0/XJz9zp+nIpbZD6lo+RtMyItC7ndbujQyxO6Nb
	0nAyqAs04AdHuxR7TU5C6GmFj2CBU1gIbzF1APyQGZNGTu09J+8wDhOGP41xC8zD
	B04HJm4GPxVQGJUsFdiuQLpIrvwoQ0dbaan8nwZvO9EqM/8tdjYaWDgT54cjDFLG
	qSB8Ou7ZeJt83UQ1SuKsNzvhiy3Ft2O0CXr7ZMOwLF3/OHsLgb5+p6mmRb9mKKsx
	ECqwFA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5nu68tfg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:41:15 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3b427e5a37dso4329373a91.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795585275; x=1796190075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3pM1+ScPXqw2BSd7iFdjCVQ4DP95QrCl2A1gDu8xmMU=;
        b=LCBoDKKlEpPLxttzRJD9cG3vu0X6hWaSXLwIX6w308XLhYIo05T3bvUK86bIWge3aJ
         8DQRfLprRpi/QQqO1NuBnUR1Tgus/e7JNeCmVy09HFCRRfNtIB0Tu5K9vv+7nOuhdITe
         HjPsfN4blPOzSAQhd9qlMZSGcZsty4fJMomuzAhUxPhHmdcwK2hD/SXbszVi1SmRpfHv
         IUklut4bhPQodq/sb7moEin4ygtuGrxbaE0UHswhtXeQOyZTkrjS1WUp2yOskaOd/8i3
         KRVomLymggbl6jn4rMBqlLdUhpB88yglQ81XUyLQQMe23S7mj3pjN5On29VyZ/Q6U2Cb
         j06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795585275; x=1796190075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3pM1+ScPXqw2BSd7iFdjCVQ4DP95QrCl2A1gDu8xmMU=;
        b=sIolUgMusfTxN1pjTe/ZuUGEhFF0KQPdZoe5IOiXKOTMMW4xZ7UZvxDmeSrX4gTfOc
         FtX32Bz4vDKvwbz1P05ePu44F2+h1Tkc0Pio121hA1p2aljy1gM+9FFluL/Cp8ye2quC
         qxWydY40l0PqDa7tSy1X33PYzhxbc/mj4ezsC2ZcO5JijgTs4LHSKDa3ssvRB/qzJhWI
         5gAE43++AVuqNhVg1BAoTr3VAhb8K/HYBt57CphE1uBTpgAQdz2J7PFGhAf0a6ox+fIJ
         jhJAw4ULCztNMioGPJc8rHYjW03g3WLaqpm1+tsZ8LpmQ4w0hvBPk3dtOqfhLzGCoofS
         hlZg==
X-Forwarded-Encrypted: i=1; AL+hErHIcKIF6325B6xi3bafp0cidZvX0I5M1jpzKqDQCkuHDRaBoJoiQR/jC2rmXZMZls8xN1zZSgc=@vger.kernel.org
X-Gm-Message-State: APuU4Z83H/ZHevc1IczlQ3JlraRBec0+enqOI12N2mrAk3/ZY4wuaf4J
	qEPR2pYBwGpofF0BXNu7mDbIRyMb6S+iTCiibLGI7NuPrKBnZB5shV6MmmZ/yhffSDZJFU0+Xhd
	4n0V04WJPj/kahOmWyAcGQsSfNOnw/m45jE5nSFjmbTJoO/Y7hGuK//eyIno=
X-Gm-Gg: AZFdTZd2YSFUW80d3cJZkxIehbYIMgfju4E2qQ87SGDg1J299MfqbZLgAhNFSA5h0EF
	vWPpXCXuMAw5vWvrSEGg7W3/hIy4MN3Dsdzrf0reHTlJRBWdQ+BT6l7a1+tm0FlxPpvMQdnZZgU
	ea/y6/1JZA1WJf9x91RLgO6/cVmbKEWZfWjgJjZER61N5a8OEDUayazysNB9BByr3YaYGkXIbtP
	XklaMQQBuWiYkKQ5G3pL5okCe0n/l6dwHTJh44wAB0mk/Abnrmxrhc7EUpBIqSm0CYT3/RxWMU4
	vMII0SZ3ulp7vtP5/kfExrn1h06D5x7mcl9Pcel0/42+sNFewr22DItJKQowzJHWGXd9SEfSGY6
	phKlpKr/Ac+SzRRByHT6tYycQ5mHg0k0vR/BY+BLJTZAZRyeFb52viUuJXCkivWUtucyoz8Wp8Z
	zX/XZhE+Y=
X-Received: by 2002:a17:90b:2416:b0:3b4:c66c:ba01 with SMTP id 98e67ed59e1d1-3b4c66ce8f8mr3546462a91.50.1795585275034;
        Tue, 24 Nov 2026 21:41:15 -0800 (PST)
X-Received: by 2002:a17:90b:2416:b0:3b4:c66c:ba01 with SMTP id 98e67ed59e1d1-3b4c66ce8f8mr3546438a91.50.1795585274577;
        Tue, 24 Nov 2026 21:41:14 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b409330ae8sm28897957a91.7.2026.11.24.21.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 21:41:14 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 11:10:25 +0530
Subject: [PATCH v3 3/3] media: iris: Use firmware reported count for output
 buffers
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
Message-Id: <20261125-fix_dec_seek-v3-3-66c9889def2a@oss.qualcomm.com>
References: <20261125-fix_dec_seek-v3-0-66c9889def2a@oss.qualcomm.com>
In-Reply-To: <20261125-fix_dec_seek-v3-0-66c9889def2a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795585253; l=1538;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=xyePRasdnpLsafhfZYAx9HOTRZfG/52xPinQP+y2ocQ=;
 b=iPakmyqAO5AduAaevjMNoFxhFbaFX7qUHZiYjhXidrOhyWzhIML7MtHw5cow5op0EaQK5rDOq
 7k4/USEpMHCDHAL/vKyO9BYDcEvGq4Wus3UhmjPlsGulp9LfqqF0bZS
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-ORIG-GUID: oNSKWC5_yTl7hbdauBIOMnMIACCY7nFA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDAyMiBTYWx0ZWRfX+xoIvLG6IZHB
 1+mIsMQ0kX8U/nw1V0jUz43n19rr4240AJ12APTwiC1CgEIBx4RYaba2kHfOX4W3dHqt+NdKgy1
 9rR9S0vrLGsfLjNIkF8g4Xz98vP5h90=
X-Proofpoint-GUID: oNSKWC5_yTl7hbdauBIOMnMIACCY7nFA
X-Authority-Analysis: v=2.4 cv=Vra2kO2n c=1 sm=1 tr=0 ts=6b0674fb cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ngQ_FiyG7nPeVDEeuhEA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDAyMiBTYWx0ZWRfX3bvQ+aH0psgG
 tUXzzrH+8mn9iwPIiJDrN88yx4AsKS1IO1LRX6bcw4O+7F74Fpi8MLB1O6KoGW+L+ibbai+VlBv
 RAUsdpUnCpIHkFajyRgvjFs4RYWsmt8liDGJts4sRPH260jj66OEc8SPdEWIiB2ydW1IZBCKo8Y
 bR8/dEQONbP+2ddoca4ulWueG5bMnjBcMD7XvHwg/L6XlVEEGFNxg1sfhg5tSuCRwfGgZgARaBp
 AdK0dNUk4asFkzA/ABXXuRXB/TzA7vaFNVKj7JpGaG0AlFOQ3g9vll3S7JvXWF/R2eNvzn6fZ40
 agL30ylBz+afQkBgYE+LjPiSaAGHqb5P+B4kp6jWaoDJ1vYOhBX7lAc6JBvFEw0GAB7L/Rbymb6
 sJggqOo3mmnHL4uzyns+fGAUmqImbaIbDdiQRSFj/002Mba/j7+ptJt7NXTW247y8I1BvuElDjR
 Wl/SDleIUXlV00G0YrQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250022

Once the firmware reports its minimum output buffer count, the driver
still caps it to 4 for VP9 and AV1. After a seek, the output buffer
count can be lower than the minimum required by the firmware for VP9
streams. This causes the firmware to report insufficient output buffers
and the seek operation can fail. Use the firmware reported minimum count
without capping it.

Fixes: e1f5d32608ec ("media: iris: Add internal buffer calculation for HEVC and VP9 decoders")
Cc: stable@vger.kernel.org
Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
index a8170e5fa9e6..57467c952f42 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
@@ -2375,14 +2375,8 @@ static int output_min_count(struct iris_inst *inst)
 	int output_min_count = 4;
 
 	/* fw_min_count > 0 indicates reconfig event has already arrived */
-	if (inst->fw_min_count) {
-		if (iris_split_mode_enabled(inst) &&
-		    (inst->codec == V4L2_PIX_FMT_VP9 ||
-		     inst->codec == V4L2_PIX_FMT_AV1))
-			return min_t(u32, 4, inst->fw_min_count);
-		else
-			return inst->fw_min_count;
-	}
+	if (inst->fw_min_count)
+		return inst->fw_min_count;
 
 	if (inst->codec == V4L2_PIX_FMT_VP9)
 		output_min_count = 9;

-- 
2.34.1

