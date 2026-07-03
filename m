Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654F235E1A9;
	Fri,  3 Jul 2026 07:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783064567; cv=none; b=dvo2j0oGmE3a0a6VknbyBSnvUI11+ChrKKUZEygoXQMUHyXDdX5zUQ/U4rVZWFMksl6EHPSTjzz05/e0Cx0Kg2gAlruGW5bEdSM+ZOT1bHnY3BuV+Wy67vOA6iQrkH2oTRKjAJf1FISaGrjjHctaNEr/taR689XxZfWbqMt79Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783064567; c=relaxed/simple;
	bh=R+RN7Yq9PFteZNPgteL68fTfCcdDrmpJueXE3IMaMSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PPftXs2FatjmuOnnkU+tZcptYO3ydmPweVvslvaDPgbgB6hQWhA3DMrL3SpM+7rzj580PmKZGJCui+w5d6MsReLr14ESmdOBp7M7N3Fg7TeLWF8dh9z1RtoWvb3P2d3R8W5MMPn8jJD/L5OaZjmaWbe8J0TzLaYjV5j1XkEkdJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowABXL5brZ0dqZEvAFg--.1767S2;
	Fri, 03 Jul 2026 15:42:35 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Frank Li <Frank.Li@nxp.com>,
	Kees Cook <kees@kernel.org>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] mtd: rawnand: fsl_ifc: return errors for failed page reads
Date: Fri,  3 Jul 2026 15:42:33 +0800
Message-ID: <20260703074233.59967-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXL5brZ0dqZEvAFg--.1767S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF4DGr4UXr4rKF47Ww1DAwb_yoW8XF1kpF
	W7X3y7CFWDGF4xtw4aka1FvFy5Wa97JrWxC39Fqa4rurnxZr15uas8KryI9F45JryUKw1D
	Xrn8tas8CFWFyFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUoWlkDU
	UUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

fsl_ifc_run_command() logs controller timeout and other non-OPC
completion states in ctrl->nand_stat. fsl_ifc_read_page() then only
increments the ECC failure counter for non-OPC status and still returns
max_bitflips, which can be zero.

Return -ETIMEDOUT when the command did not complete at all and -EIO for
other non-OPC read completions so the NAND core does not treat a failed
page read as a clean page.

Fixes: 82771882d960 ("NAND Machine support for Integrated Flash Controller")
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260623061413.47409-1-pengpeng@iscas.ac.cn/
- add Fixes and Cc stable tags as requested by Miquel

 drivers/mtd/nand/raw/fsl_ifc_nand.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/fsl_ifc_nand.c
index fad0334f759d..a88ac2cfaccd 100644
--- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
+++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
@@ -684,8 +684,15 @@ static int fsl_ifc_read_page(struct nand_chip *chip, uint8_t *buf,
 		return check_erased_page(chip, buf);
 	}
 
-	if (ctrl->nand_stat != IFC_NAND_EVTER_STAT_OPC)
+	if (!ctrl->nand_stat) {
 		mtd->ecc_stats.failed++;
+		return -ETIMEDOUT;
+	}
+
+	if (ctrl->nand_stat != IFC_NAND_EVTER_STAT_OPC) {
+		mtd->ecc_stats.failed++;
+		return -EIO;
+	}
 
 	return nctrl->max_bitflips;
 }
-- 
2.53.0

