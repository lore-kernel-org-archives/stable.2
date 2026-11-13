Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592997;
	b=TsszyXlCUXQ++w4VkikZnJb7adyeO6pQ/7peUg0a+uXecqYKyGLYgF4LLm7LMhCWbEbK
	 eA1DDLR5oBagO/ZOzuILgK4JbeyLTPJ2rKmiRuQSXlgKxZ4aMEMRj7uPga9fMSrlZCb5o
	 mZds1zJKUPelRdUCFBSZDn6hLr1Ds2/tnFxMEvePgqARYk4QKlm+pnvP4eNJxOdRiJeJP
	 wqF+77SEYn3/ajm07hVBYGIrMNK08V5fH/xLSUREYp7wENCUjlGiWYTSER5balExipY/4
	 Zt88loQTywhI6VADDdIMSPzBFaYyFNDZgCE43fskGis9eyVkQssGOs1hqaU30JLIXYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592997;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=/k28KAuf1blwCL3gfUyWn+VycNPQqkG4yx0T+hxzuMk=;
	b=0z2gF6HpA9vim+VLHLs4X1GGhVsrGx1Fz4T6fTZcD959FovymjqXNt1eN6kVdNM44UdV
	 ZkXdVxnU1+245d6SIMDH99C9REZOX6s8iaEll7g9RpYIqS38bEjfxzOG6FlGUiU0KpraR
	 WLWj1fKlZo3x+D4QXqmhayFUKDqlOo3gFSVvD7He9UjNANJ6FsqUEGpoWjU3iK4Y9oH/3
	 ePy7WWh4ohJrybxkZmEv/RWU0cBQGukLYZ0biereUFjIPoke3ZjYFEFC3+61F08KlPnt1
	 SCKC6JHqXrWJ2VSY3M9V5CtWgkGFt6RXAK9JASFYjZF6QxacaT0GHYIMFnC4tN/1wFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=HDV2UUpy;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817D1606A8BA;
	Fri, 13 Nov 2026 18:03:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 817D1606A8BA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=HDV2UUpy
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jR4ql0gp0z5BNRf;
	Sat, 14 Nov 2026 02:03:15 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794592995;
	bh=yU8ff4AptdSzMl8ZlNFMUC7cvTRaeDAx3ylQHu63xnE=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=HDV2UUpyWJqzCOq9P6K/i37x0Tsnf/e0QzdHC0V4JDKwLbSWYXMeAwSgJEWs52TUd
	 oDaGeKDShJICOvp7+0COn+iqHQC6lQlb9S9/bBZiBx9jYip2mXCW9S/oOhjtRtcRAv
	 g5DTpVPDBM4aAcO5dddrie9rQNlUcZRp/KduGGmAHFKkHcFK3iCfKErxIER7iFqDyn
	 P5xvdRNZWD6sHPvduzvK4UybjoWrcYcnCDXAQA9V35cnjRghs1pAMSNycIapEwT+A7
	 OwA4cTYegEmSdwUvo4Q1+xbI6kklZt+GZs+eSPO4rSzkM7JE7+sQvf5C9WSyeo62aw
	 tDcwqLvWfmGMA==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6ADI35xs099930;
	Sat, 14 Nov 2026 02:03:06 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Sat, 14 Nov 2026 02:03:10 +0800 (CST)
X-Zmail-TransId: 2afb6af750de4c6-1a407
X-Mailer: Zmail v1.0
Message-ID: <202611140203101363UQCrVoWqgVi1YYY1odJO@zte.com.cn>
In-Reply-To: <20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn>
References: 20261114020305026WLIRBj8VPB4JcDv_dhOQO@zte.com.cn
Date: Sat, 14 Nov 2026 02:03:10 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <linux-ide@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIFJFU0VORCAzLzVdIGF0YTogYWhjaTogcmVsZWFzZSBRb3JJUSBhbmQgU2VhdHRsZSBwbGF0Zm9ybSByZXNvdXJjZXMgb24gcmVtb3ZhbA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6ADI35xs099930
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Sat, 14 Nov 2026 02:03:15 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF750E3.000/4jR4ql0gp0z5BNRf

From: Shao Mingyin <shao.mingyin@zte.com.cn>

The QorIQ and Seattle drivers enable platform clocks, PHYs and
regulators during probe, but their port operations inherit directly
from ahci_ops. This omits the platform host_stop callback, so device
removal releases the resource handles without undoing their enables.
Repeated unbind and bind cycles can leave enable counts unbalanced.

Inherit from ahci_platform_ops so that host teardown disables the
platform resources after stopping the ports. Cover both Seattle
operation tables, including the variant without SGPIO support.

Fixes: ecfb4598512a ("ahci: added a new driver for supporting Freescale AHCI sata")
Fixes: 535dac4ab5f4 ("ata: add AMD Seattle platform driver")
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on next-20261105 in an x86-64 QEMU/KVM guest with KASAN and
lock checking. TEST-ONLY hooks supply RAM-backed AHCI registers and
observable clock, PHY and regulator providers, retaining the original
QorIQ and both Seattle operation tables and probe rollback paths.

Each variant runs 12 start/devres-release cycles: unpatched, clock and
PHY counts grow to 12 and all four regulators remain enabled; patched,
ports stop before one platform host_stop and all counts return to zero.
Per variant, 12 IRQ activation failures and 12 PHY enable failures also
leave resources balanced in both kernels, without duplicate disables.
Firmware discovery, full host registration and real SATA I/O are outside
this test.

 drivers/ata/ahci_qoriq.c   | 2 +-
 drivers/ata/ahci_seattle.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ata/ahci_qoriq.c b/drivers/ata/ahci_qoriq.c
index fc6b8cd75b..3e3ce1a02b 100644
--- a/drivers/ata/ahci_qoriq.c
+++ b/drivers/ata/ahci_qoriq.c
@@ -147,7 +147,7 @@ static int ahci_qoriq_hardreset(struct ata_link *link, unsigned int *class,
 }
 
 static struct ata_port_operations ahci_qoriq_ops = {
-	.inherits		= &ahci_ops,
+	.inherits		= &ahci_platform_ops,
 	.reset.hardreset	= ahci_qoriq_hardreset,
 };
 
diff --git a/drivers/ata/ahci_seattle.c b/drivers/ata/ahci_seattle.c
index 9758fa0260..0187eb2d27 100644
--- a/drivers/ata/ahci_seattle.c
+++ b/drivers/ata/ahci_seattle.c
@@ -48,7 +48,7 @@ struct seattle_plat_data {
 };
 
 static struct ata_port_operations ahci_port_ops = {
-	.inherits		= &ahci_ops,
+	.inherits		= &ahci_platform_ops,
 };
 
 static const struct ata_port_info ahci_port_info = {
@@ -59,7 +59,7 @@ static const struct ata_port_info ahci_port_info = {
 };
 
 static struct ata_port_operations ahci_seattle_ops = {
-	.inherits		= &ahci_ops,
+	.inherits		= &ahci_platform_ops,
 	.transmit_led_message   = seattle_transmit_led_message,
 };
 
-- 
2.27.0
