Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00F9288C81;
	Wed, 12 Aug 2026 05:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786511001; cv=none; b=C4hOmcW0hpQ37oPuzxpszEVNDmd7Zpw6JbcMe2D9c+hQf9w3aO3PEyI2ypmauBjn2mpaGCathLcLgJepQBTHZU4MjUZyaT5QalNOnLgVEd4vFituaUNM6vD9LI8/CVbjaiWnU52jIrpj8mhupFPRuMW4hOcBVsAXCcrWWDazTWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786511001; c=relaxed/simple;
	bh=45c9Mw+RtUpfsCt03yp7BPZDMVxg9SOCXgQtlflD+eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2nUgLztiI8V0PHPeT8qqhR4Ds/kg/xBCek6iOfwF0+Hbfc5mt3iv1nwP5EqxJd66Dr+Zqj2YdP1O+U7arwiizEtiyN+fSTSJUxkUww37xHEyjatn1Pxl+y3O4iI/RT4IQEW9k6PKJ5poo8OUsZ2KpPPxp/pKJ93l2j8AiG/ZQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lSFJzf+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lSFJzf+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3C81F000E9;
	Wed, 12 Aug 2026 05:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786511000;
	bh=AG9V5QM/LQXyVzTFmXGwnlr2XmuiKwvic52wSwqRFzQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=lSFJzf+q9hmSN5emquAz9I3IscJsmGq5T3KpusvnyFpGD4/i/WjIpPuCtjvTsHC2l
	 pCvfKHl8O/ubf46hB7lvrncAx5enJIzKUPk/tRW6uzf3jOtrDMSqHFzpwZPtIvaFRA
	 d1P9Hcx4AI3iNHwGW/UHpGB4tMZEK7mhUJN5BQG1UrITNQTRfUNg6NbxYGS3zkKfCR
	 GaI9EJvJcgzDPNJso37s3yhasCE0zf9jHzRMEvO/PoWp39v6Vxb1gfozUSMc/vI3BL
	 MxDMYr9lKRVO0GzfmqeAFgqGnCdXHRtbPQFiyD0Ddv+oNDug2n6T9ywj+KEjfKYqxf
	 ajIVyQVqCeJIA==
Message-ID: <6906ca3c-03b2-4d9a-a3b6-2d38345d8534@kernel.org>
Date: Wed, 12 Aug 2026 06:02:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] arm64: dts: qcom: hamoa: Reserve low IOVA range for
 Iris
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
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
 Andy Gross <andy.gross@linaro.org>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Stephen Boyd <sboyd@codeaurora.org>,
 Yassine Oudjana <y.oudjana@protonmail.com>,
 Pierre-Hugues Husson <phhusson@freebox.fr>,
 Marc Gonzalez <mgonzalez@freebox.fr>, cros-qcom-dts-watchers@chromium.org,
 Matthias Kaehlcke <mka@chromium.org>,
 Douglas Anderson <dianders@chromium.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Aniket Masule <amasule@codeaurora.org>,
 Malathi Gottam <quic_mgottam@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>, Jonathan Marek
 <jonathan@marek.ca>, Dikshita Agarwal <dikshita@qti.qualcomm.com>,
 Renjiang Han <quic_renjiang@quicinc.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
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
 <g_hgO2Ky6WOywvRuvLUE7DXb-e7Kb8S3QoVsLbN3yhHbYzryQwZBT0VLRe3C4iVy8rUA9Tvc1Vu255IjAnbRJQ==@protonmail.internalid>
 <7caa7fd4-6732-4c80-8b8e-a0ed99631ba2@oss.qualcomm.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-US
In-Reply-To: <7caa7fd4-6732-4c80-8b8e-a0ed99631ba2@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/08/2026 17:57, Vikash Garodia wrote:
> 
> 
> On 8/10/2026 5:40 PM, Dmitry Baryshkov wrote:
>> On Sat, Aug 08, 2026 at 09:18:42PM +0530, Vikash Garodia wrote:
>>>
>>>
>>> On 8/7/2026 6:48 PM, Bryan O'Donoghue wrote:
>>>> On 07/08/2026 11:22, Vikash Garodia wrote:
>>>>>>>> I don't like the idea of this series, because it_again_
>>>>>>>> doesn't tell us
>>>>>>>> the truth about the hardware. This typicall ends up with
>>>>>>>> bigger problems
>>>>>>> honestly...thats all the info i have about the vpu hardware that it
>>>>>>> restricts non pixel to DMA from the 0-600MB range. The same i have been
>>>>>>> trying for a year now
>>>>>> You are not honest here. You also know that there are secure streams,
>>>>>> which have to use their own IOMMU SIDs. And some of them, as far as I
>>>>>> remember, also have memory range restrictions.
>>>>> please read the commit description again, the answer is there.
>>>>
>>>> So I don't necessarily get all of the detail out of the commit log myself.
>>>>
>>>> Could you give some detail to address Dmitry's point.
>>>>
>>>> The question as I read it is - are all of the other potential SIDs
>>>> covered by this change ?
>>>>
>>>
>>> I get the query as "secure streams also have their dedicated reserve
>>> regions, so how does this approach helps" - This patch does not reserve any
>>> IOVA for secure streams, only the forward looking subnode can assign
>>> specific reserve for specific streams.
>>> The patch enforces a common IOVA across all streams, and is good enough to
>>> fix the problem we have w.r.t device reset.
>>
>> No, it's not good enough. It defines that both non-secure streams use
>> the provided memory range, it doesn't provide a natural way to later
>> _expand_ it to support secure subnodes, etc.
>>
>> We know that there is a problem. We already have been bitten by not
>> describing the hardware as is and using band-aids. Can we now learn the
>> lesson and write a proper hardware description?
>>
>>>
>>>>>> So, if we land these patches, how do extend it later to account for all
>>>>>> of that?
>>>>>>
>>>>> forward looking design would be subnode, which we can land ontop of this
>>>>> series.
>>>>
>>>> Yes it should be possible to branch to make subnodes work on-top of this
>>>> - accepting that once this lands it becomes ABI and support for this
>>>> method must be sustained, even after sub-nodes land.
>>>>
>>>
>>> Thats the plan. This goes as ABI with subnode to land on top of it.
>>
>> So, do you actually plan to support both ABIs? This would also mean
>> moving reserved regions to the subnode.
> 
> How is that different from moving the reserve region when stream IDs
> would also need to move, so be it for the associated memory regions.
> 
>> What prevents us from landing subnodes straight away?
>>
> 
> You are well aware of them, but still asking the same. Reasons,
> 1. We have been attempting the subnodes for almost a year with multiple
> pushbacks from multiple maintainers. We are closer and working on it to
> post for iris, followed by venus, once review is acceptable for iris.
> 2. Current solution, in this series, is much easy to apply for all
> kernels and can land faster so that it can fix the reset issue we have
> for already enabled devices.
> 
> Both from timewise and simplicity wise, this proposal is made to address
> the reset issue, while subnode can land ontop of this, without breaking ABI.
> 
> Regards,
> Vikash
> 

There is another solution.

Restrict multiple concurrent streams in both drivers. The failure mode 
is as I understand it only triggered by _concurrent_ streams so, 
restrict that case in the .c code.

Nothing dictates DT as the means of addressing the problem. Clearly not 
many people run concurrent streams with the upstream stuff so formalise 
the restriction until sub-nodes permit reintroduction of the feature.

---
bod
