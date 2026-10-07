Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BFB392C28;
	Wed,  7 Oct 2026 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362501; cv=none; b=QIb9FPwITG/7aqV4i8mDfyDBJ0Nv2wahi56KEOyCz7nONCJmwMo5IsMMKXxGxlff7USTIR4p9W2Nj0MHEtVRfgaSHRaSkjjeOiN8vm/a4GTJ2Gey7M3QkikfOk7mtrpFlAR8haJ8FrjY9hMkYVu3424P3GoCfm87/uw1OFEOblE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362501; c=relaxed/simple;
	bh=gH8OOCUTMc1iQGCHn/0Qeb2u5qHQaDYF9RGXCbL86UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvwF//chgpxpPdUJYlXL+0tCpDyBB9iSND74RPPDKsbGKuEACl7zYnALwAzpKJvGe6QQk9rn23ig2R4wPZfxThoOXe2Ay3Kzx6bvwr+E4qsrda8Pyjs2I36IZQZmMr8C7TsdDuCVWY+GC7pbzGUiBskqfQD8s8xoqevU5/szQBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZCwSNZT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZCwSNZT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710401F0089B;
	Wed,  7 Oct 2026 08:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791362499;
	bh=3SuIsjUgaO7uGeWs7i9d4/i8BApvoJuUTo0JvMQk5BU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SZCwSNZT1FlC2OWZbTjN26Wp468lwkHCiTqI0S2Nbvee8mTDhySTKJSYssz6W2f+8
	 pxox6R7upUBHdjij+U9ryf4J7z4oQM07e89eid+OSdPtrKBAJe2mkXmXcZvbSpBOrJ
	 cfs/tqP+1DGWw7lUPaUAK2Dc3cH1PVjf7e8vvOaSJh8d3eMuUG5gXZhyEe25QRS5mZ
	 nv4X5XV0zLzeQAYwiAGgZ8kERk/tmRsWCDYiCyfeZ46tUBSV0UUNplKOE8xpLJgixI
	 TBf0ZxIwPVOKLRcnRKm4UUUiFzdUPMkdrmUXgF762WZsrPfz28HAjDpIre8rfonmNp
	 Gm+zE4MLTydug==
Message-ID: <ccdfb6d4-59f8-4773-a3db-0e06b15fb889@kernel.org>
Date: Wed, 7 Oct 2026 10:41:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/74] RFC: Switch on IFE YUV, Stats and Params support
 for sm8650
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Daniel Scally <dan.scally@ideasonboard.com>, Keke Li <keke.li@amlogic.com>,
 Richard Acayan <mailingradian@gmail.com>, Hans Verkuil
 <hverkuil@kernel.org>, Gjorgji Rosikopulos <quic_grosikop@quicinc.com>,
 Radoslav Tsvetkov <quic_rtsvetko@quicinc.com>, Robert Foss
 <rfoss@kernel.org>, Milen Mitkov <quic_mmitkov@quicinc.com>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Antoine Bouyer <antoine.bouyer@nxp.com>,
 =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, stable@vger.kernel.org
References: <20261005-linux-mainline-7-2-sm8650-hdk-rfc-0-v1-0-ed985aefd611@kernel.org>
 <RUM_JvFD5QdV4d3aiPXG7hliueufdM_8Bh_LgOrotD5Cli4Drmsxc7-LHAitng2t2FMPt-U7PIicZr0uxuC0_A==@protonmail.internalid>
 <asSdUQ-2fnvcD-h_@zed>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-US
In-Reply-To: <asSdUQ-2fnvcD-h_@zed>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/10/2026 09:06, Jacopo Mondi wrote:
>>        media: v4l2-isp: Add helpers for stats buffer
> What branch are you based on ? This has been collected for 7.3 and
> if you base your work on media-committers/next you should find it
> there
> 
> Thanks
>    j

Ah v7.2 - rebasing onto 7.3-rcX threw up too many errors not related to 
my work so I backported depends to 7.2.

I'll move to something like -next for v1, v2 and merging.

---
bod
