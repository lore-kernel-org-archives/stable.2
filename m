Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECD523645D
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493529; cv=none; b=lRjODhvhO2qp9F4iiSOXRJrITeeiyiq53O64ZMvle6OVwe46fL6FONWD9o7tD4+KdkbE3jYBOzyxheYzlC3DHf9NgfbMi+gIUi6t0x91cq8G+XhgqC5bizCu5h5X8GPlTYukqkfm4VDn9ZTQ+ZdwvTqqX16G3yrdxcfPPB+RPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493529; c=relaxed/simple;
	bh=lywlvxyNF5ZYqpbb5YtEFG35Q3vRqvrSIjvw4XwxHtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cXzC7Yyxa4nEWmXMW/G70sDq8EajNSYmmMzsNylg/xShYxrPrUCsAlAzNssS0gA2wVuKyz+ZAf2SpHQoLcipU+DVmNZU+Bygs0uVMJ+Cs0TbGEPhh7glZSVDrhxy0clQQoTwp6lJpkgcFdZVyEu94obhUyG0XA+RHcYTlx6b1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMSQ3Yse; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMSQ3Yse"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469d249c5so2903295b3a.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789493527; x=1790098327; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TllSv8C91B6/5oyiPgB3bIf4ptvSZ4N3RPUetFlm1DM=;
        b=GMSQ3YseyO3ssrgNLENHYQyCxYXWFenrCK5YT1QUl86Hje4Qur/vhErzLNzlRch7fE
         J2SFNhfc+D+z1CjZOggzqatuJcG1HCLxmGTciMWzZop+7x29/uKfEij8/L+i80ujkT6K
         ZLHQRivU6CrE+mWFTZK2aojjTjW94IaDof87/ohoUJ0IIeoPKxNayjnEvcfVoD1Yvtxp
         EyuOANU4P/KdtOKXTwzFybiEdk0GP9xsTJRhQZ++Pr0gZmGVpzOuBBJnO6DCI+IU18Na
         PFXz7MrF58Mvc12R7KJAp7aIxbYtt5UxNlF1NwgbNujoc1WqOUSZdchrVNtkdaV8g//D
         Gl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789493527; x=1790098327;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TllSv8C91B6/5oyiPgB3bIf4ptvSZ4N3RPUetFlm1DM=;
        b=ezAGT9by5VNQ6LAj3LaJ20hpXbYZ8XmF9pU49l0s7DF6SrMiexsotwD+tf1pxbuWE8
         3qkCr8uMRhg6JvrTaNJ6ijpjW3NQ4/F33M6aKCxSUPGzB5Sz5CU498o91IpXji/xhOVa
         0lVi8zq4+uEHEpTzRtaPWPt8McftURPpKJy2wTJ3lo5OrzXH09l6QjF18oEkzAXTmHw2
         gbIAtiVLRKCthoCpTBq3VniqFeC/aC7ds0NDH1fy+JDB+FGnCNHSZ0kO5VsJ0MT2sWUb
         2YhjVEAj5vCXnZwVH4Otq/o9ovFn44ZzyhygZabyrILEyjPPnKTltJLXTjtxE22bRYAi
         Lb/w==
X-Gm-Message-State: AFuF++lWoQtSJ+BoO3af4lE5sDVC/VjElkiPzrYMfxC+HL0/76HvdIZ+
	GOPv3Z1jfnoz9ZEN/nZ/ukyUBKU6CQzAEX84Y4pUzhb+Ep1IKeFTPwzB
X-Gm-Gg: AYBFou2OHpJwYmd1D7umYiR4Jsx1L5TN4vthjKYVDAE3vLJjfa5CZTTK4BTqRVBTOit
	qwvu4vtV8V5qVUQrdmErkXhyPUKjax+86GcB/ivafSmied10L+ZvAimub9H3yexOW5zEMw4xfkx
	opnN83r5rMbzhI8eb7WoD59wz71rIP6d9DMXKXSS4EoypUU1S1R7X2+KwnlDnpOuIgIp2qdmNPe
	56X6fa1XBLjW7//+PfhpvovU61qzLnNzAD8rfFuwGeb9qZ08foBo+j2x6LYlDYPCVOS59j9aJut
	ijVtDYvmhGEfAyT9s1CrfpqSTFf2bpjp+gwXBedGlMiT+6Rt4iBaG7ra6+RZ5QQPnKA7b5a3f3u
	CqKaJ+hfGaFZu338kArntvKrUqoNJjujNfC7KPS+lbDkxG/HxULrhktgvitPv2OwLV3zn/86GE0
	mljzwV+QpYR7Vpcg+wknzQwDGRZeavPR0bpfyoZLF6TN1U/9s9a0c+0w==
X-Received: by 2002:a05:6a00:4fcc:b0:871:9e1b:8a75 with SMTP id d2e1a72fcca58-8719e1b8ef7mr2506620b3a.20.1789493526504;
        Tue, 15 Sep 2026 10:32:06 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29bbdca0sm6609486b3a.45.2026.09.15.10.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 10:32:06 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	=?UTF-8?q?St=C3=A9phane=20Grosjean?= <s.grosjean@peak-system.fr>,
	Kees Cook <kees@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] can: peak_pci: fix PCIeC cleanup on probe failure
Date: Wed, 16 Sep 2026 01:31:57 +0800
Message-ID: <20260915173157.2510375-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

peak_pci_probe() initializes the PCIeC resources before registering the
SJA1000 network device.

On the probe error path, the registered channels are freed with
free_sja1000dev() before peak_pciec_remove() is called. Since chan is
part of the netdev private data, accessing chan->pciec_card after
free_sja1000dev() results in a use-after-free.

There is also a similar cleanup issue when peak_pciec_probe() succeeds
for the first channel but register_sja1000dev() subsequently fails. In
that case, the netdev is freed without releasing the PCIeC resources.

Clean up the PCIeC resources before freeing the first channel, matching
the ordering used by peak_pci_remove(), and also release them when
registration of the first channel fails.

This issue was found by manual code inspection.

Fixes: e6d9c80b7ca1 ("can: peak_pci: add support of some new PEAK-System PCI cards")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/net/can/sja1000/peak_pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
index 69c61ccf621d..28b94e642170 100644
--- a/drivers/net/can/sja1000/peak_pci.c
+++ b/drivers/net/can/sja1000/peak_pci.c
@@ -697,6 +697,8 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	return 0;
 
 failure_free_dev:
+if (!chan->prev_dev && chan->pciec_card)
+	peak_pciec_remove(chan->pciec_card);
 	pci_set_drvdata(pdev, chan->prev_dev);
 	free_sja1000dev(dev);
 
@@ -704,20 +706,18 @@ static int peak_pci_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* Disable interrupts */
 	writew(0x0, cfg_base + PITA_ICR + 2);
 
-	chan = NULL;
 	for (dev = pci_get_drvdata(pdev); dev; dev = prev_dev) {
 		priv = netdev_priv(dev);
 		chan = priv->priv;
 		prev_dev = chan->prev_dev;
 
+		/* do that only for first channel */
+		if (!prev_dev && chan->pciec_card)
+			peak_pciec_remove(chan->pciec_card);
 		unregister_sja1000dev(dev);
 		free_sja1000dev(dev);
 	}
 
-	/* free any PCIeC resources too */
-	if (chan && chan->pciec_card)
-		peak_pciec_remove(chan->pciec_card);
-
 	pci_iounmap(pdev, reg_base);
 
 failure_unmap_cfg_base:
-- 
2.43.0

