Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628574;
	b=MhNYwxRxsT4QKtCSHAVmg11yggYCO+jNLoi7PZL41gTbEcPDuZk3hkwGnzk7O+L3EGaQ
	 sLJuurDNMsnn3t3HYIwTB3KsBtwJq/brDQCgA1KU1XWMvTFakutdD3rcygNtwoQLJ6fyZ
	 6hiy/F+Lz01Euwu5lbnI1IE0qlxu55u0QyjPJNlw5rr46vNznVgSi2XLkJfjQbxi9zcGM
	 IA0cExi/SAcIoWqac1iUnuDsNeYlJLaCrrGaKyTPI9RJ8m901MU17cEdQeHbDgLCLyIEC
	 DchAlfl0HgaFVxrgS1sUKu1KwU2imxVkKdD+KSmCqOHPzvWjHPtA/2B5YF/aFuEjvzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628574;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DxJKwewUgUZqtLuS8HhNBwrR+jQCjU8WzIK/0udhZ9g=;
	b=mtOGBkybgJk99JjR0AssItq7KzoRBq8hbwOn+Q11zWbJmDlxhXao/QrgXDtOYwW4fHjB
	 U/upi3PCq1PjQlJ7o3e0f2dnGSj8d8GSERYHWS8qQxdFBTaqBD/NPkE1f5U883AUgpQgZ
	 3WeQqi9hYlUdr8J0paLAjD8iSoil216OxWRgpGfNL/XnTiXChcWb7QbVJJPhtnJJTblU6
	 vfkvDJ040hUpRM/Ab/2u+lFqcpvcaAKLc8mFXjGAw68yknGzsJZFSOdEBndwif6kMeGiJ
	 MxBqVozwTD2LbS67VM7h+q1ldtbgMCOBCA2NTE4ivrNLjzozi+JhM9SEi1ZsowXd6nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6CmCovM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97396606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g6CmCovM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DF71F000C4;
	Wed, 25 Nov 2026 17:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628574;
	bh=DxJKwewUgUZqtLuS8HhNBwrR+jQCjU8WzIK/0udhZ9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g6CmCovMjroxi9go6RVsZFKOgLG08vU3sFWsk2gQZB26ZXfs37CezGlA3+1XsKeMI
	 d2U/f0kIVVoduw0jexUO6wL7+lolLPs/QJQzvwRPQhgjDE6/BBewXBVcdpeSSEh8Ge
	 7edSwnNcPLdb0oVokB7kCmD57EBdly32dco5uOQF/9Osh3bRvUspBXFMNuD2grqx40
	 Kb10bk8rgnRipYnhUV/gQHXb2ohSj0m371RNCZnEfsc6sKn49M9FTT2gwETEB0sKix
	 OlqA38cl0DG1dVpAEjjZagrc0CBjEUNJTReKNfqfLdOaoh2/XMK0ez/h4SVgQj9eeI
	 lEdQY0Nvza22g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anton Lundin <glance@ac2.se>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] hwmon: (nct6775) Handle dual use registers
Date: Wed, 25 Nov 2026 12:42:52 -0500
Message-ID: <20261125174245.1026755-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112508-tidbit-squad-4a07@gregkh>
References: <2026112508-tidbit-squad-4a07@gregkh>
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
index ce2cf1f229004..ed17b00433109 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -1152,14 +1152,12 @@ bool nct6775_reg_is_word_sized(struct nct6775_data *data, u16 reg)
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

