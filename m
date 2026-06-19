Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC9632B11D;
	Fri, 19 Jun 2026 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781856101; cv=none; b=CdbpkcBv9ht/W9UCMzDiEA8id4pz44khRHAj25me+X+n1dr3H5LihH+hP29e91v75CjQHlkucrB7ph4blHadZhUSG9bdLyBbJTa/aY3BzMJOWzuJ3mqIcIBwx8+aA6j2jZUX1Rrk94IldQU+VQ0MnIrD50t8/ry8V5DakP/4Av0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781856101; c=relaxed/simple;
	bh=tjVHnSpEH/bgN1eRjAXU8UI/87UG1ARWudlF/Set55c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7pBwYz6mvQQU1rKK4jwsE+UHE8LL6iZa4SvuPt6m/Ra0P8ol0QtWjNSeIJnIos/qgafbvKWWuEcrhK8oK0FuZuHc3FwABOjx2/UCaA93SdqqbUSt8WlmAm4N+KACDwNIuJtShsl5epmArkE6LmSN38Jb5z9lhOsPfJV0lQlfcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YW2quG2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YW2quG2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3433D1F000E9;
	Fri, 19 Jun 2026 08:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781856100;
	bh=0TjxzzDO6vmgFkmwlKHAqYBOln9gocUIZalMIUI/bV8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YW2quG2H9BUc2Mrz3NOAdYm943VPFSEUdyqcTxqJCcvHBAOSjco9MM4hR/C2QWaXl
	 VUY27KuHT9tXUOSZRT+cgkkDXF7M2QraFNxz3iE3Kd3nsO3QQGqMsl46eO6CfSKFgE
	 LaJ/C7CPEVz2NnQ23TjmvflMy9OdZeHVeupQZ5gVY97bWp7AqlgkUp7lXR/oZqlaMm
	 Yhs1egQIRizu8SPjlDu6Fm9hN/MMwzWPf/6ErLtAJ1SVuaZhqp98B8qelgve7fgSG9
	 6cLBVbEcT3TdtOdeHmRpGyR/kxY4JJoHt7pVg/FWKQeWzSE62ROyGTvc7xOnPx7vMR
	 hxWG1Nyh0JoEg==
Message-ID: <a4116337-64d8-4a10-8c1d-c14abc1ce6aa@kernel.org>
Date: Fri, 19 Jun 2026 11:01:34 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] media: microchip-isc: synchronize the IRQ before
 disabling clocks on stop
To: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260616-balki-isc-prefix-fixes-v1-v1-0-b23677fc5ab6@microchip.com>
 <20260616-balki-isc-prefix-fixes-v1-v1-3-b23677fc5ab6@microchip.com>
Content-Language: en-US
From: Eugen Hristev <ehristev@kernel.org>
In-Reply-To: <20260616-balki-isc-prefix-fixes-v1-v1-3-b23677fc5ab6@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/16/26 14:50, Balakrishnan Sambath wrote:
> isc_stop_streaming() masks the DMA interrupt and then drops the runtime
> PM reference, which disables the ISC clocks. microchip_isc_interrupt()
> may still be executing on another CPU at that point; it reads ISC_INTSR
> over regmap, and touching the unclocked registers triggers an external
> abort.
> 
> Store the IRQ number at probe and call synchronize_irq() after masking
> the interrupt, before dropping the PM reference.
> 
> Fixes: 91b4e487b0c6 ("media: microchip: add ISC driver as Microchip ISC")
> Cc: stable@vger.kernel.org
> Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>

Reviewed-by: Eugen Hristev <ehristev@kernel.org>
