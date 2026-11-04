Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794919;
	b=ioWIq33S4uz6uzPhIU7aYd2KqUzmqGWhL182md5C2sozY9uSdpRvCrNjLT/Lsmx/vyMz
	 YcLHmnEkCfMe7wNUUyMWvqxUlDXCdKehomKuCmKavYqi3b6ST3y89UsBIrvnwbMBYzKYj
	 QAhq3G7NM0vX06Lx0grqvgf0A8AXZiJzCWW6+Q53CYVtYO7eoSYldNjvGwuwV3AW2Lb3n
	 AzDA+g9ulIYNxuFuba+ZA2Cq6zCLj070Y4t613er7DOn8L7cz+LVoKBkGDaLqF7yBu5cc
	 D8whikxihI+rjVV8rVPj2gO8TyfwPF5IHxp9pMOY3spngmuzVo20fRIjPwFC2tCbCHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794919;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UnEnkvalLpA9bogWtSVKDojXdVfOEBBi5ZWxJhdb+eY=;
	b=JP0x5avJHmx4v5yFchUKMytxMJ2uzsX14JaZmj9F5wG9rhcIL8R0FDBU86/TyB7Ey+l6
	 5wBMqgnHnxrFA9ar2mHSx2aBn1FNNEuiizoQHHEwSPnMgYWJJw6loDokETYKpo8AoSX2j
	 87W+U5ZBQYHpdCf0bynzqXFBjboxJPnyKKaowentiMgvW6acrGn4gnpp6EZquW/tLPyL1
	 6FummYDGONkCt5cwMwcBx1DexhUhXKvNj5mLfKFP891oZYYeZF48PVE0Q3zk+5d0x957u
	 6yl6RMIH2fY4TwMtQ0AwbARMlQS8IBSLMgMqIntT2ssIocTdOyCKuTDZ56OJPFZbRZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=Xf5Y6pVA;
	arc=none smtp.remote-ip=185.70.43.22
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC22C606A328;
	Wed,  4 Nov 2026 12:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC22C606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=Xf5Y6pVA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1793794916; x=1794054116;
	bh=UnEnkvalLpA9bogWtSVKDojXdVfOEBBi5ZWxJhdb+eY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=Xf5Y6pVA6NixcyqFrS/YDRp2gWR9+IepDHfwhMQJpdefaQMNh3wA4PqjWXybS3G3C
	 x6wBKVmmNbaYZCoYNOby2f7KaEfqrJkaZ9vCU7WMEmJFOUnXKgqZwhUYRtbF0UZPjB
	 NOxmf5CvsYYUhmL31UCuDLDrDbEGN0Aa7Kfxu0YlNsfnySG4GJlxgNWA7+G9JnE9Hy
	 Rzi8myeWIPJMGlbHlWE1MFR8y1ClzEuOZ3TncO8o8bDsKkV9fO/WQJJBv3ELtHidQg
	 y+ClPvXFKSMN3IA6uuBe0atkwvF82Xy71fuEh0KE+Owr6030lErU3/nwY8T1SMyFuD
	 8YrNVcL8+RN0A==
Date: Wed, 04 Nov 2026 12:21:52 +0000
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
From: Sinan Turunc <enscrpt@pm.me>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, sashiko-reviews@lists.linux.dev
Subject: [PATCH v4 0/2] ALSA: usx2y: Bound the PCM buffer by the URB size
Message-ID: <20261104122136.1518-1-enscrpt@pm.me>
Feedback-ID: 48393780:user:proton
X-Pm-Message-ID: b9e734d70338c72dead360983e9b291a9abbcea7
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

v4 of the usx2y buffer fix. Patch 1 changes only its comments and the
nrpacks note in the changelog. Patch 2 now also sizes the playback ISO
descriptors from whole frames, after the review of v3 found that they
were filled from the raw capture actual_length while
transfer_buffer_length used whole frames, and gives the maxpacksize
check its own message.

Patch 1 replaces the two-packet BUFFER_BYTES bound of v2 with a
two-URB BUFFER_SIZE bound in frames that does not read the endpoint,
and keeps the capture drop guard. Patch 2 adds guards in the playback
prepare path for a URB larger than the buffer and a packet larger than
the playback endpoint's maxpacksize, and sizes each descriptor as
counts * stride, all pre-existing and unchecked.

Tested on 7.3-rc7 with a USB/IP device presenting the US-122 interface
layout. The playback case of patch 2 reproduces on the unpatched driver
with ordinary 48-frame packets and a 100-frame buffer, which the stock
constraints allow. With both patches, buffers below the bound are
refused at hw_params and 400-frame buffers stream in both directions
with no KASAN report, for S16_LE and, on capture, S24_3LE. With
195-byte capture packets the descriptor sizing of patch 2 shows through
USB/IP's completion check, which refused the v3 URBs (descriptors of
780 bytes for 768 bytes of data) and accepts the v4 ones. The results
are in the patch messages.

Sinan Turunc (2):
  ALSA: usx2y: Require a buffer of two URBs
  ALSA: usx2y: Guard the playback copy

 sound/usb/usx2y/usbusx2yaudio.c | 43 +++++++++++++++++++++++++++++++++++++=
+++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

