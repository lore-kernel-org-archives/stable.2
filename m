Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795127286;
	b=v2+D/Offq0eRAYo8JXEnGKNXYP+WckUHzomJ7kLAbe0jGMZVpTOLNgx4LgPZvGnDz8q/
	 IpSuPEcMEJSQCgPcWuWk9XxUJB1cufhsMi+FZpzU8l79jRSOE/y8QqEkJeDcYr3L7BUz1
	 lWEFEnt7fL+Fvx3yU6aYPf9dJ/KDebnfIw6r9EAz6uiegdO5rJGmkM35C7KJHvLawnyQG
	 dLYushdiFXXkTJG3tuhdATUGDFisC2SxSAIlIuHeXdFkT40+DlwkqXjagxBskz9QKKeRB
	 7bczyCn49j41CP32XHy99SX46AuFp07mj4eu8q+fX4RXEHrwcVc5ZiyxZEMz9oTCN6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795127286;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Subject:
	 Date:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Last-TLS-Session-Version;
	bh=cExm4v1nnoeFCJIraxxSfsSKgi1zXrIFP4E1G6KpmNI=;
	b=GW0CvjIIFhLIE7FoPU47A1XjGSnDNU2LD/s26Zb2E4XDZecfiNF4knNaH1SNOu0gVDZy
	 m2gEv0/2qLuMksuJlvti5j5RBp1RxvC2/RnneK2WiC/UWaaY9W3AAl2Vmc5OCdf51olpy
	 uozb9x8KwSo8Vya4TplTvVKl3Z+p/2p95LdWrUBq/4SRNGgCwBn4g/ViObI219S9y/gBh
	 BL5VbrSHL+WgOx3bhsd5n95orsNkUdrxePkx6ZybNxl2rb7yrxanKOZRPbVJC/bBigDaN
	 szdCzlv4/OtGmF0QS2E82gmGGiMbAcY994wu0DD4hjxRTx9k7mhd1KHvGSEtUVe61JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lNmJPseF;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAEF606A326
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 22:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFAEF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lNmJPseF
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 67614C2F4C7
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 22:28:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B64906035B;
	Thu, 19 Nov 2026 22:28:03 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7330311BC0D8D;
	Thu, 19 Nov 2026 23:28:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795127283; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=cExm4v1nnoeFCJIraxxSfsSKgi1zXrIFP4E1G6KpmNI=;
	b=lNmJPseFNU6vULqKZcykGprhLZSVuKKRpBsugkC0YpYF8QuJ+rjxj7KWOSg6gXxzEn0Ozo
	MmXv6ms9UDc7UFH3+FcoqhZoACPBooLFiFFrB+Xkux1arb46lRnNCCJlOg8b8gi+8EVolK
	7bL5+IhD8Ytp2HwWRfwNnPSURkki9miWsmuFokdhwhcpgFsUkvh35b8ILMYyPpE7yWFrbU
	R3tAO01HzsNJ2mKfcqD8OGfiyH/MQkZU+M+fj2ti+TuLbyl9fHoB/lDKLlzxnl9KBdoqWn
	Py+epuw9QflkkM/8l7B1ILc6pHoIwyyF0v2hohkZp/V2MXnP5PQSWExEzJaB+w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/2] mtd: rawnand: cadence: Fix incorrect variable
 dereference
Date: Thu, 19 Nov 2026 23:27:55 +0100
Message-Id: <20261119-perso-upstreaming-rawnand-fixes-v1-0-0c95641b550c@bootlin.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqDQAxA0atI1gYaRYu9SnExOlGzaByS2gri3
 R1cPj78A5xN2OFVHGD8E5dVM6gsYFyCzowSs6F6VC0RdZjYfMUt+dc4fERntPDXoBEn2dlxGp7
 1EJuujTRCviTjO+TJuz/PCxUg4w9xAAAA
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
controller. Patch 2 uses a newer API for one of the DMA helpers.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Miquel Raynal (2):
      mtd: rawnand: cadence: Fix DMA device dereference when DMA is disabled
      mtd: rawnand: cadence: Switch to dmaengine_get_dma_device()

 drivers/mtd/nand/raw/cadence-nand-controller.c | 27 ++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)
---
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
change-id: 20261119-perso-upstreaming-rawnand-fixes-fb73bd596d1c

Best regards,
-- 
Miquel Raynal <miquel.raynal@bootlin.com>

