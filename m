Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A322F7445;
	Thu,  6 Aug 2026 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786013408; cv=none; b=VBL+tvaHmjo2sjgIjjy+gDWNfzCjsao7TxLOEmJ7ijprfkspcUB9ZrlIVs+mOczenZ0ZWSjM349Xlw+jmgkfv4pn3t+6UtBU8+qlWsKya5mjEKRKsGxUzNqA3+NVZsL+HOmA0nDQ9O/dua0uE+NPmAM4xHZaAis/wJMUy3rlOSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786013408; c=relaxed/simple;
	bh=zeiuelYk+6GIluS5LQVFyMUGXRKFB9i7x8Co9e8lEZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5Axw+nZ9SvEDH7dfzmTpYL4ExIQBGhEchcCf6UyJYOJ7T/XPRETY2cgc8vmtjxoZrPHaItBRRVLDKQG5lkpIe+msYH6aFhxfu6CoxNco1lhsprexVChAGxerBg4TlWNFqGOTBwN+IbkjK8uvhhekMh3mlbfCaru2I5IgRiEYc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fucOWUXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fucOWUXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06C61F000E9;
	Thu,  6 Aug 2026 10:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786013406;
	bh=eJz4gaO6R9U9qpj6z5LcqbnA10j62bx1m9/uXd4gt2w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fucOWUXoCrajXetVFk+wyY62AOr3/Tcdi9odaQD8KD1sAcCskHuyEnzUgakB6Ddxe
	 IG+2rkiITQRnj6NIhc+GyqHB1hAsidvN9q5By7uRQSvNUC5oc6utJZPyBgsdbk6seZ
	 sBGdgXoAiajLggxOnDB5WmkondFQjcEVNb3irE4vTLlZ4iY9W7cY/bRtpA1W2XkGJ/
	 NjRNuQj0PJP1BUZzXSxApQprOCx4O3bvgQiPkjL3tmIL+tUoqGgEC/Ql/C2oGtwXg9
	 XIF8Z7m/8u3qv/icM22irxYgELOm6y27IbXK6ksmGNnwWgC1oJ6SSn7syoSOcB85JB
	 xwI5Wz3hWD+bg==
Message-ID: <995779b4-925a-48a1-9288-930e0a10b7c5@kernel.org>
Date: Thu, 6 Aug 2026 11:50:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] dt-bindings: media: qcom,venus: Add context bank
 subnodes to common schema
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
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
 <d6ffacaf-7f83-42be-a3cf-40ce00810ca9@linaro.org>
 <Ia82wa4IJDPkQZpTCt4MDMqtq1VGZ7DqIaJFNvV0MjaT3jjWrbD_iBs8RU7pqrIz-ZTMSK2irncUv7-PZ-fvkg==@protonmail.internalid>
 <8130900b-c9f2-4f5a-80f1-1e8567ee1b72@oss.qualcomm.com>
 <f252d83f-e0e7-4061-8da8-d2650f1beadf@kernel.org>
 <ea0f1777-4615-415c-86d2-2a792ea42b3e@linaro.org>
 <41163185-09e8-47b5-9ece-c6503cb48920@kernel.org>
 <72b267c5-6490-453a-9900-b196d1cfc5f8@linaro.org>
 <2tWmEJ8s0nm8efbgvq24Zwo1vkuH4Na_gC6stCr9_O1A9k9JcA2-TFN5qziPoORYrCKyDgjscvGyO64HI6qVqQ==@protonmail.internalid>
 <72b4edc0-dc80-484d-a2b0-88ea11ae001e@kernel.org>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <72b4edc0-dc80-484d-a2b0-88ea11ae001e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/08/2026 11:32, Krzysztof Kozlowski wrote:
>> Yes -master.
>>
>> My issue is how long this will take. Several kernel cycles and the
>> debate is ongoing.
>>
>> Daneil's fix has not been applied which means the replicable system bug
>> is out there in the wild, not addressed.
>>
>> Daniel's fix could have been applied and rolled out to all users in
>> mainline and consequently stable.
>>
>> Instead another architectural level fix is still under discussion, which
>> is of no value to end users whose systems can reset in the meantime.
>>
>> Its just not responsible behaviour. So I feel both of these drivers need
>> to be marked as BROKEN unless/until a fix lands.
>>
>> I'm hoping the vidc team will come up with something else.
> I did not object taking a known fix for the problem for the mainline
> kernel, regardless if the fix is optimal or not. I only objected the
> reason of taking patches because of something in stable kernels or
> making backports easier or whatever other semi-expressed reason, which
> is not the mainline-kernel reason.
> 
> Best regards,
> Krzysztof

I'm all in favour of rolling out Daniel's fix.

I don't want to propose BROKEN but at the same time the timeline on this 
demands action:

- Sub-nodes proposed around December ?
   Which means the system resetting bug was known
   and understood but not promoted as a bug requiring
   resolution as it should have been.

   Fine people make mistakes, that's life, lessons learned.

- Daniel's fix posted.
   Not endorsed or rolled out. Its not "perfect" but
   it is certainly "good enough".

- Now more debate on sub-nodes
   I'm all in favour of that but NOT at the expense
   of replicable bugs from real users.

TBH, when I start to lay out the timeline on this, I get annoyed. It 
seems to me qcom has understood this bug for nearly six months more ? 
and mainline is still waiting on a resolution.

So I'll leave it up to the vidc people to decide. But some kind of 
deadline needs to be put on this.

Close of business GMT Friday - either something mergable lands for 
sub-nodes or we replicate Daniel's fix to all platforms. Failing both, I 
will have no choice but to set both drivers to BROKEN.

Stability has to come first.

---
bod
