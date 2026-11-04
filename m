Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793789552;
	b=PUIzvrMiHk8kCDrOE4usa2esT/F0wxz7y35vsa27KF0NCtLqzoya5Z5TkxWHmMPtPzRD
	 bqKFBf8BdfHUtuaU86wMytoWSEPbmdUH9NmEV9xbai71swTancoE26AMYwFdqSUUcyxqO
	 Wd2cS79pUnlEzJs7QtVFfCZ+qrf2MBUMrAsAO/oZATVYKabqWS6FAHXM0fJRSKM/mA0tQ
	 Rlg9/X2U+2abqs1DNypFPICjXglpo7LcDY+WRjEPeM3C4n2vHIiMhSjHjgtwcs/59C+5H
	 OHz2UFH72WgEL6cEzlhGGTHVqzPOUyGvBsgL5LsIyoMcAxxBZ1WJIisIWOFjfOo4S4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793789552;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=gPOtSnUHV51wT2vUVKP1LPX/njpqcDKUkh4XI/B1K50=;
	b=m96DwJF7pLHlKaYEbipg3g1crdowHGMhXjBEWJDPG3K1udTMc1gbbftZGYqmEPbdB4LH
	 aS4B4oSSEb1Lkv2MMb7FjvVt40cquOTQGlZv/itwVBnnkh0HHWCCco7/JTQdZo7Gf7HtF
	 ulvY9GKfxqCvNgEC/+EV2IjApOBEse3lncwC3UxharlXnGMkMtbMy70xUWBxuUpyla9MX
	 WLV5AErDfBOa0nI0u6hJiC8ftGJxyV6id9ZHqxIN1O0WmWHylqsCzI7eUziUR/nvusZuI
	 Eu/ay1Ct5mA8Sw2CyZXDkICjgYAza2gr6LIjrCB2srfdcSwcNetU9SViKZ2QZy3sqJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=Wx7SRqN3;
	arc=none smtp.remote-ip=185.70.43.102
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch [185.70.43.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9CF606A326;
	Wed,  4 Nov 2026 10:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D9CF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=Wx7SRqN3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793789549; x=1794048749;
	bh=gPOtSnUHV51wT2vUVKP1LPX/njpqcDKUkh4XI/B1K50=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Wx7SRqN3+anNwZ/hh06lt+MzYXXH6s4gs3Qvur0o1xHnpktZCbiLYkAnRo+QMlEb4
	 pNg9bzQilE0T35bHA/ABEqMHAGBr752Vlna5UBwmKvZGAWWR5Bg3jym70BXQ1C78NZ
	 b0gO5MM4f3z5EEW1M5efusN7X9NEd5iSl+gqs2Z9i/b4L2jecRhvY9m71eo8fLbIrw
	 ymcdHJUFwML2KEEKUkgG4oYmfojVDx9WPVNBZz2yAL1awZwuB+fkedpZO9Rh03N60/
	 VrpO/ogBJOZDcaW9ou89ALiK5XXaZJPZFBtae70eDZkZabIeM7LzUReGCb8tk246Ok
	 7mwcopSQZcRYA==
Date: Wed, 04 Nov 2026 10:52:24 +0000
To: Takashi Iwai <tiwai@suse.com>
From: Sinan Turunc <enscrpt@pm.me>
Cc: Jaroslav Kysela <perex@perex.cz>, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v2] ALSA: usx2y: Reject buffers smaller than two packets
Message-ID: <20261104105205.1099-1-enscrpt@pm.me>
In-Reply-To: <87h5hxuk1w.wl-tiwai@suse.de>
References: <20261103132247.713-1-enscrpt@pm.me> <87se1hukq1.wl-tiwai@suse.de> <87h5hxuk1w.wl-tiwai@suse.de>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: 04a17c8e6687e097ebd8ce3c89eadd1c106a7b49
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

On Wed, 04 Nov 2026 08:34:19 +0100,
Takashi Iwai wrote:
> ... and I noticed Sashiko warnings now, so dropped again from the
> queue. Could you verify whether those complaints are valid or not?

Yes, both are valid.

The critical one: usx2y_urb_play_prepare() copies a whole URB of
nr_of_packs() packets out of the ring buffer with a single wrap, so with
a buffer smaller than one URB the copy reads past the end of the buffer,
and on a later URB the length goes negative and memcpy() gets a huge
size. This is pre-existing. The stock constraints allow a buffer of two
1 ms periods, below one default URB of up to 200 frames. On 7.3-rc7,
with 48-frame packets, inside the 43 to 50 frames the driver accepts,
and a 100-frame playback buffer, KASAN reports:

  BUG: KASAN: out-of-bounds in i_usx2y_urb_complete+0x79b/0x1ac0
  Read of size 18446744073709551280 at addr ffff88800e6b02e0 by task vhci_r=
x/80

v2 did not cause it, but its two-packet bound and its comment did not
cover it.

The medium one: v2 read usb_maxpacket() in snd_usx2y_pcm_open(), before
usx2y_format_set() selects the altsetting in prepare, so the bound could
be stale or 0. The capture copy stayed safe through its per-packet check
against runtime->buffer_size; only the bound was unreliable.

v3 replaces the byte bound with a frame bound of two URBs,
2 * nr_of_packs() * 50, which does not depend on the altsetting, and
adds the playback guards as a separate patch. It follows as a two-patch
series. Tested on 7.3-rc7 with an emulated US-122: buffers below the
bound are refused at hw_params, and 400-frame buffers stream in both
directions for S16_LE and on capture for S24_3LE, with no KASAN report.

Thanks,
Sinan

