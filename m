Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.188.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795383541;
	b=EJ5+cBFf4RcG3dVZi3ou5IVZs04jtuqL5eKqyzT5Y5SSp05lsoYOEaXxQmf0/IT2uvxk
	 Ms90+pVghhVGiSMnBV0vL6gL359PkbUT3yXGvaA8Y0uCzMy+s+5v19EerS6iu+7Btw5bj
	 UlUp2jqRItRF53Twlsg9q6GoIna9cDcK6e3WcmYc9+Fnf+dnX4Qy0xX6CLOYp9pNlguuh
	 frHkWhhxjmljQjGe7vJUYCkAJCT7WT2tJy+iSMXP9LILYwCwWqL04vVpSmzNLjk/QXQzU
	 9nlhQNypz/5VID1Y7T95xpbG+8cqw6Rpxz+wjTR+8QvNCCKlNvxMjORnSOatoXQ9HeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795383541;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:MIME-Version:Content-Type:Content-Disposition:X-PGP-Key;
	bh=OLXjFAMNkzDhIfVt4uNt6wUXZBTcIFwPfmYtYuZfcKI=;
	b=uoRh6LsIkgyRJxc/W75lckuJBV5ELeeEuepLFARpdo3O8hdyJiI6dyOxmEFjCy0OVkg5
	 AS2dkto3Mnd800QDNbAtBEc2PRzbfT7cgWkb7hYzwjsNt1fu3fbmL2jQwaVrC6aLyEvTu
	 aatG6WUtywjlPIhtUiGVSrUD0fGYum2XnuhVDA0F/GMrt5GdNBQPt5UKKHzb/sdIwSC6g
	 nliH3Zt7p0dEoWaGq2axM65k5ENpGEVCIiR4eeSuXRMFUXEcSufj9o6L+BlahXoEcFWuV
	 ILhPKfMAQMfD3dXQHR9oIcKqgQzbqjwL6t5IBZrajC7pw+4TdFghOJ2SIV3lj/kqcXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kucharski.name;
	spf=pass smtp.mailfrom=kucharski.name;
	dkim=pass header.d=kucharski.name header.i=@kucharski.name header.a=rsa-sha256 header.s=20201103 header.b="o/JBLjKI";
	arc=none smtp.remote-ip=5.135.188.45
Received: from ks1.nodegroup.io (ks1.nodegroup.io [5.135.188.45])
	(using TLSv1.3 with cipher TLS_CHACHA20_POLY1305_SHA256 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB951606A31A;
	Sun, 22 Nov 2026 21:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB951606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kucharski.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kucharski.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kucharski.name header.i=@kucharski.name header.a=rsa-sha256 header.s=20201103 header.b=o/JBLjKI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=20201103;
	t=1795383530; x=1797975530; bh=OLXjFAMNkzDhIfVt4uNt6wUXZBTcIFwPfmYtYuZ
	fcKI=; h=x-pgp-key:mime-version:message-id:subject:cc:to:from:date;
	d=kucharski.name; b=o/JBLjKIk+/1KhXDS9bU/k2R3BVT1RKFmOohbOJ4eSG17ce6YV
	t+GfVkpAvL2o81+4PCOy40lSWBeGgGC5Zry7OQ1AyZQpyICAYFQv3JHxQ/mUmz70U9NIlX
	6gyLh1LxJIYKZMBvzoXvKbxWFIN43YvmIJhen9kM4J75x3QogvN1/R7TsiEJaFcmQ7joY8
	0WM7T6eFw6MtBC/949er/w9mBf5oHfYyr186i0pA5fKdER01FUJeEi0rtYIxdwpdKyn8vc
	Kx9KInB1MTC+rIzlv0vR5VS2MAE7VY0oxv2awBjImNQVvAkdnm8MNU7CIdd7uFbBfQcTVG
	DeutHxOtOQag==
Received: from localhost (public-gprs385916.centertel.pl [37.47.138.189])
	by ks1.nodegroup.io (OpenSMTPD) with ESMTPSA id 664adf19 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 22 Nov 2026 21:38:50 +0000 (UTC)
Date: Sun, 22 Nov 2026 21:38:46 +0000
From: Mikolaj Kucharski <mikolaj@kucharski.name>
To: Mark Brown <broonie@kernel.org>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>
Cc: stable@vger.kernel.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: Add DMI quirk for Xiaomi REDMI Book 14 2025
 (AMD)
Message-ID: <awNg5lUNAYmZ2tOx@gdkpeagp.my.home.arpa>
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
Content-Disposition: inline
X-PGP-Key: id="0x10C7B55D"; fp="42E5 F0B0 D47B 17AA 16A3  1508 506C 97BD 10C7
 B55D"; src=<https://www.kucharski.name/pub/gpg.asc>;

The internal digital microphones on the Xiaomi REDMI Book 14 2025 (AMD),
board TM2422, are not detected because the BIOS exposes neither the
_WOV method nor the AcpDmicConnected property. The ACP6x PCI driver
creates the acp_yc_mach platform device, but acp6x_probe() returns
-ENODEV, so no capture card is registered.

Add a DMI quirk entry for this board, in the same way as for the
related TM2423 board.

DMI information:
  sys_vendor:   XIAOMI
  product_name: REDMI Book 14 2025(AMD)
  board_vendor: XIAOMI
  board_name:   TM2422
  bios_version: RMARB4B1P0606

The ACP is PCI 1022:15e2 rev 0x60, subsystem 1d72:2422.

Diagnosis and patch were prepared with the help of an AI coding
assistant (Claude Code); the change was reviewed and tested by the
submitter.

Signed-off-by: Mikolaj Kucharski <mikolaj@kucharski.name>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index f636b5b..766d493 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -955,6 +955,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "TM2423"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "XIAOMI"),
+			DMI_MATCH(DMI_BOARD_NAME, "TM2422"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.47.3

-- 
Regards,
 Mikolaj
