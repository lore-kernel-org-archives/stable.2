Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B160B47427E
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102757; cv=none; b=qP1Kvvn2l8ExQmCMRGTljhmMj1RiI6FfvSJbifftDLZLmg1kzekWGjrTRjX8gEPIY8MkmW1AOa7d51m0fzhQH7nSCwDBWjnpl4ze243Zlk+cN2O3I1FQV1Xs8TgYV6r/Tgh6YlxdlVYS4Rw/VD0w9+ta8ccvXEemWl+yPtcZWvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102757; c=relaxed/simple;
	bh=Cyj/a7aD0htE+cYAQCmhWbDxWS5SIn806XBiddZWImQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tg9cAXFxTToIVLtQYXPtBPYYuzFsyoIwp2IevWxDhBNV4LQLwcP9l7thMpO/CgsaxvLVJsZdoUaiZgcyfsD/9tZ/nsnrkK6HoNrhRFHyRK9xFO1vKq5i+WhlhQrDrSx7ru5trwm0cUR/vpV7mJiFy2gGjgjO1l6lUeiPc63Rs80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9pn1sAN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9pn1sAN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B60F1F00898;
	Tue, 22 Sep 2026 18:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102751;
	bh=lDCdQ0OvaacXvY7qiiixqWhPom2MScUJxqQFozZZWfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D9pn1sANxw1hXUnma+eTYkgcKgEcVaxATBIeb+fhIfi3jBfcRPgApgQyJ2/ttDl8z
	 8D7v6B6WagKB1/mXpr+6EesIrh7fEJ7KCFxFsHNjNJYhlV7AWAAyItZeL8ve08FlX3
	 G/5BV97zfTIlFTV831YH5F4LvTWm13j+63uuRTmYTO++06BkZRlm37HAfXiN79JGu4
	 j8hND62tQACZ5tZf9hAtMkjwgQHJzvyktA2jhMMoTsHGWj43Kgat0dlgoMwunK+uXJ
	 fB78MU5wdvArbnZaNGbfTI1duiQwDhcaotwEqAmi1tJHaW5T4z5LgCyI7WQuZIQOtI
	 1W275xmWycLow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Helge Deller <deller@gmx.de>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] Input: hp_sdc - shut down kicker timer on module exit
Date: Tue, 22 Sep 2026 14:45:49 -0400
Message-ID: <20260922184549.3790806-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092216-pager-pacifism-6b92@gregkh>
References: <2026092216-pager-pacifism-6b92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Runyu Xiao <runyu.xiao@seu.edu.cn>

[ Upstream commit 309731e95917125bbd13626a7a5600490a5bf44f ]

hp_sdc_kicker() rearms hp_sdc.kicker with mod_timer() after scheduling the
tasklet.  The module exit path uses timer_delete_sync().  That waits for a
callback already running but can still leave the timer rearmed.

A callback can therefore leave the timer pending while hp_sdc_exit() tears
down the driver, allowing timer activity to access dismantled driver state.

Use timer_shutdown_sync() for final teardown.  It waits for a running
callback and prevents rearming after module exit begins.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Codex:GPT-5
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
Acked-by: Helge Deller <deller@gmx.de>
Link: https://patch.msgid.link/20260902154004.3595416-1-runyu.xiao@seu.edu.cn
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
[ adjusted the removal hunk to match del_timer_sync() instead of timer_delete_sync() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/serio/hp_sdc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/hp_sdc.c b/drivers/input/serio/hp_sdc.c
index 13eacf6ab4310..ee096d7c7846c 100644
--- a/drivers/input/serio/hp_sdc.c
+++ b/drivers/input/serio/hp_sdc.c
@@ -980,7 +980,7 @@ static void hp_sdc_exit(void)
 	free_irq(hp_sdc.irq, &hp_sdc);
 	write_unlock_irq(&hp_sdc.lock);
 
-	del_timer_sync(&hp_sdc.kicker);
+	timer_shutdown_sync(&hp_sdc.kicker);
 
 	tasklet_kill(&hp_sdc.task);
 
-- 
2.53.0

