Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=37.187.101.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794520317;
	b=Lb+AYj+BMdfbUBWp9RmtSxCE8TuCZsrpeHyk5+Htj6WO6G8FYvtuC6YBzdT9HkRvDXFf
	 s92o0Iuce5kMWWtDulmugEj0hi2AzP0zaDJ+a6a7RT3n4a0cif4ESjWgnHyy7T6ttnIJu
	 38n8m8xlu04LgimQTYT7tVqYG6vNm8WoiuIgS8pVg9iT8j9k7cDF9+uVr365Fw5JPInay
	 xDCLP/Qyg9S8oNSdRwZ4OnT1YjLdWjoolLTyCQSLutv6gFi7/ZieqZ83USoI6I+VgYnJj
	 djaigAc0OejMdLvUixooL49jqS6WmTGlPhn5SgyFv3mtx1DRCS8Mnt+f2dWP/6s6rzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794520317;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References;
	bh=w/NkXJ27IA+NN3KMm91jOopXcaRSh7yA1WA8BqvVdRE=;
	b=qtycDVqA/SvmdXmIbX2w98D94+lPq/joTZL797B+3Vcf2IhqEFwsSHsSpHHsSJwmIo6f
	 RyBjNA1OZtgPSYs0ICqjWxP9M+mGBaCDM9hDKLoIxhB6MSXveMq3WMSBBdyGeIuVauzo0
	 rotLBso0j8n6XQD2ISig1cfzbW3hb385kTFPSf7P07y75HbBxl0KmLvBlPWYjv3JK50Zb
	 aGN5V/3Kevu89fBZ8z0VMPgibjy8SUS346KMS9wn79ZlVimzIXMoPcIBLtAWdfDRvuA5Y
	 jLlIomUFCBNNA+By0skzIRkKyJrQVrBEvy1iYb9MOB4HRHnP7iupIrNwvQpSfFVhaSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sven.de;
	spf=pass smtp.mailfrom=sven.de;
	dkim=pass header.d=sven.de header.i=@sven.de header.a=rsa-sha256 header.s=default header.b=pRVk5tly;
	arc=none smtp.remote-ip=37.187.101.158
Received: from mail.sven.de (mail.sven.de [37.187.101.158])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C00B606A321;
	Thu, 12 Nov 2026 21:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C00B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sven.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sven.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=sven.de header.i=@sven.de header.a=rsa-sha256 header.s=default header.b=pRVk5tly
Received: by mail.sven.de (Postfix, from userid 1000)
	id A6EECC01D50; Thu, 12 Nov 2026 22:51:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sven.de; s=default;
	t=1794520307; bh=w/NkXJ27IA+NN3KMm91jOopXcaRSh7yA1WA8BqvVdRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pRVk5tlyczjXKcLesDewJD5+RHkLogWTjVV7EscK4n4P4MkGU+b4zmx5xQhfrzHLv
	 tLgiwvDXlEs0rBCICvsQsKRH2MhMOWKL/V613OZv84uKarsc9XthlpQnWgp1qvtlxi
	 MyJWlRW+yVB0PYYxflQSSl5kVWdUUDMzaa2P63cw=
From: Sven Neuhaus <sven-kernel@sven.de>
To: linux-usb@vger.kernel.org
Cc: westeri@kernel.org,
	andreas.noever@gmail.com,
	YehezkelShB@gmail.com,
	linux-kernel@vger.kernel.org,
	Sven Neuhaus <sven-kernel@sven.de>,
	stable@vger.kernel.org,
	Mario Limonciello <superm1@kernel.org>
Subject: [PATCH 2/2] thunderbolt: Flush the ring interrupt status clear
Date: Thu, 12 Nov 2026 22:51:43 +0100
Message-Id: <1794520303-5758-3-git-send-email-sven-kernel@sven.de>
In-Reply-To: <1794520303-5758-1-git-send-email-sven-kernel@sven.de>
References: <1794520303-5758-1-git-send-email-sven-kernel@sven.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

On hosts without QUIRK_AUTO_CLEAR_INT, ring_msix() clears the ring's
bit in REG_RING_INT_CLEAR before it schedules ring_work(). This is a
posted write and nothing is read from the NHI afterwards, so the clear
can take effect after the next frame on the ring has completed. It
then clears the status of that frame as well. The descriptor stays
completed and the interrupt stays enabled, but no MSI-X is raised, and
the frame waits until another interrupt on the ring runs ring_work().

Before commit 468c49f44759 ("thunderbolt: Disable interrupt auto clear
for rings") the status was cleared by reading REG_RING_NOTIFY_BASE,
and a read is not posted.

Read back REG_RING_INTERRUPT_BASE after the write, so the clear has
taken effect before ring_work() looks at the descriptors. A frame that
completed before that point is seen by ring_work(), and a later one
raises a new interrupt.

This was seen between two hosts with AMD Strix Halo USB4 host routers
(1022:158d, 1022:158e) connected by USB4 cables, running an
out-of-tree service driver that exchanges XDomain requests and
responses and moves data over its own rings. When one host sent a
response and a request back to back, the request sometimes stayed in
the peer's control RX ring until tb_xdomain_request() timed out and
sent it again. In a request/reply test with 300 us between exchanges,
3-7% of the exchanges took the whole request timeout (about 75 ms).
A debug build that checked the control RX ring every 500 us found
these frames with RING_DESC_COMPLETED set, the ring's bit set in
REG_RING_INTERRUPT_BASE and its bit clear in REG_RING_NOTIFY_BASE.
The data rings of the driver lost completions the same way, which
showed up as retransmissions after the driver's ack timeout.

With this patch, 6000 exchanges of 8-64 KiB had none above 1.7 ms
(99th percentile 0.35-0.58 ms, before about 75 ms), no request was
sent twice, and the retransmissions went away (84 in 1000 exchanges
before, none after). ib_write_bw at 4 and 8 MiB stayed within
run-to-run noise.

Tested on 7.3.3; ring_clear_msix() is unchanged in the thunderbolt.git
fixes branch, where the patch applies as is. Not tested: other AMD
host routers. Intel hosts set QUIRK_AUTO_CLEAR_INT and return before
the write, so they are not affected.

The analysis, the fix and the tests were done with an AI coding
assistant.

Fixes: 468c49f44759 ("thunderbolt: Disable interrupt auto clear for rings")
Cc: stable@vger.kernel.org
Cc: Mario Limonciello <superm1@kernel.org>
Signed-off-by: Sven Neuhaus <sven-kernel@sven.de>
---
 drivers/thunderbolt/nhi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index e99a3fcc4a29..dd109f6ac70f 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -533,6 +533,14 @@ static void ring_clear_msix(const struct tb_ring *ring)
 	else
 		iowrite32(BIT(bit), ring->nhi->iobase + REG_RING_INT_CLEAR +
 			  4 * (ring->nhi->hop_count / 32));
+
+	/*
+	 * Flush the posted write before ring_work() looks at the
+	 * descriptors. Otherwise the clear can take effect after the next
+	 * frame has completed and clear its status too, and that frame
+	 * never raises an interrupt.
+	 */
+	ioread32(ring->nhi->iobase + REG_RING_INTERRUPT_BASE);
 }
 
 irqreturn_t ring_msix(int irq, void *data)
-- 
2.47.3

