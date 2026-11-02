Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.230.196.243
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613170;
	b=Zfze3TWPmP50jlUrGWbstGhDUyst4MXD6e+dwuiSQH6bG/U/bBeoZQ+fT32z8jqTWzkh
	 fYSCw6Jqx4UFyGT/jcuTvy0My8tKI1MucVLCBdxXwTsn6yJxQ/npr7FXo7LLy9HZuMq0Q
	 XzoZDMqR/iEJb8o3psF2OuU58B/Q8PPbX34ToD0r5thoMlc4+E1rjqpMvikhaniVse2Oh
	 mW5zHPe4NjQvMPfcSwkTmr8qqHl3/jATTBnHCr0TF8W510V3Nit/N/kE2SJsZ5jYBsWoy
	 vu/lJPN/ZNeu20XRfypefC3j2Ygeg+bl5hlm1cDyX76T1VxUmCIDaSRy8TmddJHsdtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613170;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-KSMG-AntiPhishing:X-KSMG-AntiSpam-Auth:
	 X-KSMG-AntiSpam-Envelope-From:X-KSMG-AntiSpam-Info:
	 X-KSMG-AntiSpam-Interceptor-Info:X-KSMG-AntiSpam-Lua-Profiles:
	 X-KSMG-AntiSpam-Method:X-KSMG-AntiSpam-Rate:X-KSMG-AntiSpam-Status:
	 X-KSMG-AntiSpam-Version:X-KSMG-AntiVirus:X-KSMG-AntiVirus-Status:
	 X-KSMG-LinksScanning:X-KSMG-Message-Action:X-KSMG-Rule-ID;
	bh=FkYS1w9u0+LaOyzLJRCPz6vwu0WtFSRe65AtlLC83O0=;
	b=u5sjqemOm1vjOrHPxZSXiqMNlum1TyHCv1Pb+73zUi00qVjpqU89fEQE0xVJQMWjBMfL
	 MK4FzS2+KTzkXrRweE55chcN2KIa4FJF8PLTq1oK4Gj7p2KZ1JW1Tu3y7QO5N23G4yyBc
	 8RtOWqxdWZmtf/LbNhq2tbYWlrQnttJG6MdWYc87eJnSZAVNnJpG5W6A4ta65MIrft5TC
	 z7O/w4UJcpDnqyD72hF0Xx4utwUueF78KSHOQFFfKknVCle1t0PDahPXBYKnNLB4soR0k
	 9zMET4K14H7ufYIHwjIL0p14wfOQlb8rC5Cksqu44CrydxfDpV0Lt+hAaGZc/olD0VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=astralinux.ru;
	spf=pass smtp.mailfrom=astralinux.ru;
	dkim=pass header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=UYznJyHn;
	arc=none smtp.remote-ip=37.230.196.243
Received: from mail-gw01.astralinux.ru (mail-gw01.astralinux.ru [37.230.196.243])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92607606A324;
	Mon,  2 Nov 2026 09:52:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92607606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=astralinux.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=astralinux.ru header.i=@astralinux.ru header.a=rsa-sha256 header.s=mail header.b=UYznJyHn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=astralinux.ru;
	s=mail; t=1793613158;
	bh=Nob264xXleauE6t2oflw9XoRF0JlXcR5+ar1pZlg5BE=;
	h=From:To:Cc:Subject:Date:From;
	b=UYznJyHn/zFvt2KtUaAUPEQC1+ySyA9x6wTP3UYa+PSY/Xm/k+s9lkD6Ha5r7stv5
	 f2MpK8SAx3JZouGY6TEeABhUA2+LGjnbwMGljpOkB8W0SoXseAYYmywswJXbOcYE1F
	 da03Kk98PpSLkpd1cBk3EQ6os5KJEci3BPbiEINcvVRkBWrO/Ys2Jzmr7RUfIoMols
	 lUTCUc4/AjdwW6zNUYZoG6dJL/46TZe2IZd1vZFgN2rNXvq677wlqjeL2Ir2xQNYzu
	 0Ud+KeGf9vVwi6SSTbx2w6CHHakVW6Xv5Z0NO6HxnVrc3CHPpGUkzpj9RW9aTAg1tn
	 YtF7Rx/GXnSTA==
Received: from gca-sc-a-srv-ksmg01.astralinux.ru (localhost [127.0.0.1])
	by mail-gw01.astralinux.ru (Postfix) with ESMTP id 0BBB4250C8;
	Mon,  2 Nov 2026 12:52:38 +0300 (MSK)
Received: from new-mail.astralinux.ru (unknown [10.205.207.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail-gw01.astralinux.ru (Postfix) with ESMTPS;
	Mon,  2 Nov 2026 12:52:32 +0300 (MSK)
Received: from DESKTOP-D46TNHI (unknown [10.198.31.164])
	by new-mail.astralinux.ru (Postfix) with ESMTPA id 4jJ6Sb3Xfyz2s2s;
	Mon, 02 Nov 2026 12:52:31 +0300 (MSK)
From: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>,
	Sasha Levin <sashal@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] mtd: core: call _get_device() with the master MTD
Date: Mon,  2 Nov 2026 12:52:12 +0300
Message-ID: <20261102095213.104-1-mdmitrichenko@astralinux.ru>
X-Mailer: git-send-email 2.54.0.windows.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: mdmitrichenko@astralinux.ru
X-KSMG-AntiSpam-Info: LuaCore: 133 0.3.133 d508d579b02cdb6df47808421a9b9e12fc9fb75b, {diag_burst_silent}, {date_rfc_vio_soft_silent}, {Tracking_from_domain_doesnt_match_to}, astralinux.ru:7.1.1;new-mail.astralinux.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 207172 [Nov 02 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.0.7854, bases: 2026/11/02 08:04:00 #28779785
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 1

From: Karl Mehltretter <kmehltretter@gmail.com>

commit 12b31d1acd20b3185bb5f0748db0cf6874c8e9d1 upstream.

__get_mtd_device() calls the master's _get_device() callback with mtd,
which may be a partition. __put_mtd_device() passes the master.

This breaks gluebi partitions because gluebi_get_device() uses
container_of() and therefore requires the master MTD. Pass the master
to _get_device(), matching _put_device().

Fixes: 46b5889cc2c5 ("mtd: implement proper partition handling")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
[ mdmitrichenko: Keep the existing try_module_get()/module_put() error
  path. 5.10 predates commit 79c4a5625021 ("mtd: call external _get and
  _put in right order"). ]
Signed-off-by: Mikhail Dmitrichenko <mdmitrichenko@astralinux.ru>
---
Backport fix for CVE-2026-98833

 drivers/mtd/mtdcore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index b2d88ff90e93..d960d4ed2e5b 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -990,7 +990,7 @@ int __get_mtd_device(struct mtd_info *mtd)
 		return -ENODEV;
 
 	if (master->_get_device) {
-		err = master->_get_device(mtd);
+		err = master->_get_device(master);
 
 		if (err) {
 			module_put(master->owner);
-- 
2.43.0

