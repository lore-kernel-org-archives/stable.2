Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53A0364049
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 02:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780368040; cv=none; b=IiB+iaifDFvYoUgOzpZZyV6t06COCvfj6egoWumjQuyb5P2ZlChvlNnJllhwmtSwoxQgac6GbfhnoGnao1aMb7raRslArGWPO78IEcHKoH1HmAboepSMMs/WvMFsc/mHxGB9SIaEjZc5D8cpCJT3PhEgjeIRZxP7EXqOACDj/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780368040; c=relaxed/simple;
	bh=pu3l4so7HE/6aPov23DNyoo+QaCHW2xwcQuz5IOG1Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MP1/OKZBSVOO0ejXlA/wVV6TPL2cC45bYCZlhMDyDLt54WlikY06JPfab3xpcKAXY3a9AJECvXUYh4azQ73rEcJE5NLCF9zx6cKggrl87h2J+XmAjXY5cxjEcRB28njQGzbFK6tWm0HudFlUkTR82gpnduIa04+vEOP95F6IMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uq1zRBmW; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uq1zRBmW"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-51749fe346cso14257171cf.0
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 19:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780368038; x=1780972838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AeohTwvd4oZnskIqWgfC2EYaBkDAYS0G0xQwLeBQASs=;
        b=Uq1zRBmWgW/XNimxHN5i/mO2fpLsbBUNuQgr9D1ouxijxK1UHkOQkeHTFCx7NBf3th
         JiXrGQG68zgCnky9Wh89yJzm9BwWzK5ZqIqvztBbIolF9Q2aCgzNAckfLrtnEN8J9BMi
         46MmAYjt2IwLfVNA9mXjZdYxk6PbyhnJ6QEGMzWlc02bp+XwWbMJj5Xlar4QgrS6r+Ux
         qY85l88Frhm0tiLh6OQR0lFlRCMCrQenpULrU5r00NIOmiA7DeyoGV8g/dUXE5vVe0zG
         wb9RVZmZhqProfBKYAAbehyH/CXCUAsRyN+rdNjC0Hlg0vNcL8kvGbu+Lg6Irt5EIqzL
         K8Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780368038; x=1780972838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AeohTwvd4oZnskIqWgfC2EYaBkDAYS0G0xQwLeBQASs=;
        b=KLcGk2ck77SE2+DnBFxMpB48CYufodX2cOGxZerUqKTkdaFhEc08iLRh5h5o7hbOq7
         pZrc1LbueR8Zpb3gw/up710JUKxwuse4MoaNkIx0R6N1w8iKchZwP8AaioaOw1NzNzvw
         zXgrhMH2m4Na3gmEcKwF3Kf8227HW9aN65HJn0qfMt5YXBc5452tbyU2Iem4R6sFcTDl
         STuV8xEOOaUSUqeSi5oUjQ9AhZrDYVH7219orGAP2kHuLgdEz8NsviTWitwVI+vHWdMV
         U3hbTrrbCqlWB885ujYNQs1hja0lRpDRLtaYS8dsLa9eQ6f6mgza/9tqZS9AaydPPWwr
         BT/w==
X-Forwarded-Encrypted: i=1; AFNElJ+mB+VkVzUOdRlx9wdpS5jAe4UeYsjKQaAyy8oACWIbvh/dh4D04RibUtrpMsW62oeagpT8ngU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd0Qk7EwNdfQ5eDWnhVl7KkiboAS3E05CBMjEjo6BjyMiM+xVy
	gpVlOWfU8SIz7dutJncIdBMq2LzEkjaeL9l7BLHReqdJYrgNyvKmHeyT
X-Gm-Gg: Acq92OEsq2Tf1oYcrQzH8Oijn+uwu4fGq3SyiGzTaw+AE04xjJXYmjZjMk4dayIBqLP
	ZU/nHvqB4YkLlaeRKhkD8urriA+rQzbsnPYkxi8D0FQQWmE5jK26mrtA4dmW8KC8+iOhpWGivyR
	ZgUuF9S8G+5ae0lSmUpgGAc+AnlrQByddRRsHE2ZdIKRshkgANwMiWKK6hf8orXYNg12hA7pMk2
	jSGeQHPpA5CBYVpijIl09qIEIxTKnNPCS44NV9yUZwyeTeKi6yX1DQlPFsxkqgE9RVua7gjo3rn
	MzRP1mdA9mLq797sm68D2mkNUwIoshYTle4wk0kUM1rv/ZagyOTBVnV2O9iVsGaqHGc2nQ9+a6G
	UwlEhOzhyiG7aGktPmSYO8qybQywXysU78DULvIZwQvfO9rUhD3MhjMbsGDsyL7aS+Kp8iJKle3
	ez9ea9q7fihqRAzl+j1HmfSC9UV98+Z0fMoMe9vJ9m7/NY0khev7WQVqo8FBkUFOzfEByAxqhBC
	jeh
X-Received: by 2002:a05:622a:6843:10b0:516:ea2d:7c5a with SMTP id d75a77b69052e-5173a8232d8mr154097731cf.41.1780368037828;
        Mon, 01 Jun 2026 19:40:37 -0700 (PDT)
Received: from aiden-laptop.bowlinghome.net ([207.174.150.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea23e115sm108327466d6.42.2026.06.01.19.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 19:40:37 -0700 (PDT)
From: Aiden Bowling <aidenlbowling56@gmail.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aiden Bowling <aidenlbowling56@gmail.com>
Subject: [PATCH] kernel/sys.c: fix prctl_set_auxv to use sizeof instead of user-supplied len
Date: Mon,  1 Jun 2026 22:40:02 -0400
Message-ID: <20260602024001.14119-2-aidenlbowling56@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prctl_set_auxv() passed the user-supplied 'len' to memcpy() when copying
into mm->saved_auxv, instead of sizeof(user_auxv). Since user_auxv is
already sized to the full auxv buffer, using 'len' risks a partial write
if the caller supplies a smaller value. Use sizeof(user_auxv) to always
copy the full buffer after validation.

Signed-off-by: Aiden Bowling <aidenlbowling56@gmail.com>
---
 kernel/sys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 62e842055cc9..d3f5229649e3 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2189,7 +2189,7 @@ static int prctl_set_auxv(struct mm_struct *mm, unsigned long addr,
 	BUILD_BUG_ON(sizeof(user_auxv) != sizeof(mm->saved_auxv));
 
 	task_lock(current);
-	memcpy(mm->saved_auxv, user_auxv, len);
+	memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
 	task_unlock(current);
 
 	return 0;

base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8
-- 
2.54.0

