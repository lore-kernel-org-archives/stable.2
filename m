Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E8D3264D4;
	Wed, 24 Jun 2026 05:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280388; cv=none; b=skUCgHwtG8IUiP2ZTQddShddduLkzWXsVcT/Fr3sebbNIJmIGexZNDM6GcI+CCVNT+5Lchy41JVk4JwfOt/DivFEO2hpoNhrv7j6dgKkS+oexPOywKfj+HqjeI5bM/1/H4yZnRCdvNzItgvL3Q4nI5MGch4vrx8j/IHX5VWf3cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280388; c=relaxed/simple;
	bh=ZLCE2mKu1Ri7wlKURliRPi8nuqpKQO4ZQCX2PClFm80=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bDFD6/oXe69sTfacHrfDmXhPvgMalexpx1Ys/lJlVU2Q6BpTQM06+UmAOxDQ1dVUq1R0cLNrI0aXpjtD0q/wxw2HDeZKoF3lkND5lI1PlPcPsGMJieXzlFqdnFrjhXjQdMQ59TedoRsI9dzO7YahDAC2mrRJSx+mnmdI8MMwHEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=gbXr4uSs; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="gbXr4uSs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782280362;
	bh=e/i9mr+tw34H94yqeC3BDAdBWPbcg3zLOWALeGd72N4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=gbXr4uSsCMi8mNwcUqnDloOIdKALBsVU0FcDZ4ZI1uCeEULRsH9c9DuXOOLq2YhNn
	 c+7/qHz5W9pDqhwIR8eW1QB2XUsyhkxsi7YL4fAsK/NtOyxjpxhgpG+gEe+bObg06N
	 tP5+TN7PLtkGhc7m0LjgGObReIYJplAZb44GIbeA=
X-QQ-mid: zesmtpsz3t1782280348t771d4a40
X-QQ-Originating-IP: WRBsZP3w3tKjf/j4DHmMSfQ9xdGrcma1TJmQRFjJ5y4=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Jun 2026 13:52:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 2615932569881778472
EX-QQ-RecipientCnt: 4
From: raoxu <raoxu@uniontech.com>
To: sudipm.mukherjee@gmail.com
Cc: linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] parport: mfc3: use port A DDR for status lines
Date: Wed, 24 Jun 2026 13:52:24 +0800
Message-ID: <DB30A1926283DC1E+20260624055224.4183972-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NvjhxCSDgXICUmQPbSFTYFYF7gcwqls7YNHEU1CAoZBejF9J9JegwGYX
	JBLyrh5B1vGpICTdagitFl47kenTTLaQADcHIgz+jniH5iK6K4r4sfN16+6s8hAIrGbVwvR
	+TkpF+0tfZmgCJU156F4mTZGiO7ttJxE4CcQu4oFC2MgzMxQEbvPHjj7XBabt9zAXpdkzSJ
	Zv9L7OLW1CcHSiBGdhajBcsWPEjD0RmXndcEHFc7JqQIeMdwMLoQcyOGSmWHSjRUwdLfnda
	6nxC06werseSiMBZhXb41XB7vULQBmllrFxJXK7HjI6MzZENsjum43cKp16sU47LfoYJnz3
	ItZ/KP5H5duZaTwWfeWs+T57R03OsGpmR80TAa0qCUtXUuk5ZZbjOFxbBKRuvfJH6gTwlBv
	/UfPxdaKTo7TPO4OT8vgDryLJ7Qdg0NOUx3nsMZ+8wzjTTdZzQlyYAqxPWSFU5WSw+RjZFo
	n89sHlFvXHrRp/s83aH0uOQTssbTSlpkXD0DQ99yayf7OZEED/+eqiKUVwIZQm8BwEGTtwq
	o/ObuNRj6Y0agYq4G4MsMzcOhs6mEhUUryJAxPMrhO5QK8WRibqcyDRrBoU6xl5DPH1NlpU
	tmIAiozXXwS3L088OI2CIg6QRJEQY5qrewSn7MvX1O+T5MOMsi8KUNKqve1Rht2Xj0ukbQZ
	T/W7ycFlqf+GF/gSFqFdchF/a8NNZDpYPaVdL5CTg1t27VUihmaiD4Ut7aOnOYp9wEFn6GM
	+PHIEMEWxvzq9pG/+JMIQuH7Kgih/d2OKOIyPOZ/g1xEyDXnQVC6J5kj5SVjIMQ587rn+R8
	chx1/DyoSskWseU0B9wWwleRGNCoj4/ZC1IovCyMHW2PBma++zEFjPcPNgIXTeMutPC3xDo
	IlTM2n/Omu6gigw0tQST6DqI/sI9QKYxl1dooL0pBWUv1yuPDfVgqrousazzq4h/3rUAJQx
	D5omKbgOE4Al1r0mepNYjuHsw7MXi8kn/AXQBDw530DUpsVYOVd2knsioJNiSQpleVFsi1S
	bDqFoSLAduYsbkt/e9LWqj7NUgd6T0H5DgzjfgX3W8vUMWsoG+3V7ap7k87vQ=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

mfc3_save_state() and mfc3_restore_state() clear PIA_DDR in CRA to
expose the port A data-direction register, but then access the port B
register address through PDDRB.

At that point CRB selects the port B data register, so the save path
stores the port B data latch in statusdir and the restore path writes
statusdir back to the port B data latch. The port A direction register
is therefore never saved or restored, and restoring an initialized
state can replace the restored data byte with 0xe0.

Access PDDRA while CRA exposes the port A DDR.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/parport/parport_mfc3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/parport/parport_mfc3.c b/drivers/parport/parport_mfc3.c
index bb18172..ccb5bb3 100644
--- a/drivers/parport/parport_mfc3.c
+++ b/drivers/parport/parport_mfc3.c
@@ -226,7 +226,7 @@ static void mfc3_save_state(struct parport *p, struct parport_state *s)
 	pia(p)->crb |= PIA_DDR;
 	s->u.amiga.status = pia(p)->ppra;
 	pia(p)->cra &= ~PIA_DDR;
-	s->u.amiga.statusdir = pia(p)->pddrb;
+	s->u.amiga.statusdir = pia(p)->pddra;
 	pia(p)->cra |= PIA_DDR;
 }

@@ -238,7 +238,7 @@ static void mfc3_restore_state(struct parport *p, struct parport_state *s)
 	pia(p)->crb |= PIA_DDR;
 	pia(p)->ppra = s->u.amiga.status;
 	pia(p)->cra &= ~PIA_DDR;
-	pia(p)->pddrb = s->u.amiga.statusdir;
+	pia(p)->pddra = s->u.amiga.statusdir;
 	pia(p)->cra |= PIA_DDR;
 }

--
2.47.3
