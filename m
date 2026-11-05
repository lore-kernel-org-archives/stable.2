Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793866651;
	b=vXffJVfGibUYwAcfEAvrmcVQR6f0mm1Y0gBuPeYAL/lrkXacsILdMfRwmGnUgQrV0q4t
	 wd0cgT0A8xV4kCjv3vk+soqWJFFwoWuEaXsuyxqeKap1DmCw96pR1vtol1KdiG0qlhBKU
	 +b+Cubl9sZzx2yuyN+dqkrpjsuVNMQtP51Wg76/7ogiSJJFs5fesN+g+x0ryPj7iA/zHb
	 BPeciYxRvj104OvBtb9K6yxXTnwDXE8SoHLuR/B2aqc/jKQAb4fBX3dGyz8ky5c9Is2+V
	 yOphPulYXx8w2p0aSDa843xVVWTvTOA1dCP0VKNmJluzP7xjGA8kIObUG9cFxRcz3EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793866651;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BJGWFOkAbAvqtC9ZmVuWCIdXA4sNhgkQh3qqt15eZLE=;
	b=uoMgpPJ8woSWCwE9/C8cIcQ6z5N5NG8mfM+NoLaMBbWkF+WDUGll6/cJk68hAZ9mB6YC
	 dOHAVu5cv21u3DN3DmNGZLR2cCaJ1/NmwPuJk2I2KYNglmb4NIw1M/E17nhJ+OZLkx98r
	 23YO8GPvPtZO0zEUnrdVruSU+tja7vprD3KBSLehnuDCA6kiMXPv61OPZENgJXcNnryOg
	 uh9KwihpVsHAeF7W2AqaVDy5nCq8r3Rfjwk7EasxaBG5geWV6bNd7njlNHxwDZMAJEY4E
	 qQkvLixpja8rNUMqxbyTjeUwlShOdUkM77VLOGh53IU4nE/ZG2/ggmHqAqihrwVl8hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n5yEkUO1;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OWxloPAe;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB28606D80B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDB28606D80B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=n5yEkUO1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OWxloPAe
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A56Tock3223009
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 08:17:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BJGWFOkAbAvqtC9ZmVuWCIdXA4sNhgkQh3qqt15eZLE=; b=n5yEkUO1a3p8uX3j
	AmpIH1k4enZhmFn9bgq/EnLzLvIXZj3GwObapkpLpTr1qH4xdJubO/3IjGrGXD29
	H/DrjwtFdDSWNn4f4ggp5ZTq4j0lqMV+NQ6V/PGUPw0XtnTsMgJ4A++4a+PGImbY
	40fmVY4NUBLLo5BGW3gR/6fLx0kXmolH98Y3TrmeE2KHu/JH36yAK34I2V5AtMIm
	HSCiaxro49pxGM+OnVmzQX7TnlLtQXIpKGKJ3y1K2oNCFi/7sLQWiTMVmSZsKgkZ
	y3oHOA42mfH0Pic4cpuC6szq5cT/4D2qEqQ0rvmuy2uITDzqbSLFxe5tUKI8QqDk
	xz4VLA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrj43h1a3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:17:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f1440e081so43564085a.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793866648; x=1794471448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BJGWFOkAbAvqtC9ZmVuWCIdXA4sNhgkQh3qqt15eZLE=;
        b=OWxloPAe1vgJV2Ooner+Jk40SD6GR3OzR3mBkyYRXUI2c+RcbIXQiJBHH99SrKrz1p
         KFFj/G6yQoggke43zckm9+H4/ITM/Bw9CxtSRZLpP4RK4FRT5nnEjp0dCtdj+y/Pk3L1
         e1MDd1RPPFxC/a49zx7qvgqBOCXRh4HUCp4F6IYI1iRGgCvOZluq04Q0+5XZXWmNKS6U
         5M55U8i9UYBMMJV5iikeCvZp+PXhcqg2SFHjZ7TEfuoP5oXMhPVdMwpIKIu6fqRB/ix0
         AT3di7OJhT1ygweT+jSBOTfPY7WjFz/9afbuhH/FuaSqSLF75GXzRe+xrkrXdnfesNtL
         8l3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793866648; x=1794471448;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BJGWFOkAbAvqtC9ZmVuWCIdXA4sNhgkQh3qqt15eZLE=;
        b=nPjw5vmahMlIva+FRyTHcvVUZU4pZnHkt0rRIDGvtG87oYw3TOrOZsFMOdlIkrAzcW
         /46PjRZJ6R0RJjqco9OKy57Cz6TC22eBXXg6JVMNMqywCxIB2QYS6/7bAvWiKqC4yod2
         JxB1azMp6nh8pipeefvpOkBkVFbeOnbDUy6PMGYfq5Z50/LU2CJkoXZ/yWaJwAVbdDgD
         eEw7BiFwloIqPd6RVE84Hda239/36io1F6NMOmxwpZ5GAwHfCygsPIkYZxFNa3b7yPeT
         gh7zAVu8luvg66og11jaLSzA7CwMYD7YjBnyF70wB423BcuO5oQXTTgd02+iizh6U7Xw
         1IDA==
X-Forwarded-Encrypted: i=1; AKwUvBx257jf05Tg8+hFVW5FMH3H73IWUNAqUwvnbsnrmQU5SvntF51U3WA35xQkf9FQ/4u2JQzVocs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/gtu3iK5cI3wt9QI6e/Df/LFkOe9NK42sUL2ouoKG4W8p4CyJd
	7ErUkw4ibvHwYtbNwAiEL7e+bT+0qOEvqbCW6XkJU2p7RybyGYNo22Ex2XGS5ywohZAtmRgD3yH
	SBBypHajBveI+2NyI8S5Uh7oItwWokktZQKtZC61Mu7npboNY9ri5aafSjcs=
X-Gm-Gg: AYBFou3aK6FSd3WcDhRd9rHNcwJqFfTec0G701nkdZ1Mh1JXqzjEeqQttYtWc/lAjnZ
	+MqZ3D70+m2JCyzpHn1Lfm9Uy1x5y6Ib2f4Ygn8PkJ0Srl33J01kZ6lZugvPqBjLtaolBaTf7DM
	Zq5e/fxYlInKCNw9/lYv6PtZGqcFQgmSfGS/08CxVXwyeXXH0BcgzvvEI2vALuhPF7u2WZd/1Bt
	5vbsuqLjMl1X+Szwokf10V5maRK8UBBDMyNUDb4xQcKs7WIvobRrKVjBaHGvS2EA6ji4vard7JS
	gOw135ALtgdU0njOYBR/3C2kMhwhJFpHajxz6VYupM4LDNt9ekenQPhDKxi/ay8JJ7JLdkZkkC7
	G+hzrcNnCbshwG2xip2ZELCNXXh3LElm9kDKlv8ycxMc/EnqanmjMlQurA72iEWZUYD3Y
X-Received: by 2002:a05:620a:a40e:10b0:92e:6485:f640 with SMTP id af79cd13be357-94421762860mr3088642685a.4.1793866647935;
        Thu, 05 Nov 2026 00:17:27 -0800 (PST)
X-Received: by 2002:a05:620a:a40e:10b0:92e:6485:f640 with SMTP id af79cd13be357-94421762860mr3088640685a.4.1793866647490;
        Thu, 05 Nov 2026 00:17:27 -0800 (PST)
Received: from [192.168.226.1] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e4236basm148809766b.26.2026.11.05.00.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 00:17:26 -0800 (PST)
Message-ID: <b9bc095b-e22a-4965-937a-0e4f9543f874@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 09:17:24 +0100
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
Subject: Re: [PATCH] soc: qcom: cmd-db: Fix probe race with possible ERR_PTR
 dereference
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Haotian Zhang <vulab@iscas.ac.cn>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261104151550.215604-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261104151550.215604-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: e3p1DfyKrr-zTBKsu-EvBkfhXk95j-lG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfXw8hjusgXL8Au
 zkyXjazLigaXqMEOdZZjm5j0wA3HIRi3oTtrbwHy25+UYhKGdhhcnwTnx3b36icyAc8x7EE7hFU
 k1Lc8l43Pamhc4VwxlJ98n6mXSqZz/B3vqN1Ya8pmvCYhpBpoJdFcosxSuiv7IOmlL0d21rYAEz
 G7QMaJwrWrpNzRsCu0IUhxsLP3kgHhUBc1dQPaG55tW1VMgOcmwqtl6PdnIBza0rTGDmSjOqe+X
 PwLEB9BTfSNUYmfvJgbG0oPCSdxFGMK6XnKynD8xskThOsbCPjoeyXU2t5KURYP/ntPcxvf9QhN
 GDW+e0CuSm/cRRpMl6tk7OH7ifG2dz2p8UxpCiLGjHk3IL1Bk7PkBflOsCVx9VeJx0alfj+o2m0
 yaQFwWusQMGpUXJtoab/cYfj5xGBIRRcZaoSLPbQFnnLBmdfNTXIHrvEoxhied8Aqi5R10+n/rX
 cD8gyeC8/CXiLWeK33w==
X-Proofpoint-GUID: e3p1DfyKrr-zTBKsu-EvBkfhXk95j-lG
X-Authority-Analysis: v=2.4 cv=SZdi5fRu c=1 sm=1 tr=0 ts=6aec3b99 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=h-WqzLMcamjAHn9wFlcA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDAzMiBTYWx0ZWRfX9MHwL1koqtuX
 tKCSfi9KFXA27reO2LtuvDKcOPEg2HD98aZMxqhuS1wXbSSR3Qh/H6rdHSdQOOhurdWgdQUPjES
 SMFr2+VVzC5hE5DvAvPG5NylkI40ybc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_02,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050032

On 11/4/26 4:15 PM, Krzysztof Kozlowski wrote:
> cmd_db_dev_probe() stores the result of devm_memremap() directly in the
> global "cmd_db_header" variable and only afterwards validates it, which
> opens a very short window where a concurrent thread could access and
> dereference stored ERR_PTR.
> 
> Theoretical (not reproduced) race condition could look like:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
