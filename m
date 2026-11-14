Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677756;
	b=FrFBxwR+7rtCEVH09WvSnGFk5Y4zFdmEJftBgKDW8zzdPS74sLzApb3z/v8hQS/txJZM
	 /0VoPxKq38UHAH9KqHtXXHMq6xoXGvAkqCab7uLjtRPap7KEmCueNbyB80zFXuDufv43c
	 enR3EJitdng/VfF+/SPMiIksWSzPeobdlVCLmAAMHgT7HN4bcK9m6HVqLWc8LCYSRYsp+
	 ooa5+zS2Pnliam2tvV+qzYvZnC60ePMMpxCVKql1ayNGGPsxeBKpismABY1adGxNLV1jB
	 U7g5QN4CtYWbKAqsLRUtsuoP2ldpuhQe3MVsLuKLfE1hftWwXGaSFd1tPq0fAgB3ENA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677756;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qK7SuyRaPZU4Zu8y5BHFfEAd1B/irS9odpnB5X268FU=;
	b=VpFeWjlYDVhk+xor/hx+u87Enlky1DEWfO7ydXtHUAt68vSg3WS/yXP6Rq69yRrgWjPt
	 tYzubwAaFGnPMxoZyMyQ8u6Q7X9HCTwCySt2PBSgZI170KkmnBSJ76OjVx9/FtxHmIsOw
	 t5MvkwMfSfLA26ptuRDhV9sZ5A/GqJvSwyKSKyKjIaKoXBM81sTYzQ0Kv826BHn/E9P6m
	 V5650gTOA85Dd9T5wMEHEexpSpKYyqIA3bM4lUtOhot+AepXw1SYpI/QHUQGqhEOuCXDX
	 4KTi7oYvtJMGXHBHOt2gJUI6EyDhSJetKWiL9+ICy7Sm7J1djGfoxU+KGqwuKmWIchg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=justthetip.ca;
	spf=pass smtp.mailfrom=justthetip.ca;
	dkim=pass header.d=justthetip.ca header.i=@justthetip.ca header.a=rsa-sha256 header.s=key1 header.b=v+0QoPX8;
	arc=none smtp.remote-ip=91.218.175.22
Received: from mta0.migadu.com (out-22.mta0.migadu.com [91.218.175.22])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C949D606A334
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C949D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=justthetip.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=justthetip.ca header.i=@justthetip.ca header.a=rsa-sha256 header.s=key1 header.b=v+0QoPX8
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2E6UwzKVw7xbUUzy4LRhSE/cy3bndWxPXfWiSHkxIRI=;
 c=simple/simple; d=justthetip.ca;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794677753; v=1; x=1795282553;
 b=v+0QoPX8dnT9S1HhuRc4W7BP60sTbojQ7gjTlfbKmjHx2O1ZdoQoQasPl/1gRvcgZmNdmB0S
 nG/XsQvSG32fSAsMVhln1wwsjXQPkahZ2G3C/ZEIJSyoaClwzzvNPvuAhT5yH1B2F/SOBtFGdDt
 NteqXejawRnA71OQ6cNaSzlJBa7YImTxAURHPYeDfY/5gze8jWCQoxwJQp4Hz/zsR1XEr8/pLY0
 IdEIViFKOAfjBPHGi+vfqdf4G6O3JASzljz4+3RtvOs2AD8ucmSpQt1rVxjZdcpkmDsLzLZu2sB
 E26mEUTgrckRsEIk8xXY6tHoMvIK0nxuE1tcXZfHWbuPA==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4af640e38ee65c47;
	Sat, 14 Nov 2026 17:35:53 +0000
X-Mizu-Trace-ID: 4af640e38ee65c47
X-Migadu-Flow: FLOW_OUT
From: Devin Wittmayer <lucid_duck@justthetip.ca>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Hao Qin <hao.qin@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>,
	linux-bluetooth@vger.kernel.org,
	regressions@lists.linux.dev
Subject: [STABLE 6.6] Bluetooth MediaTek controller reset fixes
Date: Sat, 14 Nov 2026 10:35:50 -0700
Message-ID: <20261114173550.5736-1-lucid_duck@justthetip.ca>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Hi,

Please queue these two for 6.6.y, in this order:

  a7208610761a ("Bluetooth: btmtk: Remove resetting mt7921 before
                 downloading the fw")
  33634e2ab7c6 ("Bluetooth: btmtk: Remove the resetting step before
                 downloading the fw")

6.6.145 brought in the controller reset they remove, as a dependency
of another backport (1c770a550df2, upstream ccfc8948d7e4). 6.12.29 has
both already [1].

On 6.6.162 an MT7921AU USB adapter on a USB 3.0 port has no Bluetooth.
Setup ends with

  Bluetooth: hci1: Opcode 0x0c03 failed: -110

and the controller cannot be powered on. On a USB 2.0 port it works.

  6.6.162, Alfa AWUS036AXML at USB 3.0    as released   with both
  boot                                    0 of 1        1 of 1
  plug-in                                 0 of 1        1 of 1
  USB reset, then probe                   0 of 5        10 of 10
  the same, Wi-Fi driver loaded           0 of 5        5 of 5

With the Wi-Fi driver loaded, its probe also resets the device [2].
The fixed kernel then still logs that line once per probe, and the
controller comes up.

Both apply to 6.6.162 unchanged.

[1] https://lore.kernel.org/all/aBxdpIabalg073AU@m.b4.vu/
[2] https://lore.kernel.org/all/20261112-mt7921u-bt-reset-v1-1-65587a4d7b81@flipper.net/

Devin
