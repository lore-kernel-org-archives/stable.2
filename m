Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794323021;
	b=pJSgexrQIk0SRdx8Bg/RvWnEfag54r2angvgKU5m5WIFkWAA/NzgNxo7oBkk9gVFAT4c
	 WO2QAvRn2ZDk9B2Bl07ELhnPVgazjfnDWFJlisDjscg4X8jDC9aHN99njZg+p/wiEKTas
	 KKoRbpBfiSBIFyvKUiFYMVa3ukMZQ4iXEPL/nKATdKRhHJSu3gQIo6Ynfyc4VSlTJEpCx
	 7/S5ctDtDlMatQkwJv4PvHvqRNJG5SdHewoZMiRgHthhvpb1rvfNtlXguYm/oK0nSg+t+
	 BAryvGmS/KpcbA/fOQBFuQz5Earmei02i+xxaSHEDb40nQaPMxwT62/YzJso9AqSEnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794323021;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=ggJPbILCYL46WuX1BBPeY3Wpb3fsoNxyA10edzKi5X8=;
	b=STGAuvj130HSvryBFguHBW6ZsTAv12pvwz8Kus2z6R3Jt4jzWPjXDGIkeZohJhzcg8Ke
	 qjX/g8GTNDjOokS/p+IA3CGumsdmjXgVopZXq4GFwngpXvbK/DFyK/TFKcWItjRI4x7Ra
	 ckEuJEWrZFZGSgp78ktCFp9uc/z2NEJuyBMGk7qJ2IfqySvUB8ClAoN8aHxiY77O06g5b
	 C8hAfo4Dh5ktzDBq4gvfSAJxBmXc19THnuw3TJk/++mkA2M9+2ChAu5OttTq5pdYLma2p
	 +y+kJdaDaUURDy01hA8V2nZgRV13g1YYRunrRYy6fqo+ivctNKq5a350bP1OGbIxR7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=pQI17GVq;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2663760A2627;
	Tue, 10 Nov 2026 15:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2663760A2627
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=pQI17GVq
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jP8zq42Zwz52SGb;
	Tue, 10 Nov 2026 23:03:35 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794323015;
	bh=OEKQR5Ol/enBUiw6cnVbeWG4AEsmfCb0Af18zShHpS0=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=pQI17GVqRiWsk6qMcI+HzWGa48sLrm4UafYNLMFaCapU1KDvMcgwNYiV86Z5r56kl
	 G6uIlA0X9tEqanHLTUFrnqRTMQEdk0h724oXrxJjRqif9wH0AuG9iz4fxZPjmrkIWk
	 ztRSwtM3MbbpWjjLA2VdnCqC2/W+hTbZRhplfrW6QrnNxUvb4ww6Fju63RAdUxH/+Q
	 s2XkqvjYznIbJySNrBxxvK5EHiH9qaYDYvzQ8ZT8uugNRX+gIslr/Q35+AUBvK1iFy
	 i9VSuedcDB4MY83EwT+Jnio77bxxVgYz55witR9XZDy1dUxirRUKYv6g6O6dXoghF9
	 3fycid4EFVY8w==
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6AAF3U9L030948;
	Tue, 10 Nov 2026 23:03:30 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 10 Nov 2026 23:03:33 +0800 (CST)
X-Zmail-TransId: 2afb6af3324561a-07c58
X-Mailer: Zmail v1.0
Message-ID: <20261110230333900hZfrwSglqwIg7teONyzzq@zte.com.cn>
In-Reply-To: <20261110230327212pqd9rWq5IWa4wD-Ckj5C3@zte.com.cn>
References: 20261110230327212pqd9rWq5IWa4wD-Ckj5C3@zte.com.cn
Date: Tue, 10 Nov 2026 23:03:33 +0800 (CST)
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
Cc: <hansg@kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDIvMl0gYXRhOiBhaGNpX2R3YzogcmVqZWN0IGludmFsaWQgRFQgcG9ydCBudW1iZXJz?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AAF3U9L030948
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 10 Nov 2026 23:03:35 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF33247.000/4jP8zq42Zwz52SGb

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
check as the resource loop and skip invalid child nodes.  That loop has
already reported the invalid port number, so do not print a second
warning.

Fixes: 33629d35090f ("ata: ahci: Add DWC AHCI SATA controller support")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

---
v2:
- Do not print a warning for the invalid port number: the resource loop
  has already reported it (Niklas Cassel).  The validity check itself
  is unchanged.
- Send as 2/2, with the libahci_platform patch as 1/2.
- Carry Damien Le Moal's Reviewed-by from v1: the only code change is
  dropping the redundant warning (confirmed by Niklas Cassel).
- v1: https://lore.kernel.org/all/20261104221318841yKO89PGcSNeaV4KutBOUJ@zte.com.cn/

Tested on 7.3.0-next-20261030 (QEMU/TCG arm64 guest, KASAN) with a
TEST-ONLY device tree.  The DT adds a snps,dwc-ahci node with port@0
and port@100; the TEST-ONLY printk hook in ahci_dwc_init_dmacr() is
applied to both kernels.  mem=512M keeps the fake MMIO window outside
System RAM.

  unpatched                            patched
  KASAN: slab-out-of-bounds            no KASAN report
  in ahci_dwc_probe                    port 100 skipped, boot
---
 drivers/ata/ahci_dwc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/ata/ahci_dwc.c b/drivers/ata/ahci_dwc.c
index feb8a8539b8e..0ace0baa2b94 100644
--- a/drivers/ata/ahci_dwc.c
+++ b/drivers/ata/ahci_dwc.c
@@ -225,6 +225,10 @@ static int ahci_dwc_init_dmacr(struct ahci_host_priv *hpriv)
 		if (of_property_read_u32(child, "reg", &port))
 			return -EINVAL;
 
+		/* Already reported by ahci_platform_get_resources() */
+		if (port >= hpriv->nports)
+			continue;
+
 		port_mmio = __ahci_port_base(hpriv, port);
 		dmacr = readl(port_mmio + AHCI_DWC_PORT_DMACR);
 
-- 
2.27.0
