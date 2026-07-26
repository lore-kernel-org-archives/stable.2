Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ACC3AC0C6
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785067244; cv=none; b=A88uKjtisA29ArnLJWDmg3+9RxBQ/tAzoWdlhx3tgy46p3K0mvEs6FrMW5Bj/2h6/Gcdf4sBl1TXo3nR7WlteM5Cf0nJbdB7g6mqG1eyaZvLAAmrEDtKkOLIz//iGl6rBeBhRgKB3DZL3hc02mVv5yZnqZ0QAh46niq/nnI8euw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785067244; c=relaxed/simple;
	bh=I1pMA+lSZiNLTUfmhzN2RvxECOPm/lHJqszx/d4er4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0aJd4GQmIDJiBHcrRZD+nxO7pc08b4VVzaL4CeqPLM3MzxZs4eRmFo9NIIn4VUpcoDj3OH7L8RAmrV/2j0UKQq6FHqRV6mN9QGGz4nQ95LwdgpKXP/VTXnPCSgt/RrFCUEBN1GZw5n/XdgHRCwmvMp1KAcpJ5TWCvV/nQ/U4Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSg7XDSk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSg7XDSk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1A1D1F00A3A;
	Sun, 26 Jul 2026 12:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785067243;
	bh=AzXQSKoEM5O9g7keCCkgQnaNzlu2cb00dAIgQkmVwd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VSg7XDSkvDLizNrnGeyh93P+IvD2rmZWm7sMm7LIum4rkMTr7l3kdU0MjwdqH1eOc
	 Fsgw0gfdMeaQnYRTJM15fgPYQ6AoVV09geDA4/EFCpQOlno7Tu+pJkFRYH6S+p4bw8
	 lyGxwy25w+F3isdPs9SmpEAuO1e1313cirOwwRVtAkrQa8TMJWdPIypBg2T/jOfZY3
	 XlmxdOIg8zB0kUWLryWaPOkqSD/i92YeSt+v8B9y5HwIxyiEXU71vg6dbzXCD6rkLC
	 LNYLLsyFpIbMaLoVUg10hyhi/J70MsraGls1C81hD3KbybzQ22zsnP+aOPgLMbwkpq
	 miqxBND10fHWQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Florian Fuchs <fuchsfl@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mtd: maps: vmu-flash: fix fault in unaligned fixup
Date: Sun, 26 Jul 2026 08:00:41 -0400
Message-ID: <20260726120041.4138089-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072055-underwear-richness-fd5f@gregkh>
References: <2026072055-underwear-richness-fd5f@gregkh>
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

