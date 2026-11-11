Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435199;
	b=GvH04D+9OJyujXI9gq0D+KVIm99ZKgFuPFjxuI0zoQidNLVI8L3QncEfJ24Oez9HVQOP
	 r6b9fz3PAeMygwrR4tyPPWF2AVv8tD4jmKviBdQxEJZiFfJOYn4BnvUNo8oRd6j50Nvdj
	 m5YMhDCvHSViGl9x+6rcveSkgmCVkN8davKX+AjJ9pNi6DGWf38SUH6jxhKMiJYwc0zYC
	 F0XMFQvcUUpiPYVJStL0oumMvic89d8bZMNxUw27y7HmDnBG8PNdSp33/w1qtkREAfHE4
	 emg3Q9fUFWwU4M3DPR/vuw1f76grUgKIuyNZ41FiG2jZYW8EUyFRKL/ppM1cLhtqWzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435199;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=CkL1DxVgDMrAwGiDxbno089zDqxJvFCxMrqWkJjJQ+Q=;
	b=IbRMXhfPMg0fbttepx2ocby3xcLqB1YxhJWBjO886JEWBK57aKNvKIolox+RHpxqqHxw
	 1ROGJwCm1LNwcJg4LkAnPerQ55434St0DiylA5DZTQE0YugfiBZwFMUYh9ULvWTj2s2TP
	 PcC4XXw7IixrFGD6pRRT8hY39J1iOOMo7DBXn8cF/FeoBTxoIJmaSNKUlWla3D48cyQ5O
	 mfBGZCKiwfXkjoDA+AlYNQPXcUGaW53DSzCj13zK1gK+2Osch4IWwxSDyz76BiWzXtU8w
	 0oA2j4H0t6b/VRdHmaWWjntYBuqp7jAE92RwybWOW53AlNLgLMWL2cJGi0nfHgKI++g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJBMnGSK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC44606A321;
	Wed, 11 Nov 2026 22:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aJBMnGSK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011151F00A05;
	Wed, 11 Nov 2026 22:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794435199;
	bh=CkL1DxVgDMrAwGiDxbno089zDqxJvFCxMrqWkJjJQ+Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aJBMnGSK6XwDmQVb+2IsS7eW5mLAilJoTyGJqyQm0u0n165S5t7Xa+NnP+2LwQEb0
	 VWHzNfnESLI60Sh4mY/mXoTjHfHQWhNFYDj8/Tn/5FeajuZFYp//kk9H/cHPi48gNu
	 QSM+s4/vLZ4hgFwEjk1LLbZXBiCjD5L/sy1it3QrzRbu9JPQ7Xv63XSbcBgFMXSqy7
	 L3e7rkmytAmyFVyEnepW43u3LD3afyW9ukLUonfC+hYJs/kLPi2Uo3xG0jTFwn0KBT
	 5Qlzgtu4tD3VUZPESXlTy8mC/TJwr1oHXav+xiNTy98KAQbFNY9MEdUz81ULH/FsnK
	 oyGs/pCjQ52ZQ==
Date: Wed, 11 Nov 2026 23:13:14 +0100
From: Michael Grzeschik <mgr@kernel.org>
To: John Ernberg <john.ernberg@actia.se>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nobuo Iwata <nobuo.iwata@fujixerox.co.jp>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Wiliam Puranen <wiliam.puranen@actia.se>,
	Michael Grzeschik <grzeschik@puzzle.ch>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] usbip: Stop tracking work context in event_handler()
Message-ID: <avToeux2DxhBWGN4@toad.puzzle.ch>
References: <20260803104342.2790105-1-john.ernberg@actia.se>
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
In-Reply-To: <20260803104342.2790105-1-john.ernberg@actia.se>

Hi John,

On Mon, Aug 03, 2026 at 10:43:58AM +0000, John Ernberg wrote:
> From: Wiliam Puranen <wiliam.puranen@actia.se>
> 
> The work queue used by usbip is not pinned to a specific context.
> 
> When usbip_in_eh() evaluates if the call comes from the event handler
> it doesn't actually check if the call comes from the event handler but
> if the call comes from the same context as the event handler was first
> called from.
> 
> This can result in "sticky" devices on the client side, due to the
> teardown path in stub_disconnect() being lied to, and thus skipping
> the teardown when it shouldn't, or vice versa.
> 
> Fixes: bb7871ad99ea ("usbip: event handler as one thread")
> Cc: stable@vger.kernel.org # v4.6+
> Assisted-by: claude:opus-5
> Signed-off-by: Wiliam Puranen <wiliam.puranen@actia.se>
> Signed-off-by: John Ernberg <john.ernberg@actia.se>

Just as I stated in my other mail [1]. I just did send a near copy of
the change without knowing of this mail. But this one is the patch to
be taken.

Fixes: bb7871ad99ea ("usbip: event handler as one thread")
Reviewed-by: Michael Grzeschik <grzeschik@puzzle.ch>

[1]: https://lore.kernel.org/linux-usb/427d908d-1fa2-442c-ac91-b3e925e5c7bb@actia.se/T/#m2d50ad8abda5dc92fe6d8690edc0cab58983ab74

Thanks
Michael
