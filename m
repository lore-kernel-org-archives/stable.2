Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFC13932E8;
	Mon,  3 Aug 2026 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785781680; cv=none; b=hznQ5BUguzZRCKkJwxJOaP6M6C8TBJMJPqwA/G9u2MCU6/hzPxTRWzkBlCnRPyw/hx6Gff2y5AsmsHjQot+Joo0SZF0oiGyexdkzS9lEg8gTtOs2G8YDAQauuiY1EtRU6hpj2YqldhB3DmfNXsMRDXIaCBRQPEv6hj2XaUflVE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785781680; c=relaxed/simple;
	bh=jIz3BJTDhW73H+tLjep0/ppR366ZBftJ1KK3CoTOfGM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=XETDhNZLXTsVUiRaZ1/yNachwpyg987zyp7mm//bP6tF81GfHwUUOT2UJW/8OWA6lQt/pc2KCsQsxhksGjjLf7CHXIs6VKYyAZflan7itP3oqo58PPLoQ8pbK8j+sTlei94pf969eBLIlQ+pw0ZYubAxFSz71444hVhF1s4BV10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkB7rq2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkB7rq2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB971F000E9;
	Mon,  3 Aug 2026 18:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785781679;
	bh=WmbOkPAiaMrLGRjtVF9xC4tPfFZSeLU4xssR1Id2CAg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=DkB7rq2SE2HZlq3PQCev8CRkgzaCtgPsfB711Uk8GWz8SdIBoCNtCSqW/tKkENYnM
	 Uchg5KYFdTrLhk1od/9DMNLmr9BdGe6lG5ixEw3X5MWRfZk+Xyj5di4VJdBxg+UrlO
	 Lwv/hoxlwxfQWtUR9P3U0wfWg7zwl9VQOXQki6QAmZYrvWzoMjg96yI79V0wguW8p4
	 Vvqzz6FhPTxG7lxJSGB3aY/E2xPPO3GU1A7Z0a96fwD2FDdMHdpkyJjsfHuuyUwZnh
	 rHvTJQ/uueppfIXIIkFsOcFZlJoQOggAMomquQoo+a2niGdhssjdEJb4k4ouDxgjKe
	 tc+gNvA37/p2w==
Date: Mon, 3 Aug 2026 20:27:56 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Baul Lee <baul.lee@xbow.com>
cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, 
    linux-kernel@vger.kernel.org, tomasz.pakula.oficjalny@gmail.com, 
    oleg@makarenk.ooo, bentiss@kernel.org, federico.kirschbaum@xbow.com, 
    stable@vger.kernel.org
Subject: Re: [PATCH] HID: pidff: fix OOB write when hid->inputs is empty
In-Reply-To: <20260726062503.43717-1-baul.lee@xbow.com>
Message-ID: <9s691pno-26o7-2099-0001-sn9751958r8r@xreary.bet>
References: <20260726062503.43717-1-baul.lee@xbow.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 26 Jul 2026, Baul Lee wrote:

> hid_pidff_init_with_quirks() derives its input_dev from
> 
> 	list_entry(hid->inputs.next, struct hid_input, list)
> 
> without first checking that hid->inputs is non-empty.  The list member
> of struct hid_input is at offset 0, so on an empty list list_entry()
> yields &hid->inputs itself and the following hidinput->input load reads
> an unrelated member of struct hid_device.  dev is then a type-confused
> pointer, and force-feedback init writes through it: each
> set_bit(FF_*, dev->ffbit) stores 8 bytes at dev + 192, past the end of
> the object dev actually aliases, and input_ff_create() adds further
> writes of a heap pointer and two function pointers.
> 
> Until hid-universal-pidff the only caller was hid_pidff_init() from
> usbhid, which runs under HID_CLAIMED_INPUT and therefore always has at
> least one hid_input.  universal_pidff_probe() starts the device with
> HID_CONNECT_DEFAULT & ~HID_CONNECT_FF and then calls
> hid_pidff_init_with_quirks() directly whenever the descriptor carries a
> PID usage page, bypassing that gate.  A report descriptor whose only
> application collection is on HID_UP_PID leaves hid->inputs empty while
> hid_connect() still succeeds through the hidraw claim, so probe reaches
> the unguarded list_entry().
> 
> The write happens in the USB probe path, on the hotplug workqueue, so
> plugging in a malicious device is enough to trigger it; no attacker
> software and no logged-in user are required.  KASAN reports an 8-byte
> out-of-bounds write in hid_pidff_init_with_quirks() reached from
> universal_pidff_probe().
> 
> Check for an empty list before deriving dev and return -ENODEV, as the
> other HID force-feedback drivers already do.  universal_pidff_probe()
> propagates the error and unwinds.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: f06bf8d94fff ("HID: Add hid-universal-pidff driver and supported device ids")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

