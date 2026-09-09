Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1784A0123
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947943; cv=none; b=AqJGo6EEBWytjgi/ZKhi1NNgqzF7Ha2daO3m1nAYV3bbpJ5mUeM9hg2+uAkB0QP9pjA/8lmmtFo8wPpGosno6Wi1JjyY/VnnVbitHp0UC4t5LX0dbs4HZdXlOBQd2qgkiWYQoQ/6kIREPpXfA3eHDuj86wMar9jL+smRC/MJCDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947943; c=relaxed/simple;
	bh=3uMHrejs9NKnEjf32OgmectyT0Bnpi3I39A614yjwLE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YK/YWOWNi6np6++7lpr0h7UwM8Hu2Z5J7ftY7JtJhe37ygndnvtozzUloFtcWi4sO7DAle+PF/yLBDs5AeX+4gUYJ1KHoFzm6TqsigPdkCvVZaEOJ37VkyKiYk4Y9Ifm6uaaiDS/2kGTfuxucFeICGAEn6pvRIQYgz1gS2aA3HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zc44Hqxk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zc44Hqxk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FE81F00A3A;
	Wed,  9 Sep 2026 09:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947940;
	bh=l4W2IAXd2pSey6tY5l5mxE6UDvl3GD52eaABgaU/8Do=;
	h=Subject:To:Cc:From:Date;
	b=zc44HqxkxSqlqtWjnaXdxpDDS+ctPNJh1tjblGyhofoZLK/DI5GHwXRmfI/jTrJbm
	 7zFUJdzayIRkM2VHWEhL83tftT4M/oagiRbUSXjdTJN+VAXFlHXCVcuJm2FQO2+J5+
	 beXZaQfGMExER88aAtn4eFDxTZT22Cp4seWQIC+k=
Subject: FAILED: patch "[PATCH] mtd: rawnand: pl353: Make sure we use the monolithic helpers" failed to apply to 6.1-stable tree
To: miquel.raynal@bootlin.com,andrea.scian@dave.eu,michal.simek@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:55:28 +0200
Message-ID: <2026090928-shrubs-fax-9803@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 80ecacd054ffeb60cd28e46ed5cd6bd0d2de318b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090928-shrubs-fax-9803@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 80ecacd054ffeb60cd28e46ed5cd6bd0d2de318b Mon Sep 17 00:00:00 2001
From: "Miquel Raynal (DAVE)" <miquel.raynal@bootlin.com>
Date: Fri, 29 May 2026 18:29:57 +0200
Subject: [PATCH] mtd: rawnand: pl353: Make sure we use the monolithic helpers
 for raw accesses

Any access not using the hardware ECC engine should be monolithic
because the controller has its very own way of handling the end of a
transaction during operation configuration, so we cannot easily make
repeated reads.

This has the side effect of fixing support for software ECC engines.

Suggested-by: Andrea Scian <andrea.scian@dave.eu>
Cc: stable@vger.kernel.org
Fixes: 08d8c62164a3 ("mtd: rawnand: pl353: Add support for the ARM PL353 SMC NAND controller")
Signed-off-by: Miquel Raynal (DAVE) <miquel.raynal@bootlin.com>
Acked-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/drivers/mtd/nand/raw/pl35x-nand-controller.c b/drivers/mtd/nand/raw/pl35x-nand-controller.c
index 7dd71bd69deb..0ce3796d161f 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -917,7 +917,6 @@ static int pl35x_nand_init_hw_ecc_controller(struct pl35x_nandc *nfc,
 	chip->ecc.steps = mtd->writesize / chip->ecc.size;
 	chip->ecc.read_page = pl35x_nand_read_page_hwecc;
 	chip->ecc.write_page = pl35x_nand_write_page_hwecc;
-	chip->ecc.write_page_raw = nand_monolithic_write_page_raw;
 	pl35x_smc_set_ecc_pg_size(nfc, chip, mtd->writesize);
 
 	nfc->ecc_buf = devm_kmalloc(nfc->dev, chip->ecc.bytes * chip->ecc.steps,
@@ -984,7 +983,6 @@ static int pl35x_nand_attach_chip(struct nand_chip *chip)
 	case NAND_ECC_ENGINE_TYPE_NONE:
 	case NAND_ECC_ENGINE_TYPE_SOFT:
 		dev_dbg(nfc->dev, "Using software ECC (Hamming 1-bit/512B)\n");
-		chip->ecc.write_page_raw = nand_monolithic_write_page_raw;
 		break;
 	case NAND_ECC_ENGINE_TYPE_ON_HOST:
 		dev_dbg(nfc->dev, "Using hardware ECC\n");
@@ -998,6 +996,9 @@ static int pl35x_nand_attach_chip(struct nand_chip *chip)
 		return -EINVAL;
 	}
 
+	chip->ecc.read_page_raw = nand_monolithic_read_page_raw;
+	chip->ecc.write_page_raw = nand_monolithic_write_page_raw;
+
 	return 0;
 }
 

