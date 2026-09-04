Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1553F4827;
	Fri,  4 Sep 2026 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788535672; cv=none; b=TTZhduBlax8BifXSkSVm6Dd8NqiDcc1XlWTT4bH+bKY3dD94H/mDx3OSY8rV/zBQtvcG2DBdtRnRD7sJY0VU2X0kxsVs3OV4Fg6wN/fBb19vUBNC/SuFg1n1Yvw/JdTxq42Q7e0QvUb4DyuGXjIBxKkT4mXEIxXZqG1SB75Vlvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788535672; c=relaxed/simple;
	bh=QQ8diKhFHWJAtIfnEYnoYfmqFG689W2ITKxC2kRfle8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=bGahnDCFrZogzqoHZGxgTlCUdvmSalB6Gz5vFg70nk5WcajlLfnI9Q4JoOgy0aglQ4XeAn+cEPo/BtgAHaZvWve2AiUxgLpiW+4LV67jT/hR8UXpuIy3ki9oWyWupFf9H6t7dgCF1USdFHUSK9tnEmafxnRrche8zBgJRXIGSaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NkMb9aZ4; arc=none smtp.client-ip=43.163.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NkMb9aZ4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1788535665; bh=p6YT/VL9q0sGuJwdEwSfwmPVh6F1cIy5Cuf+I+1m3tU=;
	h=From:To:Cc:Subject:Date;
	b=NkMb9aZ4Uo9h20yRv0PVotH630F/z8jzd9XjL8NZk65KeJ+US/STEItOF8cPoPfnG
	 Yvm6tuDMjffwP8C6Pe9cZa0vJT8VA+i9uAV4ZJfLJ43oZ3R8BnhdOIwRTXjYKkdvGJ
	 Gb/pGGpubeyB3WSQAxCX1LOwwMl99cpAOmxNc37E=
Received: from xgyy.localdomain ([2408:8352:603:550:ac27:2fd0:a691:b668])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 69A3BE9E; Fri, 04 Sep 2026 23:26:26 +0800
X-QQ-mid: xmsmtpt1788535586txwovzsal
Message-ID: <tencent_B5154AEA68C02E81646C47664F2DCCB5AD0A@qq.com>
X-QQ-XMAILINFO: MPcqOQWpcFrmJuKMPTvtbXjGodpt6d+d7SviPalG30iDXb48r+pVjbpHJRdI2v
	 K1GoT2F2rnc6PmJjuO83odnHf1lDpKVUCamhV3hI3OrEOglXWzqAL0BzN+KBOLkCBJUON5a2Kujk
	 UHgkMob5VYyWH12KV6TYHpTQYJzPzoNHCvh5fOL3x1XQjlPHZdQkUKvuEr1Yd1pRM32BHYjX/m9p
	 fAYjYpa+SQUIlAtQORNarMkYAfeSBlPvaXY+liUZTe7qKMR1WIj+XeoI1Egtpnb+75wfv3i5Onjj
	 OXDM7CpzqxUKdXScLjK7/25KoVw5GItQe2O62oudn4/dfZfqDt0DIlW2QCtA9KfPufar14O2e7h4
	 STRy4Uc46O53jc8yk2ylfBZhnP1nEvQR+0BfCfeFVATa1Oo5CZuWLCSM/M8TigutBuF+nOXH2snC
	 NHprylyZ9rfZIIza7UJWhiCItfZjQ94khiKMlk040c9ipjJB/dgY96JCnFTal68YWIvJl3tJXORy
	 jr2xQN22GS7lOP60m5Qdaq2cfabrcCtB+4xrntkWyYpKNDiZV7Jvb7RY2EaHP+bd2l/QrWy9fuWN
	 TdURmnbxP6OIK2eb11Nvt9qMTTeLc2xFo4RD7NmhwXBdlBQV29hRQA7LRtpiURAF1ixdmX8O6P3E
	 MNpUHTWpXgCfb8zhxXePRS8dCqI91L32g2Q/UBST2a9Kux6nvT4tQ/YbKS+sa60278rGc+9z6SGM
	 7nZAtL5HBSpggMjEXjHf3ISBrupYeLiOg1Y/VNG36dgErg9laCx06F5JyGLWoNdDT21oX18fWQLk
	 FZHX5MME4KE2PrLjKqxgwFdlGpqWQkdOWjqSBvYGblbQjSwz0MxJBoc/pLy5wQpOLRyU//kAdIqf
	 Q4E0Jk0gxddAl/TMdbyr/t5DPQ1iuhsT3l1SxkiD426ZY9pnQhtFgz1K/JseKb1Ox08raMMT2+yj
	 9YigaPNqjrnBCo46N3pfMTQI/5LrrELES5OT2VI0klYBKwUAk+6xCFw50Jalhr2FHCYRl8QKrdiu
	 SI4G4SR3vIIPoLeCOqJ/XYMUMDWnPgxRdFrbTLTaErm7yKYU5+Mkx8D6fBBotsxZyoGsIy+VGrkL
	 TH41ii6DKMHBLDhuxr1+GiTew7WfFwM/0iiRy4cxgwDAzJMhMx5HPdnrT1P6mKYvgRiWLBA0zO/B
	 oFKXAT/NAINrzJUA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Zhu Ling <zhuling0805@qq.com>
To: linux-can@vger.kernel.org
Cc: mkl@pengutronix.de,
	mailhol@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zhu Ling <zhuling0805@qq.com>
Subject: [PATCH net] can: netlink: fix static FD-NON-ISO mode validation
Date: Fri,  4 Sep 2026 23:26:20 +0800
X-OQ-MSGID: <20260904152622.40779-1-zhuling0805@qq.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

can_ctrlmode_changelink() calculates ctrlstatic_missing before removing
CAN_CTRLMODE_FD_NON_ISO from the static control modes when CAN FD is
disabled. Consequently, the exception has no effect and disabling CAN FD
on a controller with a static FD-NON-ISO mode fails with -EOPNOTSUPP.

Calculate ctrlstatic_missing after adjusting ctrlstatic, restoring the
behavior from before the offending commit.

Fixes: 6742ca18cb41 ("can: netlink: add userland error messages")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu Ling <zhuling0805@qq.com>
---
 drivers/net/can/dev/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 766d455950f5..26983f1b4077 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -321,7 +321,6 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 	maskedflags = cm->flags & cm->mask;
 	deactivated = ~cm->flags & cm->mask;
 	notsupp = maskedflags & ~(priv->ctrlmode_supported | ctrlstatic);
-	ctrlstatic_missing = (maskedflags & ctrlstatic) ^ ctrlstatic;
 
 	if (notsupp) {
 		NL_SET_ERR_MSG_FMT(extack,
@@ -334,6 +333,7 @@ static int can_ctrlmode_changelink(struct net_device *dev,
 	if (!(maskedflags & CAN_CTRLMODE_FD))
 		ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
 
+	ctrlstatic_missing = (maskedflags & ctrlstatic) ^ ctrlstatic;
 	if (ctrlstatic_missing) {
 		NL_SET_ERR_MSG_FMT(extack,
 				   "missing required %s static control mode",

base-commit: 641d03105cc0d2437e32fdeec164f91a4ccef6c4
-- 
2.43.0

