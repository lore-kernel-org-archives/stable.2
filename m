Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792821950;
	b=AQGBbwJe/PS9VTbx9qk5R6Mc8SbqXAfcdjECgdRhEJN9HX2Rpqjkk5/SB/z7nJ6In1Xv
	 yrMv7IVU3hxhJLmCJ6vQleZfU1HM2bQFLNfOVfccyOwcJRdx9UdjqTotjLCMc1gRCIVIq
	 y09mA9fMY8A2LxMi52juV7VHKA06uvvZfChkBNVTBs2W5xLtqX01Pnln7ZlcCm8hwkChm
	 CcAiNKH43CbnSmXPqbFcYl1Vb5OZ2jmVGQKURzGhthzTCadyC39ppoiUF0JrbX5ayW7A9
	 xdFNFYLNLcCS5GT6iRf40PRdpALSSWV7nx3xQLDkGPDfadiUFNX8lrVdNM5F9ADmoBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792821950;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Type:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LyrLp7MtnHDCZQrIuhGxBdHMfkxuSL1N2R4p1hgpS5w=;
	b=O2O2I6VUi1WlXdapBIKkZA4HB7MNgWkR7sfOkyVK778cM9sohb0dFIMAdhFBos/4KZbl
	 sEXba6aP398JnFw5jGJzEO1+cTvajPPCLH8S/aa5TMOUk7/mFzEneAl66+1wtqtg8YY4y
	 f8LCUgWVDSGiUYu6ZvGBYfTXkuycDCFOvAipFJBoL4NDcJocW9P3b8dWI7U9ldxSFvtxT
	 XH5RegFolCqzAkC50GRGB0pdO0T33tT//AXD/9ioApXolv4u2u+2yRM2ju4noLW0pb46v
	 cyoI4Zw8Ock5dHwM6DKiuy0CGloPjLDw5krV8tXuk35fEnsDQ0E4O1rkbBQijp8ppJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=justthetip.ca;
	spf=pass smtp.mailfrom=justthetip.ca;
	dkim=pass header.d=justthetip.ca header.i=@justthetip.ca header.a=rsa-sha256 header.s=key1 header.b=Na3gC1q6;
	arc=none smtp.remote-ip=91.218.175.235
Received: from mta0.migadu.com (out-235.mta0.migadu.com [91.218.175.235])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA3D606A31E
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 06:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DBA3D606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=justthetip.ca header.i=@justthetip.ca header.a=rsa-sha256 header.s=key1 header.b=Na3gC1q6
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CNfYvZVz1LcysgHlM339INEK/Wv9LylLtDOS5Oht0h0=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792821945; v=1; x=1793426745;
 b=Na3gC1q6TylKXoTQ4hhVl4427lJ3dydm3QPiqsE3hW857yJ8aAZfaodx9+Psdh7JnNWjZ5d1
 aIglVvNZeIMZnepdOygtGv27C6AVYM64t+8fcPh3jDDPWsAQBHTPXgs/LtHg6eFoQnBhm6eGYgy
 /Z5E0oAOlxOndO4Bgt1HOtSaH2vnpIpqFIBdYs9UZ3HcxA9D8ALDcM8AmwqpT4puNnLptLVGusG
 JWkvb8qZOBgr38I2ed2f6GE+hwGu0uF0NqmvMMhXPiooa+Y1KkYlwKIga6gZsgGCpd1WEwvZ6/s
 5wrKVKINZGfz+/o1OmP6oBX6nysj9t1SNwh/dKdQ3XVzA==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1f07bef94bd888e6;
	Sat, 24 Oct 2026 06:05:45 +0000
X-Mizu-Trace-ID: 1f07bef94bd888e6
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: Ilya Shidlovskiy <shidlovskiyilya@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>,
	Johannes Berg <johannes@sipsolutions.net>,
	lorenzo@kernel.org,
	ck.chang@mediatek.com,
	eason.lai@mediatek.com,
	emery.hsin@mediatek.com,
	sean.wang@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [REGRESSION] 7.3: mt7925e hangs on hibernation restore; fix c182bfe944eb only queued for 7.4
Date: Fri, 23 Oct 2026 23:05:42 -0700
Message-ID: <20261024060542.52883-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAGjg407dj0uZ0rCrL4G=PDkQv4-QC_og9Eeg7ewWzxqBvU4b2w@mail.gmail.com>
References: <CAGjg407dj0uZ0rCrL4G=PDkQv4-QC_og9Eeg7ewWzxqBvU4b2w@mail.gmail.com>
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

Ilya wrote:
> Could it go to Linus through the wireless tree for v7.3? If
> that is too late, please make sure it is picked up for 7.3.y stable.

v7.3 shipped without it, and the 7.3 stable queue does not have it
yet, so adding stable@.

Stable team, please apply to 7.3.y:

  c182bfe944eb ("wifi: mt76: mt7925: fix reset panic caused by the WM2 rx irq mask")

It fixes c4edf9e3e0e5, first in 7.3. No older stable tree has it, and
it applies cleanly to 7.3.

Hibernation is one way in. Every chip reset on an MT7925 over PCIe
hits it, and the driver resets the chip whenever a firmware command
times out. Forced resets on 7.3.0:

  MT7925, stock          NULL pointer oops in napi_disable
  MT7925, with the fix   recovers, traffic and a reset while
                         associated both fine
  MT7927, both           recovers

Thanks to Ilya for the report, and to ck.chang and Eason for the fix.

Devin
