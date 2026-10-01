Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B579253B42;
	Thu,  1 Oct 2026 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790870522; cv=none; b=EUvGQ9fqeGJQqpnn+kMw16e7+qftypYSOxNPYEDRGzcCOgr0zOs97OMNqkrpj7/dUGnkcWfxt8/sn8ujaOMgIRgv39j7+WPm0HNiLe1jCFhZqgwTIwT2vES4PrzR3/vRztHYH25fM463+jl/RvyrzVt4pC0dF381ucKl5rYlG0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790870522; c=relaxed/simple;
	bh=6tzBwYezvCHMFybOlAjAjqSt/P2oNWqJ4vxlblDRPUA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZTovC0IKCcs6sg1WsGODq3fS98kJFIFMU4acLR2gN8woRnT12GprDYgMy/Jrj4NFQ6tCT2FiYEpbi0HFyS7PFW1z2ApY5NjnDl4hZ8BB+JEL3qz7DSqow0xo7uJQYEFKL14IzdC5Z/GpVOzFfd1tPC2aYcZR3zOMyc/LyqE6564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=V1U7nrc/; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="V1U7nrc/"
Received: from mail-acc-it-01.broadcom.com (mail-acc-it-01.acc.broadcom.net [10.35.36.83])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 22DACC0005C5;
	Thu,  1 Oct 2026 09:02:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 22DACC0005C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790870520;
	bh=6tzBwYezvCHMFybOlAjAjqSt/P2oNWqJ4vxlblDRPUA=;
	h=From:To:Cc:Subject:Date:From;
	b=V1U7nrc/UL4pOBZzYnrxjDev2Y1njEPG4ai+m9bUj3zxdkfTzgY5ORVMW0MdIBeay
	 pTQe07QMLy5Xj2k5EjbgPKYX3hfQ5uMkqdFFEaqnmwZ0p+GdjuipuKzb/sE3mwnjt4
	 WzduhjuIpI6LCDNHDsEFqV6miaLGK0uKAgK3hW50=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-acc-it-01.broadcom.com (Postfix) with ESMTPSA id 5DACEAEA2;
	Thu,  1 Oct 2026 12:01:59 -0400 (EDT)
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
Subject: [PATCH stable 5.10] tools/thermal/tmon: Fix compilation warning for wrong format
Date: Thu,  1 Oct 2026 09:01:56 -0700
Message-Id: <20261001160156.814419-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Eckert <fe@dev.tdt.de>

commit 9da39ef332c417ce52732564c1c682a6e1209302 upstream.

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

