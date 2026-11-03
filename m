Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699298;
	b=YSUTv9vg7PnJrsafTu+vF2zeOcwytMPgghK/GlNZkhBLfiTV2fUQPf38dG5edOkPQfqa
	 ZpDtP785+kXiIaSSksZGmBZPG1UzR0T8qorZ6wFVVB389AwMzfe7WXWTp0TyAs/mryMsH
	 9WroK/pIfofrIAFGc+g7DLHXy6i63xShCBNo16tm+zd5iDAXKUzgtxkYZFaNa5FDXT/wu
	 fosiYPtcsIucnATs5gGBhYQ8EgIM9dH5nevAsV4FrA1xZFw1jAsuRB2rxplyx++R9fipM
	 2PyTozbYv8aIZIpl0zq/YBXCHot67yZZloGXoj7Iyt91o45cm8T191SXthWOAmcsNqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699298;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aTbiAOOXIcFT+/lo81vU5cq1PuTSUe4CMWmyUn2ZLLc=;
	b=tSiMY3sfzobvv13PRCRE9hPAV/obf0o3/47MGgsPuv7Ji5SqrTxS4n46tNJOGMz9Sm3p
	 EJ1Ge63nKZIDndqsYxq+EEOP2XjkIwl4Df/35WjTOMeU+6fgCLqdTYUKKRVzd8IDL7vqe
	 vyvNdkpbM2J6abVkuNQPma0ovBzVKhNyGE4hX6UL+Aq4NE3yg2+RziXANYpCu6QHK02Zk
	 GJ6aDCjinNeYyvOWyyWB1sgR6EHRhUe3GqbXLdsUOoKF7obTgZhHruEkt7ICEZuJo2dab
	 7Sccv+HijcKUs9fVjeB6wIG9S0hnNpUGjXqVVfY5f/+6pu2qfNRH9zbYBKuHmaGZ0LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O+Sm+9TW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DEdQIPF5;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54965606A332
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 09:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54965606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O+Sm+9TW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DEdQIPF5
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A37omXs1082965
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 09:48:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=aTbiAOOXIcFT+/lo81vU5c
	q1PuTSUe4CMWmyUn2ZLLc=; b=O+Sm+9TW4kMoojPk4O29eFTxPJdAvkuWlZ5R1k
	hF9SdindCTK03jZ6Q/EjTTOEVIz746+sRBMy6srg6uSNmOVyTuG38ggYAz9ikC86
	AFnAsrZBGEXlsNSoWUn/PSsZXMGWTSNPMt2dTA+FYB1oQZpJO/qpOApl86/gLCNh
	FSeDfiCu2t1bXmYNMqzUvjy9d/bDwGliOhyytQmH1hQdnSiubAv3n21SsniTXvY8
	BkNruMCpYHzEFQmMY3ouK8h4+NnZMjvipW6A3djGQc8IFgEupuMJ03QqZ5h9sUY8
	6m/D0kjimTN2dprotfHqxsDc5ZKvJTRTbduACmA2MbmP8ZzA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq07r33v9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 09:48:12 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91b8c60c550so102053806d6.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 01:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793699292; x=1794304092; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aTbiAOOXIcFT+/lo81vU5cq1PuTSUe4CMWmyUn2ZLLc=;
        b=DEdQIPF5w+moAr9vgBCV897FoepebvS2/lUWz1CK0o64ZAjWWGfa0x48Y30vDizQnt
         CXYflAxX1+JesWBTx+rHOjODJmhvHHDKEb7QdLspmFM16azxjS1saBffjbdDgRE+BeuL
         qoz41PjTXw5N4l0xS8Tdjumwok/Ejgf7Fjv8bH52Y/AmrfKyG+Fp38A8XkX3W0g7BQwi
         c2gHUmL0Qh8aSwdf29g5qRrQRNlbVcHSnoJ0GEM1d/EmeDaXZwPca4KevNmvN09PAUdL
         1LTVC4CNffE4csE6N6vIsZP5t2P6096RrbRyZEyXCH/IBqE8VYVd7UM07s7aYQmTfrYW
         WS5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699292; x=1794304092;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=aTbiAOOXIcFT+/lo81vU5cq1PuTSUe4CMWmyUn2ZLLc=;
        b=cKJt8U290l8ptKTsqzA5xOVk8lksWv5HJQRF9gUiZo2XdjlMHkX4KpGwpZVjcP+6nR
         2eh37nukg3r4V4c1/a8MBFnATT3gO0rq2y8jdx3/AlquZGJxZOqNpvz87r3+iNDIolnD
         rJpQGN1F5AqWjeOW1lcZeYWp/Qy1OVRnA7IDII+kBSpyUhPSEh3OBQgkDvvRDhGdM0QV
         2pmffbGbMZlhBQPUaXph7Czj1mzeqHfiwCHtC8oT/lqfPjLEM21SzGQ8xqVd72e/Ot7+
         jycUBY0gNKIv/jB4ee8iHI+pm16oEoWS/DiQyFd1SBP0jBC/u75bqCzKezUJ6Uol79yd
         +AtA==
X-Forwarded-Encrypted: i=1; AKwUvBxMY729RoBeREFR1i3Qqn8IFp9T+M3GZgga8S8UYqALgWZGcQqZOn+byEz5cv9D+zh/dPKnBH0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wjY99PXrHk+IIsxjsjXIqI6JPsEdAaciIvnig75342DBWWaGF
	rHBkySSK5DtCdAG9jj/ngEaEgVH5g9NB3gieoG2G7Fc/RXHiGeLPd4fbXPFt294QewqfoAWrpbA
	tDihICVaDQQAw0cF/dICikbgIsqj3LxirfErvNUa4x1WDawc0DLDP+0LjA5o=
X-Gm-Gg: AYBFou1f3wB3JfgwV7qi91q5xlUsKRDPIQy/KPAIjJUAIi41vqMi/EnWT70jbnRZg47
	niB+++VSN6oA2uihk2IpQ7Z2G3regTfob8GKroMxSLXBn7isJtfZRmnYfk7dQSiajcnqn6L6uDi
	Em2xiXYzrRaH8mEHsUWQzt6c7k5+31WJ+CRvSvPMwzo1iqDUqQQGuUehuoPWmyiXaF8c0kFE3ZT
	4nlDhMQsedAtJ2qJmD/EmgyuCeLlp5jJbVO8iKu8BwtDwpqFhAzFhP3aC4MXX4lJ2H4bTNiv0w+
	9P7Ols9QkywwZtY+Pr5p4M52UbpRcUiwn9EX/oV1cXJpyHVJCVHWh+JMLfUJVTL5Upzc3frsNfE
	mWS5D3QOxEEN1TB/P0DbUisrruWYnis17Jrnlpd3QWU3YN6TQPLWXgkvVLg==
X-Received: by 2002:a05:620a:372c:b0:93b:d79a:c45f with SMTP id af79cd13be357-944216cfea2mr2039290485a.55.1793699291392;
        Tue, 03 Nov 2026 01:48:11 -0800 (PST)
X-Received: by 2002:a05:620a:372c:b0:93b:d79a:c45f with SMTP id af79cd13be357-944216cfea2mr2039286785a.55.1793699290696;
        Tue, 03 Nov 2026 01:48:10 -0800 (PST)
Received: from [127.0.1.1] ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2aa38bb4asm44422715e9.6.2026.11.03.01.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:48:09 -0800 (PST)
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
Date: Tue, 03 Nov 2026 11:48:06 +0200
Subject: [PATCH] clk: qcom: clk-alpha-pll: Fix the L value of Zonda PLLs
 with a negative alpha
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
Message-Id: <20261103-clk-qcom-zonda-l-value-v1-1-9c271ef29155@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIANWt6WoC/yXMQQ6CMBBA0auQWTvJlCYQvIpxUdsBBmurrRAj4
 e4UXb7F/ytkTsIZztUKiRfJEkOBOlVgRxMGRnHFUFPdKEUarb/jy8YHfmNwBj0uxs+MbU+kdde
 S7hyU+Jm4l89vfLn+nefbxPZ93GDbdlhZrRl6AAAA
X-Change-ID: 20261103-clk-qcom-zonda-l-value-7f003397039d
To: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Abel Vesa <abel.vesa@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548;
 i=abel.vesa@oss.qualcomm.com; h=from:subject:message-id;
 bh=5njVES4Z5ZBlkcrpu1QwiiuUbpd3M7eSK7+VdDNHtaI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBq6a3YVlh52IiRy8CD34qkvFVYstJj48rMrQGmn
 dQZ5tteLTiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaumt2AAKCRAbX0TJAJUV
 VuzaD/wJzqC7K1eA9xAL0ISxpLL5RglAuAVDaMmTE130Qy/sX1u3tHj2loxG/PDHpvds3oHMEV9
 hC1mvnOogjuoYhf2a5nPap60yibupoqYVs1Vva2iSgVXhx73lOwqJnsH/aql1WKJ+hpYn9/jXjn
 UxIwyhNPvHVYHnf6vBo7dBqNrRnOnO0Wbv2z0ltGureWKi7lUTPrXtnqrLHC4QcjIhhB7BUq42G
 t+zSbeV+OVxGEJXB/MaqH5VmkqwHZdCzuN1Kgeg2XG+fcNXR0q0+AXqAzY+gfvGPn4LSoOSzz7K
 qr3p846cQKTmo7u7u24YcFppOnuu5Rfa23bLAD/WBUP8Yu19jKrkl3iXmiZymPHfbrfJrwj0Z3E
 rR9qSX6Nfo6RtscAVM7xADrIx/IXmIXhfkJRFnNYdg9aztzCZR9x8kk9YNkG+QtHuPuqpn7Q0JL
 kFYx9qVdTIEaVd0I8xibmhACrf1arg915oEuTLtxhwN24aRjDVF1zawqJbUGNGyVvS9cZP05BK8
 bGl68xs8IGaDEwTwf9nzGzsBSPxLSUuEW6YfI+rE6DEoptcsbaY60j2O54aKIcxb5Myx6frdYiS
 EfkjkqOk0NIH4EHso63pdjMyiBiymEkcEF79gRp4hwEU6iuaDi9S5CPkUTYCyp7dLvkcpYmwegc
 s0lb/OlepaYL6bA==
X-Developer-Key: i=abel.vesa@oss.qualcomm.com; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Proofpoint-ORIG-GUID: FuIhn4G2Bsg9__8ZRLVBpHDaFaFR6K4Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzOCBTYWx0ZWRfXxRt7TqXMiiCE
 96VpnR6ObuQkcqymN6LykKvQ/bHzbBBYUUMgGawxvlHCKUTr0A3GIKwybMKEzU3gv7niwKTB74B
 ahA9bSr9P9Xq4CwJYp6vHZp0DsVHaYW+5DCXqe+XbJjmqcAt+6lLdeMeKjIDHWv0X6eSwzoxdsu
 RH1Dc/VgW35fS4e+W13jZGjpFhIkrfwuvjhmX6XO8zJebwhv8LBcIzTriXmH1HbSFpZUsZ1s/Vx
 hq0aasztpRkcPN6ZKYtp9vYstpGoQUGvqPygH4TIpfO3X3Cnnez9NHYHdgyXQdK+kTmFfkcdeUM
 9JDna4WptlYGMKUvYC9woraLov+/2ondhaafWe1jls4l+TOHPIOH8GMWm86Xvxmi8OWqGN+mFHo
 VHPKyRFukIA2Kbe2zcku+0HkmJj2Dd0OElpyP/jUD841nwB+qsV95a8iCr8YazEibp8PcljkkPK
 D+BINywiI8+CYseN5jw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzOCBTYWx0ZWRfXzYJLHftiPkA1
 n6jFRh8razWxM+z6kewIJqbUiHQxX+62hcRCeXimTbhviBy1JruoXUSoJRGpMixvu5RBHNFewjf
 z3DPBG4NtY5OoMewG8HHzmU9F0v9k0U=
X-Proofpoint-GUID: FuIhn4G2Bsg9__8ZRLVBpHDaFaFR6K4Q
X-Authority-Analysis: v=2.4 cv=NZlzRGD4 c=1 sm=1 tr=0 ts=6ae9addc cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=U0MhLFlXrxXVFuOl:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=m72LRCnX1IptLpsbfGIA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030038

The alpha value of the Zonda PLLs is signed, so for a rate with a
fractional part of one half or more, clk_zonda_pll_set_rate() programs
L as the integer part rounded up, through zonda_pll_adjust_l_val().

Since commit a4d89b11aca3 ("clk: qcom: clk-alpha-pll: Simplify the
zonda_pll_adjust_l_val()"), that function adds the rounding to the
requested rate instead of to its quotient by the parent rate, so such a
rate change writes the rate in Hz, truncated to 32 bits, into the L
register.

Use the quotient again.

Fixes: a4d89b11aca3 ("clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()")
Cc: stable@vger.kernel.org
Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
---
Prepared with help from an LLM-based assistant.
---
 drivers/clk/qcom/clk-alpha-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 60173b076cc5..9782fb062a58 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -2271,7 +2271,7 @@ static void zonda_pll_adjust_l_val(unsigned long rate, unsigned long prate, u32
 	quotient = rate;
 	remainder = do_div(quotient, prate);
 
-	*l = rate + (u32)(remainder * 2 >= prate);
+	*l = quotient + (u32)(remainder * 2 >= prate);
 }
 
 static int clk_zonda_pll_set_rate(struct clk_hw *hw, unsigned long rate,

---
base-commit: 2637bdec0535a2044cd830eba9a79363651d9043
change-id: 20261103-clk-qcom-zonda-l-value-7f003397039d

Best regards,
--  

Abel

