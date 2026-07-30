Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD17418A38
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411157; cv=none; b=biBv1N7MogUswBMoJAica23n9Zi7TNXQ2ofgbiBvNU7tjrJujiP/AV06YoxZbnCRtexDglpnB8np9ax6hURU2VU3TC9hSaDZVa9jbMscX1kqMSC3ISD0wIbrCZXHnv+h2D/BYKL7MIM351w5+xCLNUQ0IlVRXL8Q5woVB2Cfj2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411157; c=relaxed/simple;
	bh=N9Ohv6rcdNYwhoH7sgF7IMFqPbPWZ8UU9+WoZm0Q1PM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qy9UFkUgLv5xXlqupt+KtpdLxOKTDvgA8nZaEyciGT0Or3EujpQ8WMVRHxMuwOd0lgxLmlJdqYR6IYVA0sAXY1PkUSXVAaEl5jxiCtpJT6gCmkjjktEnDoGJa0P4LrTScE18Hx8f1H0pLwcgR/C+srQNeTWfa8ma5QBtXRRN6EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=f+s+ANf/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AGUZPEme; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="f+s+ANf/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AGUZPEme"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66UBHT1l917853
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mU3S2KFyCM2FJ/zPY3ZKd6sbQzwi2C1DPhH/yC8ntBg=; b=f+s+ANf/k1s576D5
	LIvfUa17zlcR+dIgzS72oMwvXrvZK/6kAyystl+icmj6yqXfoDgYJ4hhVBueI04C
	q/IfrBUiivE6c4nFF3cr4iDoZSJre2Yv/K7EIb6joVU11XY/e2aHGrgvP1hVu5hJ
	uxMIXlVyLlpBlxT4e8VtbEkekWNcNV/Mmcnzp/f2Jn7iSiKwdXiD3iZaNfu9kG/B
	0WsaOZJVEfcMiR+wrg5BeyBZ99WUHD+miL5e5bj/qlpqCBXRQJ58F9d9ANjSDiGC
	FvQBzIP8FXC/pZfjKz/vrTdEvQTkD81QxM5wl6aQZ0O/IwK335oRaY0X20cPx2jB
	Xq3A8A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr5m081rq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 11:32:34 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93163ac056aso27636285a.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 04:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785411154; x=1786015954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mU3S2KFyCM2FJ/zPY3ZKd6sbQzwi2C1DPhH/yC8ntBg=;
        b=AGUZPEmeqOidzVYwivVxxuJYks1pGvvAqWZtHi2CevuFbyRDRKAu7AX17qI+G+7Cg+
         5D+JgWg36mKgcoVEd3fU+3nZ2Jg5napIysRDZc6qL0Cx/DbWyv1ebIc4HlnBYRXGJgJ9
         kVW01KTqvB9CJ/GDctxAdHVDcGFMBKiin3x68fdxY8NvqHCbhyNe6Ti1TBHd8hphrOjA
         fVwx/LWFE46O5aFaY9h5xUWigCErzNzNOmTzb1EiAO3I80hxvAK5RlBjlsyKGipo3Z1+
         0rQWduBvHvLDd4ui5CoBtHihXw7fIXQo0NrzaYAEZGLRVQE/+GnxmZ1nHnsV9JcticMb
         BhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785411154; x=1786015954;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mU3S2KFyCM2FJ/zPY3ZKd6sbQzwi2C1DPhH/yC8ntBg=;
        b=D8Me3WDWd4+IyRCYyxbo83bq4d0QLpMyAtsQgdqJH+BC9tn1DTwceaaCrbblEcF9qd
         pQb3KY6O+SdE2DNdopIzDqR3/bmn0GpsxfFZyZK0nPuXHDXc2rRqHZb92eRHiGT5PVwU
         BUs0dMi0PNeD5CcjmHM+TmtWzoYRgwcDHglXAQc8Y6vJxB/DeXPyA8HEOWFnWFMsvJGO
         ndsdQRqfI1PQ8nQCdGnSh+TMYwwTm45kjAYSSCayIUJ70iHqKbVTZheW6B1bgld/+PT/
         +7vEpzMTinDxn9Ok3noYgfunCxZoaPJ9DUbjZo46VE4JUpqtNBc3GoB9DtbmYmxcGXTN
         wIyQ==
X-Forwarded-Encrypted: i=1; AHgh+RqLVJEcisc8z9Zdmv0y++KzL5IVnbUFoClBfflIyJFzs4lIN+zKG5IgaB/3BregVt5WiKdIhA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVwlrSYJI/GXoT93ZBqQ3ApckZrSiyJB8Cph3J5VeJ9IlJx2CD
	NkZ+r/RNNZ9JL7PrztGG2l+LgMZjSJLursNDLxVZcW2RFMFLWKhYK/EFsHWbv2FxWe3jYuCcU/e
	D6m16RAUQNm+bSUrGNvAjGD8xeRF1gyy8LJoZFumjJ+s9n3cvbXFQTSY5ed4=
X-Gm-Gg: AR+sD11sUOFJ791UfDPcRCJk8QTiTSG9cq4JnMVGFBzToaqg5PpOiuC73aSlTh4r8on
	/uHF+L3KLQfLYlAogHoksW7A9qRNHs+W0QdqhIPbmRxg6JuML+rEG4Q6h8Au4+WHBYQgtyvBKnW
	v05b1y1O4uKrdeBa92OE2g6UEqneWG0gC5mycWLPYvVOCLJdMWYJvJ900/BtDajsezYfO+W7ztB
	QJM8BlpetSUeyhvFolbC0tk4FBy5ufLCaysVwbzfdNpSEu8t2+gpL5B2F5KLt35EWbKtOhs3iYG
	9h/E5Ml/XV14iJxBr4O+wKNSxPAJTTfJmS/9zJ1DBug3HVQnaiiLYcP7DepZmJPsDeg715Kz3uE
	S8A1acqOHwfkQaro+AI0/y4RI
X-Received: by 2002:a05:622a:6d01:10b0:51c:845b:ac4 with SMTP id d75a77b69052e-52b386944b1mr27789361cf.3.1785411154288;
        Thu, 30 Jul 2026 04:32:34 -0700 (PDT)
X-Received: by 2002:a05:622a:6d01:10b0:51c:845b:ac4 with SMTP id d75a77b69052e-52b386944b1mr27789051cf.3.1785411153808;
        Thu, 30 Jul 2026 04:32:33 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa857c8e1sm59328866b.19.2026.07.30.04.32.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 04:32:32 -0700 (PDT)
Message-ID: <3da755bd-ab8c-4d2f-b7b0-6cd7eeb4808a@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 13:32:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: Fix test_ctl_hi field for DEFAULT_EVO PLLs
To: Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Rob Herring <robh@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Iskren Chernev <me@iskren.info>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260729-pll-test-ctrl-fixup-v1-1-246d79589380@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260729-pll-test-ctrl-fixup-v1-1-246d79589380@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: ZNowFeAbVXjefBH0tJ0fIOSRGyKV9Ty7
X-Proofpoint-ORIG-GUID: ZNowFeAbVXjefBH0tJ0fIOSRGyKV9Ty7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA4NiBTYWx0ZWRfX0HOuTShUE1Qa
 qSKBUWubl7/Z+UCbtcnrY8pows7AR1I1AUY7c1UUpY123gEZOroxSBm5nMxOvEE71K3i/F4tCsH
 mT038CtXH0lTiUcEHassouSPs0Ay6KU=
X-Authority-Analysis: v=2.4 cv=esPvCIpX c=1 sm=1 tr=0 ts=6a6b3652 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HWpFVbl4Vm_CWwIzw78A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA4NiBTYWx0ZWRfX1PQOZsXH6y4d
 87sF5R20ny0ROOBH4cMI9hZzFtPMY9s4wmsiEpoRPbijFA9v5NSvoAIiFQI/iZwd82bdPiKlKtE
 zARoJ+jcac0JMrklR7vvPvBU7PZFT1GtJFlZiH92nqV3Ck6ihc6dhVXsnfJQDFgZkHcW2E/wbnF
 6hFMcMcPlcLCLhGxPuLH/5ZWYJhl/6Hrb8c/L7Ev+O73TeWX7SB074pApd/Wb3JnVO3uPTem6Px
 i21wCx/eSYWMwRvz8NgZk/2vrLVgQBTeMjcWMV5PNnwd5BCI1jJpXgLY1YC+p3Qv6EmUJFpQ2dc
 5JW3Q5BPWAZqBCFtB0tYy/1gd4eCdOBSNpJ2H2dOJyvmUqYp+XIpGA0Dzh05MoJTZf7aj2YwtiW
 qxHdKNi68xserPOe/foMaDVCxVvrfUqy0IUvdzdL37J7y6YXBZ8+29kFGhPneKj3uv5D5rWZeCo
 9kgKn3Iwog/p7oLZXkQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_03,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300086

On 7/29/26 5:23 PM, Imran Shaik wrote:
> CLK_ALPHA_PLL_TYPE_DEFAULT_EVO type PLLs do not have the PLL_TEST_CTL_U1
> register, so clk_alpha_pll_configure() does not program test_ctl_hi1_val
> for this PLL type.
> 
> The GCC PLL configurations for QCM2290, Shikra and SM6115 wrongly use
> test_ctl_hi1_val instead of test_ctl_hi_val, deviating from the hardware
> recommended settings. Fix them to use test_ctl_hi_val.
> 
> Fixes: 496d1a13d405 ("clk: qcom: Add Global Clock Controller driver for QCM2290")
> Fixes: 01cf3e27824d ("clk: qcom: Add Global clock controller support on Qualcomm Shikra SoC")
> Fixes: e88c533d8a2a ("clk: qcom: gcc-sm6115: Add missing PLL config properties")
> Cc: stable@vger.kernel.org
> Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
