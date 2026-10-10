Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF43D6CA5;
	Sat, 10 Oct 2026 23:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791674187; cv=none; b=DRRitsQdQcUskkJZrv9CbxVokT58KZ4WcrAaoQvemaTtHwPR66b7vcNyZJSqaQGbXlLC9yDYApxou0mvIH9DBDlOrr8FH/w6TDH2KTz3CrmVSONxoP0ZfR+9m6/bQucB9unF0i5J/pF0KtCOoqLdTiBqWePnYnEUO+pV5tHFbXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791674187; c=relaxed/simple;
	bh=KGnh8Aqg7Eove+gg5d5FZnYhLMjzjKxYzHrEG64EsSc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dUAaP/pDCgYfug28RE0J/eA4hyVLRAReCfxLPDF18Ii4INwksf06M8XGKc06hbTj00jQ/0ORe3ZuzYbZUkNmpQniK/4M+J0z3eMC/y+a8sAD2cIkPm0ezCpxrqRyxHF//8c3pRw+A8gejadZ+JwZWl+K4Txooq9wHpnTgZ3wrw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u9Xi148G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u9Xi148G"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BB7D2C2BCF7;
	Sat, 10 Oct 2026 23:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791674186;
	bh=KGnh8Aqg7Eove+gg5d5FZnYhLMjzjKxYzHrEG64EsSc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=u9Xi148GY5Gq0LyOwE61xBHOvDUOMtAXl2ZxeBK3D0/KG0tIWZrMF2UbvbknRPCFP
	 pvPffmi0Yomx5FTPSINISJqw9bYd+l6Db4Oldh/4jGEBzm/2B+VfUez9C1EiDQDVqg
	 t82hLwwc4Vf64VgUdZ3IGa9o0ATPLXQY5i5RNK6BwXykVnF+JclMJFaUAMsHu6hW8y
	 uqh4/KckMaCG/v5Uw5IMMq/yOh3o/YNtZjgIk87dgtH7DiGLoxfmgvrvIiB424G8+v
	 iTv/52UXKaXqx9dP3q8tLAJ9JtIoQvP2/W+1EQTPuYIMVp4nN4Cbjp9BFM78VtSBZD
	 BRstDF0b9Ultw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83B9CA9EC5;
	Sat, 10 Oct 2026 23:16:26 +0000 (UTC)
From: Joe Finzel via B4 Relay <devnull+joe.sudmix.de@kernel.org>
Date: Sun, 11 Oct 2026 01:16:10 +0200
Subject: [PATCH] mei: me: do not bind the 700 series PCH-S xHCI controller
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-mei-xhci-v1-1-38c28b5f3f99@sudmix.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDA0ND3dzUTN2KjORMXQMjc3OjFANTA7NUYyWg8oKi1LTMCrBR0bG1tQA
 IRGYDWgAAAA==
X-Change-ID: 20261011-mei-xhci-02772d0506e3
To: Alexander Usyskin <alexander.usyskin@intel.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Joe Finzel <joe@sudmix.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791674185; l=2786;
 i=joe@sudmix.de; s=default; h=from:subject:message-id;
 bh=dHPRvinmj3gT398vg7KB5i9657nu0BvpUvNDZSpaljo=;
 b=Q1saQ00ra3W30vwtbtKVqcmZeHPBryR0R+4L9jmFjm7pJf4wDTp5vS30Crm6vwvpcJb4Tu4hc
 OSpVoNHJk1SApao/OySbAIcwUFn8T6I/pT96vSUiwvZBTWAnXQxHkpi
X-Developer-Key: i=joe@sudmix.de; a=ed25519;
 pk=vaX11uVm57me/1N8otNmzMMnsE+f0U3/Hi9TCPbnvZM=
X-Endpoint-Received: by B4 Relay for joe@sudmix.de/default with
 auth_id=1151
X-Original-From: Joe Finzel <joe@sudmix.de>
Reply-To: joe@sudmix.de

From: Joe Finzel <joe@sudmix.de>

PCI ID 8086:7a60 is listed as the "Alder Lake Point LP" HECI device, but
on the 700 series PCH-S (Raptor Lake-S) the same ID belongs to the USB 3.2
xHCI controller (class 0x0c0330). The HECI device there is 8086:7a68.

With CONFIG_INTEL_MEI_ME=y, drivers/misc is linked before drivers/usb, so
mei_me probes the xHCI controller before xhci_pci can claim it. The probe
writes the HECI host CSR into the xHCI MMIO space, waits out three
hw_start timeouts and gives up, blocking boot for about 5.5 s:

  mei mei1: H_RST is not set = 0x18000840
  mei mei1: wait hw ready failed
  mei mei1: hw_start failed ret = -62 fw status = 803401FD 00000000 00006032 00000000 00000000 00000000
  ...
  mei mei1: reset: reached maximal consecutive resets: disabling the device
  mei_me 0000:00:14.0: init hw failure.
  mei_me 0000:00:14.0: initialization failed.
  xhci_hcd 0000:00:14.0: xHCI Host Controller

When mei_me is a module, xhci_pci is usually bound first, which is why
this has gone unnoticed since the ID was added.

Match the entry on the communication controller class as well, so it can
never bind a device of another class.

Seen on an ASUS ROG STRIX Z790-F GAMING WIFI (BIOS 3201), i7-13700K.

Fixes: 930c922a987a ("mei: me: add adler lake point LP DID")
Cc: stable@vger.kernel.org
Signed-off-by: Joe Finzel <joe@sudmix.de>
---
Seen on an ASUS ROG STRIX Z790-F with CONFIG_INTEL_MEI_ME=y (the log in
the commit message is from that board). With mei_me built as a module,
xhci_pci binds first and the stall is gone, which hid the problem so far.
The patch is compile-tested on 7.2.9 and applies to char-misc-next; I
can test it on the board with mei_me built in if that helps.
---
 drivers/misc/mei/pci-me.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c
index 790a46478..26e89140f 100644
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -113,7 +113,10 @@ static const struct pci_device_id mei_me_pci_tbl[] = {
 	{ PCI_DEVICE_DATA(INTEL, MEI_EBG, MEI_ME_PCH15_SPS_CFG) },
 
 	{ PCI_DEVICE_DATA(INTEL, MEI_ADP_S, MEI_ME_PCH15_CFG) },
-	{ PCI_DEVICE_DATA(INTEL, MEI_ADP_LP, MEI_ME_PCH15_CFG) },
+	/* 8086:7a60 is also the xHCI controller of the 700 series PCH-S */
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_MEI_ADP_LP),
+	  .class = PCI_CLASS_COMMUNICATION_OTHER << 8, .class_mask = 0xffff00,
+	  .driver_data = (kernel_ulong_t)MEI_ME_PCH15_CFG },
 	{ PCI_DEVICE_DATA(INTEL, MEI_ADP_P, MEI_ME_PCH15_CFG) },
 	{ PCI_DEVICE_DATA(INTEL, MEI_ADP_N, MEI_ME_PCH15_CFG) },
 

---
base-commit: c26cc979e28f5193310e4379e14aa6417375c565
change-id: 20261011-mei-xhci-02772d0506e3

Best regards,
-- 
Joe Finzel <joe@sudmix.de>


