Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A9C5921EC;
	Thu, 17 Sep 2026 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655296; cv=none; b=pqK6OpI3hHVjixLFYxMSyMIwC2+xvMTIpxoVwOVA5y+uxwQQnyJ2NBEQHfnZx+FAkakyv80i3oguorT6YfOdHaMrn1Rt57eJIQC2iSldfGQsM9i3a4//lSeUKL5wIZauQCSC5wsfcnFisOgQh8lBvGrVE1SMp+VQ8vFbANJiziM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655296; c=relaxed/simple;
	bh=C36nkIdIAii2ztIyD1UPt8TsxIrHC849VboK/FSWLis=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aMkERr3dIpEyX7aGZ2Hb+EpmYggz6Phv8vPZc4EnVpdrR7uMpQ/GnHApNdun51LG5DbGRehhUpYd+ulOmfsDZuqDoyBI07tLLI5vg5gUAEc7pi/xnNTvuLuf/bc+GSAAngiTh8Lex6hcALLVlrk4WXQbSUSq63qGzUKrbV6UcKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAAnlT_6+KtqOnWCCA--.4922S2;
	Thu, 17 Sep 2026 22:28:10 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: broonie@kernel.org
Cc: lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	mirq-linux@rere.qmqm.pl,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] regulator: core: Fix rdev reference leak in regulator_resolve_supply()
Date: Thu, 17 Sep 2026 14:28:10 +0000
Message-Id: <20260917142810.2156816-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAAnlT_6+KtqOnWCCA--.4922S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GFykCrykWF4ftr4fAw1kKrg_yoWDKFX_Ka
	4rA3WxC397CF4DKr1IqF4vyr9avF1jva93ur4xKFW5KrZ0kF15Xw13Jr9xAr47Xw4UCr9x
	Zw17GF48Zr13ujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbfAYjsxI4VWDJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq62Iq12xI8VA0II8E6IAqYI8I648v4I1lc7Cj
	xVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr
	1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7IU1mLvtUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgINA2qr888MtwAAsM

regulator_resolve_supply() takes a reference on the looked-up regulator
with regulator_dev_lookup(), but when the supply resolves to the
regulator itself that reference is never dropped: it leaks on the early
return and is lost as well when r is replaced with the dummy regulator.

Release the reference before handling the self-referent case.

Fixes: 4b639e254d3d ("regulator: avoid resolve_supply() infinite recursion")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/regulator/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 0ae11a521943..31893c7decd5 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2221,6 +2221,7 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	if (r == rdev) {
 		dev_err(dev, "Supply for %s (%s) resolved to itself\n",
 			rdev->desc->name, rdev->supply_name);
+		put_device(&rdev->dev);
 		if (!have_full_constraints()) {
 			ret = -EINVAL;
 			goto out;
-- 
2.34.1

