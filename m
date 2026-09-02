Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3E8258EE9
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 08:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788338693; cv=none; b=n+JdmiNJlP8d7RtAcemSkAxXHnEmDBZivQlwPwBCgk+8g6XeyLPTqQNVcQwgIZvwJQ0MQIfA9sv6XVCNOz84Z41UauK/4EW2iWHu3JgTTdvQQclyaIBpY1B9uXEmrtBI8XLqsxrPbQxtz7sjbPe2vxc1IxjLdPWkINPojIIgKiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788338693; c=relaxed/simple;
	bh=W9gAYG0X9XJxEJUSM37YRKmyz4ctudzKtZ3GvTGFjQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VZustvDAFX+k+hbume/CNGHx2Fl/DWWiYxu4LHbmA9xBQL0k5FI8g3CBirxsa8s4aMMNY3pDesxxOS0rTtFqnaTC/5AUGl+oOrklddKg+1RwfrVo7VxcX7f0XptwF6YTlg3FmmcqriupDteus5l04lc8WsIF8KaqDtJGIBGzJc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0l1jqUv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0l1jqUv"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8487214ad2bso1172010b3a.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 01:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788338687; x=1788943487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uexc1NDi5NdMn1KWK0fKne2QitDNcH/zJBrubqnXvz0=;
        b=m0l1jqUv1IPswz77SST8oCqywRkd/wNCYOxbmeEW9vtCDGHxvqEGd45S/K7T11kZiW
         S9OSrSx4z+CPZleoo/hxOzDqvqLHVRux+cCZu+sF1fD2azNLQPVV7UFltBXP6SrB2H96
         TgrDHzNy+9vUbqxROvIxJneftfVvO1aW01t5NKNjei4UugAzAezhssHY+uIpgp/FHUH2
         TSiYs8FPk+rb6b+rrmckeePdsXAqPOcLLg9mKGMo2lhIkwLFBb4pwPH91ykAZTsM01Sr
         bP3O24dNyMYoHO65x4l78bz5fZGWwRbdNfGmZGdEp+90SaRvRogmhzW4kHzn9cW2AZfY
         qX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788338687; x=1788943487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uexc1NDi5NdMn1KWK0fKne2QitDNcH/zJBrubqnXvz0=;
        b=qz3AZVwI2EHsdH/WUuFP82XC9jJ4PJzY7JHTt9HRztbVgKU0GDsf1W2m/UaCab+dby
         RV4jmUD9r1VxB9M9mp2vjJ1QKtSglYyUuuHCCLq5wOdAULodXMTEERftpr7ng8CTiwqU
         A5/xY6t0Pg23t62/8RBy8oln13vm/wlOku7zPI8kF5agRA+ShNTqGV+dliWte14G9037
         xc9DGVUtEkQLxKEQHBhRufaF0IHOFFM5q5Gmk/N63uptKJgzZLE6MrB9JnLiBLPjWSQ2
         +2xfKN02AB6459SaNtllfd1dtZXIrFahefmGWrDpGG6KkOz9hvRfbRHX2clMF8CUbmbM
         4d9A==
X-Forwarded-Encrypted: i=1; AKwUvByVYzo09nG/rXWw5zlQaivkc+TvGg/7dmc5VIPSpWgppIq8tjvazL2kYkedt/gOLZypUD90rW4=@vger.kernel.org
X-Gm-Message-State: AFuF++mt4/elUH7BI5Rr2JC3J5Tcusr/Vt1xQLe0/PRMgZ0CkiBEpPu+
	P8t/tLShvSVuN7nkAozg4MwEGY+11OFSBxvl0EsXyG0btH17zE0k08PO
X-Gm-Gg: AYBFou0FQoBcBrE0nwe/W7SHb2l6UkDyVPJPY4U+i7ChFQEwTTV7TkyJ3JOqh8x9bLs
	/EE2YeexsGI/exxKJp6r0GR65yhPQ0/A26Dozi5v5wxmOAPabogAZnSUc0mf+h/JvFneslt+xi2
	Ntcq4ZdpO6LpaWJNHlp0+B1aqHQ9VigG+MiJikJM3K6rteuqmiXi4y6cK2Gv8ZYsuMQ5gBlOAJ0
	/qoxgzYPt85niIP4oYfwfqW/cRTb+uuHer6Dq75JO3esULF7cNFvkkeXH/atAptS+NT9OPS5Wmi
	hndMpDl4CMNKFuIJV+FSD5iPZcxhUyRYGvSghA3400GQTNIXi/yczISE5fXedeVqXMv+1fKdp1J
	WpPsJM1hsqLpFjC9BsNcdhnj67rvOKSKn6oyNETYlMhHH+muMPj0PqUCkjm64IpF5/lVpQk4rrq
	tY3oFosl7uZmUUqPSQGR9wiEn7oer8IwyIye0fcKYMQ1U+CPp1Uuy34Y1OBzJHDgbUWXENxR00y
	LdQKYSpxd5WZFBr
X-Received: by 2002:a05:6a00:124b:b0:857:726d:2709 with SMTP id d2e1a72fcca58-85ed3f6e6e8mr5014011b3a.21.1788338686927;
        Wed, 02 Sep 2026 01:44:46 -0700 (PDT)
Received: from celestia.taila51cc2.ts.net ([2402:1980:9c5:2de5:8b4e:3f3c:b637:4ca5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-85db29deb9fsm1047430b3a.16.2026.09.02.01.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 01:44:46 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Wed,  2 Sep 2026 16:44:45 +0800
Message-ID: <20260902084445.27170-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When setting goal_tuner to 'temporal', if the goal is achieved,
quota->esz_bp will be set to zero.  In this case, damos_quota_is_full()
will always return true, even if no regions have been tried to apply at
all.  This causes qt_exceeds to increase unexpectedly.

Fix it by:

- Returning false in damos_quota_is_full() when quota->charged_sz is
  zero.
- Adding an early exit in damon_do_apply_schemes() for schemes with zero
  esz.

Fixes: c7ec7d5f6b3d ("mm/damon/core: handle <min_region_sz remaining quota as empty")
Cc: <stable@vger.kernel.org> # v7.2.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---

Changes from v2:
- v2: https://lore.kernel.org/damon/20260902081825.18931-1-aethernet65535@gmail.com
- Changed patch title, v2 title is truncated.

Changes from v1:
- v1: https://lore.kernel.org/damon/20260901105925.106186-1-aethernet65535@gmail.com
- Changed the check in damos_quota_is_full() from '!quota->esz' to
  '!quota->charged_sz', because the former is an upper bound, while the
  latter represents the actual quota usage.
- Added an early exit in damon_do_apply_schemes() to prevent a scheme
  with zero esz from being evaluated by damos_quota_is_full().
- Changed patch title, original title: always return false when esz is
  zero

---
 mm/damon/core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 8e3ded1a2cf6..de78ad56c8b3 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2560,6 +2560,8 @@ static bool damos_quota_is_full(struct damos_quota *quota,
 {
 	if (!damos_quota_is_set(quota))
 		return false;
+	if (!quota->charged_sz)
+		return false;
 	if (quota->charged_sz >= quota->esz)
 		return true;
 	/*
@@ -2666,6 +2668,9 @@ static void damon_do_apply_schemes(struct damon_ctx *c,
 		if (!s->wmarks.activated)
 			continue;
 
+		if (!quota->esz)
+			continue;
+
 		/* Check the quota */
 		if (damos_quota_is_full(quota, c->min_region_sz))
 			continue;
-- 
2.55.0

