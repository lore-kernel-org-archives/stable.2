Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045988;
	b=tTYeadCdpvjANTMjBmihnEQIdKRzZKQwM6qSzu9N0v/oN6nTDZN1EPT0yfcWZ5dSlRZ0
	 66BuDvRSwTYgAs+tq6tY1p8v/mNFfbCCzdxR/IZHoLbt2B9tRNHUSz4CC8IohyN6thBQb
	 0g3p55YHRUna0zUoFVhCjdtRL/v/MltrYuP+uPxd59hhDobA4SAz+pismxgx1sTx7pwAW
	 /vuFj9IWzGrfdxY0Q8ge6thEuBAnt1OTKtfKDI2+k/TjionvAYqBqsAqLuaabws3SjXc/
	 axh5DuHJ7k+8Gwzf10V5kJRXRLPOsETE9dS0Sdc4TLS4nNOPOsX7qvfXG1buhQTsnyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045988;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iazoU4tL/ZNyR1NYZTvp5wnprGiN1HBvb7fLB0lJwRM=;
	b=07H01AGrAuH7TrlCLgi+dXTUI8YVFb4YHWBn6e3iiiJk3UKSTFQn8eJyB4VY6vFkj9KQ
	 VFjMk6sTlu1FLDtmsiku8PlcHbZ66jRljEqIOWiu6YvZ2ukxwKuu12qYSAaS1Q39qoPgq
	 NLB4zGCeCxx8G/REkul/TPdNfwNUOUpirmdJa13G5OIJYc/4nokLkXKMATGdsC6I1Ft0P
	 dGQ3jhMFVYiQ8qL8tmCOaOE0iD0fUmawCGA+6dVVYSSuWaOep1G+I7XhabnkRaCaBdCxx
	 DSVEVAjCvbp0/AOKoSWqmqHOHcUly0p2JPbZyawyn5CklkYYxU1m4Pqjx0v8xZRO44A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHJxl7bz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF2F606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jHJxl7bz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA03A1F0089F;
	Sat,  7 Nov 2026 10:06:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045988;
	bh=iazoU4tL/ZNyR1NYZTvp5wnprGiN1HBvb7fLB0lJwRM=;
	h=From:To:Cc:Subject:Date;
	b=jHJxl7bzbV5VoJEwR3nOPvXK/Jx2Y34w+OeaP5+jIEt4E00lnZ/BECVewXDINJfeY
	 SthG9vRI/thEC6qfQ4cje3Q8lkle0BdxH+b968itqZR+H+XNpVuRtujRZ9uFM3E5iA
	 WBmy/gXOLeM5bIhu5vSNtBIqUtd0el5UQqjJJZZ8/WdBGK+6QIrdBKyUznorV/qMl6
	 PXz8+RtPQ5bU6z/8q/6SiRvd9AdHZm0EP4+EZIdW23ySM9Kd9V4e4NBAbWSZN7Ur6I
	 UxjqGOx3sa7LBOEHSSaxBDL5GBEOS/4tXDlJtkn0jmNIkRyO8GXZJB4fqktqiMTYzk
	 I7pH3XY9NOBVw==
From: Sasha Levin <sashal@kernel.org>
To: rosenp@gmail.com,
	miquel.raynal@bootlin.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mtd: rawnand: ndfc: use devm_platform_ioremap_resource()" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:06:26 -0500
Message-ID: <20261107050626-failed-6.18-0d66f9895f28@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 0d66f9895f286d2fab396a71e6efeb95c4a7e5a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050626-failed-6.18-0d66f9895f28@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0d66f9895f286d2fab396a71e6efeb95c4a7e5a6 Mon Sep 17 00:00:00 2001
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 24 Aug 2026 13:21:20 -0700
Subject: [PATCH] mtd: rawnand: ndfc: use devm_platform_ioremap_resource()

Replace the open-coded of_iomap()/iounmap() with the managed
devm_platform_ioremap_resource() helper. This fixes a mapping leak on
driver remove (the old code never called iounmap()) and simplifies the
error path by dropping the manual cleanup in ndfc_probe().

There is no overlapping memory-region concern introduced by this
change: each supported board DT describes a single ndfc node with a
unique 0x2000 register region, and the EBC parent uses dcr-reg rather
than a MEM reg resource, so the newly added request_mem_region() cannot
conflict with an existing reservation. Distinct chip selects map to
distinct 64-bit physical addresses, so CS instances do not overlap.

Fixes: a808ad3b0d28 ("[MTD] [NAND] ndfc driver")
Cc: stable@vger.kernel.org
Assisted-by: opencode:hy3-free
Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/nand/raw/ndfc.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/mtd/nand/raw/ndfc.c b/drivers/mtd/nand/raw/ndfc.c
index a48274297d3b1..d6db04d48c45a 100644
--- a/drivers/mtd/nand/raw/ndfc.c
+++ b/drivers/mtd/nand/raw/ndfc.c
@@ -185,10 +185,15 @@ static int ndfc_chip_init(struct ndfc_controller *ndfc,
 static int ndfc_probe(struct platform_device *ofdev)
 {
 	struct ndfc_controller *ndfc;
+	void __iomem *ndfcbase;
 	const __be32 *reg;
 	u32 ccr;
 	u32 cs;
-	int err, len = 0;
+	int len = 0;
+
+	ndfcbase = devm_platform_ioremap_resource(ofdev, 0);
+	if (IS_ERR(ndfcbase))
+		return PTR_ERR(ndfcbase);
 
 	/* Read the reg property to get the chip select */
 	reg = of_get_property(ofdev->dev.of_node, "reg", &len);
@@ -210,11 +215,7 @@ static int ndfc_probe(struct platform_device *ofdev)
 	ndfc->ofdev = ofdev;
 	dev_set_drvdata(&ofdev->dev, ndfc);
 
-	ndfc->ndfcbase = of_iomap(ofdev->dev.of_node, 0);
-	if (!ndfc->ndfcbase) {
-		dev_err(&ofdev->dev, "failed to get memory\n");
-		return -EIO;
-	}
+	ndfc->ndfcbase = ndfcbase;
 
 	ccr = NDFC_CCR_BS(ndfc->chip_select);
 
@@ -232,13 +233,7 @@ static int ndfc_probe(struct platform_device *ofdev)
 		iowrite32be(be32_to_cpup(reg), ndfc->ndfcbase + offset);
 	}
 
-	err = ndfc_chip_init(ndfc, ofdev->dev.of_node);
-	if (err) {
-		iounmap(ndfc->ndfcbase);
-		return err;
-	}
-
-	return 0;
+	return ndfc_chip_init(ndfc, ofdev->dev.of_node);
 }
 
 static void ndfc_remove(struct platform_device *ofdev)
-- 
2.53.0




