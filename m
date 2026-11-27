Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783306;
	b=wnJIHtFeRhXzpXZyF5PHgKrwCrCgRHL8uXaLR9rNgouDT+nlwBiECrZMQdmV/HTzyjaI
	 02m8mORF/iYVYyA5/4CmSgO+0URRYJbE4fPInP+S3b+NJGgREVSGsEz3BF32vv5a+5KSu
	 Vek5jLokNjhpBEt1rf1jW73O2UI/GHGOept1X2wPHDhyfhbiUyxAtn/7dkfbhbPbDaDW6
	 YriAvtzetWat8NJj57KaIBiGJvsW6ydYNXWwKATrBVJlMqKG1XOHOHqk7Jk7B6dfi6YM7
	 FTt3+bCts/BBPEzNraYYg9Yf/B32A/aAZsJKQXC+I4F+9vPV/xl/7KBfbtiKzLRgi5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783306;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=G7WfnYAAz9L7iq6xcuOnJKP+ixkbp4G3odLAKqkVuMg=;
	b=s1dOBdQ9h35GuUAewTbYyGIj3kn1y1umsVI2HvlO2xSpyF8C6kJH+ik5HhUWY0JakuUd
	 j9+V00ikVL3z0Bz1VVLA8XyktDDeU/fGVDQz2lmU4+/Tv1BoxZK2Lr19Kp9Ts5Jn19THK
	 9lLAkm0vWp+7K2xf1oKVB1Tl4ZbLPeGWASIB+HFaDBtP/Kaz6ORol/YVpukXMoO9j68Or
	 4qiAlsS8PxMz667Iot/clg1PQ5QrUdhAtOLxg7m1YG7mhYrkW9vnRHU9DeFPfynTXzSrp
	 rJ/OPgHYP5oqN+uEzinyNyhQcm8BGXCtPKg9k7hd8Hzv8nPjfqizm2/vE9B4eQ3FBhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ksYuS3+N;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jEjY+FC8;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD2606A321
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81AD2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ksYuS3+N;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jEjY+FC8
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARApNqD273544
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:41:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G7WfnYAAz9L7iq6xcuOnJKP+ixkbp4G3odLAKqkVuMg=; b=ksYuS3+NdQcAkupq
	UqtxonlxKl8nzWLPnjJ2cnDy4QMEFs8ukuo/xtyLmhlxavYzxHwouTzgqhYBoMbE
	2FA5UbMyhVHF5c3ODFPVYbg9DjA9YSOu5EszWDVtsLgLG//r1U/pSoNXMRgZtA68
	ePQQjJsazCF4H78cHmZmgZXN5kEbalgR4Q+rqk8JgnK5Wg7nRJAauY1hDBqouPYA
	jrWUDUIIiP9xyUTXioJvgDZga74UZUqQzVAjVdS2/KZ9qzKXIXJHo162KVnU/xX+
	c8g80b8Zvlp70HFSnj+8i8A9z5BKRrOev4mB8d/T1F6sBjKs22r5tNsBrlTg3Afa
	Zgo9/w==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6u49b0sf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:41:45 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-386b8624cf7so7019790eec.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795783305; x=1796388105; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G7WfnYAAz9L7iq6xcuOnJKP+ixkbp4G3odLAKqkVuMg=;
        b=jEjY+FC8/F6SyJENSeH/5Ipor9xyWqnnr0kYQ0vAXgWx6l39ZWH45sesJV9MrMRRRq
         F4ZbARA7aUR+WmMqkpreph7pteI3BAyzoLIL6qIvSApjUESpkAWSO6kwuIqAZXzfrFvK
         Um0Bf67ehWLPUavx8SKe8KnzjBP3E6ifMurS9Mj1DDcRiWGtsufEEI2r/p6FBCaDOacK
         1Rl+uhpiTsR1WGDmIT9VGpmS8OJf/OEsoRvj6pO5E4qS8KJqlxkep7+fB0YdmaYpmZSO
         LemZ+n+ryUjf80EDvuqcYBrycC5igh+nZx6t+2X+ivcZ5v8w4GFDXWeDQFz8Phl+Y22H
         rXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795783305; x=1796388105;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=G7WfnYAAz9L7iq6xcuOnJKP+ixkbp4G3odLAKqkVuMg=;
        b=d4WWlH5OvuG+eS7dTFxhWRdU5+lFay7EDMsv++qfprelsw3ZEW6+ZgrYFj/SVME665
         FrnPoxYtvaEmbwxQxPRmV6cEfbqtcSbi4sCtI71g4fpi/QqSuPsELSWSYH4/B+tedcMp
         i99lt6nrI7BLq+OqJ3u6DFX0/eQqVs9xTGrbmPr+FFQAkVv7CeodWfWw3coUhGlkSMOE
         7ediCH4pFU/bsO006LXUwOBPoiYAvqq/LBcvtPgE5fVZw5EMunq/vuzQYyWlESm/1ajn
         Kg0Z24GL6OOat4n4LVuFvYUo3ZFxHrrpnBbayXGQ/ZOezKJpes+zvbwPHOK0v4W67Hj/
         +QhA==
X-Forwarded-Encrypted: i=1; AL+hErFM1bKOsA0muEVe9Yix4AI3HNWtkeTRZ9q/KHzDZ3nR0I6q7oneJx7RnahwrIxYEdFU0Yvmg8Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9PJK2cksBlfQi4/Ufkw7AN9HZW+sPKexE6c5MoWHkueEWV2M4M
	qeZJ+ofak3mRIWJNnXqJZLySwHsszWtZFc/5hMEkwFUrtzRXVlLhsSUffNQuYaMsgOBFydfHDaX
	78H7R/1rdswKpqveJtaSeEfdK6qzz+NZlef77kOEadb85OHtK8qRvzkF85bc=
X-Gm-Gg: AZFdTZene9+vOCXPvoc/lmkKtgdzr06LwKCQc6eQO/FQVLarKhkXPD4YhU/d2YkeXqn
	5ItITOefjTywAzw5uL/gEmZRyWI++pn1nc5RKwept4H+sF8e/DzJmflRCIZ9xmeE2E3nD/KATD/
	cqyszLLQoMmVTcFShLApN1vA2aLr5I4dKvO/yBh3Id+SBwTKcyDyE7mWZowAo9jEMrxcXNQUCgU
	qnmsZ6HQAu5rZWgUxwLTXhtZhpqQP89At1+F12evRItcL05GxCWva/hclYkY4toi9ra2aACHJUy
	QCgWEvKwo5TZCIEL91IIHTmV9mkgIr7FvBFaAh4AyyEN5SfE5Biwyh0+CtcSimAjls+zEyz8crM
	BRznGxkIcDdW1OYBblKqjUxZTeRBNkUE3qlzI1+A/ZLS+FDxBUg5oEwoARfF4JexbrWOV1Ctovf
	ejKdBA1A==
X-Received: by 2002:a05:693c:65c3:b0:386:e9bb:d9d3 with SMTP id 5a478bee46e88-386e9bbda7dmr2871208eec.28.1795783304895;
        Fri, 27 Nov 2026 04:41:44 -0800 (PST)
X-Received: by 2002:a05:693c:65c3:b0:386:e9bb:d9d3 with SMTP id 5a478bee46e88-386e9bbda7dmr2871178eec.28.1795783304400;
        Fri, 27 Nov 2026 04:41:44 -0800 (PST)
Received: from [10.206.111.23] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38567daaf70sm74177848eec.28.2026.11.27.04.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 04:41:43 -0800 (PST)
Message-ID: <1ea0310d-b25a-4e34-930e-7998eec03605@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 18:11:35 +0530
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
Subject: Re: [PATCH 2/4] media: iris: use dma_iova_size() to check the
 reserved IOVA size
To: Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sibi Sankar
 <sibi.sankar@oss.qualcomm.com>,
        Honglei Huang <honghuan@amd.com>, prakash.gupta@oss.qualcomm.com,
        Alex Williamson <alex@shazbot.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>, stable@vger.kernel.org
References: <20261127115849.2780625-1-m.szyprowski@samsung.com>
 <CGME20261127115900eucas1p268ca3a6688c2fd99513317dfc99dbf59@eucas1p2.samsung.com>
 <20261127115849.2780625-3-m.szyprowski@samsung.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261127115849.2780625-3-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: v2rCQUsvpkt45T4D1h2HePQS0fMf8t23
X-Proofpoint-ORIG-GUID: v2rCQUsvpkt45T4D1h2HePQS0fMf8t23
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfXztT5mj6XURMD
 DCnsOh+zONORPsnVD1NqrsnpAW1gkEUDCjFmwjy4tWE474E9+Ky9h6E/lPnBXBnBtqHlg6/dQ0h
 tGEq13FMshztnt2i3eUrekw3pKtmqJc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfXwdEosPBi9/er
 jRC0rApEJX9N6fiWX8Q9/j6dQec49uWOWcyDnUIahmn3r9px0M8HXNQghC9iSuMj+1KtRzgkrQo
 XEc3fPnirx9QxaNbRhw956OoSxTllhieh9Ba54PoC7UuzUnStAn4XJ5Ot33vo3VpkjMEo3gLKJh
 JLelNA1upPxnC+6i95hSZWA0gZkeDFtyGNmvCNVGQc8qxutpxtkWoD1qGrqAnOmq9umhmG5gM09
 ZGWdVFaz/rEa8aU2sB7a3Afdd6H0y9/Qt0DfGWTIowq0KK7FGaI+BJkueCuNEmPD1BXFhrFG2jt
 iCvbx7bAF3h1lrbfhcr1doSUtvjEmipK/LTJ47p8umH3sAGjV5QWrCaXuG/yuiyxBaICWk4gGdc
 zzzUuyB6ZJH/3a94HQC7TTvKaCgSUVZ183pZfv2TUCQq1ziCqwR4L/TwgV8Rfv8uMErY3ZOEkyp
 lB2lqxIc0+HNnT/ePBA==
X-Authority-Analysis: v=2.4 cv=A875rKWG c=1 sm=1 tr=0 ts=6b097a89 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8 a=umoC_DmSGuEwgYlhGCYA:9
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270050


On 11/27/2026 5:28 PM, Marek Szyprowski wrote:
> The IOVA reservation code compares dma_iova_state::__size directly with
> the requested chunk size. __size is internal to the DMA IOVA API and may
> carry flags in its upper bits, so use the dma_iova_size() accessor
> instead.
> 
> Fixes: 200473c198b2 ("media: iris: Fix iova allocation from restrict region")
> Cc:stable@vger.kernel.org # v7.4+
> Signed-off-by: Marek Szyprowski<m.szyprowski@samsung.com>
> ---
>   drivers/media/platform/qcom/iris/iris_probe.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
