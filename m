Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461499;
	b=BZBBqUw/lmNgC0/H25b1Y9QKgiEpRL1JCBmRMqguHSRZySxjvmexMQEElzyIC88AJh7D
	 3AtU2QpTzDa9zr2EMRNkQTc/LaycJWh+Jn8V0Wsf+3Ww8N8t1Pz+GPlgTmJUKn0L7XYbp
	 aL81XBufSTuTOo/VHn/PkcjqQn6uzGLQyLPyzmXA0vI5SSmWRRXpSk5gB5bGMHN4NTg+K
	 M8OdNJQrrlznP958//at/+26uWUCzRqnD4aa8LkKhu5mLTuffR8Y1Yec3VcWW4EXnPZgU
	 lgPU7iDe9RRUdXgAXYRmWhY6sJAfWKhLv1JzEqhNkulI21N5QcPp0gWPuFeMAhdgaeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461499;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=QeVL1oh/02zJrzsfFfCh64xNOfXvg6lZnkmRzYRsosw=;
	b=PHzRvE0Ipmxkjkms0yv+b1wTmoX6TL4zWGv2CVyTJs6USTwayY+uS1ZDx/HzOIwGUC0y
	 9MYlySJ8zNxNQgqHanLLlXy3vwLoBy3cCTYBNLHuEIrRaMM7BD73RZvN69VUEJNlaZrLI
	 Wkgcvdpn4W0NJE5z+cbJRuAUulhIxcwCNHV7uyA0imqaGxunKcsmHrRw3SzdG0ioCfGqZ
	 YdiHgx4BmiO+jIdcCqDmNQzhiJn4b2kpqzNic9UI3QWnnmrHrNDbylrW4k+re/Tj5ACu/
	 Ld3c2xTQC/fLl4TXucYQ+m5bO47k3XtLxiaCi7pggpdZt1sZlU7WV/PnEaBArHZwPNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVOcXnOE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3668606A31A;
	Mon, 23 Nov 2026 19:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iVOcXnOE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B11C1F000D1;
	Mon, 23 Nov 2026 19:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461498;
	bh=QeVL1oh/02zJrzsfFfCh64xNOfXvg6lZnkmRzYRsosw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iVOcXnOEp2GsAyPxMFcuyOEVwMBipE8I6tGzJt3IzPs6FhuPv0lG0ZtSNBphUHeFf
	 nAvykFFvkMXQLuZbSRu6l/7srxmzXqAWOod9oYD3eVCSgkAbQghQY3Yz2xob4RdSwd
	 RzoWSx/P7sQ32REAPhuerb+4cHZ7+eK0oS9gWD/2mqGsxAUdUBhWBR8MWeXJoqN5iq
	 UZ3nfVF56WNi3hfz5JNBAhWJHBgSlWfDP+6U/EF8WhRHCRU6hbyY5bXXRk+1cW/S2k
	 JW+ObOMg48hxGrjJyfbs2rJoX1iOfNpfsnT2OeHAMP+FbhVkVYMLGT2IKJwrpVQ3Bh
	 tuSRiP9keZlSw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Ulf Hansson <ulfh@kernel.org>,
	Juha Yrjola <juha.yrjola@nokia.com>,
	Tony Lindgren <tony@atomide.com>,
	Hiroshi DOYU <Hiroshi.DOYU@nokia.com>,
	Jarkko Lavinen <jarkko.lavinen@nokia.com>,
	Pierre Ossman <drzeus@drzeus.cx>,
	Aubin Constans <aubin.constans@microchip.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Allen Pais <allen.lkml@gmail.com>,
	Christian Loehle <christian.loehle@arm.com>,
	linux-omap@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 08/13] mmc: omap: Shut down cover timer before disabling cover BH work
Date: Mon, 23 Nov 2026 19:15:52 +0000
Message-ID: <20261123191703.179283-9-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123191703.179283-1-lee@kernel.org>
References: <20261123191703.179283-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In mmc_omap_remove_slot(), cancel_work_sync(&slot->cover_bh_work) is
called before timer_delete_sync(&slot->cover_timer).  Because
mmc_omap_cover_timer() queues slot->cover_bh_work and
mmc_omap_cover_bh_handler() rearms slot->cover_timer, a timer expiry
between the two calls (or a concurrent omap_mmc_notify_cover_event()
before platform cleanup) can re-queue cover_bh_work so that it runs
after the slot and its struct mmc_host have been freed.

When cover state polling is configured, shut down slot->cover_timer
first with timer_shutdown_sync() to prevent re-arming, and then stop
slot->cover_bh_work with disable_work_sync() so no further work can be
queued during teardown.

Fixes: 7584d276d47a ("MMC: OMAP: Use tasklet instead of workqueue for cover switch notification")
Fixes: 921c87ba3893 ("mmc: Convert from tasklet to BH workqueue")
Closes: https://sashiko.dev/#/bug/linux-f30b1077-ed4d-4d62-a07b-11fff78d42c5
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mmc/host/omap.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 36df578298c3..55efc4ec9d03 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1356,11 +1356,11 @@ static void mmc_omap_remove_slot(struct mmc_omap_slot *slot)
 
 	if (slot->pdata->name != NULL)
 		device_remove_file(&mmc->class_dev, &dev_attr_slot_name);
-	if (slot->pdata->get_cover_state != NULL)
+	if (slot->pdata->get_cover_state) {
 		device_remove_file(&mmc->class_dev, &dev_attr_cover_switch);
-
-	cancel_work_sync(&slot->cover_bh_work);
-	timer_delete_sync(&slot->cover_timer);
+		timer_shutdown_sync(&slot->cover_timer);
+		disable_work_sync(&slot->cover_bh_work);
+	}
 	flush_workqueue(slot->host->mmc_omap_wq);
 
 	mmc_remove_host(mmc);
-- 
2.56.1.750.gf70dc682cf-goog

