Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192520;
	b=rZs1GIjU1KObJQziN/BTNO33Mvm5Fr3CFWTt5AXKNDRjIT4tcB0uTbV3P5l+Zm6ZSXU5
	 6pc7+UDyo5G4AJO2wcVOJH+i9KRqyGWVhAVwV0z8xoPo7tZkjqwwwDHVZGwJuQ5g5G4MR
	 CeiF5OOX/KAmZbcZNYBIMNd76APz7oTxswwEaK7VNw/0FdRDindAOAKpUnwLsXy4XzoHD
	 X+8HdVViAexB3carjkEmUTaDOtvpnUhmcPEpeVOePNzS/YuwbzHCCxLuq3OvZxhPGDW1c
	 79+IL5nnHxx39XFYMl4aXieM2rOoGNKp/5ujn8jbKqvH10k+SzeyMdDoyX6HM9cG/lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192520;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=JF+E1/98bAILDGzRZuRXRNPmaGCH431NnNIaFq3b5kE=;
	b=kOwNqe+S56i9ubzTUqFOcV65HEZcEKPscr6QD+S2Ggp6knGD6f55kbyU5P58Dn35m35J
	 OSdxU9TWzi7RbmTff7JdkBYieuKhZWnDG0HZaty2TnbUyK2PJU43CNNQT1bZEsD9agwlz
	 yn1EMVs5d1EA3D2SC2AXwSQS/OwKzKLSHZeXiKcklxoBM/W/uUHlsJrOCMO+Aj2G995sG
	 vRc2ma9+iW4ALtAsZk0mEvdRY3bLvPeUg+mvmcTIAiEYQKIBeHVRY5F5Y3NykaISNT5nr
	 Qgk2iVLmqsXVYOa3Hx8I/dwv8Nz2eYsSPmR+v8mJhDsCadGu374EDbM//isuiTj0syw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V+FumsiE;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QRJl1SXw;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A41606A327
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8A41606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V+FumsiE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QRJl1SXw
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SBe4nE994733
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:01:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JF+E1/98bAILDGzRZuRXRNPmaGCH431NnNIaFq3b5kE=; b=V+FumsiE/zr12OpI
	DFvA1swVDcmHoCFSMeuxf6gR1hYAK3aJg97AZw2yDP8OeufhK62kJmBEp+gboxx1
	Xi8hsGiR7zyDrktr8xN1m+uBKHMwOk0wsVM4aOMATdrICf0ZBxCkne7RMXAuFAel
	1VqbuFP5so8wBEgNwGEGTT62Ja/jZflNjlLHbbs3hzqsW1EnUosHDzGsRCRCTegy
	lQEJAimnmTgBR3b3cY61BBkHS69zt7vwihB1XmsBSxJ5+ZO2Il1k5qFEQFIBDRU6
	FV9pQGaazuPUkMWvLM4kNU+rv1EWa0FWnbLxg1cUjm4II6mvSE8yAjrkmjcsi5yH
	96TlTQ==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hk82tt585-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 13:01:58 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c97957d83bso77186e0c.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 06:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793192518; x=1793797318; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JF+E1/98bAILDGzRZuRXRNPmaGCH431NnNIaFq3b5kE=;
        b=QRJl1SXwTC+/ycdHpnyfytE2F5CpRqYoOGkIGcN2a4cr2Ha3VgdWTPUto9uQ7Yvv9x
         vhvMHBeck42b19kdVRpjlGBm9j/XpfYVX4t2Xmsxicy2eTen5kbovrW61KzFM+RjUcXy
         hinmG5Ds78vcGID3RvHE/zTso4oIz861xipNiAYtI+twPbdpltfBMAo8pfQUlTPFYaqR
         k0oVf1KMJUf2sLpEm9uCBk4898I0yrFCwIBagjmgt4Upm5E2vMfjRylps5Mp7BT/1uGJ
         4sMmgzr7PLEUW+hf92dlT+2F+1G+F9E/pyqS3jB0YJCSeetf+I/dGKS7FMcRbD22gpmI
         3wcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793192518; x=1793797318;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JF+E1/98bAILDGzRZuRXRNPmaGCH431NnNIaFq3b5kE=;
        b=nsUyP7kVNBRpu3mZQCAl9OP6z+NfD2gvUlsed3QaaShhP/1P66O9RvvbyNXYqePfOm
         i9FCoh94/MSVNn82xKATGz0MVjESNaFYnkOIBNzhc0PjCaqQaC9xAH6hnIlz2Rj2ichS
         gw45nq+l1odPKK+hwa6f+yMTxGDOlUgGG4wMdcDWzP7puThgZS1gE4BK6Jx24Xijjgsp
         5BpAiRrvzO1Mb5OiS1wuhhnp1zsSz9YTbbDokd1fyv9h669XXD4eUlFAVY8waoI3fnoE
         hBNphopi3rYcu9Ohf0L+0LiuZbBWLuffhGLl/o+1LqrI/kNKmGNhL21KYfRBzK0YJfWu
         O9ag==
X-Forwarded-Encrypted: i=1; AKwUvBwKJs1Hvte3ERTtUAea4BtozRMmT7C9i5rBXX8vABJ2E+wMTA9MTTEQjOcmMzf0uFYQRz2KRhU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJid82vVFkui+A8Qidsdx/0ak4cyuWAZzLrhwuMxI+rJcs7416
	swyN/4ff1zidobjv4XeaPEq8JiA3vVGn5WvUX2kg8J7oLQjVNcUssDXhGlpSHrdqlaTWG2xhNHy
	ovTA+VtfG+S3VgS42qwzn55oZGOaoio8t0+teHSACmJiGqcJ5T34pUxU9Cbw=
X-Gm-Gg: AYBFou1ZoxJvUx+jhcSVGy1fvMoDxN6hw4e26sLDkAg/hm8vNYxAtw2jJ2Nhd6mgc8o
	wJ32EOWQtQEq0eQ+Ef1qevkJI0g0RA937zBmlZ/nvm55jzKhuaSKBMWBFnHsyCBdvs9hqPKLdQw
	csP8wf3Tzne2alh56AFfBtYlF70AdmZNGeQZQFWHYXjt91wpjE25ttjuIQMBya1I2aYrgVSUIEH
	OVq/phE7Z4sRgO01xJl/f9xsvc3xwNt31mvoYvZ22LL0EaKGmckwwVqzWm9A+KjQLyYH79iRPBy
	3Oo1TIgdyDR9vKv6PPDPV7gNlKc+xFteX1fzj724qTKe84D8Tdv4nwr4l2yPFyLg/7zsfBvx5EV
	2CKlb14SL4LUp6v/josPRLo0cvvGUlwPt6jkUctpuUD0yX2dXJ3MewpZDXXhtAzVPcPW/9no=
X-Received: by 2002:a05:6123:553:20b0:5ea:af6f:16e7 with SMTP id 71dfb90a1353d-5ec4cc714a5mr883541e0c.4.1793192517795;
        Wed, 28 Oct 2026 06:01:57 -0700 (PDT)
X-Received: by 2002:a05:6123:553:20b0:5ea:af6f:16e7 with SMTP id 71dfb90a1353d-5ec4cc714a5mr883211e0c.4.1793192515300;
        Wed, 28 Oct 2026 06:01:55 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd4eabadsm610575566b.14.2026.10.28.06.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 06:01:54 -0700 (PDT)
Message-ID: <4b373217-d4ee-494d-a5a0-244fc9181b75@oss.qualcomm.com>
Date: Wed, 28 Oct 2026 14:01:50 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] clk: qcom: clk-alpha-pll: fix Zonda L value
 rounding
To: Taniya Das <taniya.das@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org
References: <20261027-nords_dprx-v3-0-5d98b2c6c263@oss.qualcomm.com>
 <20261027-nords_dprx-v3-1-5d98b2c6c263@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261027-nords_dprx-v3-1-5d98b2c6c263@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: wiaPovTmxgiSasBfQoVeS06Y4cmRi5J8
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1MSBTYWx0ZWRfX6oAjTk5gxDFP
 2RKlByjjlKPJJ1VXC9lEpfk7rLsBsm86vlyjz6xeIVy09yQ7ISPe/0bgus1G01y1Z0FOdSHiszT
 QQHCt1+lgFWEE4+1xcOTgyVVUv9KRf4=
X-Authority-Analysis: v=2.4 cv=Tr1zFzXh c=1 sm=1 tr=0 ts=6ae1f246 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=IYGMUUFy9tKC-wNfIDcA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-ORIG-GUID: wiaPovTmxgiSasBfQoVeS06Y4cmRi5J8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1MSBTYWx0ZWRfX94HrjJ9NQEsj
 95A7PQu2te2kyXZ7lfkPNmm/0QfM4GB3QSqFVJ6DiCm4wVOKBZh9urrz/g+BFIaaTu4Or+yrHQp
 WWePEgTcB0MdKnxMyO11ZXs9g/P9xzPuRtESJIh5wz8lOX94oBEPG6jRxutV9qbHQtpD5+F1u1e
 AFXRW9TxMIiKsxyiwYmyuzu1VuLnsmVGZAFURTkRzM3ZcwExt//kjSWMqUbikmqCe3nhsPaQJvn
 QfsNeNk2QkSAcNMobDyrFrBtPjsLxxus5RKYxtMgDLbSRRfJLh/IHmWrV4ZDvmGNS3Hll2FfhEH
 I95NhzTRTf1Jy/GhyUDWtNzS2XwZbxAAU58KJil6ogcj9CZfYU965IoqVPMUzBaSLhzfAA9haPW
 JKDAG9IH4JfgjU64BKi/tS0O99NcBjgRd/V3DX/1BshTNwoymLuC7hf8r0y+Yq6VF3fsHcTDNA5
 nzgyN6BCEhxUxFKW2Lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610280051

On 10/27/26 7:08 PM, Taniya Das wrote:
> zonda_pll_adjust_l_val() obtains the integer quotient of the requested
> rate and parent rate in quotient, but writes the requested rate to L_VAL
> when the fractional alpha value requires rounding.  This programs a
> nonsensical integer divider.  For example, a 1.2 GHz rate with a 19.2 MHz
> parent requires L = 63, but programs L = 1200000001.
> 
> Use quotient when calculating the rounded L value.
> 
> A GPT-assisted review reported this issue.
> 
> Fixes: a4d89b11aca3 ("clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()")
> Cc: stable@vger.kernel.org
> Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Link: https://lore.kernel.org/9dc66fa5-47a9-417b-b8ff-b3a61ea75678@oss.qualcomm.com
> Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
