Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A6358387
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236469; cv=none; b=K6CtJEd382yQppavDGWTo5lnsSEMZKNfJ6Wubw3C+R5DwISLguB4KTUYs5rSHpBIOAT5RtFMAT5cnyjR3e0VXW1ONoI7ue5JssnNRZKPzatr9yZuKezWkiRjwSCvw0iAKxGJqPI2hOL6jfy1C2NxWKh+hzlQFYgatcc592xS6io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236469; c=relaxed/simple;
	bh=3k1krIsMjL8C9GSdXhNuqALrM8YcwXNu8Ii/KMmkoXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mxrhOlkUUjMGmCyJO23GpKLFD2pahBuTbM1JoEzy64NddpQSXS5XGVqF2WEpvVlu4HjLT3HuTEE44LsGr/zKrn+bmu9w75EDKy6tTyiZLhICAbbBm9ysaL52fY39QZchrkuJ/hDmZyFacaYnZkIVaYmdex73Nm4rqeN2UuK1PIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=O1LAclDG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Q/ZQzwkW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="O1LAclDG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Q/ZQzwkW"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KE7iNh3650425
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	VH7OWd4qs6XPQgmtcdGTxRGr3GR0uOZKsVeHDZny3jQ=; b=O1LAclDG/UtSGOER
	3KHnOA56eh7kqRlwRREKVigXp7MWDNYjGDvIK2qeuMlxluVaukaukBfC/ANO0t4y
	kSl4nl+1rjKv9TkAOlCZ418PRrU5YmG4qbHRH8CifkHbzOTu0PKTI06hRX5UiaRG
	0XRy6R/eHN3id/ujY03SvlNJd6/vvoZ6fQRY4uRj6z/MJ+r4FmklQ1w9HpC4DvGX
	+piO1lfrUyt6Fvsy7CdyUYyiIleZdu2I+aKL1jXesfnIRoQhy8XWAvB9mBrO9LS+
	6KFBT9pPQN61u2zJ7+pZC3TVKsckHfIrdM0D4NDX/U211GmX2ScyzNXhEz6aS8xA
	7D2YEg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5w499r0c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:34:27 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-930a098ea19so349325385a.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 07:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787236467; x=1787841267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VH7OWd4qs6XPQgmtcdGTxRGr3GR0uOZKsVeHDZny3jQ=;
        b=Q/ZQzwkWTaC/34LJZzzl/QVKq3DjRYtVkD9kGQTZuTgDc4YlAK0WYg00Pxh6CTtjaN
         jVuFrc0gHUU8GLC/WzAg5GxxPGUixL4wpwtXrKYptfJljLJo/VixQ/gEuydmt5yTCn+H
         sr7iEeRcvENvvoHKhvnYkxRFFPTtaUWad6OXHlE4xXhQ4Pqsgyig9pWZdvX0ma2gucLV
         HwR/4u2jlstDfJ/Umh79ldyohYKV2xs62DOB/I6hGii1ClWcqyeJGBW0jWP81PApnUPJ
         tIvzdzfJehQX2Fkx9QpMyZBE6FjUTu3v5wQrufgBw3Ndv7c/zBUlMm+gWB3fRJyt60CE
         TZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787236467; x=1787841267;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VH7OWd4qs6XPQgmtcdGTxRGr3GR0uOZKsVeHDZny3jQ=;
        b=s0UAEX5UjEgIj4rT2KC76maz1umC6Qxy6heap/qWhP0xWUcENL92GcW1X9WM8X3PRa
         Yq0xYy+4sJFfkxX5uczAygEBBL5LKw+w1wvXswJkHVVZ4xNYwR0Ds6Vg1ZwxBw0+CQJ9
         NO8rXbJDkBJFnxsYvRvqWYUg5tf1UT213Mnq5iw8mnNuWmXo8jwBrb9/3/kh4xKeNfxW
         MtbSA3Ww15MphDHxfL9QhtuCsZgkMf6dw4MLD/Am4yjxrotNv6pbGrDQLwTWlufdECUZ
         jjcv/mQ4CyfWTuJ4vC4ijo6B7FiJWvs1bG1Jvd6ugoCYx9nrPr5hbJXSjmBqK9wlXoCA
         937A==
X-Forwarded-Encrypted: i=1; AHgh+RqnaYMLpiAn0Ki9/MknUHaMiP3pfSTiy/krnWJJQcsSiGSFF3FtKNDy0nMhYZmoy08UoBJ6eQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz96lVJv/Hq9E21sh2kZawfv8LxA/sXhGkg07+M5gLtwQHKakqW
	LvIaFkNLnNpXLItUAUd0ivp2dscSM9rIMQiHWt0xd6/137hfk9cu0fp9aP78A2wC3UIaobv4JBD
	sHSVqHAY1vT5ctyEZmY3d57oOBUHcQBveA0E17OsySHjkb3nKwY0ci0tSW9I=
X-Gm-Gg: AR+sD136SpVscJZsvhgFQo/KeNnu5VP6lDTJiTed1t3JrdTaqmVza/o/PQlo8mTWzSi
	BUud1pBb1MfntOkTq1q35AfPqxzusnuoGhz6oCPGauwkmqkvJJutdUSS2ployQ/+ff5pMlkkl9i
	YOYnwsFjSSlJraC2znEm3wGY4WbIO+0vf0TMa2g4jENWoMdK9bHCxAteeFcu3XPIPxWfapbtda3
	pVvRKYHkvF4/UhUu37keLD+/iF5jFyljpnpvleTOHwbuVU1TArmpghCu1MuZ3chcOpvXOFbpcPQ
	XdTCcM2rwaxC2dPJEJEgDoVY638Aqk1zrcMxL/mTpACiQJ33dHTfS06+eWbgGCjmRlFa/I2L4zl
	hEXb/wAp9G6027FQOcPZBrLUyWX32lf18
X-Received: by 2002:a05:620a:7084:b0:936:695a:185a with SMTP id af79cd13be357-9371e744119mr1175190185a.44.1787236466622;
        Thu, 20 Aug 2026 07:34:26 -0700 (PDT)
X-Received: by 2002:a05:620a:7084:b0:936:695a:185a with SMTP id af79cd13be357-9371e744119mr1175180085a.44.1787236466068;
        Thu, 20 Aug 2026 07:34:26 -0700 (PDT)
Received: from [10.218.4.101] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14b802dsm11919279f8f.17.2026.08.20.07.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 07:34:24 -0700 (PDT)
Message-ID: <7e863f09-473a-48bf-bc2d-c7a8122b27bc@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 20:04:18 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: geni-se: Fix write to read-only firmware
 buffer
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
References: <20260819-fix-write-to-read-only-firmware-buffer-v1-1-be86532fe122@oss.qualcomm.com>
 <3b924a67-a229-4836-abc9-0985e3e10d4d@oss.qualcomm.com>
Content-Language: en-US
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
In-Reply-To: <3b924a67-a229-4836-abc9-0985e3e10d4d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDEwOSBTYWx0ZWRfXytW3NnN25FzW
 Euu0rgq7E3ezLQnbM42hY+5MoklZ3pZLZV/rErLRwmW/aTI+4LhYbIKsSWL37za+aiE2OoeDF1l
 rK46M5fN5Q3akTLJZYgV0tzkfTEFrOk=
X-Authority-Analysis: v=2.4 cv=YP+vDxGx c=1 sm=1 tr=0 ts=6a871073 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=-BkaF7zFfwnn-ZNdrDEA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: xlteTVAhEgMehpFm-RW_D_1YKhNcz0B5
X-Proofpoint-GUID: xlteTVAhEgMehpFm-RW_D_1YKhNcz0B5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDEwOSBTYWx0ZWRfX/uuc5hBNZGpg
 vuAbg9TBJyGSNq5h9NOnRibNt64QdkaxUC05pJ0A4t5Ie5wSgVpHQPh762+OTZ9BFHuiulujAoT
 gznj+zs5SlVye63Oen3A6TRzSVLb7PfWcyxBA97nfSrjvvPbEW6fL5AV+fmXu7PL+m5kD7s6D5H
 riPan/TWuhSRXMGt43zbRioBZxxXkMA4Jq3j/QrKOyX0atBZDPSXVMf2IytwywMOKKp0c73CXKq
 MeTzsThs7GwiqBSIPVmtDCEaN0k0/I9ycembtU9JCTVfTrRScrLlyCBdbHHSsNQLyDhL+B6xC5F
 lxXwz5KL3i3ynjRMNdseXU4VMp1S3fCk2z5/d7ABg7LA1T7mUVjgIiQCa4UsVQrsmrTeLaxtivs
 k08F2t7+sYllC8lfJyG7JdzUirrO5VegIkyDowqx2+8GsVJw13MaA7z7WiM350DGhYK4/Othbe1
 F5gjNyZ6s7LZKiNg23Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608200109



On 8/19/2026 6:44 PM, Konrad Dybcio wrote:
> On 8/19/26 12:14 PM, Viken Dadhaniya wrote:
>> geni_find_protocol_fw() casts fw->data to a non-const struct se_fw_hdr
>> pointer and writes back a rounded-up fw_size value:
>>
>>         sefw->fw_size_in_items = cpu_to_le16(fw_size);
>>
>> The firmware subsystem maps the firmware blob read-only. Writing through
>> the cast pointer causes a level-3 permission fault on AArch64 and
>> crashes the kernel during driver probe.
> 
> Bug 1
> 
>> Remove the write-back. fw_size is u16, so incrementing 0xffff wraps
>> to 0, letting the bounds check pass for an unchecked size; widen it to
>> u32. The bounds check used the unrounded fw_size, so a segment with an
>> odd word count can pass validation but trigger an out-of-bounds read
>> during the copy;
> 
> Bug 2
> 
>> round up before computing fw_end. The caller re-reads
>> fw_size_in_items directly, bypassing the validated value; propagate it
>> via a new fw_size_out parameter.
> 
> Bug 3
> 
>> While at it, fix serial_protocol being compared with le32_to_cpu();
>> the field is __le16, which would cause the protocol match to always
>> fail on big-endian.
> 
> Bug 4
> 
> Please split this up

Split into four patches in v2.

> 
> Konrad

