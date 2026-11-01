Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793555662;
	b=Et/EiKbNtCq3xJ6vEyIHUrLwunLmRKH4albVyKST6wQ6nzEwIk6UA4mFtQEh77nJflgU
	 9gPAui8RTc6zapYwbcaLyY5fzoP28GaVfkSM4222qn9mHvloUHbzXf3pirj7eyKuTK+WK
	 6XocKDmLrqjDQxgPgntRQsWaPIRrn71/lhrnClIWmfCbl1kT/C5LtO6vyeNw5NvGbH+OC
	 vKfUJZTOwpse3Wou0CzAs3POoxPSSEKj0/sQQeXoEWC0dfh/bgb498M/4cqkj8AVZO6Cp
	 fvt3A7s1E89fWUpbjlJZiVG6zr8eaJ0HPlInQVt09HC+58XyUf4NL2vWkD7PSyJF43g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793555662;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kdtmiZdTU1nXwsamLd7Szc08WcYoKl4Y081kH3kHkjY=;
	b=KO2JkfCsLIVzqjKAUdLrmXOy/8edq1M7fDrIY12NxQF7Uv8Bwa0XhL4s8FafnxzqGUIg
	 vl8ky4aVtGiXU7qxz1d1KpTCewxiWW74zF0NWTQSfyuc3PKtp0GzgsbY6wIorEsBCxqAa
	 OD7nvNk28AKNDGBdzhhKEV2UHUCqI5I+lQvp7eX4yvbJb6UDetAB6K+d+TDD1aUwPYLGt
	 X3UAFNio48RzvW74j/vOpLYW/DlD+BlqQC1Yrc4xfF2P6ds/rRBJLqJeyNpV9CoN14D9C
	 BeBew4L7QzGgc+6Dnayu/2e29W2Zs+76pB/nI+T9SJKoT3E9LFCZ8zXas0Yi7eim+dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jOMHyELc;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oi5g6u0w;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C833C606A32D
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 17:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C833C606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jOMHyELc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oi5g6u0w
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A1HRjHg381180
	for <stable@vger.kernel.org>; Sun, 1 Nov 2026 17:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kdtmiZdTU1nXwsamLd7Szc08WcYoKl4Y081
	kH3kHkjY=; b=jOMHyELc7YKJrU2lbiIdQ8ccYv1sGKinrcX6pRVIoGtPQxOKdTb
	ajo2yPCyEsZ6A39YuRUua/PyVE1HSgsTC+msvcgMy6cilaXVrQMAVFoB9Bk+eF1k
	eq92zAc7d4/T/AJwx+pbwM40qKvHg0DzS/fjR5obDCft5fs9t7Q320FLeRKME+CB
	pxBlv6MlKSPQklbPtBmxwan+oZDWymKUN7AByfw/mCz5YfZ4CjlUHmjjsaXSsaHx
	mQcmFHGUbGPYlwAca078PwlIxnNtq4zcw5T9ITL55M32VRMAOqp3WlpmeTkG9m0a
	Ou7DmlNQPHyEM/8lpx0wf1wUpL9nMZfj5FQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8q7uu89-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sun, 01 Nov 2026 17:54:20 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93e92aad34aso459883785a.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 09:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793555659; x=1794160459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kdtmiZdTU1nXwsamLd7Szc08WcYoKl4Y081kH3kHkjY=;
        b=Oi5g6u0wMuPbL5mLRDY7c74PZ8cLNzU2KBdkGN57JzUWNpr5q7ikxRd7tpPCIV7q24
         VB1P6kBGuIQP1SE3diaQUEZvaIeicGP0vUjVguutSKgQ651+f7rGp9nLAf1lK6AcZOJS
         dkA06vCtZbfAxhxGcs3Bq20XrUdc3q4DLNDMuS5C+tL6ZNxUyX8BthbTxTG/tbVy5+WC
         DUzCorprBAY2IiTvizikDHHmI/5BRhAVgmEgkuXayJtW5KBynXa4DpA6K7fdO+u2IhJz
         zqU15DEKkp/i97YyZsPW02HVRqfvzRRQkLrAEt2PGL8hE1iQTUcpNHSEnSkrXcV9go0K
         JGnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793555659; x=1794160459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kdtmiZdTU1nXwsamLd7Szc08WcYoKl4Y081kH3kHkjY=;
        b=te9T6RO/85fHAdpOhzU2AN+vSPhtvydZGDZFDdhRmXSWbs3k/bsZF3fyzKVQi9sKPl
         Luc7PUfb9X00sT8/0FSse7xHeMJnniw4deE+wdoHCbopNoQEwbkuGZpaUKUgHX9CVkGG
         McSzf4pDhL8KPe18jDSReDpd48RbaqjJH2649+EBxyn5f7SP1zio50GefoYVfdLxp+9J
         lN3VpbHKd4BXubEYlhjdqFb9W8FOXNaSn2sCpvcCDQBtRNfU5AnrhzIf9xN0eyi398wh
         ZuiCny1ZSFKtwCUWYJNwxkzU5uOEcMV8pJt5HEWgWJZn5YT8UH8QrOVjzmFlMA0LdM5b
         qPLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdACgHMpeGY+3CMYJd/qF+3ExR7u664l53NIwkaSvKtveELtQiOtiZsayTSjkDLMMGyiC+GUk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIH5Ds5pvAThzS5R5echkfF++5uhB+WdusA2YGfgnVOCuNUbGSz
	/O1aPTe35w+8HPQkwnnaHY777L/OAYQTlqm7MStr+hPY2IRlAw0fcPNJjGwJ5+LO2wH+1zi4Q1L
	6EAOwhWZM52h3Fn9s1nBPmqMmBD7L9oRMpHZ8orSleu2jjSnH7nJRQ5FWRI8=
X-Gm-Gg: AYBFou194kinPhkqqMHaF0AQd/pXA105NCsBbMf5YaWOeCeMI0iflBHn2pm3FzTzfVi
	gFD1vrKiGBvpjFVq9uzvHy9kZ6hOkzlTmWV0hq3yrt/71wwtMvPcNPWJi1dCQVBCujOvXm0csbo
	PfC0JOIaPEAzUTtmph79KljInkSZacYoh3Uv8Fa1DmGfjlLcprROviaJ3wFOMq9SLGG6lphguC8
	Ln1unyNz+xEVhpx36Ci5UPXxcouH0ue9Ji4pZx/Uffdpnsw3AdpxtmY7gHWg3TNEOOJQHXe7zfB
	g51dExwn/rBK4owAx+UyPkFGXxPWR16MVAe3+08kqKKbxzMdPWveXYKeq90ReCPgpdHeI2OsQGH
	4QPuHXO7zNSzOk6ryr1J0Z1o+V50a8DLaeew6qvImSmu3nltSdfN52uOQdGFrNg==
X-Received: by 2002:a05:620a:6848:b0:939:ff85:8067 with SMTP id af79cd13be357-94421663f42mr1273097485a.30.1793555659022;
        Sun, 01 Nov 2026 09:54:19 -0800 (PST)
X-Received: by 2002:a05:620a:6848:b0:939:ff85:8067 with SMTP id af79cd13be357-94421663f42mr1273094685a.30.1793555658425;
        Sun, 01 Nov 2026 09:54:18 -0800 (PST)
Received: from quoll ([178.197.218.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa80f04723sm325714735e9.5.2026.11.01.09.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 09:54:17 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Mark Brown <broonie@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] soc: qcom: apr: Reject packets with header size larger than packet size
Date: Sun,  1 Nov 2026 18:54:08 +0100
Message-ID: <20261101175407.110780-2-krzysztof.kozlowski@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=4MmiwbTe67Vae9D7Lm+Zj++XqRihN9uwcpy1QVEzwR8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBq53y/r7BuYv9eK3+a8QHoZBIisHOoqo5rhSCYT
 x83EJSNlliJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaud8vwAKCRDBN2bmhouD
 1y9cEACPaj9qjm4Xgq2YAlnapjZ58AL8Ampb8QNuC8Q2em4csesDfI7RlNvwHxZkbCKKftlHP8q
 R1l8jH6moeUbMfPMFoqbtgedazQfS1q+MVgIIzgI4yRkwf/gRPK3dOEGs74dGL2/VRIqriImqm6
 ZRft9ZDOmNscRv8oSlf0cSusfzJhaY76AsT5XfhvdVxv9HHTCCwHmlQ1jqd+CJxdcXjpjdbuJ3/
 f9da1/Wqa/x77gsXo70d/5DMqX/MFjIa/zcNOS9cz06dUAXqd5P+/Xj+ccr0R9o4vzaaIeXZuo1
 +h1xXwIWbePSbuobLX9bs4kFqAXeMiXV//+c39eMpZaKEcwP/i/xo5/zX66AyvKrEoK+t9WzqV6
 lQ2NSAs6ckCdKUAO06lNAcmmk0wo5p5smBNYyoxqTA4a3HdYp0KMucFEseiIpjj4SKRbXSlO6r6
 M2CVnkiKM3i1IAS5NJ8hwuJiJ1mPhHMJXWZ8qyLyUbu6FsvjcdPtyBnazeo4FnZMBO20aGvjTOA
 8g+IkgWoTb8gHMAux6fT5SReiBGW1txvpPx1afafp6sbvTrp2Bl+VXzGl2YoiR68CnRo03I0sww
 wckAJZ/8dfTPRSGKulNus45bOrJElgXwaAZew84f6a4qsfFQTdzSCDETRQaUX3+pG1IT+Tqa7xM u1hWjU49i/JprBA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b7gkZLO8IlZtER86bv-KMIqnB1Koz58I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3MSBTYWx0ZWRfX5VLyXEtjH7V+
 fCx0ZCCIEAtvtM818oDTbceYaQI8WgCpoAQrNsu29hDMQaOD/Gxmx1ryotO+PKl/Bts8El1dFxn
 WJGgkNWi4EvVotK/BZVMVANes6IhsCc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3MSBTYWx0ZWRfX8YPh6ctSxnEA
 bqOooG+PF1rYaXNOGJ5gxe4i8sTL4UdIzhn+HmF5srci48mHwZ6bcNpcCWTVYbFE6GpbaXjgfmA
 Euwpv4K6nmTcxG6cvHXssz4AquZ6pBPDJbgn2kGOH4V4dkOjCfpy0ukUN4tBDAFBEsqNYnXfkyq
 2inO5Lq7jEu0IiNOcRTvozSt/DQBhD/3dv8Y/WsSkcG/FfyLfxi1MrXjQHb2okMwDm4Dfm0E+YB
 kXyZlyLq8V0IomjyQpa/LZc0cD4ki8/XrAix9wxVoKFpTnFIJ93Gl//71uMWncZrZAMUevPYIrv
 OSiWFAHt7LP5RTuQEU94vlypSDfNC00IyF2UUEjb445+OIZPqCgZHVJiBApWj1F2sIY7phMFlGW
 xzPWWtD7bslvHOf0yrqKrTkiTQvGy6NOogrOUrzNpyu1TDGiuhzhkPHVFeylrZr60Xx4Q9xeZXJ
 l7AOKYpd0Yc6YZHtfUg==
X-Proofpoint-GUID: b7gkZLO8IlZtER86bv-KMIqnB1Koz58I
X-Authority-Analysis: v=2.4 cv=PucG/AM3 c=1 sm=1 tr=0 ts=6ae77ccc cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=uyPgTw0bjBTS2cVxpiNm5w==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=DVh7n887_SxPlczGqH4A:9
 a=IoWCM6iH3mJn3m4BftBB:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010071

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
 drivers/soc/qcom/apr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
index 2d5645ff9919..6f29b57aaecc 100644
--- a/drivers/soc/qcom/apr.c
+++ b/drivers/soc/qcom/apr.c
@@ -210,7 +210,8 @@ static int apr_do_rx_callback(struct packet_router *apr, struct apr_rx_buf *abuf
 		return -EINVAL;
 	}
 
-	if (hdr->pkt_size < APR_HDR_SIZE || hdr->pkt_size != len) {
+	if (hdr->pkt_size < APR_HDR_SIZE || hdr->pkt_size != len ||
+	    hdr->pkt_size < hdr_size) {
 		dev_err(apr->dev, "APR: Wrong packet size\n");
 		return -EINVAL;
 	}
@@ -280,7 +281,8 @@ static int gpr_do_rx_callback(struct packet_router *gpr, struct apr_rx_buf *abuf
 		return -EINVAL;
 	}
 
-	if (hdr->pkt_size < GPR_PKT_HEADER_BYTE_SIZE || hdr->pkt_size != len) {
+	if (hdr->pkt_size < GPR_PKT_HEADER_BYTE_SIZE || hdr->pkt_size != len ||
+	    hdr->pkt_size < hdr_size * 4) {
 		dev_err(gpr->dev, "GPR: Wrong packet size\n");
 		return -EINVAL;
 	}
-- 
2.53.0

