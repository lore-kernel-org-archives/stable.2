Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC33B331203
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784964348; cv=none; b=NmC05Ok844w+OErOwgQnot/PcZ/esZT672zsiv1nFf7gnwy7Zb+SjDtslrllHswLsfTi1AuuoZB5nsOFbzlzgzQozlus0Il6Po2Wa+PjLlNmTjkUquYLHPXsTazAy5C+MkI+4ZmJTsFMq/GtLaPax7UeXPaa2iM8JFcg2Da4Q9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784964348; c=relaxed/simple;
	bh=DCI7rjRmM93lutxj7+bxqQZ86jwK5qGWszKWi9ztQ4A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tQPI+xoYJAlTF0oDb5PJ2UAGTfwdnU1pkqK7tq6o2QjZapq7ECBxiBbLyGU3YQgtgEowZXXHw2f1FnSmiX5LOnVQFgXc5Dmtnst+CHTjh3oi9ovpwDDBZCln52JnyqX/RsG8WNptXwdfIkIzBH2nzTPWolydNoAWbQsgLiS6m+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWqDM5mQ; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWqDM5mQ"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e58034d05so1278443a91.2
        for <stable@vger.kernel.org>; Sat, 25 Jul 2026 00:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784964346; x=1785569146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IxN16LlGLH2WwnDJmdIskymBeU5WPj7iW8e+rfqR+5c=;
        b=TWqDM5mQ0LvbGO3xv90snOwBtokbv7LCbbDftiCg3HVPneK7e/7MuYwuqEiv4nLr8y
         FFIPec+LxtPLG+0JlJ8CqAfkQ4GdIky2EsW1WHsCsja1XJgCQ5n/clfJw542JfarLKsc
         2JVNh1/X83sOBWllROG0a1dggH+TraGt0H9Zp5D34SVLIUQSS4hnCSRpzcXt4AHy4XMS
         2LXYloOjGXl1v2Rk5qC0qc2j7u2XDtPlL44k8r0rZzdRnPDTvJfe0EGMIo6Kw8DT+dmC
         2A/+qfVO16dOxgpbRwTc31NwPv3Wys5UUSNWT/nWPsiLz8cugpLWoo9FazMuc5nX1pt3
         ubCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784964346; x=1785569146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IxN16LlGLH2WwnDJmdIskymBeU5WPj7iW8e+rfqR+5c=;
        b=YkbxYvx2wgEbM5vMBGKpd6MG2eLkRFArLxRidCyoWA9mUlVzaMHgoAx8p5yYot1y44
         q9Mp+u5hVDrHZ5uP1oVnhOLgF/RIYDGoVQB4dMS6VBRvFlaXqG8UG9fyI2XJ6xTnzfzS
         L3xKuerYdFNz6covzJXQ5XOyJ+rKecRk/m/ukPYGo8ib23esQS5WDvor0A1iH3S6q4Z8
         SVYaZIXXXivw6+EsVH2L7XfXbGje/+GkIwiWe642rOz63+tFVM7gNx6pZomnLtMXYsMf
         RzC6eU8bEcOwK/jBGjg8I8oxhXB6fJcA4TyNtf9wFHbY2ihFX0mN0w5qBkF/HhHXzLl0
         h0HQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdbFt3dwOowoGRo0w535BsSyhiSrZOYDaYxpLY7vVYULDHvqTVkVhGdBtYzW8LAdt9ASQ/3lE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2yKyIcvea/0R4TwHs2ZSRXf/wEK0L28dFcuPHRvAFLbI45M6T
	JROtHpvn/5bVaV6SwXRHyuN5YLSFVeYSL3kiSUxktzqwAnC1jF+/2fCB
X-Gm-Gg: AR+sD109re9SoKOFT2OSqVuzuSTOkoQozURbkH6h9U3strzirQbKAYrS8mk/PnT64n9
	k4W68hu5e4cCRwBTvEJ1kVMvyS5MbGNEPTQWpTsnBGwZSbgNGbsUDcPAGXhYAb/bLp2/gJSnuwp
	1V4Myz/LMZY0XtiTioESIy43mfOGZauAKJvIG5bAm5lk2YnUwq9U6kBTqU9GK0NIvffvwPoD4kW
	huieb6FaXKkiYL2u0yBILCMxJkLysLxUmSNmA70AbGv7rJscWI+WAzYe+I70oKaqfKftei6vBAB
	w6gEFGC6/NuNWWEennCudyTkhUTkJXXKiD1/8dA10JMjBC8n6LEpkBbVCKz8Op8LNAPtas7bSxI
	ZuBxUpcoESQgU3JFZ2DUsfOBNS9AusrkqZQl69Gotx7+ZU2Uqh6swYq1HxMdk313iNcGFvTCV0X
	XdqDrlK5s0moph6L05Zcv7VZ/P3AuDFoJkLbANqg==
X-Received: by 2002:a17:90b:3f0c:b0:387:e0bb:57f1 with SMTP id 98e67ed59e1d1-38f2975d581mr1657727a91.34.1784964346221;
        Sat, 25 Jul 2026 00:25:46 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d13014d27sm33921944c88.4.2026.07.25.00.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 00:25:45 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"H . Nikolaus Schaller" <hns@goldelico.com>,
	Anton Vorontsov <cbouatmailru@gmail.com>
Subject: [PATCH] power: supply: twl4030_charger: cancel workers via devm
Date: Sat, 25 Jul 2026 15:25:40 +0800
Message-Id: <20260725072540.3092504-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bci is devm-allocated. Two workers (bci->work and bci->current_worker)
dereference it. twl4030_bci_remove() disables charging and masks
interrupts. It cancels neither worker. A worker pending at remove() can
run after devm frees bci.

The USB transceiver comes from devm_usb_get_phy_by_node(). devm
unregisters its notifier only after remove() returns. A cancel_work_sync()
in remove() can then race a notifier reschedule. devm_work_autocancel()
and devm_delayed_work_autocancel() avoid that. They cancel the workers
during devm release, before bci is freed.

Suggested-by: Sebastian Reichel <sre@kernel.org>
Fixes: d6ccc442b1210 ("twl4030_charger: Make the driver atomic notifier safe")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20260702172128.2001753-1-maoyixie.tju@gmail.com
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---
 drivers/power/supply/twl4030_charger.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/twl4030_charger.c b/drivers/power/supply/twl4030_charger.c
index 04216b2bfb6c3..d8bae2daac23d 100644
--- a/drivers/power/supply/twl4030_charger.c
+++ b/drivers/power/supply/twl4030_charger.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/devm-helpers.h>
 #include <linux/interrupt.h>
 #include <linux/mfd/twl.h>
 #include <linux/power_supply.h>
@@ -1002,8 +1003,18 @@ static int twl4030_bci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bci);
 
-	INIT_WORK(&bci->work, twl4030_bci_usb_work);
-	INIT_DELAYED_WORK(&bci->current_worker, twl4030_current_worker);
+	/* Register current_worker first: devm cancels in reverse order, and
+	 * bci->work can reschedule current_worker.
+	 */
+	ret = devm_delayed_work_autocancel(&pdev->dev, &bci->current_worker,
+					   twl4030_current_worker);
+	if (ret)
+		return ret;
+
+	ret = devm_work_autocancel(&pdev->dev, &bci->work,
+				   twl4030_bci_usb_work);
+	if (ret)
+		return ret;
 
 	bci->channel_vac = devm_iio_channel_get(&pdev->dev, "vac");
 	if (IS_ERR(bci->channel_vac)) {
-- 
2.34.1

