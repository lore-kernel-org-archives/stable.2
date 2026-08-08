Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CCC380FCE
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786179695; cv=none; b=qXvJwcPkI+9GYTR9ga5ony7m2Xr37hTDRDPvmmxF6/7043FU1E5/l/p0FByE+TL3LKIySKi1e4LdtlR0nju7GNpHIqaQyxzchT8YYhUHEQV+O8VEix/thOq1pXFn1DOBrV3tOd/WXalVKpHKl6k9mgV0cVtGFpUCwV34eXTKQqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786179695; c=relaxed/simple;
	bh=k2o7RLdEaMQf8liSnLShdk2zw3dk1hd297iCbzakkMc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V0enV5p+v6o23QOgJ/oyRBQ5aEvByy9Ah0/LeACvaxmjzzGH8z8gBvXcapZ+McqT832sipE1FmneOHMMffjYh5SU082ZwH8k0tl4tEc9FvhB26OPjbdnCtgC+VSX5vvRtVUxdaCXH/4Tou+vKFNvJcu8BS4IlxxdD0YStMXfG1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aODdhckz; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aODdhckz"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so183580a91.0
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786179693; x=1786784493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z8XEbNxmFITtGAeV3qoLd7HeCqmH9Ffgh8sG2RD/33I=;
        b=aODdhckzHMdGqUfPAE2aJFy2fKfRkVRAZlfgKQ1rZTC+vvDnORdhAc26Y8gylCV/Xh
         KZs8MkRWpCHl++ceU7kBkmAeScqg37XSlEB611yunwH0OLNcd+8jEHnfBkIjdZxqdq06
         ins7RvizitqNGRFU8vXvMeOxPe0ZCpsx+ExWKlnVKCWjNSquHNFDgcu4Zt+230dBOA3M
         LIJ1U9reE03bXFIQKSgzDTBCQHSE0gxro9fYnUa4ck0TK6ofwPY7lgazcVHyXc7sPoqi
         aYZM6LqJ/eyQ8Adcmu6auSdC3I9Am3O/EYLIan8kKhkNdyHODJYodiI+9VVCf+OSGF1I
         LGvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786179693; x=1786784493;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z8XEbNxmFITtGAeV3qoLd7HeCqmH9Ffgh8sG2RD/33I=;
        b=CX3BoH4fiUWlPDeBUEFd0SStLJuMIG9aCQ8pVtS5vvCc88V5wvPWBfhtEqLa0xzdtg
         vCrIfSbShytqTXUrOxbaORSOJO8aI4pwgv8qaOZTa9O9ZJkKrGhv1uj4UAQ8ihqD1V5A
         bHyXB3aXzh+o9O585K2640KHvPP8KQEKmprxBLnk3I7nqXyT5h/MUNlsp1isfNU9FzFt
         RQbGS7+9nU6ber5MbUen7Dug40mYyf/sSPu8/X4J5HqnEjEJlqbMlaPg5tP+liAbweyp
         yrYtWvnaxUHVklfYvmXy4lMGOFD/q4SWqo2lZgr4wwPy9uz8JU01/hXwaygeMlCbFZYM
         Kd3w==
X-Gm-Message-State: AOJu0YzVYvxPQzBhbddldWFbGTv0wPODKr3z02IgS+/gkmzG/C2ll/TT
	c9Nu/iM1yBvaxLoukUwWv1lNj6T2LbWcPOT4d+cZbCQ1rpO7cHVt7oH/
X-Gm-Gg: AR+sD10h7vd7RFhERC9ENqNXHNbb47ZPhWpq4oZk5vSfPWxkwn9mvwXqyXwr9OOcwgO
	2bDOmPwdrWkaBSs0poPLMCwoCB/vxyUy40T/GmYzJWzm0cXw8HknYm+tihEPIcYef12fC73cESH
	ppLV/jXS+46ScHNq8JgOKGKy8HC4M92TmcQp95o2g+mippkrM/lyMdbwpk1lfIAC71O8TcLhkVG
	KZfKvx5NVKBs2AhhHb5lqrl3jDfEtWDqENEW1mseqkHsKhSr6nbgIqL+z8yaq3pmFE0MO+rgcjf
	/sWby1ZDE5Y3N/sf57exPOga3uZDV/vFroHICYbMX7izkFjUH7FNiLM3Yv6V72iUKLxgwR7rYOj
	8bf6oMJbhQXoHgC2djsejUNzcSb7+yeQ21SgkWeyYXDKmuCUFnbC2+X7WAqVJegEUTAGZfNB69A
	k/OQaaX4Gv8Uln++qsThZLTiFp0zHqabXsogAtfZpMS3r2teuQh+V1KvVvnmyTvpOm/uH6
X-Received: by 2002:a17:90b:582e:b0:38e:485c:ebd3 with SMTP id 98e67ed59e1d1-392823d97aamr5991393a91.15.1786179692981;
        Sat, 08 Aug 2026 02:01:32 -0700 (PDT)
Received: from lgs.. ([101.76.249.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925ff24b91sm5349083a91.9.2026.08.08.02.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 02:01:32 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Corentin Labbe <clabbe.montjoie@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] crypto: sun8i-ss: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 17:01:21 +0800
Message-ID: <20260808090121.2718855-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sun8i_ss_pm_init() calls pm_runtime_use_autosuspend(), but the
autosuspend setting is not undone if pm_runtime_set_suspended() fails
or when runtime PM is later torn down by sun8i_ss_pm_exit().

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during cleanup, this reference is not dropped and usage_count remains
unbalanced.

Undo the autosuspend setting when pm_runtime_set_suspended() fails and
in sun8i_ss_pm_exit() before disabling runtime PM.

This issue was found by manual code inspection.

Fixes: f08fcced6d00 ("crypto: allwinner - Add sun8i-ss cryptographic offloader")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 59c9bc45ec0f..775355ac9f9e 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -664,14 +664,18 @@ static int sun8i_ss_pm_init(struct sun8i_ss_dev *ss)
 	pm_runtime_set_autosuspend_delay(ss->dev, 2000);
 
 	err = pm_runtime_set_suspended(ss->dev);
-	if (err)
+	if (err) {
+		pm_runtime_dont_use_autosuspend(ss->dev);
 		return err;
+	}
+
 	pm_runtime_enable(ss->dev);
 	return err;
 }
 
 static void sun8i_ss_pm_exit(struct sun8i_ss_dev *ss)
 {
+	pm_runtime_dont_use_autosuspend(ss->dev);
 	pm_runtime_disable(ss->dev);
 }
 
-- 
2.43.0

