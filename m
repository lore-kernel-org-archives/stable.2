Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458774;
	b=1yon2jVlRk+FUfR29jq2Igsb8Fni9rXjLr9Q5k/tr8sNzDFGkvvBf7ZiIZb/U/Cm7M+H
	 51GVeTx2dqZk6FmZwchZbGBI6xOl0xsIgpR8JQL7gkjbuBpSwGp8HUWa9jyYWK6rjTV6R
	 bOpjzYKYAOcGCP57AMi+U5CpZdDPO8C9fD/ry3xxrBbd6hj8ZuSHCi51oISPhknMp24mp
	 j8sq6lzi+NILQGtYIo1YAowjjTUAb3KiPWaUBlgEeJNH4l9wDaatTXZQa91eSb9ZgvVLT
	 Z2/N4lNrAYz0M+QVAa2Ce3HvdHdjYqJtO/1JobAjQWDHsWYJI9EIdT945vKptZFNpXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458774;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=XvFGxLtguxADkoKymBc4jGtX4rfLze4pZj3zugD9AMY=;
	b=eKdY9zQN/pvodlTB3m+ssCTo2PqNb/RTOkCCNFM+RDiPDpVwU9KeU/1CpWIGRduQB8Ur
	 ejwj8/mS2hNqO5Vg40PPvnK5x4gtsdHNrPdd129L3lLP/MgvsThgGJHFQW/IrGNEMGLi9
	 FEzBkNOIFgdqf5ngnbE7KFwncIhklGdV+EJWtLa4apCP57B7Eb36edhRbLPuuUF+haI4N
	 5A8DBM5xMAbhLoLhbTN84dVxIXaKjWB/8zE88mhAPSCeynuG4aZHyZSbCVZXDnKOnzq7W
	 Hd0JeAPO87eDcHZxWCjV2WKvMlYoWr2Y+YIriPm8l+8ObIhDIgFh2GU5rhMkyUuNRNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JuN1uIXn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12D8606A327;
	Mon, 23 Nov 2026 18:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JuN1uIXn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4981F000CA;
	Mon, 23 Nov 2026 18:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795458774;
	bh=XvFGxLtguxADkoKymBc4jGtX4rfLze4pZj3zugD9AMY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JuN1uIXnBnO8/GBhDEUrU5UMuHjv6fW5KpCiabBadiozzUwU95Y12NiJkCjrqhVDj
	 j3GbqaWhJcejoIWFAdsavobczXdi4HraO85KvVoLBjI77C7SvQM9/u1InKSKZOJFR0
	 4ASQaeqzLTbQPFDe8iVkM7dHlodPJdjR19uVJiA8t7XV/nPdNLujurFqPrCWuj2E1D
	 2/JZpjSl6tHmZ9c/lDahMvGdEDJCJok3YeQnd2J2i7Oz1F3tVFzX8rsdXAtHiMiOXE
	 tj6E70ZycrLtmjqw8XinLn0WJ5gmyhX3ELi4RZ6xryEsDtuo1Q8F68LH25zq8zYKvE
	 IUcP10ygTTtpg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Carlo Caione <carlo@caione.org>,
	Hans de Goede <hansg@kernel.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 07/10] Input: axp20x-pek - skip IRQ handling during sleep without input device
Date: Mon, 23 Nov 2026 18:31:13 +0000
Message-ID: <20261123183200.3900004-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123183200.3900004-1-lee@kernel.org>
References: <20261123183200.3900004-1-lee@kernel.org>
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

On Cherry Trail systems where an ACPI GPIO button device already handles
the power button, axp20x_pek_should_register_input() returns false and
axp20x_pek_probe() skips axp20x_pek_probe_input_device().  This leaves
axp20x_pek->input NULL and both irq_dbr and irq_dbf zero-initialised.

axp20x_pek_suspend() and axp20x_pek_resume() nevertheless pass irq_dbf
and irq_dbr unconditionally to disable_irq(), enable_irq(), and their
wakeup counterparts, manipulating IRQ 0 (the legacy x86 system timer)
across suspend and resume.

Skip interrupt management in axp20x_pek_suspend() and
axp20x_pek_resume() when no input device was registered.

Fixes: 8a78050ee257 ("Input: axp20x-pek - revert "always register interrupt handlers" change")
Closes: https://sashiko.dev/#/bug/linux-5ae6851f-784e-481c-900b-2e1686578c89
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/misc/axp20x-pek.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/misc/axp20x-pek.c b/drivers/input/misc/axp20x-pek.c
index cbbc9db33ad2..a02cdabcf22b 100644
--- a/drivers/input/misc/axp20x-pek.c
+++ b/drivers/input/misc/axp20x-pek.c
@@ -329,6 +329,9 @@ static int axp20x_pek_suspend(struct device *dev)
 {
 	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
 
+	if (!axp20x_pek->input)
+		return 0;
+
 	/*
 	 * As nested threaded IRQs are not automatically disabled during
 	 * suspend, we must explicitly disable non-wakeup IRQs.
@@ -348,6 +351,9 @@ static int axp20x_pek_resume(struct device *dev)
 {
 	struct axp20x_pek *axp20x_pek = dev_get_drvdata(dev);
 
+	if (!axp20x_pek->input)
+		return 0;
+
 	if (device_may_wakeup(dev)) {
 		disable_irq_wake(axp20x_pek->irq_dbf);
 		disable_irq_wake(axp20x_pek->irq_dbr);
-- 
2.56.1.750.gf70dc682cf-goog

