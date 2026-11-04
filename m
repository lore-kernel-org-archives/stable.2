Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.29
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794898;
	b=swXGixL3H0jjeDuMQgqleVpsZFiNS3C+pi2eyF10VEaHtNH9euK2mbbF+whXzdXjoOqf
	 9i1iszrW6YIrl7DKy3U5aRZ4oA92Ehu95BV81pb0Di8V4XUw51nuKDUx375aA1IkfQ0gw
	 oLgbJ2qmGbdc9lcoeJQLfT6bpFO1jwhMk5qDVDx3l3XqUyfJF2kGs/QJ/nf54il3nN1Np
	 ePjYJG0d6xtyFZo2YnzQRk5aPTG046szqmiSAk8nr83AxOK73qFqL6u9Y8B4U9md5Y+Kf
	 FKbNs6AMbMRlGQCDXWwrHcFTLefuH2YYLF0h0++VJaUw01NmA61N7SnvHZoOC/9RMLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794898;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=IPU5n/aemWK5Zk7I9aXIvcUrWcHVqx43/uwXdnAxPsg=;
	b=fAeBCyTLWLEasZJadUje2fzoO5lhP/ffRBFuOImW8b7Bp5RUJPFBdEHxHIm9D1UY0Iwx
	 YxN6F/tb4s/NXuOUQjEJduOGPX9R5IxCzGC7owMvwUtpxrOFawn+DIblS2p/7zsc4i6Yf
	 cChZsRkcGEiObY68vczp5LH09BB5c7GDHMd4dt2ZmMmT8oKJ1WuiB6/8xpgM4GmKp9yoD
	 N74BOzz2StqFmFAAJcyI5LPujbFzQlHbVgBhnrSz2AyM1mh0jEk8Bw0xrRU65E671ePwA
	 5xbGIjRGKwdk7VBTlJl0JAolKTf9zY8pMS88RY8gvIC9XNARhB3wJyDzgFUAUMr0dyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=Ew9Zslwo;
	arc=none smtp.remote-ip=79.135.106.29
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C21606A329;
	Wed,  4 Nov 2026 12:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92C21606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=Ew9Zslwo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793794895; x=1794054095;
	bh=IPU5n/aemWK5Zk7I9aXIvcUrWcHVqx43/uwXdnAxPsg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ew9ZslwoIeY0PA8jvTySLrCngTMq/FkujYp2l62DsZLvNMtkNcp9ddn+1LckxYJuX
	 Ur7YDfkS9XFUjYLEK/IdsJaXtOZi88vM4mHSnEhj2GMwBrjavnUjZ4x6PLJmnAhgkl
	 sA48tBXYClAR/6dBdRCp4EpJa/10obUbLTIBnJtv58Fucwiq3Nkz20WDVdyl4J5GDo
	 kDGDbZ6JW8/w2xDxy9Gq29xip+rE0DwE0XoDaBBo1yWT08hr1AVR+cyc6OV3uOVRdm
	 WhMx+yHzySYHt3B1OHthJdmxiqcobelKdoE1mE+ZFz/LdlVFhIvSc8hzs0TRfNJTtb
	 eJqValDSrt5sw==
Date: Wed, 04 Nov 2026 12:21:31 +0000
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
From: Sinan Turunc <enscrpt@pm.me>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3 2/2] ALSA: usx2y: Guard the playback copy
Message-ID: <20261104122103.1493-1-enscrpt@pm.me>
In-Reply-To: <sashiko-outbox-197138@kernel.org>
References: <20261104105228.1124-1-enscrpt@pm.me> <20261104105228.1124-3-enscrpt@pm.me> <sashiko-outbox-197138@kernel.org>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: 3c0c087de62a64768cd35af5b7c00875d40a00b0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> If actual_length has a non-zero remainder modulo usx2y->stride, can this
> still read past the end of subs->tmpbuf or runtime->dma_area?

Example 1 (a descriptor of 203 bytes on a 200-byte endpoint) does not
reach the host controller: usb_submit_urb() compares every ISO
descriptor length with the endpoint maximum and returns -EMSGSIZE
(drivers/usb/core/urb.c, the number_of_packets loop), and for the
full-speed devices this driver serves that maximum is maxpacksize. The
driver then stops the streams on the submit error.

Example 2 is valid and pre-existing. The descriptors are filled from the
raw actual_length while transfer_buffer_length and both copies use
count * stride, so a capture packet that is not a whole number of frames
makes the descriptors add up to more than the buffer, by at most
stride - 1 bytes per packet. The excess is read by the host controller
and sent to the device; the driver itself copies only whole frames.

v4 sizes each descriptor as counts * stride, so the descriptors add up
to transfer_buffer_length and, with the maxpacksize check, each stays
within the endpoint maximum, which also removes example 1 without
relying on the core check.

I went through every value in this file's data paths that the device
controls (packet status, capture and playback actual_length, start_frame
and wMaxPacketSize) and where each is bounded. The descriptor length
was the only one left unchecked after v3. With an emulated device
sending 195-byte capture packets, the v3 descriptors add up to 780
bytes for 768 bytes of data and USB/IP's completion check refuses the
URB; with v4 every descriptor is 192 bytes and the stream runs.

Thanks,
Sinan

