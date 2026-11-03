Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699379;
	b=O/BLFxuz+Ktk1vnLIob+Zq136IdwLvakyfkTrXGiOz5yZdT6s+9SklC4Bx4GfPaE4k9S
	 OEWb9/XaxWeJTgA7BFowdZhRHkM/zRGPMyRwBDyuc1dDXFJtld6DwoR1KhyyuS4+vXaSq
	 s6gB525P4fBVctO9LdRXGRN6TWj8c8xbNJ19n2jJBi5O6gg0pgn4K5XsyFEVaOrdSBc6Q
	 UV+IMiXyAuZhR2Y5jWxCPivkO7jDyC92aPNWmg75khiiI5Paj5z9zcZaL3/GBMb2ebNO+
	 eCrgdzMTaoCVxlwvOZC5VsBnWyjyve9Hyhjteheqr7b5z5pLf1KlvMV41KDx05mQfVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699379;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=kMMQdzS/XU9GNBHfZVGHYfrRZgo6UXRJKRG45fQahE0=;
	b=ywib72Tc/FpiAxtrXJSqjIVvGDLeRAfn3WOJDkx+KlNlXqlLj0+z9pyPks+ABiXiUsz7
	 49zVVzjaUYLh88sBehAjpFPejDDTWAmHSxFibzIz0fssHyOAk/w6OxcTZxHsfC2GFvD++
	 Kd9jCQb6dWRRvPoZEAcJffegjjpbPdDGV6oK/du7dfB3buZmFuHP3qPaVoWU9PqCRLd1l
	 eRKGXz6EW0o1Gci6txmWa/3YMDlHL1l3lfHO0dz39e8EepmG2vNNNppRLQPfT9P74Z82y
	 OoU1CeXvF7A9oegemGxPTkg4tnGG9MsyIA0sI7gyPLXqMYv9K0TUEWdVOezVUMuwFpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kZ3AbXuW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OvUdwu9P;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB63606A327
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 09:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AB63606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kZ3AbXuW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OvUdwu9P
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A37ovC11397204
	for <stable@vger.kernel.org>; Tue, 3 Nov 2026 09:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kMMQdzS/XU9GNBHfZVGHYfrRZgo6UXRJKRG45fQahE0=; b=kZ3AbXuWPVnIFJ73
	O739e4Nif395c0f6pBHTd7pycrx1UiErORl2JUqtk24WPwDngoqsf8ZqFqWF3nmm
	AFISxSw4C3dAure3DwRq+m1KyQku7/0KGtueKXZysYXs6kSG4qek8xyK+wrDfn3F
	8KYo/AvkQ+x6Ufr9gj+T3849nSh4UKiqdsupZZBdkKweqEMcnPYCr+9RU7JlxgYE
	ENpL2EtDVa7TZWfV3pRj2l7WlOAa5RVq0rpAW3aiTuNpZWQpNtKcP+50iDEbKZVa
	I9RbXZUAwxUCxMCTJ1uLnFVtChe4oEaYNb4YNWVTz4tTG1jggxzInktVfYe0/6wc
	mKUjrg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq4v5j1mg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 03 Nov 2026 09:49:38 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-91c7047e84aso13683646d6.2
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 01:49:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793699377; x=1794304177; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kMMQdzS/XU9GNBHfZVGHYfrRZgo6UXRJKRG45fQahE0=;
        b=OvUdwu9PXEkCdP+U3r6mvE4PA23jYV1AGLkAEOqhGGTvF9XBtZQczkaKGD15L+o21Y
         +Dp1au42mH4ssx5a3RnIbNgsEM9x9EcM3uWCaD5dP8XtDFXm674R8iUPFVwLE4DtLZaX
         kuoXNJ2PLlkNIKiCi517u8LlMdwKj8PrXknH9EQM/km/sUf2b6OPe3c+jor6UwZc5lim
         eJT7TUAh98Z5a9wS69K8LdKvWx7Li74M/YUnbmdJmvSLkEeOiEQWL7Nk2eESO0n8kNxY
         wv8B/qcbAXBBrLSXVhnqIIG6uf/KvHN7TpEtwwIvY34zJuZne2t8kMbR/qtB37tRfgVu
         Vo2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699377; x=1794304177;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kMMQdzS/XU9GNBHfZVGHYfrRZgo6UXRJKRG45fQahE0=;
        b=1FuI9v6DgHssMeOXSky8lm3WGqHE4QT5NA+u+skLmw0BczKsP7u8xJV1s3T7nsilWZ
         oH/WXGwvzceErvD4DVsSNduw5rfW18eSsxGD4Ir/6IiVUKti1vKIhZgAMI8vAvcOpC7V
         U80Va6M0C0TPpQLXBC9r89tgIzmEWNurSshfY2S+i+ErcFn7r+LQq7BDkM5zHu+vTPXx
         omJ574rE/NUb6N9iXFk/WFVZCLPAqMsbW6ymniLYpIaxpvbi+dI6o1giLVMFrBHLl0re
         Kk4QQ2orPxyrtx3lwVOKabzt+g+zwPyp/hPK3Xo5jG2ewIxfmeHXpR6h7a6+57qq5rgf
         V3Ag==
X-Forwarded-Encrypted: i=1; AKwUvByMe0zpjuDuqEJ3++NopfnqM9cllWRgOWOYosJSkXxWOWVu6eZw0B8zLLaOIYsl6N4ydFCoSoA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8udcjDZWdabR3UerYsOb1vUJ2pUYskACqnnke0iSotIU2pgL8B
	veSDGrjkGuCqdrCrLCV+2PEgDtmqRJo2e8cRgjBp4IMdDpiHo22qlHNB4wUPyrXsVzWhnzkchxq
	O0hMjv9RhIY7Bv9iwcifZm0GT53QbF8Swp6khwZ62NY5icmzVYhduCsXa0Ao=
X-Gm-Gg: AYBFou3EVQnSwGJueWQYJcTTpXPgB1OGYu+QYhkC+WIX1rUN94tlusL7KITBVQRYKmQ
	TceZeHuLmMfdukUEtIVXDVf491RUws21CbrL7yA+nWFURuhFczuD1xbqQWoVnsuXJeneGEuic/A
	53jgmCQhOZzhebwRE1HyvTvPCTDVoTgdiT4Nurf1tav7RYi1Y4BfABH4dXl/5GvLwVg8rgjszfR
	TKieOamm3ZMsjTQEac2eAUoBxYE/L8iHSp4pOg6kOaYsHFc74L/24IWdHYJttTXg+VG6qHZt3Re
	9iE3es7kdy2pqaFHFdRUpZ4eFhUVNWaE2c65RDc1TfvzMhBI54iZoVNxL9F3HbnTWcu9aniG6sH
	SxNyKnymNgBxMwZWvo9QhVw0Z3haDi6cd285EtsYw2OxsC0CtB0ILG+akXmVFKPne3uF8RQ==
X-Received: by 2002:ad4:5f05:0:b0:917:9dfc:b958 with SMTP id 6a1803df08f44-91ca4a0b081mr304850466d6.1.1793699377547;
        Tue, 03 Nov 2026 01:49:37 -0800 (PST)
X-Received: by 2002:ad4:5f05:0:b0:917:9dfc:b958 with SMTP id 6a1803df08f44-91ca4a0b081mr304850016d6.1.1793699377101;
        Tue, 03 Nov 2026 01:49:37 -0800 (PST)
Received: from [192.168.226.81] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cebebf164sm68701366b.13.2026.11.03.01.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 01:49:36 -0800 (PST)
Message-ID: <b8d60bb8-7000-4f9f-abff-02f596e1bee4@oss.qualcomm.com>
Date: Tue, 3 Nov 2026 10:49:34 +0100
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
Subject: Re: [PATCH] clk: qcom: clk-alpha-pll: Fix the L value of Zonda PLLs
 with a negative alpha
To: Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261103-clk-qcom-zonda-l-value-v1-1-9c271ef29155@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261103-clk-qcom-zonda-l-value-v1-1-9c271ef29155@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 8ccGTfmsTB-LzSuY38lC4IH5pwiEfcNr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAzOCBTYWx0ZWRfXy3UIQ8ZO0KYZ
 WNRExX0cRNft2CeJ8N1UDBNotH+05FvJqfFgC0Kgpu+aRpIOQgPDysZ0sI8c1rGJZPVL7EHWjff
 /RxEUBmMsp03BLvC59HGGleMzSXVUgnatvw/Q2nWNClzUKcqaGs0g9UdKoHBT5UTeUFxQvNBzCk
 jgjOl8NuWQAZ14zdIpzWyaYGKIpOUvcHgGN6t7wLztzSVEGFjKxVlONES7sY94eMsxiQJ0XvkbK
 rhcP/6yxI8Uflz9DB4d/tX4cBkWGNo1J7+fnBa0Nx47vZoBKmPZ8YBJ8Eb119e0XgwZksAvnYnZ
 vcQz3ZKr5yzrrdf3dGbVnlq+2E/DQ6Ruy/BXHt+Deoz+ceJrOsdhsYU6LwIXrv0kIdylFsOKadh
 gaU3vMmAdqepqoxB0j7CDt1rA+pRaxeoXroJS9uOTm5STtar+dOnPGk9ELkO+gt4o6MmQyAZXMp
 xyZveQBWiDWQ5iWVI/g==
X-Proofpoint-GUID: 8ccGTfmsTB-LzSuY38lC4IH5pwiEfcNr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAzOCBTYWx0ZWRfXyjDEBagYn2sg
 HgVNZJn0Mf8VvOcg+wzgHe9HeyvAVCxuVmV7ikqaSJ5If4MpzQqLF40eJl4hd/4V1/Yq7UdnewZ
 HqLYIEsgzQqjS2e0R3avuvo7WZrZLy8=
X-Authority-Analysis: v=2.4 cv=NeZzRGD4 c=1 sm=1 tr=0 ts=6ae9ae32 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=U0MhLFlXrxXVFuOl:21 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_AXJYLjol3WrTOYx9vcA:9 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030038

On 11/3/26 10:48 AM, Abel Vesa wrote:
> The alpha value of the Zonda PLLs is signed, so for a rate with a
> fractional part of one half or more, clk_zonda_pll_set_rate() programs
> L as the integer part rounded up, through zonda_pll_adjust_l_val().
> 
> Since commit a4d89b11aca3 ("clk: qcom: clk-alpha-pll: Simplify the
> zonda_pll_adjust_l_val()"), that function adds the rounding to the
> requested rate instead of to its quotient by the parent rate, so such a
> rate change writes the rate in Hz, truncated to 32 bits, into the L
> register.
> 
> Use the quotient again.
> 
> Fixes: a4d89b11aca3 ("clk: qcom: clk-alpha-pll: Simplify the zonda_pll_adjust_l_val()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---
> Prepared with help from an LLM-based assistant.
> ---

https://lore.kernel.org/linux-arm-msm/20261027-nords_dprx-v3-1-5d98b2c6c263@oss.qualcomm.com/

Konrad
