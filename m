Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490089;
	b=ZyfGsnh6fo4qKBcMrWSeh5D6Q08eLcFHvcftG6M8NIrfNdEgzEBuruWJ2FnenEt2r1lj
	 mpDCY1r8eRbutj+bYtJJ6atq39KEFOvL/lrOs+LUGFbM5YHn0yyq1afILPjR3+S2WDpUA
	 qsZh8+hyS1jkEhPJ+FoaETWViL9VrkTxy2kN3r1p55SF0n5RrBJXLk9BA9vh+l/wqmzRT
	 hnJ4m4zHU+ctag5jBxiCsgAi8UDc9kZpmri8qKH0QhSHWOl+YVjBeCqlu14/C+GjdDlxE
	 TgNr3e0vqutzK8S02rpZcbZebKW6xZaFwDAhpQJELWVmF7Hk9dxHg9jc6uH7S1Hmc2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490089;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:Content-Language:To:Cc:
	 References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=kNUsFTA/+rFt0nSFuj90/JPHp5b0lPSf8zxAPCksYKo=;
	b=Lu7h42Is+yDbr5KA94WP8oWhaAbjflLPza4KHET8CKNUjyUOY1EeNsVee79Pg+7ceWA6
	 JSr8nOBFUaiRlT7wbd6cIlbx4pIGfkjcagN/dI8PunuuUapG5C0UnDlve716UuyXdq20v
	 ns5KgsES+kYk/xD/N6Rx5xcuX6ArEDJrfLfFJnE4d/An5Y1SXljtgjFb2ilnJFPk24iO9
	 ddGwD5eAxohwQpaL016EUHTmGFEUczfK/8v6mLker5LBvBhAFQeNCwEs8utTR6ESLU54W
	 C3muiFAZztnWwkj/GHX87y0EYS66AXNfR83zgiaqGb1K0hBXlxJcbHcZzJADoQrgirA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nrsbhk3K;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kvgtSbRU;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74071606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:14:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74071606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nrsbhk3K;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kvgtSbRU
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AO2k6oJ901940
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:14:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kNUsFTA/+rFt0nSFuj90/JPHp5b0lPSf8zxAPCksYKo=; b=nrsbhk3K+FF5KSBX
	GIcsHunAGylqzXpdILRnF7MlHSHapypkIbvKfRqXolyM0J/E6UF4xCQKJ2IyWQei
	GYwXM8zVRiBwDhNMox0rd/fbbuMzXtex9Oqmke3Z1bvSn5Iv3cD59Cdm08DKnK+H
	ZPRQcviJ1wBeMmcuEi9Iq6c+FnhoBz5DxtdEqn5syEvBiyENpC1TbK6Ddjrsf/p7
	XLNJzRzwjopiqLqnXCJHPA+biVEAM0yDBzPowlCWmh7JcGEn0aBFmRJLICA8wz/Z
	yi9oECBmC5uhvdL0aa0KlOWZmMZ5WWP6jfAiP/3pxuwJzp3akCX6E0+63nq/Vu9z
	Zx2S8w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4w6ss2tj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 03:14:48 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-3869865a304so2702571eec.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 19:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795490088; x=1796094888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kNUsFTA/+rFt0nSFuj90/JPHp5b0lPSf8zxAPCksYKo=;
        b=kvgtSbRUJAXoyapQdFzjcBbbdN/99okoagPrwU+yE4fQz1LqNsSXxXqOAm6NwXotUi
         U/0WR1nb64BwjrNLzy8p4WGoiPWgkceF41pvAMnyX/Qxm0gLyjSZlvYCXorhy3hAbWxf
         a6PpGEzz2otkxfkxxW+cMdSZAwWEHWZyWCmmb5u0wzsNuM1EGmpANpxR4sbnoGvmFP/7
         bIbToDmGrhzsNoy2fvppoUOpbLNLIsRolGnDucXjXc68/W1cyRhmpwNy/SSJ1QdTT78f
         LkLhVChuYHlO02SxLj17bul93VWqya5U9GoK3CxLDMWx9h0iJwoqFgq97Ht+i9MftCMj
         7rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795490088; x=1796094888;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kNUsFTA/+rFt0nSFuj90/JPHp5b0lPSf8zxAPCksYKo=;
        b=AlmzCuzdZ/98F4nKppn51vZBDFg2cf6dL/f1QgR89v9/ypygMDZ92c2KToZrvGNKp2
         vsrD7cyxnp9jttXBokGk1b+XfhsAGa2A1wCnL2XN9PxqynomIzMACLjWwVBZtp26HBaX
         Fb9hb/+o9h0vRYgJfzHV/LdVXuJp6YWsxRbkOdtDLn/3IvODK5wwW2uWyecZHWGBC8/x
         4cM+UkKcfyOyEo/gafoliaiQJ8uW23o8iZiiruF4rsSpyqGgI3xHDtaQaecBZ5RIbMAF
         qIYHTdYJS4G1fFxIAUeTDbTmhObX8JP8etdJ4x7e1r41eR6LxH4J7cXJifWJO0NtJC7K
         A/9Q==
X-Forwarded-Encrypted: i=1; AL+hErE7CvHRJPklmXnvK7XvPyKQ6+CX4Ij1Gc8DZTNkMwDKvDBzMA8RBcqStTl/Vnz8/w2iFgUVbxQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+YiYFfpbUTYONE6T4XFYthTkSRz/mgC3dnl8lAtqrMQEh+TLHF
	efyeYmLUHdDuds6Q/dXCT72RqR5cJg4Vu9qVuYX6UHOO7Hym+/8L/SplgOlVBL11hqGu760xSYz
	Z7dHz9jsNLz6UtLy8IhFHSglFn0/HHMCytklm1nXVfZublhLw6VOzenmzThM=
X-Gm-Gg: AZFdTZfj76ZMkhU0HMHBUmRz/U1jqOFqdnTZFkel7MZfzEkqr0Fbxk0znuoFuacIOfv
	fC+8rXxUG/fNYa0cOA2wSMU2bmAG35JYQF41WjDYl53H8tSt4FaViAnCIM/SsLKF7HG5P3raV5W
	Fz3WpQuYqrrBO7HTT0jEy9xBw+J5SiwehHXkWMNwflbmiugsxg01LfjrTxnS3gBo00yoyNpjJE1
	inLAVsUa0dhxKWMEe43bssWgFTeFIl5GUM7o+avkFHmp2Tisd0vzrUmZuhCKKrg8pPvTJ5e0Pjg
	+UbUmR/QbxFaMGsfLGRT+d59g6SjLmQFd6u+eHwUAntrMyWPRYHfHxJUlWsqrAZ/oQYWfjxg1q5
	FAPy+NRH0LNLq75iBHwvk5hRFknzqFoNQHwDjesgThO/m7eNnOoHIGOF2QPf/oBS7gv68GOcrKI
	xUSy9ytQ==
X-Received: by 2002:a05:7301:e0cd:b0:375:dbeb:b363 with SMTP id 5a478bee46e88-38570f221dcmr14525351eec.28.1795490087853;
        Mon, 23 Nov 2026 19:14:47 -0800 (PST)
X-Received: by 2002:a05:7301:e0cd:b0:375:dbeb:b363 with SMTP id 5a478bee46e88-38570f221dcmr14525321eec.28.1795490087361;
        Mon, 23 Nov 2026 19:14:47 -0800 (PST)
Received: from [10.206.101.140] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386992b404bsm28956772eec.1.2026.11.23.19.14.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 19:14:46 -0800 (PST)
Message-ID: <18b59d4f-8f99-3ef6-9e89-73816d9b3bb7@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 08:44:39 +0530
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
Subject: Re: [PATCH 3/3] media: iris: Use firmware reported count for output
 buffers
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
 <20261031-fix_dec_seek-v1-3-cfedf0c267ee@oss.qualcomm.com>
 <179501763210.2846709.2834027862962422789.b4-reply@b4>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <179501763210.2846709.2834027862962422789.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: QzBC-47O4JE3g9v9gLpL_qfLDbwfHqyC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDAxMSBTYWx0ZWRfXzKgxEvLqOcN2
 KMjLBARsi5q7G0nCF8gy7k9iM/QM/zbdak5H+HPCjITj70YcBahC1pCwdu6lBDCjs3JrhLOvyIc
 JKkdGAfkoabSpLKCPz9Y9pIdkeYAqgU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDAxMSBTYWx0ZWRfX9/uuNHBWzddN
 jnpIL7imK33WomLkGAEiiRWcLNpZ118R8oi9WzvRLH6AWjE5rceZdl1rU0alUOz3PFwbpJo3xoI
 8/vO8fTvpfA4xY1IjdSG1xiCjU7/gyhH6kVAIl2hFolkCypKkMGjtSE4fUijuxiv7Y7l30nnts1
 mBUvcHX9FfS+F3tsm7/dGGE0iko5MtVnJMtK4V2fjYxspoUlI9V0KebMhOaLaCFeDq753Zx50lU
 N31V+IgQLhLXlmM5j8AOg43Yu+5+vZOrqj+ex68Ny7uWyWTWLgE+lsIx9x/ngoYkqgECW0GmG97
 Taijaa//92d3fnWENvzfITsIsZs4is7x0qzELu5gFFhQD5gCT7jE9L2zL0f1OBRA425TfM96Vui
 /a6EYAC0PCYyjhaT2MvysfWt0oNT98YIJYT1uFyjjTa9BIN+0dOXIuqf0hHQUncxpKgO8UkGTHA
 LIMb66M2IMzze5dJ5vw==
X-Proofpoint-ORIG-GUID: QzBC-47O4JE3g9v9gLpL_qfLDbwfHqyC
X-Authority-Analysis: v=2.4 cv=V8DoQuni c=1 sm=1 tr=0 ts=6b050128 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=TiF8m7coz-ZBskysaL4A:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_01,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240011


On 11/18/2026 9:30 PM, bod@kernel.org wrote:
> On 2026-10-31 01:49 +0530, Vishnu Reddy wrote:
>> Once the firmware reports its minimum output buffer count, the driver
>> still caps it to 4 for VP9 and AV1 when split mode is enabled. After a
>> seek, the output buffer count can be lower than the minimum required by
>> the firmware for VP9 streams. This causes the firmware to report
>> insufficient output buffers and the seek operation can fail.
>>
>> Use the firmware reported minimum count as is. The driver calculated
>> count is only used until the firmware reports its own requirement.
>>
>> Fixes: e1f5d32608ec ("media: iris: Add internal buffer calculation for HEVC and VP9 decoders")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
>> ---
>>  drivers/media/platform/qcom/iris/iris_vpu_buffer.c | 10 ++--------
>>  1 file changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
>> index a8170e5fa9e6..57467c952f42 100644
>> --- a/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
>> +++ b/drivers/media/platform/qcom/iris/iris_vpu_buffer.c
>> @@ -2375,14 +2375,8 @@ static int output_min_count(struct iris_inst *inst)
>>  	int output_min_count = 4;
>>  
>>  	/* fw_min_count > 0 indicates reconfig event has already arrived */
>> -	if (inst->fw_min_count) {
>> -		if (iris_split_mode_enabled(inst) &&
>> -		    (inst->codec == V4L2_PIX_FMT_VP9 ||
>> -		     inst->codec == V4L2_PIX_FMT_AV1))
>> -			return min_t(u32, 4, inst->fw_min_count);
>> -		else
>> -			return inst->fw_min_count;
>> -	}
> Quite a few questions here. Why is the minimum count currently set to four
> ? Why do we use a hard-coded value of four more than once, why not define a
> different minimum count ?

These are the minimum output buffers the firmware expects at the start
of a session, before it reports its own requirement. Once the firmware
reports its count, the driver must use that value from then on, which
is what this patch does. The hard-coded 4 in the min_t() cap is removed
by this patch.

> ---
> bod
>
>
