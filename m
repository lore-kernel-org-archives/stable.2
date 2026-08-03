Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8C4322E6;
	Mon,  3 Aug 2026 18:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785783304; cv=none; b=e98oXMF1ya0lhPMixABS/eOlaFvoW4MpPQil3DPVo5o9RT/cz9Tc2M/4uFyT46JiN30433KdsDYkR4H9OUaubRKtCHQMRzJhS/RyZKx9zGVVOE6iLXlBJRVbETn5qTunsgZcYAT8bvajoaDAwgvEz8JdfSC775VOuz/hrX5rFYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785783304; c=relaxed/simple;
	bh=BFy1mHr7X4+eG6w2oV3Q6JFRozZEGT4to+nTEWSDQto=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=d/LmBsfhgL1rRZZnXqqe3+8gZcQmf1BaIQ/oOcraHZIpZlBTgsDsP23HfaNYoLLNYGvD55xbAOL7DUbTp7DTMQkCdt4KOBVdjlHnEQD8lcH25k6YYM0JaIqYa7FcJEY29oL2YoDTiEpxhd1DfbM0NWFIczM5AXMcB1qqa00C4HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eepH/rW0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eepH/rW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B0F1F000E9;
	Mon,  3 Aug 2026 18:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785783303;
	bh=Pxke/vqfk9U7IMz7tijv+uflzPa8znz+eeiIXihph84=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=eepH/rW06JMNgz46yjOqSUW4rQ0sE8cHvxiKaNZCYlQ7h0g++X/SgiQP0GX4c8poR
	 O/ZReWnvwqfK2MraCc1DAC9Fp1f6LP6dp/fFWcQoSbkv6Bw6rvP3Z58CbfLWqo9Cou
	 kagRyCbY3JZ+opciiklySLQzWMqyZMhAwHZc046C0Te2dlQ65vkn4sx4SQSf7s2tEM
	 Ndwfx1Pmqj10XlQCHW458yGBw+V/WztKpYMeFeT6HhjRbretExzEMB0P9/Omi2ouMf
	 Vf0JRBon8hO+tT5wSAuFU64skHxTc7hsh8HWTIBAprxZvkof2iqo4dvgAuHPWdDQQg
	 mEDavr8PA/uGA==
Date: Mon, 3 Aug 2026 20:55:00 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: raoxu <raoxu@uniontech.com>
cc: erazor_de@users.sourceforge.net, bentiss@kernel.org, 
    linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] HID: roccat: free buffered reports when destroying
 device
In-Reply-To: <B93A126D2A126AAD+20260731084926.1771993-1-raoxu@uniontech.com>
Message-ID: <89r4o32s-150q-8q34-0oq8-sp77rr5q0q1n@xreary.bet>
References: <B93A126D2A126AAD+20260731084926.1771993-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 31 Jul 2026, raoxu wrote:

> From: Xu Rao <raoxu@uniontech.com>
> 
> roccat_report_event() duplicates each report with kmemdup() and stores
> the allocation in a circular-buffer slot. The allocation is released only
> when that slot is reused.
> 
> The device destruction paths free struct roccat_device without releasing
> reports still stored in cbuf[]. This makes those allocations unreachable
> and leaks up to ROCCAT_CBUF_SIZE report buffers per device.
> 
> Add a small destructor that frees every buffered report before freeing the
> device, and use it in both paths that can destroy a registered device.
> 
> Fixes: 206f5f2fcb5f ("HID: roccat: propagate special events of roccat hardware to userspace")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

