Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D501F3D0918
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691005; cv=none; b=rsO16oT2P8BDNa+tc1f7wOnQJAwZ4eNt+GApUQGy6oJkaTejrm2ap7eM0D+2vNPHTYdl1naKN1cBQwrOVdE7E568gkjUITsinbDVrUo0j3ieySMf3AYAlgAaNudcO9KZO0Z8A6/4HI1/qZ3fYuhKQU2xRXtgcEdpaV1C1W4MHsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691005; c=relaxed/simple;
	bh=LsdT55GzrGnni5tHROTuUFTGgK0O+ZZu7Oj5y1cwZ6o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NAzs220RHgRLbkbfQOqLpUftA0NkWKxuzzg+FtfcETVcoNP3KSUkwqid9OMUAoyTUinpnAjRSAYDu2ncN5Eurb1CiVOocu/8O+F/59FSgUiUyJ0pILh304jYHzvoAv9s3oiSSx1npYBEWX9wLyHvfBGRbmYOubxpRE4KrHKXw7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqD3H/T/; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqD3H/T/"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5ad4b60f6d5so237071e87.2
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781691000; x=1782295800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vGwnZNetQNHsEtMJnoWmHE73vyXkoWstMnhqfVRhjIw=;
        b=pqD3H/T//2PTz7OFi8PFn8z/JJvFqn7hbs412QerZHR2Y1PTGayfh2diWX+OoHI7yH
         7e2MTjd4EG1qL94byX1GtEMBG8vvn8sB69InZIkXjTjxYFWbtRBCGwNb93aSVMeE9ibn
         O4a++Xo/Gmbdz+BLFw6UvJcyeDoIZ140mOlhn8cZsh7LwKLBWoLzaDnzKQ5miy9bh/os
         lmtbp/oOuTUHPr03l21GYHoHE6HfgUyPlMEVjSIUKvA8R6U8ibx/Pfu40uY9Tc7A7ODM
         O5mEMvLQlUS86I0B/YW4/XaeloluL+Y5s4SHuOTe+dvkK/LhALPxzC00+UXkkTC38cqZ
         ZWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781691000; x=1782295800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vGwnZNetQNHsEtMJnoWmHE73vyXkoWstMnhqfVRhjIw=;
        b=aU+Y53OcwW+x8V6f5ygdZ63y5bCD4OZxu0RT8jQW2k/9g++aglI0EBiPL3w9dM24bs
         R9D6W9jjK8LCvm1+2nNoEwEco95NKKZB7YtCyaI4JjxBFvIPg0wTz9Rb9wTgiMFJTVtG
         DCORBQlQEKJMUgSr6IAWF6PD683x72MiqQQQyROtdo3o75RsbVlYqHnrjBXFM5QH/iM9
         Cu4oT/6CdbmDeZPbOzQXvDwUsvt1tvzTwFoksF77an8rbRqPT1AHAYLgg5EhP3OPsRop
         +Ot4sy2NWODZnuFc3R6yyjBIAmeYzIpsjE+cxDPyn0jOZ6ftlKe/R3r+IBTME7Qb2Mqd
         29HA==
X-Gm-Message-State: AOJu0YzWpjhNP1GcT3PaDeRtJHmA2pQxjI0uzbJ7sBVQ2zTXDeSLwwCd
	JQw/wblCX+G8LHe166U8G/sh14Kwg4DzIFNQvNH/FGA9HddGnElR7OsZTGHk0K36RfA=
X-Gm-Gg: AfdE7ckJ9iFwnlh5VM8pAOUxeUrOqRZym30CuNEzkSThKuPCKjyzgm3sqdo3Xmp5MLI
	uil/b7cv/1GJScUKr0y89rfukdkz/a37Lgefq+tqj1EY7ltOs2lWr+uu9rk7OKeB8X+yZ762Iil
	Z6iB6S+VwenuwC3cd3CPbzsuPg+MjBNA2jIJMU7N3qwDSQcCMPC+3LGKQx+HYD0TsgPmc2ZnH4G
	+vuCwikvhvPQI1HnjpZSeYh3hgo8yt1TLkISI/IrlxUq4GQsLOOzo8XPYpmvFeq353SLFzja0Eu
	LGptDsKx7/9TPtJ3aQCiuLcfbaaOMJelpLSU2prk8nRyyTElBlF+LlykRYS/kaXIYRz66kxV2jz
	LOl6Qu5eIyNMgry5GJ28og2dKa/eWJGM5ciApkqCvFNyFMfPg9O+u9VOl19RYlIIJ/40mRB8Nz5
	lQzDLCfk1XRcg66J9UGirJzEQ/OgK6K5cR
X-Received: by 2002:a05:6512:3e1a:b0:5ad:4c10:e990 with SMTP id 2adb3069b0e04-5ad4c202d17mr91232e87.43.1781690999742;
        Wed, 17 Jun 2026 03:09:59 -0700 (PDT)
Received: from cherrypc.astra-academy.ru ([81.9.21.4])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1a726asm4301506e87.44.2026.06.17.03.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 03:09:59 -0700 (PDT)
From: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH 5.10/5.15/6.1/6.6/6.12/6.18] regulator: core: fix locking in regulator_resolve_supply() error path
Date: Wed, 17 Jun 2026 16:10:12 +0300
Message-ID: <20260617131018.880160-1-nazarkalashnikov0@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: André Draszik <andre.draszik@linaro.org>

commit 497330b203d2c59c5ff3fa4c34d14494d7203bc3 upstream.

If late enabling of a supply regulator fails in
regulator_resolve_supply(), the code currently triggers a lockdep
warning:

    WARNING: drivers/regulator/core.c:2649 at _regulator_put+0x80/0xa0, CPU#6: kworker/u32:4/596
    ...
    Call trace:
     _regulator_put+0x80/0xa0 (P)
     regulator_resolve_supply+0x7cc/0xbe0
     regulator_register_resolve_supply+0x28/0xb8

as the regulator_list_mutex must be held when calling _regulator_put().

To solve this, simply switch to using regulator_put().

While at it, we should also make sure that no concurrent access happens
to our rdev while we clear out the supply pointer. Add appropriate
locking to ensure that.

While the code in question will be removed altogether in a follow-up
commit, I believe it is still beneficial to have this corrected before
removal for future reference.

Fixes: 36a1f1b6ddc6 ("regulator: core: Fix memory leak in regulator_resolve_supply()")
Fixes: 8e5356a73604 ("regulator: core: Clear the supply pointer if enabling fails")
Signed-off-by: André Draszik <andre.draszik@linaro.org>
Link: https://patch.msgid.link/20260109-regulators-defer-v2-2-1a25dc968e60@linaro.org
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Nazar Kalashnikov <nazarkalashnikov0@gmail.com>
---
Backport fix for CVE-2026-46252
 drivers/regulator/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 765bd1b5deb3..761a3f905859 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -2159,8 +2159,16 @@ static int regulator_resolve_supply(struct regulator_dev *rdev)
 	if (rdev->use_count) {
 		ret = regulator_enable(rdev->supply);
 		if (ret < 0) {
-			_regulator_put(rdev->supply);
+			struct regulator *supply;
+
+			regulator_lock_two(rdev, rdev->supply->rdev, &ww_ctx);
+
+			supply = rdev->supply;
 			rdev->supply = NULL;
+
+			regulator_unlock_two(rdev, supply->rdev, &ww_ctx);
+
+			regulator_put(supply);
 			goto out;
 		}
 	}
-- 
2.47.3
