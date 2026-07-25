Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3593546FD
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784981692; cv=none; b=XZ6EHAms5k6ct7lKt8F5Ui0XHLEDuqyMdLcPsjHAFqfDobXQS1RkJdwoGvu4ghnKCaqbJHsTda7LH3ezZIJftuq8pyFvrZIjZyA25Ae2brsQFnoau4MrkdwjSnGCaio0Wri4vtjMHkbDUaiaXp3Gp/Rz43+2BqEYz6McMb0fKW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784981692; c=relaxed/simple;
	bh=A0Tw8YiL9rzaH188xvNmuhgB7L7DOcmR8p8bSR/4tBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mp8vpQZI1LDlWWrKvSo2a2RXcowyEELNEUMBHomLcNin93JS5by9XLYImZ0Vg+ti5NPF+S+mluLReurJLFb+u5KGlJOW0BQfWq+6ZEGBy6MVq35GHvz+U86F/pqYK/rw6hQvkZ7ebsOZY9LZbEXLbREuVT/Zoe4EixZ9hDILCc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnVHgNsQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnVHgNsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAAC1F000E9;
	Sat, 25 Jul 2026 12:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784981690;
	bh=rNbhF75m4pf/5S6nu5OduzV+JiNHl5Xx4K64ECoI4Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PnVHgNsQBhFxioagX3O2ujwmAr+fXP7Ha1gBhVTXvTh1CAwUsuhCHzcUQZUoZbRmP
	 dfjqh5cb7af8yvdY92CVD5kR39clTEP0J8MogsUNsExal6V6ubMY/Yqec4CgOZtcmR
	 NPN2QkhYxsKL4hVXtKb3h1WZ8a6RrnoQinDZ47cc3bkGI5E2YpQfl5vWZy4QKD4tm4
	 4fl1ezA6RnikMjB/XayxbUoAjpECA3RtcCD++lfZUKih6QugS1loPKpUMzNJKkc74S
	 7VL0n9muiQWUhpmxR1NIqKFfao1L9wky4vONZSZIm+cTypt5opYkfm4yt/AFHrnzrH
	 8tU8cs+tcZ0Mw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Fuchs <fuchsfl@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mtd: maps: vmu-flash: fix fault in unaligned fixup
Date: Sat, 25 Jul 2026 08:14:47 -0400
Message-ID: <20260725121447.2570457-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072054-bronze-override-3d76@gregkh>
References: <2026072054-bronze-override-3d76@gregkh>
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

