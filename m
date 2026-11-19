Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795085417;
	b=JetRzYaBrpETi3vYgpMN1MWr5po6oFB4xhvJSU4rnvZiqvKOuH6GUVrSxpMHZbDRg6Wl
	 Q9mLInzFNJCzSPgFkDzDDjSWS6j0kIrr2w5ZXF8M3TkWfJtoS8ypA1K03j3AlT81xqvOw
	 NLPoZDnRaNp4dSmy4Gr4UGvqF6Vkk3ndZH7B56nF0S8jCIZnvGyMVgVN1Q/UpqSWX7azc
	 aO0VzcnTchr6gNWeTDk7P9XgHF5nH6i7D1Ghi9TUuRX94OmhbgI7WN72ag5qSF2hE7ljS
	 D2EGcIx6sCL0XWFh12Utqxe1AJ2CKEGX1/QXfNzAe+EBzmvjIMT8qTbt+QxYtYTTv4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795085417;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/R2gBmUJNOHulxN5FyC8S+OCRx4mvbTbvxpNTATZDD8=;
	b=M1gWkUyrAAm9NkGI21cwhmFh6HfRB0MSxd0p1aCBNIOcTlLBkdVWVmXGEGUAH6c5yHcw
	 7sAC5Sio7axmJa30jQhZC/yUBndoq7mWLZ2DYdj5JilvfQha648hTfiS8SZmQ8yU3fJZW
	 Rr8DyUZDVrT/CL1BAkzovmCHvgFpdOaKPCgxCKkV88si6XqUQcrRQcD3fsoPC7mylzFaP
	 J8aVaNxlPIhC0wWhKzAcYA/Ve5ZgkMMGK9WYxEKrlhwhywgRAh5VvvwblsWDpLtgMuJRI
	 fZ/Ine5aL4GmO3b4YQXWhiD6sN85SfWzDvuHIJ8pFZwNp6h/v9w2j6GuD0RgfSJpKaA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXkGkiWN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE57606A320;
	Thu, 19 Nov 2026 10:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oXkGkiWN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795085416;
	b=Xg5Cf4wl+B+BXpoGiony+rE8aTag3oLCvLOi/fT2Ndbz82DBKAC8/6sIJmq+Q4ZxDt1z
	 22/6op75jI6vjAzsfU7AS8NFUtS5U910MxMpKV46NrheLEHKCrGHGMpYwKv0CnTeftYdF
	 2fLJKfZFku7k1Si7H33/SrrEsffLWPPdM3ThM7UHgE+9JGOxd2lynAgNw307DXFC1h7n7
	 IVoKKv0armyuzpCm3aFzb+RJ0OBjDBU/c79aZMiWY8DkqJO43x/UcLspdiKhFUwu9GGz6
	 JiS+DCT0G1/sgaElAMD50z4M7fvx45GS1E4SiRUukiqHyaHB4cEf9MRMUX9B+iN5yHg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795085416;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/R2gBmUJNOHulxN5FyC8S+OCRx4mvbTbvxpNTATZDD8=;
	b=Dz4M5mcvD/O+oX0/RR8VXKlb6hEsj6V/ess5whtRpg1YpC5sFD1qO2wGqPRyhSxfjSRu
	 Udg7wexK4Vv+iAuzQAxDUCDPr9/yGUYvxEizWM5t1TZ5SFCZUaTDicUDVhBR/TX1Jasbl
	 BHJypVLLyQPE/RAVjYp41SzJVEMgqCZ7WkyX1KOLqXaSIg/2eE3dUatQ9KrPhdhs3A4Oz
	 uPoyyoGtiboCrRiD1PUGEQDau04B0UZg4g7e+9QT1vdzD8xRn9S6CfiPcRdzpCFTOQ+5W
	 pehIuTpfWAZ0BYO/2eXJA3cFbfvXqjyEXHYc72EMmNCX1BmF3QsVgFuiemSjHUgo2mw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 68BD31F000CA;
	Thu, 19 Nov 2026 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795085416;
	bh=/R2gBmUJNOHulxN5FyC8S+OCRx4mvbTbvxpNTATZDD8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=oXkGkiWN9fww46X6ujRGrxl4BbnMghUxh4j54SrCuWRg0eXnr7TeRnf98gJvGTmDg
	 1j4JRHYBBneCGD5Jt6jXPdGcFFafUXdEZ58gCPEGBBfcR5DsDuODRLwNT3CQ5+r+k2
	 CYfLn4xp5r+spzmqtC3YKfrIiVDRjY3EOdihf0LvFPOBUoe7HkDekdQmC9eJEZ9z71
	 nmEbOdnNo0VOfxuaeTctR3XAvqhYu+d2JUwCqxUoTNV8sAclBI8MyK++kSeaT3Ksuk
	 H8R94R7Yi/BXEOjNQICB7ojeD2uK8cbG/oiBODKQyNwLBwp2v/WEyfKTdzV0SYGmSo
	 SRvcfa6jA8Ryg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BCDF74B24E;
	Thu, 19 Nov 2026 10:50:15 +0000 (UTC)
From: Blake Alexander via B4 Relay <devnull+blake.alexander.airbus.com@kernel.org>
Date: Thu, 19 Nov 2026 11:50:00 +0100
Subject: [PATCH net] net: dsa: mv88e6xxx: do not override PHYIDs on
 external MDIO
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
Message-Id: <20261119-mv88e6xxx-fix-v1-1-2db604f3516f@airbus.com>
X-B4-Tracking: v=1; b=H4sIAFfU/moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQ0MD3dwyC4tUs4qKCt20TCA2skw1NzI0sbA0T1UC6ikoSgUKg82LjoX
 wi0uTslKTS0CGKNXWAgC4JhAocQAAAA==
X-Change-ID: 20261110-mv88e6xxx-fix-f29e7214897e
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vivien Didelot <vivien.didelot@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Blake Alexander <blake.alexander@airbus.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795085413; l=2771;
 i=blake.alexander@airbus.com; s=20261109; h=from:subject:message-id;
 bh=DEvRstpM6J0VNGLN6y0A8zWK7GLAM0NdyvBdHfH9s/U=;
 b=OfmZz6PPSSGr42KEyWN02aE+/S0tChV3uv/5keBZmbwX94dTMLQ3JST8THEblY1iUhcjGJTor
 PcoeOc1NVP9CU9KhwH9V2k2jdVF2C4+8B3cJI0a1dYM6k4gwFWPfUAX
X-Developer-Key: i=blake.alexander@airbus.com; a=ed25519;
 pk=cfpa2FQbYHF1zxIJuHbr8W+NR9T4DK/baAknnTv2I68=
X-Endpoint-Received: by B4 Relay for blake.alexander@airbus.com/20261109
 with auth_id=1461
X-Original-From: Blake Alexander <blake.alexander@airbus.com>
Reply-To: blake.alexander@airbus.com
Content-Transfer-Encoding: 7bit

From: Blake Alexander <blake.alexander@airbus.com>

Some variants of the Marvell 88E6xxx family (such as MV88E6390) support
an external MDIO bus (in addition to the internal MDIO bus for
configuring internal PHYs). A typical use-case for the external bus is
to configure PHYs that are external to the switch. On switches that do
not assign a PHYID for internal PHYs (i.e. the value is 0), the
mv88e6xxx_mdio_read() function traps read calls to the PHYID registers
and sets the PHYID equal to the family ID of the switch.

The mv88e6xxx_mdio_read() function is reused for both internal and mdio
bus operations. The PHYID overwrite trap does not check whether the MDIO
bus is internal or external and wrongly modifies the PHYID of devices on
the external bus when their PHYID2 register reports a value of 0. When a
C22 device reports a PHYID of 0, get_phy_device() will reprobe the
device as C45 and if successful create a C45 device. Overriding the
PHYID in this case will prevent a C45 device (such as Aquantia AQR115)
from being reprobed and their driver will fail to bind.

This was observed on a development board during the bring-up phase. The
board included an MV88E6393X with external AQR115 PHYs. The MDIO bus of
the PHYs was connected to the external MDIO bus of the Marvell switch.
Prior to applying this patch, the aquantia driver failed to detect the
AQR115 and instead detected a generic C22 device (as a PHYID of
0x00000393 does not match a known PHY). After applying this fix, the
external AQR115s were detected correctly and their respective driver
bound to them successfully.

Do not modify the returned PHYID in mv88e6xxx_mdio_read() when reading
from a device on the external MDIO bus.

Fixes: da9f33018e2c ("net: dsa: mv88e6xxx: Workaround missing PHY ID on mv88e6390")
Cc: stable@vger.kernel.org
Signed-off-by: Blake Alexander <blake.alexander@airbus.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 46aef6dfe77e..bf077e476fd1 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3779,7 +3779,7 @@ static int mv88e6xxx_mdio_read(struct mii_bus *bus, int phy, int reg)
 	mv88e6xxx_reg_unlock(chip);
 
 	/* Some internal PHYs don't have a model number. */
-	if (reg == MII_PHYSID2 && !(val & 0x3f0) &&
+	if (!mdio_bus->external && reg == MII_PHYSID2 && !(val & 0x3f0) &&
 	    chip->info->family < ARRAY_SIZE(family_prod_id_table)) {
 		prod_id = family_prod_id_table[chip->info->family];
 		if (prod_id)

---
base-commit: af6f95c3300e3d234c813b80f831dd7b80b3eaf2
change-id: 20261110-mv88e6xxx-fix-f29e7214897e

Best regards,
--  
Blake Alexander <blake.alexander@airbus.com>


