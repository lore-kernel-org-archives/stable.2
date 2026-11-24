Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795512273;
	b=mcGegRRyQ2QdESvwZyurPQKTr0OvkY5MGtkwmgVOrRboI9R1RnZ3AdhPVVgdFvWR5gJT
	 oY2zBBzhuWvJUivP6TqS2OZN7G+UhMzxDI0RXHBGaAgzZtHDvq/BFAXeLwTj68hE8qYqB
	 RCHy68PWpKbHiEBBlNyYr1ivD73fvjcckQw/ofvD2R1f/U0L9EayMQvNGObnuhCwYb/O/
	 pGUVa1mqRQN17ujlkDwwlOp84d6RnYDxCSfRHENJyRZgftD/mpbmiluxVdHquGNkI2PWM
	 l57kC+Pt8amXgUpGrpQYTjLpisVHKpWSCROIWNQ0Y9aDEXnV67S+pahrnjn4vGTOtUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795512273;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=ErlUnItM2bJrYKuLZXeyKH1pw6LrTqwX7tmnsb6bczY=;
	b=4Yk4oM65ioJNs9RquG7s2RxV0Hx03ZQIxJzeFoFYOlAi1IiCbH2SsrKPgnntMMGLed3v
	 lzeHMbfJrw+wqxMcY9t/VuHc3xr6j+g7G5FywKn8JotyjuRBRdCGCWjvhBJuUN+nTLxgB
	 vp0fuEjcQFLh7wbimEZ6pgUnXgOufJ3xk+pL//fCaa4jGlslXohQjWAABn2JH3JpKkfcr
	 Xb2sRecdtlOwCJ8BoE6j2YwCugiMPkQBASVW6eXmv4kjQptxly59IXlzIq5T7/NZQ9D6L
	 x6LIFX6Xs/nW44q1CFf+h+/974F2yXeiTYvhgMmYLzzL7iasVvIVLjn2Wio0jAPCwHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=v4Jfiv6p;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4FB606A33D
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C4FB606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=v4Jfiv6p
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 74E43C4CBEC;
	Tue, 24 Nov 2026 09:24:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 11349601E1;
	Tue, 24 Nov 2026 09:24:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 319AA11E68C80;
	Tue, 24 Nov 2026 10:24:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795512270; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=ErlUnItM2bJrYKuLZXeyKH1pw6LrTqwX7tmnsb6bczY=;
	b=v4Jfiv6pkXQse3y32vlDDxQyWbunmg1FQl8vlrEw+mLYE2psH4Sq1L2VrlkX/72U+vDXMC
	xPyovGstdwL7PHREEa/KoH6rQREJJ66r2Z2z3Zp2Pp8B10eL5+0tOTN6sEevLHI7X4uckZ
	3V6bLdfZAXWIaYPX3p1vrPZMIVCwQD67kTdl8fBFG2xEl06vMJRIgqgVLYRvXgqn/tFH4p
	usK9ww7gBZyx98DEYPsFJVwb/RGifb8/6q9ixuJSdvjQzyV5/MXDBu9WsL6VVLEBWdZ299
	j7dam/FQebX+aRBan+5inuXw8G8qiAVYU8TBc0G1j1OSX4Hu8W+5LzkiMExTfQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 0/3] mtd: rawnand: cadence: Fix incorrect variable
 dereference
Date: Tue, 24 Nov 2026 10:24:21 +0100
Message-Id: <20261124-perso-upstreaming-rawnand-fixes-v2-0-69db17ad07bd@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQ6CMBBGr0Jm7ZgWLQZX3sOw6M8Ak0jbtIgaw
 t2tnMDle1/yvhUyJaYM12qFRAtnDr5AfajAjtoPhOwKQy3qRkrZYqSUAz5jnhPpif2ASb+89g5
 7flPG3lxOxqm2cdJCqcRE+1Ai967wyHkO6bMfLvJn/28vEgUK26rmLI1Swt5MCPOD/dGGCbpt2
 76Rk9fQ0AAAAA==
X-Change-ID: 20261119-perso-upstreaming-rawnand-fixes-fb73bd596d1c
To: Richard Weinberger <richard@nod.at>, 
 Vignesh Raghavendra <vigneshr@ti.com>, 
 Niravkumar L Rabara <niravkumarlaxmidas.rabara@altera.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Small series fixing a report dating from September on the Cadence
controller. The last patch uses a newer API for one of the DMA helpers.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Changes in v2:
- Add a patch resizing the bounce buffer before the BBT scan, which
  fixes a potential heap buffer overflow reported by Sashiko.
- Convert the buffer mapping in cadence_nand_slave_dma_transfer()
  to dmaengine_get_dma_device() so both ends of the transfer are mapped
  against the same device, again as suggested by Sashiko.
- Link to v1: https://lore.kernel.org/r/20261119-perso-upstreaming-rawnand-fixes-v1-0-0c95641b550c@bootlin.com

---
Miquel Raynal (3):
      mtd: rawnand: cadence: Fix DMA device dereference when DMA is disabled
      mtd: rawnand: cadence: Resize the bounce buffer before the BBT scan
      mtd: rawnand: cadence: Switch to dmaengine_get_dma_device()

 drivers/mtd/nand/raw/cadence-nand-controller.c | 62 ++++++++++++++------------
 1 file changed, 34 insertions(+), 28 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261119-perso-upstreaming-rawnand-fixes-fb73bd596d1c

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

