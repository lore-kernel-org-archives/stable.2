Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801606;
	b=lKWQcaZJkkInR8KvRbjcBNjpp8c7Awr9ogwU9Bs9caWCIOKEVFurzO8JJKfS3n8GT8ps
	 mCo+YTk/NnXnqtWpyNA9zu70CUzbL0WW0Kdg/1CmaMtOcjjCWRBPhIwz4Qd+Kgy/+5AAo
	 YOWsG9rykUqG/Zsxsb++sJFhyeImyogre64BYD91n10NKnQLU+IzhrqcgVD2IsyO2RSJv
	 8zm9xFia34Lk+OgXs8MNi9luRN97/rI9OsesTRfmF04cWuAVYA1eII92Cgo/LqhL2O70p
	 /hOqI07nkLuUV2Q6nYzLKiN2nfgXgTjV3XB2By69LDEBvVTOjJhx90/iOCO2V7vaXXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801606;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=XvVsoqH4aYRulmv3Tk9hWzl8BuWOdg69iluKd5EZjE8=;
	b=N7462jZOFWsPeU7rHKwKrkd/gzsjylLsF1P/Xxo8QbFkLB5LzpBNWGR5CLzYet6KEmXe
	 ViTDtfQS8QIb6VdhjL9j/wfKSbLt6p6pe3yzan8RWeXfbvc+d5prBz4Q0ZoZi0ZCydzgt
	 LfGfF51loPo0PzbykV6vQ77qjTb3ooRGW3kLcoBGCPoF1GVyJDqrzsE8DCG+ImmEY6KJh
	 o6ndffqlc1Bo1CqsEbsf4MfbO1H001gZnkxLAAYKBkP86A+kOhoEM1mR28sx3MgfD5C82
	 Vdn4JxPv5rwMXTZsNi9vD8EoBFVPLC7IzHAve5Ow5kB0uF6bqNMMfk0gud39fWZjt1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E66E606D82A;
	Wed,  4 Nov 2026 14:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E66E606D82A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jKS8Z6Rlzz5B15L;
	Wed, 04 Nov 2026 22:13:18 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A4EDFIV080065;
	Wed, 4 Nov 2026 22:13:15 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Wed, 4 Nov 2026 22:13:18 +0800 (CST)
X-Zmail-TransId: 2afb6aeb3d7e4ee-363d7
X-Mailer: Zmail v1.0
Message-ID: <20261104221318841yKO89PGcSNeaV4KutBOUJ@zte.com.cn>
Date: Wed, 4 Nov 2026 22:13:18 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIXSBhdGE6IGFoY2lfZHdjOiByZWplY3QgaW52YWxpZCBkZXZpY2UgdHJlZSBwb3J0IG51bWJlcnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A4EDFIV080065
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Wed, 04 Nov 2026 22:13:18 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AEB3D7E.000/4jKS8Z6Rlzz5B15L

From: Shao Mingyin <shao.mingyin@zte.com.cn>

ahci_dwc_init_dmacr() reads the "reg" property of every available child
node and uses it directly as a port number, both to compute the port
MMIO base and as an index into dpriv->dmacr[], which has AHCI_MAX_PORTS
entries.  ahci_platform_get_resources(), which runs earlier, checks the
same property against hpriv->nports and skips invalid child nodes, but
this second walk does not.

A device tree that describes one valid port and one port with a "reg"
value above AHCI_MAX_PORTS therefore makes the driver write past
dpriv->dmacr[] and access MMIO beyond the mapped region.  Apply the same
check as the resource loop and skip invalid child nodes with a warning.

Fixes: 33629d35090f ("ata: ahci: Add DWC AHCI SATA controller support")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Tested on 7.3.0-next-20261030 (QEMU/TCG arm64 guest, KASAN) with a
TEST-ONLY device tree.  The DT adds a snps,dwc-ahci node with port@0
and port@100; the TEST-ONLY printk hook in ahci_dwc_init_dmacr() is
applied to both kernels.  mem=512M keeps the fake MMIO window outside
System RAM.

  unpatched                            patched
  KASAN: slab-out-of-bounds            no KASAN report
  in ahci_dwc_probe                    port 100 skipped, boot

diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
index feb8a8539b8e..9094eb19e19f 100644
--- a/drivers/ata/ahci_dwc.c
+++ b/drivers/ata/ahci_dwc.c
@@ -225,6 +225,12 @@ static int ahci_dwc_init_dmacr(struct ahci_host_priv *hpriv)
 		if (of_property_read_u32(child, "reg", &port))
 			return -EINVAL;
 
+		if (port >= hpriv->nports) {
+			dev_warn(&dpriv->pdev->dev,
+				 "invalid port number %u\n", port);
+			continue;
+		}
+
 		port_mmio = __ahci_port_base(hpriv, port);
 		dmacr = readl(port_mmio + AHCI_DWC_PORT_DMACR);
