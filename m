Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B00D298CAB
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784992950; cv=none; b=GSc8fNqwp1T/50qftq+0HhGK6buBNZVOumhbA4m0kF0C7x+VpDuSdOpaVhGdbNsEeHWuiF9rcA6NuI/EewnU3eUIZe5qnEpblwJvbaVPV2SjJxi1A4mdSo08F4ucrjb6C6ID4V4tgJ6fEL7dGO93kXZKvTg9cEB2i6bHD4lxx+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784992950; c=relaxed/simple;
	bh=I1pMA+lSZiNLTUfmhzN2RvxECOPm/lHJqszx/d4er4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nV7lbsAmg0Ys+uwuVuis4ztCDiyE9rHoCzFmM4wZpWe0K85u8DEh+ichbzWgZuNX/FvKnANDsQID5RMRShfPSVRvWDhtA9fyonK66aES5W3Gw2xr0HuU+oXe+z5XhVxoUM/x7tY6X05dJsgXYrLFMbjb3iZYOjoldX2bLy2OgHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLKlREBX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLKlREBX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5269B1F000E9;
	Sat, 25 Jul 2026 15:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784992947;
	bh=AzXQSKoEM5O9g7keCCkgQnaNzlu2cb00dAIgQkmVwd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hLKlREBXydScSlPXIuDruqELNYfmdG43gtzMTVxEATbapOuAM/YyRigiOJSddwByJ
	 H7PoBFB0gmjjd9y72Nt5hCYApaUMvlWZwqwA75qZXAyZ7NxwOBy7GtdQK7G3SKX7Fv
	 OpGqvnEPsjss1H1sXQPzw0gdjZiXlo/F3KlH35Rl6+DgbO/1TWmZISQ7bgfkCPJLPw
	 7vZ094qI1aEFW6/dkKOYe5ulF1ec4Am22Xoquoq42yuqYgQzgmMfbMrRDAb9pBsjwt
	 dZXgx8/riRh17RCyDvk9NpvoBTrRnSbmxpnKBvObo+Nd+7adhvOa6qSZIae8KE4yOu
	 6qZdeN+bV/yJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Fuchs <fuchsfl@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mtd: maps: vmu-flash: fix fault in unaligned fixup
Date: Sat, 25 Jul 2026 11:22:25 -0400
Message-ID: <20260725152225.3856910-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072055-excusably-purge-be46@gregkh>
References: <2026072055-excusably-purge-be46@gregkh>
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
index f96a165fccc7cb..ad10f7887dfa0c 100644
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

