Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348772D9484
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 06:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888645; cv=none; b=QpRmCtvTuPiX9T9crHm6FKnUu+ZdZQyhXiPLuQB2rXY8h72nT7as/LoalMn6Q6kCWHKBlXi5dhdZpqnL66NpPMgcRFt1M/j9bNtgKasJ4fZcdeKHUui2cw9lrjVel5oScir+Lh7EYV07kFVz3sisWbdB8RH4IHRGFEV3+Tz6Fv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888645; c=relaxed/simple;
	bh=BW2E2MltUrh8Ffu3za+NXtLmFNG73i8yFckczgf4Yq0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZ/0VKVFjDnAo9zOatBkk7lW0J0wOdYpzvYg75EdFSMyV0jG6GW5FSQAdfXCl8G9LkiLNniPk5vrjkseyrAw5zi+X6iddRiLz98j89HiDH1/rEBoUNqfKgaZwiVHh98z1Juq6ysn5+xowa/LbiTQ/OikJDFHtSjZ+blm6mhpsME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b=EnPWGn5e; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20251104.gappssmtp.com header.i=@cse-iitm-ac-in.20251104.gappssmtp.com header.b="EnPWGn5e"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8471013fac2so163725b3a.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 23:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20251104.gappssmtp.com; s=20251104; t=1782888643; x=1783493443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n5gFr0Ah0wwlFvOzu82oC3eo89DUP3i2jLIZB/ISzek=;
        b=EnPWGn5eWM5Vszy3q5fnn3a4VP990p4di9T8yOyuvSy4OGFGlugqR49A99C2alHckW
         fQVDh3Ii/JotmEF2Ds+iGDxV5A6UPSwxBZMdx9XEzA97WRnK9QOO4MHyFyeqHel8Z0Gy
         haJjSZsq3S463I2tfcwpibZtMo3tY+gO4y/72UDb308hm6hMhOZl+8j4GEoNUoEjo3OT
         ysHTtMVpEzHMv4YbouBj1Z0YSENrLu8LJuv+Xxt9uXraeUuNh9SKOs7oFb8qcWYKlOzf
         oPTl37mdHmQS4DLo3v1f/X/NiOBwO6ECu/xS1PKHOnETl+JoDKWNNqS/2Ew9d1HdhzhI
         RPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782888643; x=1783493443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n5gFr0Ah0wwlFvOzu82oC3eo89DUP3i2jLIZB/ISzek=;
        b=ogz3CLxf1qEqEDsZOHk+xJmM2BbsS8kA7q1mFCGBhWngZoDpQPrCrutkAF3JBYOIuj
         v8og+o3+sEFRUmY2V/mhAfMY7TlFhZuUJw6tZPJJGQKp6xrMzMhMVQ+gHqcS14aWsC/t
         Q0iyLSSXV1YPtZG210l8iNe0JcUXHNYcB8l6kJUzE0g0Y2+14RyNlJRCG1k6rcxxivq2
         dUlTuoAE0MTKMWlptvF6GF2su+qGrKzqxEP3WSctSwsr47Jpnt3R40MFvdWotT0hDsJs
         +66kAl4nyJcBpGyJ/Dai1aOnuBB6GhsMTcPDb6IFBZFt3oDsNq7OwqlmPg2lM+uW/MeP
         x+zA==
X-Forwarded-Encrypted: i=1; AHgh+RqM5TkIqMYN6dHxOtQ+z2G0VVcrCkuIt92618bbMyWik23oEIbF8MVpAJXdS6jlKROj8+dQeWc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu2OLY91qDvVEV6DMxNaicihoT9HT7HKjmBrCHPT73HhXe1LRp
	e4kH/0Zmhg8DFQge/SwELLI9gjAmiApJgO/zpsWfQfFmwvHmdnEWxY6XA/BjyVopwBI=
X-Gm-Gg: AfdE7cnHMSzEbpV11zvssTsqmz0tZsq6ENUmrBeLpxYmj6H8YpqE9r2mAFKRgWRlEyt
	hK6NZEOGQ3uP205WuvwW2PkrZycWSy9pbzJdB4s1K8WYETgY8GpnlAjc52jbLfgzII/WDj4vXsM
	MCf0neZWKr3fryK5VIXyA06YcpEzsjh3Q16K186Xr48uVWsjIBMGg33RpP9z1tDMPQOGT/9KjMU
	Jbd632eITDKInDfdFEjPE5dJZwQHdzlNxbwm0YebjC93wjvL0Zqu4tnkNGr2ZrbdkjsxZw+1YhM
	5cVuWJBH4OvDnmCXvOwcIijd6G3fYfp/9MmXrXBDBxQVQ2W87fWiIpLIm/frokGzhTqYHGpRz80
	4iejs20zPtiw8MnyLg8GVk68uu2+A7oG0oldlK2PYSR0lHvWp/apE7W9kpHyj11BbMA5MoZs4Lg
	eQK3+zg6BdrjdPKHErw3WRcQ3HNTUdyfxqc5w0ZAz828RbCs1TQHWSkh+64dl6rpwe3IqDr+3/Q
	eSnNUW7BrE8y93mPbduNu1eTjrVE42yy6R+Cthw5qs=
X-Received: by 2002:a05:6a00:4652:b0:82c:6f07:299f with SMTP id d2e1a72fcca58-847c06f7ccemr322704b3a.14.1782888643573;
        Tue, 30 Jun 2026 23:50:43 -0700 (PDT)
Received: from Metius.iitm.ac.in ([103.158.43.43])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-8479ff8c6f8sm3289531b3a.1.2026.06.30.23.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 23:50:43 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: skalluru@marvell.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] bnx2x: fix null pointer dereference in bnx2x_free_mem_bp()
Date: Wed,  1 Jul 2026 12:20:26 +0530
Message-ID: <20260701065030.381836-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In one of the error path in bnx2x_alloc_mem_bp(), bnx2x_free_mem_bp()
may be called with bp->fp uninitialized. And so, there could be a null
pointer dereference in bnx2x_free_mem_bp(). Fix that by adding a null
check before the only dereference of bp->fp in the function.

The issue was reported by Sashiko AI review.

Fixes: c3146eb676e7 ("bnx2x: Correct memory preparation and release")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only.
Thanks to Simon Horman for pointing out the Sashiko review.

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
index 5b2640bd31c3..25ee45cb7f3f 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.c
@@ -4712,8 +4712,9 @@ void bnx2x_free_mem_bp(struct bnx2x *bp)
 {
 	int i;
 
-	for (i = 0; i < bp->fp_array_size; i++)
-		kfree(bp->fp[i].tpa_info);
+	if (bp->fp)
+		for (i = 0; i < bp->fp_array_size; i++)
+			kfree(bp->fp[i].tpa_info);
 	kfree(bp->fp);
 	kfree(bp->sp_objs);
 	kfree(bp->fp_stats);
-- 
2.43.0

