Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993C54FD789;
	Tue, 13 Oct 2026 12:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791896142; cv=none; b=lj0SOUCPA2DjNiVlTWKuURchnpcRuJLX2li5KxqJwh631sxezbLQtz9d0bVc/EUp3hn26HCylA3alA02EypfoC2aSl4hG6DgDdTS5lHbDHyJWuHoy65OKwV7CkZtnvNjmNdMsmGgpVPTb+hYVwOJYpqLIPztrLWoU4VBbZ0H0kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791896142; c=relaxed/simple;
	bh=7i9Epf4o0SHeMIr1rVNgs8LOdyoj+UszO1GeXaq3+r0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o9mjEoy38uBz2fWt4EyleJ2Rox8qyQB6S+ea8s7hbyEXDxLjekPNQNzBfZSDikTRYm9hGSkVnmi9dhnqQA6XKI3V+BVpvkAZ9epfCciwmqM62dBDB1W9i/B1CedaioWx1DmHs1EpHYs+zONUA8sEu5/o5QfkY5cABUUYNiZmCvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=IPDMhIFt; arc=none smtp.client-ip=188.68.63.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="IPDMhIFt"
Received: from mors-relay-8201.netcup.net (localhost [127.0.0.1])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4j3vS15CyTz439n;
	Tue, 13 Oct 2026 14:54:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1791896081;
	bh=7i9Epf4o0SHeMIr1rVNgs8LOdyoj+UszO1GeXaq3+r0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IPDMhIFtTX5JNjv33QQAgGOHFvY1X2wH7yLR566ThKimdwjWcpqIpNQb1mb76ujaC
	 6FALGKixxQqRgbzpR209ybwsC4GWk1TdV0fY3Oj+WltERtQ5qQ9rPdwxdZo3LyVTUV
	 8F8ELTDSh15hBG1K8xZ/U3EiLA5nV7fVt3Gghg0gaUk60XwyzKGM+/970KdmLEXhk7
	 YT90/8i+mLfZ3yW54jSzHE/MGFMeHVb9ViJNBGfQxWvALGyYu5AYimP5uPWeQndaV5
	 F9cCKh0TCXmEHy0nCfqm5k3sdF4EdmlCKAZdr5pkP1uVvwBWh4JREzmFyrTToIQu/Q
	 a6bPe07pzZYHg==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8201.netcup.net (Postfix) with ESMTPS id 4j3vRY3hN2z46VD;
	Tue, 13 Oct 2026 14:54:17 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4j3vRV056lz8tYV;
	Tue, 13 Oct 2026 14:54:13 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id D26885FA0A;
	Tue, 13 Oct 2026 14:54:08 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <fe51a4ac-540f-4d14-ba76-b69b0eb17164@leemhuis.info>
Date: Tue, 13 Oct 2026 14:54:08 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] HID: usbhid: skip interrupt IN polling for devices
 with no input reports
To: Ahmed Yaseen <yaseen@ghoul.dev>, Jiri Kosina <jikos@kernel.org>,
 Benjamin Tissoires <bentiss@kernel.org>
Cc: Denis Benato <denis.benato@linux.dev>,
 Antheas Kapenekakis <lkml@antheas.dev>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Alan Stern <stern@rowland.harvard.edu>,
 Kerim Kabirov <the.privat33r+linux@pm.me>, GameBurrow <gameburrow@pm.me>,
 regressions@lists.linux.dev, linux-usb@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260828104159.62399-1-yaseen@ghoul.dev>
 <20260828104159.62399-2-yaseen@ghoul.dev>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20260828104159.62399-2-yaseen@ghoul.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <179189604945.249777.13990098998483599791@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: D26885FA0A
X-NC-CID: 4pRg8IrCsnexsSi7MDa3wWNm3fLMh/H76nHXDh6n6IC4i3wBeSA=

On 8/28/26 12:42, Ahmed Yaseen wrote:
> usbhid starts polling a device's interrupt IN endpoint on open
> (usbhid_open() -> hid_start_in()). If the report descriptor declares no
> input reports there is nothing to read there, so the poll is useless,
> and on some composite devices it is also harmful.
>
> The ASUS ROG N-Key keyboards expose a second, input-less interface used
> only for RGB control via feature reports. Opening its hidraw node (any
> hidraw reader does, including SDL/Steam Input or a plain cat) starts the
> pointless IN poll and keypress reports on the keyboard interface get
> dropped for as long as the node stays open: a lost key-down drops a
> letter, a lost key-up leaves the key stuck. usbmon shows the dropped
> reports never reach the URB layer.
> 
> The useless poll itself is long-standing; commit 4ac74ea68f64 ("HID:
> asus: early return for ROG devices") is what exposes it on these
> devices by keeping the input-less interface alive instead of ejecting
> it, so its hidraw node can be opened and the poll started.

Hmmm, what's the status here? Ahmed, is this still needed, or was this
fixed in some other way? From the the outside it looks a lot like this
regression fix feel through the cracks, but would be good to get into
7.4-rc1 to finally fix the dropped keypress reports.

Ciao, Thorsten
> Skip the poll in usbhid_open() when the device has no input reports.
> Feature reports and hidraw output keep working over the control and OUT
> endpoints, so the interface is otherwise unaffected.
> 
> Fixes: 4ac74ea68f64 ("HID: asus: early return for ROG devices")
> Link: https://discuss.cachyos.org/t/keyboard-input-issues-on-asus-rog-strix-16-2025-with-cachyos-during-gaming/30823
> Link: https://github.com/ublue-os/bazzite/issues/4590
> Cc: stable@vger.kernel.org
> Tested-by: Kerim Kabirov <the.privat33r+linux@pm.me>
> Tested-by: GameBurrow <gameburrow@pm.me>
> Signed-off-by: Ahmed Yaseen <yaseen@ghoul.dev>
> Reviewed-by: Denis Benato <denis.benato@linux.dev>
> ---
>  drivers/hid/usbhid/hid-core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 96b0181cf819..d7cf2b56e117 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -688,7 +688,14 @@ static int usbhid_open(struct hid_device *hid)
>  
>  	set_bit(HID_OPENED, &usbhid->iofl);
>  
> -	if (hid->quirks & HID_QUIRK_ALWAYS_POLL) {
> +	/*
> +	 * ALWAYS_POLL devices are already polled from usbhid_start(), and a
> +	 * device with no input reports has nothing to send on the interrupt
> +	 * IN endpoint. In some cases polling is harmful: on the ASUS ROG
> +	 * N-Key keyboards it makes the sibling interface drop keypresses.
> +	 */
> +	if ((hid->quirks & HID_QUIRK_ALWAYS_POLL) ||
> +	    list_empty(&hid->report_enum[HID_INPUT_REPORT].report_list)) {
>  		res = 0;
>  		goto Done;
>  	}
> 
> base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f

