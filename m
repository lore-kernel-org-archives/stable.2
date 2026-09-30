Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7170E4CDA08;
	Wed, 30 Sep 2026 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770397; cv=none; b=ZWf9W9hk5H7Pxbpt0L9kQsdpD6MwsN/NN45ip+JebB2xVZt8O/joovqYRL8R+sNUCa5K3im2kHkI1lu0Q0GAeDFL+QrlSDAS1UDszydqpni4GW8F/xxV1jQM4d1jSRcl42+piMeHvf3FVBDKGH/yIWO1jX+4b29cBPD7V/ilyck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770397; c=relaxed/simple;
	bh=6MSj9+4ueSWYrzoILlxvE20QnybguvccKIIuyspV3l4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPdkF1ucxbgPr3I5wp6btNE9KWRV74wEcUtiVY9tD4Qsb3S3Nw3VMwzHFmOhXho5xkssa1B65hMQDZvfUm+2LFz5qX0E0u0MK8H3Uf0XP0nPU9T73AKDSJDuJmlpgK51pzMG5n3pBdLkJQWXG754ArQIxZXyAA31icXwaLxSgEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wpl2uOHG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wpl2uOHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DAD1F00898;
	Wed, 30 Sep 2026 12:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790770390;
	bh=3si7iANsd/lOTKEE8IEi+h9CFFD4ddDFNfdaI30rXqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=wpl2uOHGJSJ8I9SNpYxeTNvRARnraDePEmxr0krNvEDN9Yl7EJmGzbyqID+22XCYk
	 63S25HyzC6oT2sikV3NniSRe0ozZHtlNVIZOlhyo56H0KOTTsw8FFv6z96iqtTGg7S
	 Xj8Aozhzfn/WDYzLX609IBw2pyuVQl/Sc8/RJfMg=
Date: Wed, 30 Sep 2026 14:13:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?Andr=E9?= Pinheiro <andre@pepdata.pt>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Antheas Kapenekakis <lkml@antheas.dev>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-input@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [REGRESSION] 6.18.y: HID: asus: ROG keyboard 0b05:19b6 stops
 working after 56d1b33e644c backport; missing buffer size fix e82ae34af29e
Message-ID: <2026093029-elevating-pungent-b8ad@gregkh>
References: <14ed23dd-b171-4ffb-b368-5c717f56188c@pepdata.pt>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <14ed23dd-b171-4ffb-b368-5c717f56188c@pepdata.pt>

On Wed, Sep 30, 2026 at 05:24:59AM +0100, André Pinheiro wrote:
> Hi,
> 
> Since 6.18.49, the internal keyboard of ASUS ROG Zephyrus G16 GU605MV
> (USB 0b05:19b6, ITE Device(8910), bcdDevice 0.03) can stop sending input
> events. 6.18.42 works. 6.18.51 is broken. I did not test 6.18.49/6.18.50.
> 
> Cause: the backport of 56d1b33e644c ("HID: asus: simplify RGB init
> sequence") made asus_kbd_get_functions() run for QUIRK_ROG_NKEY_KEYBOARD
> devices too. That function reads feature report 0x5A into a buffer of
> FEATURE_KBD_REPORT_SIZE = 16 bytes. This device answers with 63 bytes, so
> the transfer fails with EOVERFLOW. The buffer size fix is in mainline as
> e82ae34af29e ("HID: asus: fortify keyboard handshake",
> FEATURE_KBD_REPORT_SIZE
> 16 -> 64; its message says "Since the response is more than 16 bytes,
> increase the buffer size to 64 as well to avoid overflow errors"). It is in
> the same series as 56d1b33e644c but was not backported. v7.0 has the value
> 64 (checked in the source, not booted on this machine).
> 
> Symptom (6.18.51):
>   asus 0003:0B05:19B6.0001: Asus failed to request functions: -75
>   asus 0003:0B05:19B6.0001: Failed to initialize backlight.
> usbmon:
>   S Ci:1:002:0 s a1 01 035a 0000 0010 16 <
>   C Ci:1:002:0 -75 0
> 
> The HID report descriptor (1102 bytes, from sysfs) declares Feature report
> 0x5A as 62 data bytes plus the report ID (63). The device matches its own
> descriptor; the driver buffer is too small.
> 
> Evidence. Same physical device and USB host controller (xhci on 6.18.42) in
> both runs, only the guest kernel driving the HID device changes; bytes read
> from the evdev node while typing:
>   guest 6.18.42: 16776 bytes in 12 s
>   guest 6.18.51: -75 as above, 0 bytes in 12 s
> 
> Requests sent by hand on 6.18.42 through hidraw (HIDIOCGFEATURE on report
> 0x5A), device re-enumerated before each case, bytes in 5 s windows:
>   GET 16, no SET before:  7488 -> EOVERFLOW -> 0
>   GET 32, no SET before:  7776 -> EOVERFLOW -> 0
>   GET 64, no SET before:  8208 -> ok, 63 bytes returned -> 8568
>   SET 5a 05 20 31 00 08, then GET 64: 8496 -> ok, 63 bytes -> 7920
>   SET, then GET 16:       7848 -> EOVERFLOW -> 7056 (did not silence this
> run)
>   (an earlier run of SET, GET 16: 2736 -> 6984 after SET -> 0 after GET)
> With a 64-byte buffer byte 6 of the reply is 0x83, i.e.
> SUPPORT_KBD_BACKLIGHT
> is set. So with the fix the driver would register the backlight instead of
> failing. One or two runs per case, only this device tested.
> 
> Request: please backport e82ae34af29e (or at least the
> FEATURE_KBD_REPORT_SIZE
> 16 -> 64 change) to 6.18.y, and to any other stable branch that received
> 56d1b33e644c. Alternatively drop 56d1b33e644c there.

That commit is already in the 6.18.54 kernel release, can you test the
latest one to verify it is now working?  6.18.51 is a few weeks old now.

thanks,

greg k-h
