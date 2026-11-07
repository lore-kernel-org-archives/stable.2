Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047323;
	b=iyP6rCRO/eXiYENbGQ0hehGQQ2Mg0aoaGrB+Nbk5QEEnILQve9robZtToN+xOb2HYWOM
	 Oy3eGWBAxo6crnKVPaTinrijJEgZh+/oGjbfq6cZulIWFDZaKImbbWeFJ3U1OYHRyZZHc
	 /1RPqVSRP4q9fb/Nj0idZsTjOZ4mXAciBCPFjzxBF+SfxcVc6GTIHlTo9z6fo1r8vsUY1
	 opL38cqJAzNeruirUW/mNKTB/CcUoK406Y9GxY0LCE6w4guOgGTlmH51ayOhWW6MZdJnF
	 7Bcw3pdiPZClU4kxGHMt3ufBnmzvKd3dyovQojUNEFpv3TBo5wHecQVU7AJvg2XGfng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047323;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=k8buaW1ltT+Q1akg19oXp4dkfitIDRxC2KsTb8OwdWE=;
	b=1HVmyy5Bkv8gsKSxchqG9ZtoP4TuDKH84v3cq/IXjxTw9pyLdNnaxXK2Jg48eQl18UDj
	 hiafclC+e8ZqMLveYtN5MJdNvsj5RgwxtoF+XKpBOX+kt9huR6CburOXmIbZmbl0Jp+3v
	 BWR/Ys1fa4VcfLW4MiabRKosnsx/jbkseVLaG/QkbPdchPYZNgv+leVCUjfUx97i+9epR
	 cwtswwixAGNa+wRFWMJ5YJuWN9Rqhj8Z1tP/PL/0hfzbD2CpPmw/+i6HiL4AeTLSv0pUw
	 TEvdE3RVG9zkqYryCym5oQuY/4AyBywcPujShPvw5YjYCUaYa4iqB7elNV192rZdgig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVZYM0ju;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FD7606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVZYM0ju
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354BF1F0089F;
	Sat,  7 Nov 2026 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047322;
	bh=k8buaW1ltT+Q1akg19oXp4dkfitIDRxC2KsTb8OwdWE=;
	h=From:To:Cc:Subject:Date;
	b=PVZYM0juN5TzJDREBUnq193kHp/ijMnBb0bcqtjgmP6CJEzSSxWpr9kabQ+wmevZ7
	 P2afrkQIbaOuzJB6TnaM6IimL45kZs+7nr5CSVLreUVxbJQUr3F9BW6CwCQxOs7k1Z
	 6/WlW8omBv6FD6atm9ecQsWJsZQUVMIxWQ7evJdla18wF30ZnN5XZCKJzH7p8OrLsj
	 AfsdDtAlsMt43rRrA5VCbB5z0268StG/CmEwMcMwa6S7xgsune6jusm2yKwlomzoAu
	 8+P59G+K8fz6Af7UoLSL8ZThdObQae7Xg0ME9dCtJ1IlYkPIk6dqgaPM5kVKeoBHhN
	 1pDNaAPdLRXAg==
From: Sasha Levin <sashal@kernel.org>
To: rosenp@gmail.com,
	miquel.raynal@bootlin.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mtd: rawnand: ndfc: use devm_platform_ioremap_resource()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:28:41 -0500
Message-ID: <20261107052841-failed-6.6-0d66f9895f28@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0d66f9895f286d2fab396a71e6efeb95c4a7e5a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052841-failed-6.6-0d66f9895f28@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




