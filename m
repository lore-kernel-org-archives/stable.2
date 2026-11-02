Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631683;
	b=OfhBpC4/R0tFrTube3h5FkDFO4+Sxu4P1OuWbp6WzbXBZES7OFc3vokf63ul1OVKZCE3
	 2A1FJB6llIHUIeo/LmkU+7HQvTUFSC9Nxg7r4bQBoIJx3oYgApZHEeJAWsuN7nhvnTTVp
	 9HPo1u8aR7ahl21vCtg3owaC0BW3FBW5atO5aEqHWcPpyDyYwP5ky4YSO3ZxIxuD8vul8
	 zGKWu7hNEtyHfCjD4X/Nj5jZFq6/Nicwjg6HOhol8T3+H9JzErOLCOjQJDCJOb7syJDn7
	 i4svW79Ggpzoxi2Bcq83SKWZEvhn63tRNmOIVERS1YmZgF0Rm7Xu7Q4Re9GWXC73CaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631683;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=FihYy7TOnYbSFAFPXg+VCzs/2XkXfUorlToazOp5HEw=;
	b=FbWVysKn4IttED2jh5v9l6Ph0hN1GQC692izofU4H8DvQq6VldTbrQlTGEAMLVCIIQSE
	 sklXLsAbsEJclbxlFGXEeqYMNzy6a8MB3wAJ1LVDhtZrYifdkkPxf1qOPBP3rg+0FEcNr
	 ppURQJG8H2GM0IAIQHlOzEKYozmrDjhdqZIT6drxPLQvfVTk4zAjzQtnNy1lKDf5sduL5
	 twQp3nfUppjiZPopsxtkOP4z7juKHaJNvVaBoEBsdnMLjpGU19RmZh55kyI7qxn1pbRMN
	 Sa7CQJmXNWeoLprrtWf6VqCF0BgWHzucUNzfy4jpzkOO9T0vWQH8TO2bNadLqpObc7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RYYcQ4EU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GPgie7S5;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042E16088B16
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 042E16088B16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RYYcQ4EU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GPgie7S5
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DpIZO3102589
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 15:01:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=FihYy7TOnYbSFAFPXg+VCzs/2XkXfUorlTo
	azOp5HEw=; b=RYYcQ4EUdTxB/gqilviCGo4lwnmTO/r6IXYKIec0HqXxv0Xi9L3
	fg3yElEq+XQ3CdCe0i3irk0z6guSTj7IYvWeca7OA+dE/3KhkqDN4tncT0Y21+vk
	4FhSMVkzgXmrH85iHVHMeCno9SBJAl2YUkMD9BuNQrloTA8UzCxbcnYz7j6b4z6h
	fEPwDOMYtO3qvpoailED5xucaCUimezlWTKk0+3aQog1KdeEmW8h+Rc4fKkZKCmz
	Uy/zZn0a8m3xVrzY9TfR1NExZoxkuzFJA9ONl9vw0wS3bcbN1GbszJi8JVeZ4RA8
	SVV/Jan11UUiVnSEMN0pGcnXMrtKDDcZ/yQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpk9rjcmj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 15:01:20 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5eab0467c89so3968639e0c.2
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 07:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793631679; x=1794236479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FihYy7TOnYbSFAFPXg+VCzs/2XkXfUorlToazOp5HEw=;
        b=GPgie7S5C+GwAi652gHofuix0dUTLpdPfHzMzryaBnXKN1D/+xKHvJ5yfh5cz/yi5I
         o/Wi4V9jmr0Hb+FxTbE/DjyDFxU8XazYPAl+l6LijZgt7AAXvglqjjQhd3C6gpKyzVwB
         2YEK7XQYDNhNTMSppouMR3C7kvpT53q34zSQy9sFMG95TXXCuNh7LhTLympCJDzINfyk
         DDmkHV/2MlIpnyng8USWAr33JOdQL61BASSUNzY/CDT6/qe3ibchw0Ly9OHjIh8aoxH5
         1GsHC0R3aZxWh3jpEhjQrhD8oKYBL8MiL/+Z/Ha8olWTtCnGrRHFZxyAHlJIG2EMf4Nz
         5PuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793631679; x=1794236479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FihYy7TOnYbSFAFPXg+VCzs/2XkXfUorlToazOp5HEw=;
        b=y+vcXPQ15zRqAh3lEtN5qW62xFeNdcp4lMOKshnhxUzhr3rD/CIEaRZZh6sS+YLecg
         QSon1T813lEseYyRHky+k77UpasNv4S94/jwtXKNEqlJny0jQcmwEJxj+QOj61/rtIoj
         sKnIbMCM161VteUZYgWIMogkjKDg/L3Gm7ZZg7dAuCn6lPz8993QC3rnPTj6XoyG8bE6
         w5U8xPcsvklbpZcZ7YQ67vw2SqzZx7sE+XEjYuCqrtVfVdsr2dYPrCrOC1CXa1NroH0v
         9qf9kEKgekoCm1bNUMwD9Tzd0E6L73TO+FjQ0UahYConZBC6WlmjgL3CsRhBcPpnxe+R
         zN8w==
X-Forwarded-Encrypted: i=1; AKwUvBzg0EE4Tic/dgwm7iE3mq/sx/oCTKE5y3WOftP4DWIrZQc0ufAM0XHJQFOhi/OTjtLr170lYu0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uvg5OmVsLEBHJsQM7lrwhPcp2ciNhZbhuOR7cjU/CtlsaX58D
	WTjDFIxxvPfU2GS7gkOuBYzH1hjNpBNelS9tYnGdX0tRk2Qp6AgorVLp2vCT4/0v7uwEqvSuUym
	6ny5JMF774Qdwkc7GMJLsctE5/tcl6e2RbAOriYeGnUUPOopZLdrNL8HvicY=
X-Gm-Gg: AYBFou2S5luMeEAUpO8Vj6SH9MAHE6Gcz18hmIvV15lw6znCeHKMhcHxLnsyBhlXK0k
	ROGv6poaxV3pMrB3piPX/pD8iO9T2uSPa2z2TWoRKGMhUE+j3UhLRb5MzJdPKx/INA5h3VSJ4tN
	4doBagpMOvcBPeGdKQ4pzSpjylvCO7irmTN55HI8S7QP2xouDGEuEaLV4gSSUz8X1uteRqdnrW/
	I0RYCMk9RX3oiOYp0n5VdR+QcCK/33ohts0uQSD3cxSEKSh1tb9UsIl8wTZ5JyNm41waxL+t1dd
	4Kl/zHEp8kq/PTpi4tJBnk5aSjuKswUHnuFhTwYgsTvzultlYZ5zYW4ZW4miJf84aGp+1XlWNjF
	TfD2w7WNAqk+Z2pYxxj8HHKa9v5AVQPWAft/hALI5QZCs7LhbS0qb9G+yA36Q4w==
X-Received: by 2002:a05:6122:e46c:b0:5e9:6d96:a598 with SMTP id 71dfb90a1353d-5ec68953084mr4605344e0c.6.1793631678394;
        Mon, 02 Nov 2026 07:01:18 -0800 (PST)
X-Received: by 2002:a05:6122:e46c:b0:5e9:6d96:a598 with SMTP id 71dfb90a1353d-5ec68953084mr4605215e0c.6.1793631677480;
        Mon, 02 Nov 2026 07:01:17 -0800 (PST)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf368bff7sm279827185e9.2.2026.11.02.07.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:01:16 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Sumit Garg <sumit.garg@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
Subject: [PATCH 1/2] firmware: qcom: pas-tee: Always initialize resource table output size
Date: Mon,  2 Nov 2026 16:01:11 +0100
Message-ID: <20261102150110.227479-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=Rm/Oh/L9WyT5D8rfKiKyP1ZCHuU35dMVl3bZ70YesSw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq6KW2ngE+f+BWLvW3FLnusMQw+cBFT3BIDe8d9
 8u0rCz/LB+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCauiltgAKCRDBN2bmhouD
 1+y7D/9C2sfocUr5eTVqoUPCXIpyKG2rvbdLrh2vkYMCn/yS+UNOClQniwFuFdhtfc/8A7rUU+k
 kHo3hcLXFHBT5R/qDuxDwzyqFg3Y87pxMCGVIPRtzMtkx1KXg7nydNaATDz+wT9G1wJgW+FXr27
 IHXK5MP+txGYQqD6VRZfgLLXX7Vb3U1fMzu/QBXkCLaDGXnkjPymqyfrBW2v4DUpqyLCNIVsk97
 Okco7j4SeyFLX8MCRsx2LstAUP1CnFda2WTobB96I+Q0s89daP63aDBsXzAfBd51pdONMp0AEOy
 I6YA5/CgxN7cv/A0DRaVGnExxmOUELF239Jisjh/mF0nXm5EnDofoTam7sGs8ul4USaQb6kfvi5
 p3SP3H7M/hb6HJEHwTDDNp0Hdtu0IQlsoypfXNCCf7v3UWBS03WKVheUIrd53f54dcEOyuiExU8
 EtzwTLFthLjk+WComIu5YH5UalTRfXvy4hiYwbRpc2KnEbrQw6SMBOd6GFAWP3YMWLQU8jgGtLd
 7XraOe6YCiiPj7khPUkRCPegZo5JIORkvNkCPvLgUiXEhERYOZbCUC28W46Lywkk4KYCXOI3+5z
 5vo6W3TL2u6256bzNDcXyQU88R+x1QT6IudvuIz0o0PX3TNzzk6zW7C52Mqc1goca5+TP6TEVHH MYp2qikRwJxOaKQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1OSBTYWx0ZWRfXwOp0bAantl2w
 eWEolZ4YsuEo2jykNZz46lCstQvxL57l0R0KC526QrikoqshZt9ciJRimADjjgpGe18XuUtfJgd
 CB318ZvWe/tYXkWGQFq/u3GIpHFJL2o=
X-Proofpoint-ORIG-GUID: S3ZZdzhRtzLN1O2bEXWWNm5Q1c1w5qZ-
X-Authority-Analysis: v=2.4 cv=LvwHWXdc c=1 sm=1 tr=0 ts=6ae8a5c0 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lnzBmoKy2Z76xE5QrQcA:9
 a=tNoRWFLymzeba-QzToBc:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1OSBTYWx0ZWRfX+FQKz3N4hAwu
 GYrdxLWt9PQ+RuVitz3qxfK4fZr3LkNYmHtPwuyTxToVZRaqrYC8wVoTOaus4nV4kupqA6jkUO9
 pFuzKjP98KlP2ame90CwYLi3uGFkoRm0LaCcXCsjNPglVByUT9L2aD8xpxuMU38zFIZrFV5/YRu
 MzG2NmJqxcMJxGJpmYHjZZ/jpjpyb8/lAwyi/62Rq4q1kCGDfImG51yrycB2CMHTXY6XRngUzhP
 YOluFjUOeWPvnuXS2Ll78rU/2Vq6PJMJqFDvcBw6nozjDDQFPH8Oqmuh3bOpYLkrVeAoxXG65Yb
 Iln0BzVGmvCMPxuKsUhb1E8D5Sc2SpdtF4QUM/tgjmRD/oGbW+LbdT4iBBY3VGs+IIQ+5Oc04JO
 3ZqM2UL5DNTBVDIdgCloO7X4sPrjAg==
X-Proofpoint-GUID: S3ZZdzhRtzLN1O2bEXWWNm5Q1c1w5qZ-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2611020059

qcom_pas_tee_get_rsc_table() sets the "output_rt_size" only when the first
TEE invocation reports a size smaller than the input table, or when the
second invocation returns a non-zero size.  If the TEE reports a size
bigger or equal to the input size on the first call, but then returns
size of 0 on the second call, the function returns NULL (no table) and
leaves "output_rt_size" output parameter untouched.

Caller of qcom_pas_tee_get_rsc_table() treats NULL as success, thus
uninitialized "output_rt_size" output argument could in theory lead to
out-of-bounds accesses further.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-bb15726c-4185-460a-a5f0-f779d5ee144a
Fixes: b6f7978da0c4 ("firmware: qcom: Add a PAS TEE service")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_pas_tee.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/qcom/qcom_pas_tee.c b/drivers/firmware/qcom/qcom_pas_tee.c
index ac33a00687aa..ba9957023ec8 100644
--- a/drivers/firmware/qcom/qcom_pas_tee.c
+++ b/drivers/firmware/qcom/qcom_pas_tee.c
@@ -275,6 +275,8 @@ static void *qcom_pas_tee_get_rsc_table(struct device *dev,
 			rt_buf = kmemdup(rt_shm_va, *output_rt_size, GFP_KERNEL);
 			if (!rt_buf)
 				return ERR_PTR(-ENOMEM);
+		} else {
+			*output_rt_size = 0;
 		}
 	} else {
 		*output_rt_size = 0;
-- 
2.53.0

