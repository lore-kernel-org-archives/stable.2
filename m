Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3873F3C3F79
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160826; cv=none; b=H8QuTnGlFMxVzVvZ6bqmQeWk6X1U5Un51Td7NTsQeOr3NdNDDqA9uyl2CudU+byB2pAhaLaWTtwF894h7/v0VsPwhO7BwDNv/W3Cmi2O2ne4Uv9jC96mtbZBEkak5k1vkb+ZOx8HMsx0mOxPo5/Uxx1mk7EbYzlEObSpxKZzu1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160826; c=relaxed/simple;
	bh=h8J2NrchB0Z1iFN/dkUbMfkCPgIc00ZPMgcFXxFod04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcXSlie68HFqq8ZBlF36WpyFhrp17Ug5iuGRyrk1cvO30Y7Pzd3XfDmziXMKmQ8LJk8m3GCDTAyuN2W/9GfKZK4ByZ9QeXDFsgLaA0BaWppbGC4LCYivq7iFBbKqVfiFz5H/fOKhTeR+UpQ6w0RJHeps4mxsqbJ7tjUa2/2JgSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=T+KK612L; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LJ4PD64M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="T+KK612L";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LJ4PD64M"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V6o1KI3269786
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 07:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jp+hqQqMNpfps3DxX8HzIVZ5L4ni0RL7VXbNl/0NSJ8=; b=T+KK612LWjZUANeB
	VkFdsMWkr9eyhS/Q15o16qwql0zjmx3zVqavLU23rgjw75IUZUoeAw5IHkblRKn+
	7YzUSSJgv8+lF+kOZ2W6XWW5bum1I9EQ+RpOKDfct9vO11Ph6msTMLpc/ic9AYgw
	9O8Aw8paGd/LlJnIuE4ETOoGVuwYXXhZ+vb77bRI3rZ8QAVyFbCKjs8vRFOOVwqN
	jYcwONoZ8zLm1TjLaKsiTZz3e2FqBM4bH5hcaHomWo0mCaNv/8Iyq9WKBXXmSWeT
	sCT2wFUOep/7F5Lk8R53LQ532oQlxD+K1hDs2Mlg9Gl+3TG7dDe49k7ZK1lSrFtj
	9mSIhA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gd4pm83r2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 07:20:23 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52ec554a80aso9313911cf.3
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 00:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788160822; x=1788765622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jp+hqQqMNpfps3DxX8HzIVZ5L4ni0RL7VXbNl/0NSJ8=;
        b=LJ4PD64MOjmIEBA3fr50V0IqgyoR6uLn2ocu1W9O/3M1Iodo6bwa3hm6UXpsA7gsyi
         S2zXqygAYdWRbpJtEuo0U2J6ZK9qMwIRzsdNQCQk9AMhxB78DrE8a2lFx8idGT2XTK+w
         LuidQwE4w7TaTd4MZdCbO6yX72KR7kyrs3xZgH3DHDGlZmD+NV3HnzeQ7qO4ISajqaBc
         3B8u/zFpFBju7sX4Z0+yOOtXlqISofBouNbLQy3LOq550AzmketCWlH8puDokj5BuLzI
         XZtv+n+8fRqv3aq2i/1Z20gQTFBoNVrHeKyoyV43pewPgcmKhhA3dLEuvXK3pmiXm5Ev
         i0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788160822; x=1788765622;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jp+hqQqMNpfps3DxX8HzIVZ5L4ni0RL7VXbNl/0NSJ8=;
        b=U2siA+gfwz1welykvZwHLOih7xZkGTE9gecUzrtMmENCjEJ+d1Wf1+/ZArvW9pj83u
         Gk1f5lP2kRXRWUWOJxP2jk4vJzrIT1LX1UKOrvqbm7TN5lh6wS4ZIkInpgukrX9z0U9Q
         ELzY8HV6P4cenBXVcPL5h80D2mZCsW4HBEp+f8lq58u7JT6aX/+QEXepwQHmse8YsQ9T
         vHFK4CJU2cRcarg04w9oeySF4c8H79U+uNqMhp87d5SOCuNweBh9tpnlWdcqc4O/9wuG
         AM0bYXxSSAy2f5wiV9WwOTjzxlDwviRSyLD569TF45jnyuBlm+gpQj2TldJS5hTuJ7Aq
         x3eA==
X-Forwarded-Encrypted: i=1; AHgh+Rqf+5yUBTi88mVzM/QyU7lScg8+W6Xy9JyT1heOlAJhHYziNcpcR04prF+mnfa256+LH4wTWHU=@vger.kernel.org
X-Gm-Message-State: AFuF++m5d+/pnA3fOic8SjuXEDteByITi8UIlFZ0MlPM7kh3p2ivUhdK
	iCZF1VTRVyCIW0s8wJZpr6ijolo8rA7OF9EUZ41ajVXevoI2cGz1IfmbImwOAdx6WP64di474Hq
	QQP5BiuD3N/9AeS7RnWi3YU7CE1MnGpOlo43msLahXXCH6UqKmFIkYTywHaI=
X-Gm-Gg: AR+sD112GgpRJHShq+xgM33x0zvSkPvHXFpQ6HwoVQ0gDV6TCAIMIaPO/O9bGX+lY/c
	rJAUpaInf2CWYz7cv5RggmUvHp8MH+oCqkw2arbFHaO6pmOhyvto/02W9jO074HXYeAfrBZLMLW
	fMBxU27gDmXTGyg/HpHUSU0H+SeJl+jOuyoGxahsp6+Ltdkbiuc9EiUmrsS7tEX80Qz5dACMeMj
	V5opAeVQfUvd/v3tmFnacv+c83HXWUqaj1aCi/nZ3h/vSk+3Oi8stXhs+OcgeI0Ytu3dsBLXdPM
	ViXl7anwSF2Y7Uy7nY3v3syA89sNt2Fg+5gfFpEJyQ9EyBwHj8ormh09NJxAKWj1fH80n7FLMRI
	et8kHLhn9ap4z3pPKWmPZrQ==
X-Received: by 2002:a05:620a:1b9a:b0:92b:7420:bd58 with SMTP id af79cd13be357-939285432f8mr771690585a.0.1788160822427;
        Mon, 31 Aug 2026 00:20:22 -0700 (PDT)
X-Received: by 2002:a05:620a:1b9a:b0:92b:7420:bd58 with SMTP id af79cd13be357-939285432f8mr771687685a.0.1788160821970;
        Mon, 31 Aug 2026 00:20:21 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f1b2049sm405315466b.36.2026.08.31.00.20.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 00:20:21 -0700 (PDT)
Message-ID: <655e39a2-88d7-4522-a27d-767dc9578aa2@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 09:20:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] i2c: qcom-geni: release DMA channels on probe error
To: Shengzhuo Wei <me@cherr.cc>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Wolfram Sang <wsa@kernel.org>,
        Ludovic Desroches <ludovic.desroches@atmel.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Yao Yuan <yao.yuan@freescale.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, stable@vger.kernel.org
References: <20260827-i2c-dma-channel-leak-v1-0-271d4adc03a0@cherr.cc>
 <20260827-i2c-dma-channel-leak-v1-3-271d4adc03a0@cherr.cc>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260827-i2c-dma-channel-leak-v1-3-271d4adc03a0@cherr.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: iSfPEtfVeIvIYjHY2YonXs4bveZNuWvS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA2MSBTYWx0ZWRfX6Fd6+/YKemQc
 im0sOmMZTJZdeXd4yJq4I2aLN/VMWPYJAZk1xUqvqJv18rFWYLsU5inA/tpKzykt7cb5B7J9aCE
 fRr0hVx+JYo1p0nuX5LlmDAMAYhqVdrLQhUmxEeyDiYNiqnpqBK/sORrZBDXsRKhfeWqxoDwMzQ
 57g9DoLRebZWf1FwHlFUH2x7N186f7gtGJJwJLCKahcEOd3cFeI9wiDSGb4fwAsq14wHuQQHjpo
 y4w1crFcs29gsL0duFv8vTugy3+hoG4x43bDDL9Y979GrS51yh2jo9xKH9e7L4dBp53UL+Awi1p
 SKHD71suFs+rP9bSl9FdPkTsC7SYKWPQAzu5ufPkmG0WkYY2E1h5+ktvdI9tMNTkIHokzUDy9Sb
 nS+NdWYExwMcc4+Q3PGBVxkeX3seMux36Unqqcoe+uXDoRXJP2t+GO7sBi8cx7fqK0PmlE1nAeF
 WLe1Uc2grHX+PAFtIkw==
X-Proofpoint-GUID: iSfPEtfVeIvIYjHY2YonXs4bveZNuWvS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA2MSBTYWx0ZWRfX/4f3aDIlR9qV
 dPFf6rYKYz6B7KaxxErTrbNlLVLYLh37j4IozfGCOc3hxSNfOxA4zWqoy4XKUPCHgcjtKH00jAj
 0rJsjyEcdqxGfUP+nzbM2LzxeBDpAe8=
X-Authority-Analysis: v=2.4 cv=GbQnWwXL c=1 sm=1 tr=0 ts=6a952b37 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FqpsaMCCsM1CaQCKzz8A:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310061

On 8/27/26 5:43 PM, Shengzhuo Wei wrote:
> geni_i2c_init() grabs exclusive GPI tx/rx DMA channels when the serial
> engine runs in GPI mode. If i2c_add_adapter() subsequently fails, probe
> returns without releasing the channels, because the remove callback is
> not invoked after a failed probe.
> 
> The adapter-registration failure path used to release the channels via
> its err_dma label; that release was dropped when the probe tail was
> restructured into geni_i2c_init().
> 
> Release the channels on the adapter-registration failure path, mirroring
> geni_i2c_remove().
> 
> Fixes: d8d3bb127ad1 ("i2c: qcom-geni: Isolate serial engine setup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shengzhuo Wei <me@cherr.cc>
> Assisted-by: GLM:5.3
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
