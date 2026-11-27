Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795772998;
	b=iKFxdZRPzfvodvhX+LxaYNIbieNYsx0OybApxf0O0bPHtXVJjsS9wqdwfsGuZmsjlJul
	 Svq2qDnjy4Vs1liiLBV8qClOHOcbO/cw5g9mk38ANubIjglnIOrN4+2cPJ5oBqtZ+Wuw1
	 xH/5pugxthoswSl/4VoDDhU9L6hAdxUheVVLh9CTHrEr1zvVkE/8eLe0WBvUltQmHpdzM
	 fLdEfrD2dZaqgOlyeLMIML7YXI7VD/mTH7K2+P6O/Xy3EdG+oxVDBKwDKjpZCu4ZRZCUV
	 cXHH4eCYp0+tdBXW282k/vmJpCn37tW4Y9NXtb/BekFxzIqOc0Nmgvu04/u0HdNn8oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772998;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=c0Dnai2mS0jKW2gFMXtdOeHQc3Vgz+AH8UmEJxjmLmI=;
	b=IG0QKawObNQUhPHLnOZ55Vtcshk1J1BsNJmjtRVkdVotbvoWW5NAAOOJCPhMz5XvNnzE
	 8oLJt5Fmq0UPlq+q4wVKigSBhu9NEeREhXSIXVulH9a7YL7ZCYEnm638XG4w8D4acybRr
	 wD6+IBeR2UGmE28G5v8GWvp4GfXz5PmFU9AG987QovPPmcZNO+OduuXku4pedNLiIf7WH
	 gSryOOSarnM+x6Aj1g4U9wEcJgjGGAOpQL1+a85bycYve81UQsWat6+WoiRaflhk8pJS+
	 u/RwXvcVKcSITZs+xvMSocorYNOeP0YElSrINQbyePU57U2Qh5yYpwnljtcwjRAS8Fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=obfICoDJ;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f9giYd5x;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E23606A687
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8E23606A687
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=obfICoDJ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=f9giYd5x
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7GYCB2188181
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	c0Dnai2mS0jKW2gFMXtdOeHQc3Vgz+AH8UmEJxjmLmI=; b=obfICoDJxgCSIHVq
	1H2m4OsJZmwrrNOkmSyZ5PCFuHLydF4UHCKinlEo20WiN62lEXqg8fCrjE/BVyRL
	T+SLXWOy8Z0j18JjAfAvm27SoQTXYpUSbb8bmYvHjSRTDL9E/zGTDF7lO79S7N6t
	P4H1x1ULr5XGWIdnr6qI8v5aALiTNCgFnldXX4WlH/lEkCLQidFYyBtMZhIIbpIq
	yPxi1NMbVXXIILZs4rEbm0Yj3P2OwMYwpOesSv8+UCA7W1sDdaD+/rhtQJaF2LXl
	BWjRYP8hQFzHaHoTOySn1+/zh1AGahS5F9wMKKynuLSQImyYJzqgIq/E1kwnJCRD
	soScFQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74gh8sv3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:49:56 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2f053f9631cso94968765ad.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 01:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795772996; x=1796377796; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c0Dnai2mS0jKW2gFMXtdOeHQc3Vgz+AH8UmEJxjmLmI=;
        b=f9giYd5xDCxK4f1w5/qTkfCdb4CeHpi8ruUnxzcVpY5nNmQRBB6EC8meML+tuGAirQ
         Lj3TpIFKOmdGGMSUKr8gspT45PCKPxYAtJ/k6Exei5moJDAZPY8QCzjDF7rSDsij4dt3
         RkOyi8XyModNrMyHl4NB5qnfjdSATuJmwRdnYSyHtoSINhVFESguw/5KqRobLSA+b8IC
         krzJU0g6n3n5Z1bXoRm/jRlJn8GjjOXP4Co6JxoZpOeyvs9Mp25pMV9WfSnwD9FulIwE
         v/hD3ZxPZQkR5yAzP0dYYfhJFEZZoP6hiKFpchX6DTRpjsn7mWvs5IO7128d8ulTP+Tb
         a3Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795772996; x=1796377796;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c0Dnai2mS0jKW2gFMXtdOeHQc3Vgz+AH8UmEJxjmLmI=;
        b=XJ1lFg9ksroWzEcwzuc8O5BDHJ01S9gaDNuX9PIDsPzOSmIzeev4Hk4QOSUJs+BEde
         xO5d2B18PF2UjNygenh8ItU09rw5fnF7tVUHDdiF7eWxp3r0ZBpI6342wN+SEQgFE49w
         NNh3aOsiG5YZym5lI18sOw7sdpgVNUgreUfeEOdWXa2SS/ZA3fp47oVq91QdlEtzPuBs
         JU+hanylPBUDvJyG93IKF0GkQZOv87DUUulBchmZ7qetgBKWDFuTDHvD2ekMVu/oTPZ3
         yipm+9NOf/drnflkXtuY35LjosIYfFmL522pD3Gnb7tI3mNOdidTt0H6TsAWTKFK7FOQ
         KXyA==
X-Forwarded-Encrypted: i=1; AL+hErFmZOsNL5rfegAaJHXKdeb/405CHt3otEg4NrBscUog/lBzCeKKPUz+MwASRrs+/lgatYHdnDA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NhT5MVj7/BGAmRHURreyPhhpOsZSw0Su5G+TImoWMIU3s6wk/
	DLwLX2/z075Y1qTjEscZsORvYg9DeB/LBsaL5aRPvkb5TC9iVGiv2htoe4MO+ShdSz7Rq/DiIqu
	vWYjf4n4qv6JS8rx7dtDkFZC7noqJq4NIyEfx60FQbruddPs6JzmpCaRr6xk=
X-Gm-Gg: AZFdTZdXsLYUjFm0uZ3sB8+Uh09Ls/H/rivOYf5MOJ1JqbETZu6oecBjnRxuvEE2dzw
	XK6XleP8+6QKMw+Ik1D6368MiM3dvkA+zkpEkTJPBeMA/pcJo3rxueAtFaUTW6Km2jUjy3ntfQi
	Dt4iLqosaU6u2tCoYfklxN08oAOATBL7TZyPbKL9PMkD+87nWQ4QJ3DEXKzJZ+b7HuCtHKk12kW
	ZE4YezuG8PpLqS4ef+mMMct2086Z4Fn/qKG/ND39lv3HaFT6xnOdDNkZjcIB4fd3Jzz293BjYnh
	5vsENFRnq+HVui7TGSQytTKrbhwXmcJFVDYJAWZNXLmlxIP0uSFrW1Gt/+izy83lB6Oe9SCudh5
	bezj6LDCy+zUGs3n3MoeRfsDStKwdo86bNFlVBtrEJIKl6SJq5DvN5bVrmlJqsCEnLW+LnVv1On
	xtuEm1NX8rAdZTzBxmZyuwCALVVCly6dT9lj0tUgsIXJxl3QNyzvIQHZL6hhrqZKRDlCbvvn8dj
	ErF
X-Received: by 2002:a17:903:41cd:b0:2ef:efae:e8e7 with SMTP id d9443c01a7336-2f03eded341mr252338325ad.0.1795772995893;
        Fri, 27 Nov 2026 01:49:55 -0800 (PST)
X-Received: by 2002:a17:903:41cd:b0:2ef:efae:e8e7 with SMTP id d9443c01a7336-2f03eded341mr252338105ad.0.1795772995384;
        Fri, 27 Nov 2026 01:49:55 -0800 (PST)
Received: from [10.149.108.218] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f147a9esm115916895ad.72.2026.11.27.01.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 01:49:55 -0800 (PST)
Message-ID: <917776ae-ab75-4f81-93c3-7e359641cb1e@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:19:50 +0530
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
Subject: Re: [PATCH 3/4] remoteproc: qcom: Fix bounds check in
 q6v5_wcss_da_to_va()
To: Atul Akella <atul.akella@gmail.com>, andersson@kernel.org,
        mathieu.poirier@linaro.org, sibi.sankar@oss.qualcomm.com,
        quic_srichara@quicinc.com
Cc: linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261106184312.100-1-atul.akella@gmail.com>
 <20261106184312.100-4-atul.akella@gmail.com>
Content-Language: en-US
From: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
In-Reply-To: <20261106184312.100-4-atul.akella@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzOCBTYWx0ZWRfX+LTYjh6FyuTr
 D21Y4pN4W4qJ3LhyKWQ0XZjzOlBLXxnyrr2rCZUruwyB0MowiCciO0iCm45dRHdZV1AbTlFz9JQ
 gSSBG8ZwONFZA8LRuYRCR2W0lsHW9Nc=
X-Proofpoint-GUID: iKeDo3tixQeUDc1o2RvESimBIKpIKgsX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzOCBTYWx0ZWRfX6hknH304y7Pa
 civZxAB3UGiSEdwnTt6ug9R63Zlq2NcwCdoJZaKMTVig3gF4SE8xs6d0P9E/0pk8lSZY9PzzcfP
 BAW5I7Mg2E+z0ss/dBrCDjIv2NRllACIqjQ+gdioxUZqSX7o65VEswv4NyCBEquh4XDe7OUX9Vz
 3+geTJDl+EVypecaXEXo3x3jR7cJVowR3uzNEFuMJy9a4gx0BR1Xp0z0Np8iBPxaR1R2AE433U5
 /JLKL3WQxqnx8Li74W2cDLxObCX6GCOrUWwbW+mhoDwK22HNqdu/hen9/NB+hDQUt58Bdbd6137
 KqccF5nUDQl9KXIw/a0pQjPEnkZtvYiDd+gLw/dUbEncRtF32f2Eub2Z6SjZhtkqDbBNyl1JYNn
 dm+bpPirToLn8gpNE4FROCo7BYnVa2lWFaX9shKfBba0IE5kt2EnuHznr3pG4kxjD7RB/Ws0vUF
 /kcsKB6JDcYpsise2RQ==
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b095244 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=E4ycadI1TCjYcBWHacUA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: iKeDo3tixQeUDc1o2RvESimBIKpIKgsX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270038



On 11/7/2026 12:13 AM, Atul Akella wrote:
> offset is calculated as da - wcss->mem_reloc and stored in a
> 32 bit signed int, while da and wcss->mem_reloc are both u64.
> For a sufficiently small da, the 64bit difference is truncated
> into the 32 bit int, bypassing the offset < 0 underflow check
> with a small positive value. Additionally, offset + len >
> wcss->mem_size can itself overflow when offset and len are both
> large, providing a second bypass.
> 
> da and len come from firmware's ELF program headers via
> rproc_da_to_va(), and the result is used by the ELF loader
> to write firmware segments, so a malformed firmware image can
> cause writes outside the carveout.
> 
> Rewrite the bounds check entirely in u64 arithmetic. Reject
> underflow before computing offset (da < wcss->mem_reloc).
> Replace the addition based overflow check with a
> subtraction based one (len > wcss->mem_size - offset) so no
> intermediate sum can wrap.
> 
> Fixes: 3a3d4163e0bf ("remoteproc: qcom: Introduce Hexagon V5 based WCSS driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Atul Akella <atul.akella@gmail.com>
> ---
Reviewed-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>

Thanks,
Gopikrishna
