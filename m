Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231165;
	b=xBblqsVdnUg9qkq/jWPZrc46IgENry9F3+G1pt1TuOMri3EQYrLjlHJbitud4c5S054l
	 y0Nn9RYs6I0ncxob0R2hA2+6HT43DlVnmIl923eZ9SWJk36bnKDTHF/hISWMMOuNLrtkN
	 w4/9+YEAjFmNIcY0U4VQcZzaiDLdofGAszKDqZoGoG1biDDFLn4CqCfq6XsQM65dOoj7t
	 tVb3Mh+tZh29isO0PCLGzf7UlMG3jSUE9Q7dDXOKqlC/HeMKC+6DpgGsq/7yqth+lIVTj
	 e9/gbcGIQ84akZYurXmZV6wtLcZVxLiu8wQL+mOarEp6qoUnadjaMCoxxziE4GxxVuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231165;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=tSYZSMfbWpn6IZacmi5pJPA8yJbsB5V+fFXDT86LYhY=;
	b=jBt6a6uunUIUxZPmdTXRmAs77MCmW+0vkjhTs8WLKtUc6yIz3kL+fOSq8j35ycIqB1cr
	 FzrhfQuD9gpKHLB9zRE7LVfcA2duN131bw9uDkH0qCS9tRY9QbeJW+1YUZbnan2dsVZyZ
	 MaQq4AeSIlgDzK2MibFXHI6Au4BFXjpRVx8j/y9t5mTXPJaZf4yssL/wdNWdiggGe4j32
	 TWKIbLOTWa4F9gfmXXGl6b/svq1v32A0jFRhhtA7sfzWh+JFNjXLv7FIGhhFTjlgbaw4V
	 h4PGPwS3AtLpOk4Os9M1wFtiFZdxasbgjO1SSSaU4k48MN1q6OyBRKVSGSbOT4dhCVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AuIEAf33;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ni3Rxsls;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C447606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 13:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C447606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AuIEAf33;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ni3Rxsls
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9DF17a309729
	for <stable@vger.kernel.org>; Mon, 9 Nov 2026 13:32:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tSYZSMfbWpn6IZacmi5pJPA8yJbsB5V+fFXDT86LYhY=; b=AuIEAf33+rrs+pto
	WYdMtA6ypYrroU5H+DcPWPiCxEkisy9TOauID34IJjIyEr1IcFCDznV+xp97ZBg0
	cenaQyHSTchsakwuhzyQFi+RsWZQAX2qIoLOn5mHQEHZLd2D+td42zrAjlWYMM8B
	Zm1TkyYfQZ05g32+LqpoBSCx4Rr/Dal6yDMp4UnWzTtvXpAEM/cFxS3TR7AiIwle
	k1tZ8oePfEtXHnffTZ+3q+63WJCUSHva8/dJWcmo4pZGMHWdDf9Z3ugTvmVYbpFb
	ZBCDbLVPn+Y6Lo8Bxhz0dPFb3OmasektxfwVEdWjvj0u513EONjM8yrqwo9GIRAB
	afBi8A==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucap8kpw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 09 Nov 2026 13:32:44 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5ecdc7807f4so30379e0c.2
        for <stable@vger.kernel.org>; Mon, 09 Nov 2026 05:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794231163; x=1794835963; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tSYZSMfbWpn6IZacmi5pJPA8yJbsB5V+fFXDT86LYhY=;
        b=Ni3Rxsls+XypYtn4S3ryGuFw1JmPGo13e/OTqhNLz3IQkNzIGusUOxKQApqlnJc9uJ
         VHJLAFwF4mDXOcXoGtA/6UDqbRozjQfXri8+h/f6zWr0bA43bO+nm/p32VXwi03TuAiO
         vJMbibwIn4b20RlOvVE/JIsAZbnNLhGmxPGQX6IY3lGR/kpjvVu1i3ravjeiBEPCGBme
         sAo/Ahajc0Jt31ErIKAAbGWwYOIcmLy7ZMqqHoe5FqDSfWQ//CwYH8xfLnFSdId/ieNL
         lSqiaUbUIbAc3+NU/bR2hJSxVnrd4JaMAvhhi43nGkMf5sxAUdGT4/NGGTaE1OT563th
         aZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231163; x=1794835963;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tSYZSMfbWpn6IZacmi5pJPA8yJbsB5V+fFXDT86LYhY=;
        b=AQYLRgp07NvcpaU/DJmbj3p1FW1no9ebfy0MPcG+R1KP4mEyWyMGbXY76jKOMv0jvO
         VdpmPI5AwCLAQ4eIlorHpYsWziRVfGok7AEvVFjkqefZ0DY1cGT/QTjhpBmmsldoaH71
         CspQQobnREzhONAtevveb6KUyol1satsspM1TNVkIUmtLm3h2kJ9P5WRa0seZuIUTwP5
         LYVZVIjN2YtIDchwhz/RgAs0SaBN4nQY36p7DHbLJroYGP25Ky1dgoHqQ+18+u+oB2cK
         RsHjSthsWsT9PZM+SxtSzyzotEp9cqRehYUPGhdAKohFvfxup1RlyfkGb0DkvZ/tdemi
         2Wdg==
X-Forwarded-Encrypted: i=1; AL+hErFEA2SLUUiQnbYx8mKs9pZJCdewSx/ay6yrm/Sw769h/SEOWKMCQqdzSrT5XywMmEJaFaCnzBo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JPTWWIIBjlMgclxAO6BGKQsong7piiBqja2KQWh8xcfOjH1Vg
	Zq9KofwQYY5eAETTwSMBW9xYrHRdFEwX0T+jiAU+Cm+Mc4BNywH8iyl6oN33BzQgho8mXW12Gsk
	EmVfnbqYIowUlHCWq2g9/y3g4lZmw5KefOOi+B1g/rCMdqGKx7ao0wnKyvXU=
X-Gm-Gg: AYBFou1jRf2Da9Tz+WLlVfWcrbjVysU1pyxMCRdRs/dTriD/6B0vU+GRoyWDFsmmMZB
	ddYKMrBMBC6aJ9UIuL9tM84nW0UjUzjTcS4/IcllyH4avRWQ+h8V6uioM3pv1MU4RNI0zsWuF7j
	3PGbGixsbTF5YELqLxZ9oqSn0wdwybmTgRnYIcU/mpzqV9NZaWvpvejg8Geu38Uf3o3RERufGxK
	3LkqaLRC+/a/PJWghQe248fR8wwlGuGZKhW39QNvyLlSkL+6NlqI0AF6WRENqkUZnVcjaYycUJP
	QHxuGVc1vnePr4rN6OpALbL+p02+JH21LVix39P/uFxg/RYwNCry0bNG+ncW31w7usZZQKXAmgJ
	R2XcvK5VhwZWtOzTdy/XwLrNUvUKxouFM1k+t367wjswyNBL3OvhNKYHd5GapcdDBErVxSQ==
X-Received: by 2002:a05:6122:1c9:b0:5e9:2e3c:2f5 with SMTP id 71dfb90a1353d-5ece7165ea6mr965344e0c.2.1794231163506;
        Mon, 09 Nov 2026 05:32:43 -0800 (PST)
X-Received: by 2002:a05:6122:1c9:b0:5e9:2e3c:2f5 with SMTP id 71dfb90a1353d-5ece7165ea6mr965320e0c.2.1794231162971;
        Mon, 09 Nov 2026 05:32:42 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a9bc2e2sm169621466b.83.2026.11.09.05.32.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Nov 2026 05:32:41 -0800 (PST)
Message-ID: <480582fe-27ff-4d14-b0c3-deab365a1225@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 14:32:39 +0100
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
Subject: Re: [PATCH v2 1/4] mtd: rawnand: qcom: parse boot partitions before
 registering MTD
To: James Hilliard <james.hilliard1@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Sricharan R <quic_srichara@quicinc.com>,
        Md Sadre Alam <quic_mdalam@quicinc.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261108-submit-qcom-nand-child-probe-errors-v1-v2-0-4a8704cbf7b4@gmail.com>
 <20261108-submit-qcom-nand-child-probe-errors-v1-v2-1-4a8704cbf7b4@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261108-submit-qcom-nand-child-probe-errors-v1-v2-1-4a8704cbf7b4@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1MyBTYWx0ZWRfX3H52qGqjOF8d
 29U7oduaYo4ow09xjtpHxssKVeZbf2tizIwAG6LZKUkoCOk5xHwcoSfUxMGRkySpe7U5mzVhAji
 cJBm/LoRaOJzecYNixyIVSPJaonRDJ4wNHrCTJ3M96AdoNnKK/u3ZU1pXFG5I78F2yQvt2zBsco
 npEuw/7SrGKmhz0JTx+QuSqtBKJrnbHi2jVOeQIX9x0fJsT0aEz3C+9Xqk/UZ8iuzqwZDv/ah48
 16MJ+Tfe/BQ09jhtCSmkJwjDnwHka3RSdJ9e/TxRB7dSa9VuohiWvcsXjOj9wZNJw/sz6VSNotc
 2nSW0ASoPlM66RMpZCTlli/sH5kwxYAgix7eNbhbf8yArroICVocKeb1SQkU7H/kwCnK2ylVKkE
 wFP2XtkMapLHz2RNHfWaYkZxDxBTbA3VJ4kyk9cY+DiRT9ZRdUvfWRTdtmP+CdnknbPQ6crqU6K
 pRVdw2boPWYX4VY8gNg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1MyBTYWx0ZWRfX2TMHWI0blAY2
 owhNyqjk/qFq/PxvZtGfzqj1hJ7Z13cv0nlSfVWwhUlUBKVecSP8Oct+so7eP84dQ3T4fiTOPe1
 CUx775Cf63xM/EvO5zP2BPYKsSZE4VI=
X-Proofpoint-ORIG-GUID: 63p0LNzML03e4Q544ADGS4TBUTg92dDX
X-Authority-Analysis: v=2.4 cv=TaQDJhQh c=1 sm=1 tr=0 ts=6af1cb7c cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=X9yRgxbac6UzRlJmAAEA:9
 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-GUID: 63p0LNzML03e4Q544ADGS4TBUTg92dDX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090053

On 11/8/26 11:42 PM, James Hilliard wrote:
> A boot-partition parsing error currently calls nand_cleanup() after the
> MTD device has already been registered, leaving a published device backed
> by freed chip resources. Registration can also invoke consumers before
> the boot-partition layout is available.
> 
> Parse that layout after nand_scan() supplies the geometry but before
> publishing the device. All failures then reach cleanup without leaving a
> registered MTD behind.
> 
> Fixes: 862bdedd7f4b ("mtd: nand: raw: qcom_nandc: add support for unprotected spare data pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
