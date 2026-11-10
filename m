Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326319;
	b=gJKiGi2pzPl4TL3g/nkHMQv84F7mIGtGRrokMWIf/81J1WRIdqMjjzSnbaAqGI1KYZ9c
	 8jBdsL1hWWU2/1zGFCrcaJxENyqrU1RCjwJcxFLxUfjesa/DnfZ80xj9sJoKBs3WsYTC6
	 1/d1dpvkB+zmnB5b2g3299khMK5Gcea0fcolMI2wqX1Q5C+Tdy1AIqny1Io73sp9pG7ll
	 qvaVNDphox2dZGZrrN1glNKt3fPnOx0hf9+mMxq+NXLcrCq5uGAXG0F6ETMPgInyX0Vc0
	 uCDGsSA9Orldk4M6prmc0bo8p7BS9ZaYQq6i/omscRe9gvt6JAg6ISxDiC+D8Bmo00g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326319;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xk0reJJf8gH41UTQixaOZ14ge4pj/OL5fNTlduNnCq8=;
	b=iTPSq1ce1EFraUVHNXDBtPRkgKDveVcjdCZLpWYGRu/nTtlWVAhTd++NqXoP0TzE+K3J
	 yAcuQVOh3yLEfilGhZQJvZvEIwnrO9wRY95luPag78o2W9Y84Rb8L1hlYna1q06KIlEtz
	 kpCU2xYOfT63s5MFol3OhaZTtAY5+4Tt3oRTpn9HCWt+CBHCmW/hnYuu2FBVpC7g1mGVj
	 3F7/YjY/qiP4niCNe/vyGY87bS/22GqTgdNwjUDnwVBzviDByBE0SWh4jaNKgQMVYXDp1
	 g/sJawcG2moH6HzKqE7LdVjglEFcRMTutNoyqCFyUGSbN0w3A22oM+n/S3EYVIHZOOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCItmY+5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB07606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCItmY+5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2B61F0089F;
	Tue, 10 Nov 2026 15:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326318;
	bh=xk0reJJf8gH41UTQixaOZ14ge4pj/OL5fNTlduNnCq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CCItmY+5hFzW8+tkEZnTZKtce3BYZC3sMnrb1RtwrlUjbaKtk9jahfS/CBim2wNjJ
	 pvJvNMBV5GAvEg7XlKTC2XsZU1jm28zf/M7ozNkpvnQCxVd5BQvRA200GJylWJyWq1
	 GstICyrMy79ExFdro8DGgP84CXR0eJScRYm7hcdthYPgV1GM8vtMwN39Vy5stTxU/N
	 N1ddhRa0d4LEPc0jk4w+qkHs8mx5fzA7JvS7xslHkwZD+uAgcpF1xIj4DMrUPPLxxG
	 uM2xxTFvk5Qe18Slja6yEBKla+6QDyGxTzhXNp5O/xDilWeE3bnOfAucmuuFgDJewY
	 NzWC/1PZWIhgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] mfd: twl-core: Use i2c_check_functionality as boolean value
Date: Tue, 10 Nov 2026 10:58:35 -0500
Message-ID: <20261110155817.2340846-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053012-failed-6.6-3c5c55d979dd@kernel.org>
References: <20261107053012-failed-6.6-3c5c55d979dd@kernel.org>
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

From: Thorsten Blum <thorsten.blum@linux.dev>

[ Upstream commit 7ee4fa2674e51a0d100b9240cd8a50355141362f ]

i2c_check_functionality() returns a boolean status rather than an error
code - directly use it as a boolean value.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Link: https://patch.msgid.link/20260505114543.159381-2-thorsten.blum@linux.dev
Signed-off-by: Lee Jones <lee@kernel.org>
Stable-dep-of: 3c5c55d979dd ("mfd: twl-core: Unregister the auxiliary platform device on unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/twl-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index ce01a87f8dc39..352a1fb88f08c 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -725,7 +725,7 @@ twl_probe(struct i2c_client *client)
 		return status;
 	}
 
-	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_dbg(&client->dev, "can't talk I2C?\n");
 		status = -EIO;
 		goto free;
-- 
2.53.0

