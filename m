Received: from out28-2.mail.aliyun.com (out28-2.mail.aliyun.com [115.124.28.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D702472AE;
	Sun, 13 Sep 2026 12:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789301106; cv=none; b=YvgQesGiOrdQ/q3JtTv4Cb41MtVgOM9wXmtUncKoQZI5i+NO3xBR7/udxt6h8XGAFaSMynV56xZfOFHP+Pbp7ZXV8D34derCybyE9B0x+LN+yG3bbcRaHNps0w/edzuZyELqBpmAfoRQoUurXuu5pv9lnT6WEcm38QeKsJGnHPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789301106; c=relaxed/simple;
	bh=WIe6ukNPWLFz7U5vYq1bT+6mHD4BU0hSjp4GdzTV/yo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PuqG78COiI+ZWuxFTzKmSKEFv9k72d0I8adMx+W/15rArJPC2twAwaQmb6xMxZLPttTdPDQlzyFHGJwMeNMru8rGvXue4wxD6DS06pRlydv6DmM8lnzg5eRDKkqArdSPyT8wlnDgBEUGfn92q84UTjfyiIV12qMt7zD6F5y3BuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=efkFnf/B; arc=none smtp.client-ip=115.124.28.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="efkFnf/B"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789301100; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wG60YZwiNpAAKnOxkZrxkPXo59sGkQnDfg3Hy3nBu+Y=;
	b=efkFnf/BOda3tjOPIkO08R7YyjOdWfBeGMtcULh5qj01VgOtzxYeoeHnL4sPWXTcvR+ALBtuwKKVStvtncAqLYjgI3Z15CGC1Zp7pVksenLNHQ/40VXSyXV+r++DQllwT0sGUfjag+q3ZG5fEsOpkRGVOGRMzZjukpBFD26WbAs=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07440358|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0290235-0.00022646-0.97075;FP=11235475274937681233|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jCW-I85_1789301098;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jCW-I85_1789301098 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 13 Sep 2026 20:04:59 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: Linus Walleij <linusw@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>,
	stable@vger.kernel.org
Subject: [PATCH] usb: fotg210: validate endpoint index in ep0 handlers
Date: Sun, 13 Sep 2026 20:04:58 +0800
Message-ID: <20260913120458.1608186-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fotg210_set_feature(), fotg210_clear_feature() and fotg210_get_status()
use wIndex from the USB setup packet to index the fotg210->ep[] array
without verifying that the endpoint number falls below
FOTG210_MAX_NUM_EP (5).  USB_ENDPOINT_NUMBER_MASK is 0x0f, so a
malicious host can issue a setup packet with wIndex 5..15, resulting in
an out-of-bounds array read.  The resulting wild pointer is then
dereferenced in fotg210_set_epnstall() or fotg210_is_epnstall(), which
compute an MMIO register offset from ep->epnum and perform iowrite32
through it.

fotg210_clear_feature() is especially problematic: the out-of-bounds
access occurs at function entry (source-level) regardless of which
USB_RECIP_* case is taken, because the ep pointer is computed before the
switch statement.

Add upper-bound checks on the endpoint number derived from wIndex in
all three functions.  Invalid endpoint numbers in clear_feature now
trigger fotg210_request_error() (STALL) instead of silently falling
through to fotg210_set_cxdone().  Also add the missing le16_to_cpu()
conversion for ctrl->wIndex in fotg210_get_status() to fix a sparse
endianness warning.

Fixes: b84a8dee23fd ("usb: gadget: add Faraday fotg210_udc driver")
Cc: stable@vger.kernel.org
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/fotg210/fotg210-udc.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/fotg210/fotg210-udc.c b/drivers/usb/fotg210/fotg210-udc.c
index d9e024873..127a259c8 100644
--- a/drivers/usb/fotg210/fotg210-udc.c
+++ b/drivers/usb/fotg210/fotg210-udc.c
@@ -661,7 +661,7 @@ static void fotg210_set_feature(struct fotg210_udc *fotg210,
 	case USB_RECIP_ENDPOINT: {
 		u8 epnum;
 		epnum = le16_to_cpu(ctrl->wIndex) & USB_ENDPOINT_NUMBER_MASK;
-		if (epnum)
+		if (epnum && epnum < FOTG210_MAX_NUM_EP)
 			fotg210_set_epnstall(fotg210->ep[epnum]);
 		else
 			fotg210_set_cxstall(fotg210);
@@ -677,8 +677,8 @@ static void fotg210_set_feature(struct fotg210_udc *fotg210,
 static void fotg210_clear_feature(struct fotg210_udc *fotg210,
 				struct usb_ctrlrequest *ctrl)
 {
-	struct fotg210_ep *ep =
-		fotg210->ep[ctrl->wIndex & USB_ENDPOINT_NUMBER_MASK];
+	u8 epnum = le16_to_cpu(ctrl->wIndex) & USB_ENDPOINT_NUMBER_MASK;
+	struct fotg210_ep *ep;
 
 	switch (ctrl->bRequestType & USB_RECIP_MASK) {
 	case USB_RECIP_DEVICE:
@@ -688,7 +688,12 @@ static void fotg210_clear_feature(struct fotg210_udc *fotg210,
 		fotg210_set_cxdone(fotg210);
 		break;
 	case USB_RECIP_ENDPOINT:
-		if (ctrl->wIndex & USB_ENDPOINT_NUMBER_MASK) {
+		if (epnum >= FOTG210_MAX_NUM_EP) {
+			fotg210_request_error(fotg210);
+			break;
+		}
+		if (epnum) {
+			ep = fotg210->ep[epnum];
 			if (ep->wedged) {
 				fotg210_set_cxdone(fotg210);
 				break;
@@ -744,8 +749,8 @@ static void fotg210_get_status(struct fotg210_udc *fotg210,
 		fotg210->ep0_data = cpu_to_le16(0);
 		break;
 	case USB_RECIP_ENDPOINT:
-		epnum = ctrl->wIndex & USB_ENDPOINT_NUMBER_MASK;
-		if (epnum)
+		epnum = le16_to_cpu(ctrl->wIndex) & USB_ENDPOINT_NUMBER_MASK;
+		if (epnum && epnum < FOTG210_MAX_NUM_EP)
 			fotg210->ep0_data =
 				cpu_to_le16(fotg210_is_epnstall(fotg210->ep[epnum])
 					    << USB_ENDPOINT_HALT);

base-commit: 2f0c1cf72f4682178506f513bbf015e591b1aa4a
-- 
2.50.1

