Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E3B345EAA
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 11:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784977370; cv=none; b=dVu4ZpRPOmnoku+pKple2FSJtKvS3peTjeUMN4cEbfsw+z035jJpY42OgctJyjvMbAJrpTUtl5aV7KzsF9Fy7QLAGVZ+Wy705bNOlRNJs8jaRpdJhN4mhWF8i2zRFIv5NUIeSVIV4lbCgEKlaRiC7pRXHRcWzO4E8n6JnHA/jLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784977370; c=relaxed/simple;
	bh=A0Tw8YiL9rzaH188xvNmuhgB7L7DOcmR8p8bSR/4tBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pqK7ie/00SXv/3g+b4bZ154tGZw0ygvMonDzO9m/shaSgy2z/W5ExzwYtCTaH+g2H4TCYd70ewbRuSU78Zkt+rknd8PAm+nYv9eYsRxTf6X16pB6KtcjtBKj+Ali6el0XsuNEZypepcl0XO3SjRsHY913FYG+VAwj45n+8CDaO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KAu8o+s3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KAu8o+s3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 126901F000E9;
	Sat, 25 Jul 2026 11:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784977369;
	bh=rNbhF75m4pf/5S6nu5OduzV+JiNHl5Xx4K64ECoI4Rg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KAu8o+s32Ivy8HQ+PmqoA5IAqAyIwV28BA3uaCiWGb2Ocx7046+s1E9v+DxvLdhJf
	 bGhjymiK1/kAu8cvvUHNnnrQ5hr8FXxY94NgIl/QngcM6G0gDRfeC5YpudH4sTdQjs
	 Lusqef+2waPAdSQ3MdUI5Yc8RaSCJbTTEHpmCLVR36ppCSZxkeesDUkFfzxzt5mLCU
	 Br2cAyuCxCsz0PBlOZwLEzoYrAKY2lLpuSL8kTn152mjf3/Qm+lReF6kvthCH/44Zq
	 kIA4alFgqKU5El3pP8grbukv5oLj8HVfRzTF0scYxA03urFmZxf+SYpVHRI4rPdOJU
	 16AxlQvLYfSVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Fuchs <fuchsfl@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mtd: maps: vmu-flash: fix fault in unaligned fixup
Date: Sat, 25 Jul 2026 07:02:46 -0400
Message-ID: <20260725110246.1858961-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072054-croak-unfixed-9a14@gregkh>
References: <2026072054-croak-unfixed-9a14@gregkh>
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

