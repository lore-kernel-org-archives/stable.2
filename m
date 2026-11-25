Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628907;
	b=iHAWLKVRND5UU0uSdynw0Cf/0IUw3RnSBKSESB74DJhiYpaiVIf/0yoz1l5z0ZeFZ8nF
	 WOQo1bI7uw5AX4x6BM5WwwSwlKYrKt4/5B0wnfk4S84qMIeK+20fO8VdKmRs0MA3uSf7M
	 s/U9SfgVm8Gt8u3gbhwrJqUG9gcAbRK0xT1ZqsHqjrcFzaXPAAFmTF9tkI7KCMnRvFMLr
	 4EJ+F8jIbp4nGFEwdzqH4gHgf9xHA+TXCPIB3Qg3Htx2R0ijrGcm9FHOyT4fDzcl2BihB
	 RWeG0+fhAMqDmuu+i3HYHHtKMIrKsWiONs58nfsRdL+V5wRvYqxtDit3uwQieycfupg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628907;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3Bb6wdHJJb1Ix/kHrQqbhsZvGNyBen1Xb6dnGQ/H4R0=;
	b=c9c1VmL5DTLgTEBJSPvzZGlK5TSCysIRMd6UMNuZKSxCKsNqXIEAwjXIziMq6kO9BNqp
	 c9mKrf4psckWPrR1zSqUyr9XV1FvIFgqffrE2n8REpwIZ4fwiM6JalKWomaGn0ryLcmOG
	 mLYd1595K93rn3Ky1OsHwID2lNeTHy5zmth3dCoWgFtWBovD56twfS265rG241RgRqhnc
	 56/NarvAWMAlB7ve+RfTnUqcfSbjQGSH+TOMTdODHyIxLUbYB3HMb6Z/6uofx0nppU1fw
	 lj0wl+itbDVhSkMCywPX3tfPpwfMw2/6kBHWHDiD4QETBQyzO/AgwHE/URlcTFc5JsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBS5iK0U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A74F606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBS5iK0U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE411F000E6;
	Wed, 25 Nov 2026 17:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628906;
	bh=3Bb6wdHJJb1Ix/kHrQqbhsZvGNyBen1Xb6dnGQ/H4R0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UBS5iK0U7MX/l0C+cLpFgD6ckxhAil1a5gGB/Iehwb2ihFeuk8SsgHXCwLEu9RZ+M
	 +KJF4/1S9mvf4PZoHRe4j73c99YUAdY4Yb8TiSUGyJBImzJzLobfGDkTuFn5UAbrRW
	 V4PfeZ3qArAiHlJJ960uQEqR2lWR8QTbpYWhLI29i4Fc9E9FMUUMWOraY+Rg0QslMX
	 b4JumIT92JXdTS50gDMUYiu4b3elZU19R3ICI9HmeVd76lCqysfqXZAAoFSQOiw32H
	 BDHLuMEaKDKD3ElyXc3GFA1diAP9yluFpd94qh3PXbIzykkf4z/VMcLv9m53JFHRJi
	 cTmqy/QJO70Mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anton Lundin <glance@ac2.se>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] hwmon: (nct6775) Handle dual use registers
Date: Wed, 25 Nov 2026 12:48:24 -0500
Message-ID: <20261125174818.1046387-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112509-boned-unholy-4e29@gregkh>
References: <2026112509-boned-unholy-4e29@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anton Lundin <glance@ac2.se>

[ Upstream commit ca1abdd1a9b9ce51713a18c8905bf10579533c3b ]

The REG_TARGET register has different meaning, depending on if pwm is in
thermal_cruise or speed_cruise.

This means we can't assume it's always word sized, so we need to handle
it differently depending on which mode we're in.

The code already does this, but the register was configured as word
sized for the speed_cruise mode, which would do the wrong thing in
thermal_cruise mode.

Fixes: 6c009501ff20 ("hwmon: (nct6775) Add support for NCT6102D/6106D")
Fixes: 29c7cb485b32 ("hwmon: (nct6775) Integrate new model nct6116")
Fixes: 437b3c2a4bdc ("hwmon: (nct6775) Add support for NCT6126D")
Cc: stable@vger.kernel.org
Signed-off-by: Anton Lundin <glance@ac2.se>
Link: https://patch.msgid.link/20261109082511.851377-2-glance@ac2.se
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/nct6775-core.c b/drivers/hwmon/nct6775-core.c
index 7e8e265cc6c18..548837c4113a4 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -1151,14 +1151,12 @@ bool nct6775_reg_is_word_sized(struct nct6775_data *data, u16 reg)
 	case nct6106:
 		return reg == 0x20 || reg == 0x22 || reg == 0x24 ||
 		  (reg >= 0x59 && reg < 0x69 && (reg & 1)) ||
-		  reg == 0xe0 || reg == 0xe2 || reg == 0xe4 ||
-		  reg == 0x111 || reg == 0x121 || reg == 0x131;
+		  reg == 0xe0 || reg == 0xe2 || reg == 0xe4;
 	case nct6116:
 		return reg == 0x20 || reg == 0x22 || reg == 0x24 ||
 		  reg == 0x26 || reg == 0x28 || reg == 0x59 || reg == 0x5b ||
 		  reg == 0xe0 || reg == 0xe2 || reg == 0xe4 || reg == 0xe6 ||
-		  reg == 0xe8 || reg == 0x111 || reg == 0x121 || reg == 0x131 ||
-		  reg == 0x191 || reg == 0x1a1;
+		  reg == 0xe8;
 	case nct6775:
 		return (((reg & 0xff00) == 0x100 ||
 		    (reg & 0xff00) == 0x200) &&
-- 
2.53.0

