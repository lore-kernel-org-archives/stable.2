Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CD741228D
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 09:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379090; cv=none; b=I4o1hMip4XKKXv6x2zmb4TyGi8FcB6vVq2wg9FboLvQNsNGSw+inskvEAN+7H59TzdXl65GTfB0dyGo0RrIURZWBBWojcDmuwn9SMr/pdfnB21UCKThH/78s0ogfFdF3+SZVijfaX856k97M94/S6oPonLd5/8oqj2DVI+8uzSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379090; c=relaxed/simple;
	bh=bJMpjnC8818Qn90JG4OyI5Z5w5FClyzIr/EvppeqS2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AGKJjNCKgWZvIZu/WSOlWKxpMtJTOtUIhaPNJM0S1OxIKFb9RL5ZhyWA3G2kP9lPYJmvVqchyKDXWu4jIwGVveOFoQm1jwOskSvngm5niRjuZKK39XTiIjuNF+fDKkNRp+HmxPtJ9Bnjb3/iUlOPfo0FNxCaMHjD6T1bEKryM+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kani3b4J; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kani3b4J"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4be0e5351so2093642a12.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 02:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789379088; x=1789983888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QkRU9xRYmAFB55vHbz0XfJewi+FHJzT2FTL1zw86HDo=;
        b=Kani3b4Ja4qi4I9AmZNPeZod4nv4KGX9Xl5UdOUZaK0v891bD2EtPbbkHzFEojL8by
         8vNtyi8ssPL4a0acYJw/qadSmQjU69SrVhPDTlKD3Vgq1BYTvvA2xgL+MoXuwlNCPy5N
         R7yYxD0CbDW8lGx2Rmu9VaQG8Cc2Ldz3AYKC9vT5Vp6jdWoEah8ArblPdxzOitPiy5GO
         Oqf5oUNc5pzitt8MgfxLQXRxyQG399o7Jk56Vlbjgsm5xRmxhl+KiVZ7mo+Ug1p+xMfS
         vQhigEE71AI9d6vUzCu+mFUZ88QJ7SuSdsHPV6WpBxyD+VCVM8UMU+ssl580n3wusJ+4
         0jNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789379088; x=1789983888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QkRU9xRYmAFB55vHbz0XfJewi+FHJzT2FTL1zw86HDo=;
        b=Ka1Uua5s9TV7Rg811ZBz+vGK+NYTAeX4KHZgsGBSBMMrjFxaB1SJ7+cyHGlvGg7t1M
         ARrv9wsD69ZptUPKnZhuvqFkbUXvQFUjeTDuPhTWzd+DhobR1UqN8HeTT/qQ6TlgWHlB
         Ex+u9w1t9itNX9gT5KWi1eb4bfrE05WGDdRSunRLQC7Rse6spmq03CvKzkzekaGUzca2
         vivoqSN4waQ2MWaobmf1JS2AXSLekYUWrNmRN7sIDJ2DGw9vwpQdepfr89rN9FBicD4L
         +g2rN61DgXN18IgRVZa+kXJb8GRAlTzkV8chWAFGO/fD4CEPG7ZbYQscDb+LKfU/soTD
         6kJA==
X-Forwarded-Encrypted: i=1; AKwUvByvKO0n17uA034GEY+nLiPeRCXs/YhArBHWN2FkLo0YsW0l8FIKoBjC4bNUGcMvwtNy5dksYtY=@vger.kernel.org
X-Gm-Message-State: AFuF++msy+rJ+UQewb3+eGcODGbkoxPbjyBqYB6q+QwYP3aNjeH8sF2d
	2vnL8oK20sQ/645DdPWGFyF0JWnz7/IqXVxVq6eIVW5rjFHRG9+23VLD
X-Gm-Gg: AYBFou2f+dHlW9/5AG4C+CNEl2mFSX0l5dkNXyREadWKBhh5lFiar1iAcxQFTs6RtMd
	D8pCXGJnFI8Fl/immWY5rH9gJ1vIlHeHxjjXB5ZXzG5bvhlwnXKCAKP7boR1aelQfZp3D/WcdcS
	4vgw3oyW1bAENw/SilxmnkneXGI1m61CD//V6mSxb8bjUSIYeQ3tvWLtTejlIp4e+01bO/0N86h
	cjZRcvV2ZisZam7Yw9z2mAEwW5e5Z8741QxKngoK3QC9AP+vjfQSBGY2XVw9ag07i/Q8De9D7CO
	OJ4U3EVIj7QQgfeAUvBxCqLzZabGE7+HOg5hwMQsjvnJHlC6ijp/1WC49GNSAtIQBaMAVT/NGZx
	VgLTa4pZbsdrSpCEc5eg4+R45mRQg3UmvZdpvdoTZvNAFuOz30qp81++hhJT1+ZaDM4YScBQu9d
	BHGYuXNmLFgmj+fKspWQ09g+GUIBiW3sLp6OY5mGit1CTirV3V/+7Th62y15Y8K+B254kUlXVgj
	Px8LGo=
X-Received: by 2002:a05:6a21:1b8a:b0:3cc:b26a:7686 with SMTP id adf61e73a8af0-3db4039c820mr4065867637.6.1789379088059;
        Mon, 14 Sep 2026 02:44:48 -0700 (PDT)
Received: from user.. ([2405:201:c052:b00b:dfba:aa04:857a:222b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c6550bbasm4554443a12.17.2026.09.14.02.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 02:44:47 -0700 (PDT)
From: pavankumaryalagada@gmail.com
To: Breno Leitao <leitao@debian.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
	linux-kernel@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>,
	syzbot+a9efa71b884a23e74153@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] configfs: fix NULL dereference in configfs_depend_item_unlocked()
Date: Mon, 14 Sep 2026 15:14:26 +0530
Message-ID: <20260914094426.25595-1-pavankumaryalagada@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>

configfs_depend_item_unlocked() can dereference a NULL parent when
the configfs item is still being created.

The item can be found before it is linked to its parent group,
so ci_group can still be NULL. Check ci_group before using it
and return -ENOENT if it is NULL.

Reported-by: syzbot+a9efa71b884a23e74153@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=a9efa71b884a23e74153
Fixes: 4bb8548df632 ("usb: gadget: f_tcm: add configfs support")
Cc: stable@vger.kernel.org
Signed-off-by: Yalagada Pavan Kumar <pavankumaryalagada@gmail.com>
---
 fs/configfs/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index eda80c2a2d38..301a64f41887 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1244,6 +1244,9 @@ int configfs_depend_item_unlocked(struct configfs_subsystem *caller_subsys,
 		return -EINVAL;
 
 	parent = target->ci_group;
+	if (!parent)
+		return -ENOENT;
+
 	/*
 	 * This may happen when someone is trying to depend root
 	 * directory of some subsystem
-- 
2.43.0

