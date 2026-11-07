Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049069;
	b=zSmeCdI35hIcqpLw9+W+FnJokKltMLi7Rr02B1Bi62smX+fv8E/5ACz4nVQu/Oj/3wDV
	 6snE2fDwo5k2m/2gNWb++bEF/F0QNgW8TlKXQ8j9fQ/iREsXmtBEipRs8oWJPYIn1K8y8
	 NnGcaSPKjFOOpKZef19+jPkt5xY8vvUjW6CRpa2O6KalVaZiLLGQ8LztE8jMecQ0fLvnF
	 PPS7z6ESUPYozuTN55nnWxfVFxFqkt7879twfbR6xv8G204Rac/rco6iLS9wY5r0aashu
	 HEuzlpRYsjo2SFN1htVRbnrB9RPPwLSC+S0H3dUGS7Oe1pDTbTBQYYOjnYZWJCkzIlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049069;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=45HCXZfmxtWcU9sGH/5sC7GIc2uXdhnfE5NZkHL1uDg=;
	b=380qh95CstgPthDZXVwgoJeQl9+/IYUIbuNImrXgO8H6fRfLDMA7IME5Wv1pCQznK3HD
	 60v98iuJbaEe7Zghx0sOxUNddetF5mA24nonAPSHeBH9Z8f8EHqfWuIOnef6sG0H/LxRw
	 YIQA1esLXZQKWFfYyFD8m0SFDzwUmIB/mwAQnHGzC4eNpeaoCR6gxRruylEl1niJiDt7E
	 ZHJrZzdreYmXhwi9QjIIJpaYa15oct3RlN1uekcfgDYhmdxJG/Q7F9JI8vod/tvJVPeuC
	 JFNEYjFR1eGzBKlpxkRdE6BgPXejxPfwe3sJDbMEkH78XffwnwYwUVqirrjawrkCdHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fsuTf4xe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188F6606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fsuTf4xe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880AE1F008A1;
	Sat,  7 Nov 2026 10:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049069;
	bh=45HCXZfmxtWcU9sGH/5sC7GIc2uXdhnfE5NZkHL1uDg=;
	h=From:To:Cc:Subject:Date;
	b=fsuTf4xeIUB1v68jRMiTm2Urj7xa92yHuaVMuwk0wgMA/dSA64fFpj6WPiyQk3yv+
	 WkieoIMi+3fxtD3N1abTRq/m27Z0LerBlUdBJhLXTH0qz2G3mCCdgl0aebmfmDb9It
	 ic3QHrxD+asgFiNRiRrGqiXcqJls2sy7x2k2HtzRjgBI+4idv0ptTSTEFvKU+6cmpp
	 jeXr/4olLeJLkwsKmUxVg5oyREFKfQpdJZ7QSaKCZiAWWC6dBdT7wz2XhIAC3MZBaZ
	 c2Tt9YfJW9HcuoO3Q/AmiLtEeuQYi8DtrJnZ01txikaiYlff7u8JfBpBvdlhaKO/Py
	 mo1h1E+VESVjg==
From: Sasha Levin <sashal@kernel.org>
To: rosenp@gmail.com,
	miquel.raynal@bootlin.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mtd: rawnand: ndfc: use devm_platform_ioremap_resource()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:57:47 -0500
Message-ID: <20261107055747-failed-5.15-0d66f9895f28@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 0d66f9895f286d2fab396a71e6efeb95c4a7e5a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055747-failed-5.15-0d66f9895f28@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




