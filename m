Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047841;
	b=HpGdFEnHfwRczdF0JXDuhqCy2jna8saPAmVqE1ghPCGdIQAcm2qR1xkjIgQNAe55sN0t
	 0HkUba/7NcE41T8cYXJ04ZYzgMw8jtqqgaY3BcYP9m3khdX7ozslFANVgHgkW9JmaKFoD
	 e4GelzEkQS50BqB+TURXyMduAvy1O/uFLBCLihzJG9XZZ42xUVGLYtWisI56kpapSnOOc
	 ju7/9VrhD8HYqoqOWPGtKQDNK7LnYcJBKzmmI/PMbctRYxAMSQlilYYM1CFR2GlAeS+K2
	 JzXG4D6WaJpY85jutgeislo4lOitkzE3oIvh6V537GmADFOhMgHutnDFugN8KrTwKAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047841;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=w/krc7RcWs2uvlJQpCCh5wjGVOBIIbayE/U4/brAyOc=;
	b=eGgieBgUmG8r4jtN8oyO9qFUM84BD10ubtODXdK9VRLrkBZUADsSLY34GwbCVfyerXv6
	 HjaFld8HlukGpO/BZFoGHxaJqnFo9yi+oKsd7Ieu0xQfJb8JnuRz0K3GC5CQm+glihGmv
	 iRUsBo6QSkRs9+8W6v0BzPRxFGmBH8QEYr3mGoCRhgWetX8E9TYPTo3C0VxWXZQqe6mLq
	 Cm+VJhSONU7fTlQiTfAZAjH2h0MIqyokzshrYVw1UrwHdDgnj0n7mcWEwKeqJRnDUo68Q
	 0CjEkeG+rSGnCboctrMiYEFz1C/G5s3OzFoQ1aeQbLaVlp+FA3BVrtjL5V2ejBcSP0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iV5iOsna;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF0F606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iV5iOsna
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D6B1F0089F;
	Sat,  7 Nov 2026 10:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047841;
	bh=w/krc7RcWs2uvlJQpCCh5wjGVOBIIbayE/U4/brAyOc=;
	h=From:To:Cc:Subject:Date;
	b=iV5iOsnanuV4zAmSswjD6ZsN9NwxEQ1fTQkBriFIK02WKaYAL961YOFWSGMa7xLeE
	 4O6AOG2DwBOOD9zmXWvqvogIXMmDR/+wxo3SmeA7mzdps6sXEX9MSatK3oP2ecyWez
	 7kqMWYvixgQJ4sFFVuNKS0FY+Yk9FEAjLRDvcdJL3pXTpoyG1QzaOaEbfN4T7RYVjh
	 U5S7CzvgfARFx+U1yhbrkROT+tnxXQb8G8fnIXoXZoc6jbJxLttYcmsFmhSl4Ys/rx
	 jVB89D/O2BBWpS3q6g0iuBI4JppClM6rzW5TgSjZTHZ+uZeG2gNE+qKx8hxaJD1ma4
	 wQh30lJ4Phr6A==
From: Sasha Levin <sashal@kernel.org>
To: sahaj123.sc@gmail.com,
	geert+renesas@glider.be,
	bartosz.golaszewski@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] gpio: pca953x: Preserve wakeup accounting on parent IRQ failure" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:37:19 -0500
Message-ID: <20261107053719-failed-6.6-a38bf551726a@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x a38bf551726a21c9bcc001b02164f30378b64b64
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053719-failed-6.6-a38bf551726a@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




