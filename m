Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39DC3AFD0C
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 17:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137403; cv=none; b=S8Fah5Gqqdf7djagSHdZ5XpgJpVPq2mQWDsI/j69wm8PzUKEAZUjK4y/kZMuOgg3pPihXjWJdk7WwpTnJKeBTohtrPWJVTvgvI4vQ4hjDs2gQGHrdt0KZX9dxnoRk2uihRWezALkhA0snCxmALInVhojRYWUBSZOiSz6ycHPQS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137403; c=relaxed/simple;
	bh=yfpLtXbd12CAgBQljtOJxL14HOrrTCHBVY/qg/gGY+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nQqfeH8tJQebucLCuUxaVNN5+8paTd9OpMjW98zlnE36/lndCdvBI+d5bA5WqtWuwEVCP0JUeTL08+9Tv7uDYWMirywYJbc+OLg/nKUI2LMKSFlNDERV09+18CFTiCdKbZ0Og2KughQuBW1y8Tv7IdAX8kUbxuHE1YDSa8jtn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cjHmzO8t; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjHmzO8t"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-44cd237446cso1535434fac.1
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 10:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784137400; x=1784742200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rTsgM1jD4A2z9rUodHyuFm6DsVyqIgLrQWyt1V+WEqs=;
        b=cjHmzO8tlawYCbCX8pDN0Cyq0if/hi9BIsbx+vmr2b2HAeOJUEeasMc97GgTI7p50J
         BfPKFTF0o2OcwQbLaOw22un6uakrO7z19wsH5IOAC6gxlW1IYxQxj/vnZq27zbZ5hmZR
         /B4MgD6gGVo9UWKuY3FDgz2r6B/3AiqibU+9Mu0oDvI/gQaCZhgWxMotFfMerP5da/gV
         OzhslBueRDwkHfFVSX2VKPr1W5labLVcYyiJooFiSU2y3H6wJKaSDP8PyChmCxCfCZ4x
         aFEAIzLBWxKOoExG/6dKX2AP2JA/3uWo26YYcS9pxnQYGW9Zns20gKpiscaruAuxCBoi
         XW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784137400; x=1784742200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rTsgM1jD4A2z9rUodHyuFm6DsVyqIgLrQWyt1V+WEqs=;
        b=A4lPvxZN8HRqgu+vPAq/B0nluytnwgQURycjRTFIM7QlJisbvvejXs5rTMcbrjKiYU
         ilcziSi/kPWxtogAuc/SyqxJ0ZK6K7j7Sq7BVpG/Dz+OCiZRajU2PjfpJB/4oQk3UbEN
         6xyd0T92DON6gYJ2ORAnAYV47IwvfKPzpYpNX9qh006BkdnXMnuna+bj5l6MjsyXtf6K
         yyEx1axelhL51yfII9wehYbaUeg9EeSs+rlgd1aPC8lw6xj3yCfLjIAqAOWaFSEGlccU
         gskSJFZPzgcvsMY3H7ayWvbrBn8Y+Qm2NF0YCoX2p4ESiOKTx+ndiO6WtYCP13oLX9y4
         OJig==
X-Forwarded-Encrypted: i=1; AHgh+RpbkIfjtzJoJjUfG9tXKOMFyccQ23PMENZJkchEjLB5wtBXE4ttWhzm9N6lSJEknNMzA8brSG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCrtNF/0/SA3knnrKq+fEkhSqe8rAo/8Vib8zWczRq++SOfefB
	yZeg6lwRfx0uT5sjJezRHjp449/0SKIZ+b5oCYuhBTlU+XqW8WaNwWWaaQGh0Q==
X-Gm-Gg: AfdE7cmOAvEVvjn1E9xvqlEcAKyuM9KWUytM9pyzs1zx3HfcrVCUGt/LV2lWciSHuol
	Nzr8K8Ji6QXEC5v3z7wb8dO0L2cnNs2wSxmwepY+Ln1lmKa1NAqkhQEnj5ne1px6mEutVu1gtZc
	HDC5XVsxLsXBZh0D73w4iVqxQtnBWEaJEN1ptV5oTurZBLRSGjWFUVYUhb/+wlQcweesUzobK4e
	9xl+FYaK8mThkbkYMriQvlEqYHWF396T2WkXDr9mTzqAznczJiouIQEj/kholgCEsfxIzihQXOp
	50hnqwJo7VAS9oqETqwp9KPY4JN5lt5xfI9gwl97JQDWwMtjUP4L+cXK6JIvFzS7sIc4p51btpm
	RTXVn3m263LXxQbKem3c/odpt0mxRhdr0DNL/BDMr9E7iswv4PWnoIxVBw+WqO4x+C4IxnyOUlT
	8XdMmA86yUxzEzBhGnVxLqes3uaNy8Z8IkOcdVBUo94pw1r+f9D//IupDaW+Dqu4cu
X-Received: by 2002:a05:6871:5214:b0:448:a0ba:1252 with SMTP id 586e51a60fabf-451f13dc253mr11282031fac.26.1784137400551;
        Wed, 15 Jul 2026 10:43:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-455c73a335esm9219859fac.12.2026.07.15.10.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 10:43:20 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu,
	bernd@bsbernd.com
Cc: fuse-devel@lists.linux.dev,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] fuse: fix missing barrier when checking io-uring readiness
Date: Wed, 15 Jul 2026 10:43:03 -0700
Message-ID: <20260715174305.336261-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260715174305.336261-1-joannelkoong@gmail.com>
References: <20260715174305.336261-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fuse_block_alloc() reads fch->initialized and then fch->io_uring.
fch->io_uring is set before fch->initialized, ordered by the smp_wmb()
in fuse_chan_set_intialized(), but fuse_block_alloc() has no matching
read barrier between the two loads.

This may lead a CPU to observe fch->initialized=1 but fch->io_uring=0,
and skip the check that blocks request allocation until the io-uring
queues are ready. This can reintroduce the lock-order inversion deadlock
that commit 3393ff964e0f prevents.

Add an smp_rmb() barrier to pair with the smp_wmb() in
fuse_chan_set_initialized() to prevent this.

Fixes: 3393ff964e0f ("fuse: block request allocation until io-uring init is complete")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5763a7cd3b37..b70c536d7e25 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -85,7 +85,13 @@ void fuse_chan_set_initialized(struct fuse_chan *fch, struct fuse_chan_param *pa
 
 static bool fuse_block_alloc(struct fuse_chan *fch, bool for_background)
 {
-	return !fch->initialized || (for_background && fch->blocked) ||
+	if (!fch->initialized)
+		return true;
+
+	/* Pairs with smp_wmb() in fuse_chan_set_initialized() */
+	smp_rmb();
+
+	return (for_background && fch->blocked) ||
 	       (fch->io_uring && fch->connected && !fuse_uring_ready(fch));
 }
 
-- 
2.52.0

