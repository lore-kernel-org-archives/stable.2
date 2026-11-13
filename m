Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592991;
	b=qp+feRa1JbO3UZrPUf/e06WD/AC1oSCjUlzTNTYzXlKWkvxrheYH7yY94hbxE8J0058u
	 WP4yqPdlV8q4qMEspuOtYrqf6/53CQeUsyXQKbtQkFCXtJTcjYxwts8X6GfgJ3wM9BgvB
	 cmh8NfrZULLF17e7Z5gXueZLybYRqGczMfX0EHJ7ogLbMj2i9RiwxV0V+HMirnNA5KvC9
	 jri4eL6i3PbzyZCPAnFzb2msGy09vxNPaAx2I4xQYBIvC1T4UyQsks+Nvq1sJYkGW5j3r
	 SbaokGuLqrJJEg42AJgldzU0YCkR2CYf3xTE3JlrdD0/mXDIPN371xYcwftFcOewiKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592991;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=BDCHJcU2rmlWsGcn+ewx78IR8adyNMNohPpcRFq14As=;
	b=o99htOYXorzyF5GoWC5W8TSVwz8p6bPmsDI7q85yCDj5hJ/hnxSgQwBhiJFoYY467uur
	 vwE3RH2qwo9xPmvwKB6VYk/irF+t7MIc6E2CPflGiVP8A9wO9JqmD79idjtAheHTjwFB1
	 7zQQXlfTCahtCu2eUmwokGvE2NueDqGznrrGauJJ0YH1rOqUpiztlSYZ3UomFfx/9HWy1
	 WKI/VWVwn8QWwxB6SGEVK+zmeo4FifapdLX70fiBEffvh3cF7M1G05uvDUIYJ1WXroUZN
	 kq6w1EaiZI6GF/RVctVa/gcfwC6g+PAYa6cDD947mDUc2Hgb2bXw1tSm31xlc3BmDag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=MhyKUQnl;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FE860A2624;
	Fri, 13 Nov 2026 18:03:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10FE860A2624
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=MhyKUQnl
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jR4qd60XCz5B0yy;
	Sat, 14 Nov 2026 02:03:09 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592989;
	bh=Wt8hU2Qj8hmcKvInfU21LWe6vuoriDsz4R9lOL2ZmM8=;
	h=Date:From:To:Cc:Subject;
	b=MhyKUQnlRacNizMZCT/VexD9WZJKvjTCAXX1+6qIxKwBodCwnHHEEamAtCweZNTT0
	 X9rDFUOw2GH+74l3T4V6M0i5hFKCstqtEg11sCBI/R4j+dzEL/iKIyMw91rw1U+W8f
	 QU/q6MGAcE0IsDXDDrCo4xkEDk3EAkZKJrmissMACySLVmAQAK+DQ8u13N4tN0XjRQ
	 eHEOIiiEocH5PvijHge8sOAyrXVkGgcHZ5vTbEvV3rXviZdGgvLbL98VHnupOzpAgC
	 yX5lYsA9DpmDXibfiFZsJqyH+G7+gXFnhaBC1gavSW34Z3jFSG+UmPiBeESkoioEjK
	 uUMa6X85cj8Ew==
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6ADI31Er073681;
	Sat, 14 Nov 2026 02:03:01 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 02:03:05 +0800 (CST)
X-Zmail-TransId: 2afa6af750d97c4-3b6e4
X-Mailer: Zmail v1.0
Message-ID: <20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn>
Date: Sat, 14 Nov 2026 02:03:05 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCAwLzVdIGF0YTogZml4IHBsYXRmb3JtIGRyaXZlciBwcm9iZSwgcmVtb3ZhbCBhbmQgbG9ja2luZyBpc3N1ZXM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ADI31Er073681
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sat, 14 Nov 2026 02:03:09 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF750DD.001/4jR4qd60XCz5B0yy

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

This is a resend of [1].  Patches 1/5 and 3/5 lost their final
context line in transport, so git apply reported a corrupt patch;
5/5 had the same trailing line.  The diff content is unchanged; all
five patches now end with the format-patch signature, which keeps the
blank context line in place.  Sorry for the noise.

[1] https://lore.kernel.org/all/20261112221230052E8YTrPU5pi8AJJy6dnh9E@zte.com.cn/

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
