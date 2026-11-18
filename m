Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794961579;
	b=X1MM478O3nXJ5In+KBAI1RpiJ8rkcfXE0D3X2TV0XYt9n6sRpPEsmEzYB2i42AOYiXZH
	 r7c4PuRo3asP9EdYYbAn5HOgoSI9tKVsNPSgbuBj5Nn67uNRPQmG6oFMG4yxmlDJMrrHq
	 sMHZFOH7VXVrYuVGl8yO7L0153sT/CQeCG4djXYPf/ObL6lFtLp3RW89I3oUey5KGSqUn
	 FbcbyILVslbtT99z3X6z6V/TsKKN+vwN1ML7/lur6ecs3F2AHybNTevNm07hUuWGvNh68
	 zw0/td+ztWSMjfCG7FyCQinBCdmJuJHgugrzdaI84A3qnrkxv4GvczK8yjx/hqQIb8g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961579;
	h=Received:DKIM-Signature:Received:From:Date:Subject:To:Cc:Message-Id:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VYtG6DGXwBzTTL55vHMHEJqWnxHnMS2plSXaGsf2ruA=;
	b=Z9Ubqh5Dc3z971SU6W+c9jkkFq4Mb/0F10tdV7B/g1vx/4cCBD6U5VNFB/+Qf/bceKRN
	 GWCtf6gB2j0HaHjBbRDR8ybwwXmSL9Gzzv19/vNECv5PuqfVQ/KfTGEtICy3pq08TzM1x
	 E91PFg8PK+8/VNl+ayLg5/QC+0DV5ZjsPNByEmzkcqniNXfdlHlf0mx3byxPmY/zQlR5o
	 rnNRIlrp05TI0qhjtWu0/qYSqFE1EJvFWz9WaeXwU5OscrgEVXiXyHosr96JnUq9munuJ
	 IBhaLs4JEymdd7IdDhXuqnIovacXpac1eDmPqOWBc1PPO2sBjxVK43RrNL1LcIu+tVg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDc23IAN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4E1606A32A;
	Wed, 18 Nov 2026 00:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDc23IAN
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794961578;
	b=MdTQPEr2+z7Kd2bCXAKxxMWNxFX4pYlMxXa3nvVxPBRcXwgRKpv0LrslIXc6kQnDoaV8
	 YUiyOo/22tnhNSNOnGvAhzSe1HWemFvYJ1MvuXcR8WFThCc4OUj3F41dUz3TV0YBQJH7v
	 MhPi1gTv3kh9THGl4S415/XsfN13xjFleyxmnf+4rSfU1kemqJXmzia3tOORVPykr1SmY
	 15Pa5ieOAM1z0c3SjaAS5jvoFbgl+TpYOKosI2leMsViTZ0AU3VsfP4Mhp/+6eKwMnVF5
	 ouBxqo04VvSd/RXqCw1yellGs59AzGRxTcCkQYV4QeKk1IMofwPM5XYJ7vO/Yg5/57w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794961578;
	h=DKIM-Signature:Received:From:Date:Subject:To:Cc:Message-Id:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=VYtG6DGXwBzTTL55vHMHEJqWnxHnMS2plSXaGsf2ruA=;
	b=aHrhD9Gz7gvsS9La1TLIwmAP4I2oqmxapiqGXpeYmvQuS74Ls23NhSstWS52H/D73RdJ
	 jPD6pdCVcY3OmmZCXqAL8ZUx4i4xb9wINQyeJv8sIP3T5W4zwJYqzNVxDy96fU3Qqu6L2
	 ePRACaZmeOxdhuVX5cxuM9R3IOoYLUADb/i1oXC9VWekQCqzWKeF0LN5+jTiuMmJEbDWB
	 MXaWZiTY8WLpBPZIT+Uziwo49umzSHrf0A+F6exx7WMUgW4o/yl02BQzjX+TLY5l5siQp
	 9LJEaEbbl1NUhtbZxCyvddgTJDe5VWKgIlAUuq9ID5DgukV5Dawo7wjGMxDEKbeIguw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 510F91F000C5;
	Wed, 18 Nov 2026 00:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961578;
	bh=VYtG6DGXwBzTTL55vHMHEJqWnxHnMS2plSXaGsf2ruA=;
	h=From:Date:Subject:To:Cc:In-Reply-To:References:Reply-To;
	b=oDc23IANf0Hl5efMJ71Ivbc8Z33+vK0Zo3PBJjNaEhZk0p2WwLFvGcENFK4isv/NX
	 7tAZFYjwSUQ4Re9wh2Zu350E2B7J2eIGSsG+bL/7H9nfAmbiEV9g4fy7ZiFB7RYwYr
	 pFwSAknGAvAN+9Pu9gKPeyZ45w34kIcg69t3FkbbfOphGKT8f6R71T7RXOocA6WzoH
	 KBsYDDOK5ugoeMvgHSKsNvI4DRrz6EMBqYGwHFWgNqIL5PVpz8m1sR3k/nV7R1BMhK
	 g5tAV0XLJt+78W7kSimP7dzrI+81tKNf/8K3BEwWvsY6QO71sV0OjdojDu9itRlC1V
	 iss7D+3ButE/A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D0C334AB72;
	Wed, 18 Nov 2026 00:26:17 +0000 (UTC)
From: Matthew Salsamendi via B4 Relay <devnull+matthewsalsamendi.gmail.com@kernel.org>
Date: Tue, 17 Nov 2026 16:26:17 -0800
Subject: [PATCH v2 1/2] fs/proc/task_mmu: reset walk_end before each
 pagemap walk
To: Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>
Cc: Chris Down <chris@chrisdown.name>, Vlastimil Babka <vbabka@kernel.org>, 
 Muhammad Usama Anjum <usama.anjum@arm.com>, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, matthewsalsamendi@gmail.com, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Message-Id: <20261118-pagemap-walk-end-v2-1-94cd92d838b3@gmail.com>
In-Reply-To: <20261118-pagemap-walk-end-v2-0-94cd92d838b3@gmail.com>
References: <20261118-pagemap-walk-end-v2-0-94cd92d838b3@gmail.com>
X-Mailer: b4 0.16.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794961577; l=1428;
 i=matthewsalsamendi@gmail.com; s=b4-kernel-20261117;
 h=from:subject:message-id;
 bh=7qGs2hd6Xj+UHbWpzY0D12fJy01dF02sQB04QPCEhTs=;
 b=Mc9ZX82EqhXsHrPuC5JbOue8KSUJJJe+aeJNlnoQt1oDt7qh63ZBSqkMCdmrEMHJu/jJe1kqN
 yPXCwPuokCXCNL51/tvJiRSpZrCbS+ZSW/xH8TYix1x9mLmSaQ/5PNB
X-Developer-Key: i=matthewsalsamendi@gmail.com; a=ed25519;
 pk=K4Lg4pTU46IL2CPz2Nb/u30nsnWJ38MlR2/Co4n0tto=
X-Endpoint-Received: by B4 Relay for
 matthewsalsamendi@gmail.com/b4-kernel-20261117 with auth_id=1555
X-Original-From: Matthew Salsamendi <matthewsalsamendi@gmail.com>
Reply-To: matthewsalsamendi@gmail.com
Content-Transfer-Encoding: 7bit

From: Matthew Salsamendi <matthewsalsamendi@gmail.com>

When PAGEMAP_SCAN resumes after filling its buffer, it can return ranges
beyond a stale walk_end. This aborts a production game server during
dirty-page tracking.

Reset walk_end before each walk so a completed scan reports the end and
a partial HugeTLB write-protect request keeps its retry address.

Codex assisted with diagnosis, validation and this message.

Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
Suggested-by: Chris Down <chris@chrisdown.name>
Suggested-by: Lorenzo Stoakes <ljs@kernel.org>
Cc: stable@vger.kernel.org # 6.7+
Signed-off-by: Matthew Salsamendi <matthewsalsamendi@gmail.com>
---
v2: Use the per-walk reset suggested by Chris and Lorenzo.
    Verified the 513-range refill and 2 MiB HugeTLB retry on x86-64.

Stable: The bug is present in v6.7. The hunk needs a context adjustment
on v6.7 and applies unchanged to v6.8.

 fs/proc/task_mmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index b87d3e86442d..8723ffbff77c 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -3155,6 +3155,7 @@ static long do_pagemap_scan(struct mm_struct *mm, unsigned long uarg)
 			mmu_notifier_invalidate_range_start(&range);
 		}
 
+		p.arg.walk_end = 0; /* Reset partial walks. */
 		ret = walk_page_range(mm, walk_start, p.arg.end,
 				      &pagemap_scan_ops, &p);
 


