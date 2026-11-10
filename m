Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794327396;
	b=koDJyvhtU0o9vs9kmDeVYdR3QzclEA2pzaQgmFEXeHsP00nE0AG5K9DFgtQMTQkNOhCB
	 zT8+AO/QQJaqs99MTaA63ZOGL5Exxi1PhuDrg0vnRjDaN6QHegQZcf4/F9sl5Tbw/8/mI
	 /RGYEjpHSCWv/oShdywbrSwctZ2po1dTVdnWoQiuUtI4xRajoD77cFrpxafUbarghJ3Pe
	 IRgt/PW5Fno5+47K4v7zSdr3IeJ0HCDnaUOiGz9WEePYi0ijopE+G1dpprApfeS9vTDJD
	 wjRpNcqQwkDfEFj5JYfSsMgdRiMOReSiWlDZWrKzL0RRmMBpg6/QMY2ZSy6waRXTE1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794327396;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=LYCtZw2JtpMqlctEGmrzpnm49JxMRBFGTMjnWhIUQPI=;
	b=Zk8TY1kp3Lo+mQgzHxRxd/iRAmXwGrKX9F6klIh75LhGN8OAt8mEbBm8XJBhokF5VoMs
	 YfguVkBJhWYzP5nJEo1zqyALCgtWUhloV5blFWwPOwJsp+rk5vL5tk/SZ/Mmelc92e871
	 GDoCmbr6WeAbfFrFhtHLFctQSQsUJXwlho2Sqv2+It7bMQStFORAqfh7GS6sRfyRKgyn/
	 Y8OAp0cIOEDm57K7jRcok58VVgzW9DkBwMUlststeaaw9NoQwzW5mNrGnCULY9RtLoywm
	 cJu4EOAa5+16JSYPefKVUHsStRqQ86EXQ9RBLmb+3OD/Us4qHIdtcnWEvouuFhF9sng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WSi4HxvY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F4F606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WSi4HxvY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420461F008A1;
	Tue, 10 Nov 2026 16:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794327395;
	bh=LYCtZw2JtpMqlctEGmrzpnm49JxMRBFGTMjnWhIUQPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WSi4HxvYk/pLeeLRAj0La2d854sNtS94zDrFB889FfoTBO1JErqF7fYRr4WjBNy94
	 FhuoyW/QrFBx/+lD97dHEGc3HJ5HQntTnYnc98xTo+9HeaGyVhiM0ZpXTId9PKrlA1
	 sOityi9oaZdQfS/qoQ6oeHUx3TAgTnkNkGdlsxA+uHp9UMbSYEsJNGDSLI8871dYBX
	 OgBceO4+UmIJX36yFzOAj0MABZgLC8P8H6d4CJSF70ezolpHrnjn311yGFkEgKeSPZ
	 AR9ysOk3wNk7GXGWE3L5dV88aSk9kRzUUb7ddNEJ91zwZsqxIDYJHeltiw1PdY+6ob
	 XqCwksHbJA49w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] mfd: twl-core: Use i2c_check_functionality as boolean value
Date: Tue, 10 Nov 2026 11:16:32 -0500
Message-ID: <20261110161605.2449325-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110161605.2449325-1-sashal@kernel.org>
References: <20261107061659-failed-5.10-3c5c55d979dd@kernel.org>
 <20261110161605.2449325-1-sashal@kernel.org>
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
index 718ae54f4d6f6..d5e588c68c0c5 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -791,7 +791,7 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
 		return status;
 	}
 
-	if (i2c_check_functionality(client->adapter, I2C_FUNC_I2C) == 0) {
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		dev_dbg(&client->dev, "can't talk I2C?\n");
 		status = -EIO;
 		goto free;
-- 
2.53.0

