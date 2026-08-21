Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1FFC409E01
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 06:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294194; cv=none; b=cmkzT24Wzw8CfWOJTZisSM5eL/Hu5QKXi3wF3q58DJWSN7sXxMqij34CzS4/+HrCx/pGlVluPnYleVrpODhNzOrEr9jkze+MtduCqLaa9ur4WKV58b9rgzeg8hCFN60K1B8+GRAFlS9UFf+7he8Mjdb4Z3ugObt3stXEyx2ofck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294194; c=relaxed/simple;
	bh=nzZOtbt5OVvyXTsuO2enZMGjCyp7ObHjMnPZY+OoxFs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XRC1OOAFBRto/jhD1Vkn7Kxg+9Ydn9X/VjptYlpWHN5HXuBVlNCClfDNNGmS7In9dopXEUkUSVjvn9e9+VacSirwWAuq+PX1HY94C2DbM4SSOXqo4uyIJJphwQPJ1eMQyYzrTgcEgBRSp7XiQQb5FGx3Buaw3Qd3GkWt7pl2Ux8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QmYfYqHT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hVcRE5Xo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QmYfYqHT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hVcRE5Xo"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L5UAVI1370010
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 06:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qryDsqatoi20683XWRj2TQyfOjsImSdTWpK8VqCl+pI=; b=QmYfYqHTBhxbYCWf
	sqn9kwqRqxtyhewzNt2a9VyI0mabwmRmqDhJ7HVkFcHMIXhTF7VgydASY/UHATT0
	Cz5rq4CboK9RTg+Wn2ULO2RF8AGI3JJJk8p5lxBf3NP/sHcGMTRPDne5yEi7auKP
	8gjQYCtKZghVCMcdJpMEJFtqdkI3ZmrgrMID0DmwqhSx4UQH/ALfwyxG1oQ+JybG
	ET8Ol80zaUGtYcT7qVMHci5YAuap6tlyKAH1fomymjKJtHArqFEFcgaMixe3flq8
	+1XeneEbE9ElWdpuL/mpuJi3b/diZgI2CrczGolcGM6RFB+GturgPXes4+r6wjqd
	zJ6xAw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6gdn87f2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 06:36:31 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so1088525a91.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 23:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787294191; x=1787898991; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qryDsqatoi20683XWRj2TQyfOjsImSdTWpK8VqCl+pI=;
        b=hVcRE5Xoh+TSQBJaIHHJZMJ8xGMdAUV+Yzo3Lfm3enGjEYnEEOWCaHHnGhX6nKZuBF
         uxNOsROLra2d2bVTjwlP3m8sBYBBTeMKl0Yx4i4lvC1GPm8EAO1cV5orPQJojPXfM8iz
         nPf3wJcGaUzPqnrPGkFdUOBtXOiaybaow7DogYBGWMPm50wmv2D1VW4ObuiNlZnFHcDA
         SrH2gJl+heAhcUw18rYPG3DhKLVRw8JoTJEwpFskg66B2Om+bmB0kKa9eojpRi1Suk6o
         dvKmKdXbOKMWcd/ZZ+JnAaZIKaHv/ln09HQVC/522Gt7v85aFM88NbRX3yCXfbs6Hc8X
         FAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787294191; x=1787898991;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qryDsqatoi20683XWRj2TQyfOjsImSdTWpK8VqCl+pI=;
        b=gK+kfCAkIFSLdhbLsYii89ao6ml3V3t+GuFhzxd2PEdvs7VGu6Ot+0sFrhFyUod4x6
         T6HdusuhNi861b5ORtpgqWBQjmhN6LxEg6ooPOOTvlh5wwcUCdGi+Ca+iHM42qQFIt7o
         dciXUykt9oI47yYdwg4bdB1oGk8hwx8m2vvmd/h932KY0kO3TPHGUwkwg8oauqLieZA4
         h/CNhipTJSgyevjxONd89tiTxFb6rA+7YHRQuMnWNgoILuCdgzGlcUK/VyLsbtKhHiwK
         MbrnwAxLtc0iLB2hhwfm/qzj//xerBx9tU6Qji3/V5KQX8haEQKq75rINApx45cFWK8v
         jBlQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/tTYxEg33lvfcDMe4urFMdqKSBiwmmFHGgrdktC//f+bcXEfpkkrv0uO3KF52F+VYMGhPRNM=@vger.kernel.org
X-Gm-Message-State: AFuF++nuMGrqOgr4pyddwXHoz6KbRnCT0EP8zzMRbOa9aK1k+qDLH6Nw
	60VWXx+WKZKBnCXZqg38hHLz3FA8x/YyG59W9UnYhSg8H5N54lVWWWVRlZnyfMtGeKA1yqMcUoq
	I4+IH31WocR+nETUcWhblcIkmfqB+K+rYPcqEv2p4/F/aigSH7ooo4g/7RQVUzpuphjY=
X-Gm-Gg: AR+sD12RzBgtqUbnEnl10ISMU/kMJHT7ZDIwbVQvauJc3LxFC9lK3/liKKyBVB379CQ
	5ve0EdA1G7CzqL/zDhth/mdKGhZ3ZNVWSAxP7IxJv+yjNPoQw8HdOtwnWv+XDj8aeNOtJbPfNDm
	LP4jJfFaIFmLED38dJDfh5jUbmEkZDOJKSegRtqLY8zHw2ZkbicKagqOkWcaLTxHIcn56e0DilL
	R9VwHdYkUW04Xgb+j6Xh2k0KCScZf0diOzaJEGCC7BZrrR2l7mi/vVs5xe3YcFPxzQ+jrv9h44V
	tpsqaY+iW3XUnd4DJkN+DxPlTpjup9pY3BWkA7DgYslVI7cOXXOs0V9oPbKzsKl6LAbBwxpeebd
	9DVI6XZGeloMcQB8Yys5g746NO8i0y4E9pDSI
X-Received: by 2002:a17:90b:4fc2:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-395c33e1194mr7801564a91.2.1787294190832;
        Thu, 20 Aug 2026 23:36:30 -0700 (PDT)
X-Received: by 2002:a17:90b:4fc2:b0:38d:dfd1:7a8 with SMTP id 98e67ed59e1d1-395c33e1194mr7801532a91.2.1787294190422;
        Thu, 20 Aug 2026 23:36:30 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4c3da9csm1787377a91.17.2026.08.20.23.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 23:36:29 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Date: Fri, 21 Aug 2026 12:06:17 +0530
Subject: [PATCH v3 1/4] soc: qcom: geni-se: Fix endian conversion for
 serial_protocol comparison
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-fix-write-to-read-only-firmware-buffer-v3-1-43e6a3abd651@oss.qualcomm.com>
References: <20260821-fix-write-to-read-only-firmware-buffer-v3-0-43e6a3abd651@oss.qualcomm.com>
In-Reply-To: <20260821-fix-write-to-read-only-firmware-buffer-v3-0-43e6a3abd651@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787294183; l=1231;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=nzZOtbt5OVvyXTsuO2enZMGjCyp7ObHjMnPZY+OoxFs=;
 b=BQQ1wJCWvzeU6abNEBjxhD7QNvPqS3ho1zXZzQ+AXlgB66HbSCIT5aixn1xBTi2RnJDVd3OQx
 u5r+IVkjLZ2Aa0e1GcAjYs55d6/mhVa47Sh21OLCvKQ45M7rict32th
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA0NiBTYWx0ZWRfXyzbEoGHow4VE
 U4qCpSWsJgYxqOq474liJS5peI7MIAwEcNQB1enzDLvsQ1oZl3WUmfAR4lrba2ljmBqBGWvIyOP
 x10mnxDq7EkiaZfD20LAGRe8LLOJWY808v35NrwOjITufz6YMSTdusUj1BeYj1WlBBmlbTjAApH
 +0vLuGms7PayLkH8PaCwCLUyxzElag2hT35I7g2MUMaXg2mgkb2158DgxEv6LWt1LL4BOrqo/By
 Ndd2s5wKD0TdWx7Ce2YtKwJsHMsCWv7tzhdySL89ziqW2OyV5XiHi4ycc6u2VsS4f879geFhn2r
 PfE8ClDdWwRg9+2c5c0GsqjMmc5gv+ymcloQwc7dHLDl+DisqeB6CLRzqkCOnFdQHQxfi2GnM+4
 XZB8xRVcAM4ZND630ok6kEYPdw60YxDmHpQJA6hZYPVCDONfUuQ+LZLLJQkkfmuVHeWi9eYXwlv
 AtCo0KK/4iuLHybx0Gg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA0NiBTYWx0ZWRfX4VuVt9dYexPb
 eQwjKnXZ7e7xgvvWVwFTN/nGPBSPNPEgrEmg3O8PMVO6EY1+xp0DtrrJaQiuzPIKmm7DM3H05yv
 KfMBoLEorJm2vWYbTNdnTX1afWNn6CY=
X-Proofpoint-ORIG-GUID: wAZOgRCaqD51xoRaXj0OOTw5bCL2tVue
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=6a87f1ef cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=BdrV15eiT15NMrSX6N4A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: wAZOgRCaqD51xoRaXj0OOTw5bCL2tVue
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210046

serial_protocol is declared as __le16 in struct se_fw_hdr, but was
decoded with le32_to_cpu(). On big-endian systems the extra byte swap
causes the field to always compare unequal to the protocol argument,
so no firmware segment is ever selected.

Use le16_to_cpu() to match the field width.

Fixes: d4bf06592ad6 ("soc: qcom: geni-se: Add support to load QUP SE Firmware via Linux subsystem")
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

