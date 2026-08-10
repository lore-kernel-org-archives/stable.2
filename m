Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326A342DA5D
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 16:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381071; cv=none; b=DQFWuVp8UFn4Udat7KX/2tYCzOfKubhVSMKFc+uChO7VHQWGvJmHGqA/RqxBZOd29Li0y2a5E6/XNRaVe9+RWnSHt0xx5EIHKk9vMCdsc+Z+jfewvTN+rAMa8RfMR166ll8NGRdL+aO1+HSkLtrGnPTptwlGU4a8TVSUCjDtMqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381071; c=relaxed/simple;
	bh=ysfqfXPio134Qd8d8OvVqS8aWsQYJnFC+iPjlngYUsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlM7T0A4IIoTjsUCj0e3Ku/zRnSBU0JrdyX012Pm8IzSO9eK1CRY2JBJ40o5PgCcyX+vX0DgdfLkOJcVKxrB0Dw790rHnf8TM9eDaeFhlQcOuglQmA9KlglpC98Csm5/Y+GE2OaVQgI5nyDZBk6yDwpawEzZQVN7daxA2ukB4yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=M3KMeGL7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AkjA/TKb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="M3KMeGL7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AkjA/TKb"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AGDwmc880825
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 16:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QSdGRKjeM4r/MTfTpNKxuTG9yGYcCn3iH+71thLM5wQ=; b=M3KMeGL7JRfcGzyC
	YBsv9/wdmwMXNZDFVQEWvnLOzz+70kyIa4JgWuOzgZdm8F1IIttsHv7on5jZQAeA
	ZF+eTFY8DTRdqY6QpYfBYwA3EiE82puRfyAh8fCu2jr5DtfL6KfimpWSC6wuyv1u
	lS+TX6LwrvsamCqobC0O4UEjnJprnW+sObmzATvB6yL9z0jZBFG2juhGXkAuxsuY
	d9Qv06q8ws6c4JqoTStqzxT1OC3+rcEysk7+GDX5JsYt6DWBqkwV3V3Deo101uJr
	Xo4Md7Ka3nGyHg00QPUOTjbKISsQN+g1lEmlXXkX+CcOxIwqeu69icltusiUHY8O
	unIUFA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fycgest30-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 16:57:48 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so2880121a91.1
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786381067; x=1786985867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QSdGRKjeM4r/MTfTpNKxuTG9yGYcCn3iH+71thLM5wQ=;
        b=AkjA/TKbp1NtSBE6+TEVAJRPJXb/p8yxXBS+ReBq5/ro7Fw6zUq1aH3rJDFqqGCYp2
         bGY4NXXZE9/niQ8zHlQyZlXmA14gaJPGE2FM79f3uDeXXaPuvVYm3S2b8pctFLu7Fnks
         +zqwJsuSN54ALJUtgbxBYnX03gFxyhumgQiJFjsmPg9QrnxY7kMhHQ5+9KIeLZo+aeZF
         ZUozXq7ZNAgoJio6YnVKDQ6Ukil7EBLgR6niYCkvhaee04SjBbcnsrayks1/qKEgQN7Z
         qKNlUz8bBsDr3vi7oUTAhPnLx7fm1aYjbqh+ygl232DUdJt5yMFrNO90skznByTeD14Y
         GNgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786381067; x=1786985867;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QSdGRKjeM4r/MTfTpNKxuTG9yGYcCn3iH+71thLM5wQ=;
        b=ekBeBB4OylwkE1chWe6mqd7pzHW3uyQlEKqbYn4k6PT3EFhy4qnVqHJZQJwkbrr4jx
         1VLmXijGtssyzco9dNY3uMU+RJkOyp9BhskbARaYGzPHLC1rTU1PdyIqpikU2LxbN9ID
         s0zEVHakL7LfKG4yHy4Fz7sRwOxObrlrfxPt5zchCQsR2lSFYG7s9qiIipew43jaXEX+
         jT7HMRnWsIs+qdHaxEW65q4GQhoryR/Mmhhzlx+AKFKPJ/Xrue7VRem5DTs629Can+Nf
         IWe0Yy+1N4JHJw5rUYRVT3WZFaALEOZHU9EnKxE3hrK1lmlF67GlN1KLwUnTUuYWTxk1
         tyfw==
X-Forwarded-Encrypted: i=1; AHgh+RremaR2F3N+SGGGddmlEFhsEQWkjBatUxJ3aiGKcViufkDPLXQC3HPZm/O3Pt4e9STDli4/pa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhdlfP+2FFbIYmTCCAnuOWMUg2o7t/I0nVFcGWKGxujJWQPr3S
	2l0xzcGQCzDAlV7A5wTREu5zmA/e65hfrA/1VijWSk61XgaeB0C+Y+apg1Dm0CossLi+zKGNlCt
	cDrQtP8ptRk+tcWg6ShyRyBUszp9y6NiW7Fbgi3jWsh2v8qIeUzoOMpc3FqA=
X-Gm-Gg: AR+sD12cI85osPCz8G8JZFfXRNZAy5t/G1ZAnZ4QQS2p2wFzukz5VNiFstnH2z32Kcq
	dMoMNsAy2swKDSqht2iGhoao8k33FRmeN9Omhfy9z+zSSwN4lOHhDdZwYlaAuIc0O5ai0E5k9ab
	W5OU3ELm50/RJIbvKqnlncTY6/4W2jG3UrjbkjTaITGjhuNM4PbQebOwTZ+jQupPoudtPmAp02Z
	qXGfJc5mXul6vduO2B8WUCyTiWmIZWiK+XlFWphlKC2hTrNu8400uiSmroW/3WMv3EpnSjLkoZn
	0nGmayXqkjzPyY/JqPWfbOrYRgIM0X4nMGd0i8cw6r4bNwMdltXBX2ul5oSDGlCUaVZgz6Z2XZw
	lKy/XlkQburma74im8NlVFBU7Cmb6mY+CT2s=
X-Received: by 2002:a17:90b:3c0b:b0:381:3b5d:30f4 with SMTP id 98e67ed59e1d1-392cc8d0454mr3334152a91.1.1786381067377;
        Mon, 10 Aug 2026 09:57:47 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0b:b0:381:3b5d:30f4 with SMTP id 98e67ed59e1d1-392cc8d0454mr3334065a91.1.1786381066917;
        Mon, 10 Aug 2026 09:57:46 -0700 (PDT)
Received: from [192.168.0.172] ([183.83.139.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101b7a772sm37165790c88.12.2026.08.10.09.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2026 09:57:46 -0700 (PDT)
Message-ID: <7caa7fd4-6732-4c80-8b8e-a0ed99631ba2@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 22:27:31 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] arm64: dts: qcom: hamoa: Reserve low IOVA range for
 Iris
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        Rob Clark
 <robin.clark@oss.qualcomm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Pierre-Hugues Husson <phhusson@freebox.fr>,
        Marc Gonzalez <mgonzalez@freebox.fr>,
        cros-qcom-dts-watchers@chromium.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Aniket Masule <amasule@codeaurora.org>,
        Malathi Gottam <quic_mgottam@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Jonathan Marek
 <jonathan@marek.ca>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Renjiang Han <quic_renjiang@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Daniel J Blueman <daniel@quora.org>, stable@vger.kernel.org
References: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
 <20260807-iris_iova_600mb_fix-v1-4-3996f67e33f9@oss.qualcomm.com>
 <ruow4uus64krlpy2gvm3g2d6rq5kgmgxnlhstmecil3gw7lhkd@2golvucd473l>
 <27f0b033-e940-4369-aaa0-f08426aac73f@oss.qualcomm.com>
 <tdgbfewnlj3xypfnyckivnd2b6667laapkcfs2vpnk74bh22aa@obasatns3jfr>
 <MHRdGybtgutWtIo4EOZisrGdCVgOj7AdOArjfuxCXTTNcc1o1v40eltpkDUqZl5sOY9tjRFaY6tc_OKvzrYJ4w==@protonmail.internalid>
 <429d5d1d-92d5-4949-9991-b092cc7e9937@oss.qualcomm.com>
 <181b02e3-831e-4461-9327-ab5646380a10@kernel.org>
 <73b26356-8ccb-4a81-b626-a96de5b13173@oss.qualcomm.com>
 <v7vlh2lgvluvacmxora6l7u5r3cbhr4xaqqlzqdli5jympfwxl@5qsqc354n4u3>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <v7vlh2lgvluvacmxora6l7u5r3cbhr4xaqqlzqdli5jympfwxl@5qsqc354n4u3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: aJx9tNp9QyMDZcWQC5q2dWYyhZdwH0rU
X-Authority-Analysis: v=2.4 cv=R4cz39RX c=1 sm=1 tr=0 ts=6a7a030c cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=vZaankvBGbqXg3MvYcFdyQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=AauyIVVOzEBGxx0bfrQA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: aJx9tNp9QyMDZcWQC5q2dWYyhZdwH0rU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE0NSBTYWx0ZWRfX58rF4tXPaw59
 GKTFyfg/MdsSqRJrUr9f2TVj+mfaiplbXOhWtPvPH7Ps9usZC15nqXP+dFgr4ULZ4Wt0j5qaZ9r
 wBSsDDtakf1B2rYuMeu/DwNFnzYe8Wg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE0NSBTYWx0ZWRfX4REWScp4A+SE
 gC3qo0BcPj5Ytp/kgUeKYxxtXsqzJocHwrzgd9Q0615tDjB0AD2xBi0PJtZ/zXN5j+G3oF1wEm/
 7+bkylI1efBNRZ4x9HAKx2uuz2QvndchwJeXs46Nyy38m1Fgd6Up/EXaTOvMIrzpkOophyHG+zu
 xtzXCwPdGf59a5yjTpU4fy/Iz1q5J57xjU80RiJJtP6F9qC5kKxv5F5EsmLNmtzsBOOxcLqCgwT
 1HGxwudR5CbMBwv8Ae2FClBenNE2K+l96zSmWaf1NqXrd39WvvLdwitHEs14C5YgJwTZxbs0b3z
 ktvn1kWY/DiIGUDhvsM2OEeRvvv1tLV+UWRTIqgnRag1Z6RDm3lxEdTceByFS/4R9oKI5ZccvZ6
 2p9hLuhWjcK0JhmkTFpVrt4BE3UXzSpGBGDiyDIx/ijT6oLVtQOfVBIYV/tH6iWzg0UBGzF/RdZ
 I91JBId+aiXlzo0ulmw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_04,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100145



On 8/10/2026 5:40 PM, Dmitry Baryshkov wrote:
> On Sat, Aug 08, 2026 at 09:18:42PM +0530, Vikash Garodia wrote:
>>
>>
>> On 8/7/2026 6:48 PM, Bryan O'Donoghue wrote:
>>> On 07/08/2026 11:22, Vikash Garodia wrote:
>>>>>>> I don't like the idea of this series, because it_again_
>>>>>>> doesn't tell us
>>>>>>> the truth about the hardware. This typicall ends up with
>>>>>>> bigger problems
>>>>>> honestly...thats all the info i have about the vpu hardware that it
>>>>>> restricts non pixel to DMA from the 0-600MB range. The same i have been
>>>>>> trying for a year now
>>>>> You are not honest here. You also know that there are secure streams,
>>>>> which have to use their own IOMMU SIDs. And some of them, as far as I
>>>>> remember, also have memory range restrictions.
>>>> please read the commit description again, the answer is there.
>>>
>>> So I don't necessarily get all of the detail out of the commit log myself.
>>>
>>> Could you give some detail to address Dmitry's point.
>>>
>>> The question as I read it is - are all of the other potential SIDs
>>> covered by this change ?
>>>
>>
>> I get the query as "secure streams also have their dedicated reserve
>> regions, so how does this approach helps" - This patch does not reserve any
>> IOVA for secure streams, only the forward looking subnode can assign
>> specific reserve for specific streams.
>> The patch enforces a common IOVA across all streams, and is good enough to
>> fix the problem we have w.r.t device reset.
> 
> No, it's not good enough. It defines that both non-secure streams use
> the provided memory range, it doesn't provide a natural way to later
> _expand_ it to support secure subnodes, etc.
> 
> We know that there is a problem. We already have been bitten by not
> describing the hardware as is and using band-aids. Can we now learn the
> lesson and write a proper hardware description?
> 
>>
>>>>> So, if we land these patches, how do extend it later to account for all
>>>>> of that?
>>>>>
>>>> forward looking design would be subnode, which we can land ontop of this
>>>> series.
>>>
>>> Yes it should be possible to branch to make subnodes work on-top of this
>>> - accepting that once this lands it becomes ABI and support for this
>>> method must be sustained, even after sub-nodes land.
>>>
>>
>> Thats the plan. This goes as ABI with subnode to land on top of it.
> 
> So, do you actually plan to support both ABIs? This would also mean
> moving reserved regions to the subnode. 

How is that different from moving the reserve region when stream IDs 
would also need to move, so be it for the associated memory regions.

> What prevents us from landing subnodes straight away?
> 

You are well aware of them, but still asking the same. Reasons,
1. We have been attempting the subnodes for almost a year with multiple 
pushbacks from multiple maintainers. We are closer and working on it to 
post for iris, followed by venus, once review is acceptable for iris.
2. Current solution, in this series, is much easy to apply for all 
kernels and can land faster so that it can fix the reset issue we have 
for already enabled devices.

Both from timewise and simplicity wise, this proposal is made to address 
the reset issue, while subnode can land ontop of this, without breaking ABI.

Regards,
Vikash

