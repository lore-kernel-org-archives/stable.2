Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048074;
	b=uPLe054TpBnxNS8i4jTQmKRnl2LT67NRK62beMhB69dujzmqBygGZHtRckTO7fSlaoPH
	 RIUmajfjfJeajarWndjg9C67ySe39AyLzaDHBc9/4TlQdr+jsEMLlGsk655AjoslnfHgb
	 fYm3cSiJySWRdJmSdsAOsv+fFm7iKbN4CCfaE7uIJ8C31PUn4T39UuTQbcN46wNERiSvD
	 xvvHEcsA7H3g+JQ4+QZctJR6w4mxIhcw7f3HIYreT0PE9+I1FSgJCHaAtkvdBkHU0933i
	 S23emgPvtL7RTK2V5gDS7myNch4OSVGqEyi8KeaYjL/i03aMhy+UGgWaSlcYrug5OIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048074;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=POQrQtFm+5aYv4fqcLsgHFc0E9TElx68qVQNMjww1gQ=;
	b=LvhbLe886ddNo5wxXyO82bXRzl+AphpmLpQoffrYS6+mgl6oXUgqSJKcE6pSK4BUveOo
	 aHobN1oTusUPSsK2x9cPN4InLOyM7G80/rtnrayZvpmh8cqpFI4HBJvUoaEvvjDJJtT7D
	 gMqawcD2m8l7fd1txpmZG5aCVbtfB1UlV00p5f4XznfexVKSdcDHosGzxfMX9R7IeTpMT
	 TWe/xy33JhfdLXjj9wufWNmSx3cEfMsypP+6yuO8AhZZ+wfgD99P19urqUgoXTnees8Z9
	 grbiYF/cz1T/tSGmv6M7smuAGiJLr6wW6AkQddcDNXxh6TCG1XG3M+PgvYAVjovA6hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1iVg6wr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15B3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1iVg6wr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA581F0089F;
	Sat,  7 Nov 2026 10:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048073;
	bh=POQrQtFm+5aYv4fqcLsgHFc0E9TElx68qVQNMjww1gQ=;
	h=From:To:Cc:Subject:Date;
	b=U1iVg6wrxC7Xy9bvt1z9thpNo9RYUhZhvwvt3F9figGfxT9QtTb/PDMbNHrIFgOkW
	 EwMeR7Zww5V7nu42dbukFkzrNvb7qjafuiQ64aDZ09Nfb2Tfs/IDdsMH0vQvEeg8sL
	 2VNr7JfR3Nuy7Zm9EwJc77MpAoI7OtZn5kVlUXYyBRNw78IYgZDZuUYrpAvtO7tezZ
	 y5XfMKN8vDmWnM3V5VsDZvmG+OWQEY3hRMSan8ldCxsFXlHxmq5NByZ7VY76e0M+xI
	 bId2oldqJJ6r1/+gMAFk0TfrgihK0PrygsIBbHceKyA+gXKmsktGq+3UZnZ3qsVD9u
	 9bbS8hm+4FuIA==
From: Sasha Levin <sashal@kernel.org>
To: rosenp@gmail.com,
	miquel.raynal@bootlin.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mtd: rawnand: ndfc: use devm_platform_ioremap_resource()" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:12 -0500
Message-ID: <20261107054112-failed-6.1-0d66f9895f28@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0d66f9895f286d2fab396a71e6efeb95c4a7e5a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054112-failed-6.1-0d66f9895f28@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




