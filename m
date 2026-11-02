Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793632646;
	b=Upxm0upIUlvh7QJeFO3Oj8GbfHtzHWZ+UiJSZMVpyvvogy0kZytVbLHbuKJ+CCyrArKy
	 V/4ItsP9uKnMEhhbmVRydZQSaKsnpndBAQcmBeL2N9yQjieYJKHs+SwCj2j7KWuCylRDv
	 AItMGB3j6CNDtg+6Z8b1TbPLQQ4s6LFhLb0jRo4L7kKZ7skSUPrXG4GuLR4GjWzETLaUw
	 S/BcWZPr41sncb5QaEummR2tWQLohnxrcQYUtMDBxIkXDMwm3cfRbRBfG58hzHMCFlKXb
	 haxUAegXbmH10H4ABp+qncqmdhWzLEmqxG9ZqpH0gKhhLOIa+XYiMEnrIxmQduqKcOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793632646;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xuhqBrKW16db99x31+Khr64qplFD0yF8QwhweIPseAE=;
	b=jvNWANpCYpEOgyNTE50RL4Qz0AT29PPvEFB8v/fGXDK/SZYU6KwEFIoKyCRgRFdvtTvY
	 M3j6W8d4J4cOe+Nf3ZnllNh2OQ7PNFpM7g/48xWZjnZ2MKSY+4bSLRhSNpY//gvx1RxvZ
	 rSdBjXol4LbyeXDDJTnWPqwNDtX8pB6aVYoOZ7vEMaXNzfqm9OkgmldBdet9qKwIyzgw3
	 6PURJEQiQqLQ2jt3Oc1DqVvvJ8OqDfMtymKLlMobAus5Vu3u8SfiXyyJIUpxMR6/Pmxk8
	 b1g8E8b8yHtgfVY1y3PE8rFI0BEqrQ6eAetRt9SSpXsSjlAFMbGOq4TvDSdVHapw9Aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5168D606F3EF
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5168D606F3EF
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1ae18eb9b69so2060514c88.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 07:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793632644; x=1794237444;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xuhqBrKW16db99x31+Khr64qplFD0yF8QwhweIPseAE=;
        b=lkHqqSKrZK+WdUfynjCIApaAeMeRzhRDhk+geU2xYo+o3X2rGiWBXQmEq2xZ0abtY7
         0ODRdZFioYkkGv7Ypv2HCwm5RgJYUDrhtjn+a5HkZXJeB7eDVvsl+cBjhTRmy5gXjKgJ
         GaPsKRN9xMMAQx1RWKioUT0wr8y/cYWOdDWvwoLQEqam9oruyRg563oVhiSsl11rXkik
         cf+t9DD/vasqyGxnuA+/PmGLXSY8SPW6+dMaiwWaHcd8Th7tu5nd6wOO607+eVmyArZY
         VkG3S0Noh68JJvX/oSzPRaMQGeab4c361fGUCxizyj5C/QasiR6xoqfwvLHYOw+KDutI
         Z7yg==
X-Forwarded-Encrypted: i=1; AKwUvBysFYoYYDaqAFuoyhtB9Hsn/0jiASn2pAEqgboc73a874WEEmCiOsBhJ+dKdmjW59fAtxUds4s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLe3T+2R47SrPjQ7/yoC4Xy84kaaEqgWGcYLSZfrfMwfrtohMFy
	8waa4rn2fco5d8xgsp9RTisQW2g+5vfAh4tqUGSUzfN3u8bCh1Q9ojH8
X-Gm-Gg: AYBFou02hF/Mhf8i2XRRSJ/ZvxTu9t8xQiwmGhLwQC7VatPNHf3r2uDbWxnJ+PfmZ23
	AxViP2IrxhE01PI2iZu3otxGs2ToRZauL9L66JcSQGSMIc0wXZBbUEWphRu6rSzdX4s14zXpQ8O
	vPW/tt0FnC7CB8/lG/WK9n3YMO1Z3fEoucC3pBTYHp74lknde1F6ROcLpeSAYG8gEnXpTV4M6Ur
	l1r8kCI1XnaSHONoIpzjRiQFmVM5RbvnWjXi4ccwffd2XbMPdTpQEU9qV07By/PnDP9GoMwvuXc
	Mwrpy8E6JNyAEVjJUrg0ttQrBPhiJeDxnNa3uqbJHLyqHFsT6mJzvg2kVsrMjl1itIzsD9gkCYH
	xkPS9JrJhS0693BXihnNrhKc0yx0RKWn3Qz9Nxe/SEcbzX3PxKkOsWuH7YrLjMo+cxs61niAH2E
	0SQLg4hHkBFiHFr7fUM+mX3nf/QQPqB4IxggzlpvQRbsRvvmKGjbCQCqVl+osOGUZw+NN+4yODx
	veVRz3Xq7KzeLg3i+DvKlqwK0et6TtcliSMaXXZzAENkRdxifLL31gAaXR3vWlW3XhaDJB5nhNn
	3ZBKPcRiAePDO1kFNk+I+A/nFMeKZfvqlpBXfMfm+uWKyp8s2qbRal9mRKkEmHpeG6gwh/dQUpn
	9oc/0OzwamdUp2BM=
X-Received: by 2002:a05:701a:ca8a:b0:1a6:887b:16e5 with SMTP id a92af1059eb24-1ac5e31f9a1mr17352812c88.27.1793632644055;
        Mon, 02 Nov 2026 07:17:24 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2602:294:1:b9:a2b::1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac13ef1d4dsm31588877c88.3.2026.11.02.07.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 07:17:23 -0800 (PST)
From: Hongyu Xie <xiehongyu1@kylinos.cn>
To: samuel.thibault@ens-lyon.org, speakup@linux-speakup.org,
 linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, chris@the-brannons.com, kirk@reisers.ca,
 w.d.hubbs@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] speakup: Do not hold spk_mutex across catch_up()
Date: Mon, 02 Nov 2026 23:17:11 +0800
Message-ID: <179363263139.43100.6891425671047443776@kylinos.cn>
In-Reply-To: <20261019111505.2048-1-xiehongyu1@kylinos.cn>
References: <20261014071713.321914-1-xiehongyu1@kylinos.cn>
 <atUPbjRxDtzBZ4Vc@end> <20261019111505.2048-1-xiehongyu1@kylinos.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hello,

Since my last reply I ran an automated A/B boot test of the series in
QEMU (TCG, q35, busybox initramfs) that reproduces the stall from the
report: speakup_apollo on ttyS1 whose backend never reads, so the tty
runs out of room and catch_up() keeps retrying with nothing draining
it.

Without the series, rmmod speakup_apollo never returned within a 50s
window. The hung task reports escalated from 10s to 102s, with the
stack pinned at __mutex_lock <- synth_remove and the speakup thread
stuck inside do_catch_up: rmmod dies on the mutex, before reaching
synth_release() at all.

With the series applied, rmmod returned in all six trials, covering
repeated load/speak/unload cycles, the spkout synth, switching synths
at load time, switching back through sysfs, a no-op unload, and a
stale-fd write. No oops. A write through a /dev/synth fd kept open
across the removal now returns -ENODEV.

One number to be upfront about: with the series, unloading a synth
whose tty is still wedged takes about 30s per round. That wait comes
from the tty layer's close timeout (tty_wait_until_sent called by
spk_ttyio_release); it is bounded and preexisting - the series does
not touch that path. The unpatched behavior never finishes at all, so
the unload moves from an unbounded hang to a bounded wait.

Hongyu
