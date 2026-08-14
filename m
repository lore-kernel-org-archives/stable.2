Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C147E45FFCF
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705081; cv=none; b=iVgdzPfZGKDx80i+CQRwJI/j+WAg095ak9Xbb3UMnqebqAzg/a41835i4Gf3VCNXmIQySWvIsxTfWXpbBXcGJHy0Q31oEGNVn/RJ4r2QjSekozK7ZBHSDbDM9/T+xnxblPWZHqiCAEtMjjDDjWgrSTsfq1LtwvQL4emfeGZCX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705081; c=relaxed/simple;
	bh=/TYIhfOmT8Bb4t2u3FQPduCphwNJftOBmshuMKDdFGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4vxzaN7zjgxKGiP1JGIWS3X0tSW4hNUIWAYSGGJGzQN1MLjde3r7K06Qa+G3evO00gUOyijUlt6PTf/psytWG0BwEQfNnvJnrK3Knnj9bv4XB05NVrTM3rre3eH/Vsw4U0+Ct3/hKTcnd2D6odc0UAarPCAO0ONRmWk9JhX8MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pMuxA/yF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BVa18ySF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pMuxA/yF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BVa18ySF"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EAcIVe664778
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 10:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/TYIhfOmT8Bb4t2u3FQPduCphwNJftOBmshuMKDdFGs=; b=pMuxA/yFUdkM4MJv
	K0VIoROiLJur2rCFAnu78cjniV6U5v3/NEf/CmLTkCU7ymyMhCk9SHCLgNDQ5PX3
	2cguS68+KpXst3qnhOkksjLHoqJ+RHcTV2bXWoCe9s418oNzfsG5/mDdzKbnyoI7
	gX98bl8VTjsCpwkpS/D1wV5mBwqJvL96uNqeyi5elV1QlxOcDQ/vWuEVGzmCY8Nz
	5hcA019liQJvybHv7Tg+fd7E9z+dXCPOpiIGH2o8Fpv37rWAbHR2EQrZJNGz8JHo
	S7mKmfrj676V3XMeE3ms6SZ1sKybKi6CQuZ7ozyb6ZmZWO/mjsam1Jg2xny6bci1
	XShUGg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1m42k150-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 10:57:49 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dbf293831so1927042a91.3
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 03:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786705069; x=1787309869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/TYIhfOmT8Bb4t2u3FQPduCphwNJftOBmshuMKDdFGs=;
        b=BVa18ySFOMbUt4axpJruUkHU8jNjlvv5xDxkfrJUjObE86C108rEnIxwZn9JvPqRlE
         hphLH8Ucrm6Jfnn2xYSoigxKR1tXeQ7baN9jZUBnAYCoQgzmiO8b/zC6cxf/9OGWH8G6
         Ec8h05DTB7UIMDIPwXTvLlPVrNs/NxMFMOV8qH+8W7aBuyQAl0tGdAGdsJI89OPWzs6v
         irQF6rL///ilRMxk0VpJ3Rj9FaISzcrAPT8g+rX/QQEWWkajQxb2STc0KA6ENFTar7dz
         cD/F2DL+X70OFj+W48tASyzbqhqH2tuXv0qT9iWeG1A+cZJfxV2733+Dcd1gu0hfXaFs
         qOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786705069; x=1787309869;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/TYIhfOmT8Bb4t2u3FQPduCphwNJftOBmshuMKDdFGs=;
        b=kLr4fDwYxk9s+t+UqIGqgkp3oQ9x3d4cAYHv79YEGlP3UX1XrEm0aYLBWrp9+98eFU
         4yYR5rqPLdw49ZChPZ0X2WIlFpSem7WU5znolmjYcT+tzOdclKOIOaXmVcctew0tqtYE
         3ybFwhk0iH0xKQrXWV2uw8HraCyF61fmEGuZraTMKyGKyTUoC8dn4ccSn17psQe5tNQE
         +Lr+4QclNy8sq+v2muPOIlKquWxw1YCCSZIdak3S0ul26k0NYmPMV1QMw8fkSsb8cVWW
         xMicY4FIqshlW10q+wtpzRUDsQrGCSKYgbvhH2Fqnfjfbpfgbkz0Jei/cN+tOzGG0sCS
         Ykxw==
X-Forwarded-Encrypted: i=1; AHgh+RpCI1FSWD3u3WjpKxtEK5+CSZnEu6T6an+lC2+bNYxxovXSBSCk2GXt8C9cu4AQ+WyBwKrPZfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfEPyiVaY2tnBUjY+0RryK7sqiK28zBnOvQqgPxjWt0sdqE+5o
	51jx3vm++k4eaxqOMzV3KRwLW2fERyXzzy+uSVVcasOWDNWiIxuN8ru6KV38/D/bTInLXfotTWu
	enayfRP/AHRoa63X599zCtBbJuO7UaPriJIOOS5tccksXZRQvjVrCmKNtvc4=
X-Gm-Gg: AR+sD11l7/sGWD/J/btyDKaD7U6zUc79TQBgU18cb1e9R2QSgM39oQxmn0nsy1RDVEX
	yRYXsNF8PllkUsqNj37RHkDrMA/WJm593Y7kTb9cTrNJSsI89KKQvu8ai32Z0K2JOT3K2RvuPdm
	qh99tU13CIZJCqOlfx+p0BSUV6HIHIiZSOlfxBsvG7tOk2xIhg9qVciUCyzusgEZBFuXdYluj6r
	FbmgwEGY/2jLsmHJwAg2bA4d+WTDkK95WkY2v2te6K3yEOZRLEUXUS796pHHbexdM0vHhu9yhcS
	uTvCSJYqmO40zzEk8CuADQ+xmjxFk4uiIKg0DyFZZJ5Pf7JaH7LakiSplDvTGcFgP5nqFfmUQsP
	c3Pvm+s3q1pUw5qt/7uke7RSaa+JaeK2x
X-Received: by 2002:a05:6a21:2d4b:b0:3b2:a809:ffe with SMTP id adf61e73a8af0-3cc71a2d522mr6482119637.14.1786705069477;
        Fri, 14 Aug 2026 03:57:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:2d4b:b0:3b2:a809:ffe with SMTP id adf61e73a8af0-3cc71a2d522mr6482065637.14.1786705069058;
        Fri, 14 Aug 2026 03:57:49 -0700 (PDT)
Received: from [10.206.101.140] ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-320ea2fcfb8sm3392781eec.21.2026.08.14.03.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2026 03:57:48 -0700 (PDT)
Message-ID: <25b990fc-558d-d64b-1a5d-e593f4c8d649@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 16:27:40 +0530
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
 <4b34e718-0878-25cc-a5bd-0d8858df5133@oss.qualcomm.com>
 <30195e14-0dcb-476d-af0d-f85ee57e2aa5@kernel.org>
 <e287e538-135a-4eb7-1b21-55b475c844e0@oss.qualcomm.com>
 <26a880b2-5f37-43be-ae8b-2c0c27c777a1@kernel.org>
 <c03354d1-843c-af24-0e7b-a4c0cfb8e001@oss.qualcomm.com>
 <ed6c14b1-49b4-44ba-87b1-65b685e6c25c@kernel.org>
From: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
In-Reply-To: <ed6c14b1-49b4-44ba-87b1-65b685e6c25c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=I+dVgtgg c=1 sm=1 tr=0 ts=6a7ef4ae cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=axlFovWQs4n-uMMd4hsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: fau8irvo4IUG7m5qNZIkZ2V-4C6eLimr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA4MyBTYWx0ZWRfXxru4QHA6X1LA
 lpVzbvqMNntecQhTpTknWTKRZ5jKoQgIO0kW3TZ1IfU6r++sAkE51bubltHAtSQMkB/Cnzproue
 z/f26G/yzdHB67WRU6On3bRbYAkQneNDmgU/8gnjVbI2uXw7UahDhdQ/JFiIdb+yF9hf8LldUYm
 HGBSsAx1TjJkizk9fJT9Rty4MRYY+r4DL+ri9nRqEWwTd0Q2G4TUMKEsyC7tvZSpi4yONDt4Tc9
 VOAKDHnBs/DT1ew0Mm8b28xx35+Cra6OCv/JPQcw36XfjF1S4kXM9PzNXWTcsxu3UXqekFnsqhZ
 ULxKHFr5+AbQbrpCffjLf6KEJrVlKAWX/dmoParQyrcmmSDQeV9O18ZkBxyNRPLVHn1lw0gFRL2
 lZh0vFjqasPF+odMPkqMGiqjPh1PcD4sRPIJaEdsgMYO9DaUhzFlh986ImbY/2KrECXhwPSoyYy
 imzCIIwXaaKyOqd6Ujg==
X-Proofpoint-GUID: fau8irvo4IUG7m5qNZIkZ2V-4C6eLimr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA4MyBTYWx0ZWRfXyqj5PsTiLpk0
 SmkCQc7OuCaiVy6AddCqsA9R9ZIBkZOYTk/ma+OjACxt3nnVBqNPd9Dfbbp7/lcXo0Hw/ya7aR8
 YB8Ag33pb9jLlVNndilwN/cMebWS14U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140083


On 8/14/2026 3:56 PM, Krzysztof Kozlowski wrote:
> On 14/08/2026 12:24, Vishnu Reddy wrote:
>> On 8/14/2026 3:26 PM, Krzysztof Kozlowski wrote:
>>> On 14/08/2026 11:49, Vishnu Reddy wrote:
>>>> On 8/14/2026 12:01 PM, Krzysztof Kozlowski wrote:
>>>>> On 14/08/2026 07:29, Vishnu Reddy wrote:
>>>>>> On 8/13/2026 2:49 PM, Krzysztof Kozlowski wrote:
>>>>>>> On Sat, Aug 01, 2026 at 01:07:28PM +0530, Vishnu Reddy wrote:
>>>>>>>> While testing with some higher resolution clips, the venus hardware
>>>>>>>> triggers a fault due to wrong input data being received. Corruption
>>>>>>>> was also observed in the captured output when the client dumped it
>>>>>>>> to a file.
>>>>>>>>
>>>>>>>> On debugging, this was traced to the venus node not declaring
>>>>>>>> dma-coherent. As a result, DMA buffers shared between the CPU and the
>>>>>>>> venus video hardware/controller are not guaranteed to be I/O coherent:
>>>>>>>> CPU writes to an input buffer can remain in CPU caches without being
>>>>>>>> visible to the video hardware when it reads the same buffer, so the
>>>>>>>> hardware receives input data that does not match what the CPU wrote.
>>>>>>>> Likewise, on the capture path, data written by the video hardware to
>>>>>>>> the output buffer may not be visible to the CPU, so the client reads
>>>>>>>> stale or partial data, resulting in corruption.
>>>>>>>>
>>>>>>>> Add the dma-coherent property to the venus node so that DMA buffers
>>>>>>>> shared between the CPU and the video hardware and controller remain
>>>>>>>> coherent.
>>>>>>>>
>>>>>>>> Fixes: 37613aee2179 ("arm64: dts: qcom: sc7280: Add venus DT node")
>>>>>>> Really does not look like a fix. How skipping a cache sync can fix
>>>>>>> anything exactly?
>>>>>> dma-coherent tells the kernel that this device DMA path is hardware-coherent,
>>>>>> so the SMMU maps its buffers as cacheable. That attribute is what causes the
>>>>>> coherent interconnect to snoop CPU cache lines on every VPU transaction, so
>>>>>> hardware keeps CPU caches and VPU-visible memory in sync — which is why the
>>>>>> dma-coherent property lets us skip the unnecessary cache clean/invalidate.
>>>>> You just repeated what I wrote. What for?
>>>>>
>>>>>> If a device doesn't support I/O coherence, its buffers would instead be mapped
>>>>>> non-cacheable, no snooping would occur, and the driver would need explicit
>>>>>> dma_sync_*() calls at each transition. Venus on SC7280 does support I/O
>>>>>> coherence, so dma-coherent describes that existing hardware capability to
>>>>>> the DMA subsystem.
>>>>> How does this anyhow explain your commit msg? Are you saying driver is
>>>>> buggy that it misses sync calls?
>>>> No, driver is not buggy here. dma-coherent flag is missed in the dt node.
>>> Again, no... or explain why. Missing dma-coherent is not a fix, but
>>> rather optimisation, but you claimed it is a fix. Explain why.
>> Is the dma-coherent flag only for skipping cache sync?
>> I might be repeating here — it enables the hardware level snoop between CPU
>> caches and DMA memory. Without dma-coherent, the CPU cache and the memory
>> which VPU accesses aren't in sync at the hardware level, which is what
> They are in sync, because driver explicitly MUST sync it.

No, currently driver is not calling the dma_sync*() explicitly.
It won't be in sync. That's why dma-coherent flag added to keep the
CPU cache and DMA memory in sync.
Will you suggest to sync from the driver explicitly?

If we call dma_sync*() in driver, will you recommend to add the
dma-coherent flag or not in the dt node?

> You cannot have uncoherent accesses without proper DMA cache syncing
> operations.
>
>> caused the corruption. So dma-coherent is the proper fix here, and that's
>> why I've mentioned it as a fix. Do you have any opinion on how you'd prefer
>> to handle this? Please share.
> As I told you, it is not a fix and provide arguments why.
>
>
> Best regards,
> Krzysztof
>
