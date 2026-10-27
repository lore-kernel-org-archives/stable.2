Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793097533;
	b=cafxVkLpi9wUm9emZdTuhTJFU1ScHB7atzUQ7GT21HXCS1MEZhZWFxoxU6vqPpT4H2XX
	 qf7Ilik3qyqXD7yAozYEH0SLQPkhfIKrPh9OSDubGHEAZjpPcTP0Uy/yBzj4/4rrUfP/P
	 d+aj2i9PLV1kQK/oUGDrKoPeIMpbB8W4pdenxrAmTM0FV3BBCc9t3JY5TBZUpe6pq7fTr
	 NrZ+cR3YRZV30DjGK5ngdHXJ20xPUfUXVriw75ZBH0NUE4LrZuo6YmcDwmRpkPdgJ3ptm
	 VFkd2PdnxVUW+u/G0NaV/yaXogH2rk2nWgmscR9qqAu1bJjiXZdSvIdJkyf9OGfMBeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097533;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=f117Q560NSjBr6anMxMv/fimQdDJKi1k4+mVt+CX9eI=;
	b=CrMMd7iVONzO9jcqUXPJS3NLrPtBZZn8tyCC2eyqtVYn2W3HqvhvyHo3KNTCyzbJla33
	 S1v/Vw4XUbi3U7WnCTlpOF/3RP4KKsatDevIONIjH5m6w+j28jHajymP7vHO38eYLM87E
	 9AmMnVudQppiBqWB2AA0gnLJidzLMtzzPQvpjWRi7XXavWHk0w1VFCo9UE+8zxVd8WO1G
	 Ao+oOhXtrfu4drbPXdf9YWUu0SdIyzcY48fFKONAL9vMCXmyArwZ6cvMfUxvkk2DD7+pz
	 HpvaJPrHQpn1LJQVM/+MdeezS3wGCILqcpW5sk4sMx0pov1OHEPy6pb2NUeCWaEM6hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijEVgSdB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D528606A31A;
	Tue, 27 Oct 2026 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijEVgSdB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C25F1F01825;
	Tue, 27 Oct 2026 10:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097532;
	bh=f117Q560NSjBr6anMxMv/fimQdDJKi1k4+mVt+CX9eI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ijEVgSdBPn2SY+nPgA3zsOTgz/3fSL2gxTh77xNIRsI0zEhHQAtGzO4DwTSq8Yihh
	 jFHGw8R2OnnPntv5C2P0PkaKWEpahjIfQaVRHayKivWMCn6OsYp6Xg35ZosFPzpK28
	 Ft0Hni74Pe/83iG0748ozTgPue6rUpYrxb4uZr1xv3RsiODZqnv6Pg+/PVvklplZ5N
	 m7v4C8EgWWKSl5SJjMylXyPIo4iEOWH673ZHJXSTi8Myhn9AS9lndyTlkN4+hJa00V
	 RnmGBw8EFRJjOtnagLVFjg/2P7VXfcLBlfBUmccuz6eyxdtlvHQP62A2UsSkvffdYy
	 /p3RuMcvaRmaQ==
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
Subject: [PATCH v2 25/27] mfd: mt6397: Unregister PM notifier on probe failure and unbind
Date: Tue, 27 Oct 2026 09:30:54 +0000
Message-ID: <20261027093306.2812695-26-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.307.g5fe7bd680c-goog
In-Reply-To: <20261027093306.2812695-1-lee@kernel.org>
References: <20261027093306.2812695-1-lee@kernel.org>
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
2.56.0.307.g5fe7bd680c-goog

