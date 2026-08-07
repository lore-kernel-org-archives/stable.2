Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DBD4248AC
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098153; cv=none; b=gN23af6adIUJQVOIHet8SyR/j2YKq0FdAjoZSf5vgqEW8dXUnizVm7XqzKZXDXKLBch4KDELkghVzIUppxToYJkhBS9aY0u+lzlYm8DIuGI1MqhZ7g9H1fOjY2+VTj+ulLLybukTWnYfcQsPHTbb0OAgS1qgKGKC+8cEW9bpSaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098153; c=relaxed/simple;
	bh=7zkyUWwkB69eCRYNVOott12JcB3HyoSQ1gvyGaXCpXk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TOATZJTcyCZ4czH+kAKURNzp9Lcs2c4alZqfoK8cwS/UAKqbdTkwvSFJ93t8rcewEzXAtZxf3rFALdJHwJXLpOfVZTmjLhv+YhAU/f1ikKOe8UgKtdXrLYA/lYfAikObz+tDJJ8ZOjMDOzVOe2ahMkE9wBD9zzSHbZRbEQK/QkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j876Lv27; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PHyT+MG3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j876Lv27";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PHyT+MG3"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67783tKl3251830
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 10:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RQctFQu5cMeG5fr/LvJoKgC8qsXR7V5CESvfC5rs/PM=; b=j876Lv27IBsPJGHX
	Bo+hLjcNn2B14hUmoJ7L6eWSlx/k/y7ZFqoi46hiHO6sTlMnqYBLAd52xN3U/Dtr
	qAM+NST/8GDHXXLF1O8pq5X61KwxdZM6CGXSrkVv/aska9K7kXKM7kebWwJ+DlRG
	B/CfDxNLPr+ACzLBc/9+QTYs73mVmcrrqLakdWWYJ9JPEWdKMMejoTB58mUx4lsn
	jMSLgypnNwVQO31IdGfvOGrBgUPL9aqAF8dZ1ItLn16BeUtXSj4A59gjMYgUF+5r
	CKC7yxUFYr68oG9VHePqr3xKucSQKEFuwbTUXvF3xjJsyAFni0cTRNpWJwJ0oz/k
	qDtwJg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6k3g1k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 10:22:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cee1ec30f2so40159635ad.3
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 03:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786098149; x=1786702949; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RQctFQu5cMeG5fr/LvJoKgC8qsXR7V5CESvfC5rs/PM=;
        b=PHyT+MG3cJPdY28BR27Z/9OvAPs1a4uy7BRT+yVQILgZRsWnbH1XqapVeRs5BnFXsx
         tb9CZ6V3tOjaWVPbhqPBEtWVJQX9BZ08tNKTga1Itr1I55KilIcJRSYZe4hoXy7AhgoP
         4sNWS6SbAYfEhWBVFC2p+PquGxI+FTBEkurI1ISjL3pe5trbA0nCJHWYWPMlM+OHR2MT
         nwodnCHMTu5+MSPmHRD8I16VW7Mq56cFgQJ9VFaNBFtUzwXgaoHfRw2CjksdH6E2RDvE
         4XjnvR/xJd5LdERFQanytGdauCAZkV+vkUSpJqc2Va4Ux6s3+TfHT81GRDhv4XIPgTsF
         GLXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786098149; x=1786702949;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RQctFQu5cMeG5fr/LvJoKgC8qsXR7V5CESvfC5rs/PM=;
        b=fRTqeOmMuSpSviBucDgG7+v7/of63WlilLDP3Mrdihw5EuVoWIWSys2iwakE3NDb3G
         IiFkshEf0Vjh9TzsW+BmUGQv3qJvYC3ZrzP+pjLYpKjqxwBYZx+Hdsvb7Lxl6OTiKTYr
         aZ4bdEYd3Q0KT+qCBDHLN+L/4cjm03olXxVy5JXjA/gwvH6CJFttXph9J/aEkwS6an6A
         NPkOeveBwWq5thzuLi6JRHWFe7JYnXvNgzIcL1Ae+R7hX5aKOgjjBMDQEM5IPVFbUD2z
         DkkjLIfy/srFcjJIAwg/of6gkHalhtxyOcqYEhvL2Rgx+1T8AlzswUBfH10Fdh7aB1Kg
         6vrA==
X-Forwarded-Encrypted: i=1; AHgh+RolyK33tPmqjdYC5H8/n/t7tBS3F8A5dP4YXmgLgDRNLm/K3i/1ncSlfDVomZ1+pHILd+y7Kuo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6svywi5vSubuF3LOlfTANGBcH0flUMoiOY3NuFkKyFqeH5paC
	tcX/x4Vka2V4CUuLyNHBdgDg0WzmyzGWL8lxFQyNMVH8dRYTBiBhqE7Vf2fwfO+NGzIEOHCF2Wg
	Vt/NenIHm9t57uUyU00yKxWQvMubupeW0rB8WwWAXp0D6SOFAVWpmJHeIN5E=
X-Gm-Gg: AR+sD13q7BPM67Vw88vVN5VmL9wTsMxJUMu+K5bgEjMmvOPBxG2oHz2NkHHbmaS5G9N
	lo/nBpt8BzBwWgzXv69N9rJ9JfiqsGqR+RnVBIvl9qfZkuSkMN/pS29ompG4LJ7sW5ZEtlZyHTN
	Ckuwfl/iT1GGIYEV5W10lYrfslUwfJqT6zTY9MRQgau83t8HAPuVxPsa9GcjrSXU8YNT9+lrZeX
	xnEb74v5tNJYJgIz/sSiSmPCGes2IGVvuKvDK6I+O8ua2Z61WqjZryBCWGh5WjYA9pu29fJCWaI
	ca/HXOf18BrEeuSJ0LX8KnGpxr/jK67f8DiUiAvfgHZxSFbdFk+9pc4111lnel+idnTUTzIXvJi
	ctxOzkeyHcxXMKMdtDi/Y1MOwmzTR//V0ttc=
X-Received: by 2002:a17:90b:17c6:b0:38f:1a2e:6e56 with SMTP id 98e67ed59e1d1-3903c59330amr20917465a91.9.1786098148998;
        Fri, 07 Aug 2026 03:22:28 -0700 (PDT)
X-Received: by 2002:a17:90b:17c6:b0:38f:1a2e:6e56 with SMTP id 98e67ed59e1d1-3903c59330amr20917408a91.9.1786098148489;
        Fri, 07 Aug 2026 03:22:28 -0700 (PDT)
Received: from [192.168.0.173] ([183.83.142.146])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb88413sm9100037eec.18.2026.08.07.03.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2026 03:22:28 -0700 (PDT)
Message-ID: <429d5d1d-92d5-4949-9991-b092cc7e9937@oss.qualcomm.com>
Date: Fri, 7 Aug 2026 15:52:12 +0530
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
Content-Language: en-US
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
In-Reply-To: <tdgbfewnlj3xypfnyckivnd2b6667laapkcfs2vpnk74bh22aa@obasatns3jfr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=RpX16imK c=1 sm=1 tr=0 ts=6a75b1e6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=eVbXwf39F0J6/s7D6zfB/A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=t9ty7G3lAAAA:8
 a=EUspDBNiAAAA:8 a=klHhFlPy27of03slvZkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22 a=CsAS6f0m0zARWR-uHzm3:22
X-Proofpoint-ORIG-GUID: 9xeQOrxKxe11cXPSzpUzDaNhpsGvPVIw
X-Proofpoint-GUID: 9xeQOrxKxe11cXPSzpUzDaNhpsGvPVIw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3OSBTYWx0ZWRfX1zBztUG5nSmo
 aC+YfFuZgZXBSkZS0Dj4W8dHjvicqq+/+FKmR2yUimp+PYC/JxGYlaFFwForSrrJc19ga1dxmc3
 2A2uCNhuCJUVJFoWfi/qKwfzlYWNfl2xlT9dzbK2eTecUDH8X0MB6X5tAiiZ+Hz913Cm7TpgFNN
 MEYnuNtjwcvxzJrUSVWAA5GE43dIWx95SiFs2cCgVABjzzBIqP41M2U19KdgC6+M4PL2ua/WVIN
 cKlGlZ2aV5nCZgyMw8HBz3b9+xU84mFCaAM1aPc7jsTSWDnwR6uPJlbdOt8suMr7DCf0uji8Y+5
 XHNy0xMPhOFQUA0shdVmBsDkAQj/w7PVaicPJq9GcS32tlZqYpYxUz7xqWJJKQ817hfzdIhtjfR
 aSlj73/vhQW4J8YNg38sNIah62UTAfi0+f/eWI7hiQrWlotr67z1V4rew9iuA0X0HGWsbleD/Et
 YfirLJDO5G+bMXGEUmg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3OSBTYWx0ZWRfXzJ+jH+eKCoMG
 N1/H+sCxcTFmWdrhiXnjOuRgxL6MIVYiMHtUZrwWQjpeMhhoS2F9HiJ/4aIdwpFBvkHmxQub05l
 1BdCOfgr1MFcHJ3vII9muiNvj9mYQHw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 impostorscore=0
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070079


On 8/7/2026 3:30 PM, Dmitry Baryshkov wrote:
> On Fri, Aug 07, 2026 at 02:56:27PM +0530, Vikash Garodia wrote:
>>
>> On 8/7/2026 2:33 PM, Dmitry Baryshkov wrote:
>>> On Fri, Aug 07, 2026 at 01:54:48PM +0530, Vikash Garodia wrote:
>>>> From: Daniel J Blueman <daniel@quora.org>
>>>>
>>>> On X1-family hamoa platforms, the Iris VPU reserves IOVA addresses
>>>> below 0x25800000 (600MB), primarily for secure non-pixel buffers. DMA
>>>> into that range, from any other stream id would triggers unhandled SMMU
>>>> page faults that cause spontaneous device reboots. This is readily
>>>> reproduced with one or more browser tabs driving multiple concurrent
>>>> video decode streams.
>>>>
>>>> Add a reserved-memory IOVA reservation node covering [0, 0x25800000]
>>>> and reference it from the Iris node so the IOMMU layer keeps DMA
>>>> allocations above that boundary.
>>>>
>>>> Link: https://github.com/qualcomm-linux/kernel-topics/issues/1157#issuecomment-4458933574
>>>> Fixes: 9065340ac04d ("arm64: dts: qcom: x1e80100: Add IRIS video codec")
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Daniel J Blueman <daniel@quora.org>
>>>> Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
>>>> ---
>>>>    arch/arm64/boot/dts/qcom/hamoa.dtsi | 13 ++++++++++++-
>>>>    1 file changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
>>>> index 8a96ea1bdb9c4c409b2af997680d8c13fed0643e..87f424765d513c97b06303bceb75ca9f176d2ace 100644
>>>> --- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
>>>> +++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
>>>> @@ -666,6 +666,17 @@ smem_mem: smem@ffe00000 {
>>>>    			hwlocks = <&tcsr_mutex 3>;
>>>>    			no-map;
>>>>    		};
>>>> +
>>>> +		/*
>>>> +		 * The Iris VPU reserves IOVA below 0x25800000 (600MB),
>>>> +		 * primarily for non-pixel buffers using different Stream IDs.
>>>> +		 * DMA into that range triggers unhandled SMMU faults and
>>>> +		 * spontaneous reboots, so reserve it to keep IOMMU
>>>> +		 * allocations above this boundary.
>>>> +		 */
>>>> +		iris_iova: iris-iova {
>>>> +			iommu-addresses = <&iris 0x0 0x0 0x0 0x25800000>;
>>>> +		};
>>>>    	};
>>>>    	qup_opp_table_100mhz: opp-table-qup100mhz {
>>>> @@ -5439,7 +5450,7 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
>>>>    			interconnect-names = "cpu-cfg",
>>>>    					     "video-mem";
>>>> -			memory-region = <&video_mem>;
>>>> +			memory-region = <&video_mem>, <&iris_iova>;
>>>
>>> I don't like the idea of this series, because it _again_ doesn't tell us
>>> the truth about the hardware. This typicall ends up with bigger problems
>>
>> honestly...thats all the info i have about the vpu hardware that it
>> restricts non pixel to DMA from the 0-600MB range. The same i have been
>> trying for a year now
> 
> You are not honest here. You also know that there are secure streams,
> which have to use their own IOMMU SIDs. And some of them, as far as I
> remember, also have memory range restrictions.

please read the commit description again, the answer is there.

> 
> So, if we land these patches, how do extend it later to account for all
> of that?
> 

forward looking design would be subnode, which we can land ontop of this 
series.

>>
>> https://lore.kernel.org/all/20250627-video_cb-v3-1-51e18c0ffbce@quicinc.com/
>>
>>> later on, when it starts to affect other bits and pieces.
>>>
>>> I don't want to NAK it, but I'd strongly ask to reconsider it.
>>>
>>>>    			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
>>>>    			reset-names = "bus";
>>>>
>>>> -- 
>>>> 2.34.1
>>>>
>>>
>>
> 

