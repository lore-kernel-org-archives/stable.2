Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795783026;
	b=NbYBXiuluSOECOkfI5GPV4yQSRiG+D4qQK+KQhs0DHerabXvIuPdf/iIVbbsd3LgjVhm
	 Qsu4t2b9ctYijfdhZqYGgbCIfCBkB/KkAPvnO7jYE01xTCB1uWfrFDK8EkLLXuM1kSG+7
	 ks4xbSEu8BL9rhI1kJO2Gx0oeRbyvm8lWrzq7w+TMDktPCKdpOJZXevGQ5X9yZf024FIb
	 /rwgGX8ds4sLuxXOAA0BEk4+mSm2BsZ2NkABjL8nsr82HqtDXhGyFocVdZQcVL3PvVGNh
	 YYGW4K+Cudh0B/9uDHbe3BRfYQzwID949MXE5pI+r/BtcytTLCNyPaH41YwRxfr1oYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795783026;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Hh8c48r9GrudpQXzXEgvdFAldCpWfhxNFka640a82Bc=;
	b=U60MkijTj/KW7IqN40DnWRmvtzfsn/Br959q+LK125NKSXHXMyOcYZ5FvVTlshGHSobg
	 klEytGt45+7uXB8BfJYNyNjl0aSh8zhPpq5AfZzy3e5cuBjt1GyuRy9uvVeGpEoz1hBVi
	 n2IdNMJUmTWj+ocQq2QYeUeO5Dgamtw0/V2JIR57CVXAt83yH46nBzd6ibkx6TJNMzgqs
	 X8mK7+Yy/harAh2hsu9hAnSNtTYJkv7gDaKx57un9UhkXiDCnz8jMc3zmK3wJZeI4Ukc0
	 9ICcsagyoeAVPea8HIuLUXGbhAw2kdbW+b09hGA0Rhvu9MQyqgtKrEIO95V2KeLQMvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="j1M/IWo+";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AVWT93Cq;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34684606A324
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34684606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=j1M/IWo+;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AVWT93Cq
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARApDtM2677325
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:37:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Hh8c48r9GrudpQXzXEgvdFAldCpWfhxNFka640a82Bc=; b=j1M/IWo+FcBGsw4+
	K9HC2uueshvm5urAsoG24grMwN3cYSVizBuz1Ya5f/51SqolpAmiPif3k+QyAGKi
	Tlkzjua7JsClhrlKnl9jM8PH/StObrmcOiA4h6nOGXdhN+BsCD03urAiWSqX1cBa
	d8PNKBF+89kgtIOeS6Ge/XkfEQba7gsLk4Yg0aHHf8Ytwdvr3XYe4AChV0OBUpzL
	wpxMB6Xmz9AP0BHsJAo8u0BbqyRASeiOol1II/HKVznBG1N+hZ1UHOzkPXSb1ZjD
	WtJhI4qpyTCUU8Kvxt6Vnva9IMWGHGh8Y8ESpOWJEcYGJPkoA+dCttM3pAszqYRw
	Lc/m0A==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j74gh9dh7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:37:04 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-14373747468so7723815c88.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795783023; x=1796387823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hh8c48r9GrudpQXzXEgvdFAldCpWfhxNFka640a82Bc=;
        b=AVWT93CqGnjbYU+lgghuuQQ8G38o4CfXjYy2BwUSG183gqUEoBVqAIcQfuo6WCrMLG
         TZgHY8/wL1viI7l3QFfmg45MRaaxSk0dsLEdVIiHp6no1/ItEADeaQlJZFTkjvBL3H2S
         Xsjw7bgXQvUep4URxW1kJuG2jVU0iXI3O9dUEeGOpq2anlZEBPh5bXHVvay+tREc8Vol
         If2dp6KSwKNJUPvC0Y1u+WiCsOmjJ2IKZvJFWw0ZCr/twGlM1LMiip1lpRd16eUIGRMX
         vs/auD9CqFvM/8Jfd4CJwxmGUgaATauPSxy+nJKMKK/m7jWIvcN2R06FrMCnjti79qrs
         88QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795783023; x=1796387823;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hh8c48r9GrudpQXzXEgvdFAldCpWfhxNFka640a82Bc=;
        b=JUeb5bgW9NWb8ckzMbptYQ/X6EevGbXaUUD8iwRRMxZTyC+NZ/rlkj/hxdL5oIa6fw
         TgF9cvCv0hUGPjLI2mtIE43EqOYdGv8FfE2M1rPwNt0rD5MU0mXXS14yPbjhDHrw+ciM
         eGtj8WhdPcW2s1tuAOkHmGuXaqCwZYhtkY5GaGSCR/qW4YsUmsTeHc6CVjmIVnhU+s0s
         drj1ar8AmOhNU3L/GURWl5iKnJFSbuRHHhBvhnDDmc4PaiRFXL8YqXto0js5IxfQmSpo
         RwoQflX5ucFCzN+t6X+iNK7paiQv4lGycDOHEtZ4J8v1nZUBSLXLQ2EaWS4B0hgjEqnF
         b00g==
X-Forwarded-Encrypted: i=1; AL+hErGcxcsCyv4x5kvcBJfOUwriJQ1bRhxIQlaH1QKMXrZih0xdIpGbN2uJkLhCdfkdPaPMlMN92m8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+q7VwI+IiDHnDS/uenHopYewjfA+7G7OQSs9yixeKeF4MhYLwH
	SxS5FdSz+uvyNDayEpaJOAaY3Cax3ujtdqEoPXBpdgwPSuIOIOlWRokTxgjIed8m7S8mNScNWDQ
	BcoC8dEBgelW1pr/RjPXxpCT0vpuD2VDXOHCs448a9OEEj55kzz5wtw94Fa0=
X-Gm-Gg: AZFdTZflyqRPMppjaZO+5RIo0caHPY80KYwvdTa7l8KUsViDjy4EPmkdff1veZV5msQ
	ifDaV/hARoNSbjli2xJzWDC1IgpBEGaGsE/AQh2olg8AFiXOoaZxiebH0Y1EUVaA6ALW/mAFOEA
	EU/tWWJOnYxf/bH+0pZLkZ3EOD5/c/HTq2O3VCwy6aQ8Ir0siA5QG1ST/5L2lczzoAcIY7E7vr0
	9Ob0SHgCLq4PdFD/g5x6TO+ktNSpXUjceMNHoxLwky+AXaH0BclnPPGTuV496qIAK5k31q2JYIA
	eerTWq1PvizjOE5cSpMttx3D6ZR39oCZoq1sFyr4v8jO7etLPDAjp9ISP5kEcjBkxq7oTfITAsj
	s74KZajNdqr6vJ/7iD7hS+TEH/YO/fWHzxuC327BJQ6SPrpeLSo/tNDpBhR6/xe32Fqxl87Jxqi
	VKo0rd
X-Received: by 2002:a05:7022:290:b0:1b5:dc3:209b with SMTP id a92af1059eb24-1b5568ac6b0mr22594252c88.22.1795783023063;
        Fri, 27 Nov 2026 04:37:03 -0800 (PST)
X-Received: by 2002:a05:7022:290:b0:1b5:dc3:209b with SMTP id a92af1059eb24-1b5568ac6b0mr22594243c88.22.1795783022646;
        Fri, 27 Nov 2026 04:37:02 -0800 (PST)
Received: from [10.206.111.23] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b59d8c0cafsm3430688c88.7.2026.11.27.04.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 04:37:02 -0800 (PST)
Message-ID: <fd5edb54-0ee9-4aaa-ad0d-9e92c15e6779@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 18:06:56 +0530
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
Subject: Re: [PATCH] media: iris: Fix encoder reference buffer size
 calculation
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261031-fix_enc_ref_buf_calc-v1-1-54dcba5977a8@oss.qualcomm.com>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <20261031-fix_enc_ref_buf_calc-v1-1-54dcba5977a8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfX4LXNbnSRefgm
 wm5k9McIkyU8dxZzqgamSfwVD2hcmF6ixMpX4P7hp6psCDqLVK9EnbyKqbgyFhUSWUV/oSsLP2u
 Rc5nLPXHeGbrhYJXi31R14CRtd62ppI=
X-Proofpoint-GUID: WLw3aePm_L10gev9qU6-bEEr0P8jXuY0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1MCBTYWx0ZWRfX43XHVBDO77ky
 QYjxrs6kMqDuTqguW16/lmejjvUd4f9/adGRlcuTfpJcNfTo6nx7YjXueN7SJ6UMWxxPaaS/Lrb
 9cJjyehF4HSbGu9ngN/rxFTPq+GeI5IGRZ4pFX6UUliZs0OgU0qhzdeRK6Lbrryesc3bbnTp8b9
 DQ9F9sQf8Zcs5a3Uefbk+dj0zxB+CuisCw460xSC0OMJHZTYfLl8l4On1GYdBcbMK9Kehl+7JwQ
 7wmqdoae+1RTF39IO0k4bseDS/aYgILW1C7SjqsoEq5N2X1igNRVsL1Bymxo5TNECR5hEM68VQc
 6cs73J1Oeik2Ff0ypjAN0XUqfyo/ylnajA3PuxObri+SFW5WkDgR+aP1rv6tc3X3oXIwNnr9flO
 XTjMOWYXPOtyLyJOrQjvunrB7UeppNT4ldWG/iRv4uJlcBnxgy1Oof2SQGvIXHRuXVGbZ6yE3JC
 SPf4bh/v7LskTRa+maw==
X-Authority-Analysis: v=2.4 cv=U5kHnuru c=1 sm=1 tr=0 ts=6b097970 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=1hkGSTuj8OjxEnJCJEIA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: WLw3aePm_L10gev9qU6-bEEr0P8jXuY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270050


On 10/31/2026 1:43 AM, Vishnu Reddy wrote:
> For frame widths that are not multiples of 128, such as 864, the
> encoder reference buffer size is underestimated. As a result, the
> firmware reports a session error when starting the encode session.
> 
> The encoder requires the reference buffer width to be aligned to 128,
> but the current calculation aligns it to only 32. Align the width to
> 128 when calculating the reference buffer size.
> 
> Fixes: 61528e86687e ("media: iris: Allocate and queue internal buffers for encoder video device")
> Cc:stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy<busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
