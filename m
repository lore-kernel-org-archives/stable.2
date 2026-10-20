Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511177;
	b=W9gPBTV/YBkI72BOYk3RaBbcxoHNc4IJHs7Vy9Mst6iPjT1fEASmXOUOhyrviOv9yzVk
	 cMJPMKqMFs2w6I4PVYEavgfIrGM8mWYll/YfAeR5oBmWeaGff6rqADjlftTaN5OSQa5cn
	 8jDDkGarvE8KzeY9nXybLA3Cf59+xbfPG+1kWOULqOkQ03VnZpFX6QJqOsT65LzDBnhW/
	 QxkLXyTdgvuVpv0sbMe/lntbwIWKXvejKJiMpdu9ju64OcZJOOZoUv3kcpobsXAr9/0Ii
	 uGEZ9RNruuImxEM7MVT/f6hz0JyVnnE4N57nUTepHdJCpCyAcp1ZHodEtHlfP3k52WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c4KdIyx5wd3lW7yQNQkMYWV0DoFONhgCwEzOBtMGwk4=;
	b=ezgDZS5tWuIg+jSYMuPqoEyB0XPQa8gTETIh1BC0ZF21b3gzLkYDgCGP3a8NNAQcXBde
	 rgzfJUXezGuBfc1Vg6DLao4f/k+M9Xw3O9oIPqIJ1B6p8Y2Pmx5xkMrSFJaDN96l2doCk
	 KiaOgjHlMYdXgqbGfyuNRGHDg68m6f9MM36HZoU5LzhEFKemszcNUJcZnyRWTPNZljkJW
	 k5gmUZuyuEla4/EN90Ybe56+8sAGr+MM3Z18QDxbe9UQ7KqWocjHr7pjkqPw7oqh7t515
	 rLOQp0Ao9mJ4N/GBAqvvW2sxGlfjI7Klp6M0FWnJ5eM2JUycHyd+VeODc5FY0m0U9yA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pqshield.com;
	spf=pass smtp.mailfrom=pqshield.com;
	dkim=pass header.d=pqshield.com header.i=@pqshield.com header.a=rsa-sha256 header.s=google header.b=E38VOoas;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC86606A326
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 15:46:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCC86606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pqshield.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pqshield.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pqshield.com header.i=@pqshield.com header.a=rsa-sha256 header.s=google header.b=E38VOoas
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-48af4d4e61fso2105939f8f.2
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqshield.com; s=google; t=1792511175; x=1793115975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c4KdIyx5wd3lW7yQNQkMYWV0DoFONhgCwEzOBtMGwk4=;
        b=E38VOoasEpWAnLvnZ8WivNqYKBz0bimAwdacr+8ZuIcKJ7k3AW3YwjK9DUIuxdy8W8
         SZudXCakreIjQc7lFLgEm+Sz+i/ZJ9SA9Cu8TvgP4anK7YLb2sJwx7auHAHjegDvC2Ua
         aM/yI8rNmkNr89B+Lt++Id3WKJYSiI2IfxsA9UKEfPo5/uKWvfnen22hsctlYbk1Kjhs
         fGsiVBZXNN/vXWOyK46A7URtAoaXh/Ix7zmDKvgZ+TM2T4A/8+7qyi9DOv38vEvmJs56
         qa5IKadnUwLUQLK5FDkyHjxpGL27OsG2taw5UBBJo9MybCN5GP2B5NV/sHU0yymHo14K
         TQXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511175; x=1793115975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c4KdIyx5wd3lW7yQNQkMYWV0DoFONhgCwEzOBtMGwk4=;
        b=OMHy4koNucttodPSIDolgjYTx3JrV6CmW21+clI/DHnrqVZfuMPvlO9Rwf7zNLjOWQ
         OFk18HP29+3v97c1BgqOxQNZU/TA3cY4ewbKzO5Q/yDGC4Ryuza11Wk0v/E/BNJyP0bt
         FkbxNwZvKYbmpSm9X3gayW/cVh10gi3m4pbNlfGhtoNT7VVwRrjrA/7fg4wnT++g/BIo
         fSaR8FugLt3G5wMB9KSp5i4Gin/9Bx3eSKcRj68nA/Fx+jaGPVyZT9d1jIoHQDchX1Xe
         2pD6RktVuBCfmy1bf1oeHcQv6V3eU+6jZzGuOdYUP+xOjSNqtOKCiojRY1nCxw7UkJCf
         GgBg==
X-Forwarded-Encrypted: i=1; AKwUvByG90xMqK2Um/RPP5idZGPR9zn9dQO0NjFERw9jc+nwPsglbgdNEBa+HoPKIhMpRCoEj9/Y6nw=@vger.kernel.org
X-Gm-Message-State: AFq9FYISaVvF4uBSANBOwBycFrvChGPuFS2P62Or6dxOlTU8esNdmqMv
	XDnyTkabcGlyJVDY3N6/55IQKCOSaaf8tRFj+BU3/ijeVx7fK50vDogU0kCXTzOQ5t9H9Q1x8cw
	Ew9qmL/QbZA16UJY=
X-Gm-Gg: AYBFou1RU8JIQxdOXWNtaos0CJq1lkPfEHCzODlgRgVw3QghedEshxuQ1/vFCtKY8bs
	dW4bEhGx3sMoYUu4UOgrYjeeDA89540fbtEQ1y/4DVmXMaSuWYSmbigblhDh+2lfN7kXJXbBX1g
	cQkAR8RgUJzINen/V+3HgFmlIczRx1WridiNsUunq94pxbB6kbtUiFv4DlXoHiDbn1c0dx+5bQe
	Zz9edAcbhpfu8tyy5tqTieuT7AHvt4L8vRJVEhUDP+DkER90/29+Ot+vRPRAm1KKUqGm5Fj+nD5
	jcLPhGWupK7zfXkHrUL7FFJc5ETp3xDIXrIr8XNs50GX5QEYMdOFBX2kldHlymmBw2ZU4YfV5mg
	2QYM3BFd4SzRT+LdYlMLxSEvF6ePBj0bkLcqwHhlAKMJNITDNeOIKVpJT6giVkCQCW8EmKKHCt8
	YuDhPwSRRq/y/Xr3S2JjdkfQ43HdpqZDzdETYVGcWcTtRmKEKO0cU/LklhKEfNKxxfK5LwCURHi
	1IATjrOzV+g2hNYzX1+xCCDjAxQOg==
X-Received: by 2002:a05:6000:605:b0:488:89c7:31aa with SMTP id ffacd0b85a97d-48e07fa5687mr25408992f8f.39.1792511175008;
        Tue, 20 Oct 2026 08:46:15 -0700 (PDT)
Received: from lucas-pascal-pqshield.home ([2a01:cb14:182f:5c00:2ff6:a03b:2ad7:1e40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d82e23asm7291445f8f.50.2026.10.20.08.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:46:14 -0700 (PDT)
From: Lucas Pascal <lucas.pascal@pqshield.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Hongren Zheng <i@zenithal.me>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usbip: vhci_hcd: store seqnums as u32 to fix lost unlinks after 2^31
Date: Tue, 20 Oct 2026 17:45:57 +0200
Message-ID: <20261020154557.597177-1-lucas.pascal@pqshield.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3237a1ae-c38c-4544-97c9-0dfaf0a0bc94@linuxfoundation.org>
References: <20261019151537.112304-1-lucas.pascal@pqshield.com> <3237a1ae-c38c-4544-97c9-0dfaf0a0bc94@linuxfoundation.org>
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

Hi Shuah,

Sorry for the duplicates: my earlier replies went to you only, or were
sent with HTML bits by Gmail and rejected by the list. This is a
(hopefully right) plain-text resend to everyone.

On Mon, 19 Oct 2026 at 21:06, Shuah Khan <skhan@linuxfoundation.org> wrote:
> Can you reproduce this with usbip_host and client exchanging messages?

The QEMU test I mentioned may cover that already. It goes as follows:
- dummy_hcd is activated and g_zero is "plugged into" it.
- Host side: usbipd + "usbip bind" hand the device to usbip_host.
- Client side: "usbip attach -r 127.0.0.1" imports it through
  vhci_hcd.
- Transport: the real usbip_host <-> vhci_hcd protocol over TCP
  (loopback), no simulated peer. Same setup as the production machine
  where I hit the bug.
- Traffic test itself: I reused the usbtest test case 11 (unlink reads)
  with 3000 iterations:
  /opt/testusb -D /dev/bus/usb/<M>/<N> -t 11 -s 512 -c 3000
- As I modified vhci_hcd->seqnum at INT_MAX - 2000, the test crosses
  2^31 within seconds.

From there I can think of other tests:
- using another test case which does not focus on unlinks (case 1, 2?),
- host and client on different machines.

Would either be helpful?

> have you noticed "seqnum max" messages in dmesg while you were running
> tests?

Not in the QEMU before/after test itself. seqnum starts at
INT_MAX - 2000, above 0xffff, so given the driver code it won't trigger
the message:

  if (priv->seqnum == 0xffff)
      dev_info(&urb->dev->dev, "seqnum max\n");

However I did see it on the production runner server, ~20m after it
booted. The counter then kept going until it crossed 2^31 a month later:

2026-09-15T16:01:36+01:00 fwtest35 kernel: Linux version 7.0.0-31-generic (buildd@lcy02-amd64-060) (x86_64-linux-gnu-gcc-13 (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0, GNU ld (GNU Binutils for Ubuntu) 2.42) #31~24.04.1-Ubuntu SMP PREEMPT_DYNAMIC Mon Aug 10 09:38:02 UTC 2 (Ubuntu 7.0.0-31.31~24.04.1-generic 7.0.14)
[...]
2026-09-15T16:24:45+01:00 fwtest35 kernel: vhci_hcd: unlink->seqnum 37862
2026-09-15T16:24:45+01:00 fwtest35 kernel: vhci_hcd: urb->status -104
2026-09-15T16:24:45+01:00 fwtest35 kernel: vhci_hcd: unlink->seqnum 37865
2026-09-15T16:24:45+01:00 fwtest35 kernel: vhci_hcd: urb->status -104
2026-09-15T16:24:45+01:00 fwtest35 kernel: vhci_hcd: unlink->seqnum 37867
2026-09-15T16:24:45+01:00 fwtest35 kernel: vhci_hcd: urb->status -104
2026-09-15T16:24:48+01:00 fwtest35 kernel: usb 5-5: seqnum max
2026-09-15T16:24:49+01:00 fwtest35 kernel: vhci_hcd: unlink->seqnum 75555
2026-09-15T16:24:49+01:00 fwtest35 kernel: vhci_hcd: urb->status -104
2026-09-15T16:24:49+01:00 fwtest35 kernel: vhci_hcd: unlink->seqnum 75556
2026-09-15T16:24:49+01:00 fwtest35 kernel: vhci_hcd: urb->status -104
2026-09-15T16:24:49+01:00 fwtest35 kernel: vhci_hcd: unlink->seqnum 75557
[...]
2026-10-15T17:31:35+01:00 fwtest35 kernel: vhci_hcd: unlink->seqnum 2147467545
2026-10-15T17:31:35+01:00 fwtest35 kernel: vhci_hcd: urb->status -104
2026-10-15T17:31:35+01:00 fwtest35 kernel: vhci_hcd: unlink->seqnum 2147467547
2026-10-15T17:31:35+01:00 fwtest35 kernel: vhci_hcd: urb->status -104
2026-10-15T17:31:35+01:00 fwtest35 kernel: vhci_hcd: unlink->seqnum 2147467551
2026-10-15T17:31:35+01:00 fwtest35 kernel: vhci_hcd: urb->status -104
2026-10-15T17:31:39+01:00 fwtest35 kernel: vhci_hcd: unlink->seqnum 18446744071562096407
2026-10-15T17:31:39+01:00 fwtest35 kernel: vhci_hcd: cannot find the pending unlink 2147512087
2026-10-15T17:31:39+01:00 fwtest35 kernel: vhci_hcd: unlink->seqnum 18446744071562096629
2026-10-15T17:31:39+01:00 fwtest35 kernel: vhci_hcd: cannot find the pending unlink 2147512309

These last numbers show the bug:
- 2147467551 = 0x7fffc11f, < 0x80000000 - the bug doesn't trigger before
  2^31,
- 18446744071562096629 = 0xffffffff80006ff5 - the bug triggers,
  seqnum > 2^31 are sign-extended with 0xffffffff,
- 2147512309 = 0x80006ff5 - the expected seqnum.

Thank you,
Lucas
