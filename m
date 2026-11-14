Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674021;
	b=qD7Ets6u7ao3RKkVtgjjXrvA/jniY75V4Egez3Vs43bbWwBnDVAJeikIIR2FKo673ssB
	 ZRQ9gkQCeZZLSVKd3WCmamn125OrMYGZ4U911y7uNHFpzYOTMTvgBbua9+2/jUn/wGwZr
	 fpCjSCVCH3sUi5fhaDO3agp1BGKylZW2Y37f8iPAx/mwQERBN2L2dwmlEyVYLQhYrPP5P
	 1nKdtIbJSJPxnnANTtr8A++vtQ4BD3Z7SmjnEJEHMHcQyU0z1BYemSvu9I83h3ZnlqAZi
	 dXvO49RZA1aa96VzHkrtqGq5gd90sbXTgOFHKsp+/qnPJ2S4SqGL6Y/kSYPSZSDgTlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674021;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 X-Zmail-TransId:X-Mailer:Message-ID:In-Reply-To:References:Date:
	 Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:X-TLS:
	 X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=CXusS3WynsuamluNFyCP0oICY5fs8xPh6HyTsyP8xPo=;
	b=Sj3FLKcdLVcrx5iei14b2cJl0g1iWWhbwDIPxXbeEDGrXD90r0o8mIaYzGHw6wmApZb/
	 afM8dX/0P4fSb42hETBN6YojdDdgqpKtZ6oDraHK7dUSs1FHn9WYU8xLU1g0IXmdhaECl
	 9fmu90nMBwyI5SoeVl4CYwFgu8uJLuMeZkkbrJ2KvTAl2l7yxflbpGENe8PHb86m4PtLt
	 pcXke0pSJRZ0nsWhaMVH2YcMI7wsd78FV+gWxf1AayZe6/yBPaFne1M/+OFknotkHXJos
	 CTKqXGBq2g9tLMbEsg6ULzM23v9rAeUB0GoW9ClAwu0rVpwoKQbCFKqrqKPTNKpa1BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	dkim=pass header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=A4HjaOYb;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E16C606A330;
	Sat, 14 Nov 2026 16:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E16C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zte.com.cn header.i=@zte.com.cn header.a=rsa-sha256 header.s=z202610 header.b=A4HjaOYb
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jRfnn6ptXz8XrrM;
	Sun, 15 Nov 2026 00:33:33 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zte.com.cn;
	s=z202610; t=1794674014;
	bh=ZDkF8FVy3XgTS5h082PmBKS9ATXs63gctDS/GVHZMyE=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject;
	b=A4HjaOYbOHSjBSEsKZ9pgZrD4QKzl1GT09CvOVpKo71ivE/iLMzb7/k+qgo1evZ+D
	 jhttp3duJzL/cyNiCM7y2MH9lUPufdotwX2e9GC0y8Iy2oB9BCE9X+SOtqjKzhY+6E
	 25MOMzK1/6fo7UEsye0jTLdakV27/9USZvV2fe0APM/gdv2D4XDzFf1gRiCKUiaj2j
	 /qNvweoQfTGvpEjbTpFxsW3jcnLW+26le2RnZF2WMGeIOyTmszBSbkvnHWyah5YaQM
	 IbX0Xq4+oT4Ata2Kq2Joj+tUxhZfqceICCsJxmkAnDvEcXl6zdE4eSR5S7/yOyX5Hx
	 jNyMoLWm7jUPw==
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 6AEGXOMk085602;
	Sun, 15 Nov 2026 00:33:24 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Sun, 15 Nov 2026 00:33:27 +0800 (CST)
X-Zmail-TransId: 2afa6af88d57166-25141
X-Mailer: Zmail v1.0
Message-ID: <20261115003327071py2fApRTKzNRqgeSpm03u@zte.com.cn>
In-Reply-To: <20261115003324243qi0CFfSksizkJybVkq3QH@zte.com.cn>
References: 20261115003324243qi0CFfSksizkJybVkq3QH@zte.com.cn
Date: Sun, 15 Nov 2026 00:33:27 +0800 (CST)
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
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDIvMl0gejJyYW06IHJldHVybiB0aGUgYWxsb2NhdGVkIFpvcnJvIFJBTSBjaHVua3Mgb24gdW5sb2Fk?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6AEGXOMk085602
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Sun, 15 Nov 2026 00:33:34 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AF88D5D.000/4jRfnn6ptXz8XrrM

From: Shao Mingyin <shao.mingyin@zte.com.cn>

get_z2ram() collects whichever chunks are available in
zorro_unused_z2ram, clearing their original bits and storing their
addresses in z2ram_map. Those chunks need not form a prefix of the
Zorro RAM area: chunks already used by the system remain unavailable.

z2_exit() instead sets bits 0 through z2_count - 1. With holes in the
original bitmap this marks memory owned by other users as available
and leaves some of the driver's own chunks reserved. A later allocation
can then reuse memory that is still in use.

Recover each original chunk number from its saved address when
returning it to the bitmap. Keep advancing the map index so the
following Chip RAM cleanup still starts after the Zorro entries.

Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
Testing:
Built with W=1 using m68k amiga_defconfig. Exercised the actual
allocation and unload functions in a host test program with substitutes
for the Zorro bitmap, memory addresses and unrelated device teardown.
Of eight bitmaps, the base code returns four incorrectly; the fixed code
restores the original bits in all eight. Cases include holes, entries
above bit 63, empty and prefix controls, and all chunks available.
No Amiga hardware test was performed.

The incorrect bit restoration is already present in the initial Linux
git snapshot; its original introducing commit has not been identified.

 drivers/block/z2ram.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/z2ram.c b/drivers/block/z2ram.c
index 15ef92a9744414b9387f4520dc3c7b2f42bebc87..57df672f62a1a2d3db0149ecfbfc0d213aa5f016 100644
--- a/drivers/block/z2ram.c
+++ b/drivers/block/z2ram.c
@@ -395,7 +395,11 @@ static void __exit z2_exit(void)
 		i = 0;
 
 		for (j = 0; j < z2_count; j++) {
-			set_bit(i++, zorro_unused_z2ram);
+			unsigned long chunk = (z2ram_map[i++] -
+				(unsigned long)ZTWO_VADDR(Z2RAM_START)) >>
+				Z2RAM_CHUNKSHIFT;
+
+			set_bit(chunk, zorro_unused_z2ram);
 		}
 
 		for (j = 0; j < chip_count; j++) {
-- 
2.43.0
