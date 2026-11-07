Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050776;
	b=aldM5ho2qQdIClbziZcCRlO4SafSEzkewV6xufKAU1NRVv8yvfLdxOd3NrudJuQiMVtB
	 L9tkKqHcImJwaiVEcm/Z0e6wU+YUcHlAn34jfCfC0+Z27J9KZ/T5oqG7mQN3/9MRLfaFt
	 W8kmBnYrgBqEYCaQ5oVDkG2GCwvL8u3OjekJYv2W5eLPxnt/bP+v+GaRlI5ujqFWe0+qt
	 KphL2BxFVCnRWxOV/HJo1YGn9Az0egQrYTa5h4H1uvUpsbe4P5PdZx6R/gOBkACu6TOmN
	 IZW8hpTDpMa5buJUa4QqGJ7hG8UMSruJmQmPsQ6Ata+kjHO1V9YTWT1LrpzFdcBkrVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050776;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SXi5Je1CtBcWUSId9aMrF+IdYWa0Ub4JET1HrmxPGdQ=;
	b=W7EjtdIFNskFOLcG5UFuwUdMcb1URmONDHAxA/ncUlcBmr0spd9Pw4BBFwxG6T9NG6B9
	 Y+3h0RCOFpGtCBNpIgY7nLxMOHF0u6e3HwCaLXzjmhr9L5TvEqN7xhRmG+Pbr9g5V5qOt
	 qVwU8vQJPMI69U9aOZBLNyk0xOj/O3xRh58gvm94KtCPXWLucPboWZ0mOxNekJ/YOd1MY
	 PdOubuzeR5g9CUT4B/LeqU6x6W6qnS/p/g/+pdP2LMgATEzRZXwqv5b/9igwFWNpJEN1d
	 LoIsD452kWECRCvXf5tRZazXURMGrHQFXqMOeMHCONIS4/PaMOpK8c+FIE5rYH+8HkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fe+kSmpA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3091E606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fe+kSmpA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87C0C1F0089F;
	Sat,  7 Nov 2026 11:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050776;
	bh=SXi5Je1CtBcWUSId9aMrF+IdYWa0Ub4JET1HrmxPGdQ=;
	h=From:To:Cc:Subject:Date;
	b=fe+kSmpAAf7nYiE8t5n8p7QS3k4P/jIzAHo9etdV+/LynMIHrKa22fF0rqZiK9Eh/
	 iJp9NRzlUSVF1s0x6wexlhbOA/uIqO0EqB+mdKld6sNrss6Z2FMkPxXQ0JfXSxWBVs
	 NnRZ8KMdeOrbRa0mctSVBOFqjrzFm4OGYtGaqb4ROdHKFPUWrAPGf0jdH6r5GT6Vij
	 QNy7TU2WRuEB1jQpDk8memX2wuGTvfVycj0nB0G4yo/xUzqNW8QRMAexLh5DiW44jh
	 fmN7TkrLJMBvZKgdL/YhEhWyw0hYrCIClgFcqfxzniA8VS33gl4X/5Q1ZBJD+IkSEs
	 HKs0rmMA+75iw==
From: Sasha Levin <sashal@kernel.org>
To: sahaj123.sc@gmail.com,
	geert+renesas@glider.be,
	bartosz.golaszewski@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] gpio: pca953x: Preserve wakeup accounting on parent IRQ failure" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:26:14 -0500
Message-ID: <20261107062614-failed-5.10-a38bf551726a@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a38bf551726a21c9bcc001b02164f30378b64b64
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062614-failed-5.10-a38bf551726a@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From a38bf551726a21c9bcc001b02164f30378b64b64 Mon Sep 17 00:00:00 2001
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
Date: Sun, 18 Oct 2026 21:40:42 +0530
Subject: [PATCH] gpio: pca953x: Preserve wakeup accounting on parent IRQ
 failure

pca953x_irq_set_wake() updates wakeup_path before asking the parent
IRQ controller to change its wake state. If irq_set_irq_wake() fails,
the IRQ core rolls back its wake state but the driver's counter remains
changed.

A failed enable can therefore leave the expander marked as part of the
wakeup path when no child IRQ has successfully enabled wakeup. A failed
disable can make the driver stop retaining power even though wakeup is
still enabled. The suspend and resume paths use this counter to decide
whether to disable or enable the regulator.

Update wakeup_path only after the parent operation succeeds, leaving it
unchanged on error.

Fixes: f70fbc15bae2 ("gpio: pca953x: Configure wake-up path when wake-up is enabled")
Cc: stable@vger.kernel.org
Signed-off-by: Sahaj Chaudhari <sahaj123.sc@gmail.com>
Fixes: f70fbc15bae2c89f ("gpio: pca953x: Configure wake-up path when wake-up is enabled")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20261018161042.3298045-1-sahaj123.sc@gmail.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpio-pca953x.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
index aac9ea7520b60..869ed4264d48a 100644
--- a/drivers/gpio/gpio-pca953x.c
+++ b/drivers/gpio/gpio-pca953x.c
@@ -838,13 +838,18 @@ static int pca953x_irq_set_wake(struct irq_data *d, unsigned int on)
 {
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct pca953x_chip *chip = gpiochip_get_data(gc);
+	int ret;
+
+	ret = irq_set_irq_wake(chip->client->irq, on);
+	if (ret)
+		return ret;
 
 	if (on)
 		atomic_inc(&chip->wakeup_path);
 	else
 		atomic_dec(&chip->wakeup_path);
 
-	return irq_set_irq_wake(chip->client->irq, on);
+	return 0;
 }
 
 static void pca953x_irq_bus_lock(struct irq_data *d)
-- 
2.53.0




