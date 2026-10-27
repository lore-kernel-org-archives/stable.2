Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793124528;
	b=m5rAQm42jhmCSOHrTqVNJozRI+F1SRgJxGNncwr91RgrOk+DlbkZHvwN+S5QR3cpxiUu
	 O1DBqRMfYiY062l44IKsAJvlLYAjVUew2f0EiTilJi96LdGg4YszAS5GHtCoisWLw6VWc
	 YYBAsa4V3FjxzjpZLEk/goPvtcFNNU5wlrvCZgYtgCcD358f7T81SyTq2ILJBACiZB7M1
	 Dht950PhfSXzpYCNG7ilOabah3yf7oLyqttpUDsrxJ6bQofKsu4KQ5YeHUtY0RhjHCtJu
	 ufW4XqX/m9apYi6LHwLwFspPDe5iuSJPcVNfNYi+xJFZcJSXvbrMVPRKbIrSny5EETw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793124528;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=V+0MkK9FJIevEfjdwnmobeNwbUyoiVJQ85WTwnR/ZB4=;
	b=SxXgfk0Li16VApyXAwAD1/R6OBg8D1Qtihd+J6WEaAczFDqI8JQ0gLxkXxLWxvQ9Tvjy
	 QoPlm3imSOU5lIj+cftXZhsAPNkdxZHe5VUaAF9WBXnmHZoD9kMn+U9IoEZVl0VWoGP4i
	 xoXHQXbNkyHleYcmdsWOEaeN7fUNQ+El5i37XcKPb9bJV8HtVnEC+Ws5xh5/S3xVPEACp
	 l6HjFbr+V+GvO0Via+w/NlCmH/rr6QOjPw9zXyuiHnPmVT9gkfxxcVDzcWMptnjZXu6et
	 uimKcHat2RKxJS1gMYFglX2BgNSSvEDcKl8ZYDf/w71t7MUHZIjTfwnQ5Ol4MzZeuzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MWq9MGrG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D5ItdqCO;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF46606A325
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 18:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFF46606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MWq9MGrG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D5ItdqCO
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69RH08Ps2786928
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 18:08:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	V+0MkK9FJIevEfjdwnmobeNwbUyoiVJQ85WTwnR/ZB4=; b=MWq9MGrGHekRKODJ
	mzxuqkcgIkzutQUFtO3uw3hWZy5Utu+wADC90/n5qK5ydh7iQczljCYwGVwzZrQr
	G7FCLT4Y/vZqiPWOMlB9hGxwZ/ih8jB5j7TFU5k0jICg9yYtPnu3LJ2kspGQpev4
	wd2TYiWNfzVzDwXVeLySY3QA66DgjtED9tfcETTqZB3BvIBVGYkJ3bVyVhfnAY3+
	/v5BUymfcTvBHzaOG/Bf2daRDB8Mp+AICLxreyvKhtMjBn9H02YCxNYhvUWBCTpM
	6vU2ypOXNazANZ+ZDrBeTA4o0arhOnQyzxZu8khpjLNCw/VqQIoQZ5m6zLOFFiYQ
	sak3hw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy670jta-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 18:08:45 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-147be78cd56so214978c88.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793124525; x=1793729325; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V+0MkK9FJIevEfjdwnmobeNwbUyoiVJQ85WTwnR/ZB4=;
        b=D5ItdqCOtKE0ryGGQAT3M20htsDuAKVnmOZvodn1iCbY97UkNVtAzmwZrM8oFH9Rx7
         j8Ei17sr2u4wqEmdYgmg1sG1fy0uAqYwApD/0bZIVCApu0nwJCEPxyUy6p+M6ZpBoBi8
         /UNpWq2yjUNm385lGdh78ZylSO/6QENpSOodCprdnlUrtyEzfFXfqma/NpA+A5hwqgEA
         DTIGDUHvC9GW+XIShjVGi3yV//H6B+KSKoy7DxFmTyysb3epOc/i5PWud0+++NWfc0nj
         FmgHHFopEumuYLJ5NNuCHsw2C9rlzahSuZ6VRHtClgmXHTTLc4XNDCrERKhkS+C2AmAw
         qTFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793124525; x=1793729325;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V+0MkK9FJIevEfjdwnmobeNwbUyoiVJQ85WTwnR/ZB4=;
        b=pSBAVseYY3GqmpxtaYN5C3RS/hKrrmyoFeS8kpzXMsb1oN/RmbA4v7TmaUUwRxTSms
         wpEvpicrfw346Wpn5Q4j9EiSN1QuPVGxH4CbHydow8LejqUr4PQZ7QUZVx39y64RqcYP
         XF9H67S9xlqo48T187taBfAmwc0UIhOzajaDCL1tVuuGXWrdKo4DREUaxJZqbzOc+Oyd
         m7G04DyX13eGqWqYyUK5fNmjCsswp3Big+J/00QTfdzhVYW3CsaYx4j9hOIHeNBFcB/t
         xGsjRu0eIM+jchl2QQNduljEJpvZW2duPNfSvXNV6gbc5pE1jrKfXH10aNf6vox7Dfyx
         t8nw==
X-Forwarded-Encrypted: i=1; AKwUvBzJzq+Myq6y717mY0fWhxeErSNcrBn0kBm2UrvS1bXt8Q4va4GSvWXbGBsu2nXNObOgjykMgFU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKB3g6bAQJ+XDPTAbkkgDiGep4TcDFgCdOuM70MEH9EckAW769
	FvIuTn1tQbL2Fdqado5ggttbmYydlavpHWNNeE0+E0nIELy5MyaNk7cRg0teDs6K6uuUVuNwimY
	DTfiMIbZKUXVZKYFqG7RH1+Hf+peIlc6ZPGMZKFQuXQDcym6ZZgT1gQ9KHSY=
X-Gm-Gg: AYBFou1DsZghsMMYrgLJ6VRbQtVPVHk7snFvsqQSBkiOtUiRdOdE0gVMxItngEjrV3M
	h4XOM7p/6nxzHP1+Bz44mfy3XWOxhyzjJeFJ2meGOR5w1gowJlKyKE0F6hHNmhYWx/ohHl3idgU
	ELsZ6rXkG7F+oFbiukPmRtIurIMYBcp6c58HvN5ZuIFG87ZztFVbq2SsS7dyOYnZcb7pr2Zm4BM
	sFoiNoRgJGbbBphqwh70RWH7Z6mw1j8jX/I0tPCeMiGDS0QAvIQCipjBnstJCwNusYOQkyxOto2
	Yly9vZBPcA1JC7GutgBxLQGfxjhwWbb5WkBBnCtmgHyHWu1SbSLTOKxYJiTZB6LVm8bnKRXVTfZ
	c7b3Px3pwCaDO7SgzMKqdZnWOE62dWD3FeyovKASoLh3tQiR6fPqmA/tN0tz3lum2reGcIJ6aFA
	==
X-Received: by 2002:a05:701b:4247:20b0:163:8b44:902c with SMTP id a92af1059eb24-1a6cced1a1amr27674c88.17.1793124524643;
        Tue, 27 Oct 2026 11:08:44 -0700 (PDT)
X-Received: by 2002:a05:701b:4247:20b0:163:8b44:902c with SMTP id a92af1059eb24-1a6cced1a1amr27613c88.17.1793124523711;
        Tue, 27 Oct 2026 11:08:43 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0d98660sm39144463c88.9.2026.10.27.11.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 11:08:43 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 23:38:26 +0530
Subject: [PATCH v3 1/4] clk: qcom: clk-alpha-pll: fix Zonda L value
 rounding
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
Message-Id: <20261027-nords_dprx-v3-1-5d98b2c6c263@oss.qualcomm.com>
References: <20261027-nords_dprx-v3-0-5d98b2c6c263@oss.qualcomm.com>
In-Reply-To: <20261027-nords_dprx-v3-0-5d98b2c6c263@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Taniya Das <taniya.das@oss.qualcomm.com>, stable@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-ORIG-GUID: 7G42HRlI30ZoyXukMrqli0sUQ0Vt0Hcv
X-Authority-Analysis: v=2.4 cv=QvfLTlyd c=1 sm=1 tr=0 ts=6ae0e8ad cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=crv3FWtqC6gvpUHg9-wA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfXx+FjzxZr/sdY
 jzZbGDcQmPFE7Yk2Ar4HaYFpBh+M74cFP1GguSXbg1vxtegKxY81y5hHmIAsCeIDv5v4+GVxlA7
 bESrVhaquzCCyleqlhTwEhxZa4NEa9Q=
X-Proofpoint-GUID: 7G42HRlI30ZoyXukMrqli0sUQ0Vt0Hcv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA3MiBTYWx0ZWRfX94zj2V6o96pX
 ejUA2iTW3C2Gkf5f4KLKaBKiXS129zHvpOOdBTUcBSFmbf0qRydw28pWvZd2X0hjE6u9O8MIWZb
 I39rL0oZchJg5wj2XmGpGivfFJy1FGlMfixZRvMBZ8l+cw70AXZPEt+MJ7FK++vHpdvDDXooux4
 JMYfnhzQVz5RFMMjEAaZkxSyH37XK1Frmy3Pa44sJr0CYrlbelb/dd9+q/Mh7kbgXEi+npfE7Jg
 w3FywovUeuGulrPl0MqcXRIYeGWFetYZEZEbLEcZYSr5+TXp4v4L0BS7s7unYLwdqAum1R8SxxT
 Xzfma4GaDke5nyxa5TPbkPFpDWUzIQlBO0CHOqQyhwn0Oxm2cnkQASRLA+WDNo4ifcPRhaeSuyR
 TGZRcbeUpNS27aUt2/WPqPetvU2cF+yF0ZtHYVKDSX7jM2wtZm8/aJYTnactek1JVZnKKU1lQwt
 w87rAzrvnjO8ae8zOEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270072

zonda_pll_adjust_l_val() obtains the integer quotient of the requested
rate and parent rate in quotient, but writes the requested rate to L_VAL
when the fractional alpha value requires rounding.  This programs a
nonsensical integer divider.  For example, a 1.2 GHz rate with a 19.2 MHz
parent requires L = 63, but programs L = 1200000001.

Use quotient when calculating the rounded L value.

A GPT-assisted review reported this issue.

Fixes: a4d89b11aca3 ("clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()")
Cc: stable@vger.kernel.org
Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Link: https://lore.kernel.org/9dc66fa5-47a9-417b-b8ff-b3a61ea75678@oss.qualcomm.com
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-alpha-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 60173b076cc5f16bb55343a1d1136eb07f3c050f..9782fb062a58a26daf3e911ad23c5e1d805b0c38 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -2271,7 +2271,7 @@ static void zonda_pll_adjust_l_val(unsigned long rate, unsigned long prate, u32
 	quotient = rate;
 	remainder = do_div(quotient, prate);
 
-	*l = rate + (u32)(remainder * 2 >= prate);
+	*l = quotient + (u32)(remainder * 2 >= prate);
 }
 
 static int clk_zonda_pll_set_rate(struct clk_hw *hw, unsigned long rate,

-- 
2.34.1

