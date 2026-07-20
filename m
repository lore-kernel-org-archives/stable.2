Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066C2E7366
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559631; cv=none; b=endWZAoFaCO1a62z6hPf/PdC5a8W0YpeEy/26SYExyqD+TZTSqmRnugWFBvgFHuZxPh+LWeikJdfqW6t1r8dyEyolTqgYopeRUquuD7InbzY33B9F+ntNX+2Tp79m6ttIlQeyl8BoaGlaldgdZtpZm/SQyqSkbmXir0Iwe6YlWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559631; c=relaxed/simple;
	bh=vgzfpimGtxBrWtX1ILf0AqlCkT5bruqaQYJhjwP7JRU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=fjLaqVRApEKU9uBu/cteQ7xUjMDD3IldAfJo6v4lgcSpaV+cWrN1U1phtfMTk17DOjnOAAuYTm0RscacdfF42vt7MP7d+kU87NhqOBeDdKvPDFFvN7K2YHNEYQNKtS5koNYME9r9qh1g7XdertO52HMwxi1kIOqLYjtsTfAh7GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=id8frMBa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="id8frMBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800631F00A3A;
	Mon, 20 Jul 2026 15:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784559630;
	bh=c7+dw/S6Uv7wlhLDsmSX7sprEkJwpNdUYriRdtG3dCo=;
	h=Subject:To:Cc:From:Date;
	b=id8frMBar1+PswCfa5zvNB/2rEWlBR+k0e/QpJni6BcFey1YMjBQDeazrzioQzcHu
	 /dTyoQF3QIo+bE7Gr/87ybP3MmkD+MvG0Yg0YinsLlpqDd6UJsgvBcaYkLoXd+HcHs
	 MzTHwVIe/6lYxb1OOeI0Ys2/hoTT/Lgt8zwqiFwE=
Subject: FAILED: patch "[PATCH] mtd: rawnand: Pause continuous reads at block boundaries" failed to apply to 6.6-stable tree
To: miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:00:21 +0200
Message-ID: <2026072021-compare-playpen-3ff7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8e4531667d718e2e9b193928cf9b2497fa0d01ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072021-compare-playpen-3ff7@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8e4531667d718e2e9b193928cf9b2497fa0d01ef Mon Sep 17 00:00:00 2001
From: Miquel Raynal <miquel.raynal@bootlin.com>
Date: Fri, 22 May 2026 11:17:39 +0200
Subject: [PATCH] mtd: rawnand: Pause continuous reads at block boundaries

Some chips do not support sequential cached reads past block
boundaries, like Winbond. In practice when using UBI, this should very
rarely happen, but let's make sure it never happens.

Cc: stable@vger.kernel.org
Fixes: 003fe4b9545b ("mtd: rawnand: Support for sequential cache reads")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index e4e1383bd5e1..a5b278ab9384 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1216,32 +1216,32 @@ static int nand_lp_exec_read_page_op(struct nand_chip *chip, unsigned int page,
 	return nand_exec_op(chip, &op);
 }
 
-static unsigned int rawnand_last_page_of_lun(unsigned int pages_per_lun, unsigned int lun)
+static unsigned int rawnand_last_page_of_block(unsigned int ppb, unsigned int block)
 {
-	/* lun is expected to be very small */
-	return (lun * pages_per_lun) + pages_per_lun - 1;
+	/* block is expected to be very small */
+	return (block * ppb) + ppb - 1;
 }
 
 static void rawnand_cap_cont_reads(struct nand_chip *chip)
 {
 	struct nand_memory_organization *memorg;
-	unsigned int ppl, first_lun, last_lun;
+	unsigned int ppb, first_block, last_block;
 
 	memorg = nanddev_get_memorg(&chip->base);
-	ppl = memorg->pages_per_eraseblock * memorg->eraseblocks_per_lun;
-	first_lun = chip->cont_read.first_page / ppl;
-	last_lun = chip->cont_read.last_page / ppl;
+	ppb = memorg->pages_per_eraseblock;
+	first_block = chip->cont_read.first_page / ppb;
+	last_block = chip->cont_read.last_page / ppb;
 
-	/* Prevent sequential cache reads across LUN boundaries */
-	if (first_lun != last_lun)
-		chip->cont_read.pause_page = rawnand_last_page_of_lun(ppl, first_lun);
+	/* Prevent sequential cache reads across block boundaries */
+	if (first_block != last_block)
+		chip->cont_read.pause_page = rawnand_last_page_of_block(ppb, first_block);
 	else
 		chip->cont_read.pause_page = chip->cont_read.last_page;
 
 	if (chip->cont_read.first_page == chip->cont_read.pause_page) {
 		chip->cont_read.first_page++;
 		chip->cont_read.pause_page = min(chip->cont_read.last_page,
-						 rawnand_last_page_of_lun(ppl, first_lun + 1));
+						 rawnand_last_page_of_block(ppb, first_block + 1));
 	}
 
 	if (chip->cont_read.first_page >= chip->cont_read.last_page)

