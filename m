Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794049780;
	b=GfKvRrIHUh0S79TWBMZzOw5P3BcP8vI9nJQ5Z8oqnTb7wK/LDcRe22GA09BOg1I9FP/U
	 SG2J82OoGLY06jlICP/xUsPP+9PO+bqTbepSc82IzWXNJymwkyFSCV/11rLlEmod62h1B
	 gS07kqU5+kzIzt4bg/QMYFrU0+9pyrGe6EgZV8anosK38KDujyDTaMbkVIVkYjrTrmeu8
	 d51wt4IZpaqh97EETnEphhPMMKkC2VLTUFdNMHAy2ccnMVaiz+k5SjcRNIkBXoNlzSpOX
	 kPpdSMh5+MB46z3r0MqKmdwtQ8mkj5qkH4cZN4qvObCHZ7FgMHocqcMuFD5O9dQUDcw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049780;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=neb1Pm3VUu3QzsGpdwql7eQhsQbPn8IiR/3LY1PC9Bw=;
	b=lwYDTldMf+B3x/Qz/y0dSRy/r71l43LY8rQdbRbvxDq9PtmD+2/FNrxndZ8lygEnfhso
	 CJ1Fu3HVfZMaoFbm4pQ7FFqkZxVAd/oVfG5gJFXbUIBq4QgGda+IrBGENVefXGzzpXfSS
	 vqJWg4yYGphXyXxzbPNqj38/TIfTiMCepPHDWnwtWOKTrLUSNiji+YNxjAxjvs+Td7jLy
	 nLR9naVTJu2TgYLzRlRGNPlZ+QTNXcTHubGZynmkbqkWhPw1xmII420NT7RfaM33c1Bfa
	 KiLxp9rSA8E1in6VfeVUlvdqEI+BlE/AzyAD5ju7s5tEzkp57usBaSqUL8P9Wn9yfvg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PxbTz3v3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDFE606A32C;
	Sat,  7 Nov 2026 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PxbTz3v3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794049780;
	b=kugV2qi2xsc6CnK0AU/UeUI9O4Hz8HMA7z2NGhj2r2p6i5JWUMCdoXWK2wbnRvVU1C5+
	 aePhWv5aov+rO78U6AyrGKDKnJzRZmLINIcvUpcqbfc5wz0vRhR+S2w8g7ZGrZULYDBOq
	 8oZCptOF/rsk8onOdwduApDVxrjU4SJhId1USouXjQv3Mv3dMT7eTpK2/74a+JfEazcOs
	 vw0/SFkgB0RbfUc/YG3Idp30cTdMBZjqmkyc6luMAWphJ62ewhaxrwS3jk9taSbQXTVpG
	 n1yHfYYVEnUCQAvga4Tmh2al5AzI9U2Wsfd/soUFmqJhUkIFz+okkhU/M49DKLRo+fw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794049780;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=neb1Pm3VUu3QzsGpdwql7eQhsQbPn8IiR/3LY1PC9Bw=;
	b=VONUzrJaVpnRVJhddr8f+lDG/NPgXXMXZBkU8mgs4vTYGO9j+6+6SvZn/jmoeutOFtzu
	 ZFGMrbB2tj0Xd+BpIqvAhq4n8/kXIbKhf/NVgLR+WHmYNV59GcX1RSR27q/dKAY4qmlzZ
	 fsqqmlKR3sJMMjCeQ5rTthqc58s+mnXVfehFTL6Y1pFUnD3wO6ydTgw9AUMERsV+iSVgv
	 bhLmvJIPysZTjQ7BAE7R+anEL1AOGCv0cBh0xteMQALPYHOQpo70NO89RMYezXdicPGHM
	 yu+zD1iQSN3URlQjIF7ckx/X6C98Lb5oDRRJf3gp1EP9QXqRBdkFGnuW/cWyuKah0mA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 13BC81F008A2;
	Sat,  7 Nov 2026 11:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049780;
	bh=neb1Pm3VUu3QzsGpdwql7eQhsQbPn8IiR/3LY1PC9Bw=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=PxbTz3v3uuTuqIy3eZo+R27eJTf3bMidYfy3Itf05XNarG/XyYhqF+rUTMYVCMgjH
	 2+KyEi8xHvCRXNul+MEVph0TOUd/4NZex8Sieykq7At4+4iYQz/x58e1mFJHBLTMvc
	 nocl3CPpTpBGaX5J7g9McWQbhcPaCrVHJ5UVqw+zusIlH129HAxHQ/j5YE1BHmKWbE
	 vdnEzbWfHrkPuZP933DfBlDhZXLL5t7w9CBKnVDyMPCoLbOm0TZ0uAbk4G7KPQuCRf
	 n2nyJC2heDMZ9ntKAcBIjkaTCxqYdP18EeTvcTuHbGIMtJAohZNXeEvPFch7lVzSgO
	 GUsxH5varN7aA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 867E747B6F;
	Sat,  7 Nov 2026 11:09:39 +0000 (UTC)
From: Rui Cao via B4 Relay <devnull+i.udp0.com@kernel.org>
Date: Sat, 07 Nov 2026 19:09:36 +0800
Subject: [PATCH] power: supply: mt6360_charger: Set the input voltage limit
 in CHG_CTRL6
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
Message-Id: <20261107-mt6360-charger-mivr-v1-1-ae6fcfb21bb9@udp0.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMUQqDMBCE4avIPnchibBir1L6UJNRt6AtGxVBv
 HvT9vFjmP+gDFNkulYHGTbN+poL/KWiOD7mAaypmIIL4r1reFqkFsdltAHGk27GdWrRRIj0KVB
 5vg297r/q7f53Xrsn4vJN0Xl+AKY5/ox3AAAA
X-Change-ID: 20261107-mt6360-charger-mivr-3d9e7ce66fd2
To: Sebastian Reichel <sre@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 stable@vger.kernel.org, Rui Cao <i@udp0.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794049778; l=1708;
 i=i@udp0.com; s=20261107; h=from:subject:message-id;
 bh=NPOAHTLtaaexfTH0i/P9IAyN1qGjNjezFTQY55cDejE=;
 b=24QLSek8cMBjCn+fV0DFLLs5uhUl1By3RsW5vERTdOt7I/qC5khu7TXxFtXcFiRARw5suDHJZ
 uTrousjJyxYDHY0mD2B+7hQyb0GD+LofX2iDGcNVkNZDpK3LfSVyc2B
X-Developer-Key: i=i@udp0.com; a=ed25519;
 pk=XZJKcKgnUUjjyw8KuKy7u2QeIX0JLY/L1Fxzwwje41w=
X-Endpoint-Received: by B4 Relay for i@udp0.com/20261107 with auth_id=1443
X-Original-From: Rui Cao <i@udp0.com>
Reply-To: i@udp0.com
Content-Transfer-Encoding: 7bit

From: Rui Cao <i@udp0.com>

mt6360_charger_set_mivr() updates the MIVR field (bits 7:1) of
CHG_CTRL3, but MIVR lives in CHG_CTRL6, where mt6360_charger_get_mivr()
reads it and MediaTek's own MT6360 charger driver writes it. CHG_CTRL3
holds the input current limit (AICR, bits 7:2) instead.

Writing input_voltage_limit therefore never changed the voltage limit
and replaced the input current limit with the MIVR selector: 4.5 V, for
example, set AICR to 250 mA.

Write the MIVR field of CHG_CTRL6.

Tested on a Redmi Note 13 5G (MT6833 with an MT6360): with this change,
writing 4.6 V to input_voltage_limit only moves CHG_CTRL6 from 0x0d to
0x0f and reads back as 4.6 V, while CHG_CTRL3 stays at 0x72 and
input_current_limit at 1.5 A.

Fixes: 0402e8ebb8b8 ("power: supply: mt6360_charger: add MT6360 charger support")
Cc: stable@vger.kernel.org
Signed-off-by: Rui Cao <i@udp0.com>
---
 drivers/power/supply/mt6360_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/mt6360_charger.c b/drivers/power/supply/mt6360_charger.c
index b4d46234315..ccd5c200629 100644
--- a/drivers/power/supply/mt6360_charger.c
+++ b/drivers/power/supply/mt6360_charger.c
@@ -414,7 +414,7 @@ static int mt6360_charger_set_mivr(struct mt6360_chg_info *mci,
 
 	linear_range_get_selector_within(&mt6360_chg_range[MT6360_RANGE_VMIVR], val->intval, &sel);
 	return regmap_update_bits(mci->regmap,
-				  MT6360_PMU_CHG_CTRL3,
+				  MT6360_PMU_CHG_CTRL6,
 				  MT6360_VMIVR_MASK,
 				  sel << MT6360_VMIVR_SHFT);
 }

---
base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee
change-id: 20261107-mt6360-charger-mivr-3d9e7ce66fd2

Best regards,
--  
Rui Cao <i@udp0.com>


