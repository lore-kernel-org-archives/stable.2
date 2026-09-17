Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB074AA593;
	Thu, 17 Sep 2026 22:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684022; cv=none; b=bPCytG8SZ85jhKv6guhVUKMumd1PAzJ5j/1ww+9xCyJ/r30j3CFAU9WeKKamhcIPF+QOT6VuE5gXC0fMI/nZ2CpjKz/96kWRN/TzZAQaB8rYdcMp84//rfXvtx1dw+aJ9IRELZtC1Ge0cTkgz7Sikxz7WUNeqgFiRwJuQ+6u25Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684022; c=relaxed/simple;
	bh=dQTC9TkPJgydmhYfBsQYl9MojASDlaJ/9nZB2/9xisg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VgH4jjmDDRHgAS2iH+T2egCW818l2uYGfeEuDr/0uqxcv1xan+BkEGBHlOzFpGojs7puSgxZS7tDgVCOkZ+2GyvrvI8P2RTo8M8FVGHSRTMPhiO0GpSLOJUPG4b6lOEvXSWNGW+36eWc9vOglkEE+Owmee+3XrxgS3wG1pNEjJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cvdffjmh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cvdffjmh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219661F00899;
	Thu, 17 Sep 2026 22:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684019;
	bh=gEiIJyyKtrv62zUu183o4SDBSVBXFGY7UjsvYnEA6UQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CvdffjmhyoU0j23RhYsHJglOXeJg2wvzgtKGra6w4Lk9V5/5zYJM9psFqT76lscfz
	 hqsqwpDPkQsssA0lTPbCWEbbM1+ejCfQMrr9CbpgD5WjQi/ghXRZguj/+IiXJZkpsz
	 98nLiNfqZSYQnHTIY9Bvv2GHTpVzVdy+tLGVI2+3zBOdeUA2x5L7K0Kx8M+XHqzCL4
	 eozQAh9DSbk6DNPllS7qzNvMxcgEGD9SX/ljZGcHImDdahK9obVfZF03VDvQOrMc+t
	 7wW6xuzl6KRBJFXTBfu8UmkfrNElz7KpVFA3A6kiZiejuuEbyZM2zTV8jOa2UVIPYG
	 G7gbcvze+324g==
Message-ID: <ce5e9669-cab0-475a-87fc-cb555a87505e@kernel.org>
Date: Thu, 17 Sep 2026 23:26:56 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slimbus: qcom-ngd-ctrl: match downstream DEF_ACT_CHAN
 encoding
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 casey@samaritansolutions.net, Srinivas Kandagatla <srini@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260807-slimbus-def-act-chan-v1-1-fd542efb3d30@samaritansolutions.net>
 <84be0a35-b088-4ab2-9111-80809d6d2d53@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <84be0a35-b088-4ab2-9111-80809d6d2d53@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/18/26 1:50 PM, Konrad Dybcio wrote:
> On 8/8/26 2:35 AM, Casey Tunturi via B4 Relay wrote:
>> From: Casey Tunturi <casey@samaritansolutions.net>
>>
>> During my investigations, and some rather incessant cross-checking of
>> blueline's SLIMbus path, I found that Qualcomm's downstream driver
>> packs the first DEF_ACT_CHAN byte differently from mainline. Bits [7:5]
>> hold the data format; bits [4:0] hold the five-bit client number.
>>
>> I changed ours to match. It made no immediate difference on my own
>> hardware: blueline's current values produce 0x0f either way. The
>> downstream layout is correct and should help devices that use upper
>> logical-address bits or a non-zero data format.
>>
>> Fixes: 52490169cddf ("slimbus: ngd: add stream support")
>> Cc: stable@vger.kernel.org

there is no regression

We already set this in(stream.c) define_channel_content for each port
after enabling the channel.

--srini
>> Signed-off-by: Casey Tunturi <casey@samaritansolutions.net>
>> ---
> 
> The semantics match, I don't know what side effects that may uncover>
> Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad

