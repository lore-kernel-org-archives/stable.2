Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6E33932F1;
	Wed, 17 Jun 2026 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687872; cv=none; b=mOUrLAtIBLi13aYYW/FX5IKB74y/N70vHXEPyTW278bpiaLUiK0thEFQiwuzlqxSjgeoez0FsLBRdvbc6YXsbhq0sssDmrTSXpT10ustScH36zmpZT0tFSiJO+/TKesvSC4OC2PFp1Gvi2zkDyoPNq1T4OF+Vq4ilYfUeU4kUhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687872; c=relaxed/simple;
	bh=xu7aOuhQ04R4vpge7pBuLaEXJsx1pCwyTSYVw8HP9MU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pMwmDTYmGspCQ9Wk+2RPfjvjbrRhKdxPA9TKmTfr5T2tQqLVsY2QJMAbOWkEEVNfJFA6L6z73/6UmxTZFfK4CufMrscPn/keZXvPIALf/x46QvbSmRD3xjmF/GAv1rvBlFYsO+M9+UCAnM6b4VCljtOfVRUOM+e9qiaeuzwr1PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UARaXKgO; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UARaXKgO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 8E6BCC2BB3F;
	Wed, 17 Jun 2026 09:17:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6A641601AA;
	Wed, 17 Jun 2026 09:17:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 425A3106CA30F;
	Wed, 17 Jun 2026 11:17:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781687864; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=iZjSYv5+s2q2RljvmzW/0JQPykBdiJHijmZR1vkN4PA=;
	b=UARaXKgOWONpm2AfTIUcVizriXzTigTxagYOI+sQ5PAE5JlsEYsjEAqZtAw/Aj1T2VSZfp
	7Sqi3JxaFZhrS77Qj+LpVGCL64IyvLPFbLy6ry+6YjnhuP962bNXch2Zm4HTLV0YwmH/l4
	VZ0o99YfNW4HofI5LCXAf5JZcede81UaeOqLw6q+nc1SE7x2FVTrKRBf0yTpXNdot63p8J
	UMiW7JiO5vvsrati/VI3dAUTgaFq1rzZ3+dKc3g2il1nPz5yoP+iRNd3YD8Cr5mQExyca2
	2UN88CfNSKng1hlj885IAsk9vmuxbAzAjCDTfZvMeR5gZsaL2yMpvXlmNxqbYA==
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: [PATCH net v3 0/2] Drop in-flight Tx SKBs on MACB close
Date: Wed, 17 Jun 2026 11:17:28 +0200
Message-Id: <20260617-macb-drop-tx-v3-0-d4c7e57d890b@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NQQ6CMBREr0K69ptSCgVX3sO4oO1HaoSSthIM4
 e5CdSEuZzLvzUw8OoOenJKZOByNN7ZfQ3ZIiGrr/oZg9JoJo6ygnGXQ1UqCdnaAMEFTKRRMMKp
 pTlZkcNiYKeoupMdArp/SP+UdVdhE26w1Plj3iqdjGsdfP9/7xxRSkBkqKUqhS67P0trwMP1R2
 S7KR/aLl384AwoFF02eVpUudbPHl2V5A+OLSoQAAQAA
X-Change-ID: 20260423-macb-drop-tx-f9ce72720d05
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Haavard Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik <jeff@garzik.org>, 
 Conor Dooley <conor.dooley@microchip.com>
Cc: Paolo Valerio <pvalerio@redhat.com>, Nicolai Buchwitz <nb@tipi-net.de>, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>, 
 Gregory CLEMENT <gregory.clement@bootlin.com>, 
 =?utf-8?q?Beno=C3=AEt_Monin?= <benoit.monin@bootlin.com>, 
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

The first patch is here to allow giving a drop reason.
We dissociate consumed packets from dropped ones that way.

Second patch is the main one: it drops unsent packets on close.
MACB driver forgot freeing its SKBs (and associated DMA mappings).

---
Changes in v3:
- Drop stats fixing. A proper fix deserves its own net-next refactoring
  series to migrate to netdev_stat_ops (ynltool uAPI), which will come
  in later. We keep the tx_dropped++ because they are safe as every
  other context is disabled when macb_free_consistent() is called.
- Rebased to latest net/main (406e8a651a7b), nothing to report.
- Link to v2: https://patch.msgid.link/20260428-macb-drop-tx-v2-0-647f5199d8df@bootlin.com

Changes in v2:
- Increment tx_dropped stat once per SKB, not once per frame.
- Reset tx_head & tx_tail to avoid keeping stalled cursors.
- Fix SKB dropped reasons throughout by adding the reason as parameter
  to macb_tx_unmap(). This is a new patch. Then the drop-all-on-close
  fix can use this ability to report we are not consuming SKBs.
- Add increment to stats->tx_dropped on DMA mapping failure and
  tx_error_task. Done as separate patches (3 and 4).
- Rebase upon net/main @ 46f74a3f7d57, nothing to report.
- Link to v1: https://patch.msgid.link/20260424-macb-drop-tx-v1-1-b3ecb787d84d@bootlin.com

To: Nicolas Ferre <nicolas.ferre@microchip.com>
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Jeff Garzik <jeff@garzik.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Paolo Valerio <pvalerio@redhat.com>
Cc: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: Benoît Monin <benoit.monin@bootlin.com>
Cc: Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

---
Théo Lebrun (2):
      net: macb: give reasons for Tx SKB kfree
      net: macb: drop in-flight Tx SKBs on close

 drivers/net/ethernet/cadence/macb_main.c | 46 +++++++++++++++++++++++++-------
 1 file changed, 37 insertions(+), 9 deletions(-)
---
base-commit: 712927eaa34199bb62cf370af591c0550ba977de
change-id: 20260423-macb-drop-tx-f9ce72720d05

Best regards,
--  
Théo Lebrun <theo.lebrun@bootlin.com>

