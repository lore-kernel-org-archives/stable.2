Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793868736;
	b=3x2rH/ZZfh8uH8+KRzSz5GgLmEZewP2ZbMIT5CzDV1WiTzhYUgt9hW8GR1EmT+bzpUP3
	 rjlHUqsecq2OLkw9WpBRXCREsSrAVqaqz6jrvQdVWXUIDtNJy+eUaTylkCS1myTfgCOLD
	 GDfZuZL9WhUrpdO7UYefkmGGdoKEtUi0pfjsBB1Tq3UZza4Xy3vYTnPzR+FvVsGLHQ3CI
	 tlFtIAb/0Oj1pHYCJKZzAFy80OFU/8GNd9nGE+Tz5/GcMLnyZoopyD8B0cD0Rt3fS235a
	 RjqSK0dfpuw297XPJb6OyKBrp346zVw3tJswGqp17DwpoTYq7w10+aiTG3OxmPK9/9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793868736;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aKMn93+Pdz1KflYpYZRmRShKdt6jXJBXPqsYlhldJHo=;
	b=OYZ9hQd/BfmfWKMLqvhrF6E0PtHXUTANVeqxoNfFbCp+9e2dLZv9ywUw3RswGb+oGhqK
	 DOaEkZ+8tHQhhx4YD+6UK7fqvP474NETlqlW4EK8fHkkqYh98mQiPpsU5HOuylWgZuuII
	 RuMcu0RZI8GvodrY7h3v37JoNSgstrzib50rfrPMk5j/T/MU9Q+6pwrQuf2utE6Sezune
	 H3rzqXEftQD7nNu3zUtLYUY7/bsMxPmO1fuAJ7aCkxhxb2WDNykaWtUiXt3eO53mdjnHC
	 YJdhcwnIl+vGO5NKqVT6Pz2EUBpP8C7CqV2HWxP4eN9v9bz52ZfrOOcwNeBUSv2hv/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=duwbX2bq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FTTlNXt3;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C70606A32D
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32C70606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=duwbX2bq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FTTlNXt3
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56UCrB3819766
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 08:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=aKMn93+Pdz1KflYpYZRmRShK
	dt6jXJBXPqsYlhldJHo=; b=duwbX2bqOb9603Ifb7XUTLPi79mBxD4P0AtDZQ/1
	k0SSLKBI05dxW5jcl2W9mROYKSNb12hR0aBBCDqIwRid/j7koacWsDufQHr2wHwl
	tb51kDKeRvVlMwr0fLkR8i19Fp9jwaATCbr+Xz9cS8e2CAZRwpwiyBtKEr9bBMTQ
	aYRaXT/V1l4WnrPLESMwRSCzMxbloDMjhItFQi83sb6d6NrkCcqh+CU01pu5NMGn
	XrJxy28HLL6gAA88R0q4eXGg6ofUBwG92fw+ef/Foo6tCQBrhQBv6aFZ6/KW0/z7
	cjpmS9P8DunvZcMZ+E086ULDnmonWlYefxRgRtGz8UuE3Q==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hra5tk1ss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:52:15 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91c75523074so33146076d6.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793868734; x=1794473534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aKMn93+Pdz1KflYpYZRmRShKdt6jXJBXPqsYlhldJHo=;
        b=FTTlNXt3EA4SB69KeecpahEf+Zdn9siIxxQJRA4t1HW2rb6TRv/p6FwEsqMOCmfxtm
         r0oZZ+C5PwwrOInrNv6qKm5Vh7O0cPyR7G+noIM142vYH1Ce/MVWh9ou3W8RlFI3Ou81
         iq3ETky2FC/XUQk0nPBK/gFEye8PNRu5wMstYsH7oq2ATymWhC+CeQ3uDRd/VpDT5FQR
         RA4OWWu52NTq9416WhkSYssNr5sCZxMMRuxF3SYoDnPP7gIjs286kj+76PSf+2TvS7fr
         G/fFdtm8/wnBwL6UJjStql4Lqn8tK/P3DMcrJwo8bO5RzUGS5mtoRZ04EymD43mn9lip
         w9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793868734; x=1794473534;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aKMn93+Pdz1KflYpYZRmRShKdt6jXJBXPqsYlhldJHo=;
        b=ZSnzZxsCg1cRPZkZVfJYFjTS+SMipWVxxJfumgEXWmPuXoFsz3GpKyd1zVKO0WqhKF
         QEraed4q7z08lK3/fVJuNbD+1XlTHGnvsOn+oZV97Y/wNqXHUi5gbL6q9ErL+puBxsh/
         3ufChzFERfzfHeGsCGf3+5Ar2IEXz//ROKl1cbFKFi33DX0VdeE0kovUVd5e3KZefPWX
         uPOlhBEh4RLnH0nOnrwSqQN3X/gbJH8KCWnYwTttwmaL7xozcwSlJYo29QgAC970rleG
         FGVnNTVW+MfRVWfTaVAcH5LTaKd8CxskKlS3+B+Uk3N15tUvFYCQ6qc7XTHHSqpiW6cv
         03Zg==
X-Forwarded-Encrypted: i=1; AKwUvBxaqxfhMFpQa1/C1wgPI5VvRdXdHSNgc3T0wfdaGetTj1Y9CfMCHyw2UrQtEnHGdDkCNF6Rhjc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ElTto27HLcE/yfLzWN5nFeWktgrzomWXP17ldLq96/8hYW09d
	8Vidwcd3ZrEWpnIc8wFBb9APp1ahlrW89u8PgK1hiWOL9T2QstU4qmt0A7MSRrqbmcdyAZ6bOUB
	PLNIGhtuAS1Rg+/XRJH7RIIct1FSvGUv+EOd/1cq/95eFXEW7Lf41ZMpsiNc=
X-Gm-Gg: AYBFou2wrWGHBVvMdgk58T7AuNQnKymTpgGKM0nOMFk8VYWTKolSUfDyZy5sj7N4J2a
	bnbOz8/SjEWTZKWiTSX1Tfh5do6krnzq3XjOPcTHh9H1SVqkQm4Nfkymu3z8Qpvi+t3JS6m9zDt
	pq3+JDaiFJoE4uqqPqVkPqlaIEiYo8fU2b3eTUOQYgXkvizGbZLKckolbWuJ7ZNDZttG5t/kQ87
	EwZsmbjy45NgaMVyePOsE+VhoQjyegxibR/XH40WcVdsEn/j3QkFhHkLvEVYC7uRdxr7LFcFd56
	zQ9EjwLOZ4+R0XkJ+4mjemqmDhnSKXW95xaBhY2zf4Rklcyz7/LzuBvdSnjBwDTmfLA5mo5RY9o
	7PheE9j0C6avuyHytKneMm6cHpqRz5yWJdCnSsxz34awkVR4qJQcr37J+Ts4bWC4=
X-Received: by 2002:a05:620a:84c7:b0:939:f978:c1aa with SMTP id af79cd13be357-94421581759mr2865813585a.11.1793868734285;
        Thu, 05 Nov 2026 00:52:14 -0800 (PST)
X-Received: by 2002:a05:620a:84c7:b0:939:f978:c1aa with SMTP id af79cd13be357-94421581759mr2865810485a.11.1793868733609;
        Thu, 05 Nov 2026 00:52:13 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b56ef2e968sm58243895e9.8.2026.11.05.00.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 00:52:12 -0800 (PST)
Date: Thu, 5 Nov 2026 10:52:11 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
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
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2] soc: qcom: apr: Reject packets with header size
 larger than packet size
Message-ID: <diddapoxu3cgqkuldldmlbnlmlt3dpin3563rhrie5gyvg74jo@ip7omguafebh>
References: <20261101190733.121473-3-krzysztof.kozlowski@oss.qualcomm.com>
 <20261101190733.121473-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101190733.121473-4-krzysztof.kozlowski@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzNSBTYWx0ZWRfX70y2ATOV0mTn
 MMpCU3qafQuXKFA05zPIFFKc3K9AEC4kGP314jL4u1p0VUJSoK4yMBNqFulRkEfMNTRorSsFrML
 BabR8lOoBDZOFaHeelAKYRMcqN5/osc=
X-Proofpoint-ORIG-GUID: 6jnC-iOq3lmjM8aSJ7vGxqyybj2nrM2w
X-Authority-Analysis: v=2.4 cv=P/6vFSAu c=1 sm=1 tr=0 ts=6aec43bf cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5t2Un5gMkzPXvGO7pNEA:9
 a=CjuIK1q_8ugA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: 6jnC-iOq3lmjM8aSJ7vGxqyybj2nrM2w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzNSBTYWx0ZWRfX+uHMiDDohL35
 pQnJey7QuVPjv3FWxpyg9z4YeepENvvx89MNMwBCFSzvisOXrs0NvGZmkbEBI/p1gCwh9iP78Lb
 OwQQ2rIl30JhvzFwkpdPfITZFb+0OX7JbFHI1fWxPYEZ+mWPWt7TZ4PDDNzhjlbJHxizt834g1Q
 Gw2pDjkSt4yIZ39zuH33gHaM7jkD6/0Cn3ssGm7q+sXnI5akt8M/c3hRxec6rWx65/Fte4GcGzi
 dG4ciXJDXF0imtQMP9N3IAU+zLRERJmc0eydZqjQ5UzT/tDSubZBaNhkMualhhzCV58uua9gU/9
 hGf8xBpjgCJyKjWn1Q0D026+DNuFG39Bo10aHKmBd4kNRzlUaQ13Ai7SryPsNRnk5kueOeNRlLS
 c5Ird5scVURJvI/WtUcKGcx4l/tMBz1RTWtvDdofUvjM+Mitv2MoqvzJO+DmFwScMLpT3SkOTxX
 97aKg+HFG7mRC2OXQmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050035

On 26-11-01 20:07:35, Krzysztof Kozlowski wrote:
> apr_do_rx_callback() and gpr_do_rx_callback() validate the header size
> and the packet size separately, but never check that the header fits
> within the packet.  Both sizes are u16, so with a malformed packet where
> the header size exceeds the packet size, the subtraction computing
> resp.payload_size gets promoted to int and becomes negative.
> 
> Further check "resp.payload_size > 0" would fail, leading to
> resp.payload left uninitialized (stack value).  Reject such packets as
> having a wrong packet size, although unlikely that firmware would
> produce such packets.
> 
> Fixes: 6adba21eb434 ("soc: qcom: Add APR bus driver")
> Fixes: ec1471a898cc ("soc: qcom: apr: Add GPR support")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-82d40745-1593-4c20-8432-d86099836525
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
