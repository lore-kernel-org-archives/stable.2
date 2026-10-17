Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1821891A9;
	Sat, 17 Oct 2026 02:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792205398; cv=none; b=dUArSwFapqoMiXmoEbjwBd3N7T903jSpjVS9DpErZbp97vu/wa2i9AiSou6I2l/UlHh5bTW2oyho4xnfU5jq8IvEt5otGMxxHYMRTN9HDNGQ7NUV9HbfmDluA/2LDcZYcODZ3mYNM427lnpkndC87w67GqjUGBJU1P+e4LKwcCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792205398; c=relaxed/simple;
	bh=0euMBpXL8iOhtQwMwFPTjpI1MpcsW7S2QlnDj/v8nLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qU/WPB2wG64TT2Z8nRcnmB+CxhG99R2NQ7rTkicb4sz6HMnEjJ2dhKC7aUjhAH/lgB7J8znzyvDYTDEfPwxAz9dG7y43WAptNJrLN6gMc6/w2vQRP/20dfneuFn6JGnqicfdvaNs1qhCLqxi5ihW8wsJ+Mhtg89HmNfCca5qJnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=eGHXmxtc; arc=none smtp.client-ip=115.124.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="eGHXmxtc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1792205385; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nATI1dwinW9aHIS28Bn4IeOTB2dnVSU87dYw4MGIlF4=;
	b=eGHXmxtcdh6ogygERe1mBEwbgTcgDzU+FMKJp6kVeVBfEZhPhCkWlR/DnHhrqAUSKpztuqIolQdYHLefq4fXgdCRzZgFPhAV6vQocWjpEckSrZpuSdGL81hOiAjXVj46Q0wpaBol5sB73OGQBIs40U6AkdoqVuIKp6ZLoWilCwk=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.128401|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0198099-0.00310662-0.977083;FP=215468512779060368|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032053168;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jh9kJmy_1792205062;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jh9kJmy_1792205062 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sat, 17 Oct 2026 10:44:23 +0800
From: liuc63 <liuc63@xiaopeng.com>
To: Peter Chen <peter.chen@kernel.org>
Cc: Roger Quadros <rogerq@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH v3] usb: cdns3: validate endpoint index from setup packet
Date: Sat, 17 Oct 2026 10:44:22 +0800
Message-ID: <20261017024422.3400907-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Chao <liuc63@xiaopeng.com>

cdns3_ep_addr_to_index() masks the endpoint address with 0x7F instead of
USB_ENDPOINT_NUMBER_MASK (0x0F).  wIndex is supplied by the USB host, so
bits 4-6 of the endpoint number are attacker-controlled and the returned
index can reach 143, while priv_dev->eps[] holds only
CDNS3_ENDPOINTS_MAX_COUNT (32) entries.  Both cdns3_req_ep0_get_status()
(GET_STATUS) and cdns3_ep0_feature_handle_endpoint() (SET/CLEAR_FEATURE)
feed that index straight into priv_dev->eps[index] and dereference the
result, so a crafted control request causes an out-of-bounds access.
Even when the index stays within 0-31, the stray bits alias the request
onto a different endpoint slot.

Mask the endpoint number with USB_ENDPOINT_NUMBER_MASK so the computed
index is always within [0, 31].  This mirrors the cdnsp counterpart
cdnsp_w_index_to_ep_index(), which already extracts the endpoint number
with the same mask.

In addition, eps[index] may be NULL for endpoints that are not enabled,
as cdns3_init_eps() only populates entries for endpoints enabled in
USB_CAP3.  Check priv_dev->eps[index] for NULL before dereferencing it
in both functions, matching the fix already applied to aspeed_udc in
commit ee0d382feb44 ("usb: gadget: aspeed_udc: validate endpoint index
for ast udc").

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
Changes in v3:
 - Mask the endpoint number with USB_ENDPOINT_NUMBER_MASK (0x0F) in
   cdns3_ep_addr_to_index() instead of bounding the 0x7F-derived index
   at the call sites; the index is now always within eps[], which also
   resolves the endpoint-aliasing concern raised by the Sashiko review
   (Peter Chen)
 - Drop the now-redundant index >= CDNS3_ENDPOINTS_MAX_COUNT check,
   keeping only the NULL check on priv_dev->eps[index] (Peter Chen)
 - The Sashiko review also flagged that the raw wIndex is passed
   unmasked to cdns3_select_ep() and so reaches the ep_sel register;
   that is pre-existing behaviour (commit 7733f6c32e36), orthogonal
   to this fix, and is deferred to a separate follow-up patch

Changes in v2:
 - Also check priv_dev->eps[index] for NULL, as endpoints not enabled
   in USB_CAP3 are left NULL by cdns3_init_eps() (Peter Chen)
 - Correct the reference: the same-class fix ee0d382feb44 is for
   aspeed_udc, not renesas_usb3; cite it with the commit title and
   drop the CVE mention (Peter Chen)
 - Fix the function name cdns3_ep0_handle_status() ->
   cdns3_req_ep0_get_status() in the commit message

v2: https://lore.kernel.org/linux-usb/20261012110107.2458022-1-liuc63@xiaopeng.com/
v1: https://lore.kernel.org/linux-usb/20260917103145.3047850-1-liuc63@xiaopeng.com/
---
 drivers/usb/cdns3/cdns3-ep0.c    | 4 ++++
 drivers/usb/cdns3/cdns3-gadget.c | 3 ++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-ep0.c b/drivers/usb/cdns3/cdns3-ep0.c
index e29989d57bef..ab18adec831e 100644
--- a/drivers/usb/cdns3/cdns3-ep0.c
+++ b/drivers/usb/cdns3/cdns3-ep0.c
@@ -251,6 +251,8 @@ static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
 		return cdns3_ep0_delegate_req(priv_dev, ctrl);
 	case USB_RECIP_ENDPOINT:
 		index = cdns3_ep_addr_to_index(le16_to_cpu(ctrl->wIndex));
+		if (!priv_dev->eps[index])
+			return -EINVAL;
 		priv_ep = priv_dev->eps[index];
 
 		/* check if endpoint is stalled or stall is pending */
@@ -368,6 +370,8 @@ static int cdns3_ep0_feature_handle_endpoint(struct cdns3_device *priv_dev,
 		return 0;
 
 	index = cdns3_ep_addr_to_index(le16_to_cpu(ctrl->wIndex));
+	if (!priv_dev->eps[index])
+		return -EINVAL;
 	priv_ep = priv_dev->eps[index];
 
 	cdns3_select_ep(priv_dev, le16_to_cpu(ctrl->wIndex));
diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 0d272e9c556c..f65a87f11e26 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -109,7 +109,8 @@ void cdns3_set_register_bit(void __iomem *ptr, u32 mask)
  */
 u8 cdns3_ep_addr_to_index(u8 ep_addr)
 {
-	return (((ep_addr & 0x7F)) + ((ep_addr & USB_DIR_IN) ? 16 : 0));
+	return ((ep_addr & USB_ENDPOINT_NUMBER_MASK) +
+		((ep_addr & USB_DIR_IN) ? 16 : 0));
 }
 
 static int cdns3_get_dma_pos(struct cdns3_device *priv_dev,
-- 
2.50.1

