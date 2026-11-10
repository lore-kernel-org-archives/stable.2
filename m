Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304711;
	b=JQRUmJpc2VT9/WkMPOMEAuo5oNAfyAruVMpFlvhpipDyOUD4GFKLXoiTqoYE+Juh6kax
	 jaBfSpzyRqt48XWLBCBbPe7KaIfXLR00sRqZqguPmwsJCy8gANuTlZd4hYNmbRn3zluWn
	 xvrHhfoHruDoE6eAMSEU53/DcrfzshkRt9uVbPYcNxaf2RnTzarHVB6vmYiUnZQRVcRIm
	 ge8NmD69f786ysS76wlJt6Tpzgk4k9fhneYufqZB3RyG9jNubyDVT74Gei9p/nz4wcVaN
	 shgqcfOqosHCbQmQWZC9FUa+Wy3Rowddk+H6oc7ewXTWEPtAq/Ckgnm78ZZZzmr7K2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304711;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1UlnOQ4rWfQ9gnpZWWY98Nt3vJpS1G1p5S4K2DB6pks=;
	b=lXseUGayLW0Gf4OukqP7GocfDFkr1dcixmANfWRsqjMgylYXQliodmUbGJiK0+OnQTlQ
	 3sEmNKCqXHPADXUYtar4wWC1X4r/uP9aie74XgN8RKlZwUm46F4Wmkor0Rg5l2IOVrQIS
	 W9L0g8EtVz5IhhvR/OdvuwLGviOAVZ3bLQjtE9jijsp/WccYF6QbqlBnRb3TS49mWS3od
	 b9Q0WXV3PApz4HzxzHNV0oPylSEM3lBzmN7PnrfK0CikHaALs3JBAhO+cOwm2mAPH/px3
	 ZbnurFhxjke/J3brPpo9FtBqcZQeD3VuRDpBC4YPoMBWu34+GnBDri/v34BuH1ND0+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nCBIJFac;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SZoa1j2T;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB1060A3830
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BB1060A3830
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nCBIJFac;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=SZoa1j2T
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7krFM2770421
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1UlnOQ4rWfQ9gnpZWWY98Nt3vJpS1G1p5S4K2DB6pks=; b=nCBIJFachyn1nAcM
	bfTG/ySiVrCPW6gSlwvWhLPoutyqyBjmCNVsk8fhT2z+jPiTMJBCGEiZyw+C8cVb
	FoLFQjsRVP9oNrcaRr+jkwniThjiV7ovDqRpxxVAIY8j05mKOq+UpgVT8jMcYI03
	U/VAunD6PTxnFsvqSb3SBiqX8Dtqhr6RDMeUWKhhlNl3gf9sl33uwxmvy7M4CBCK
	KkHKKMrQFUNO9T5IESADpSMEUZxGtnAklT2bYDJ1Ph1+Bbh4NR+hEdBqnCvuy9QY
	SyUONvR4jdS2edncRq4nezYLHMqHuniIp7w9Lf1YGrkI/R8nQj+nqRSEzZ+3ms0I
	F4B4CA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huvtd95ps-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:58:29 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36d1353fdcdso2430772eec.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794304708; x=1794909508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1UlnOQ4rWfQ9gnpZWWY98Nt3vJpS1G1p5S4K2DB6pks=;
        b=SZoa1j2TBZmq54UsqNI5EbAngn6LS1gA4VSqymCG1iVPi/NBpmUGw/kx1wLzL/3Ul+
         wWGVksW0Ct3vr4WAZFGdX1rEy6NF1t3QaB5UO2HvoJzJVRoSTuW34K+a6h1kkRvG2gsY
         ATw1431rSJnDqySOF9zDeWYlVL3RBqG4bzgU5P8f1HcdKjoo+hdknSrW430IoKTWfkgI
         zRZgwIwJySmu92bfifoVBflhsMyUqy8s9FZ9GREl2xC65qeH9Y1gMOgt9PDaboSwG1cs
         kKYq4mXrKGd+x4z4uOZDDit3t/NOLdczdO+FjYi6N7wNMTm5sV8B+fWKaNG07v2ebS+w
         h5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794304708; x=1794909508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1UlnOQ4rWfQ9gnpZWWY98Nt3vJpS1G1p5S4K2DB6pks=;
        b=dgnq5DqdnI8UNfOKLTaiHTSvbPIG1xosE/wvk+Jd20bf6CS2kUHs9cHl05J6IgBt2o
         DrOsdpL2fr2iSZaNtj2FcvaMlEh+6bTouJzjlzsevIKUb8G6niNWIf4SpiE1JJk5qR4K
         xCYBoGGWBJ5iKG/gJv9MqTfutYRxS3/SP0Fm+SjbMNXsSPtUK3DVInhgRQyHoO04QOt2
         fdwOGFHU95WXMIYeGKYPttrYTsOg1P5ooln2FSOZuPtlUYm82Gmf4fLPksxihzpo3784
         YDqf6vS/NWuK0xYNmcY+Lun6uFqrLDh2K2UeioaFUPX3sKxCWARCqwx+4Zqmpfvdp48H
         auBQ==
X-Forwarded-Encrypted: i=1; AL+hErEVN3w6wzFtagC2wY4oiiq2vc20lJBL09usqwcSt7Sauy/nMrH3A2mRUSS1KKHPmZTxyxOOLEQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z80h2xoBcTNhx4MX9DE9ZJudAr31BeDVAP3qg7lMLqzGpZL5C+G
	R/M5i/HnIQBDChUbVFmHl5VP4J6yrTFx1kCQKvhXWKj0OkQK1tyA0gVph5yERBssUiNs9BbJOlA
	+k4KWlqfut81Wa8MdmQ3NjIiavHT9XuSUdUgVMqFU42SNbdRzqI2r+ysUTXs=
X-Gm-Gg: AYBFou0Q6v12xhRw4ffVi2YxsOXiyURduHlTZsgDqrwPBxECYBHZzZe06BdyQSLgDDe
	JSxELZmtiHLeK60SBgzBIGCYZ7hBY36zin5eqe5IGH+izUoweGhC32JIaXndDOGnZVQS3Duf/JU
	5kt5ZriapqmSWmEwOzgJFLomvsOKeqIiIWI/QTlo9DgcWNSTtnedHY4pCoYSc9fiifDJij4wkQv
	tuOP1/sCEkZe9f6GZuv1ltDnD0Fyeiv4bTVKIcMYXD0lmTnZbheosGnQ9mqyBmZmN3BN+GL/OY5
	tBgzddIxg37ziHnI5pJNHCByT4kHE2I374wgwjFT2/EDSV/hWDXIlK05IYn4j25dyUMFgwnHe0p
	dJdXHiYGv1KU+QxG4YZHAAeciW+5HrUMmV1wG9FxsqYTgJzckFT5g+l06uy1hpXMR9K+wPnz15h
	fHwL0qZg==
X-Received: by 2002:a05:7022:3c18:b0:181:73fc:e53 with SMTP id a92af1059eb24-1b3b617f6b5mr2779898c88.29.1794304708412;
        Tue, 10 Nov 2026 01:58:28 -0800 (PST)
X-Received: by 2002:a05:7022:3c18:b0:181:73fc:e53 with SMTP id a92af1059eb24-1b3b617f6b5mr2779872c88.29.1794304707825;
        Tue, 10 Nov 2026 01:58:27 -0800 (PST)
Received: from hu-bvisredd-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11346sm7333141c88.7.2026.11.10.01.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:58:27 -0800 (PST)
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 15:27:15 +0530
Subject: [PATCH v2 3/3] media: iris: Use firmware reported count for output
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
Message-Id: <20261110-fix_dec_seek-v2-3-210d8c4fc31b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794304687; l=1644;
 i=busanna.reddy@oss.qualcomm.com; s=20260216; h=from:subject:message-id;
 bh=w2OxykH7sbFu9wsbTswZwhTlE3jYoJAIFTL8aWVq6mc=;
 b=dnMxMPuhvVOA5TkV/Y8KsSgljPBw02l4Bf1/AwRdFsliQ35CijLJMXKxTHFymnUYrWUOItdbA
 HiE0PHibsA5DyQdP/mIBIMC97Uy1hR8/rPC3ayDjMvk0ybhLtqAHtdj
X-Developer-Key: i=busanna.reddy@oss.qualcomm.com; a=ed25519;
 pk=9vmy9HahBKVAa+GBFj1yHVbz0ey/ucIs1hrlfx+qtok=
X-Proofpoint-GUID: ORIQN9CDobhh3CluFgwkKy4PrdT1Tcse
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzOSBTYWx0ZWRfX5i/SfNURc2SN
 9nYuREN3Q1ocTSLhP7fyOsOSWiAaXIdPw3rgccESAdQhkcDoXRzEci7aILDKeq0lArvA10asPur
 ePPzzRdS/fup8gCcksV7CWnaQo3VEps=
X-Proofpoint-ORIG-GUID: ORIQN9CDobhh3CluFgwkKy4PrdT1Tcse
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzOSBTYWx0ZWRfX2zk/QATCjCOe
 YWaU0cPsMjplOtN7gbOv6cqe3H7XqzsKlfQbSfC804LIRbTd8U4szxA6p+OwDPLVVdO5kHrLLtQ
 VlURqSbDI5qosW44VJ0oF/A/YlzuVd/httmEh3jVU18qwMbpQkwGcLCUNyOzyGbooUZFocfuGWb
 IAK47lSoex5QgiSvgfA3jzXfANL6wsPu3o32G+vDGsJijjfYx9GIcpP0KJfnjNCNR4BHp6wVhsv
 kabpa1tAJYYAaBJ9rVqsEJMte/krpVGVzDpkKN7Bh7QKUg9zXfnB5L4+FVoxsQeOwT3K3CayJxC
 ahKzPop+2wHO3fjQUI7Ls3gcrut8UhHBc0FTFXdkb9lrLlVzCrRtqt24rKuHg7c1N1eRf4/p830
 BUK9DgXee7oG3zJCIEbV2DIvsHB4U7HBgr1OhpvPKTsYJaYchqkSRsEvjpY55I5SizcQSnjvS7P
 1GzL2lny9rNs6J7Vt2g==
X-Authority-Analysis: v=2.4 cv=ArR7T+9P c=1 sm=1 tr=0 ts=6af2eac5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ngQ_FiyG7nPeVDEeuhEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100039

Once the firmware reports its minimum output buffer count, the driver
still caps it to 4 for VP9 and AV1 when split mode is enabled. After a
seek, the output buffer count can be lower than the minimum required by
the firmware for VP9 streams. This causes the firmware to report
insufficient output buffers and the seek operation can fail.

Use the firmware reported minimum count as is. The driver calculated
count is only used until the firmware reports its own requirement.

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

