Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FDD3D3001
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 06:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782453682; cv=none; b=SbTjHP97rNWgpwlgel7kLZkfRrUUoc8F+C81BBwKgZ79GADADUOqSDi5jxV9gYX31lOcy38cNMyBtdMU1EJ500LB4D5fDBqP3gip9uDGxTbtr/phDba8BuTK7BdMBR4csX/6eZQXRZpInPmxb7lb+7OrkxHVY7WuRgsf4ZeS3WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782453682; c=relaxed/simple;
	bh=7L0JJKkBkRDuegs9xTZqxl2sH5BEOplN9Sw0ybDh2QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2IILFT/xpCszFYX/CXoLth8OFiydCHssEVogp+mT9SSVpoTivBlKOaqIzAVA1fOgTnUpScJLAk1SNtGK1IRn5uKMdG/4FPzg3RfOTbNZ1Yk5i46gmONPi0YymNscqo/kP7UFJ7gauRZXhXqaK54lcBY5CHZnCF/pG6YWhqV4aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Agc00TWD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Agc00TWD"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4626fdc829aso284130f8f.3
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 23:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782453679; x=1783058479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/IdsNMSUNjjiL5bhyJQItc/JX8qMKncxtCJvcADiPv4=;
        b=Agc00TWDbqUWZek+FeRAGCjt3bMdh7HdS4clsMhVMEO+ZqsQ0GD+YOAKKZBI3rFCDj
         A3vZO8QtXTN9R3NlpDkuoJopTfnIouaAFsSoeO6twVFqq62DL4BB5zRS5rkNFSsEK5Xc
         I98W+0TYPVvYH9jOEnbemr8Fmfld0uNInB6Fn3McgqC9g6/NAjTqyiQdgyXUqeDnF2XK
         vcpw+Rz0OSwkWfyuiO+Y5+518ZKeYK9Fmv2gztlokcWcElJiPHPjwAS5+fCQPDxAS2RE
         bvGrtriKc6BDA53HlvxsRYB2j8zqcPwh0uFR3y0IwQGUSCbZHpR1PfmQF2UN4QthmMoH
         akyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782453679; x=1783058479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/IdsNMSUNjjiL5bhyJQItc/JX8qMKncxtCJvcADiPv4=;
        b=aQwHgN3MjtGZ7No3shZJ10ltCx5u4XgqBWqyQsjTgB4Dl7AzyXdfFuCOLwAcmrzXBL
         f88mHZsVu17muao7f7JExkGtyWpXcF6mX+5w0X6x7WLK2yMs+qssrccpRR/gyFYd0iPR
         1/aa9kOhlde+QXepRbxrTZLkqDK+gx8ZQLJ4ofpToQh+FSVv4WLMhYAMBGQLawoG33NF
         0XDpTO0rYqJ/5YomBof3uJqo26eQoqHp+gITwa135BH7ztm+tziDf7hUK3YzJ50nV0ds
         7RC5oLsTM29ec/s0dPwAcMNQRUPhg9pBqkmP6SqLxLKm8jkoEqAs9iyweB6kmpzFSgyR
         jf7A==
X-Forwarded-Encrypted: i=1; AHgh+Rp1pqLKFhG+rFTia2LsOd3jPWPDXn/40jIK6J9WXTpV4HBNa2i5XD6Boqu34fvTVN8ky9C5+9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaKoy1XpmQBvgRVAgt4J3sirx5H0yhK3uN3iW0rC/Sj1M0vCbN
	USow4GlQuZ+Fz/tp+bSmj10UMm19ZF20UWETic84VCCC52N+ttytpU8L
X-Gm-Gg: AfdE7ckPkZ7ENRfzl15lTGO70XLRXVg6z3/eGQqpePsqR2GcNs0jYw8WaM05ikg5/cI
	S+ATS9wLIe05vLkgI1a+5D8chfAbqcJGPZx66t0fSovcn5LOGhbIhaMmkH26vBODkYYsowKkuVQ
	5UzJ9fbUKhiN3+sK2sckbGM8KOtqNihrPcWEP43EkuIxe0oRYlmkWPa3os5GYyHanMP3UlznHwF
	0UfVWKT+BOE5tgoCF16EcaHVXit6HvKnB8Q98lfguSULiP/RqAJwBXr98r314GYmcM6QOKBvtLF
	HO7XwU4fUSm+4JH1KE/8vJo8PDCAmVvR6eLz4J16tKhXdhX/56svymD4Hjqi1nnUcmvI0v+iXlB
	XW1jTJv3fJ4TbBnxZ0O76W3ON6XxmlM7XQ7/lXnNBu18RGRLezLR6YjZSHOIc0rEObEo8sT4O+u
	lI1A3dlFa46C0oZu1g/g3HjZQfv0koybGqgwPWftXCcL0UVhHDvCHnlTqfHog=
X-Received: by 2002:a05:6000:2581:b0:46e:7a27:98cf with SMTP id ffacd0b85a97d-46e7a279bc8mr5287263f8f.25.1782453679003;
        Thu, 25 Jun 2026 23:01:19 -0700 (PDT)
Received: from camaron.. (147.red-88-9-50.dynamicip.rima-tde.net. [88.9.50.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46f0db007b3sm2767936f8f.2.2026.06.25.23.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:01:18 -0700 (PDT)
From: Sergio Paracuellos <sergio.paracuellos@gmail.com>
To: linux-gpio@vger.kernel.org
Cc: linusw@kernel.org,
	brgl@kernel.org,
	vicencb@gmail.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 2/4] gpio: mt7621: more robust management of IRQ domain teardown
Date: Fri, 26 Jun 2026 08:01:10 +0200
Message-ID: <20260626060112.2498324-3-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626060112.2498324-1-sergio.paracuellos@gmail.com>
References: <20260626060112.2498324-1-sergio.paracuellos@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver uses devm_gpiochip_add_data() to register the GPIO chips which
means the devres subsystem will unregister them only after the function
'mt7621_gpio_remove()' returns. During the window between domain destruction
and devres unregistering the GPIO chips, the chips are still fully active.
If a consumer or userspace invokes gpiod_to_irq() during this window,
'mt7621_gpio_to_irq()' can dereference the already-freed irq domain pointer.
Thus, manage the IRQ domain teardown using 'devm_add_action_or_reset()' to
guarantee it is destroyed strictly after the GPIO chips are removed.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: a46f2e5720f5 ("gpio: mt7621: fix interrupt banks mapping on gpio chips")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 drivers/gpio/gpio-mt7621.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-mt7621.c b/drivers/gpio/gpio-mt7621.c
index ceb99641baee..57384ef74703 100644
--- a/drivers/gpio/gpio-mt7621.c
+++ b/drivers/gpio/gpio-mt7621.c
@@ -272,9 +272,9 @@ static const struct irq_chip mt7621_irq_chip = {
 };
 
 static void
-mt7621_gpio_remove(struct platform_device *pdev)
+mt7621_gpio_remove(void *data)
 {
-	struct mtk *priv = platform_get_drvdata(pdev);
+	struct mtk *priv = data;
 	int offset, virq;
 
 	if (priv->gpio_irq > 0)
@@ -475,14 +475,14 @@ mediatek_gpio_probe(struct platform_device *pdev)
 	if (mtk->gpio_irq > 0) {
 		ret = mt7621_gpio_irq_setup(pdev, mtk);
 		if (ret)
-			goto fail;
+			return ret;
 	}
 
-	return 0;
+	ret = devm_add_action_or_reset(dev, mt7621_gpio_remove, mtk);
+	if (ret)
+		return ret;
 
-fail:
-	mt7621_gpio_remove(pdev);
-	return ret;
+	return 0;
 }
 
 static const struct of_device_id mediatek_gpio_match[] = {
@@ -493,7 +493,6 @@ MODULE_DEVICE_TABLE(of, mediatek_gpio_match);
 
 static struct platform_driver mediatek_gpio_driver = {
 	.probe = mediatek_gpio_probe,
-	.remove = mt7621_gpio_remove,
 	.driver = {
 		.name = "mt7621_gpio",
 		.of_match_table = mediatek_gpio_match,
-- 
2.43.0

