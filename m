Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076D847125E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788947939; cv=none; b=cWWIDm1+BDvdezwniNfMDj7hEEBt02D1fJ5djozMekVksferQTP6bN0i164chmJmuEuHaiFUAKuREPXf0skDwnf5P17NweGSFfUm/fdkCh7Zr/ft3jioC1gDM/saPkCohwIaJj2vqMIOHwnlche1bJunpss2TUHRFEHh3fEIaOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788947939; c=relaxed/simple;
	bh=dkkDYHSY4oBd03g137dS+7lwI72kLWy/uTrMymCguag=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Q82HVL/fomUmKL4a8fZoniTmEacbDQI70eVF1mB2lX4C4Oph8q7pLmiFcPA+m6g4KTIVfTitaBtxqC4V5z80S29dFO95xkveBxP5THo2jgA+w0N0cEsUJJeCP6pyq8/cepQAluYlT6WCET9m7wJJLgzXU/PfDB7csunuY2HGPSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ta9L4eLY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ta9L4eLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7081F00A3E;
	Wed,  9 Sep 2026 09:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788947934;
	bh=SA7tkkD6fWY1Cnr/jwIer+g+sZNEGXyFAmaXS1UWcso=;
	h=Subject:To:Cc:From:Date;
	b=Ta9L4eLY5v5WzDPT/7E0ym155v5aInFGuwSsQ52x/kIykrOU6INe7ZVTDNV/KMzu2
	 8ZeSfqY6APsFqy1XpmN6dbCc+4Z6iMQnl4TgqvPN0XVrF0RnXwBxv5ZfPEkx2GoCoG
	 CWWuywnfSWyntV6hjMZOWtu9we6rOhL2wVyLEJyU=
Subject: FAILED: patch "[PATCH] mtd: rawnand: pl353: Make sure we use the monolithic helpers" failed to apply to 6.18-stable tree
To: miquel.raynal@bootlin.com,andrea.scian@dave.eu,michal.simek@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 11:55:27 +0200
Message-ID: <2026090927-cavity-motion-43b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 80ecacd054ffeb60cd28e46ed5cd6bd0d2de318b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090927-cavity-motion-43b7@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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
 

