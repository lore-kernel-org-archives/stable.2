Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6199331EAF
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784976883; cv=none; b=TSjuLo/tZL0GFem9HNKxvgIO81Tjmlij20upupzeQIFwSmDd2qDA6EYKKw6llQYoqfm3Fqii/jFqQZJnuhtxUxUd/UkFkQpGQWqdnp6iZxVocWGqzbRxmbfIB0w7LkHN6PrDitTSCnaiR3WdfSDN3u1kTZUQHJDfleVTkGJFzAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784976883; c=relaxed/simple;
	bh=A0Tw8YiL9rzaH188xvNmuhgB7L7DOcmR8p8bSR/4tBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=REJUKgJsHC+qlHRH35JpOcKDZR16beXoYp5KCBTZcmQhnQGtIa5Pr8fK9Gg7QlHl7DcHjMcsB0JOPKny/VGWhDSWCOgtTtDv6dog4z1SlhyFQDVlX9xQUI9t80i6fyMeXNPkvac6uK+GJoe3TOgWCSr9tpnBqd3/WSiT9WgxrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eC88unGu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eC88unGu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383031F000E9;
	Sat, 25 Jul 2026 10:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784976882;
	bh=rNbhF75m4pf/5S6nu5OduzV+JiNHl5Xx4K64ECoI4Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eC88unGukiBe84feXGhyZgccgQ7jYnufDImPZe1hxbEIzMrovdRhq2CsddGo6BDi9
	 OTAoxp5hs7Bq3YeqnmZv3MGg6VBlnZXjsA7PzedUDVdoHsa/1MYiJkbvoB+cH7G+Qw
	 5tzntPAIvq1u81LVttu60wGC3i1q+Dd6J28aPwkMxreYfShOXnMe5MEyfimvnslB0L
	 +ITxDsblKkxQ7NjBKKt4wHKs3v4GEwBAPhn9QqTGKquCcsVj57SRSD+hqf/3HRFuXd
	 QHLZURIo54XfoJJGW6IJeML2ov6VMRReECzeFBXhSSs9sw1MmqFRUf3C8UUi8471jo
	 aY+QWKCoiG7jA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Fuchs <fuchsfl@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mtd: maps: vmu-flash: fix fault in unaligned fixup
Date: Sat, 25 Jul 2026 06:54:40 -0400
Message-ID: <20260725105440.1854110-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072054-king-ranking-9254@gregkh>
References: <2026072054-king-ranking-9254@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Florian Fuchs <fuchsfl@gmail.com>

[ Upstream commit 79d1661502c6e4b6f626185cef72cf2fa78116e1 ]

Use kzalloc_obj() / kzalloc_objs() to allocate the memcard structs,
instead of kmalloc_obj() / kmalloc_objs() to prevent access to
uninitialized data.

Fixes runtime error: Fault in unaligned fixup: 0000 [#1] at
mtd_get_fact_prot_info.

Fixes: 47a72688fae7 ("mtd: flash mapping support for Dreamcast VMU.")
Cc: stable@vger.kernel.org
Signed-off-by: Florian Fuchs <fuchsfl@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/maps/vmu-flash.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index 3667faefe6c58f..e992f4d1417e6f 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -610,7 +610,7 @@ static int vmu_connect(struct maple_device *mdev)
 
 	basic_flash_data = be32_to_cpu(mdev->devinfo.function_data[c - 1]);
 
-	card = kmalloc(sizeof(struct memcard), GFP_KERNEL);
+	card = kzalloc_obj(struct memcard);
 	if (!card) {
 		error = -ENOMEM;
 		goto fail_nomem;
@@ -628,15 +628,13 @@ static int vmu_connect(struct maple_device *mdev)
 	* Not sure there are actually any multi-partition devices in the
 	* real world, but the hardware supports them, so, so will we
 	*/
-	card->parts = kmalloc_array(card->partitions, sizeof(struct vmupart),
-				    GFP_KERNEL);
+	card->parts = kzalloc_objs(struct vmupart, card->partitions);
 	if (!card->parts) {
 		error = -ENOMEM;
 		goto fail_partitions;
 	}
 
-	card->mtd = kmalloc_array(card->partitions, sizeof(struct mtd_info),
-				  GFP_KERNEL);
+	card->mtd = kzalloc_objs(struct mtd_info, card->partitions);
 	if (!card->mtd) {
 		error = -ENOMEM;
 		goto fail_mtd_info;
-- 
2.53.0

