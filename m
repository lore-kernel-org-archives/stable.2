Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410513;
	b=P0wHcaOQuX1vQta37UfrdTqdBNuOGt0ooZ6kOiUgs1ie7T+2mBuf4mb9jufLOHpv3aJc
	 ifND2FoEZUiMsYM9GXMCPHJnIJgfvsF/dlYB3nyO8crmAlJAOX3Aiua1nVlIfji5QK1Wu
	 RO1vZ8238tRMGtRtoTNNrtk3Cu4fZGHJ56jdME/hfjbLSFfWz8jwAHWNX2AYeGA1X77X/
	 3fRIQgsWXvR/gXPtY7w2ib1m3wXE9qkWEeEuD1KEDiLsrbNEjmnDtGvsSUQWsNVnIEmJu
	 ekymJOnQuZf5CfNcJ+hhcqbhk62yx21+Koufu7WKbguUoHmDh4FXNmg1P4hW9LIFeRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410513;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CvXkKnpoIjFBXMFh/ZhuFqD5bTR3HvMZ0lYB0ahlEUQ=;
	b=L8HHmzqyfxXsVFxO0H9hfEXq6VX9byzO074P9rzjgwIi6YN3BCZJmpTFo9MTYHpFjm7y
	 HDRStcMChSWmXEyZkd8RTMZvPpbSeRj3FX3bnXEP+vbHZOGXeDv5yCmiYsZgpgtAmFYms
	 bu6jyrn96BOFkU5I1ATJlp4aFHfmgOP9NeJcaueUwHda9h4P7C1tHyePUUooiyS2OdQ2F
	 LTd3dbLKOGMoUSmI+MJBoNt0ldBtFXvotdX8Nux6K9J02XtQQlLu+Dnoe9XqiLsg65o8h
	 MrMjSzJzDzEkJE7eCFZOENQDqsjs34IEgeC98w1okRhRmSlGVuw079OgbCiU+U/FOUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B04Rmgrc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61872606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B04Rmgrc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE98D1F00A05;
	Wed, 11 Nov 2026 15:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410513;
	bh=CvXkKnpoIjFBXMFh/ZhuFqD5bTR3HvMZ0lYB0ahlEUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B04Rmgrc123ATMlmZce97l9p40wnzmCUp1dAiJQX1CVRwbOktrb3M7W6V+0dlBLO/
	 2EwnbyDGhGH+kxgGIqNgPGG0KAsDGrYplXanpUyoDkPPZwoc87ifMghGESB2+pm85s
	 E/sXDyABKjb5XZGMmoeGKH3JsgFEADp6nrSzLxqK80T4a0iCmK70O1uIkOc0QJ/0b8
	 HpQ8tqA1gkkc9pwScKTQVP6t534Azc/PoCJwnFyoFIxEQ0FvZCrhLCSwHJvwUtHfG1
	 uDb05DUye7SbgFAfmUe6++bX/DDYsmEd3cDxiMYRjaMw1wPFi+PpW7XdF7zM3OFwYe
	 mhiBzA53gWixQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sean Young <sean@mess.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] media: serial_ir: Fix race condition where timer can be re-armed
Date: Wed, 11 Nov 2026 10:21:51 -0500
Message-ID: <20261111152132.2651491-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055939-failed-5.15-d74ac4016ba6@kernel.org>
References: <20261107055939-failed-5.15-d74ac4016ba6@kernel.org>
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

From: Sean Young <sean@mess.org>

[ Upstream commit d74ac4016ba64cb3b20f395511d0b18025ca0ba9 ]

Ensure the timer cannot be re-armed.

Fixes: 2940c7e49775 ("[media] serial_ir: generate timeout")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
Acked-by: Hans Verkuil <hverkuil+cisco@kernel.org>
[ sashal: adjusted context to replace del_timer_sync() instead of timer_delete_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/serial_ir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/rc/serial_ir.c b/drivers/media/rc/serial_ir.c
index 96ae0294ac102..dac341c68b2bb 100644
--- a/drivers/media/rc/serial_ir.c
+++ b/drivers/media/rc/serial_ir.c
@@ -797,7 +797,7 @@ static int __init serial_ir_init_module(void)
 
 static void __exit serial_ir_exit_module(void)
 {
-	del_timer_sync(&serial_ir.timeout_timer);
+	timer_shutdown_sync(&serial_ir.timeout_timer);
 	serial_ir_exit();
 }
 
-- 
2.53.0

