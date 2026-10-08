Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352AB4963B6;
	Thu,  8 Oct 2026 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791464161; cv=none; b=k2Viw8NcmNsUlvZKTn+ab4pZ7rIIgn+Z2nf8ZkOzCz8h7sTBW3zTm0bmBM/N3a0bdnwMcNmTF6AdjyK1/fJU/URa+tRXUUfkaXUqxK3h4y3cgEOdifhAlCgD9M+LNpGuXsIsK8slpcF/x+YpbUOTfbE1yrPiLixjXBSalTiPM1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791464161; c=relaxed/simple;
	bh=48va3AxlapOSVD/eQTsLmD4W6Vl42eZUNrqCeNyskJA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VWwli82Upk9xlyMtDeZGjgd1QGGUxrazSNf1bnBEwq1qoazFBEAvKaHm0MdRxVz+OewBI8oyMZeIp3JcwNGfiXdvIOhyVAIlmFfuxhklMCitMXNQB8K7kLyXrkzGdDM+S/Z28bjYmPW0LLgfHVWypFR6ZbvXLMbEVel4Gkwymdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bhmLCGbp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bhmLCGbp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1367A1F000FF;
	Thu,  8 Oct 2026 12:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791464159;
	bh=YCVpdCyEFTDkP6dCBo/QsDSh8W09hcMyco8GwpHFCkY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bhmLCGbp2BgiEMgGlOj3uH5BrlGhiSmut/gERZxNNlMNYwkOuT+IJeDeK9n62Cy/w
	 pP63NUDFySKYfK3hxY5OG+XSd+W42907JY54uf2GLozRgmE3s854rrp06YIt6IvM+J
	 onSPZlkGp097EmCiqmD4QIqQ5sWDMy1xVitTfFUEfTQW8NL5EdRPvH+36LlgWMjPj/
	 oPYCFHtU/BCRMI506RAPZnsu8OK2E7mIZ22Q9eLExZBNjq7iNRp07HYOCpHlb24hZX
	 0uFnDtCqLawLH4dCiaMjgTRXptxC7MZ+esERtVfDeN8GxRy3OV9/6ho4cjIGL0bBX0
	 BDWyRdWITuDCw==
Message-ID: <da108ee4-e330-4656-af21-286ad3eaf53b@kernel.org>
Date: Thu, 8 Oct 2026 13:55:53 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/74] RFC: Switch on IFE YUV, Stats and Params support
 for sm8650
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
 Daniel Scally <dan.scally@ideasonboard.com>, Keke Li <keke.li@amlogic.com>,
 Richard Acayan <mailingradian@gmail.com>, Hans Verkuil
 <hverkuil@kernel.org>, Gjorgji Rosikopulos <quic_grosikop@quicinc.com>,
 Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>, Robert Foss
 <rfoss@kernel.org>, Milen Mitkov <quic_mmitkov@quicinc.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Antoine Bouyer <antoine.bouyer@nxp.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
References: <2bmnjEGElR9T_ArfViwpYiEKTtnqkmH2Ly0MiZJCxhhVR_O0dZOW-Cl983_7fLBFoxMc_PBuNK6FsBbK1JLXQA==@protonmail.internalid>
 <20261005-linux-mainline-7-2-sm8650-hdk-rfc-0-v1-0-ed985aefd611@kernel.org>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <20261005-linux-mainline-7-2-sm8650-hdk-rfc-0-v1-0-ed985aefd611@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/10/2026 18:13, Bryan O'Donoghue wrote:
> This extensive series restructures CAMSS around the idea of lines and
> outputs more closely matching the concepts in the camera hardware.
> 
> To begin with some bug fixing and some dependencies on the OPE series are
> pulled in.
> 
> Following that a series of changes to enable the IFE hardware is introduced
> for VFE780.
> 
> Supported in this drop:
> 
> - YUV output on the pix path
>    YUV downscale 16 and downscale 4 work on a staging branch
>    but with this series at 60 patches I've not included that.
> 
> - Stats output
>    Bayer histogram only
> 
>    How many stats are intended to be brought out this way ?
>    Consider that scene in The Terminator when the guy in the gun
>    store.
> 
>    Gun store owner: "So which will it be"
>    The Terminator: "All"
> 
>    More seriously once this series lands then it will be possible to bring
>    out stats for Agatti mitigating the need for calculating stats in
>    software.
> 
> - Params application
>    AEC Bayer hist params
> 
>    Again there are no limits envisaged on which params are to be enabled.
> 
>    "All"
> 
> - Testing on HDK sm8650
> 
>    There is a repo to test this stuff out:
> 
>    https://github.com/0xB0D/ife-tests
> 
> Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
For the record sending 74 patches to the mailing list is anti-social.

Next time why not try for the hat-trick and make it 300 ?

Feedback to self is break this up and squash this down NAK.

---
bod
