Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34437442B16;
	Fri, 24 Jul 2026 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909032; cv=none; b=suZW4ibzJJk9RmuxV0Tby6x2097TNr7jlpkXW1A4juAjphMmJi12eEuW2qiaWRbAy7yGUALLXJrkJjbKw7WSS/RzRSEYK8Eshy/ZxIDt/wW1nj6nixIl92ICHtQmJwW8KwTtf6P2l0IDHQ9jmtxgUsnVNnHUYSbTZbR+WpSq15I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909032; c=relaxed/simple;
	bh=8l9JPUZRNEtyr3dL+VWkf7ULELkQpwlgyD505ydicS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pb+KMiVhNVlywWpXvwlIBpBQyrbQLMQaiDMz/DoImAcgstWzrpif/H16RGnfJSitb/gcdM9X2VXyBWRDndjhhv6qFTNFAc/pMwGl5+veWl4/4bnxWc7+KKwAKE47lrLYkSmjZMHZsWbN/TDgZZdJ1mPFDEXjNn/DBKnMsV7NnLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Pbr5aO6G; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Pbr5aO6G"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 912261477;
	Fri, 24 Jul 2026 09:03:43 -0700 (PDT)
Received: from [10.1.25.28] (e122027.cambridge.arm.com [10.1.25.28])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C0E03F66F;
	Fri, 24 Jul 2026 09:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784909027; bh=8l9JPUZRNEtyr3dL+VWkf7ULELkQpwlgyD505ydicS4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Pbr5aO6GhUd0NpcB3iv11BiO2nbGw4ap3vfOMScFk3obDKjWo8fy2wnD0sV9zqoTY
	 JxNl5CfDntDzuvefgIcjaAdt/TyM070yCKScHz6nSCPl5EOt3/Qz2p+jxntkw/V8Vr
	 NQvQcAunhjpEFTT+KSAPBWrf2Vgl7WquXZFtUMrY=
Message-ID: <c31aeec2-6336-4dad-93a8-982e3f4c525f@arm.com>
Date: Fri, 24 Jul 2026 17:03:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panthor: reject zero-sized firmware sections
To: Osama Abdelkader <osama.abdelkader@gmail.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260720113024.11619-1-osama.abdelkader@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260720113024.11619-1-osama.abdelkader@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/07/2026 12:30, Osama Abdelkader wrote:
> panthor_fw_load_section_entry() skips BO creation when the firmware section
> VA range is empty. The section is still added to the firmware section list,
> leaving section->mem as NULL.
> 
> Later reload and unplug paths iterate over all firmware sections and
> dereference section->mem, which can lead to a NULL pointer dereference.

Good catch.

> Reject zero-sized firmware sections before adding them to the section list.

Sadly we were trying to support zero-sized sections - hence the "if
(section_size)" further down.

I think it would probably be better to just not add the section to the
list if it's zero sized and otherwise accept the firmware.

Thanks,
Steve

> Fixes: 2718d91816ee ("drm/panthor: Add the FW logical block")
> Cc: stable@vger.kernel.org
> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index a338c4f0a7f5..6335893d3f16 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -596,6 +596,11 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
>  	}
>  
>  	section_size = hdr.va.end - hdr.va.start;
> +	if (!section_size) {
> +		drm_err(&ptdev->base, "Firmware corrupted, zero-sized section\n");
> +		return -EINVAL;
> +	}
> +
>  	data_size = hdr.data.end - hdr.data.start;
>  	if (data_size > section_size) {
>  		drm_err(&ptdev->base, "Firmware corrupted, section data exceeds section size\n");

