Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794219924;
	b=5JVJT0Hm4ljyhYTnmC5nszq4qQcsCU6mDSHdr/WToqt6FpEwSNVi91n7u3dj9PPhW094
	 WKMvPUlf44cbXwv+wG9o6Kpca8ddK0s7Jf9p5zhfKdT8DqW+C8jp1+u/Xe7emRAUPkvbY
	 AEgGjGCiXAKrXKe6KILG7GYCOXFCQprF+WqieFtoWhkHMTghC0E7utjZcfui1DbA21plB
	 T+8dV9lfodexwWlWeAOT5QvMFR3PVyeDcLwzFyAGj3rA1vwvMA3vlXvEekBYE2XHroyDK
	 mkz3o2O+6A56wE9adwT6fJuHisVmG/n+c+pU8eubOoqVTDPJTUoZBzd6pL33zzjYXtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794219924;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NnxLFtUcr1hlHxfUEIUQKoQuNxQA85JbYbu4R9dHHgA=;
	b=mLRnUiab2rcFFAwU/5nwrB5Nw22e+/WU7ofMriI7P3yGl8f+x3TRyBdhKCjjfvZdcUrT
	 BiCAVI/8VQrZgbn7W1lr3h4QMqpdWY7yKFHq+XCTOEE9FpOAo/6X89gU5upcLEKXxqU/t
	 /X09d4EKVsejs4qNZD/i4Sd9WMxHgFj3gxdUgUs9pyNFPGPmc6wxmXcqPqL2aEgDm9gIp
	 rq3cE8PZdPqu2SzsvlNDNj4v89b5UCwMxme59zFduj8tW+MW0DEcTiks+ucn/VOON7qJI
	 QEFUMWdvKhKNh284VFfC5Y6ebAO0HOq9JSDLoRpeormhIa9N+4um6D4S8bVRCXsfREQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cy1D/HDe";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 87D94606A326;
	Mon,  9 Nov 2026 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cy1D/HDe
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4D69C1F0089F;
	Mon,  9 Nov 2026 10:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794219924;
	bh=NnxLFtUcr1hlHxfUEIUQKoQuNxQA85JbYbu4R9dHHgA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cy1D/HDetXh3Ypi8kDoIHRLUbsWxZFzJULtLsxoDQziX368400p7igNdIw/PVJNwE
	 dzBLXrcKNf0c9aeRCatKTH9NpYMPVv8mbgewlKc5yKBQKI3QHtlHMfC97A31fB/PjK
	 pCuIdpN0xnqtCzgZmvPkGx49IFhUFyF1g87nmGojD5vyG8wMUMEjN7kilfL5r/s3vf
	 ObNlO/abkp/E8PjYdBax8U6bNZw1ZiBdDX+Z8nSHnHU8TgANMxhySejJxy2A1BZUww
	 YfYKg0BZhAP1G1m0/PwSnsxgwFTZ/7KklfaHSfnlA6ffrt4MU0C2xyoTNkcT9S6gTF
	 S5jJ6fjKmsopQ==
Date: Mon, 9 Nov 2026 11:25:20 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 5/5] gpio: cdev: don't overwrite the whole flags field
 when configuring lines
Message-ID: <g22agtopvkez4jqeh37uylm4xl4orqaymhcnqmdouhsgkzb4sf@i577mr5xqugv>
References: <20261104-gpio-desc-flags-atomic-v1-0-e23cedf619ba@oss.qualcomm.com>
 <20261104-gpio-desc-flags-atomic-v1-5-e23cedf619ba@oss.qualcomm.com>
 <20261105042345.GA8436@rigel>
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
In-Reply-To: <20261105042345.GA8436@rigel>

On Thu, Nov 05, 2026 at 12:23:45PM +0800, Kent Gibson wrote:
> On Wed, Nov 04, 2026 at 04:37:00PM +0100, Bartosz Golaszewski wrote:
> 
> A couple of things not covered in these patches, but related to flag
> consistency:
> 
> GPIOD_FLAG_USED_AS_IRQ is used as a lock over GPIOD_FLAG_IRQ_IS_ENABLED.
> e.g. gpiochip_enable_irq() and gpiochip_disable_irq() both warn and drop
> thru if it is not set.
> Yet gpiochip_lock_as_irq() does not check if it is already set, even just to
> raise a warning.  Why not?
> Does the updating of those two flags by gpiochip_lock_as_irq() and 
> gpiochip_unlock_as_irq() need to be atomic?  Not individually atomic but
> as a pair, else they race with gpiochip_enable_irq() and
> gpiochip_disable_irq()?
> Similarly, don't gpiochip_enable_irq() and gpiochip_disable_irq() need
> to perform an atomic test (of GPIOD_FLAG_USED_AS_IRQ) and set
> (of GPIOD_FLAG_IRQ_IS_ENABLED) so as not to race with the lock/unlock?
>

Thanks, I'm adding these to my TODO list. :)

Bart
