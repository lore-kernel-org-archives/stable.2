Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CD13DD536
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787906854; cv=none; b=YZXO6sYbfOsAvCKDyU5TZghE/5vAnD8szjQI9ys21eUF/WPjffxC7OJJHEsXr51fjc4zu6LgTcnTX+viSA1fAmOnyd4lCBVQmhD+vklszKXB3xhm6RRF73iiu7cpSiPsSUv8yFze0HouRP0apD+ZAe/kI1qCv0Vkp0/x7Cc3IKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787906854; c=relaxed/simple;
	bh=7YC0d3Lq199IvXL7FoCsyY5HhEMvPtTx5vxAZ5uu1NI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vn6dsON+H/8agGwoe5FP75S6BdJOLF4MSQOBxM0+BymtFfehqDKGS1luYHRRR21jdLuNNXBxduhiMHfAEDtyNKsU2Q3E1pw2nhJhqGD8KGbmn8Dwc19XuB9Yolv0xyXN4dXIk+UAvM33l8MMB8Uovl8G9d0J6NhvGlJKwQcIA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4fBiNMO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4fBiNMO"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cf452def93so15634155ad.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787906852; x=1788511652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RXLz3Xl6C6oGFGDAhFniglml06HtyDSEVADuwjc8Bss=;
        b=O4fBiNMO+WuCaSlhQM47joaJrW3ltmZWgv0iamCY6V9FsgtO5Qd/gETR1rJC7pcbq2
         PZFH6VAnZ27ov/9sTGaII6b/E3TWAvIgwVsAErcJDMh8aKgpCu+KyebBDVFvOQ2eyBc3
         hXHqjpjAorHWgVsg1aJBAdv8nDatdTqCUB/Z2WhUrF/Coawp40B245IfynkPI7JNIiPk
         Ib7pgilRVfGQNMSni+ca/XnHLWxg7hCtIm9Iimfv+iMnXrzB2oVc8iX2zrpQiAiBBhnM
         LMfoeXysFwQ/oV43ETXX7S5IomMszIAGnkQtAcksbxy0y/74cpLzUznwDidEpcGa6bhW
         gCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787906852; x=1788511652;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RXLz3Xl6C6oGFGDAhFniglml06HtyDSEVADuwjc8Bss=;
        b=Dpczr3JRJ9TYPS0ZNTw4xAENTxfVg5xOqerWvUWO/QoQ2K81a9Tceukft+flbEcAVk
         je6eo17EIZKY4+MCv8sV+VFSQ2DQF6pdElpu6SVTVLnao3CpFFSRpUc1V7hyWHy5zQl0
         BVpAkTIhSfMWUCNNRvXZjmFmXuN2+yxCPCiP43+tVjBL+BQRi8PofulKDqZyxfbhJ+e1
         nZsRo8CXUcum+qtzO/3qWabcQGHeYykS9AOir1cWH50NsVf7Smcs2KOpMttocJvZfQQz
         Ty1CGX1NZCphZqyfVw0W9hyyGUWYn3cyjLtduIZPAK3ffuOJOvgiWyYyVwQEqB+sWfQt
         8qoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr/Sx4dchd953P9VZRB9kqIERzNsYMOOpcVZLz5xnJFraLldgeaSh6+Qs8QyQyNtA6bmqm/1p0=@vger.kernel.org
X-Gm-Message-State: AFuF++k55lIYITsR1SoyfoaNK/ai7u5FwhoKjxhvg6noRqG2nZ9kQix9
	EjbXfB3RwIuH8GUTYSA9XkPnp4ADe9J7BktGb1Fyt2hcLO0TE2d4Ca68ft19Nw==
X-Gm-Gg: AR+sD13vQ+vfln6sm2l7/ItsvO4Ro50QokOgomFOge46TMAnAkopnxM2FfZGG8pnBLc
	N+R5NfWNEqseR9mM2P3XO0N1d//4ejubzDyyX+k2UjfPhQJz7PGGFfbjnRpYGO4KnGRVRlV6LsR
	SjZxmiJxlnL3U3Jx3DXFXI94Lw+ydg4R+7Ek/VXNw036rfzb1OhXPQ589aU6lfXJynsY33kI/KL
	ovzeXHie7jWGdfx91msked4aqdLYRZonzEboCvm0U3bUMKz40a3bvTv3Jj/aQEkW3ROF0QOYWZ6
	Wpw/Fx3QQl+FZW3V6WX7EoMFyEwQGDOw0aXU9Ac7tBDh7TUYT4nc4IsZXO1gu9lTrjUE3p/YkFA
	yvT7luu0HCrRYXC52zXzZYrR6HKajPvWEk4ZscTsM9opYFpbAcYf17zASzv6cvEU1Ec8jYEDqbx
	fM/SOIusLgXPTwZLcR1OVtqCIxLVUR6CCNMzsFENUSTM1Zuf2hWN/5gyj17Z4N4833yA==
X-Received: by 2002:a17:90b:1a92:b0:384:927f:3db9 with SMTP id 98e67ed59e1d1-396d0d35e02mr5577342a91.1.1787906852389;
        Fri, 28 Aug 2026 01:47:32 -0700 (PDT)
Received: from celestia ([2402:1980:88cd:27c4:5897:46d2:587d:19e7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b1992e05sm6292591a91.15.2026.08.28.01.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:47:31 -0700 (PDT)
From: Liew Rui Yan <aethernet65535@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liew Rui Yan <aethernet65535@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/damon: fix unconditionally skip last region
Date: Fri, 28 Aug 2026 16:47:37 +0800
Message-ID: <20260828084737.290024-1-aethernet65535@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once quota set, the charge_{target,addr}_from unconditionally skips and
resets at the last region of the tracked target, so the last region can
be skipped even when it has not been processed.

Example:

    1. Target has 2 regions: R1 (0-100 bytes) and R2 (100-200 bytes).
    2. Quota is configured to process only 50 bytes per window.
    3. Window 1: Processes R1 (0-50).  Quota is full.  Cursor is saved
       at (Target, 50).
    4. Window 2: Skips R1 (0-50).  Processes R1 (50-100).  Quota is
       full. Cursor is saved at (Target, 100), which is exactly the
       start of R2.
    5. Window 3: The loop reaches R2.  Because R2 is
       damon_last_region(t), the old code unconditionally returns true,
       skipping R2 entirely and resetting the cursor.

    Result: R2 is permanently skipped even though it has never been
    processed.

Fix this by only skipping the last region after it has been applied.

Fixes: 50585192bc2e ("mm/damon/schemes: skip already charged targets and regions")
Cc: <stable@vger.kernel.org> # v5.16.x
Signed-off-by: Liew Rui Yan <aethernet65535@gmail.com>
---

Changes from RFC v1:
- Minimal fix, only fixes the issue where the last-region is skipped.
- Add an example to the commit message to demonstrate that this error
  occurs very rarely.
- RFC v1: https://lore.kernel.org/damon/20260825124616.5129-1-aethernet65535@gmail.com

---
 mm/damon/core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 644daf5a1656..21dc6b086c42 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2347,14 +2347,15 @@ static bool damos_skip_charged_region(struct damon_target *t,
 	if (quota->charge_target_from) {
 		if (t != quota->charge_target_from)
 			return true;
-		if (r == damon_last_region(t)) {
-			quota->charge_target_from = NULL;
-			quota->charge_addr_from = 0;
-			return true;
-		}
 		if (quota->charge_addr_from &&
-				r->ar.end <= quota->charge_addr_from)
+				r->ar.end <= quota->charge_addr_from) {
+			if (r->ar.end == quota->charge_addr_from ||
+					damon_is_last_region(r, t)) {
+				quota->charge_target_from = NULL;
+				quota->charge_addr_from = 0;
+			}
 			return true;
+		}
 
 		if (quota->charge_addr_from && r->ar.start <
 				quota->charge_addr_from) {
-- 
2.55.0

