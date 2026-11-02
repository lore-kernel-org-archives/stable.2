Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627488;
	b=kCyyQSOfyIwU8TUCmgts+0OXj+IbabrVX4ehngofKwPL/o38vC9QfspIAKaxI88YBdEW
	 K44hmSsvlJp5csfcoiVFdkCgEltBN0Ljlv5Lq2HUF9+yLaZZBegA8xiHE4s5ArCdFyPQ0
	 CwZhOw53KvKY+tCFmvD2EW+jltynEg+e6srbnn9QZHllFmS+dJDFvck4eART/DAfjIKbE
	 UxATZfN27ZTsDUtLkX1S6xLPG+IK0WagWNG3OMtDXm6t773Rorn2/WS3qtW4grIh9MPH3
	 qac5WrfIe5Kjho6qtrmpq6byl2ipoohnj144mzDkXRX2N/2+sr9upjjFp78jR6zVD/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627488;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mL9IKPq0LPdvB7BdIW6Lm6MoSxPsnyVw7BnLCw2sdKA=;
	b=iCyA+4plI/1Z5QUOt1Q1JtJN8It3px4U7Ca206y45GOTNHg4LDeX27SxWz9Iy7MuZEKU
	 QBxDUlyJ4RiEH/x4Nzeb2m3cllZ/I88NkG66szjwHq7AFRgMGz013+kVKLmvOI41S+UiW
	 yPCvcXYz0UehFj3/OKTA68WfGud32wU07K+IHMcctLWXrCMZCNGHUTRDz2MqTFYRCECOm
	 sl8QvLlnXDIATgOnt8uzfXYG3XAMk7M6IhXn8S0raMAMBO4OL1UXQpg+ZRbfQV50HIqZY
	 CEqWnv0xxv68C5ZT+svAcpLDuHiRZvlCOy6mBsjAs0chhObnnZppJl8PiqF2JsWh3Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uu+HjGFC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 7D4E560A3835;
	Mon,  2 Nov 2026 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uu+HjGFC
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 794C81F00A1D;
	Mon,  2 Nov 2026 13:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793627488;
	bh=mL9IKPq0LPdvB7BdIW6Lm6MoSxPsnyVw7BnLCw2sdKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uu+HjGFCSqBZoDofdyfUOZ+2ueQMup9eYQquuMeb4bNs/d8c0nlUH7a1ngOxQfZus
	 a9xaL0FqAe8tEHlBBgoKNrEB2IewD2CrvnmH7ECoGIhs5YSadB/a/9tDXSODItWjbR
	 tAUqM5ZqH3IHNL5BUjN9Niqjw8U94EZCFqtS18NdLc8V+253POyHJOJ8BwMPRD96pv
	 TmLVdtewf2X3fJQ/w+f+FVCcwouFImBaDhELOcI+8sl08WNhkp63jRF0gViK5gopuo
	 Ag9+7Dzsnsz9BJTqSLyCG7fxeJke6/QBy4t46T/O+LSyRdNjPxijxqeucG+6s+dd8O
	 fKd/zN39gE5DA==
Date: Mon, 2 Nov 2026 14:51:24 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH] driver core: platform: fix fwnode leak on registration
 failure
Message-ID: <dvsi7uod36yljgodcwhs627crcmnwfvmjjsymm4orof7aqers7@3mnzc6fjbl7t>
References: <20261102082822.1275425-1-johan@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102082822.1275425-1-johan@kernel.org>

On Mon, Nov 02, 2026 at 09:28:22AM +0100, Johan Hovold wrote:
> A recent change started taking a reference also to non-OF firmware nodes
> when registering platform devices.
> 
> The firmware node pointer is however still cleared on registration
> failure when ACPI support is enabled, which means that the reference
> leaks in platform_device_release() when the device is freed.
> 
> A software node also stays registered as device_remove_software_node()
> returns early.
> 
> Drop the clearing of the fwnode pointer when registration fails to fix
> the leak.
> 
> This issue was flagged by an LLM.
> 
> Fixes: 7b5b51b2b05c ("driver core: platform: count references to all kinds of firmware nodes")
> Cc: stable@vger.kernel.org	# 7.3
> Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
 
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
