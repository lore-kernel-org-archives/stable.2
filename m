Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.27.42.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793356056;
	b=xibEwgJ3l5jYiA5vuYQZPp24lMLzP1Th71KtTmy0P8P05P4TpD+UJP+mpKU9dYa6WQW8
	 8jK41CTwaMgbQW4YOmN03Wi+gs02WkD7ZZ7CelNBrmusyvenktZiohzSh4eHQ8asniV01
	 1LTLBIsi/uZH4O3qLOcprrulZCLycUeqzAPMwuLTJycA6+Rk4iWQonPrq5XjU+93/zwMl
	 QlJItetGRahee5gJN5Gm9HJS0r9mNa/eJLYGtMBEAFcD+8UhT7wDVxS/GYw43hj4YeVJl
	 ZCNuYbDy6u9fV7Pe+1nJJCJhVP20YrYee3ohkQPgr4EE/PiEIYBHP4XHEaAzonU22SQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793356056;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pVhKHDNDoM5T9HxyBalWm5anYlvoUGysI1v6q4cIp4Q=;
	b=Vg2SYZxQENWi+wuKj9Kjvmy7vDy9KFfedH7xLQKf0XTKFtd+n8nr7oR/Q+Mn+SVUI63Q
	 QZoq0sGXuvRx2qAZBjJ3AOn4IHZByFJPvMR0i3XGLMvUnDsUJqGaoUM3GHlCTy5oSiq8e
	 zcjYZD4qvvRlzFKTqvHQQDVtIT8X9pLKtV1z3rnchlT67bkrJw5ilRv9EUvPXYOjrnj9i
	 /8jdT5HBg8ZArm0v1VeA1XJUrGU+dBhSCqkDxGfVG+sbu3lZ0eaHJL3/4CGDJBzHgA+Uu
	 W798NEZyJIMrSiYvrbuGTevaJv0SABvwBbrLMhHxply7/14ik29mlstGT3w1+AL4rcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=free.fr;
	spf=pass smtp.mailfrom=free.fr;
	dkim=pass header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=qd2sNrfy;
	arc=none smtp.remote-ip=212.27.42.4
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0947F606A33B;
	Fri, 30 Oct 2026 10:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0947F606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256 header.s=smtp-20201208 header.b=qd2sNrfy
Received: from stf-laptop.peak-system.com (unknown [IPv6:2a02:8424:8fef:6e01:2a4e:9a3e:485b:cbb0])
	(Authenticated sender: stephane.grosjean@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id EE6B719F72F;
	Fri, 30 Oct 2026 11:27:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1793356054;
	bh=VfjzPRPQXMj1W3dFe2OgoIfMo0mWHnZhhwU4h8DSBno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qd2sNrfyy4Q6IWHQkI/z0vov0bn/yETXg0Ic3IcN56DwmFmsXkiTRpcu4vg9FYD+z
	 3+XQzS95rfvBQ9LtB7R/SBbywYQzCpsOiUMYATjumswHsIm9ajmP7gAR+WpxsZViyn
	 mAxVR1CL5yhudjVv4k9ENSLB/gdBmxB2eX6HSHazz2yJf8f4JTwiPqfMje04Iqw9b3
	 ZpxhsvS0cdws4Jqvt2q9d7qgjo2nAWXB4InEnSZniU2TflirjvWXxG5uY2LMDDriwx
	 NPf/ZRJVNWJlee1/rXuR4ZrJTLZw/ArKTxWm0AhWamvhP9urqDGt3WzWtDueU59abZ
	 GO+Sn5sdX3ckw==
From: =?UTF-8?q?St=C3=A9phane=20Grosjean?= <stephane.grosjean@free.fr>
To: netdev-bot+sashiko@kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	wg@grandegger.com,
	error27@gmail.com,
	lukas.magel@posteo.net,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	kuba@kernel.org
Subject: Re: [PATCH v6 06/13] can: peak_usb: harden channel handling in PCAN-USB FD
Date: Fri, 30 Oct 2026 11:27:00 +0100
Message-ID: <20261030102705.30262-2-stephane.grosjean@free.fr>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179281433224.3130.6010222623227756144@kernel.org>
References: <20261022-canfd_check_channel_idx-v6-0-197704231551@peak-system.fr> <20261022-canfd_check_channel_idx-v6-6-197704231551@peak-system.fr> <179281433224.3130.6010222623227756144@kernel.org>
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 24/10/2026 05:58, netdev-bot+sashiko@kernel.org wrote:
[...]
>>  adap_dev_free:
>> +	/* the whole interface is released when probing a channel fails:
>> +	 * stop RX on the channels already created, since their RX URBs may
>> +	 * carry records for this one.
>> +	 */
>> +	peak_usb_stop_rx(dev->prev_siblings);
>
> [Severity: High]
> Should this also stop RX on dev, and not only on its previous siblings?
> The comment above peak_usb_stop_rx() says it stops "dev and on all its
> previous siblings", but this call skips the channel that is failing.
>
> At this commit, peak_usb_create_dev() calls register_candev() before
> dev_init() and dev_set_bus(). So userspace may already have opened the
> failing channel, and its RX URBs may be in flight, when
> dev_set_bus(dev, 0) fails.
[...]
> Can the RX completions of this channel, and then pcan_usb_fd_stop(), use
> usb_if and the command buffer after they have been freed here?

Right, at this commit the failing channel itself may already be open.
v7 calls peak_usb_stop_rx(dev), which also stops RX on this channel, as
its comment says.

The rest of the sequence, dev_free() before unregister_candev() and
then pcan_usb_fd_stop() on the freed usb_if, is pre-existing: this
error path has always freed the adapter data before unregistering the
netdev. As you note, it is fixed by patch 9, after which no netdev can
be open when adap_dev_free runs.

[...]
> [Severity: Medium]
> This is a pre-existing issue, but when peak_usb_disconnect() is called
> from the probe error path, the device is still attached and its interface
> has not been disabled.
[...]
> After a failed probe, is the CAN controller left bus-on, while
> peak_usb_ndo_stop() treats the bus-off command as successful?

Yes, and as you note, the old loop already cleared CONNECTED just
before each unregister_candev(). After patch 9, it only happens if
register_candev() fails for a channel after a sibling has been
registered and opened, and also on an unbind through sysfs, with the
device still plugged.

Sending bus off (and the other commands of dev_exit()) on disconnect
when the device is still attached goes beyond this series, which keeps
the existing behavior here. I'll deal with it in a separate series, as
announced in the v6 cover letter.

[...]
> [Severity: Medium]
> This isn't a bug introduced by this patch, but the PCAN-USB Pro decoders
> look like they have the same problem that this patch fixes for PCAN-USB
> FD.
[...]
> The commit message does not mention PCAN-USB Pro. Two later patches in
> this series appear to fix this: "can: peak_usb: reject records for unset
> channels in PCAN-USB Pro" and "can: peak_usb: register the netdevs only
> once all channels are set up".

Yes, PCAN-USB Pro is handled by patches 8 and 9. This one is only about
PCAN-USB FD.

Thanks!

Stéphane

pw-bot: cr
