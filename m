Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792585011;
	b=nGTPioEZGnCcL34sqscgeJtiU7RVHr4fJXe1I89+RCojyxnj5Sde61f41sD0tuN5bndi
	 FrS2pX9GoGvh2+Piw+mZtTxSWr3bmnOPATuRXb5kRRMPqcmDCNi5131ykTRAvOHhSDqrp
	 1yKu8xPwaS4ZmR5/Uy0qwzaa3VodMdqqMdAloN2i6/MjvfF2ScOJDXNAkWq1EvHFwUSP1
	 YN3RiynZ3ETFgq2kU+lh8kp7my6AJACKsoVlWrBlztrUHRprKIPw1+2RVJ5DrJwqb3fyO
	 uny8VgygvOCLN9owvhngQ2sPfTz7OSw3ekjA+sO1r3kAIVf2hYqKO+sDJhDoiDVE8DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792585011;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qDdj9EcXghdTHqmlPF4Y2JQuf4DTn5FtoR3j1bfxYpI=;
	b=bnR4rXT7+X2UxEPFYQazk6un1RgHhwyLpfsx/FFIMoCbWzYxYFoUJsKthcEHsmD62Bcv
	 C3K5GSBYEHkpNkSUEAOmpoJTWcmTKxrbRrx0NQJhjQiCDwjHM0ucWb9nwpvVtEfotnl1O
	 acW0B7ZFvk3xdHXDcqrgnCcgVVYG+KHPAPrzZ8uVHENNQXphB4IOI0BPkP2zyKl5JXVNO
	 QGiq9cYt7zsE9aQ6rGAwDrCJC2w4VENLAxCteNpS28eQvrUJhGZO6eXyCYa45z3v0aQxJ
	 Rds3nvzr+FPh3ceSyC/Zor0gnRr/7ICkXqQxdlcrhi57T81qUu7LvfRxJoW4pYRqMVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SEGbK0x2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B6F60A381A;
	Wed, 21 Oct 2026 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SEGbK0x2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56261F000C9;
	Wed, 21 Oct 2026 12:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792585011;
	bh=qDdj9EcXghdTHqmlPF4Y2JQuf4DTn5FtoR3j1bfxYpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SEGbK0x2M190Jkl7em3f5e6FsOIFjriiIc4I4TlIIZr9PFsuEj5ryTt9DoOm8sJFL
	 xQvmW89g0vFRd6n+yDBSPf1p2fjHPe5F7D/OWD7XPxiqwZd2W9FFwfWpSRlZf37RYG
	 srS6aJstdvljL7BzDIjAe+e83+Zxccbag2QfoVMINFcRTrQDlT8QsslAbrA7vpjCVD
	 qk0qMnyPjZCfx+K4CI27mG4g26owXn79Kpk9W/9zsnetyPwdDsZH4IuTb2n3vEFEGG
	 TpoeCwVTHWvkW8ac7hMipYe91ieIeVL/O80tadGGJaH9khVE0ojSD6+B/5EjeoKF7v
	 GJ2pvHUVrqLXQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH 26/28] mfd: mt6397: Unregister PM notifier on probe failure and unbind
Date: Wed, 21 Oct 2026 12:09:48 +0000
Message-ID: <20261021121245.3111563-26-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021121245.3111563-1-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt6397_irq_init() registers a power management notifier block embedded
in the devres-managed struct mt6397_chip via register_pm_notifier(),
but never unregisters it if mt6397_probe() later fails or when the
driver is unbound.  Once devres frees struct mt6397_chip, the dangling
notifier block corrupts the global PM notifier chain and causes a
use-after-free on subsequent suspend or resume transitions.

Check the return value of register_pm_notifier() and register a devres
action to unregister the PM notifier on probe failure or device unbind.

Fixes: 4e2e7cfec13a ("mfd: mt6397: Modify suspend/resume behavior")
Closes: https://sashiko.dev/#/bug/linux-edb62fbc-213a-49a2-be55-c002e234e554
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/mt6397-irq.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/mt6397-irq.c b/drivers/mfd/mt6397-irq.c
index 58645dbd8095..bc7ca22d6f17 100644
--- a/drivers/mfd/mt6397-irq.c
+++ b/drivers/mfd/mt6397-irq.c
@@ -179,6 +179,13 @@ static void mt6397_irq_domain_remove(void *data)
 	irq_domain_remove(chip->irq_domain);
 }
 
+static void mt6397_unregister_pm_notifier(void *data)
+{
+	struct mt6397_chip *chip = data;
+
+	unregister_pm_notifier(&chip->pm_nb);
+}
+
 int mt6397_irq_init(struct mt6397_chip *chip)
 {
 	int ret;
@@ -247,6 +254,10 @@ int mt6397_irq_init(struct mt6397_chip *chip)
 		return ret;
 	}
 
-	register_pm_notifier(&chip->pm_nb);
-	return 0;
+	ret = register_pm_notifier(&chip->pm_nb);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(chip->dev,
+					mt6397_unregister_pm_notifier, chip);
 }
-- 
2.56.0.218.g1ec904b173-goog

