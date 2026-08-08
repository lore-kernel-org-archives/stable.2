Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C3D2D1F44
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 08:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786179576; cv=none; b=CFjIQnO11mRWA+UMPcWaKm8aN9w2uPqwRmBh+ZfNBU53bfrabk2v4k/LFt3NYbhDxE/GBsW3oU+ICZ9X+whyNFYQnGKSF2G4O9tgfxO1C5U9ClogEpZmXpGIzaNVhYIBGb9JBHyF4oh1jUyulm8G4Yo4QMBxSXIJ5oaKKtWZ79U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786179576; c=relaxed/simple;
	bh=k1jte4S6kmlNkWiF/TPSrh2PJp0JqoJa7csBL3XZxhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYs87s8uvKd8/Oz0qHQ4BDBFVcwoCbAlgXMFfcssuF828ewhaFXQnYmuJQBgEGPQ6UxoCEFkgwN2IrdoLotmu8CBLvnwTUZgyeDLgfrnv6rbCpGaQjD51xHWB2gl+zYFiqVfo1WvUtE/miWZ7V5LiEtW9KE2yWCAEvMJT3aeyf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wrg8I+gV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wrg8I+gV"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2ce7d2adef4so5234905ad.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 01:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786179574; x=1786784374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=n/y7c/4lG8eevhNAw7vtPbWQQOLv7HTFTCbAr3jVwm4=;
        b=Wrg8I+gVL904edaMJxaKH+QL32pIWXbPwVMQNuYbQAVrI+fUEMsA7YjnudjQpfuWBu
         xvu3zpDZd0AY5HlP1KXvNloa0/e7Onod+QBQNTRIABUdA720QyRkHn0W6E3H7Uqmo55O
         gIsekM4GFMWJpig09+r1EvrmrOcD2ecqp/Qc2nx/CX2bmYM9Z4YK6gjkp2odap6Waq+9
         LaGckMALUOXNwRpFWF6TfDwzi0MqNmRSEpkoWUM03uYrXOcfoB++TOROWNKpArP6Wx32
         DafC1DNBSbO+AgX5VrZWoGtE5MMTjZKsXqS0zEtPVkrFi06DxNS2LU8R2/yQ0vlOc/x4
         oYPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786179574; x=1786784374;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n/y7c/4lG8eevhNAw7vtPbWQQOLv7HTFTCbAr3jVwm4=;
        b=s8BfbhlkEXhG0MjtCQl8gs9jnqLCv4NFGzXpEbxa1Eu1XUoWqt2JqX3xagQdWrY07x
         eKZCbGpUyDvnKh3wnUlE/B8OAAmN+wWXZGlwBJJj5i2IjbVLeGYCei0XomWaClOhbNd2
         5/0cRfIru1DQGeZVMdKeGywcRiqEpAFb6mqe1zZV14aiEt+kV/j0og3J+nhspytXQcTD
         4j/8EhDgtOfnPPOp6hZY7PlKJad/C2/axz/DB5wCch5pbRi1iJzH5iHUl5MFycrUOvNE
         ejbRUHcPQO1h/T5sY/a9pOVfp2knxgR8mEfmXUyy4ZXr1z3ZjULwZkOMkMj6SA6TkkJe
         CY4g==
X-Gm-Message-State: AOJu0YzeMK7pNO3o1QFE9KFIQ9MBN3EwPBJBw6Lp0D0S/S+DURNDf87K
	sil5YuzgGQ+sdKmLpiRQYkyLN43QG4i8RAwQCzeX+woGAnj00YoURs5b
X-Gm-Gg: AR+sD105bxcSqF3x4gW/hz3gq1uBUDgsbkXqG9CoCL43+RGSvsl4B4C9NrCIGgY+5Qe
	sq8GNMhFxjYlYWDnf/vz0OYYhV1XMpzbykRlaoNe7ZYDVeM8AwnCQyiRm5DYYBrWY0q/Dn3dABr
	5uGWBMTeFXu2ZXDF4LE8wMzuSQLx3L+gdcwAodsoJ0wQ1OpdL32jQeSw3ATN9XYNejWLuJLKkW1
	MtQvmaL951bHVGcWXm0cBzcp27v46utngFEP4cJIxdFNu0qfveHqG5altJ/OzNqClFDA8Xhtmwr
	tEp8gGwkgeUMdfstOPGeYJWGdGV+ZZlyHxPfXZWfznmJxbSOxaisK4ppkaQTvQp31AZZ41ZUEVf
	5ePDheQ398n93NVveVXC3R49MUqwY9Fgfq6y4+H40EVBjHOLAX0uqDD52UsNL/l4GiBcf/TPCoV
	tDpD+VCxi71Tg88TUQzK6abko1S+DjgY9BQ+0awMTbYpg=
X-Received: by 2002:a17:903:37cd:b0:2ca:d9b3:715e with SMTP id d9443c01a7336-2d294b4b5b1mr126407935ad.9.1786179574331;
        Sat, 08 Aug 2026 01:59:34 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4a6db2sm17431155ad.64.2026.08.08.01.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 01:59:33 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Maxime Ripard <mripard@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] crypto: sun4i-ss: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 16:53:37 +0800
Message-ID: <20260808085337.2715506-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun4i_ss_pm_init() calls pm_runtime_use_autosuspend(), but the
autosuspend setting is not undone if pm_runtime_set_suspended() fails
or when runtime PM is later torn down by sun4i_ss_pm_exit().

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during cleanup, this reference is not dropped and usage_count remains
unbalanced.

Undo the autosuspend setting when pm_runtime_set_suspended() fails and
in sun4i_ss_pm_exit() before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: 554c42b4efd4 ("crypto: sun4i-ss - enable pm_runtime")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
index 35ef0930e77f..10c0f05994ed 100644
--- a/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
+++ b/drivers/crypto/allwinner/sun4i-ss/sun4i-ss-core.c
@@ -304,14 +304,17 @@ static int sun4i_ss_pm_init(struct sun4i_ss_ctx *ss)
 	pm_runtime_set_autosuspend_delay(ss->dev, 2000);
 
 	err = pm_runtime_set_suspended(ss->dev);
-	if (err)
+	if (err) {
+		pm_runtime_dont_use_autosuspend(ss->dev);
 		return err;
+	}
 	pm_runtime_enable(ss->dev);
 	return err;
 }
 
 static void sun4i_ss_pm_exit(struct sun4i_ss_ctx *ss)
 {
+	pm_runtime_dont_use_autosuspend(ss->dev);
 	pm_runtime_disable(ss->dev);
 }
 
-- 
2.43.0

