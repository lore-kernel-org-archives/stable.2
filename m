Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1709336215F;
	Mon, 13 Jul 2026 05:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783920183; cv=none; b=OIwpBAHgMdgHS4gvUu6/q/F0UvvI6bOWpsmH6KgVTVZhd4Hps9igSWKPIXw7xoI7v/+UeC+H3XZUKvXF5mm9sy6j/QnY2CLUe4JjLhoMBjospahvFGZY51qZubdFUsU18zc1T5CU3ekObuBipEQ/k2acc+2dqfYWSb+1NLMgR3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783920183; c=relaxed/simple;
	bh=a0BAPmH6oNa2FYXnzPiCddacYqWUGRA45fRdK95jE4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ol8O1SNB2BJ6JjcoubP+94DriW732zsH5oxdGCc7pt8KOf4pWkA/nnPN6pAB8mPuWawHlWdT8NdOwxGQZd5fqhcKbwxlYPHqhiLlFQMxYan9El5uVvpnO9H/XWUJSJWq7TYJZSaehNJ0EzGY+bZEseUgfvFWRGgFFSI7IzqEQ74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=RQzHJEJk; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="RQzHJEJk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1783920131;
	bh=fM8Q1SD7XfugxOcJgMLQxjpqmZ4SQOJLImfo/tMCzlA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=RQzHJEJklgJsNetIRAk63Iq6MonT4XksBMG3i59t/aFxDvoBlzTQmwAooXEy/GvLx
	 xFDag2eidAx/l87DZ/JKMo6Zp8Pm6kGAJZtkEyeOCEa03DdKaGjLGVVyLz9S628LWP
	 s85PTc+quhMjwAbVMnGRiMigpzQRxsjmInGPZ4eY=
X-QQ-mid: zesmtpgz6t1783920126tc35ffb0f
X-QQ-Originating-IP: VPaKhDxv5lrTk04FFn2/VRP/TWvfOBAM+q2sqajFpoE=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 13 Jul 2026 13:22:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14185114708170478530
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: miquel.raynal@bootlin.com
Cc: richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] mtd: mtdoops: free page bitmap when the backing MTD is removed
Date: Mon, 13 Jul 2026 13:22:03 +0800
Message-ID: <11D80ECD6F2BBA62+20260713052203.3130998-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: M+fRGLN47oKLNN+1WT3o4y7kGNRtG6QWTN1Ahd3yrvE76c6k+8+VOgUX
	DdQn4+oV1tgSIZxRhI0RSP8mG2WUb22HHPh50tEWJY/tYLIpwPWF3pAdITZ6YJIooKBsKrd
	unr8ZBiGxxd1fuD7tmW3mffv5sT1wCitI7lAFBLoH8bQvorsfjfW8DAuEGqcBTrDga/ffl3
	yDcGmbbceavLIeDIhbYLmK1qTj8x7PIkMoL67YHnxy1qai2CuFk81b5mpinHmM7UuFkgI5o
	8VsHLcUELzCYsEUSkn1mcrEDKujRzeh0ZSb2cKqyDvm20D/nb2NwutmH+KAIcpyMiS449Oz
	gRVfdRhC0pOC97nGCUx60Scilgn5LW8pPlY5K3cc++rLPa8UOYByYaFlhz8mn0pa6meEVcp
	0ZxugGq/wrtYu6Ieaei6u99zAsjbLChwtnEiHneHjaL2HJWAFkEPtcqZrxH7l1uvNK9OghB
	0dpr9piaemlqJCv1vkzU0I8dIK8ntKNBtUZz9Gu6KL3lHG93Lkv6r1f6kmrsCRroAXNSJ1z
	KBtUAOvDeAPds5DI3TCbmEPVdHKtCEEqXPBlpufMTqDHSB7LdV7CIL40Wv+QG83vYsO3A0x
	ipZLdpvYEn7gkguyA7WXigmLBgC36NbNhz0TP3uZGMZ0cb7dWR2Cb6uHzp/GpVqLgoToC1F
	lFXXw+iXjo4qHdsrohDZ9qKQiiVv+OQ5FMqiBuFSDyexuZixZNfO8OpztC+TGBLLxXoHvtg
	Qx6hIKj6P6NfJ4hJ8un1bveht+b3d/A92yW5ltn1MR3kdJUNy6rGumrhu94XQGaA70aCNok
	ZeAGr+1v1Up44eiMMYb7t7Peo3HN0e07mn5seXmH9Qo9S0pESVhc4mRasVAsjNL7SqUVOwr
	94HpnKgFCdRPEWQzSDfYsmlwqFAjAU/NJEIZ1qlfj71KkCE8VX2C0W2li6kDCp7KfkRQ/za
	qXvFob5xuMPTjQki8CrmdzLh2ejLfbQYcSNONm+PK0L+PtG1dqgdqux95BMND3HzBVz3Vbk
	BMu1aEyfmTXoGc0NfH+ZmqMMFHXXRAx+vomqHGntxXR2uHHkTo
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

mtdoops_notify_add() allocates oops_page_used when the configured MTD
device is registered.  mtdoops_notify_remove() detaches from that device
but leaves the bitmap allocated.  If the same MTD device is later
registered again, the add path allocates a new bitmap and overwrites the
old pointer, leaking one vmalloc allocation per remove/add cycle.

This is only visible when the backing MTD device can disappear and be
registered again while mtdoops remains loaded, so the usual static MTD
case does not expose it.

Free the bitmap after unregistering the dumper and flushing the pending
workers, then clear the pointer and page count before a later attach can
allocate fresh state.  Clearing the pointer also keeps the module exit
path from freeing the same bitmap a second time after a remove event.

Fixes: be95745f0167 ("mtd: mtdoops: keep track of used/unused pages in an array")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/mtd/mtdoops.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 39df7ce8f55f..1da7ef06a7a9 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -392,6 +392,9 @@ static void mtdoops_notify_remove(struct mtd_info *mtd)
 	cxt->mtd = NULL;
 	flush_work(&cxt->work_erase);
 	flush_work(&cxt->work_write);
+	vfree(cxt->oops_page_used);
+	cxt->oops_page_used = NULL;
+	cxt->oops_pages = 0;
 }


--
2.50.1

