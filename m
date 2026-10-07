Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F548F82C
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791390883; cv=none; b=FYaNENMyHPBQhHxAUsxPs6iZrp0QQSkbKdwniXSpj64qpATxew7cirrQiH8Abcqi/DqfWj5/1hp4d33Sr0pR0Q4vH6wDlik9vIm1b+TETQiLjygbJ1GC0getcHaPcIA8bE+4Me+wcOxiEQS6nLJA737+n3N6NwTuXrKrFb1DDlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791390883; c=relaxed/simple;
	bh=jwTo89W5uEjz98yetsnbjGk2QXmB9By/eGq94DpODU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GDKNHqB96zdYO9LDTMskSojjVmhbjymnVXDsBxyXRucRD0LnDQeaSfHM+X8FeFomAYdbW+wdbGj7vPS8RC5dK0rQFUjwxUfHo9VtqnolVCbb8c+p/J8GEWbIvLCiHbDKYhWSNYEvAlXvKkdCOFLefbeSg7GLrCoC7bueIHObQWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptQkqO2M; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptQkqO2M"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-39647aa9d52so1933000a91.0
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 09:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791390882; x=1791995682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8J1GOhzcY9UVBGRcW/Cw+AY4dE8xBdwM0W7qy7H4udM=;
        b=ptQkqO2MrA+nWusamvqBZlvKEunhSUXrDIWpeBEsD7p+sJ6EQujPVJxQsyye6gDbsL
         VrTUP5hNqvZb+LkEwbYHmGZVV30mtjuwfyOWFgPCJxxQtCn4xEqskKHbm/KNS6hgU9d/
         tkBZUrrUdaZ9dN4JblN27oWqqbVEkX2d4dQ5taP8noYdJOtG+UXsf7oR3wH68aPCwd72
         pnr8F5K9u/g1iuuYmHxQF8G9ezGLlkS+l+QShPl3WLzlBIyOY/2fcFEu7PjmJPxoyqTa
         lc5xEEHrXqQH+t3Ju8+yBfL2d07HFBXu77ZuMQKIT17Cpl5Jo9LDxKd6r1ZS+of6rM+6
         IYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791390882; x=1791995682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8J1GOhzcY9UVBGRcW/Cw+AY4dE8xBdwM0W7qy7H4udM=;
        b=aWDeT2PGhI2BZc0B9yc+8maySjELCs686uIZrMD0NHhGqS0jRHsP8Y4agfAhx1CAP5
         QD4CpOT/cFoWfpbMLR2boi+uob8h0W/t5YlTA2MPBRpIsdanOaF3Xf9B2Lk+OQSgPeGa
         QH5GTdlU8Rgfwv1I7DeGjRwr9Wcruy6AyLjj/XnjRx+dI+jiwfU4K3ANtNUAm0aAlf/g
         hno7mjSCq9Cr9tTsqiQx0vrudocpYTXsnT9n+aUKJd/BbRE3iPeDRHShid1AaTknev+N
         ZYR3opYgJVt24TsPsO1SxinG+7nMaim1VX0aH1hL9pK+SJEaLnQ1Jmavv95eVkvF6WT5
         FIAw==
X-Forwarded-Encrypted: i=1; AKwUvBzWkk7ZxI030usL827oEUHZ/qb4asIe2gZuWDBIv+hQ9IunuMADW7bTs4v/fIT7HvEzRfAiO/Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKk5zdL0hrBZ6R6ZA/yDUI3paPymwLcahwOxO242vMYa0dg1n5d
	5ZnLaIa3FpNf8PdYJZNlLXzAtHo7i5ZIeJUwJSenCBfH0RuCRJ3xo/F2
X-Gm-Gg: AYBFou2nsXIaSqeOJqlA7z7tOIp1u7RYv+kXsFzWVnjcw91Pamg4zLeKYcR921ijdoI
	5XYO2DD7yVxk7hivr63p4dA3eCbrA/qAhTDxkqu2Hfzlsa0nRvc6f++1PY1vpA6+xWJ/RV4f9AY
	XTlGcUdyy768a0S4HIKiTb3nS5osYKNNDB28CMO3/ssywKaCtJv+qBLIVjkeVabrxCQIDFKG4cW
	lmTSFRpH1oV5AzEjx9mc/TFZurRGREBNVmzkT3oO3JeEVL8hrTF/dC5mAHRjKa5RCymHs1SqwCv
	RdeCUm1/UZdeMbaBVQGoPRaWgmWMZwniSIZfITCeOPcN8y72qk8YZtYeKhJtf2+J3qaIJjbNfNN
	xGu1gxavagU+4XCjh3oDDpAuMXaz+/HiXvTYxO149wyflw2r3fzQe/Braba6zUoIelNDHzNm/TV
	sn+HSMnpUnfMxrdPUfeIU47uYyff/7EB05Fcu9J5M4644xfM8zvils6PfQjG77ajjWL1sFGLW7V
	MrBHKJlI9ilqozcdfvceuOS
X-Received: by 2002:a17:90b:48c7:b0:3a0:eec6:b065 with SMTP id 98e67ed59e1d1-3a8a0ba1c96mr1499640a91.13.1791390881599;
        Wed, 07 Oct 2026 09:34:41 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89dbc9297sm2713600a91.1.2026.10.07.09.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 09:34:41 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Harry Yoo <harry@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>
Cc: Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Hao Li <hao.li@linux.dev>,
	linux-mm@kvack.org,
	Roman Gushchin <roman.gushchin@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH] mm/slub: clamp slab_min_order to MAX_PAGE_ORDER
Date: Thu,  8 Oct 2026 01:34:02 +0900
Message-ID: <20261007163403.1643768-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setup_slub_max_order() clamps slab_max_order to MAX_PAGE_ORDER, but
setup_slub_min_order() has no such clamp.

The buddy allocator cannot allocate more than 2^MAX_PAGE_ORDER pages
at once, so slab_min_order above it makes no sense.

If slab_min_order is set above MAX_PAGE_ORDER, it can even panic at
boot or invoke undefined behavior in order_objects().

So clamp slab_min_order to MAX_PAGE_ORDER as well.

Fixes: 818cf5909701 ("slub: enforce MAX_ORDER")
Cc: stable@vger.kernel.org
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
QEMU-based test results

- Booted with "slab_min_order=20"

1) AS-IS (before fix)
[    0.094926] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.097776] Kernel panic - not syncing: Creation of kmalloc slab kmem_cache_node size=64 failed. Reason -22
[    0.099542] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 7.2.0 #1 PREEMPT(undef) 
[    0.100903] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    0.102607] Call Trace:
[    0.103040]  <TASK>
[    0.103417]  vpanic+0x32a/0x4b0
[    0.103976]  panic+0x5e/0x60
[    0.104491]  create_boot_cache+0xe3/0xf0
[    0.105194]  kmem_cache_init+0x12d/0x410
[    0.105890]  ? mem_init+0x1fc/0x210
[    0.106521]  mm_core_init+0xba/0x140
[    0.107153]  start_kernel+0x441/0x8b0
[    0.107814]  x86_64_start_reservations+0x18/0x30
[    0.108638]  x86_64_start_kernel+0x10c/0x120
[    0.109401]  common_startup_64+0x13e/0x158
[    0.110145]  </TASK>
[    0.110584] ---[ end Kernel panic - not syncing: Creation of kmalloc slab kmem_cache_node size=64 failed. Reason -22 ]---

2) TO-BE (after fix)
[    0.008976] mem auto-init: stack:all(zero), heap alloc:off, heap free:off
[    0.011366] SLUB: HWalign=64, Order=10-10, MinObjects=0, CPUs=4, Nodes=1

Also, I'm not sure about the Fixes commit. Please change it if you know
a better one.

---
 mm/slub.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 1559cbace469..8400df7c222e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -8354,6 +8354,8 @@ static int __init setup_slub_min_order(const char *str, const struct kernel_para
 	if (ret)
 		return ret;
 
+	slub_min_order = min_t(unsigned int, slub_min_order, MAX_PAGE_ORDER);
+
 	if (slub_min_order > slub_max_order)
 		slub_max_order = slub_min_order;
 

base-commit: d755441b7672c74f29d1241ffdd2b067ecab1ca0
-- 
2.43.0

