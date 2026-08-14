Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849D246D2D2;
	Fri, 14 Aug 2026 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786710991; cv=none; b=oGskAs3x+dQt7Mkes68Jm95d+nZVD+UhTqq64VaO2ujvrx7sOU9k8x60auT4b0gGACrApboqU4A2KD00pgmUbx8RXaKm67Wv5N82UwKlBHTpKQkleRfpv43TI7bF5Fr3bk+O7AEvoOAQtTGTcAxFMFdq+eBn682pWVZHGkW1Epk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786710991; c=relaxed/simple;
	bh=s3rwZSbnoBbJSx+B3a0Aakphl3+ZOF5ULhPM9VXclKw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gY5Y0GryR/stSFpakaQULewFxsAN04oK7x0OOyfs652ZY8HMzhAiHD7+tMfDXOfFuTfKEpfUz6Z3xFOW+JjQyW11munxCjlfo0y/20FlFz9hGwbPZY5pXnbZEwy5IVRb/n8sJnqUcpE1qeWq1nl2cGWCqKmvQ2HmMbWirxI0eAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+idCNxc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+idCNxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FBD61F000E9;
	Fri, 14 Aug 2026 12:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786710983;
	bh=BWqClbzB/B4H/7IQSQs5j4MKbXz4Ki3bYUprg4q/J+Y=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=h+idCNxc1Eyd109HT+u3iZ8t8tLsD5uJdG9wSUbXMfdKfd/EJbavvPgUr6gDPJzin
	 ZeYnnzi+RixMb081Tf6StrPHiaBaOE5kM8fZiLECzYi5Z09MzQtLMxtvKDnepKm7Xu
	 VgQA/Cidnb4H5OtvmqCjJqj4sSmivcFbTkBr0UAn3PiQ6les2883Cwpv2UXgw3RUZq
	 qwzeIlu+RXSazkD1VUbj376ULBHCfdHdEo4y8ybWoYS6BKZdoS13NwuSnUYU3ax073
	 ASy9+62rE1SYfTxis1IdPMgZ6+HhtEv/Dgc1+yXYdRcaQLqnFzVr+LqbePsrSK7M9S
	 FMfEtgbj0M+Qg==
Date: Fri, 14 Aug 2026 14:36:21 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Doruk Tan Ozturk <doruk@0sec.ai>
cc: Benjamin Tissoires <bentiss@kernel.org>, 
    Pascal Giard <pascal.giard@etsmtl.ca>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] HID: sony: fix UAF of ghl_poke_timer / ghl_urb at
 driver unbind
In-Reply-To: <20260724142703.55813-1-doruk@0sec.ai>
Message-ID: <q76p1064-64nr-9401-1183-3p7s42165r05@xreary.bet>
References: <20260724142703.55813-1-doruk@0sec.ai>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 24 Jul 2026, Doruk Tan Ozturk wrote:

> For GHL (Guitar Hero Live) dongles, sony_probe() arms a periodic timer:
> ghl_magic_poke() (the timer callback) submits sc->ghl_urb, and the URB
> completion ghl_magic_poke_cb() re-arms the timer with mod_timer().
> 
> sony_remove() drained the timer with timer_delete_sync() and then freed
> the URB with usb_free_urb():
> 
> 	timer_delete_sync(&sc->ghl_poke_timer);
> 	usb_free_urb(sc->ghl_urb);
> 
> timer_delete_sync() does not block re-arming, and while the URB is in
> flight the timer is not pending, so the sync delete is a no-op. A URB
> completion that runs after the delete re-arms the timer, and usb_free_urb()
> only drops a reference -- it does not kill an in-flight URB. sc is
> allocated with devm_kzalloc() and freed once sony_remove() returns, so the
> re-armed ghl_poke_timer (embedded in sc) then fires on freed memory, a
> use-after-free from timer softirq. This is a disconnect/rmmod race.
> 
> Poison the URB first, then shut the timer down, before freeing the URB.
> usb_poison_urb() kills any in-flight URB and permanently rejects further
> submissions, so a poke timer that is still pending cannot re-submit the
> URB from ghl_magic_poke() in the window before timer_shutdown_sync() runs.
> usb_kill_urb() would not suffice: it only cancels the in-flight URB and
> leaves it submittable once it returns, so the pending timer could
> re-submit it and put a fresh URB in flight over the freed sc.
> timer_shutdown_sync() then drains any last callback and blocks re-arming.
> The probe error path is unaffected: it is only reached before the timer
> is armed.
> 
> Reproduced under KASAN on next-20260710 via dummy_hcd + raw-gadget
> emulation of the GHL PS4 dongle (VID 0x1430 / PID 0x07bb): hid-sony binds
> and arms the poke timer, the poke URB is held in flight, the driver is
> unbound (freeing sc), then the URB is released. The completion re-arms the
> timer on the freed sc, and the re-armed timer fires ~8 s later:
> 
>   BUG: KASAN: slab-use-after-free in ghl_magic_poke+0x98/0xb0
>   Read of size 8 at addr ffff88810b02fd50 by task swapper/0/0
>    ghl_magic_poke+0x98/0xb0
>    call_timer_fn+0x35/0x2b0
>    __run_timers+0x69c/0x9a0
>    run_timer_softirq+0x173/0x2a0
>   Allocated by task 169:  sony_probe
>   Freed by task 338:      devres_release_group <- hid_device_remove (sony_remove)
> 
> Found by 0sec (https://0sec.ai) using automated source analysis.
> 
> Fixes: cc894ac55360 ("HID: sony: support for ghlive ps3/wii u dongles")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

