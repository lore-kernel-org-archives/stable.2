Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995340;
	b=1JSLl4H99C9VOmVxVJ8MTtO3exVAPNPjANWY4tAIhIyXa4PcF4cihdxOdEB40KbNeazU
	 rpS3R3VxH3jYcqALHg7j+ci2sbekQjPxJbRp+Y8UZTjBKdPoUD17MhgPBRQFx5n8Rpfol
	 Weih/8WGmxa4pd6aRbcRcn5fdjufl5cljFxLJJK01lp5RNNi+7Cgr6ETireDqBOlbNxyf
	 x4BJQ9SRW9znXoIlAnOFbu47T0amSbMw9WpQrij4a0NtiD3F1YbcpgmJqmExACjlariYR
	 HZ0hPKkXGTiyFgOPSP0dg4ch8KxjM+V6+1qqQSr1UvqX6aC6YaVoO0sXBTxWqn5/d2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995340;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=fDg+0uni0lv6+RbVc3vOTOkdSfrIePJPWWkLalzCKCw=;
	b=DPU/I5a42bdeuatgvr9N3hWv99sPrAv3M+nE3dDtxERJ9g5++BrKrt22dpg4Y3ULi4of
	 L6gTOAq9lLZvI90v1Tjc8JDzEE8gub8dsG9Jcbw1PuXrTzri0g7hWtRVFDKHWU9CLaame
	 KC7M+QFAFDPGp1YPRDNJaDp2Yq7VnOrTAW8+5KPP0AXRMT4kqzNufGpPnxEEn517GrBGZ
	 yZ4aVa67yMmx5XJZkK11jAfxnCL9J0U1LcGub/QGspr6y4tiYcrp265T3dYiBUUgt3+2o
	 15JkIQn1pFfFb15oBF0GYQfjJC6MrkSRDkofziCxjv9bVo5EV/U2HNowgQlXREsZobA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dobd+JWQ;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF9F606A31C;
	Wed, 18 Nov 2026 09:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DF9F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=dobd+JWQ
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2C4D1596;
	Wed, 18 Nov 2026 01:48:55 -0800 (PST)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BEF6E3F673;
	Wed, 18 Nov 2026 01:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794995338; bh=YA3wPSfh9tBBbpaAm28tmaBPTTk90zwDC6a73//MQhY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dobd+JWQJqTIJRpXyquI72PQy+gqArRw+npLMpoMH97o93sMu2iaqn1xMUpFIv1uT
	 4Zvp+pHI/ZyjHMkkgQR1UhR4e1879n8Z3w+LfJ3GeFg3rIcH6mKxYoYtOmQJMmhizU
	 r5wJNMJY7/IXy52kf3axZjGBw/98F5+RqDy+5wMU=
Message-ID: <c1cb0981-b152-4c5f-a296-bdf3417bf665@arm.com>
Date: Wed, 18 Nov 2026 10:48:59 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "dt-bindings: vendor-prefixes: Add vendor prefix for
 Teclast" has been added to the 6.6-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
References: <20261117175632.2198155-1-sashal@kernel.org>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20261117175632.2198155-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/17/26 18:56, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      dt-bindings: vendor-prefixes: Add vendor prefix for Teclast

Is there any reason for this? I don't see the point of adding the vendor 
name to the DT bindings, given that there would be no need to backport 
of the devicetree file using that name.

So unless there is a specific reason I am missing, please drop this 
backport.

Cheers,
Andre

> 
> to the 6.6-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       dt-bindings-vendor-prefixes-add-vendor-prefix-for-te.patch
> and it can be found in the queue-6.6 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit c289a9050a3ce0b310e49f739d5030bddf32906c
> Author: Andre Przywara <andre.przywara@arm.com>
> Date:   Mon Sep 14 23:01:13 2026 +0200
> 
>      dt-bindings: vendor-prefixes: Add vendor prefix for Teclast
>      
>      [ Upstream commit cb81a22504f4505dc4717bfce47360e06f84bf61 ]
>      
>      Teclast [1] is a Chinese company manufacturing tablets, laptops and mini
>      PCs, using chipsets from various vendors, covering both the x86 and Arm
>      world.
>      
>      Link: https://www.teclast.com [1]
>      Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>      Acked-by: Conor Dooley <conor.dooley@microchip.com>
>      Link: https://patch.msgid.link/20260914210115.28151-2-andre.przywara@arm.com
>      [wens@kernel.org: Fix entry order]
>      Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 69da5e6a75e46..917bb153cd2fe 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -1369,6 +1369,8 @@ patternProperties:
>       description: Shenzhen Techstar Electronics Co., Ltd.
>     "^techwell,.*":
>       description: Techwell, Inc.
> +  "^teclast,.*":
> +    description: Teclast
>     "^teejet,.*":
>       description: TeeJet
>     "^teltonika,.*":

