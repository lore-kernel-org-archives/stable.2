Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048733;
	b=CpizZcRX/atZPePPFHJtXZvyKSISjmUDPWHe1JitDPJJ1c0o6zkbK9eV3T4OykUJQQJ+
	 LKoZ6WUbWeo5jlGSa+1y3hbVCKr2iirj9nPiGcPeNG3RsOSseAT1q4JAyqtSNVkWzoeER
	 OWdx+O21QHAXbhj8SS+3F4gH1aOwa1RbmZgCBZO2qE5Dl9yKj1oQpvhNK1kNJDHUWI71x
	 9LkMhTUqjcXpAR0tJMSQO/9yUoBjlC2ojpvM150QkoXRpa9FeUZqBynUN8Iw43iYuhLBR
	 QcpolnZYHe9RS/sVC3h5TeMpbbV+qfz0SMME47nnlFDxaHB5VcgI7DSLGkJUxixgJNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048733;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=wRC1CKFc7vhanJOnrzgen6/19AUQMFxk6/NIaHl4K1w=;
	b=EH8H97kjAHnRR7s8ma94YQIZYmLwexK5Y5mEzehFXgR5VDQlnI9Fxwx1b5n9gF6wdAZl
	 CLbWiItmXMJclsIPIl/uqR7lqIjDabU0k0uP8sJI1aC4SZw7ylUJMqL+Xy1wkrb6+ZOpa
	 08wd+KFuf6+qtGKzgE1goLTcDNBUncSbDxpYVhUKJCyLJmNogJPaQBOjykuzIWeB8p32p
	 av651kVAKjRr7NPr58eKHK6Fjl/rjajwc8Uy/31vcZp7uplJ7eKCK/shUdWjhYzU5tah+
	 ZpwFkldCWFkzGu+JEKEy1n4BhSbYC0GxL5wO86w7fUdG3CsUxvkeMyyAmHo1Cfynuyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="nbkE/ict";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0799606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nbkE/ict
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461141F0089F;
	Sat,  7 Nov 2026 10:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048732;
	bh=wRC1CKFc7vhanJOnrzgen6/19AUQMFxk6/NIaHl4K1w=;
	h=From:To:Cc:Subject:Date;
	b=nbkE/ictbYhLfHAqO29lryTxNEnieza3UZf9zTs85fon8FEjm8p1pIsmF4xKmcnkB
	 WvzWk0l0gPd2NwBNX2Lo+8afBXtFZJlN6Ue+zr6ym4tJqCCZyimYZDSrtsaQXhb9Ag
	 PFtU34HBDbLHRq0vkHf6asBTfSLdHh8+kCwAQkhHBvVYt/EKyrcYOUIQ/7bpYUvo1r
	 8q6ETLK0rZBEBJXNxL23CE/V53oB8e22Ia1l77drCp9b4EgeVE4gzTEYrVNoA9JzB7
	 RddXcVkg05LdyDquQQDOTCH76WBrPrE891cmya8jXJvTeETyYO8F3HrikiaYCTLOWB
	 M0nM3o4k9aPmg==
From: Sasha Levin <sashal@kernel.org>
To: sahaj123.sc@gmail.com,
	geert+renesas@glider.be,
	bartosz.golaszewski@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] gpio: pca953x: Preserve wakeup accounting on parent IRQ failure" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:52:10 -0500
Message-ID: <20261107055210-failed-6.1-a38bf551726a@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a38bf551726a21c9bcc001b02164f30378b64b64
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055210-failed-6.1-a38bf551726a@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




