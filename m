Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047082;
	b=PQtsTLEvwgVrpcyVd0NCFwn/1ufjiUoWErcgc6oLR8uRshGMW8DunnglnzI2YBvw81cb
	 xV3G7sTpNSuVHTAyEF7n9jobHncpl69bPy+5cq9+3oqeRuTFw+RD13/CKK/3129KhjtWS
	 0vW9S35y0JMzREh39HZ0451ka23xJqq2agiwzOyypKQjmNM2kTrrpztSvBz1CASD9j4dr
	 50lxjFpLR/jLoxlPZK3o+w/Mlb1bRHhFhS/xgUih2c1nz0K+e+L75FoeehQ9lWSKF4QXh
	 r+FzzgGlVxYXsu7FjpjA1cB7YZv9irDIO+/qGAgQ2MCL3GHlH2L68KP/pEYhOWQ55tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047082;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=I9RXXPPfLmAMDDrKVe5I3f/coiCoVeiVET6X8fZ/MEE=;
	b=OE43n+aBwFDCVgrqyX9Ag6og0lG2/uEuhYEpluxyDrFMRzaOFU3qDsoai1WjvXcDT8CS
	 hsAUqciFauPVp2XlogCfHQP8e3QpScY8wxbV7Lw3NaB5MZw8Skf+o72Yy0qS356REAUOC
	 Tv/kHfdaTWSPBxuor8iwvV+6+v1LS5kmIM9ZfTmRib+Sp2UwWzoZ2PGa396fKpDGGHqg0
	 L1HnMu/0F5wwGJV95bRDi8iiie8z2QnPBOdojB2FsA5wB1fZiU6FnSrU2xpvChGGvav/j
	 tyt0/HhpYcka6BF6tKU2byaGwFQYVdC3H75NMRlfxNOKy8DInMashoyzBXaHrL8pGeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eWZq7Umj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A249F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eWZq7Umj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017371F0089F;
	Sat,  7 Nov 2026 10:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047082;
	bh=I9RXXPPfLmAMDDrKVe5I3f/coiCoVeiVET6X8fZ/MEE=;
	h=From:To:Cc:Subject:Date;
	b=eWZq7UmjhTrglIfs2Yl/MfAcDp9OS2xdJW4Lk5Zvh92P5Zetij7q1TbB4UARzebS2
	 MT/+luARuydw9ujqZhhq0yN7pxp6mY9v6JuRmiv2dK2y1wUdPw9/lhMRbg06f4VYam
	 L4Qk3tLVk77Hmq9elHJGOW3sk0Wezil6vCBuWQD6j+oF8bz6vm5i1xZdKY0/fe+5jZ
	 WIg0blhVlk0tA27cnrYMkmxKKlo/NmMlIpxSB6xDIh9U1XbT/S6qY0waVxYw/jz/0b
	 4iZ8Umn1fZbXkLdNo0SRKXiaCV3wRjcgQnAd81mlh1gMxOn07b6K1UBd1oH6N6W7OR
	 QYTap40StaSSA==
From: Sasha Levin <sashal@kernel.org>
To: sahaj123.sc@gmail.com,
	geert+renesas@glider.be,
	bartosz.golaszewski@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] gpio: pca953x: Preserve wakeup accounting on parent IRQ failure" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:24:40 -0500
Message-ID: <20261107052440-failed-6.12-a38bf551726a@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x a38bf551726a21c9bcc001b02164f30378b64b64
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052440-failed-6.12-a38bf551726a@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




