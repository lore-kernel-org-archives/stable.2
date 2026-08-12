Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22BD36F8EE
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549569; cv=none; b=hbJvc9gDfUtD+xKccKqX2uQ9wWEk1DI//WTU83cSi2d+rhfUQ1tolKALmywD/w4deu5O6y421dLP31t4GFotJ12TywdPPlhWzs8A6iFhh4GkEzdL7cb/TkBRjLXEpd0Gug4yZXbrS+piNLzsGxUI865yYo74IRMpMCdOlHCYxzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549569; c=relaxed/simple;
	bh=jqyL1l0kF09CMhY6OhtHP7ayRFOweOGyvTapk4qvAOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XGCXtudQjBNr/zYe6sFvr27DOJtgRqyVCVRJD0/JpXMq1DbpunmFf+5y2DbsQC9TeFiqmtLeCddbS3GtVgSMdS0ObOwapPC9RyV6U5EjIZlX3doDcieCKXNz9GZQI+R9wsN9bD08e59WGnuKY3Zp5DQJTvbCBALRwS8AkCHzQEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RLCkMEAd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bA9/WLL8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RLCkMEAd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bA9/WLL8"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CDbT2e320236
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NaFq4qxdTWpI7rm7g/Neah3FbIy2SS31Jc7PR9Dcav0=; b=RLCkMEAdgNlO5xV0
	m5oIjihbhHyvDQ+HHWefhkDrKSJAFq6fdYzcFhC91sZzaAbOjOghQ4niEu0OMzW2
	ta8O1f8/nn6TgLGXjwD9aSaE8ubH7BksuzTg50vEuIKXGzmDYKHop9ujnClmoFM3
	8z45VKmNwAK/vi/dbRYx/o9MdeXklx8ikCGFzzwdFmIlJR7YirgI/d5XqxoXGXb6
	WQn67cpHIyrGC/TbwQEjV3qnof9CnrZYfXAI7PE7liYvlFwuVv5FRL/mtuhRB+mW
	lO41Z29AwhH6g+GOLBM3utPN64jFZX3zU1ge2MSg/4PNsfn/cczUYOgllw5fN+9m
	048qkQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0sk40rss-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:46:06 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-ca8aee88725so1524077a12.3
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786549566; x=1787154366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NaFq4qxdTWpI7rm7g/Neah3FbIy2SS31Jc7PR9Dcav0=;
        b=bA9/WLL8LmDRP9OddYA+g3MP6KCB3pZtvZt4F2dc6P/rk5QP2uEpRVPg4AZ2zvEkVC
         1UmdqscS1aN96bZGMkhYA4DW1HHwU0Az3jHHu6CS97ZDYCuENAnRLaeJS+CnR8ZVgIQV
         aEk5J0zXfp/c0er/JnN0slhUZDvREAX1e9EeqTpfSf+ghM9LGePvd0lLqWTNXCxxB1Sw
         VHj1mkvRh4sQ57uM8C6jgaWr20V5NTdBJ1CNQ2iwLy584c7YwnV4DZUmKSc2IhWvbHyn
         rRpDfuFmoJ85Bhw+oKePuwL/GONFr9Qk4Z+C8WyA6LkTj2rSbLyFU42trxemsvVpAtnM
         2KgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786549566; x=1787154366;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NaFq4qxdTWpI7rm7g/Neah3FbIy2SS31Jc7PR9Dcav0=;
        b=iDenXBKKAA5upfjUZz2hXO/ZzJ6Gd+XuLGVZxt0ph9HWlfBdigg5PTn5CA6BaMb5mS
         gNEJUr/hAj8cQ2TLK7DCi+TbymCXDdAquvMBQsZpsnEYx/vYIv+zHRIrQ8isEq+SCMil
         y+qLUL2Ks/kTD8u71xh4s3SQfALnx4CEun3qKsSgdW+AklCOUD9h2u/fQd8izPQ39m/8
         j1iax+RiNrrCNlE3UZWSxGnJk5v3Bnyfj3UmPXMekjyBTowXoCVhUxHZ3pz9fpVgJsP7
         MUbFDw++BaLVuNiiGFXAxGX85/Smw2Bl5jHssHj5mSVMq+16eV+m9wjrN1bQfGnV7uY8
         PIyA==
X-Forwarded-Encrypted: i=1; AHgh+RqtgiCbcTnJkSHaCeqrxpJBDzY661VGDhuASnfOZxg0m0GTBamfhNAUvr4b8URK8xnP5Uopf8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGwv/2QL7wMiGZYhyVy0ZEdAwLPUg1NE0z1K/QUiqw0YIBDU0
	yXnwIk9sK31EcdtCVuzEpEfgxISNDFtyAeDCs2aqV8saxSVBwJsfSLW9QKNEZewHu4jXQl6aQ3f
	dlNxUK3vHt6vmOSoKSLZ2aStUmGUBnRmLWuq07Y2s7E36BqybFOHcc+BxQa8=
X-Gm-Gg: AR+sD13Tl97tSBLD81oxiDhIYIFW0G1L5kq/BSQsFpDfF0zgplnXbp63gPd2kKxB2dm
	cmqjGBA1GKTvVFskaS06atKre+Mo8q0LPTaMLWGacQMk/j667jlM1SwJKCkiD5jZYCuaDxQ8YD7
	8cJOkj6x9TGIyfKRVx6ciV5QCtEYgffh4gCCD2kceerCI+Hqk9s3HYtRWLQeixfKxbpCyOj8mqF
	PDeY4plihSZzwXKKSYfOx2YucAcn4WPvCfUxOwZjmpJhsa2BzmeMFLAw5DIGXNySNFbDGUJTzJc
	F8WfkqLWmXFrbt5GxBTrtvq84Wl35QQfpqKLXTlbb9gdLLx3yvvctJ0KCjlYuOaTRLWnwMLPmh5
	KLU5KAesNb3zKIeZX7GKjrIjYV1UQ5ffQj0o=
X-Received: by 2002:a05:6a21:6017:b0:3c3:a7ab:135a with SMTP id adf61e73a8af0-3cc3f6eab4amr6708202637.20.1786549566129;
        Wed, 12 Aug 2026 08:46:06 -0700 (PDT)
X-Received: by 2002:a05:6a21:6017:b0:3c3:a7ab:135a with SMTP id adf61e73a8af0-3cc3f6eab4amr6708098637.20.1786549565606;
        Wed, 12 Aug 2026 08:46:05 -0700 (PDT)
Received: from [192.168.0.172] ([183.83.139.112])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14124583ad0sm10443586c88.12.2026.08.12.08.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 08:46:04 -0700 (PDT)
Message-ID: <6937899f-2fbf-4349-8c7b-1de53850a855@oss.qualcomm.com>
Date: Wed, 12 Aug 2026 21:15:48 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] arm64: dts: qcom: hamoa: Reserve low IOVA range for
 Iris
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bod@kernel.org>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
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
References: <27f0b033-e940-4369-aaa0-f08426aac73f@oss.qualcomm.com>
 <tdgbfewnlj3xypfnyckivnd2b6667laapkcfs2vpnk74bh22aa@obasatns3jfr>
 <MHRdGybtgutWtIo4EOZisrGdCVgOj7AdOArjfuxCXTTNcc1o1v40eltpkDUqZl5sOY9tjRFaY6tc_OKvzrYJ4w==@protonmail.internalid>
 <429d5d1d-92d5-4949-9991-b092cc7e9937@oss.qualcomm.com>
 <181b02e3-831e-4461-9327-ab5646380a10@kernel.org>
 <73b26356-8ccb-4a81-b626-a96de5b13173@oss.qualcomm.com>
 <v7vlh2lgvluvacmxora6l7u5r3cbhr4xaqqlzqdli5jympfwxl@5qsqc354n4u3>
 <g_hgO2Ky6WOywvRuvLUE7DXb-e7Kb8S3QoVsLbN3yhHbYzryQwZBT0VLRe3C4iVy8rUA9Tvc1Vu255IjAnbRJQ==@protonmail.internalid>
 <7caa7fd4-6732-4c80-8b8e-a0ed99631ba2@oss.qualcomm.com>
 <6906ca3c-03b2-4d9a-a3b6-2d38345d8534@kernel.org>
 <oeiqgw74eede7d3l42fgpplvk6lscpx4kjzj5iae6vrrgsxomi@wnl7cnon6rty>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <oeiqgw74eede7d3l42fgpplvk6lscpx4kjzj5iae6vrrgsxomi@wnl7cnon6rty>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: KI1x28FqCtjItz_MDdwUDk635hInih54
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX/03giD0qSwHP
 6TnY0ypTtTazlArUKzdAFIKQu2dqVSWqtboC36CT9Xaki1PjSWJG8qyzwKR4T/OkLIeD4ldjjH9
 AYEttYMYzSNwtshIJYjvxVdMSJlnm7Vs5xzJDQniNU19xyS5wQKJSfEtYAlT3JTgCkUOndQAENJ
 dMUc4HeRPoU8zAYspHd24ZbEEVr+Vv8LwOW0462QDqqg+ebnCwKhZtagcv9P1A/Kxn8O9FDA79H
 qt4xtI5fTgUgkVV2UxIDUETGRvjBvq9MTeajb3dafEGBzocyjUN5Q6NsgKJx44kCNCzcFSxn0Z7
 LZ+7dfJU5/IQIKEW9F6mnYuMkLSG7/zIRr15IjOWcqx85Hyafu8ZrYT8ncPevAK7uZadckxsGZW
 SENDjHv6ocFUetWfTkACcSAZ3lAxMUy9FOQ0fbbHqK7ceIoaVUTDG03+BSHpJLKmqBgaWbJX3e9
 hvVyBX/wQ9DB2QXR5oQ==
X-Authority-Analysis: v=2.4 cv=E8n9Y6dl c=1 sm=1 tr=0 ts=6a7c953e cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=vZaankvBGbqXg3MvYcFdyQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=H1XTA3wU2jA9kjazOnIA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfXzy8art60biRE
 bMTh7f4UiuA/9+YklnxGGjFIv5kfdEEIgrsnDtz7eFJ/JpJCrK7YSUXh5Gn/xlPQ2PmNN4FNR5I
 K3tJhdjDdflaNsFxp8/FmUQ7Eau530Y=
X-Proofpoint-ORIG-GUID: KI1x28FqCtjItz_MDdwUDk635hInih54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120128



On 8/12/2026 6:16 PM, Dmitry Baryshkov wrote:
> On Wed, Aug 12, 2026 at 06:02:58AM +0100, Bryan O'Donoghue wrote:
>> On 10/08/2026 17:57, Vikash Garodia wrote:
>>>
>>>
>>> On 8/10/2026 5:40 PM, Dmitry Baryshkov wrote:
>>>> On Sat, Aug 08, 2026 at 09:18:42PM +0530, Vikash Garodia wrote:
>>>>>
>>>>>
>>>>> On 8/7/2026 6:48 PM, Bryan O'Donoghue wrote:
>>>>>> On 07/08/2026 11:22, Vikash Garodia wrote:
>>>>>>>>>> I don't like the idea of this series, because it_again_
>>>>>>>>>> doesn't tell us
>>>>>>>>>> the truth about the hardware. This typicall ends up with
>>>>>>>>>> bigger problems
>>>>>>>>> honestly...thats all the info i have about the vpu hardware that it
>>>>>>>>> restricts non pixel to DMA from the 0-600MB range. The same i have been
>>>>>>>>> trying for a year now
>>>>>>>> You are not honest here. You also know that there are secure streams,
>>>>>>>> which have to use their own IOMMU SIDs. And some of them, as far as I
>>>>>>>> remember, also have memory range restrictions.
>>>>>>> please read the commit description again, the answer is there.
>>>>>>
>>>>>> So I don't necessarily get all of the detail out of the commit log myself.
>>>>>>
>>>>>> Could you give some detail to address Dmitry's point.
>>>>>>
>>>>>> The question as I read it is - are all of the other potential SIDs
>>>>>> covered by this change ?
>>>>>>
>>>>>
>>>>> I get the query as "secure streams also have their dedicated reserve
>>>>> regions, so how does this approach helps" - This patch does not reserve any
>>>>> IOVA for secure streams, only the forward looking subnode can assign
>>>>> specific reserve for specific streams.
>>>>> The patch enforces a common IOVA across all streams, and is good enough to
>>>>> fix the problem we have w.r.t device reset.
>>>>
>>>> No, it's not good enough. It defines that both non-secure streams use
>>>> the provided memory range, it doesn't provide a natural way to later
>>>> _expand_ it to support secure subnodes, etc.
>>>>
>>>> We know that there is a problem. We already have been bitten by not
>>>> describing the hardware as is and using band-aids. Can we now learn the
>>>> lesson and write a proper hardware description?
>>>>
>>>>>
>>>>>>>> So, if we land these patches, how do extend it later to account for all
>>>>>>>> of that?
>>>>>>>>
>>>>>>> forward looking design would be subnode, which we can land ontop of this
>>>>>>> series.
>>>>>>
>>>>>> Yes it should be possible to branch to make subnodes work on-top of this
>>>>>> - accepting that once this lands it becomes ABI and support for this
>>>>>> method must be sustained, even after sub-nodes land.
>>>>>>
>>>>>
>>>>> Thats the plan. This goes as ABI with subnode to land on top of it.
>>>>
>>>> So, do you actually plan to support both ABIs? This would also mean
>>>> moving reserved regions to the subnode.
>>>
>>> How is that different from moving the reserve region when stream IDs
>>> would also need to move, so be it for the associated memory regions.
>>>
>>>> What prevents us from landing subnodes straight away?
>>>>
>>>
>>> You are well aware of them, but still asking the same. Reasons,
>>> 1. We have been attempting the subnodes for almost a year with multiple
>>> pushbacks from multiple maintainers. We are closer and working on it to
>>> post for iris, followed by venus, once review is acceptable for iris.
>>> 2. Current solution, in this series, is much easy to apply for all
>>> kernels and can land faster so that it can fix the reset issue we have
>>> for already enabled devices.
>>>
>>> Both from timewise and simplicity wise, this proposal is made to address
>>> the reset issue, while subnode can land ontop of this, without breaking ABI.
>>>
>>> Regards,
>>> Vikash
>>>
>>
>> There is another solution.
>>
>> Restrict multiple concurrent streams in both drivers. The failure mode is as
>> I understand it only triggered by _concurrent_ streams so, restrict that
>> case in the .c code.
> 
> I think this might be the best hot fix for now. Very local, very

No, it's not. Restricting concurrency does not avoid the reset, it just 
reduces the possibility of occurrence.

> presice, touching the driver pieces, letting it to continue to exist
> even after the subnodes have landed to support the legacy case.
> 

