Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816567;
	b=wUwbIGwDxBngK330F/HjnjsSKIbBCd/1lKXbj/HKpxcbwNsGdbznyryQ7MaQT8AQq+Fb
	 OuIGaL3oAUia8lvbIS4uPRizO7oSPzaoWCWqeNC7I55eQ7bSSmPcU4tL37qpQJu/pY/Jt
	 qfAFhiqc/xcWG4LgJ81YFD8SYaiSn7h4N9UHOapqKAMp7F3Dl6QXaKQdrB1Mo7/B5JQ4V
	 cXvn12qdQ1cAI797KRrGRVnN33XoDsPVFcQv0Wf143unpQXttBlXMgxmYc9So37URRvDx
	 UIty4xOuqj3YyM3VjcGkrY0JCBzVKpYnLO3kGl/3RnSVSpzy0mdQ44z0HtNfwTVMnpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816567;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YiU9202P43soB4yi15WvsIoW/+Z1xghskP4nOhTs74I=;
	b=k8qnX6UPINCz4oM41+yNPaWIZv7MG51WtECxqblR5BL6au1zRlbNtvmOwzm6OF60Ucy4
	 KJHNtZrYpn/Yx+fWSiTG/2go8i5+0wPlQoGXyH6iT7qZYVeAlJTNz6y2tcTag2cHupJ1J
	 Ielxr2SnFVz74hcPxU7+UE1zUWLDv6lSrJ4ALV/5HVkZS7zIobIZS4ALiITvalPcZw0JT
	 v5439qlo8tAsFXIoJoGbrc8urzTjmbywzV5hqTu6NKRVbK5ZHQtlpmHTRMfwt+dvq5UoP
	 +VkTNT+5evqzbSNYAci5q11ZTQDAGGq/X4bXUhgFh8is7AY4A2x9UXYcF0V7Ii44DGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ghrn0Il8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CADD606ECCE;
	Wed,  4 Nov 2026 18:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ghrn0Il8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 993C11F000C1;
	Wed,  4 Nov 2026 18:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793816567;
	bh=YiU9202P43soB4yi15WvsIoW/+Z1xghskP4nOhTs74I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ghrn0Il85/eM53TS1zIPPF0vRY2P2wyT0SC0D3JVIJFS9+pFE9Zzmhk7KGk5YSIjy
	 lfjJ4ReVtg1wxV3EVtLa2OBElC7gfBITIuehm5zriiAccEnp4D15ZUb+DjWW83tCB/
	 UbFGjqL0N2za7yKab9QUXLjONEr5ijtmeHhrmCHVKsRVYj8qN5x4gPOkAuPScsv+Rr
	 OOnbhyrRrDsLrT8tN+WIo+v+gzdZJnYlPhH3l7HUe+8LB97bEG5+BZlaPeFn8tNEJK
	 2h91rf+stMnokpphBjNKRJmqi4wPznAKxhJuNGTyA8F/m/VlD3KRaNUrmvAwjPKV3f
	 ihNHhkxWP8AmQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Uday Khare <udaykhare77@gmail.com>,
	Jerome Neanne <jneanne@baylibre.com>,
	Mal Nadar <m.nirmaladevi@ltts.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/10] regulator: tps6594-regulator: Fix LDO4 n_voltages in tps6594_ldo_regs
Date: Wed,  4 Nov 2026 18:20:58 +0000
Message-ID: <20261104182148.1176116-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261104182148.1176116-1-lee@kernel.org>
References: <20261104182148.1176116-1-lee@kernel.org>
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

Unlike TPS6594_MASK_LDO123_VSET (GENMASK(6, 1)), TPS6594_MASK_LDO4_VSET
is GENMASK(6, 0) (0x7f) and uses an unshifted 7-bit selector field,
with ldos_4_ranges defining valid voltage selectors from 0x20 up to
0x74 (116) in 25mV steps up to 3.3V.  In tps6594_ldo_regs, LDO4
erroneously passes TPS6594_MASK_LDO4_VSET >> 1 (63) for n_voltages, so
the regulator core rejects any selector >= 63 and leaves selectors 0x3f
through 0x74 (1.975V to 3.3V) unreachable.

Pass TPS6594_MASK_LDO4_VSET for LDO4 n_voltages to allow the full LDO4
voltage range.

Fixes: f17ccc5deb4d ("regulator: tps6594-regulator: Add driver for TI TPS6594 regulators")
Closes: https://sashiko.dev/#/bug/linux-c680c361-7684-48a1-96f7-0eae5c8477d5
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/regulator/tps6594-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/tps6594-regulator.c b/drivers/regulator/tps6594-regulator.c
index 503b89a2f5f8..fa4d700252e6 100644
--- a/drivers/regulator/tps6594-regulator.c
+++ b/drivers/regulator/tps6594-regulator.c
@@ -457,7 +457,7 @@ static const struct regulator_desc tps6594_ldo_regs[] = {
 			  TPS6594_BIT_LDO_EN, 0, 0, ldos_1_2_3_ranges,
 			  1, 0, 0, NULL, 0, TPS6594_BIT_LDO_BYPASS),
 	TPS6594_REGULATOR("LDO4", "ldo4", TPS6594_LDO_4,
-			  REGULATOR_VOLTAGE, tps6594_ldos_4_ops, TPS6594_MASK_LDO4_VSET >> 1,
+			  REGULATOR_VOLTAGE, tps6594_ldos_4_ops, TPS6594_MASK_LDO4_VSET,
 			  TPS6594_REG_LDOX_VOUT(3),
 			  TPS6594_MASK_LDO4_VSET,
 			  TPS6594_REG_LDOX_CTRL(3),
-- 
2.56.0.385.gac671c819a-goog

