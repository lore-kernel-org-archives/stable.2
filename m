Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121123;
	b=jE0u2DHqQvub1S26Q59rpBUgi2HLp1A2bqjjlrb079HcQ/PxQO+hhvcNhw8upuUYB4ga
	 VomTinyssWNlQkHfVKUVvQnZpsUfS9OwL1iL69pMNJynhDX5K45nA+QRLqOCExQSUBu6r
	 cUJfuQF5y8xrUyG2YN/5wE5zCeZ/yv84rMfsxst0pWx+zN3xZuYPekyEh2ojk++mcJ7SB
	 iFIyEnvIlYLde2MzYbtux/EZ9ImT+P8SF6ntdCxhTXRWYjUJ8RwSmJpl6ypz7FaEU9CGY
	 8aLwhhOU/Awy15pUDCnqQujzzs1GV+k6stKFfh3JMJ/sK5eaJF1XTk9fmt2erGp4SQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121123;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=l7oadj4+9cMi0OE++QXqn4KnYvdl249G4HJYosXQ9E8=;
	b=HvH5HYV5dKX3E0B6TVtMobnZN/yYyxpZTFM+ORXXz3CR1F8dVHC6ulT8NSGCbMAiZIOS
	 kjojii1CssCpbPZKksRjrsIBczAl6wNXowAp1OvMR5I68QQlcIZgHM0MJDnym3w/Zn3bu
	 o+5NRRQ7L2OGePox6gf/Yo8G7K3Bouy6GmYyMyxcOWiogcLR0S7mrLqe+AhSIG9LVYWfe
	 qfxj5ZKdYObxkCO3yuQf8MtSRey7o9YObT7XARghYJIIubeqnk1kasQdrweH0SuaS5OqI
	 OZ2V+2WNaTI4ronGvo832BOr80SEwbLE8zsjdLAT8N4gYezWVOm22DDeRWXcGtrMJfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaCbcSi7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBC8606BBAD;
	Thu, 19 Nov 2026 20:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aaCbcSi7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B401F000C0;
	Thu, 19 Nov 2026 20:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121123;
	bh=l7oadj4+9cMi0OE++QXqn4KnYvdl249G4HJYosXQ9E8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=aaCbcSi7O6X6LRq1BFe/wsSCIG/6ne+00afVygLXzowJlubrGnYWD7QGUXMRZZ7RX
	 4WPvkzKREtIcVzBMcZEnedeBwUxaxdXSbML5Iw/d4j2MqdUVcNU4C+4AUgPo2vYwhl
	 muATMK6UisCII7wfv0YZy3Xa4ixrHNF6fvQA1TcX/c2/Phn1/74OyDdHTv8/Z+6gzT
	 cIjFPGLjoQTYv3jkRrxDVClgOi58lxfrDG35JwX9UHVkQVaNFcgk7dpRZH98ocudTf
	 K93CvAGBk/YA0Wc6/TywfQJZokMfS4G8ZQqKjBS3MiIqQUk6TuJ2RssTNCzd5pwQvU
	 PWUNYqwDGkp0A==
Date: Thu, 19 Nov 2026 21:45:20 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Waqar Gulzar <iamwaqargulzar@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
    stable@vger.kernel.org
Subject: Re: [PATCH] HID: i2c-hid-acpi: restore touchscreen IRQ routing on
 HP OmniBook X Flip 16
In-Reply-To: <20260930-b4-elan2514-irq-route-v1-1-44671bf01d05@gmail.com>
Message-ID: <75148n0r-r943-9304-n194-r66rnnq660s5@xreary.bet>
References: <20260930-b4-elan2514-irq-route-v1-1-44671bf01d05@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 30 Sep 2026, Waqar Gulzar via B4 Relay wrote:

> From: Waqar Gulzar <iamwaqargulzar@gmail.com>
> 
> On the HP OmniBook X Flip 16 the ELAN2514 touchscreen interrupt is a
> GPIO pad (GPP_E_18) routed directly to the IO-APIC. The firmware's
> touchscreen power resource does
> 
>     PTPL._ON:  \_SB.SGRA (TPI2, TPIP)        // TPIP = T0IP = 0
>     PTPL._OFF: \_SB.SGRA (TPI2, TPIP ^ 1)
> 
> while the device's _INI enables routing with SGRA (GPLI, T0IP ^ 1).
> So _ON clears PADCFG0.GPIROUTIOXAPIC and disconnects the pad from the
> IO-APIC. Linux evaluates _ON at probe and on every D3->D0 transition
> (Windows apparently does not while _STA already reports the resource
> on), after which the level-triggered IRQ never deasserts:
> 
>   - ~630 interrupts/s while idle, nearly every read returns 0xffff
>   - frames shifted by a leading 0xff, "incomplete report (67/7167)"
>   - stylus reports arrive at ~25 Hz instead of the native ~268 Hz
>   - touch stalls and false stylus proximity
> 
> Re-enable the routing through the firmware's own \_SB.SGRA helper from
> the power_up hook, which runs at probe and on resume before the HID
> reset.
> 
> Tested on board 8DA1 (BIOS F.20): idle interrupts drop from ~630/s to
> 0 after boot and after s2idle resume, and pen and touch behave as on
> Windows. Board 8DA0 is the other board ID of this model and is reported
> to have the same firmware code, so it is included, but it has not been
> tested because I do not have access to one.
> 
> Link: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2142384
> Link: https://github.com/testyfishy/hp-omnibook-flip16-touchscreen-fix
> Link: https://github.com/iamwaqargulzar/hp-omnibook-x-flip-16-linux-touchscreen-pen-fix
> Cc: stable@vger.kernel.org
> Signed-off-by: Waqar Gulzar <iamwaqargulzar@gmail.com>
> ---
> The HP OmniBook X Flip 16 firmware disconnects the ELAN2514 touchscreen
> interrupt from the IO-APIC in its power resource _ON method, which Linux
> runs at probe and resume. This patch re-enables the routing through the
> firmware's own helper from i2c-hid-acpi's power_up hook.
> 
> Tested on board 8DA1 with BIOS F.20 on Linux 7.2.8, including s2idle
> resume. The 8DA0 entry is untested (I do not have that board).
> 
> Full analysis, ACPI excerpts, and Windows/Linux traces:
> https://github.com/iamwaqargulzar/hp-omnibook-x-flip-16-linux-touchscreen-pen-fix

Applied to hid.git#for-7.4/upstream-fixes, sorry for the delay.

-- 
Jiri Kosina
SUSE Labs

