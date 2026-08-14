Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7E353A80
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786685386; cv=none; b=sPy0GbEP3JCb56aa0XeKj04S9XssBUudskcsrz3C9x5H2Xe3lzkcM3O9qLj0mgkj0tS1LxokJ74Z22ZN2kt8Eqw/ULxG5b5ZSVv6X6fZFmpt6lqXpSUfI/g+RkszNzQ7P8mCZeab+qQDeNO4Q8+loKBGYV9yc2o1KaRCCYNfeGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786685386; c=relaxed/simple;
	bh=2n680nI1lYLXDSKnF2Drtq6F5MjNALsTF9iACEG9iGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mm902IGb6+13eCiOTXj8nZT72ahxTkJs2Zxymgh22zoP4XVK5IzGXr4viYL9AgxCo1zZ27I7kO3yfJMhzbg4Wx0WmI4ghsgbOewOM7gIjAh5kIKIjXSpb1zCQkSUIid7mU7DWrLEpzrz+rnGucWV7xK3+qEMyKK9rXRVAZl0DLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G7H2iHLe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eIIiodOm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G7H2iHLe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eIIiodOm"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67E4QYIQ282902
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 05:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2n680nI1lYLXDSKnF2Drtq6F5MjNALsTF9iACEG9iGE=; b=G7H2iHLeUvMZZIXY
	gX1DFTdJG7B5FUxQE5nWZ2YIVdX6IyHzxcayvMaRrgl3tuMoutbT/zfLDvdtgwtO
	smZA5Bk7UQQIwgzBop6J7tqzpCdKfbr0KAgR6Pmv5sIZ2OvntXUimJ8T8ED2JEiQ
	T1k7bT0fDeNEYeeRRKmeGDPxQQFmIp3ZpypZ1b+OgNo38eAF19lBj1/a+nYqEw3N
	ztVK+3nF/pu2QGvsVhnZCqdK7z82pDwgyT3TltzZG3CGN31xHlSaSypOHQxvMa6x
	Zuo5b2ASFVQcsWozLNKBwYFy9pmIbGaNrgg7p2vMLqlBIwVeZzJcWU3s+JUBuW4c
	HzQL6g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1h90tq8g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 05:29:43 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbedb8673ceso417973a12.0
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 22:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786685383; x=1787290183; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2n680nI1lYLXDSKnF2Drtq6F5MjNALsTF9iACEG9iGE=;
        b=eIIiodOmLsW3rdpZgCuiTVoF46TlhPMVtfmSMYNSzZnXwWmHFJQ5HZyJ0eOPErzr4T
         cMen1wmtOvWlRUA6NZ/GOhp/NfwPwbpyNSpodfjsywIav4Wo7FTdSv6lGDM7eBdOv+Q5
         BbJu22KpHOOfxQiMt0B0qUsSUTA4yieVYqSHe07mJR0JjyObpj7eu6BN5mx6TUDR0gZy
         TGDIVKClSgdseDNzxmtqgyU4di3lovLnixYlnaSAkeyan6e75x+YQ5jqxd9eDpsqbE/4
         nOae50JRXmBmyrqwg+2UbP6rDxs1Z8ZkBMAdCN+UE8VHj5kyyTHU7OEmPiOVUwH4mf8a
         JkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786685383; x=1787290183;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2n680nI1lYLXDSKnF2Drtq6F5MjNALsTF9iACEG9iGE=;
        b=JeuvP9VLgmxzjGHERSk7ljITq9BDXSCh60vres8CMHvF/7JvMsc1fVyYHR64IHHWDN
         d56u0fE/56dxasJ/ella4EKCcDloVQoBw6YrgEcqowJvK2tRA/F/3w7S9cMRA7CfZxpq
         ea+gK757o9vyIBrv9miLiaLZil6XqIBlfLS6Xbl5P79+05/BT2Z7bPHl2/EqMC1BS2tf
         nfWLo6SmGnWaPkX/XCzOQEjORd7arWqdN3cXlQQPXUQwlJsnBQnEp0UGI7+/LMoPhD+l
         +rvHTD6TpMoZHNUCb9dOFjjl3dxuJ3iqXub2j557Ng4G0bGwawoBrZ71IfjabGd52lxz
         lHTA==
X-Forwarded-Encrypted: i=1; AHgh+Rp9nD+3pDD+BYIXm0wFnOic87rEBcXIT5zK8Lk2kIeAC+yMd5MvBjqJEorXwnGQuihLyrIztVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjMYC4TEdvEA0ZhDXkQ9lH/d2NhRRghPdAfTGck64UMtJP7S4v
	HTUFt69rLuWOEa0+hZq47k2TK9n+1EA5qwDXfh3Mf61fKbZPaazmUkFlPOrUStBcsvyVOCGi3uZ
	UVT32BrDRDNSo2xhO5Xsif9gs5t2yZUbyhSfIzLGskk/xeMhe2AVjbEK5Hcg=
X-Gm-Gg: AR+sD13z1Zq9Hcin03tGpurghI5PvCxo9uA0smKRiLCrStPOXPLE4Mmnaapd/LiAL+q
	d4Nvi/RfN4yER/6uFGXGFwqVIFNfQJZjTXpGK0ppPiVo/wVb+F/hvuPpyaFWnj0k9h3yt3TQwin
	DSTyUCPMJvCczTZg3YPgil5MtvNSrof9leZFqWhF2q0SOaVXFF2+Tz7wwn5jrjvaOfoohd91RTp
	hUhuD88BYrKW8b/EAhmbffbTAKCXHwu+p3P3EVIq+X7o0BAy/DlPnZByEeHmiq/j1EI76EdLCrq
	z+HBGZu4RfFx8t3GF7eOeGs4sGL8y0LVZcc+Z3XrlElwdhPDj1sAQGcEOR/UIzIUNSl5ddbIwzx
	OxoYm6CJVKeSIgu6Rk9pxMetxvvlOUXoh
X-Received: by 2002:a05:6a20:12d2:b0:3c3:9746:1fcb with SMTP id adf61e73a8af0-3cc71dc524bmr3468881637.35.1786685382678;
        Thu, 13 Aug 2026 22:29:42 -0700 (PDT)
X-Received: by 2002:a05:6a20:12d2:b0:3c3:9746:1fcb with SMTP id adf61e73a8af0-3cc71dc524bmr3468828637.35.1786685382278;
        Thu, 13 Aug 2026 22:29:42 -0700 (PDT)
Received: from [10.206.101.140] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320d61e1568sm56924eec.11.2026.08.13.22.29.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2026 22:29:41 -0700 (PDT)
Message-ID: <4b34e718-0878-25cc-a5bd-0d8858df5133@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 10:59:32 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sc7280: Add dma-coherent property
 into venus node
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260801-iris-fixes-dma-pseq-fint-v1-0-aba0cb22f6ab@oss.qualcomm.com>
 <20260801-iris-fixes-dma-pseq-fint-v1-2-aba0cb22f6ab@oss.qualcomm.com>
 <20260813-frisky-augmented-crow-fd5d3d@quoll>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <20260813-frisky-augmented-crow-fd5d3d@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Ovh/DS/t c=1 sm=1 tr=0 ts=6a7ea7c7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=2wY4_1yd3szzHPvr_iMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA0MCBTYWx0ZWRfX2V73EuaewqEc
 U2YECIrV9JYKT4cuGkOjcOb/yq8zlxtFnEOahGg6kh6SvYhr0hYgngSRIrisycwHhuQPFhBUppp
 9wbVC/YhzXxaHcGB4aHthtAtK4j/QFQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA0MCBTYWx0ZWRfX73/hlHtDKgbn
 tbFbioCbhBhj9zg5GbSAvBCZ6B8AA9UmZrU34Q1AvIdST5rYMyIqfapClCPPgnosn99RO4Opua2
 jjBw+ya9Gh+hpdkeUWFK3w2lvGbC/3NB2Ut4ALgtN3zWzpw6nhqyk7CAoYAR5bZJuC8vON46ArK
 lGY7ydbiH1jtn/3yv+HR4/yvq1SMxkVjxtaR4vWP3mziAiUzZkrkwdsTyULe1u6bwN1GIGabnfU
 f2hKBtNNBd4E2lKB2+flvZ8AGyo6LYSjhV57QvZoTqRhg1tzZdvC6l8h91MHNu0dA6V1XO3+ei8
 edtbnHy9C9GofGrevbgXEsh0+VpNhKYXpRWKGDpMvgkV3RuGvXENltE7ZRnWj900hQ1HzrH4Tce
 6xsVcGGtuahXvbB58/Ui9qbJ8OitPFRPgkSY3N4eTV9x1O/LmCUlYAjT3EbussuwzkBzriaGefy
 gfi1lTrIzh7YMpYlfQg==
X-Proofpoint-ORIG-GUID: _Vgo-_Q0_aXjwjPAO-9blJukPs_Y4uO-
X-Proofpoint-GUID: _Vgo-_Q0_aXjwjPAO-9blJukPs_Y4uO-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140040


On 8/13/2026 2:49 PM, Krzysztof Kozlowski wrote:
> On Sat, Aug 01, 2026 at 01:07:28PM +0530, Vishnu Reddy wrote:
>> While testing with some higher resolution clips, the venus hardware
>> triggers a fault due to wrong input data being received. Corruption
>> was also observed in the captured output when the client dumped it
>> to a file.
>>
>> On debugging, this was traced to the venus node not declaring
>> dma-coherent. As a result, DMA buffers shared between the CPU and the
>> venus video hardware/controller are not guaranteed to be I/O coherent:
>> CPU writes to an input buffer can remain in CPU caches without being
>> visible to the video hardware when it reads the same buffer, so the
>> hardware receives input data that does not match what the CPU wrote.
>> Likewise, on the capture path, data written by the video hardware to
>> the output buffer may not be visible to the CPU, so the client reads
>> stale or partial data, resulting in corruption.
>>
>> Add the dma-coherent property to the venus node so that DMA buffers
>> shared between the CPU and the video hardware and controller remain
>> coherent.
>>
>> Fixes: 37613aee2179 ("arm64: dts: qcom: sc7280: Add venus DT node")
> Really does not look like a fix. How skipping a cache sync can fix
> anything exactly?

dma-coherent tells the kernel that this device DMA path is hardware-coherent,
so the SMMU maps its buffers as cacheable. That attribute is what causes the
coherent interconnect to snoop CPU cache lines on every VPU transaction, so
hardware keeps CPU caches and VPU-visible memory in sync — which is why the
dma-coherent property lets us skip the unnecessary cache clean/invalidate.

If a device doesn't support I/O coherence, its buffers would instead be mapped
non-cacheable, no snooping would occur, and the driver would need explicit
dma_sync_*() calls at each transition. Venus on SC7280 does support I/O
coherence, so dma-coherent describes that existing hardware capability to
the DMA subsystem.

> Best regards,
> Krzysztof
>
>
