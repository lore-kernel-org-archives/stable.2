Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046104;
	b=bvZ8xr//Ih0RkjB2uPmADTI3lEBzcamSmzeZftLfE4tK6OkMxwUx9XvOLjoMCUIl84u2
	 wKpLYxKoSS78lVoY2LaALBbisUjz2q9R/Zof67Hk2ekYcVBZuoO27sdbZsF0HI+KV8AsQ
	 m92DrUJzb+GyAPK6e592HeGR4t3PTX+7fnXhQ1Xh+Z/CXVNFqMKevx3Fb98EAJIWPft3h
	 kbJWeMDCR06ukjv0daKjRcFZ1uvFY4Qy3DnISrHHS4gWXz6YRrh+uJYXVjeUDjnFfqcT5
	 mjB84HC/ZmlP9qI7qFvMnlyj1C7M2bYzu7MNMO+UFfl0QUJ7G/os1w3O5HS3NzMw45Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046104;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1oHJ2RiL/M76DQ7wpBtVuO3R1Y70AZ9Bm68CQlaiu7w=;
	b=M7AmIeg565jzdrltMorXbHTQUT35zImcatUc9fJkL0LHWNfJ9VUcNEF0ifL1b68dO8DL
	 C+eYad5iV8a3pdIA0Vv4ZejxX+agOO4oYMyoFAkoICDlXFuUdx9ujil0s8AEkxNi+Szpb
	 UEUBt8GX4I/buOFCtPVkR0MpIHNcd/dwvFvDdihd7WofWlSFcG7az4JeW5Bt4JZXKyqXE
	 KDGnOMRu8nq4oi9lVgqyGgLbHb46R8JlEDimokx2oMBfTdYEWcSidQ1PNLw3ALORVr6+E
	 tDr5gn+VGgrNR48dPMpc1icMhOQhNFyFGqGS7KEJy/VkwLC+r9BstoFDI32TlV6XqPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9Icv0zu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250B0606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9Icv0zu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8751F008A1;
	Sat,  7 Nov 2026 10:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046104;
	bh=1oHJ2RiL/M76DQ7wpBtVuO3R1Y70AZ9Bm68CQlaiu7w=;
	h=From:To:Cc:Subject:Date;
	b=F9Icv0zukTmC8g6GPxkPYIKQBworC8DU/ZKqs4iyUH1PypH/OE0VIR69We/zN27Io
	 xhsSf+9roLNzL/a/AinoGjZOK9BoeoIv/wwrY/FmbczOCnDQzk+eoqvmt66dGcL+Pm
	 9rVUTXF4y/0CtAck7mliunO3yfVKiGG7hAOHs69QLyVrrUz4kz5NSwz4TekCxYMfnk
	 cNKTblhXAoc+bipvdLZeqF/hnDAWFKSvlBIjNFla5HPT7ioNdsWG+ADXypYnTy3cVs
	 rbx2psEBn0XKNvq2kXriX5xs1extL4zcB0Oz18h1iY9RuJMHQ3+ZZlxe/2hieb7tK2
	 hh9wp6Sr6D1jw==
From: Sasha Levin <sashal@kernel.org>
To: kmehltretter@gmail.com,
	sashiko-bot@kernel.org,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] spi: atmel-quadspi: balance runtime PM and pclk across system sleep" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:08:22 -0500
Message-ID: <20261107050822-failed-6.18-717e45f97246@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 717e45f97246d1070cdf86ccd7a0fb872b45933a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050822-failed-6.18-717e45f97246@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 717e45f97246d1070cdf86ccd7a0fb872b45933a Mon Sep 17 00:00:00 2001
From: Karl Mehltretter <kmehltretter@gmail.com>
Date: Wed, 23 Sep 2026 03:29:50 +0200
Subject: [PATCH] spi: atmel-quadspi: balance runtime PM and pclk across system
 sleep

On the controllers with a generic clock (SAMA7G5, SAMA7D65, SAM9X7 and
LAN969x), atmel_qspi_suspend() takes a runtime PM reference and returns
without dropping it or suspending the device. It disables the peripheral
clock directly. atmel_qspi_resume() only prepares the peripheral clock
and then reinitializes the controller with that clock still off.

On a SAM9X75 Curiosity board, the tested standby and mem resumes
failed:

  atmel_qspi f0014000.spi: PM: failed to resume: error -110
  spi-nor spi0.0: resume() failed

Reading the flash afterwards returned no data. The runtime usage count
grew by one with each cycle, and the second suspend disabled the
peripheral clock again:

  WARNING: drivers/clk/clk.c:1257 at clk_core_disable+0x6c/0xcc
  qspi_clk already disabled

Use the same runtime PM sequence as the other variants. Suspend disables
the controller and forces a runtime suspend. Resume forces a runtime
resume, which enables the peripheral clock, before it runs the init
callback, and drops the reference afterwards. With this change the
tested resumes succeed on the board in both modes, the controller
returns to runtime suspend, and the flash reads back.

Fixes: 5af42209a4d2 ("spi: atmel-quadspi: Add support for sama7g5 QSPI")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260709112006.390742-1-robert.marko%40sartura.hr?part=3
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Link: https://patch.msgid.link/20260923012950.15651-1-kmehltretter@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/atmel-quadspi.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index ec19fa0180f00..96ed734b56218 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1590,12 +1590,14 @@ static int atmel_qspi_suspend(struct device *dev)
 
 	if (aq->caps->has_gclk) {
 		ret = atmel_qspi_sama7g5_suspend(aq);
-		clk_disable_unprepare(aq->pclk);
-		return ret;
+		if (ret) {
+			pm_runtime_put_autosuspend(dev);
+			return ret;
+		}
+	} else {
+		atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
 	}
 
-	atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
-
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_force_suspend(dev);
 
@@ -1621,20 +1623,20 @@ static int atmel_qspi_resume(struct device *dev)
 		return ret;
 	}
 
-	if (aq->caps->has_gclk)
-		return aq->caps->init(aq);
-
 	ret = pm_runtime_force_resume(dev);
 	if (ret < 0)
 		return ret;
 
-	atmel_qspi_init(aq);
-
-	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
+	if (aq->caps->has_gclk) {
+		ret = aq->caps->init(aq);
+	} else {
+		atmel_qspi_init(aq);
+		atmel_qspi_write(aq->scr, aq, QSPI_SCR);
+	}
 
 	pm_runtime_put_autosuspend(dev);
 
-	return 0;
+	return ret;
 }
 
 static int atmel_qspi_runtime_suspend(struct device *dev)
-- 
2.53.0




