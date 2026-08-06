Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F5053DDAEB
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 07:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786002866; cv=none; b=Tcvzm8o8hj/s8aTiVBQmhtmH1rjKVoOuhzc+zuQcohN2DYnXvW5+v3ziOMbLZgoSPPlMBfD7RfBySpagHDT21t7AoMzP+riTwwKwA56vof7Gq0fH08lxOGGYo9NNLc++IT1E7elZ5zw5SDdSksDirQZMuH0QBtRwK/Gnuf/bWDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786002866; c=relaxed/simple;
	bh=TiE5jS6xdQ0bA0I02w8JwxsgjymilDhoV3zVSyA8Yx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KgkQ5NtyHkelJF60yPSAzhLsR+wGfVX4qrJV2lNlXa18jtu+IS0Nh8EYJge7XcV9SASfHvrIrCsEMVWPQEuLNwNdqQwtBAwpHeXvaqsLT/o//b9eNXwaCIZkL0AWHbIM9wRfuuLJ376Sv84vhhllMDPyAQ8ipnprj07TIi9DtoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AgBayDkl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AgBayDkl"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-495757ccbc1so19477735e9.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 00:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786002862; x=1786607662; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VLXG2deAu9vjEHqLkwP3KT44g0q17SGCldo/DWmdJG0=;
        b=AgBayDklbzLgSbYpFLwhYK+XLH7TQzsy0eSSSHuQMlQZ4KJoqMBHGNWEOh2qfrJXkb
         lOudg2ji8AMjuAZbvk661DcYOBOPkJsw3yFlUGKMZIJsczj1wnORoSOQnGzM/Y9zCCp3
         rFYUTeEoB4IjF1ab0xdqp8mgWDMxPBHxOWbdw7RBApxsApb5Yr4FSX+TORJk2X65MdIN
         rTT+xpMP0EobH496r7HvtHcqmlhkFKJDS5JQOagmna+t4DkmZ/MNuUpJiPk23+iCkrPx
         I4rxgGFsmpWtP4hDRJ+iPnhoJ0K3lyBggL92o6syPdnWkeM1BFWgbnfXO4w/dXG4WGAi
         v1xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786002862; x=1786607662;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VLXG2deAu9vjEHqLkwP3KT44g0q17SGCldo/DWmdJG0=;
        b=GrvTIZtAttQKvuNGKDUu03D+P9ncDJmKS5UoYI4d/OVaXlKME+o9hwIFjzspnNlrFM
         dAl6OR7Re0Lhz7BXdCb01foTjJOsqeUKLqsX1hN4AkTbOD9KkL6lMMBJh5oaRWyAZM0e
         rf1Zg/S2FjsZgN2ys1U7KFVE+ILXN6XzbCDHebKcrFVitiwf4XHmBohEke44vQ0M7LPv
         OiMjQZoJjwj7xw+y2DVz8reNOye89v5r8VgN5Xe7gYvnTjrr5qOUnRnECyfjShZHtzDL
         Pi7vOh8rmFjFFdpejjEOClFdA8ABabike1JiZB4SR0Lv1CnrWoFEyDd7q4mP5eOWa3bn
         YWbg==
X-Forwarded-Encrypted: i=1; AHgh+RoQ9MSbsjpoPOsA9AGJTC4mGEVLeHkVNwjpugrqXlS/GxqTjrsp56/H9ABRkgimuHJTILOi7d8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhkKRcKSD4FotT6bnDo0Pu5OulTDnYlcgxQgNtkCrTfo73jtr6
	a99/fgNcRjvOA7dhycx/veeXlAIOnz6AMRW9fRmvJ3INNEModkYKPCAiE2Z/DEyhbWw=
X-Gm-Gg: AR+sD13WNYwQbQ4dxd5ivE0CfVJ6+0pID1Wj7132JOK4WcBE/G0+LlMhjUQLps+x4v+
	LNOyMdlkHK9Fa3KT+GdIJ2Xtp5wtoHqmmqBq/cXVxHljvx08CCNeJgWkcvGtHKSMYPITdDLqceu
	6j2BBdJxYUL1rEocn7gyC9a9jyyuYA99/QGFxPBvjCDLvbuiqwdBK9ueAOgXdm+IywnKRVZAwbc
	ADZcQguJBdZp20K1PJQSsxcfCvuhuABIkU3RM9To2O60oK4ndg+ohcHsUQFskBwGtNms7/4uDiw
	6AkOK2xtzRFnlCtADXfgFpOq/UAiFBDvOH3qdeFsH7Cgchs7taZbIBOyR7Vpf88wVlpACF2wRCP
	nXYyVsQAQiooukbauHxs0uynI2pCLGnO4FHrh6KR2pEFTrYGavrgmjONYEn56gdDmXD9lCEC/4R
	2wh/ZRKp7Gjvg8kIgsLDoL1IihEeQztTPkTbt4GhLfsPfGDuIiSR/IrQnbzS8qqpdJCLdIYbPZt
	Q==
X-Received: by 2002:a05:600c:4514:b0:496:bbce:f3 with SMTP id 5b1f17b1804b1-4994e71ed7bmr160522385e9.6.1786002862433;
        Thu, 06 Aug 2026 00:54:22 -0700 (PDT)
Received: from [192.168.0.101] ([109.76.115.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499542135cesm43926455e9.4.2026.08.06.00.54.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2026 00:54:21 -0700 (PDT)
Message-ID: <d6ffacaf-7f83-42be-a3cf-40ce00810ca9@linaro.org>
Date: Thu, 6 Aug 2026 08:54:19 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] dt-bindings: media: qcom,venus: Add context bank
 subnodes to common schema
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, stable@vger.kernel.org,
 Daniel J Blueman <daniel@quora.org>
References: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
 <futJwsC0VjGSkjrB5PP9T0jBOVgWADaDAYyRRp-OZifaKPNtjcnnA59QJaQTdqYTeayZk9jY6e1jOfun71Yp5Q==@protonmail.internalid>
 <20260731-vpu_iommu_iova_handling-v2-1-da52b5228dbd@oss.qualcomm.com>
 <689580d1-8169-41cf-a954-927e10135700@kernel.org>
 <d0983bf7-a708-46ff-9f86-f94fb6a92ba7@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <d0983bf7-a708-46ff-9f86-f94fb6a92ba7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2026 06:21, Vikash Garodia wrote:
> 
> On 8/1/2026 3:36 PM, Bryan O'Donoghue wrote:
>> On 31/07/2026 19:22, Vikash Garodia wrote:
>>> Fixes: 41661853ae8e ("arm64: dts: qcom: sm8550: add iris DT node")
>>> Cc:stable@vger.kernel.org
>>> Tested-by: Daniel J Blueman<daniel@quora.org>
>>> Signed-off-by: Vikash Garodia<vikash.garodia@oss.qualcomm.com>
>>
>> What about venus ?
> 
> Plan is to get the reviews for IRIS3 family SOCs, once we have a go 
> ahead from binding/DT maintainers, i can either bring in few series for 
> remaining venus and iris SOC family OR do all of them in one single 
> series. My preference would be to add in multiple series.

I still don't see why we can't just set

minItems: 1 for the memory nodes - implement a fix for stable and then 
iterate around this new way at leisure.

There is a festering - system resetting bug.

---
bod
