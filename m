Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA8E23BCED;
	Mon, 19 Oct 2026 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792396624; cv=none; b=PYuZ+dNV7JdgavzxEcyVPZur2hwIlFm6YYlJORY7EclHv8XxLHI79fv5d/V1B+mXzWNz+Vw7IBuBmOwQwNy47JiCzT9Sjy3eQi9c9HbRJcl68l4XZxmpXQh1hbWUs5OwRjtOriNpqqL4ybWy3p9+L99+qCQaeaYWb9hWWo/oH4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792396624; c=relaxed/simple;
	bh=9YHpUOavzvxENmDeG2DwSC3ErhKfgQGBEBFz4en7Hr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LEFPQRgKDUlg9G8fRyVMCmm1fOK5pnVMpVN9SCdlVDAXfwC5sH+veSktzU7XmvmBHctvUDAXt/MrOOTheEJfq4Ox78jwoYDWRtFnr6zo3XPyiRHickigCz8jo7ZSIgzLb8RSP8sbX4jHWw2vv4hpLGAkRdBmEC3a4+vchPSaRjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=noiyCPMo; arc=none smtp.client-ip=115.124.28.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="noiyCPMo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792396613; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HtSxq9ch9V5183EuTDsUXy0y56NBWimOMgLh4wLO5ko=;
	b=noiyCPMoD96lZI9hl03NUAj3EP6JpTxOzYOejnNadf0VB+znpluyDNZnu63SB+t/FGeriRgjDpbpaHtHCq+AZzoKtzD/N0aSQxFoGvOPOVaN8E8X1m5HH6Ai0stgVHtZnyQsmi+dPluAxro4viO7nLurWqvAOokgV3Q6y/dikyE=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07449403|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0915784-0.000939334-0.907482;FP=9866395368074857681|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045213054;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.jk9xSR3_1792396612;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jk9xSR3_1792396612 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 19 Oct 2026 15:56:52 +0800
From: liuc63 <liuc63@xiaopeng.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Weibin Liu <liuwb@xiaopeng.com>,
	linux-usb@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: net2280: fix out-of-bounds read of short packet in write_fifo
Date: Mon, 19 Oct 2026 15:56:49 +0800
Message-ID: <20261019075651.2093625-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Chao <liuc63@xiaopeng.com>

write_fifo() handles the trailing short word of an IN transfer by
reading a full 32-bit word from req->buf even when only 1..3 bytes
remain. get_unaligned((u32 *)buf) therefore reads up to three bytes
past the end of the request buffer, which KASAN reports as a
slab-out-of-bounds read.

The over-read bytes are not sent to the host: set_fifo_bytecount()
limits the FIFO to count & 0x03 bytes, so this is an out-of-bounds read
rather than an information leak.

Copy the remaining 1..3 bytes into a zero-padded word and feed that to
the existing get_unaligned()/cpu_to_le32s() sequence, so the trailing
word is built only from data that belongs to the request. The full-word
path above is unchanged, and reusing get_unaligned()/cpu_to_le32s()
keeps the byte order identical on both little- and big-endian hosts.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/gadget/udc/net2280.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index 7c5f30cfd24d..a1f5d11f82d2 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -649,7 +649,18 @@ static void write_fifo(struct net2280_ep *ep, struct usb_request *req)
 	 * when maxpacket is not a multiple of 4 bytes.
 	 */
 	if (count || total < ep->ep.maxpacket) {
-		tmp = count ? get_unaligned((u32 *)buf) : count;
+		/*
+		 * Don't read past the end of the request buffer: a short
+		 * trailing packet has only count & 0x03 valid bytes. Copy
+		 * them into a zero-padded word and reuse the same
+		 * get_unaligned()/cpu_to_le32s() sequence as the full-word
+		 * path above, so the byte order on the wire is unchanged.
+		 */
+		u8 tail[4] = {};
+
+		if (count)
+			memcpy(tail, buf, count & 0x03);
+		tmp = get_unaligned((u32 *)tail);
 		cpu_to_le32s(&tmp);
 		set_fifo_bytecount(ep, count & 0x03);
 		writel(tmp, &regs->ep_data);
-- 
2.50.1

