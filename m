Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793560617;
	b=UpncsnzrTV6F5CVFcONb2zjYTrp+Yec59b9UAEU/PYCqB86/KattHYBTQErzS+wQcQFo
	 dSo30B5ORL6KxYutQIljvQ/mBQUNfa1xhbKexCrFKULtwCVZ8F5NtmLdvsrLPdPsVD2DD
	 GAop/E0RovrAtXRseBMD34bbHoouGYEQWWJd18gpnwPk5KAAhHry64CCMQ7c7w0SdQSVI
	 5U36c6tE+7W+a+qSgX6fBuXf1AqJncx4E4N6cCtShTrFFuhHbPRku47jlRcslsUu44BPN
	 ofIusEq9PpYnp0B1kJhgyTk1dALZfAZHsFpbKa30DP4N7mDB/jLi3Pygn/7RPKRKjnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793560617;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=UOs1j22LjLE1SIXla0/ZeRPDc93Djkkb3vt/+irTwsM=;
	b=SVLW/jyhLMcZ6/hwIhb55deERLJV9dy0ltnEZkSbZ5kLBCJdz4OU4gQ0UMFZ4i3z8v8W
	 xKUDDXD3QsUSvM0Mdct4XrjxhocXO04FMBO/TEs59Ps883wGEHEzhfXgJPcLTnoxXENT8
	 EXBvJKg76f/VrlvAT0nHh8TsrcUEHnJ3wS3hGRznqSq1ky2s30cDOIM1FTEzQ49BMPljG
	 IwrfwszPwNV2OYU8YIrFHcpgbV+zSqtm4df1X2GglqZUvQNqbUAMk8UTlFfmSjabpezwn
	 /nHB8eEI1GsboSUAempc2kQex+7JnnjPewqpAwdpIFMblN6c/hKKUoMjIWsbZVoySTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="Lj/u2+tg";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bBLSzuTP;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DAFD606A329
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 19:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DAFD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lj/u2+tg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bBLSzuTP
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1HQK6I1443878
	for <stable@vger.kernel.org>; Sun, 1 Nov 2026 19:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UOs1j22LjLE
	1SIXla0/ZeRPDc93Djkkb3vt/+irTwsM=; b=Lj/u2+tgp0cEoJGTBhM2RPfzUbd
	ZdX1QbQH2xav3dUclBCjHtSqspvB31kN3ImJf/6GK/s7QWBIIPIPaQF2yi0T0rh6
	v90h9lDTJp2Z+UjPqCH6hQZi5hGm6/217zhNPn1a7UtWNURuF+O7UkMqQ3j43fuw
	69qaPPf6VcvCs78nyhhe2QIVeSk4ff2uH26zSl5sdUJmTjQoqvXVu4GuyiZNt7ha
	qTqFVWGaevtnibDyl6/hO6DizgJtS/PkudXSS9t0kiBO3gDvONPABPrqJT1CqLO3
	p0Ba0ciC1z7s7/spva0JueoylYMMx7z+6PK+jUevJZPTvU5Y532pBBbrVWg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8duc0qj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 01 Nov 2026 19:16:55 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5eadfb67611so415510e0c.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 11:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793560615; x=1794165415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UOs1j22LjLE1SIXla0/ZeRPDc93Djkkb3vt/+irTwsM=;
        b=bBLSzuTPHA5+PA/yByTKS6PHYF0Ij1RKieMLlrc8+KuEnB3iP9tDzqvKJzE3yoUEUI
         D1nfH31Jz3EN9EDck60ztIg5tTTZWxmEglBuTvdlbO22orUGVODg+U6fc9LYj/vpMvNc
         UfiiPvwbSjGU9/+sUFTAx9UWRaebHyk5UftI4Uyv2tz78Zk3nJp9HYlwlfZkf5oAb0bA
         6HczoDrXvVb4/0rkxdsrQvqmBQVri+Felbps3cavRrFOLTVut6AjjLTcJgUJmkoWFXuX
         ySxe0jEtjve5Bo/MIdn3BppC6zIHjXdr6Lt+hJVE0jNZgxziFbDb4/5NmvY8Lp9W/a86
         WfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793560615; x=1794165415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UOs1j22LjLE1SIXla0/ZeRPDc93Djkkb3vt/+irTwsM=;
        b=annWh2dD02V+TQr9SfFQ1tAMieMzdfo/UZN/nvRx6zT6TQN8YrzXYQWdY2RU6I14We
         lrL+qanR7YC+smCjiTGO5RwLqbcr5rD08h6ksNw6w2yFBoghqzRA9jkq7MB9M2Gd44DV
         /pxXTRLlWvs8rqaSWZq/SoSQidWX7Pdp5Hb2DUsjuBHYVJpz+ZkWmKrA96xzJR+N8o6p
         Zvz/r81G/zKqewlERW6PRzlNh//mo1AkUhwlLi5wZr5HmoWjmxcUvMwmpW9UYZcY0IZq
         Pu+q5FsF8szuatfRZ2DsnrRpvcYNST86piBYrrdAOnnuGX87Ph4qH+w0xVnXQSxfxjR7
         nvHg==
X-Forwarded-Encrypted: i=1; AKwUvByso8vpVHU3YKafA4szp3yV9Z0jxjME0krWrKAgUi+wPArF/ufDwrgOyKXuDoafGEUqnREZjI8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/C3zX0Bm/06SxPneZ+qZK8KRTesobh8KAMryJ18l6+/qzn5eNo
	JoAAhKTRfy5n0zRasTQ7+hV8krwBt/n5z/JLAlrFq5LqclCKNoOPwe9cZvIzp/dOEgeXbS6/Zjr
	JzpGr3Tn3TCWPY+UI9Bf84vd2F3EZiKc701ahHaJn0Gu5hzGPwSfRMH3EuYk=
X-Gm-Gg: AYBFou1AuDnRZfKhXJMrj6bwQOMBT64yuE4WG/qFOZpqelAdScdDCW1FmmgHbxcBdWr
	OcfNKAMpLiE87RdbpyDr15FmzP6EK6ZBg+zNxDQC7nk2qRFDSmOfM3hNYeTqiXj5O+YuoOhFYZJ
	qidVaRruM86HwBIZfNwmAUr8x3H9VnhLGVbF4sjvZ5HXsusZJG+1OB31sL/UHHlCRsSJJ4oClHi
	0p9umsKVhwI5ST+eSu4VGw1bFX5aQC0QRm1YqcZyfbO2dyGliBp4xVEzc/pZaHAgZSQnr4KY0dK
	XuMTP3e90S+czuyqKCYyLrjFW7sHaIOrWAtZOlGI/HUyQK5qTrU/KZ7sGBtP7Qug1Gzf8IiwCtM
	v63dhHFf62juY9y1eQRLmXHuYd3oXEpyyA4hQsv24adDjC1StegHwOwYE/gESNw==
X-Received: by 2002:a05:6102:524a:b0:7cc:1ace:fd11 with SMTP id ada2fe7eead31-7d0726359b5mr2913455137.8.1793560615072;
        Sun, 01 Nov 2026 11:16:55 -0800 (PST)
X-Received: by 2002:a05:6102:524a:b0:7cc:1ace:fd11 with SMTP id ada2fe7eead31-7d0726359b5mr2913435137.8.1793560614547;
        Sun, 01 Nov 2026 11:16:54 -0800 (PST)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d3f9sm17168223f8f.4.2026.11.01.11.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 11:16:53 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Srinivas Kandagatla <srini@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>, Andy Gross <andy.gross@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2] soc: qcom: apr: Reject packets with header size larger than packet size
Date: Sun,  1 Nov 2026 20:07:35 +0100
Message-ID: <20261101190733.121473-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101190733.121473-3-krzysztof.kozlowski@oss.qualcomm.com>
References: <20261101190733.121473-3-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2069; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=kJg/rvfiN7UDl3v4JnVjo0T2/XuVJN1WlSd/w2seENE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq5436kMlPdugyAQucba+rGuml7G8LnGlzYcMDi
 r4C/KyVAy+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaueN+gAKCRDBN2bmhouD
 15SKD/9rfYsZQDHFYT5ukKYAd98y0gH0XOt/ww0qCH7VHPI2mp+aO43S7bAAR9v2TZQMN9tZvaN
 co6HZNn83E4znnaaNg/VZOPQxHhCVPJXaECLpRQrSXNMY7WjtUZXqTPI4jEh7E6szRxHSjnmXAv
 s2ZfruTWiVVLTP8U2Vhnzm77fOCbgwSiLo00BgWXyZ7s+7oIRT4A+E6xXaFb0d4APn6pE68CvI/
 XYhX+5XPv/V5Urs4iA+8QloZYddAXx6VwwCA009u8ksU8lgWVbMS0bc194nLIzfAxvggB69IDQ1
 m46Ji4vqediUExfubRsPPpEi+lHkQnquo2FAockRKUyKLbsb5+j5+czLQaj4GKFl0wIoiOCdBmD
 n957wW1OyUvoXuVtH80dFF4PyOpOxSGfTkGaBp/UfLKgYe40k/j+piY0reZjaQgT7FC4786AFRB
 YW9pptUes2+3a3J/BI2k1J90Xf6K3LJCbvmRwFDxGuhE0k2hQZog7xa6xlhr7mmmn5i8s11hRW8
 nQn3v/wC+6w8BXQU8prrKv0l5Tc8nYqeFwmUfqgWDKkX3Ehw2yP+m7s6zIBEznYHV12uqPTaIj9
 5j8/M2Cs7jkxmWliJG5JOIeg5UwpUMhNB0P0youYObuv3hpKMiAEjhxJXrNB4IE87U6puXTtaQD uT9sTflUQQlTrRA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=O6esLx9W c=1 sm=1 tr=0 ts=6ae79028 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=fiEMaWzmfHqX7dR_b_IA:9
 a=tNoRWFLymzeba-QzToBc:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: BjSmTUCvU4rdePBXZlNcO25pQcbuUjGh
X-Proofpoint-GUID: BjSmTUCvU4rdePBXZlNcO25pQcbuUjGh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3NiBTYWx0ZWRfX8KPu1jb8TXs4
 WzbwS1UoQeK/XU8pl/S8OhdB9R4bx8Rp7AFp//14/NNaMJc4o9ofI3p4f9OdeX32k3mupfP6k9Z
 BqJSBjDjWkHK/tQfHYyoRfkq/jVQe+t9UKZuOOALOScG/Ac33++EIVBje/e01piehvMu3CCkcws
 d8ng3bkuIXjur8g11wu25gEeRlaqku8p8zShcp5ZxAAvCEF/vrczPDx7tShzNY1z8GXZa1AiNo6
 BDChOvakiW2ZxPJ3XkGG8blLLgO4psLpJgka/OlUS7c+7ajIHNqE0K4PpJlibQxGK+TykVn7D56
 7cPNvErgT8ZHtnKSpv+4rNgXpYTUrVk253dpFM24+oTduyp6QpTs07z4f5ouWhiHHwBoKHwiJzn
 LHpGcENf0aIQaCTFkWdW9sgLHtnpq0vULHC3abA2axSvY1Ex+K0J1N1eTWC9wV3M5quVfPLGCbY
 5l8x6hiPsNL8usKHkpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3NiBTYWx0ZWRfX4YAAxQg3JnpN
 b+1NikB2SvkRBimuJcxjDIVh5mkTXi6zJYMUHqpwvdYD/LHFz/bsvcWU1cgimWnxf9hQnUvIOn2
 Oic42vrFsryxEzQUbc8FWEWJNAe+THc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 impostorscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010076

apr_do_rx_callback() and gpr_do_rx_callback() validate the header size
and the packet size separately, but never check that the header fits
within the packet.  Both sizes are u16, so with a malformed packet where
the header size exceeds the packet size, the subtraction computing
resp.payload_size gets promoted to int and becomes negative.

Further check "resp.payload_size > 0" would fail, leading to
resp.payload left uninitialized (stack value).  Reject such packets as
having a wrong packet size, although unlikely that firmware would
produce such packets.

Fixes: 6adba21eb434 ("soc: qcom: Add APR bus driver")
Fixes: ec1471a898cc ("soc: qcom: apr: Add GPR support")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-82d40745-1593-4c20-8432-d86099836525
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---

Changes in v2:
1. Test for <=, because hdr==pkt size still would leave the response
   payload uninitialized.
---
 drivers/soc/qcom/apr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 2d5645ff9919..e303562526d4 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -210,7 +210,8 @@ static int apr_do_rx_callback(struct packet_router *apr, struct apr_rx_buf *abuf
 		return -EINVAL;
 	}
 
-	if (hdr->pkt_size < APR_HDR_SIZE || hdr->pkt_size != len) {
+	if (hdr->pkt_size < APR_HDR_SIZE || hdr->pkt_size != len ||
+	    hdr->pkt_size <= hdr_size) {
 		dev_err(apr->dev, "APR: Wrong packet size\n");
 		return -EINVAL;
 	}
@@ -280,7 +281,8 @@ static int gpr_do_rx_callback(struct packet_router *gpr, struct apr_rx_buf *abuf
 		return -EINVAL;
 	}
 
-	if (hdr->pkt_size < GPR_PKT_HEADER_BYTE_SIZE || hdr->pkt_size != len) {
+	if (hdr->pkt_size < GPR_PKT_HEADER_BYTE_SIZE || hdr->pkt_size != len ||
+	    hdr->pkt_size <= hdr_size * 4) {
 		dev_err(gpr->dev, "GPR: Wrong packet size\n");
 		return -EINVAL;
 	}
-- 
2.53.0

