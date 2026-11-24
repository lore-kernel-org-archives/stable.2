Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795489878;
	b=pWGWqs9FIH48dr2r5l57SED201xSeLsP8C0IMKdsGnau5OS6OdEYzdP7ALimVSTcbThC
	 gTPrI00ovxg2oM0vsW8sQgiYcitTBjAu0WQLhQuaJ6vsGSFEXFNr4bFs2VRMqRuqrTgIQ
	 UqPqUj9lkhz8N+5SA/BRr0rUuNvcGFmtYh5dWEDDT41sZHnhdySeDYRMoD3p0wYzMb7h9
	 stBZOU3YiEHwc7fVhXZ2fkKAYtY5Vn373zZnoUZqAJSXzrOaxgXShbquVt2PsSQrZsG8+
	 ad0DNsYksJfnh0bKeIc0Cwff5IfNzuqfkL47f7rA6wZYsj8QQF57KgE3RcVO9rx3QQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795489878;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Z5VeJnwz4/sm28InEjRBuwn7cnvfk5WFes1/QC4jAFw=;
	b=GpeSjFwZnDSQ1eRASQxR1ZUq0XPSt15KeIj49XLOYPH0jn2llObyk+sj3qTMBhX0iCVT
	 amM7erxNuNer5rjUru27FXz0wO6gO9iSuse069zW+5sMF0dF/UekTNDqNUKk/BAPkrSrT
	 IrLViK6mE3X1nTiGb3XBzX6Kdg26BGFCXqZuLWRB3tsfKy88+uBnKVC/AJLBUXq49O+YU
	 q24UiuuoA2auDILp9rc/h7P+qbjxwY45VLP9yd0Ba42Fws4Udkp7cv3+jVKnEpgExRWZM
	 k0qinxg0MW5Dsf7s+fxkGqNnWkN1xnRk4cw1+hs34wCXiiYExyCNT/4hxkAC8g2amLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WWOd9wlx;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ikjs1Wl3;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED027606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED027606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=WWOd9wlx;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ikjs1Wl3
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2kLJ12452885
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Z5VeJnwz4/sm28InEjRBuwn7cnvfk5WFes1/QC4jAFw=; b=WWOd9wlx+nGqB0d8
	7Uhr1RJvZCNKrfDecfAFW68iEq8eEppevbasIdWBuCOHSXpISC5Ubho4n6ZgeiWC
	jKCm72zywG+/3bXFRvEFhe4g2MvS8ndgiQTaMSFFdfZqHg+IDr1xv0RKN65Tcpt4
	Q8BmVjSMgTpkk6a1kiI6UksXe1TW9gEBQri4PSSXsAan18xUsxmXPBxlazGnQ38c
	uWZ65pDjnmU24N6xWUIzVxN8YjR266Fbw36ht/aDgS5ck68h4/Fk+JrnUr/w+r6i
	NcBUxMNqNE6REs3880Al7zGI4HhRdj7A8SEmPh6L0vnKQ/Jehxvi/vROlE+3cRxh
	zxFvvQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4ma0uf9q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:11:17 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-154e9d2d94fso4792451c88.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 19:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795489876; x=1796094676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z5VeJnwz4/sm28InEjRBuwn7cnvfk5WFes1/QC4jAFw=;
        b=Ikjs1Wl3lfyXpwtAEA3LeX6fWGUpS33OMr3vVUp2PdzK+NtLs97ZBF15il+P5c53Z6
         4n2tnQKTlKZZaXr7W6W7lIPwgKqmW0dN7y6FW9/tqo8r5ZLO2hO6SfXA06gJnMInSe5Q
         2g5uzIMAYsbMtfQSl5ndWdcMLxXjG/35t9gO0xANAh7zE0V/925icKFfg+xNWeF9LbHf
         nv9jar9tYKlXzxO0/ojXBjdIlcdT7sJqWzydtnclRh6YXAdacUslpDtj0NeJ+BhNiNr7
         XcBZMcg0RyOa+mU1NOsPcAnRxcnWHWMcBjDliFORKIU3qzJKnBKN5z341xzNQAWBT+td
         cbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795489876; x=1796094676;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z5VeJnwz4/sm28InEjRBuwn7cnvfk5WFes1/QC4jAFw=;
        b=0m08vn8+rEukxHo2frgcjdOAOTQ1VLTy4P9aCBltVZbQrLix8vdvDXpeMu5ZYQmJB3
         CAtejfw/zg3UU0KdCT0exrN4H9gL6Mp4QViBG9SCi/aWgxCHY14NquLVSnuAzZwk19Ek
         z/kZZczbF9qC5bk14Vz+RyhLzbdnJnxmBD0xPWBeHb1N1VeVlt9fus3Uf2bZ6KMVM1hZ
         1JPAR9+D7sqv9gkFRoQHyjSh5oi+TkQE7kzujswnoiZodBXWwia4k+tpmiDDkBYzzxqx
         pjeA+V11cTrlBRW2mcu4M8CxRtRBIKp2NRtkEiqLYp0hCmXhCNrVpS2kPm8mPzYdxi0E
         6/Yw==
X-Forwarded-Encrypted: i=1; AL+hErEA66XNlgYpj5r+yvRt6uEN2OMcZmxgBnPU/yTBrmurqd0/rTUcJCv2P7pMYhHQC7JHYAWaxbw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+6zKXsy/MWID3GwlZ2mLOJHYzhpIDaF/STE98fOw+ngBZJOWNE
	0oq80ZBhafSk+HWTuSRH6VooCHjR7kVywNCRhHLRfwdRv6hxuWhBqzvfqvq9NZVm1SNdmdLOYZu
	4pkYLTQoOGgm12Omu11wfUJVJFqYRIshV6zpO91s38Or2qAZROlYmgewb9EY=
X-Gm-Gg: AZFdTZe7O1IY7vwPPQ8ipjsZBL9IPoSHZ5C0YW6mJNwhNxsbpYy+ua8tGQ7f13nGLKL
	N287NF0i0dpz0jK54G2UjsMt/spY55kf1ywnUVYIWb2MPhLFGMf04Ttq4xwqBsXlOvXA4yQ79F2
	cXbVKvuYCjpmBZ8YZynlj8B8w8LbBoU2VQaL2nEk5Xet5Tr4od6P/Ml2IOarKGOH6RRAvdi0uSu
	i9hJjcDt+xx5QzLQZ9379Bc3j0J6QCXPH36OwqYfTFTVo7cl2+UeKOjugKzFhrA4cYNJNecHX1l
	toKizea67+bC0P465fBvaDaIcOVBlBM9mw5wPhUpwGHqSX4nFidaOBvkiTXaQkNN56HuKI+ZIAG
	C8kd2vYNtijm/YEA08weieio26PCkVYWswvKmj9TxQ1qGzDHx82ergD9NkRrbDgUaCKh/1psG98
	e3bdU0
X-Received: by 2002:a05:701b:204b:10b0:1af:2ba7:e44b with SMTP id a92af1059eb24-1b5567a6142mr15576902c88.3.1795489876305;
        Mon, 23 Nov 2026 19:11:16 -0800 (PST)
X-Received: by 2002:a05:701b:204b:10b0:1af:2ba7:e44b with SMTP id a92af1059eb24-1b5567a6142mr15576868c88.3.1795489875573;
        Mon, 23 Nov 2026 19:11:15 -0800 (PST)
Received: from [10.206.101.140] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55ff0e4e6sm24383285c88.11.2026.11.23.19.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 19:11:15 -0800 (PST)
Message-ID: <0596e698-a599-1f83-a39a-146b52569575@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 08:41:08 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] media: iris: Skip redundant HFI_PROP_TIER updates
Content-Language: en-US
To: bod@kernel.org
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Vedang Nagar <quic_vnagar@quicinc.com>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Deepa Guthyappa Madivalara <deepa.madivalara@oss.qualcomm.com>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>, stable@vger.kernel.org
References: <20261031-fix_dec_seek-v1-0-cfedf0c267ee@oss.qualcomm.com>
 <20261031-fix_dec_seek-v1-2-cfedf0c267ee@oss.qualcomm.com>
 <179501803041.2846709.479596500645471046.b4-reply@b4>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <179501803041.2846709.479596500645471046.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 8LgV93Y1Bi3El8gIglIftJjShIDj2Dh5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAxMSBTYWx0ZWRfX3Gu9pU3qh1r7
 Uk7olVmDUWhkk7rKBN0u0II2aL3jP1pPtwLOv/898pjYsWvqkpD025CFnjqvnNa/V4IozebX6oQ
 YI4Drds7PT5npFvXUrsNMkKen9BUYKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAxMSBTYWx0ZWRfXyNVGuOjh4e8r
 NN86xswVh+IFfxnP1CrZBzqFmXFZpvgj2+wxpJ8LlHGa8HnZHLT5RlAn3DiQZr0eARhiwsjmSRt
 Xl8qajul+nqoNP6oQib1TlnjBuriOvVyuXyQsPn7ztPXZb6VTYkEJvv3L7nUmCdgI8JBI89AGyD
 wQ47RUSF7rYIaQhj4PfQ2AizmrZS65egEXl4DuhRCV4/xgWiJiltGa/yQXBY7FsX2zCGTkLW91a
 /mVh5KnNfZ3JA+ZC6fg/SJW/rDZl+IjPHffIBfMJ6frebZtvOedxi9ZetVS13v/2aoEAHCQ0xSv
 VEL5+oWEypL4CqZjVw6CaczWpVaNKMDa8RTrjz3CGmVQOxxPrpfJxKXBzfDISZvjnYZngb1kl8/
 30WJz8ooOHgBOdsH+pLvhHdkd0SAlPaXjy1SsZ6VlmyeNEGjWDKLdsCQiiiEP1AZY9D2rjT8vkN
 Z7RdvlPfsZHMUuWKibg==
X-Authority-Analysis: v=2.4 cv=Yr+a1IYX c=1 sm=1 tr=0 ts=6b050055 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=ZEpBKAdWhQgix3oRGUgA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: 8LgV93Y1Bi3El8gIglIftJjShIDj2Dh5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240011


On 11/18/2026 9:37 PM, bod@kernel.org wrote:
> On 2026-10-31 01:49 +0530, Vishnu Reddy wrote:
>> HFI_PROP_TIER is already programmed by iris_hfi_gen2_set_tier(), which
>> selects TIER or TIER_AV1 based on the active codec. The TIER and TIER_AV1
>> caps also define a .set callback. As a result, iris_set_properties()
>> programs HFI_PROP_TIER again through the generic cap path.
>>
>> The generic property loop sets TIER first and TIER_AV1 last. For non AV1
>> codecs, the TIER_AV1 property is programmed after the correct tier value
>> and overrides it. Remove the .set callbacks from both caps. This ensures
>> HFI_PROP_TIER is programmed only once with the value for the active codec.
> I think this commit log should list where and how these settings can be
> applied three times ? and what the sequence is exactly which leads to the
> invalid setting.
>
> It's not enomrously obvious reading the log and then the code how that
> happens and which one is so obviously wrong.

Ack, will update the commit description.

> ---
> bod
>
>
