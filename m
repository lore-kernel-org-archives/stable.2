Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FD6387590
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785069528; cv=none; b=j9GYR9CUT0XSe6MHcTBb+U0KsSya2aFS5NMQWyakpMjncwdNyrgvp539un3SeYp1vThS4ruZJgkRus0tpoYssa/5fjfoK0ZMpMsZ5qokd1a5moeX93s7EfYLEQtqbrnhzUv4/PPqbPzJVsGnQn2NKkEOXe2WLylz05cKQtjEp+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785069528; c=relaxed/simple;
	bh=Hv8u88fJtzKApg3H0gBgLy6XjwycI7awiJaOoQl52Jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jds84vcF8fpVVgeJa5avtH0YqjjRyhOWdan5CvjmI/zYaekbGywnQjZYh5czXgPHESqvCgl49DH15j/wGlXW6/h6DEad17M+/1p3nl3owv2AhvOJ3i8rEMwaUmMhtZ3q/73Y/yBmDyOKLvtxBNT0OtcaJuSLPa7IZB3XoFrfYp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq81Yw7a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq81Yw7a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEDED1F00A3A;
	Sun, 26 Jul 2026 12:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785069527;
	bh=+T1I0yiK6tqQCwx7lPqA6+GVcageDXOOlhg/6Pv/MGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Sq81Yw7aSLELCZY8SJSb4aDYCkj4gyPYtDmDG1AUeEvHsFlVdBVeHcqGsobARLjaB
	 CecVOwAvnEDv3s4zIO3pBD4HpbZZKzjJoIzgEON/UiJBZ472iEtWebOkMG86hz2rmE
	 j6pGoHFb1HzTKvbVPLStXcuFmwk/PZpIX75MS/OWH2CeP9lpSASuIaM4B1ezdEXvRY
	 V+/zkEkJjEK9rZeKmDYLqVWLeOpoYd7Ql4z3idWdXJsehp2rrVbIaoarzPOw/fuIFg
	 o3ZOp0qQ51ilJ9WgiDrkOf3RTpKYd9e4SKaRkvB8/vmJ5kGXWVPAwjm4GKaGQszZwp
	 MAwBSvzcDEMHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] mtd: rawnand: Ensure all continuous terms are always in sync
Date: Sun, 26 Jul 2026 08:38:43 -0400
Message-ID: <20260726123844.64620-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260726123844.64620-1-sashal@kernel.org>
References: <2026072021-compare-playpen-3ff7@gregkh>
 <20260726123844.64620-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 6fb075fca63c3486612986eeff84ed4179644038 ]

While crossing a LUN boundary, it is probably safer (and clearer) to
keep all members of the continuous read structure aligned, including the
pause page (which is the last page of the lun or the last page of the
continuous read). Once these members properly in sync, we can use the
rawnand_cap_cont_reads() helper everywhere to "prepare" the next
continuous read if there is one.

Fixes: bbcd80f53a5e ("mtd: rawnand: Prevent crossing LUN boundaries during sequential reads")
Cc: stable@vger.kernel.org
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20240223115545.354541-4-miquel.raynal@bootlin.com
Stable-dep-of: 8e4531667d71 ("mtd: rawnand: Pause continuous reads at block boundaries")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/nand/raw/nand_base.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index 9c925439696047..11b0fb4bde96f2 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -1233,6 +1233,15 @@ static void rawnand_cap_cont_reads(struct nand_chip *chip)
 		chip->cont_read.pause_page = rawnand_last_page_of_lun(ppl, first_lun);
 	else
 		chip->cont_read.pause_page = chip->cont_read.last_page;
+
+	if (chip->cont_read.first_page == chip->cont_read.pause_page) {
+		chip->cont_read.first_page++;
+		chip->cont_read.pause_page = min(chip->cont_read.last_page,
+						 rawnand_last_page_of_lun(ppl, first_lun + 1));
+	}
+
+	if (chip->cont_read.first_page >= chip->cont_read.last_page)
+		chip->cont_read.ongoing = false;
 }
 
 static int nand_lp_exec_cont_read_page_op(struct nand_chip *chip, unsigned int page,
@@ -1299,12 +1308,11 @@ static int nand_lp_exec_cont_read_page_op(struct nand_chip *chip, unsigned int p
 	if (!chip->cont_read.ongoing)
 		return 0;
 
-	if (page == chip->cont_read.pause_page &&
-	    page != chip->cont_read.last_page) {
-		chip->cont_read.first_page = chip->cont_read.pause_page + 1;
-		rawnand_cap_cont_reads(chip);
-	} else if (page == chip->cont_read.last_page) {
+	if (page == chip->cont_read.last_page) {
 		chip->cont_read.ongoing = false;
+	} else if (page == chip->cont_read.pause_page) {
+		chip->cont_read.first_page++;
+		rawnand_cap_cont_reads(chip);
 	}
 
 	return 0;
@@ -3512,10 +3520,7 @@ static void rawnand_cont_read_skip_first_page(struct nand_chip *chip, unsigned i
 		return;
 
 	chip->cont_read.first_page++;
-	if (chip->cont_read.first_page == chip->cont_read.pause_page)
-		chip->cont_read.first_page++;
-	if (chip->cont_read.first_page >= chip->cont_read.last_page)
-		chip->cont_read.ongoing = false;
+	rawnand_cap_cont_reads(chip);
 }
 
 /**
-- 
2.53.0

