Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628419;
	b=RrGq5hdhPTkManu0obUMTut4V0rpffz9GD1qD1syhvaaNc4mDSCszFb68bJJggeHJoT0
	 e77rMn6a1fsHJJ6x495wPqoJbqBNL61KnbjpdZ1nRo2+Cn/mMgSoF3q4KgKNH32GUlwJH
	 rylX85pbgI1ruDSSMJVn/SDYfDwwOJzb3igTYrCzjqSPemfBjZHKalxTnWbfoLptRbPcD
	 /ZEwnG/IzLUJ1Q/8LEkkqw/OntqS6d1gg/JU9N9xHOjz8xGljGCH6zQuIfWsKHdgOSDhi
	 4EpAQrUlKfXfVJmWmb1IW/i2E7P8jUfHiFlXhp5aJQuy0Zj8MozMoGTanZtZEpY0dzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628419;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DxJKwewUgUZqtLuS8HhNBwrR+jQCjU8WzIK/0udhZ9g=;
	b=R5guBxgj+Y2mRBznxqZWmz9BNSoIOgzYiYDPgdItObiciVpvaC019Yb+S5jzYItV3oGX
	 P7/7Q2J0eMMAJtQbMU3wC75YqFozrJ1d1l/3mZUCsbUSJhPX/hWWzlNO/0ynX09N2v6wE
	 QhwsBOgrONSG/GmXhuh8gAQnkeVT+I4J2TZK8fWSc+Ef7yN3eNb/4wkPsRt5ZQtOFxqJp
	 wGlqlMikEYN2YG8eIJqV1NUFuokIs9h3Kw3Fzbnb7JB9EB+1gFXEpDDXaCLpgTCi3kWEY
	 e/5AEcr2+mN8XWB8wPT1DyMxRknQHuhVnytbamNMVfTetYQ0VQml2R3nkbg8YStkpjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y33D115y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08814606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y33D115y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB90C1F000EE;
	Wed, 25 Nov 2026 17:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628418;
	bh=DxJKwewUgUZqtLuS8HhNBwrR+jQCjU8WzIK/0udhZ9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y33D115ytb0cqrwlnsv7+b6h/PHQxoZZo+/ZNwr4H9QRRIzbJJSpT93EifjV4PIat
	 AYjw5yNeSWj27Oju67d8+obSPVqRMRU2jIUfdiaH1dZ2h12AEZ7e6tuF0hw0ApBKdG
	 4amSAAgp3x4Zf40TG9IA2TIfQmIScd3w7uBWat2a6yN6pCrQrJoT3k1C02gEJ8aevJ
	 AbKnvLboMiI/ulpbNPB4xdWq3FYvVp2+MzSX38xtSJOHzzMvx8dhW+elDYl2xJAzmL
	 YKIcgPBgKmTkOmyoO0JhLpgKpexTVo5Cau8rtvrGhoPrA5pyQDL+AErICB9ZnbD5Np
	 5jkSXL3j8AJBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anton Lundin <glance@ac2.se>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] hwmon: (nct6775) Handle dual use registers
Date: Wed, 25 Nov 2026 12:40:16 -0500
Message-ID: <20261125174008.1011773-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112508-scared-alright-f2b2@gregkh>
References: <2026112508-scared-alright-f2b2@gregkh>
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

