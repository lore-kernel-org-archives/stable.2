Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628248;
	b=T1a6LG9JynGBRemSBfGIjz9jbwohThIdEc8nYLI4/NgyEGC0VczQ9GHMgF5H/7JBNFmP
	 mVnxvtK0bSKvnGw24V4PHB6b7W55+UqovljAW05o0o7/8CKLvvojRjdVetyBL1aMBJA3K
	 683lWgBtjv9Tm1OIc+WajP21/Ldxr8hEy/DO3e1KbGhWWj+T91VbDknYkGvMEt40iAfhb
	 saMeCg8LbRHM/xkpUMELYNmqf0+THsKZBbqtOCqhrd1VJ3yQt+HJDjsuS3K0JozCmgbbC
	 eT3vfQ6xWA+EFVx9ZhBMK9YLOkIuPJP6BCFx5SrfbBXvaEtn1V8WN4UvkDSswPn2mVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628248;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1lt8qmlVVGVjX5sSHj45W3CqUYld15dlvGb3fkTKRJ4=;
	b=Dty5iI8hjops+Uw7A+CTgZWrFZhCl9I8o4pUu2yi/uq0t05dEGV/du43x4l6doZJE/Gl
	 CbxatXKDm0vAGTlllXMTKaO4Xp0EX8e0aL5C7LjAM42BCNKPYbH14WrW4iJeu/M2/3iDq
	 zdrbZKs16xHqGfimcAruxJkPIRolSe7QzY61yjsKIrcVqSYBA+DkZYcq3wLjP07Fy3rhc
	 3crRVbuyV8fANflpfFlLIqG3sfDN66zTq4QfgXc7KCy5QCgZcXtJIF/oi4LiZBA26/coI
	 ViIzU+xJqjmtibiE4IE8UvUYfCMP8lfDImxS1I/0ihIR3swaYgRhpL6kG1mXe63uyGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GjVocdpY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C21606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GjVocdpY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98831F000CF;
	Wed, 25 Nov 2026 17:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628247;
	bh=1lt8qmlVVGVjX5sSHj45W3CqUYld15dlvGb3fkTKRJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GjVocdpYkjiXszkidT4il7LvUbhDNhcRUgsd7EXkmHriu6IQWuU7LtHf9kLCR/y7e
	 c+cP9VhQp5Czf0EwHvURVb8e43PH5ETWDOteVqe24hBnCMzkjSbCn2QEg/twZFOgZ2
	 LQQYJtq3D44VQ2C1Vw+YvQw8OSLZN2+MvXD1gG7GiJoXmWqJhO+hzrRhZti2IjO0Ve
	 37Pb7rb+Ffw2N8zsnAgJ5ngLEs2/HzlWY8eJyrxqIlUEpnoYZb1nVmcyZh+MSpmHO9
	 oI7RwTSkuPfYmj0JIr2PoD2SfWlHXWzg0uaJXLQllcNB5h6faVJXaakHPEGT8g/4Zs
	 H11XxdwwrIFEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anton Lundin <glance@ac2.se>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] hwmon: (nct6775) Handle dual use registers
Date: Wed, 25 Nov 2026 12:37:25 -0500
Message-ID: <20261125173720.995218-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112508-excuse-mankind-5ea0@gregkh>
References: <2026112508-excuse-mankind-5ea0@gregkh>
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
index 759ea3d1286e3..9096be35448bb 100644
--- a/drivers/hwmon/nct6775-core.c
+++ b/drivers/hwmon/nct6775-core.c
@@ -1153,14 +1153,12 @@ bool nct6775_reg_is_word_sized(struct nct6775_data *data, u16 reg)
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

