Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82271480948
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789754938; cv=none; b=FGYcD07KdpvXo2/ZnE0GYIpBfI83EqJ6fu3l2RnAR/Fjallihu3ceJ3XwIAS9/cavLnPpqp/2wkYc6RXwP8nJbYQq0JU9kkeM07s4ftkLtNYqj/OyU1Q/byWB7BYUlztoXqx0aZnI7tYP7iM1KGaOJ3OVslI8w4THHCbUS8b/Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789754938; c=relaxed/simple;
	bh=rCqln+ldRcar2aGI9E66+eDbpM7FpzvC9RiwZ4ik+Ps=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FAzwaTlv/CRUcPtyWRs5FDj4Pj/XLMQXOgRRr04OhPkZgoSXCsxnnaoBLjB1MzQX3SPQKkBx/gt20F8cUBXk1AsvgbkASqo8nFfiI5ga9ApVyZ6/GIiB9KXHGtiwiAAMAN5FDq8KDoiBSSXCpXDrZNmemiILLzSbytGXL184bPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rhmqdvur; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhmqdvur"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso1002221a91.1
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789754937; x=1790359737; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Pisyjq0s/DrLt/PH5mHbqq10pRGwKUzFOy1CWK195Lo=;
        b=rhmqdvurONjYsMQk7rbY+RQWhqDV/kbHcbK61fm3kxHDXJtou9LsbAYHcO2I+C1QlG
         Qn8a0uhG7BIJiKyWObSBiawV3Q5VjGaWHt5UrhdfxteDi+8r/ky9m/nJR/U3JjmAZr2q
         Jv+U8TWL1Ot1scrCO+pe9gmz0Ex2w4rep8wdfojSHMM9p7C8TWBFz+A3pqiLp6Pd7Z0V
         TxHb71P5XyqDq8Bo+i5Ojwp3VGEmIov+iShwPnl40ACegE15DqNT0vdqfr15hFvyu8Ao
         myU/ZRCx6un/7MevgFGDoaUpa6r/6rXnLU7Vst2JPGA+JOtEqeWUPcy3Lndt5JP6Ij8T
         DAtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789754937; x=1790359737;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Pisyjq0s/DrLt/PH5mHbqq10pRGwKUzFOy1CWK195Lo=;
        b=MdaZciFxh1ZvfSRDUU+DK/GNNuq464vEy/e1Tvq44um8suT2XT7DPZEEc4Q03x4Wm5
         wO8TqEKS4CKzOMUoNVTcZN5KkaJr5rNPnWZQ+U16eT2dqpV95CQBIoAWbtuiaJQllE45
         AQ7DjrGPSIws+u5GBOjM1cg5T1vJmc4XNPnhtTWejUo2SPiv3tbKa8oRUPurT5by0ajw
         LiaFaACI7BRrRQowzcEnnJjTDLE2M8iMUDs3ZB8BrVtWj3zzTEXpoz9dFSA6n994OIoW
         27X+YJdIbxv2IzmXMeKWhAdjWa8rTVKkK5nY4i/76VH6z18dGUFUzzXWlAt4CRoM+zHa
         wb2g==
X-Gm-Message-State: AFuF++m68i9MJPDPg2dFjCqGYbmUTxmV0Xs2WsV27R5ZzFu5YK+oFUmn
	ZKReezsi0a8yOU+hcxxvmhKNOMfb0PzP5HiD2BdsKXVyZdtA4qUZBHRx
X-Gm-Gg: AYBFou2rKFQM8mxOu1K3laqE8Tv0fHoMUao0nMZQqqVkAzyoqA6lhYI31y74LJIptG8
	BGm9kM5fAXoosTYK77KZO+FrG379J1+eae9wFPxZ47b8YQBcMC91bbZ49myTlFckH75sGGIrdFt
	Xzz2JNRh54fxTv0s5HEldhCbLTwuVgKF+1F+0s7hjxHaSLQboSlN3SDnn1AsPL+Hy3dztKZS6Lc
	di7JiZFwi3S8/D4n8OEYM0/7TElPKyyOz0J3vb8xih2m/g9/cdGPqBeS6fFgreE+4QCi8RmMykA
	HQ9j/BtaLyPd75zjnsW9FNLWFzIYgvJQlVFiZU2P6A68OSDEuT6Vu6a/DMnlBgzIPoqjaiCz/P6
	VzhFwS+OVeLf+utw33Qbl/ojR9UpD+JtUWPqdy3jTppd4VJHeMNy30W5xuFOmKCZEBpdilpJ1da
	FPqcMhjBEBrVmQ3ayiCNLvh/HM18dVRieWnBBjFmNywCguSZSXyyVQHiy0Fyn0b5+O4wI+WuyWG
	gIT4y2262jj60pwA9weLk0=
X-Received: by 2002:a17:90b:4c12:b0:39e:6c6a:6576 with SMTP id 98e67ed59e1d1-39e6c6a677cmr658266a91.57.1789754936383;
        Fri, 18 Sep 2026 11:08:56 -0700 (PDT)
Received: from localhost ([124.79.30.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c164c18sm627891a91.1.2026.09.18.11.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:08:55 -0700 (PDT)
From: Leno Hou <lenohou@gmail.com>
Subject: [6.1.y PATCH 0/2] mm: vmscan: fix dirty folios throttling on
 cgroup v1 for MGLRU
Date: Sat, 19 Sep 2026 02:08:47 +0800
Message-Id: <20260919-linux-6-1-y-v1-0-577b5191263c@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0NL3ZzMvNIKXTNdQ91K3SQzo+Q0czMzi0RjYyWgjoKi1LTMCrBp0bE
 QfnFpUlZqcgnICKXaWgAD5oWobwAAAA==
X-Change-ID: 20260919-linux-6-1-y-b62cf7668a33
To: stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
 Yu Zhao <yuzhao@google.com>, Steven Barrett <steven@liquorix.net>, 
 Oleksandr Natalenko <oleksandr@natalenko.name>, 
 Suleiman Souhlal <suleiman@google.com>
Cc: Brian Geffon <bgeffon@google.com>, Leno Hou <lenohou@gmail.com>, 
 Wei Xu <weixugc@google.com>, Zeng Jingxiang <linuszeng@tencent.com>, 
 Kairui Song <kasong@tencent.com>, Chris Li <chrisl@kernel.org>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Axel Rasmussen <axelrasmussen@google.com>, 
 David Hildenbrand <david@kernel.org>, 
 "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, 
 Michal Hocko <mhocko@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
 Yuanchu Xie <yuanchu@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789754932; l=1618;
 i=lenohou@gmail.com; s=20260311; h=from:subject:message-id;
 bh=rCqln+ldRcar2aGI9E66+eDbpM7FpzvC9RiwZ4ik+Ps=;
 b=7QOIuUPHI9Mp4canz0RH3bGJ0J5na4A3EagCLP7IOHbb8Eos95/0JoDYp6FFatCFPWqM22ana
 tya5oMhrjg0DdYH2dwRarT5Euy98ZP4nTrX1fAAAaEBq2h1lAHYB2+x
X-Developer-Key: i=lenohou@gmail.com; a=ed25519;
 pk=8AVHXYurzu1kOGjk9rwvxovwSCynBkv2QAcOvSIe1rw=

The series backports the following upstream commits:

  1. 1bc542c6a0d1 ("mm/vmscan: wake up flushers conditionally to avoid cgroup OOM")
  2. 13b6b6209104 ("mm: vmscan: fix dirty folios throttling on cgroup v1 for MGLRU")

Patch 1 wakes up flushers conditionally when a memcg is about to OOM due
to dirty caches.  It restores the flusher wakeup that was removed by
14aa8b2d5c2e ("mm/mglru: don't sync disk for each aging cycle").

Patch 2 handles cgroup v1, where balance_dirty_pages() does not throttle
dirty folios.  See 9badce000e2c ("cgroup, writeback: don't enable cgroup
writeback on traditional hierarchies").  After 6b0dfabb3555 ("fs: Remove
aops->writepage"), reclaim no longer writes back filesystem folios
directly.  On large memory systems, the flusher may not be able to write
back quickly enough, leaving many folios already under writeback.  Since
MGLRU cannot reclaim these dirty folios, the system may run out of memory
and trigger the OOM killer.  Patch 2 throttles reclaim after waking up
the flusher for cgroup v1, similar to 81a70c21d917
("mm/cgroup/reclaim: fix dirty pages throttling on cgroup v1").

Signed-off-by: Leno Hou <lenohou@gmail.com>
---
Leno Hou (2):
      mm/vmscan: wake up flushers conditionally to avoid cgroup OOM
      mm: vmscan: fix dirty folios throttling on cgroup v1 for MGLRU

 mm/vmscan.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)
---
base-commit: dcbcab9d707928cd1679eba21ef0697fbb73b88a
change-id: 20260919-linux-6-1-y-b62cf7668a33

Best regards,
--  
Leno Hou <lenohou@gmail.com>

