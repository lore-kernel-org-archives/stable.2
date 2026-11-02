Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793615478;
	b=Wu111wC06fqtfWPs9Ko4uDYX9q0c0NfguPPFM7ejxTmgLiVZW4W5YHy49P4xkXzLw1ED
	 fv2uQVo4VN9nPqZ/OTMe4uP3CuIj8YwnVsQPbfGv6G3vwUeSOKkp1kALyvYMRN3dGYSh2
	 rLwSpI6p5RSB+ojLqD+XrCeX8CaGB8IT8Zm+S38ZTRxDz8NxZpbhTdTksV2kSJFDBegE3
	 zdDNsAMSiT4jVb1GP8Z4NfMNJ1tkkyvcW0At6PkQGfUuCUt29Yx8Qz6DfCo0BMFU+LlES
	 Bizwib9HG3W60FgNk8kPEghoZez/GqqvvPKO4qGIfOfGcXeo0F5teNOda6RvTR9dN1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793615478;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=BD2jJ7R23UELXBejTUvUKCF/Tie5xKv0KES5hJVghpg=;
	b=BQfeyimJJFU3nuQWC5FiFD/JTDanGry0L+vXGz8+xyL9UaY1FUhr9YZN4doCfIcZBdC1
	 rIL5qVnKwh/fWXmzx7/nbftFYamIZHxWoIcbqNplbhVax63Zyii7ZabEb3lR07kwAaIPw
	 8amON3gswdh81NFabEBCOh3ERq6SRNY+ziYo3ZVdjgc11rL6pH3yXfGFde9ztxkcv7ue/
	 f629mqhjvyYEyBI1Ly4XQ2wNhSZeqTr3H+CmKlgdtDS9iIKYUWNkHhv0lQPj8J8aTYXdR
	 tw0ur9jJAecZculL8jfrfp1vrovXr/G8EDVwF8HWtlXTl5/PKa2GfG6zGZqjdkG6m4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iqOy0Qxh;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aCP9IEZJ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733BA606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:31:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 733BA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iqOy0Qxh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aCP9IEZJ
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29AQRa3440462
	for <stable@vger.kernel.org>; Mon, 2 Nov 2026 10:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	BD2jJ7R23UELXBejTUvUKCF/Tie5xKv0KES5hJVghpg=; b=iqOy0QxhOCnKNBdb
	/Rh6UyYWPSeiPz76xCjfWUaNc1iK6XbqnFzicpEoMLn1OuC3hZKuC0tNztnd9/B0
	PlvyYYjvjvLtrAOIA0VfMjrcUvp3ndTUlyauhME0PPPjRcZ8MDTtJV/pX8VYURAn
	QIxZFkwtM/Xn8pjfgOA0QTvCrgBUmoTd2RHYmRdBnmRIrAsj+lq9VpPCx8CTyQrp
	v3dt7CsCODBmt1bmLjd1CXKa+lgauQzbhH40OhNhMmiy6NDfBz2YSpVzHLaRom5b
	Sj1hLsRUPwhaIHXuxRm9sPLo9B9EMpfk3iFFUOuAOYvBIOD6gSiH17Q5ug6EhyBb
	TnNCrg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpg201w8s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 02 Nov 2026 10:31:17 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f1f1f2ecfso47720385a.3
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 02:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793615477; x=1794220277; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BD2jJ7R23UELXBejTUvUKCF/Tie5xKv0KES5hJVghpg=;
        b=aCP9IEZJ35thTu+xxh/A0nNM///k4CWeCfLgntDzgzRdt0NKakkvUMCuAT7NoaXKoY
         6OcNrlkJPVNPXMvzQ+DrfCrgHJT0eegx5NBGti/rrBQeTzNKlnD7kTPxW5CX2tgqKaAG
         XuT5MxunhN8We95E0PPOoffzkjv7S5us9iwdDqmYCrak+//Z1CR+dZHhvHH3wx8ICk54
         D/hScTiiHpXddkTQhI0GoungCMak2Dq97FyZ+/O5bilFXgcPdeT/MUNRbsI2qCDg3f3f
         +Bq5/tPBNpQ7wm1pIl10Nw2hG8pru8I2MyjBUt/m8MQXxglbpdWJbTqBtTR+DEcD4hoN
         mhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793615477; x=1794220277;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BD2jJ7R23UELXBejTUvUKCF/Tie5xKv0KES5hJVghpg=;
        b=DU47Hm4vkQS4vQYOEzNj4XFKxsTw/JvzeXLoU7YUsUk8WJRS3qNpraFTdJIREsf/lL
         sKxovps02aAkH7UO4SngB039HTGW0jttu45MSz9TP5p7Tdep16doK5066kuDngFCMdXw
         AmEJIRVYbQVFgKrWsXQqaQ8ypsnfm2hUN2pg3J/nCEIunfPItKRB9DOdRbROk3DoQY3N
         AA3Q0Iv+WG4Um5Tg43Ywq3O1lr3IyGQU6+w/yJESgYzqPHlbhLcghzrNb+OThbc/qKoB
         KZEIQfK5jtBSpXdEzSIIP4RDMrQmSvPx1EzSft90Em2n7Y1wnhniARwMzDoOd1FRIH9X
         uMVg==
X-Forwarded-Encrypted: i=1; AKwUvBwNiEQkU8ndQKb2Drgoqq1Gr4bbEyB6npGdNwk3tVi7Ir825xu3ybkVPNJfJiwSHukGJa4ZgrU=@vger.kernel.org
X-Gm-Message-State: AFq9FYIC5HjMyTLubnixuzLDK6UvIcGieN7nNZkc5koYx2bUT2G8AR3y
	9fmzFMPNcKCvgBhD6BaMdiniAGRH2E5u38kjqV+qvOWoNHhNgyFgo960L0vAV0eK9FZ73WKxj0o
	+s3xcCeE4BvEaXDu21XgKEJxvL99cDTqmPlWzF5b3JXU6CMBq2c2D+snb8ZA=
X-Gm-Gg: AYBFou1vyZtnxS5in5B02y0tCFCZWD+tJzXu8GHJYv+zlAFL3PMB3fR/ESjFAhIEuvT
	SIfSlOpLVaxRXZ9sIdEdxqC6XzmiEtPI7U6Nmxon/+1/NsrqChb24hGb/8fekfYkaNlf9S2YDOC
	Tl49PtQb4ZE4bKVe7im/+Fv/L3WoNcR9TWxfcCNrkrGLqd7B90uHq/IqijqA693XI52CyQgw24A
	xxjYXSyzGs6QT5iWHgdsnR4OqladO7NsbWOPQwGwcCY0s8KdSW/9NGVVzZLCshnfn/S4lPeqbUq
	N8k81T1x/oKaK8ha3Q5CLZ127x8EvOXq7Cryr+8cphhnVlzpNQKV038XX3uAcODojKKISXhLnyw
	mQy5nUPFxsiT4gx43+C3C2XatovFtj18kBScpaxFO6bJOuHu/4NXTgdd+EA3yaXWhgdrBGjE=
X-Received: by 2002:a05:620a:72cf:10b0:93e:e111:2771 with SMTP id af79cd13be357-94421619197mr1550883085a.2.1793615476650;
        Mon, 02 Nov 2026 02:31:16 -0800 (PST)
X-Received: by 2002:a05:620a:72cf:10b0:93e:e111:2771 with SMTP id af79cd13be357-94421619197mr1550879385a.2.1793615476113;
        Mon, 02 Nov 2026 02:31:16 -0800 (PST)
Received: from [192.168.226.248] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabf428f1sm367117166b.86.2026.11.02.02.31.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 02:31:15 -0800 (PST)
Message-ID: <01e57cde-a18e-481a-8b4a-e38d467b39c6@oss.qualcomm.com>
Date: Mon, 2 Nov 2026 11:31:11 +0100
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
Subject: Re: [PATCH 3/3] soc: qcom: smp2p: Fix possible out-of-bounds read
 with too many inbound entries
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Andy Gross <agross@codeaurora.org>,
        Deepak Kumar Singh <deepak.singh@oss.qualcomm.com>,
        Chris Lew <chris.lew@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Sashiko <sashiko-bot@kernel.org>, stable@vger.kernel.org
References: <20261101202404.156522-4-krzysztof.kozlowski@oss.qualcomm.com>
 <20261101202404.156522-6-krzysztof.kozlowski@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261101202404.156522-6-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: qvNogZtEalrY-Vgfki4IuObEqsF4AZ3F
X-Authority-Analysis: v=2.4 cv=fZY4WEQF c=1 sm=1 tr=0 ts=6ae86675 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=UsLgiRDap3Yzww6lrMkA:9
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: qvNogZtEalrY-Vgfki4IuObEqsF4AZ3F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MSBTYWx0ZWRfXzSlNIxrt0XRC
 G1Xj8908iclTecRKAO43lp9c7IY0ckJIWiG8m2XWmgWhqwZY4U5hGUHVhF1oTmoOwP9r4g0hzWI
 Lq4151GDJws5ecZ6UK8PzIdF1qi2sQTo4HMl+NK3BipJ/7VtsCN2LYQgv/CyZ5mRCFyPJE3H66c
 /25rtblmtdL4+cKbMi42g2x0Tngtl1e0uTF1bm9Lyq2qLITSEUdjCQlq8RV0KklO0CLW395yQpO
 QdoYtLIuaQd4lUEEPAOI/747IvfClzfxw8alMfPM/R70iP+WFoEoA86d7VIlvRQvpYZt35MxU1+
 mg0+Vhk8LzfV7b5J/XSCJ8OTdPseI4vECrBacOa5kMimccq51PEgawrKBUrQww4QY7H5JNmZorz
 5zj4B3BimSTRs6ijkl2w9Vi2IjI9ROgiRQg/REWXXjLx7UWV2fJSd1gn9ixk4KZsP04lt8TFCmq
 zAmdOtlmqkiiZCpgosg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MSBTYWx0ZWRfX7jd0hUCsM3FU
 csyFhBn1g+II0xxrhdviMZNti9Y+mZ7rndVmzXDLA0KN76f8C8w0/zvshub7X530rMo0/VY250H
 cTU40MsmpMzwHP/ZBNhivNQg28N+LD0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020041

On 11/1/26 9:24 PM, Krzysztof Kozlowski wrote:
> The inbound SMEM item is populated by the remote processor, so its
> contents, including number of entries, should be validated by the
> kernel.  Number of inbound entries is directly used when iterating over
> inbound data structure, so if it is higher than actual size of data,
> kernel would read memory out-of-bounds.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/bug/linux-b79427c9-5d22-4b48-8ee7-1d7808101e52
> Fixes: 8a9a7b9d14c2 ("soc: qcom: smp2p: Add irqchip state support")
> Fixes: 50e99641413e ("soc: qcom: smp2p: Qualcomm Shared Memory Point to Point")
> Cc: stable@vger.kernel.org
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
