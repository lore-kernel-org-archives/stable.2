Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629351;
	b=EvfrSxrVrBpqwAyhWmoU0una909zpYTsvqgA2AenbvquT3j64j2seU7qnqxx583/wR1r
	 uyorRF1GKBzvOH+WE7kHWPW2popb4lC2k7Nzz4NMCgk4UjaUrXRwz+Xn8AVtJBPX4/awG
	 1LiIn7b1EtTHOBo6Occ2JIxpjyA7ak7NF18Dg78gnAyGIWgjRFHw9jQ9NeSa2JhdZQmz+
	 8isPXGZO08TDs14gBch9ZtMekKnoKNTSxJxRUMT9jiikAK2lvzq1usYGKwg1XATFuP6gu
	 yUOzkxYzvUvyH9JEeryuJ7gCeP7G9tyUngHseTdJ63GDN/UJvuyNJ/gi/Yhjneafs6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629351;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zuVlMyIqSCxAjqkG8O42qMU5kYyuUgjDTre+OCS84UQ=;
	b=1kB3ktRiZW1bhp+xtMipIJm/dbNqee9JXXiigfI/q/Q/71qKZFO9yc3Yhe5YSmgmrprh
	 lFmhczG8cg8myA1JHckDbnp4WA6N6PWZrs/GUrfMHxufY6tSt3SUcQ7FH5nYp5LD+kwWf
	 Vl7bqwh69+AFGWHaix3ok4u7abTG7ZTowPKszBRGWrdstZ8aLIv5QUrMjZSNWk0CtSkcL
	 5CaWxuaeaDkKLmMqbBzsBZoGYZZDRLae0cRXwG0Rpck/KWax8bzX2g3Thygv19soirahg
	 gIRJCCZyvrqoYeGtRwzF/0VDUdMKKGEGdevQa6pwl4swVX1G8IShKk//qS43JMuvFKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nu1P+5wB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E57606A33B
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nu1P+5wB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DA61F000F2;
	Wed, 25 Nov 2026 17:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629351;
	bh=zuVlMyIqSCxAjqkG8O42qMU5kYyuUgjDTre+OCS84UQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nu1P+5wBDypvaBmsmCSquDbaId5t+WX2JH5HbphkibhO/+mSbkg1PDy/I5lwbS/4v
	 FnF2FedVHZptp6JiKTEnok1CSlg734+87kxUUsIPdaKrx/lEplETxA3HmJM418t7bw
	 Du6C5QCgSo1XP4/4srwIZTIth3UkFqwlhFdBi7GxX3RrEMhAiDunkwx+z3yKN5+g2J
	 ZCxW0efn0q4qbVlqpnax7gNfIthrvQcaCkywRjVqtH1suE2Ra7r9mUd2q0cYeekD5K
	 Jspa9RLbyVb2QBQevpE0J6RVqK7V8eMim4GZqkCTNePVO9DYN8mWPtjDFPKcepIs2O
	 87v5rLgME3Olw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anton Lundin <glance@ac2.se>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] hwmon: (nct6775) Handle dual use registers
Date: Wed, 25 Nov 2026 12:55:47 -0500
Message-ID: <20261125175529.1065808-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125175529.1065808-1-sashal@kernel.org>
References: <2026112509-afraid-taste-e69d@gregkh>
 <20261125175529.1065808-1-sashal@kernel.org>
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
[ sashal: Kept this tree's existing context (no 0x59 entries, no nct6126 case) and removed only the REG_TARGET addresses from the nct6106 and nct6116 word-sized lists. ]
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

