Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C4E1E2834
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 15:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204142; cv=none; b=Y85HcrATJvA+fwB9ll+cOLzX3Dxzi/xuWxdzTXfdSoF028hH5MQ9gfJKM+wfHXLOape7fs3E9DYxLMtgmESDYf6goMZXPUSDQ0x7fU1ne5wRPMhWzWciUxChgJwPCJ/lUk1HTKOT4BnWdBqw2QfyCOyckPgnyIk5vLTwb3OtEvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204142; c=relaxed/simple;
	bh=N8Yt2YM6rMTV/wrCpmXi61IPPAlmKt+fFV3OrTRCvV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uPp+i27Fx1Yma8Gfir2bXIIgg8PsYzhAg4I03p0wPOPJnUPQSu70oI623xEXTrfgrHjF58uz+DIIQ8cMq5b4NlrFxG6jdRpvm5Ck/rC+Ww7sO91vD3pQ/u8i5H6go5TRtSIYwGEQaHlvWIfdI45IcbVlzPNzUN4XTfpZP6KPNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MTZP2/8u; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gS+UtM7b; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MTZP2/8u";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gS+UtM7b"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 678DboGo275397
	for <stable@vger.kernel.org>; Sat, 8 Aug 2026 15:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RTmqVCewzLJ3UuxN9kqxZ/aOIecC3UmWqHTjkXzeM8Q=; b=MTZP2/8uzLzkVA8c
	cv54y2v3sv3NMO3MlwqKbreET3ZGqSjdWMlrb00w/sK4aelgfoNbjVPETYAlH6D1
	GoOkTC2HnoB/4pmMhi67oN2gLix5Yh0fCEs7F9gSRmdgnzHcUNjyvGhi2pH9T1l0
	eb8Wf+q9bLc7dbkA6iLPBiz3OhrgtMMZtMQwQ92DlRbw13GIIQc2IUcpyWjj6+Hx
	MtXq5o6ArvuKUEXsdaNfFnK8Sh24HhC2k7gXK4UATqHXflrZt3lkoCxbBAHWvIXH
	lXNurEZJG+Rzx014R/48ZlszQ92kVaQe+RTkZy2ClTmjSEiEPA4iu0MGO3PnyJa6
	XYOYiQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwuf799ay-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 08 Aug 2026 15:49:00 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c9c26587e67so509971a12.0
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 08:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786204139; x=1786808939; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RTmqVCewzLJ3UuxN9kqxZ/aOIecC3UmWqHTjkXzeM8Q=;
        b=gS+UtM7bKzCfP8ipe/YeKlLQ6fwIoN21jxuacNcvY3q8kQyD9reLVdCllKrPaf4n4+
         IPq1nxsIq43QNBZ8y0cviN1Du6t1tV3Y6Tnvh3JgOiFNndq6CehXxc0F689sGbaSMiAh
         47XARr077ivWBuTARi25q37FtYl4+nElWfU0xWQUnvcz2E3L3fC0B48GYDV7tZ13locG
         j0Xc9RPnWq//T0a43sTsxc+jK10djTDqY/LJib6K/QvISLujB9TDl7+JV1631wUEtAwZ
         Z4p0RIKuF+QuSzTpMzyFvqmIEqHfyhIP11gIV6BYwMcArmffnlIsP5NiUMUU0C8U+ygc
         sfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786204139; x=1786808939;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RTmqVCewzLJ3UuxN9kqxZ/aOIecC3UmWqHTjkXzeM8Q=;
        b=iQ5uRraYQ8JfaweGW5ReRD5vm0VYpkUsb9viNOaQCcSQJCXHf6M9FrSD1b88y0TcVc
         GJidgIJh2Y2gxHknSMXh109Q6zwVSY5Gznzw6HLn2opFet/1rg1pRkRBEqSvueO5cgD7
         yAs1DNDD+bae1DcqtsfSBfth2kxPvgzB1dkAtke/CgjzAooolBwkp5MItplAsETFnwuB
         w+1L387cRQ3JgyunFf7k5hnAzagoYNWMMuOJYtqTFpuulNXHVijDkW5zexKS1YGbKb0T
         ykOrbbtUOqA7ad9aXvMwiX2+clbMILYY4IllVsD7JNPOpnySdZuNr0wCBotKDJTSSrTa
         T/yA==
X-Forwarded-Encrypted: i=1; AHgh+RouhJ2Taj4ZuhX36/VlUEpGE7p/3+v9v0iyw8+74/1+W+5sLPDAUM31HHszT+CTxwKnWPk8kdY=@vger.kernel.org
X-Gm-Message-State: AOJu0YytEkeDzphoMghUvbemhr31fF6HLQF0m9DAL3IxbXB+VSxSLDov
	S9FOSykBzBVQW8GOVFP1EgLAk/Wv5OysuqFnhDHJvnhXLqXOBmKUEhNRRZaKyjPEtXT1/MV1BPE
	RUfWy/wKwB5RjNt1zGbrkmhzZmUEg01SQYHuEYzExugHFeBVBvEjjb14GdLg=
X-Gm-Gg: AR+sD13uh+UwNnutJ3P+UnijYP+R0uGDbJ1FZ/eBtaN9jD8boll+Msq8HrA1J3SV+om
	E5tcsU/4xtOtMToOjcoWIL3DiEqlGKiOnU3va1qN8jYkb+XPIbox9MyzBIwA7oEMe8Gph+uGFae
	cQvQgaPlqa75cN2+95BATT1CGaaUdoZ2mmeK12Ia0cc0x/ysKHzvRbqUX1dRNE5R2+ai7bTHGiZ
	TSXhOkKdzpfhzpaF4ocftF/vlNO/jGYUjbaaG+OABvYea+jqI90yNhwcCIrbUCIUv/NgvmB5/BN
	qslot2L4sK9swTbKZVgnsgF3Y4n+YXIM5np5far5Tb+N4GlfKtcmSUQjTh0yuIF3QUc7UeiD5ZL
	P1r8yMXdbu2P6R0/HL4kBzP5cJbchdtmdiLo=
X-Received: by 2002:a05:6a21:9983:b0:3a3:adea:83bc with SMTP id adf61e73a8af0-3cbd39aad61mr7173137637.15.1786204139237;
        Sat, 08 Aug 2026 08:48:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:9983:b0:3a3:adea:83bc with SMTP id adf61e73a8af0-3cbd39aad61mr7173066637.15.1786204138737;
        Sat, 08 Aug 2026 08:48:58 -0700 (PDT)
Received: from [192.168.0.172] ([183.83.139.112])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315bebdf796sm19528407eec.22.2026.08.08.08.48.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Aug 2026 08:48:58 -0700 (PDT)
Message-ID: <73b26356-8ccb-4a81-b626-a96de5b13173@oss.qualcomm.com>
Date: Sat, 8 Aug 2026 21:18:42 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] arm64: dts: qcom: hamoa: Reserve low IOVA range for
 Iris
To: Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
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
References: <20260807-iris_iova_600mb_fix-v1-0-3996f67e33f9@oss.qualcomm.com>
 <20260807-iris_iova_600mb_fix-v1-4-3996f67e33f9@oss.qualcomm.com>
 <ruow4uus64krlpy2gvm3g2d6rq5kgmgxnlhstmecil3gw7lhkd@2golvucd473l>
 <27f0b033-e940-4369-aaa0-f08426aac73f@oss.qualcomm.com>
 <tdgbfewnlj3xypfnyckivnd2b6667laapkcfs2vpnk74bh22aa@obasatns3jfr>
 <MHRdGybtgutWtIo4EOZisrGdCVgOj7AdOArjfuxCXTTNcc1o1v40eltpkDUqZl5sOY9tjRFaY6tc_OKvzrYJ4w==@protonmail.internalid>
 <429d5d1d-92d5-4949-9991-b092cc7e9937@oss.qualcomm.com>
 <181b02e3-831e-4461-9327-ab5646380a10@kernel.org>
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <181b02e3-831e-4461-9327-ab5646380a10@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDEzNSBTYWx0ZWRfX0LuedS4aHerG
 x6BiH8HfYs5qynawHuThVfDQ6YN8+ZxU3LpcZtR+7u3MovWbOxPIQwgmCiwzGKNBYx+98lK/LzY
 RXt5y5KFonT1FUIr1GkfVjt1hPstbik=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDEzNSBTYWx0ZWRfX3cRmBJ4mSIPk
 Xd2p1ygoQk/mEQvtiCImTmlQiqkVQ78hFlBn+RfW3JquZHsURWrA4gRK85cXujTQAVLRhxNlz2Y
 0pwYpcBhx3Do/neCRGNJixPus4DFXNR3mtUzvM5cwIaCDdXT89Rhb6959nw0ad9X0Ne182WU7YW
 M4c7YOPvhCvyOINyQWnv7ZQ0Riy6yeGc2aGheDp/VbT/JcFwPDFhVQHl4wiJRYvUr7OohmljAis
 XsBA7C0Et2UStMkCEVkNSEPG3aJxXZ9/JvQGxnC3GTqUK959VSQ3Oob0TbWtdL+/i2ZHNZRhVpP
 rm3ZqDzOKv7dmhE3HGdDvwRfjw4wKcjsKuzOVNE4SDYzriKb54VQxtrUlA1/fHvWzY7GcKTkjC5
 6XsME8KR0oIbkhvlzDGBvJIy6kWqbHs6+1xmkexgQ5nFWrFemCPDGY4dSwOEdOIkm0tOV4D/QDp
 HziD51HlgguPv/u5mEQ==
X-Authority-Analysis: v=2.4 cv=ecENubEH c=1 sm=1 tr=0 ts=6a774fec cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=vZaankvBGbqXg3MvYcFdyQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=GtVQ2Xx2KDLxgnwpovAA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: DhHUGzOtdg1NbNVN-_vrvhJ4GXNmZ_65
X-Proofpoint-GUID: DhHUGzOtdg1NbNVN-_vrvhJ4GXNmZ_65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_05,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080135



On 8/7/2026 6:48 PM, Bryan O'Donoghue wrote:
> On 07/08/2026 11:22, Vikash Garodia wrote:
>>>>> I don't like the idea of this series, because it_again_ doesn't 
>>>>> tell us
>>>>> the truth about the hardware. This typicall ends up with bigger 
>>>>> problems
>>>> honestly...thats all the info i have about the vpu hardware that it
>>>> restricts non pixel to DMA from the 0-600MB range. The same i have been
>>>> trying for a year now
>>> You are not honest here. You also know that there are secure streams,
>>> which have to use their own IOMMU SIDs. And some of them, as far as I
>>> remember, also have memory range restrictions.
>> please read the commit description again, the answer is there.
> 
> So I don't necessarily get all of the detail out of the commit log myself.
> 
> Could you give some detail to address Dmitry's point.
> 
> The question as I read it is - are all of the other potential SIDs 
> covered by this change ?
> 

I get the query as "secure streams also have their dedicated reserve 
regions, so how does this approach helps" - This patch does not reserve 
any IOVA for secure streams, only the forward looking subnode can assign 
specific reserve for specific streams.
The patch enforces a common IOVA across all streams, and is good enough 
to fix the problem we have w.r.t device reset.

>>> So, if we land these patches, how do extend it later to account for all
>>> of that?
>>>
>> forward looking design would be subnode, which we can land ontop of this
>> series.
> 
> Yes it should be possible to branch to make subnodes work on-top of this 
> - accepting that once this lands it becomes ABI and support for this 
> method must be sustained, even after sub-nodes land.
> 

Thats the plan. This goes as ABI with subnode to land on top of it.

> ---
> bod

