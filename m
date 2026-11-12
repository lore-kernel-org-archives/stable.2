Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492758;
	b=vZHLkKZ6nWyN7kTzWYBaALEwKtFcASrDqp7MXCvvjXyNEfMc6oySFNL7Y0TsqYqzmI/E
	 XnZkS0i277LjcGPWGVv68TohI6PM3JyP37PeD7dmdQawPYUvT8qj5Fv5gzvaZAI2txa0H
	 zbnkodtxhbsHFPloxoKq8q5fV0Lw/WVzk0FsMeQAOtur2nVMLD6hjSzUrzjPiLPxVKi4n
	 t0gAKsZhQ/k7WK+xYAltrM52slwisX2/Dfh3ap1UfEcJCVy10K6ox4AUAoDihLyQ5PKO8
	 r+ak9AlMFHv2CIODdU8+FN5eW3XKNZo6F2h/CtUc8O0eN06NemP7f75Xi9pSwUohFCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492758;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=TDbuZxkNvN8aowxyfC/X+PDPpn3jYmSKVZv63IIsnfI=;
	b=1+Kl3bYN5e0N3677SS1IU+XeBz641617SVJeOmk6mw0F4V8nUwFzERjC9DCDRiBu/qjg
	 ycC9bBdZFtD+hHTub0VtFdqXBjc5S+1V8orcd339D+6s7Wov9un5jyG+aFNGf5D+LOgtr
	 s3SigrUoQt9WoaZX7AZBhpkbQV4WPq4J2TawteeeWa47D5qXy4mbcDqUrSGAULpGIE7MR
	 QTZUESUN7wa/ZnocZIERQ4wMfvs5khiWNARgzVOyl3r+5TLu15iRmhStfMiIFSaB0jOZh
	 rhaJ1in6vmSgLvuAiZoBuc0xcpzSKDTBe0boDJjTbsAjxICMMp4X19tsAxgkzOj7nlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b="bD/0ZNpr";
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB5A606A323;
	Thu, 12 Nov 2026 14:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FB5A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=bD/0ZNpr
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQMm35kmZz8Xrrd;
	Thu, 12 Nov 2026 22:12:35 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794492755;
	bh=ZcRuN24Wmn6hU9IiLgVcQF+SwN9RnpHIPOCRI81K2QE=;
	h=Date:From:To:Cc:Subject;
	b=bD/0ZNprS7MupyjdbU4v5xfOZWyxzbTbA1Z5Tt9asJYD1KmpE+JjHvHf9+sXYKEAO
	 0phmjCgHwG/QToZOHJVSeOnMtAzas/JGQ1c0iModaJXPeJnMrZJQCNbQSwLO1xEt5S
	 h5T60Cf2F1ZRuUCvxiBsiKM4nnpxFEyS6bZVyNt8RIok0xnSYnW7RyIyKzoPnA+3K0
	 fjl2fgnAuBHrRBEJXxvDpnNmr7RcpsltGSJNkbdKq23a/T8dsJwSqWDetNvy4y6sOh
	 JQk5A8pBhywslJH/06Kv1VZ/z86rxbL9gnBsV2WF1EfhvE+mRtbAFFHOoK2EC9JwOn
	 +CgMOUnjZl1CQ==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6ACECQg5055419;
	Thu, 12 Nov 2026 22:12:26 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 22:12:30 +0800 (CST)
X-Zmail-TransId: 2af96af5c94e674-dcdea
X-Mailer: Zmail v1.0
Message-ID: <20261112221230052E8YTrPU5pi8AJJy6dnh9E@zte.com.cn>
Date: Thu, 12 Nov 2026 22:12:30 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDAvNV0gYXRhOiBmaXggcGxhdGZvcm0gZHJpdmVyIHByb2JlLCByZW1vdmFsIGFuZCBsb2NraW5nIGlzc3Vlcw==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ACECQg5055419
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 12 Nov 2026 22:12:35 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF5C953.000/4jQMm35kmZz8Xrrd

The ATA platform drivers in this series have independent defects in
their probe, removal or locking paths.  They share the same shape:
state established in probe is not checked, torn down or serialized
consistently.

Patch 1 fixes recursive locking in the IXP4xx CF PIO callback, which
can hang the first data transfer, including IDENTIFY during probe.  Patch 2
returns the host activation error from the Buddha probe path instead of
reporting a successful bind.  Patch 3 makes the QorIQ and Seattle
drivers inherit ahci_platform_ops so that host teardown runs host_stop.
Patch 4 stops only the Gemini SATA bridges that started successfully.
Patch 5 serializes the controller-wide SGPIO update in the Seattle LED
callback.

Each patch touches one driver, except patch 3, which covers the QorIQ
and Seattle AHCI platform drivers.  The patches are independent and any
subset can be applied; the order lists the more severe failures first.

All five patches carry QEMU A/B test descriptions after the --- line.

Shao Mingyin (5):
  ata: pata_ixp4xx_cf: avoid recursive locking in the PIO callback
  ata: pata_buddha: propagate host activation errors
  ata: ahci: release QorIQ and Seattle platform resources on removal
  ata: pata_ftide010: stop only successfully started Gemini bridges
  ata: ahci_seattle: serialize SGPIO register updates

 drivers/ata/ahci_qoriq.c     |  2 +-
 drivers/ata/ahci_seattle.c   |  8 ++++----
 drivers/ata/pata_buddha.c    |  6 ++----
 drivers/ata/pata_ftide010.c  | 37 +++++++++++++++++++------------------
 drivers/ata/pata_ixp4xx_cf.c |  5 +----
 5 files changed, 27 insertions(+), 31 deletions(-)

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
