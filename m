Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546653DA5DC;
	Tue, 29 Sep 2026 20:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790712634; cv=none; b=m0ZbixyaYQ8CWcWU10qVDZbY0oMf5CMLZRYF2KNrcNtayIjJP//klG6sSuQiOgHRg4vE573+9FaIiccmXr99SyAw4Vl3cNAl8Z5oLlYSv0AUtsCTcS8wywKshZZxt6ZdTlMgzS/tmlky2DnXQ8a03CALlHrgGK13SGAn0hl4aOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790712634; c=relaxed/simple;
	bh=Sicuho4icjfTu0+nBtNXBidKVp2riLNXWxAlEonvAQE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=seYjz4JoN52G7IdPuXM1vThVg3lD6Trp8Uvd5f3sn8zFbdvQufRYmnVAZ3B+YsDp6CV/ZVQ7+7ONqarrDFpmmaKcUQqqweWQhnW1A8S3W21v+AYlrFAwRpXy+3IcEIWVmPSqs2Way5zs0ZB/YQrNtJgGzSWM8JIn/q73BwzhKaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=roLIJiSx; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="roLIJiSx"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 50BE2C0003C7;
	Tue, 29 Sep 2026 13:10:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 50BE2C0003C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790712632;
	bh=Sicuho4icjfTu0+nBtNXBidKVp2riLNXWxAlEonvAQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=roLIJiSxplEeYDDzJeg3SayNl+C7synq++bDARBaxoT0UXpjrEW3G+MqT5HFiMj1o
	 E3Y9/yqlEHrx8Mu6nLCsc3p6wuLw9/AwEGgXQfsQw2oJvGPgkBrVZJh/hOWDu3oDjt
	 5V2/gDT+pFkTMzV8y5Po0Qa277xbiebpzl0VSQFU=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id E97E8A8A;
	Tue, 29 Sep 2026 13:10:31 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: Florian Eckert <fe@dev.tdt.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org (open list:THERMAL),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH stable 6.6] tools/thermal/tmon: Fix compilation warning for wrong format
Date: Tue, 29 Sep 2026 13:10:24 -0700
Message-Id: <20260929201024.319015-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260929201024.319015-1-florian.fainelli@broadcom.com>
References: <20260929201024.319015-1-florian.fainelli@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Eckert <fe@dev.tdt.de>

commit 9da39ef332c417ce52732564c1c682a6e1209302 upstream

The following warnings are shown during compilation:

tui.c: In function 'show_cooling_device':
 tui.c:216:40: warning: format '%d' expects argument of type 'int', but
argument 7 has type 'long unsigned int' [-Wformat=]
   216 |                         "%02d %12.12s%6d %6d",
       |                                      ~~^
       |                                        |
       |                                        int
       |                                      %6ld
 .....
   219 |                         ptdata.cdi[j].cur_state,
       |                         ~~~~~~~~~~~~~~~~~~~~~~~
       |                                      |
       |                                      long unsigned int
 tui.c:216:44: warning: format '%d' expects argument of type 'int', but
argument 8 has type 'long unsigned int' [-Wformat=]
   216 |                         "%02d %12.12s%6d %6d",
       |                                          ~~^
       |                                            |
       |                                            int
       |                                          %6ld
 .....
   220 |                         ptdata.cdi[j].max_state);
       |                         ~~~~~~~~~~~~~~~~~~~~~~~
       |                                      |
       |                                      long unsigned int

To fix this, the correct string format must be used for printing.

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20231204141335.2798194-1-fe@dev.tdt.de
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 tools/thermal/tmon/tui.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/tui.c b/tools/thermal/tmon/tui.c
index 031b258667d8..7f5dd2b87f15 100644
--- a/tools/thermal/tmon/tui.c
+++ b/tools/thermal/tmon/tui.c
@@ -213,7 +213,7 @@ void show_cooling_device(void)
 		 * cooling device instances. skip unused idr.
 		 */
 		mvwprintw(cooling_device_window, j + 2, 1,
-			"%02d %12.12s%6d %6d",
+			"%02d %12.12s%6lu %6lu",
 			ptdata.cdi[j].instance,
 			ptdata.cdi[j].type,
 			ptdata.cdi[j].cur_state,
-- 
2.34.1

