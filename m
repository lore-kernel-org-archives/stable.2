Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2972374A1F
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787548888; cv=none; b=n3wKnuLXzz1gd4FKaUgLClhL6evdDHA2K4AmVcoCuXCBUr3lTbem6/3ut+B/YlE84fRnZorSw0kLrlAgFMEumgiKotVZ9drYRfuiGITRe9bswKVsN6q0d4fmJxRfWViv+iMp1JVj5FyZT7MXalWu3fs8LOQbP+eL9sLP4RgqxDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787548888; c=relaxed/simple;
	bh=MUv/r2sK0SBsxHR/er5eAJxiIiwiIoXO8nusLF6tYs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrNAx6Wg3VM98y2iOww6XiQ2Dv+qdvIXf9DRep8xAbecHsVtbDsw81a9pCSb0KHWETfn2jvpBTYEoGfWYa/mUJ06NBt2MSFIAwpHq3bN0OTSLZLzRv4VzfFR0I3quyZRJKE/lv7dsz/vuy/sgjvcQ6uO9PUSBco28QUHGqunOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eOaB1DSn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=H31Q0Ujh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eOaB1DSn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="H31Q0Ujh"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O0lcHp1463213
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MUv/r2sK0SBsxHR/er5eAJxiIiwiIoXO8nusLF6tYs8=; b=eOaB1DSnQYU2Sb5i
	wBG1Rc6PxrULAMe0K/sLfwmDpa13Nm5QfZ4zgLFte3q3BCd+JuWGymmDTrguQ29E
	3vjRabhCEg0g/JrN3/TPvTLdA2an9eELt27R2k6Zq5bShq5JIE/Klt0/ueY681y9
	NpVlDcIk34KYvEywGHqlvAco3/qkxCVoDaEPGFq+SuqEmi58thiA+Qm+wVkCPtly
	IBzY6ds3VK2LN0wTYrghYnhqkKJLH/k08RO6cAAdwJ/2tzSBwnFLY1qOynahG27F
	WQ/WVuvxrT7GiUBVpTtlNZ7li6PLdJzrFRdAnlOQK7HtEHXS8Jk0q178z2V4SC36
	SsbO+w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8bdr0p2t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 05:21:25 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee1ec30f2so42943605ad.3
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 22:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787548885; x=1788153685; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MUv/r2sK0SBsxHR/er5eAJxiIiwiIoXO8nusLF6tYs8=;
        b=H31Q0Ujh2cexqR/0xwJphuSC9SSJRBmt0cSryhnmH/I08sXBZv5++weXEajnQS0RZs
         xBUv/ovC+SR8CSQCWO28v3Ky9O9ZburrF2QrpjvYg62ArcPuuvcsHSZGfv3ZUjnPOhIT
         OwhN3Y7z3dIFCnOJXsNc+Gqc98lxJYC/P7s5xzM7f7iKl4lP0exqQVyrgbz5UuuEOZS5
         U2iZJ/HcbBF01nosYx6oa87Th7RpxdtwDje76bgEivf/h8ny07wnMeuxjqoIjDZuCaaO
         xn8AdlM++vWJ4x7Jqad3s0zEiqnuSDE9z1rl+INqKUG8x435LN3wYM8hAAeJ7IBe4DsZ
         3hYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787548885; x=1788153685;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MUv/r2sK0SBsxHR/er5eAJxiIiwiIoXO8nusLF6tYs8=;
        b=MI6U7whZtCg9jfUCBUm/M7eiOjZLy/oY44t2bvnqn6Pt8crf3wk+vxuQ1EYZiPFsJB
         caQqwD8lB+ch5+VJSbdabDF9Q+MWw+0oG3gb8LHLHQf+dWNrva9FwWnWtSQOs2ogzScB
         iA2coRGjHknC4Vraw7b/5zmWl03ZFqYpjuDa5UZ2RbtwAZwR3T7WMcQaxqKn0887gS1D
         XCj99s6k8UbdTnOQFce2AJFoRWjsYci5NHD1zBUP4I3YK12HjoKogNMLpG0Z/dEs0ADh
         JE/9iddd6ngEOb29YXfAVk8i4hzSZO63+cEIx7K/sZuo0aHagAQx29OVP9V9SAy+ogk6
         krZg==
X-Forwarded-Encrypted: i=1; AHgh+RqU9cFr4kZ1O06D6k1nc1pgghq3529Q/ddZwMM80vjK1IkprjwH6JJqa/tYhkLQjkFUCoyWuDY=@vger.kernel.org
X-Gm-Message-State: AFuF++nG+rBO9tua6MpiY/XjT0GEy9MPxaAaKAWCqtBA8DymSMFg9Yl6
	TGe9KiiWUdyG/7OShpAdilLudfrCEp/JSyneqOSO4qbX9+0aLSx2tX4isPQ0KibbY2vUFpBTQnJ
	ZVrFIud0lA5+hh7rXp4tH/5oi4im7/HlYQLZlkTPSelClphscpk/vYGyUqZY=
X-Gm-Gg: AR+sD10pGQTmYNV8cTUCv8VE1VyHWr6hgJP1O148Ltgmf8eJisH22JYqGbx8dP72EPO
	I05wHwQ/U1XSsrAOBOoDj4IlgCe4BWecY85dSgzygVVVFeM1M2L88TqNSYBTOV75Xr+cpRLoy7z
	ybRuM0mIU//i5T8HNDoNfoUL5ZjO71+WhJMqFQXMbbSztzPmNtrXPbov5OOXMbKfZh5ygsoV4pO
	6P04G1rcUOgOoyrOOEgZAF8G7Y2gVgDIWlKnpxL4I1L3evVuEIyEocdtLjxD9U59Lo47UJfFKZS
	6vJtxVHGR+5G0eS7A/hTNzCcoUUUktbBhVeOR1Y99X6BbpMMSMU4CD9g4FvWo7kkVYcSTBcXUaX
	kkIWkO1PAKbY6NnwoH0I533OGGiebpB1W
X-Received: by 2002:a17:902:da91:b0:2bf:27b2:4b80 with SMTP id d9443c01a7336-2d64b0b6ad2mr328235405ad.14.1787548884802;
        Sun, 23 Aug 2026 22:21:24 -0700 (PDT)
X-Received: by 2002:a17:902:da91:b0:2bf:27b2:4b80 with SMTP id d9443c01a7336-2d64b0b6ad2mr328234635ad.14.1787548884281;
        Sun, 23 Aug 2026 22:21:24 -0700 (PDT)
Received: from [10.206.101.140] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f922ac7bsm21411128eec.25.2026.08.23.22.21.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Aug 2026 22:21:23 -0700 (PDT)
Message-ID: <a16e9d90-2cf4-134a-6701-ba729b24e78e@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 10:51:14 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: sc7280: Add dma-coherent
 property into venus node
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Hans Verkuil <hverkuil+cisco@kernel.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        stable@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
References: <20260818-iris-fixes-dma-pseq-fint-v2-0-8dc8c4b3880e@oss.qualcomm.com>
 <20260818-iris-fixes-dma-pseq-fint-v2-3-8dc8c4b3880e@oss.qualcomm.com>
 <20260819-daffy-armored-angelfish-3be5b1@quoll>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <20260819-daffy-armored-angelfish-3be5b1@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA0NSBTYWx0ZWRfX4qppFDomPSxu
 GYLHVawY/qI9b2TWcbSQOdyj4hDc0aBOZyIq/CUjyXOr9HKIyWcSwIxObT9KQBG405tGLKpNenV
 XYy1Ou+IzPpPPY9yYkcITrJZDh4iPH+UjKLGma2BW7WQomN1RPWgLPuUt3NIB3OylxvXzLKebu2
 NjWEk2yfyXe2MmbPA1d+79ZMt+KoXJN18qOmP+pQY19G72L0eryG6m+3mGsOXAY5jD7etp9cttZ
 D6vnccmDe1K2ZwAZd6I7IGALTxUEOlthdbUg1kLGwuOojZyiIvqkVyNyOP5u5f1OVaxKahVzbhv
 XAHfbzilUX/QR1fKNJTvKrru/KbpACkkkLLaWIEO0CfzrtL0fzfdGQLjfM9lYJEGJrRrwcdhdup
 ocdK9b1qHFbgWgIEIHV1z403ZzEnk5w04W4w8aLXO+OLwudyQUghr05/H/DZIHqyFq64mGzBedr
 1WLnEtNOMTPfXz76vnQ==
X-Proofpoint-GUID: Pguq9qs1v68psSjZHMuvbs5vYzexxAVR
X-Proofpoint-ORIG-GUID: Pguq9qs1v68psSjZHMuvbs5vYzexxAVR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA0NSBTYWx0ZWRfXxrdTW3nWCgEs
 Q4RzUFcV7/rAjyLz+uLuTieKVqkqPhnQLqDc6Z/ZREMN/96aKu5knMNTKDGe6TsypmPDCImLFiP
 dtUazDOWAUnAQwiGtB0bg6Iyz6wBtWc=
X-Authority-Analysis: v=2.4 cv=W8cIkxWk c=1 sm=1 tr=0 ts=6a8bd4d5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=F9kTNvDYw5psoUNgSeYA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_01,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240045


On 8/19/2026 12:46 PM, Krzysztof Kozlowski wrote:
> On Tue, Aug 18, 2026 at 09:24:16PM +0530, Vishnu Reddy wrote:
>> The venus video hardware on SC7280 is IO-coherent hardware: even though
>> the driver does dma_sync*() calls for the input and output buffers, the
>> venus node still needs to declare dma-coherent so that the DMA mapping
>> layer relies on this hardware level snooping to keep the CPU cache and
>> the DMA buffers in sync. This avoids the unnecessary cache clean or
>> invalidate operations performed by the dma_sync*() calls, which are not
>> required once hardware level snooping is enabled via dma-coherent.
>>
>> Add the dma-coherent property to the venus node to describe this
>> hardware capability.
>>
>> Fixes: 37613aee2179 ("arm64: dts: qcom: sc7280: Add venus DT node")
>> Cc: stable@vger.kernel.org
> Nope, nothing to be fixed here. I already said it last time.

I'll remove it.

> Best regards,
> Krzysztof
>
>
