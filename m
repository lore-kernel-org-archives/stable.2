Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492768;
	b=oGwj0DmJCl0BwVVKAIdECiQheRA0zsVhWv4sdHYM6VQrJRVgxyMur/Kj6fah9cvcerUC
	 SDCZ/2v3NVy7OntXoZOaNx3nWV2Qd3Lg0hCDZk/eaAOKKt1j7tQxbxMc/ZBAc0Q0L/4Ys
	 AtgA5XSziMLxcyL2vbo9KZ3USm3BFmCxRpQXKuONwepZz9s/G67SJfpLDya+5mwpfTXwk
	 2YJxUi7TvG5EVqi/pK7RghiEzrZVf3bAiR9K4zRDqqSZCon7A0wNlLlSNlSpb9R/lJoAB
	 NdB5CIQI8J8jD+sAae9jK2fW0fcBYJNlVHvf7qwfdWVhyIOCyMddX868F1fPavx6xyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492768;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=uAaMckiUXxw4IdBaoACknRIY+JszX/Q5mOBdDQpj4AQ=;
	b=dGJ9R2rKFQIWHI5Q+/22G22KnWK7URhV9N0fmaMXUmyAYD4pOdWXVBD++/Acczq4tB0f
	 3GcmxGKDjLN1oEnnVmjnGyrC7Q1b4XQKNhsuz09eDn3FR4/yFYhkjq5Uecw6gv6dNkm7t
	 ScRZEFWHpxqYBOETnY863FjoL4WziSrciiXg96qDYoWbuWRFJNWOGbkiWSBYilEuww25b
	 3gJB6XyBNDFOduGRxRDSOyc3bU1KN5nOfkuIjSX6lVthExgnQgo5Rdz783XuVk3ahRozn
	 cWKvk1Q2TXj4cycnw+q0iSPdKrUKw5hrxMZaG+zJJEi+F0Y9Y6qzO5flNJMbSVV6eUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=tNTcfNij;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00A7606A321;
	Thu, 12 Nov 2026 14:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F00A7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=tNTcfNij
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jQMmG27qfz5BNRf;
	Thu, 12 Nov 2026 22:12:46 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794492766;
	bh=lfLONSZ7AKeagsPWTOixQKRehAD9SeRR+DnpuXAqa1w=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=tNTcfNijQIwp52W6/heY40fYzs6TEiZl6MiedKGYDd1hAcDDpeBLMGU3DCYT4d6Su
	 irRWLNG9GhyaX5wEB7VwTsO31fhtMKrZdP60HN4OcGHkkE7DkV76L9cMwSSF1qOATK
	 NurEpHYBcqFPYikL7PSos5GYR6keophbgKgmm/VESqrGeywTQlC3UEQUc7lEQmwBQr
	 peGWny7K3spQS2g3QaFba4i35XaNfHcxJOsLP+1rPG0c0B2c83Fw6dDN6Sl8yU9EDy
	 qrnaotZOCXHp0+xiTMENc4txBdaofPWCcsk5x0c4slbGMM540kMrT0G4qlX+T2bdUy
	 1CQ2s5jfEYR1w==
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6ACECbh8055529;
	Thu, 12 Nov 2026 22:12:37 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Thu, 12 Nov 2026 22:12:41 +0800 (CST)
X-Zmail-TransId: 2af96af5c959a0c-dd182
X-Mailer: Zmail v1.0
Message-ID: <20261112221241130kVJ1BhZ8c_PrjeuELo51I@zte.com.cn>
In-Reply-To: <20261112221230052E8YTrPU5pi8AJJy6dnh9E@zte.com.cn>
References: 20261112221230052E8YTrPU5pi8AJJy6dnh9E@zte.com.cn
Date: Thu, 12 Nov 2026 22:12:41 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDMvNV0gYXRhOiBhaGNpOiByZWxlYXNlIFFvcklRIGFuZCBTZWF0dGxlIHBsYXRmb3JtIHJlc291cmNlcyBvbiByZW1vdmFs?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6ACECbh8055529
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Thu, 12 Nov 2026 22:12:46 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF5C95E.000/4jQMmG27qfz5BNRf

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
