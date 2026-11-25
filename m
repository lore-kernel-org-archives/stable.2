Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629642;
	b=pA3gn5GKeNOK0f2lGxMSGYVfH6BFl4kwzM5J6yVlNn38iwc+1ADXOzbvkREVS/PSZlpI
	 pfDk5/7Hhh+RqOybn9SIlMVuNK10jaoocbY1g9Nsy3Kk4M/mZhXxp+iE7s/wRozC1daCY
	 XK/iXY6eufebW2Jdlc/pCcCKViTTY7k+RncetSVKDMOV66cU4ccLVdTY8XFCIPJXcB3KP
	 RakcBeCPxQcxsLwelbppbZyq89kbHaEHJp9R4XDy2wxeMtZrsP5IbsPkuLnlhDn777a18
	 6ZvfQOKVhKqVqFXPmxC9UkKc3wnpiqFFk8rsV/FNjDwxMhLXPiHbtEIJf1AnF+17Sew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629642;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GaezaTiuWWeulaTeOMxl/m6StldlIMRzDS5rNZVUf80=;
	b=OKH9jEtH3SrXWN8xLaWs/ZrSJMJK42MuKTL/u3o/yId+Esi7xqxYvDrmSc4vUKg3nNW+
	 8myBi3d9xGQ2t5dklGoPR5q7w2mCIbNzgpPOpxXBzvTKbzGUS6FgYiay+2cC5EXw+tRo3
	 juwxN3BjKhr501VpQ2m08ikA3ORqv3KMlSLvNfTUVWDV/JYn9dRPjlkJmkJvBcUxj7KT9
	 Dzn/g8vygTjquPR6jYY09MEs+FdpVXUbLBZiv5C6FiGurIa37gtoEunvv/6c0KeJRfIWr
	 IFJrJVOFvtkoD11uZPiLqh0qQWJskQTKKmYTkL4FgLO+QF9c7/rHAUqMg6Izl/9CNng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iCPODquI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B7E606A69F
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iCPODquI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C7F1F000C6;
	Wed, 25 Nov 2026 18:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629642;
	bh=GaezaTiuWWeulaTeOMxl/m6StldlIMRzDS5rNZVUf80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iCPODquIJQz24uL9om3xRaoXtglR/l1EHzmDIrGkhr6yq6Tc78FwE3Gcmc8HOGY8Z
	 104S5Ks9Hc6xcW7Xt3bxljXZWMprEkdyh1E8fV2fX1ZpTwKReaqyv7bD3xddF9qcFY
	 bGqXfxL6r2q24D70lIiXCfbFVImNCEVVhsM/vrSeX/sGVykl63y2kH1VxFFMShcogS
	 DscuCHm7Xo8r6n6AZYvclo9EpuVbu2ZZXJNtZTQY032rxWD44Zhlc8+5ki694itmu6
	 d6w831ew0/lwAfWDzB+ujWnqepWlMkdUPD5RqMxTCcZFjSGLWTZoidGLgkKg1jYnHQ
	 4vZG663LLRGoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anton Lundin <glance@ac2.se>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] hwmon: (nct6775) Handle dual use registers
Date: Wed, 25 Nov 2026 13:00:38 -0500
Message-ID: <20261125180018.1111857-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125180018.1111857-1-sashal@kernel.org>
References: <2026112510-freezable-rebalance-5328@gregkh>
 <20261125180018.1111857-1-sashal@kernel.org>
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
[ sashal: Adapted to the older single-file driver: edited is_word_sized() in nct6775.c instead of nct6775_reg_is_word_sized() in nct6775-core.c, with the nct6106/nct6116 register lists laid out differently. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 35a296768fde3..8ccf4fd15b091 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -1362,13 +1362,11 @@ static bool is_word_sized(struct nct6775_data *data, u16 reg)
 	switch (data->kind) {
 	case nct6106:
 		return reg == 0x20 || reg == 0x22 || reg == 0x24 ||
-		  reg == 0xe0 || reg == 0xe2 || reg == 0xe4 ||
-		  reg == 0x111 || reg == 0x121 || reg == 0x131;
+		  reg == 0xe0 || reg == 0xe2 || reg == 0xe4;
 	case nct6116:
 		return reg == 0x20 || reg == 0x22 || reg == 0x24 ||
 		  reg == 0x26 || reg == 0x28 || reg == 0xe0 || reg == 0xe2 ||
-		  reg == 0xe4 || reg == 0xe6 || reg == 0xe8 || reg == 0x111 ||
-		  reg == 0x121 || reg == 0x131 || reg == 0x191 || reg == 0x1a1;
+		  reg == 0xe4 || reg == 0xe6 || reg == 0xe8;
 	case nct6775:
 		return (((reg & 0xff00) == 0x100 ||
 		    (reg & 0xff00) == 0x200) &&
-- 
2.53.0

