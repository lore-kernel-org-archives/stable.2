Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793743087;
	b=EsCEbT3qQrjYMgWG8BdRdwAeQBhTAjA1sLdtFpbEJxqamVRY8RcVenAIg9PuxH0Z/Nno
	 XihWOI/m/m+9ELCjY0FKEwLQhYvDJek/uKoL8iQJJWMW3WaQRZkmeNXgR5rhq3LbDCcRE
	 TJKzM4PyD/Ys/dcVUCZGGRXRX/2KF+y/Dm9VJvrMZ1njkguNWUaKu9KuTroyawVhqgqcQ
	 LTnB25QBEQK3v+2zAaUzAB/XjwhBeMjLZ3Ek2wRRcHKbKpkrjjN2ja5zir0M7dJ0PBq42
	 OZaa+fIrZgCPH6uVuDHd2AfbZKeiUmt1kHE2GHUqUX8D+C7OSAphrtr+xZOU1yW1Igg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743087;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=yPgBcDhS3l/K6o3rV3DSm2qU59TL8IzS+23Q+lTdKdY=;
	b=ZXxouSFtGTLAXpLTyFBx6tgLYRtjbOCoBxmQSxWfCr7u5LQ2xcoSkolze6raZQqS9ViN
	 3eIY2oNr1165AuPtK0vnafLmZ34WbnRQw77iDAabSrCnbATIquXSwdlx21VAJpbR3Q3u6
	 GI4DkB+TktCeJ77ErwF+cG+c0tI1QbWg3kcBS7n28i2wLlMHMO1bIqnEoaSonpVYyrWUE
	 Ln5QzHs8qv6sRfr+1aSvwM/6MYdB7cNCfi6ylh1sOkdQSYPb2Xypt01qyzkl4YaG0cpwv
	 oHB8geuh72TvaD8LwXy2hCYhM/E2w4ABZFJa5O8JKlqi+BwTeirvcUEmUDpj58BkKTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=Fd+iQUA7;
	arc=none smtp.remote-ip=79.135.106.102
Received: from mail-106102.protonmail.ch (mail-106102.protonmail.ch [79.135.106.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA82606A32C;
	Tue,  3 Nov 2026 21:58:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CA82606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=Fd+iQUA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1793743084; x=1794002284;
	bh=yPgBcDhS3l/K6o3rV3DSm2qU59TL8IzS+23Q+lTdKdY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Fd+iQUA7Ms4qv5sQLKEoIlBJ9RYHqM5H57giVY/pdeEQVds235vBjpP2BXWpX7RUK
	 RS97whK2cZfuxBAE3IF45dXwUXKBdnIyRBbvpjb613kj6Z9RHd/NR6rnJck+S7Mpb6
	 A+yvWn0HIDzp5yiP7xxnDQic38vDza1dqUGIcft9bNycrqQpZSGmFiOACheeT9iyqv
	 xhTTz1vcw2Jmm7Dsf1NqKVqe2GD5z3VLu1r+1YyZHBQbiW1ETxCOERA42cbIRBLqUZ
	 GbLBP/4JVZzC4pW1p8yBeC7I2HMuT2i6+EyY0sfXRwhoI/xLj7RC/4QTK1CH/SKDIi
	 HRlMZGInTBg5w==
Date: Tue, 03 Nov 2026 21:58:01 +0000
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: The Darkbird <thedarkbird@protonmail.com>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>, "eadavis@qq.com" <eadavis@qq.com>, "tiwai@suse.de" <tiwai@suse.de>
Subject: [REGRESSION 6.12.y] Please backport 70b4db7d2581 ("ALSA: usb-audio: Use the right limit for PCM OOB check")
Message-ID: <shfaXkZCI7FtyNr5tS4kCC_d5E4uQFhc0MtwJa2CQFXpNMfSw7Ub6urwWpGrcoRnHuoneJEi9mLwtnvVImMhz1Hb25iwNJxx8GZZsDCV_HE=@protonmail.com>
Feedback-ID: 23654000:user:proton
X-Pm-Message-ID: 37861ae8205a94bb379d1365cf092ca5056b5e9d
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

Hello,

First of all: I noticed this regression on my LMDE 7 install and let=20
Claude analyze the problem. I thoroughly read its analyses, read the kernel=
=20
code diff involved, and I deemed it probable enough to mail it. However, I=
=20
have no technical experience in this matter, nor with kernel-related coding=
,=20
nor reporting regressions like these, so keep that in mind. I sincerely hop=
e=20
I won't be wasting your time with AI-generated nonsense.

-----

Please backport the following upstream commit to 6.12.y:

=C2=A0 70b4db7d2581 ("ALSA: usb-audio: Use the right limit for PCM OOB chec=
k")

It fixes ef5749ef8b30 ("ALSA: usb-audio: Prevent excessive number of
frames"), which went into 6.12.114 as commit 81e4b0009f2a. The fix
itself did not follow: it is not in 6.12.114 or 6.12.115, and it is not
in queue - 6.12 as of 2026-11-03. It has been in mainline since
v6.19-rc7, and 6.18.y already has both commits (6.18.10).

On 6.12.114 and later, USB audio playback is completely silent on
devices that use implicit feedback. In data_ep_set_params(),
ep->max_urb_frames is only assigned for playback endpoints without
implicit feedback, so for implicit-feedback playback it stays 0. The
check added to prepare_playback_urb()

=C2=A0 =C2=A0 if (counts < 0 || frames + counts >=3D ep->max_urb_frames)

is then always true. The loop breaks before the first packet, frames
stays 0, and the function returns -EAGAIN for every URB, so no audio
data is ever sent. Players that sync video to the audio clock (mpv,
Firefox) show a black picture.

Hardware: MOTU UltraLite-mk5 (07fd:000c), which runs in implicit
feedback mode according to /proc/asound/cardN/stream0.

=C2=A0 6.12.113 (Debian 6.12.113-1): works
=C2=A0 6.12.115 (Debian 6.12.115-2): no sound at all

The code above is identical in upstream v6.12.115, so this is not
specific to Debian.

Note that 70b4db7d2581 does not apply cleanly to 6.12.y, because the
loop in prepare_playback_urb() is one indentation level shallower
there. The change itself is the same single line, and it applies with
"patch -l". I have not built and tested a 6.12 kernel with the fix.

The original report of the regression on mainline:
https://bugzilla.kernel.org/show_bug.cgi?id=3D220997

#regzbot introduced: 81e4b0009f2a

Thanks,
D.
