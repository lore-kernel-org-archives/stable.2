Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5FB3DDAF9
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786000212; cv=none; b=URL0C76EkRd7iUyNBVeoCZAsHUhTUTznoSq8k14qmUSC579gv6bDlvQMStlczHArsW1hT5Pk3+1oXteBAopo4R7y3u/R67Bk81uAbK5PVB3nWAO522TMhOSoHxUh/f42tv73ckYU7Xdc1bO7MBeaBEruJV0UiMa0Lk1y4QprmGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786000212; c=relaxed/simple;
	bh=D9JmoKMI2Pmwotp5SEfjJj5F1SbchS7Q2k32kDMtCD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=brrK3IhXNPdiL/OWvRPrLe4cWQejsghH0ihFNNcdD8nqZKMxDZISU3pi+qkyfP/0G/dsBmlQqn3aF1zCYDaC2fTwz2A/Lw7gzu5nXwxSmkIitRHv46Yv7k7Tc9ql7wM4nIQy/iVrumBvwFJWlnlX+CcyrK92RKfKslijjGJeOHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oLfAZVMY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLfAZVMY"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84862b0d5aeso2233357b3a.2
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786000210; x=1786605010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pxkf9l/6VRKPUFdY+I+2JUrRfOgcQ7nzG7Tljs67NVc=;
        b=oLfAZVMYsURcvMNnJJX66I4qn/Eu34GjnRthIb3aVjz1X4yl1U4Xwnvxd7Z6k7g6oz
         6sgY6SrNdxmMAtTNetV8vbMkeOgMHy9ZUVhP3Cgctpc93YMimDBjI1vElbih091gWM01
         xNtwUFmgf8dQVu6ykVNa3KN6sexx9VRHb81ZB6/Okyin4mtp6BU5sjY+1imMR8/ikqYq
         I47oIiUArbuFY4SQmWSyD/I/hahDY3q2rDmKdVI0v9w/rzppQ/Ayz25ynKRzyEUdYv38
         1LWqLQgI0LygiZTARKT0OEG0D9bYBUDo45R+li0EIIZPtEvv2sjy5K25cMU1Po822vDH
         pQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786000210; x=1786605010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pxkf9l/6VRKPUFdY+I+2JUrRfOgcQ7nzG7Tljs67NVc=;
        b=FzpueTlXRbYLqC+HblrVrk6xBEqYV44UGDyyOd2CvMA0oYlFRTTk4huvvfltKXrIfG
         VKIvsIMXFPfBFxEA/CpnVqJijDWY+T7TKpM8xvn3q360DA+AmwF34LD6aK1Hqz6dlSSb
         Z2F1ZJP6jdCmwhrN/fCCVpfvjaPJ9LNbu5tkhT0LXWsfRLm5qIWw23GQpSSNpbsivITT
         oQHdd8e5i2ruNO3Qn4ERO+Y44Gdk+KtBWsgOABW3/KOiUkdoSAkOn6jSurxTDUUduTyb
         hUhuAWFDnwbFhVNuUsDKP3EV39g5SZyJlYp4a5OUSedlOD82EF1jHiV0pzz7nnKsJg5b
         gHtg==
X-Forwarded-Encrypted: i=1; AHgh+RqZUY3H8kGKTI5YQD18GNzYppl80EiLutBzf3QCF6jaK3MHqEzaCD31INtnWFlYyrdkq22WBWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7jiIM/RFAqKxn48rqCFUBOgSU93MMeD9x+dm966P/S7YenIx
	tw9SIq4apW+EgFCwxzPRmbniopJJ+bxZMxPYhfm52O95vapPrf0I4R3V
X-Gm-Gg: AR+sD12jfa0I/kG3fucz+QTnvhPxow4jSFxBy7ngGIILN797N8l153xWXYlpRXnJub+
	sKI/eBi+APYaGibAeuv8i447uk+UmYruFYjBx5dDIxhXbKy/rOXFdLvMNDbZv4mou2vA1uG4EHn
	9ZFZCmM+rRTRhdmAv7WJkLKwKmCT8kcTGdd1wMar7cmWJOtp+1VYQmYoaIfST2oX6B4MEEhaijH
	Ks0p/aVRAA6cgB95knpFSuY1+FIadT40ACfED4tsUpLpi/JTfZzYhWkRoHzR0Pf510TqpdiUAiB
	nuZZsqbDiRYGoB8TrjUjRvEe9nxwNTuh7mxFvCO3kkglA1qQGA3QYT6o4FqqHPJ0ktuPUCwLRF+
	KkS1RrrhCJ9D8k/4LbMb4y4POk3pEmaarUuYXRZ7EW1UcqSeKl1LxhATYYZQ7Ub+p6dpm9J61qX
	8QDXxiieFdkJxwOzJvBgsxw58QnI7MGpFYj9hd7q1akkMhWsZGP0iaFcWmqXUc3krytycLdnP3W
	voh/M2Cdu1d/XRW
X-Received: by 2002:a05:6a00:4218:b0:845:ce5f:c926 with SMTP id d2e1a72fcca58-84f2e210308mr14993193b3a.1.1786000210573;
        Thu, 06 Aug 2026 00:10:10 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f45bc9cffsm760154b3a.59.2026.08.06.00.10.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 06 Aug 2026 00:10:10 -0700 (PDT)
From: Hao Jia <jiahao.kernel@gmail.com>
To: akpm@linux-foundation.org,
	tj@kernel.org,
	hannes@cmpxchg.org,
	shakeel.butt@linux.dev,
	mhocko@kernel.org,
	yosry@kernel.org,
	mkoutny@suse.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/2] mm/zswap: Fix global shrinker when memory cgroup is disabled
Date: Thu,  6 Aug 2026 15:09:42 +0800
Message-Id: <20260806070943.95542-2-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260806070943.95542-1-jiahao.kernel@gmail.com>
References: <20260806070943.95542-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Jia <jiahao1@lixiang.com>

Zswap writeback when the global pool limit is hit fails when memory
cgroup is disabled. The pool remains full until it is organically
drained by swapins or memory freeing, leading to zswap store failures
and pages bypassing getting written directly to the backing swap device,
causing LRU inversion (hotter pages with higher fault latency).

This happens because mem_cgroup_iter() always returns NULL when
memory cgroups are disabled. As a result, the global shrinker
shrink_worker() repeatedly takes empty walks. After MAX_RECLAIM_RETRIES
failed attempts, the worker gives up without writing back any pages.

Therefore, when memory cgroup is disabled, fall through with the !memcg
branch and shrink the root memcg directly.

With memcg disabled, shrink_memcg() only returns -ENOENT when the root
LRU is empty, which means the total pages are already below thr. In the
absence of heavy concurrent zswap stores, the loop then safely bails out
via the zswap_total_pages() <= thr check; otherwise, it will resume
shrinking the memcg after processing the reschedule check. For any other
return value from shrink_memcg(), the loop is guaranteed to terminate,
either after MAX_RECLAIM_RETRIES failures or once the threshold is met.

Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
Cc: stable@vger.kernel.org
Suggested-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Acked-by: Yosry Ahmed <yosry@kernel.org>
Reported-by: Yosry Ahmed <yosry@kernel.org>
Signed-off-by: Hao Jia <jiahao1@lixiang.com>
---
 mm/zswap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index b5a17ea20237..48fc7b575e24 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1356,11 +1356,12 @@ static void shrink_worker(struct work_struct *w)
 		} while (memcg && !mem_cgroup_tryget_online(memcg));
 		spin_unlock(&zswap_shrink_lock);
 
-		if (!memcg) {
-			/*
-			 * Continue shrinking without incrementing failures if
-			 * we found candidate memcgs in the last tree walk.
-			 */
+		/*
+		 * A NULL memcg ends a full hierarchy pass (except when memcg is
+		 * disabled, where it is always NULL: fall through to the root LRU).
+		 * Count a failure only if the last pass found no candidates.
+		 */
+		if (!memcg && !mem_cgroup_disabled()) {
 			if (!attempts && ++failures == MAX_RECLAIM_RETRIES)
 				break;
 
@@ -1379,7 +1380,7 @@ static void shrink_worker(struct work_struct *w)
 		 * and failures.
 		 */
 		if (ret == -ENOENT)
-			continue;
+			goto resched;
 		++attempts;
 
 		if (ret && ++failures == MAX_RECLAIM_RETRIES)
-- 
2.34.1

