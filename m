Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABF9376BEF
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784278335; cv=none; b=NzgPuBKTXocgd0F5ip4SRJUkPzWpagoBRWgZY9DiefWUA0/0kxnZqo5KmWI7VeGlRVYks+IKh8J8y9sBaG/OQSzrG7xZz7CN/5KMtZ3hADh1iaCZtRrFC+g6mHZrvcSB7EvgAIvYXI04RGdnOqJWntCWFJPMdt8t1IfNUg+mJQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784278335; c=relaxed/simple;
	bh=h+3gZPmYltKvxFoFTsqU186dmpWa1sBnf0q8P6lIN2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AiTyM4tImwvfKaH0lDSKmRZqsRGE8uS+XAVYXsJzJvlVqVoPSonwc1d1Ahb/lSDDYHmZQxZRE1eNWKg+97LUjts9nDA/c7bLo74ChbvebuiN2o0xIM/1cD5GQqHzNIDI8Qllsanc5mOIAC8GQvSt7fGEh0ou8J3Yed2it45rqt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YZsKJnPD; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZsKJnPD"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8486672f03cso7518776b3a.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 01:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784278333; x=1784883133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=idUPlycWgvJqE3e2FFLxSJRzfsl5YsmQQbKWafiBiP4=;
        b=YZsKJnPDx7BRgVQN8tx8LCKvVRiZyVM9hO0csYNTWKFUD2ArbYi8ZD/TcQiLFj/Dyu
         2jkOkynUsmbg5gXc4U3IJhIUH2qg7OJXSvTyKeg4cTerK6wTHLdTdJIJR9nP//CZ+1Db
         WvMDqbUNESP2spw9/TiwtsQpnKrs9kO6aeoxhkTbXsw9KW5p6BSU2T0hYPTfUpUhRCNm
         r+AtgwD0oXYiKY+0urymQ6K2XGL5Zwa+2teUWSuIh2rUhWLUn4NatV5xxsTH2hea+NXu
         V+FTgB+kzOXCSPibjRWmK3b6/gOlrftTKPsSaae0Y48W4py0X3N4nYEZ4XfkEpANF4J3
         FqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784278333; x=1784883133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=idUPlycWgvJqE3e2FFLxSJRzfsl5YsmQQbKWafiBiP4=;
        b=LKC/W0OFIZz05UBDzmB9aWf2FMHyuWrRroxpVFOi7LNtBPb4GtPrc/ZPQfBGyWb8Jd
         vohtibtRa/cye9soGc5I0EivsXllWFzagxjeSYK35H8FkriDhgehtFdm+PrySSlgmHzz
         zzRlomkYXnGjK6ZxKkdhwVMm9BkNFZGaFqT1iRuZZaWqtA4Cs96w2UL7SqVRfsa1NmI0
         +JPwLmTpPTgmV8Ortu22vIBzoR2dP570X3lHPKUjPqplWyKVOgt/g+YSMofClwAEekde
         O/bk9ZxIN/4T8OWiDfMovebsW7p+7qUv4YlvnDlX+QtDyG7PJlYT2V57sQ2XunF8Y/QR
         3ycA==
X-Forwarded-Encrypted: i=1; AHgh+Rod8rSwCtt+5PNC+rT5usXHKObQ2NLcHnXj9e93yod8F1RQ6RkxirvkT9oUOtKpHhsswOPAL2s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+fpopaFTLPIF1GYbchBhYCIfnmThQYYaUveLZAhpCw08RwJAM
	Dt61ExwL/MRWyck/0S8W5VWQWv76hXGmaY/+xzl6093yJ9p/GDqFtYH5
X-Gm-Gg: AfdE7cm7IR4lfhWl/sWhGKqqcN1Uh+JRRpilXGoOJ2C7JVwRtE2VyPBi8LiRP39HW9B
	p3VbUkBzhOQKvOSsuTqdXAgG2hb7LKztbAkN8+EONZGa4SxaIWwtKU1MvlwJtKdVcLByMauTAZW
	Q9IPm0WohxGNbxEt3f/c5NepXn+JeqGuAkUqp3/Olm1ZYfo1VZRpTpPDXM6etEH4TCMgEDQ6rH1
	4F4xcLFeSCVCfXuBOIvhwWqy+qIW8hb65jnAxqXdiEsnFYkiNoebH0FcAFW8Y/KUsjaMP+X+cJS
	dvhd/RaY+jr5MMYetV4+BHrT5jI+MILRjZhftEpuxVoRwrRyvgPJnOkQ7gozdSYijSHQFR9BWtB
	4Cu9HhfZz9Soc+PlmY9xwgA9Zxkt5bznVQZkH2UBDd/tgMrKFOg/803zxTPp75izzIiiZuUmFdT
	qsz6IxKhKzzWaQGv9vpXMv8X9neeB0Fg==
X-Received: by 2002:a05:6a00:21d2:b0:84a:29a7:f650 with SMTP id d2e1a72fcca58-84c29093c61mr1731239b3a.0.1784278333446;
        Fri, 17 Jul 2026 01:52:13 -0700 (PDT)
Received: from localhost.localdomain ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af9f477sm619474b3a.58.2026.07.17.01.52.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 17 Jul 2026 01:52:12 -0700 (PDT)
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
Subject: [PATCH v2 1/2] mm/zswap: Fix global shrinker when memory cgroup is disabled
Date: Fri, 17 Jul 2026 16:51:50 +0800
Message-Id: <20260717085151.22822-2-jiahao.kernel@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20260717085151.22822-1-jiahao.kernel@gmail.com>
References: <20260717085151.22822-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hao Jia <jiahao1@lixiang.com>

Zswap writeback on hitting the pool limit is broken when memory cgroup
is disabled, because mem_cgroup_iter() always returns NULL. Therefore,
the global shrinker shrink_worker() always takes the !memcg branch.
After MAX_RECLAIM_RETRIES empty walks, the worker simply gives up, so it
fails to write back anything.

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
Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeLc=eyTPKPVQgX4g@mail.gmail.com
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

