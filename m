Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F71418348;
	Mon, 12 Oct 2026 11:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791802883; cv=none; b=cfAt8uYMD6f+U8/Ai0R9kQpfyBb3JEa2QKv8fqGUB62ixoGNUnwy6BFRj1lxxSQ8pvd7uDBhE07+acOtEoVjzl/3KjAivDOp0ME9vZnBYm3IrInVero5OyVj4ekAh7bQ8c9IASs6m1YrNec8gGFgCqnWx4h6/eBL/AwsWgjFJSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791802883; c=relaxed/simple;
	bh=ejVccV6KXhEpNNiDe7h4LA5TD8U1+7UmqMcA2H9iIxc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=atQWo17Q4xIalEpjOPQ+6TdQPZBsdFhO10QNdpykMl9K9WpaYe09lT4xJopwSzrAcKbU7vspWdQK/+4yCWwUI+TTY7iHkZ6cO368dJ+FZKIoHblsv0EG71VmehYkncs5TbM5VoP8zjV8j9hqx12i2LhZTg1yJPVbBSZTfL6tYp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=uaYVNQ3I; arc=none smtp.client-ip=115.124.28.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="uaYVNQ3I"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1791802871; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VTrnbtefp3lyWGpNDEx0a/iBNIMGyHW9EmaIxO2JWps=;
	b=uaYVNQ3IGTtlemAuOxC2yvDmluqDYyu+OipoIkMDyOTlWTkkd0AVVH6uVbjf9FVVI7oSlAT9t9KP3MezZrUxW54Jwk5VJOJaiwdKvQAnvUNnTp9Dh/SsBVu5ljnpzoQDti0PrLGdLUOXx2+2kQ79CpmzVf47qeIWvi/RR6ikGzA=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1011182|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00218585-0.00104216-0.996772;FP=9292473355862164528|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.ja6sMHr_1791802869;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.ja6sMHr_1791802869 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 12 Oct 2026 19:01:10 +0800
From: liuc63 <liuc63@xiaopeng.com>
To: Peter Chen <peter.chen@kernel.org>
Cc: rogerq@kernel.org,
	pawell@cadence.com,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	liuwb@xiaopeng.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: cdns3: validate endpoint index from setup packet
Date: Mon, 12 Oct 2026 19:01:07 +0800
Message-ID: <20261012110107.2458022-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Liu Chao <liuc63@xiaopeng.com>

cdns3_ep_addr_to_index() computes (ep_addr & 0x7F) + 16 for IN
endpoints.  wIndex is supplied by the USB host, so ep_addr & 0x7F can
be up to 127, giving an index up to 143.  The eps[] array has only
CDNS3_ENDPOINTS_MAX_COUNT (32) entries.

Both cdns3_req_ep0_get_status() (GET_STATUS) and
cdns3_ep0_feature_handle_endpoint() (SET/CLEAR_FEATURE) pass the
unvalidated index straight into priv_dev->eps[index] and then
dereference the result.

Besides the out-of-bounds index, eps[index] may also be NULL for
endpoints that are not enabled, as cdns3_init_eps() only populates
entries for endpoints enabled in USB_CAP3.

Add a bounds check against CDNS3_ENDPOINTS_MAX_COUNT together with a
NULL check in both functions, matching the fix already applied to
aspeed_udc in commit ee0d382feb44 ("usb: gadget: aspeed_udc: validate
endpoint index for ast udc").

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: <stable@vger.kernel.org>
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
Changes in v2:
 - Also check priv_dev->eps[index] for NULL, as endpoints not enabled
   in USB_CAP3 are left NULL by cdns3_init_eps() (Peter Chen)
 - Correct the reference: the same-class fix ee0d382feb44 is for
   aspeed_udc, not renesas_usb3; cite it with the commit title and
   drop the CVE mention (Peter Chen)
 - Fix the function name cdns3_ep0_handle_status() ->
   cdns3_req_ep0_get_status() in the commit message

v1: https://lore.kernel.org/linux-usb/20260917103145.3047850-1-liuc63@xiaopeng.com/
---
 drivers/usb/cdns3/cdns3-ep0.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/cdns3/cdns3-ep0.c b/drivers/usb/cdns3/cdns3-ep0.c
index e29989d57..d26fa89b6 100644
--- a/drivers/usb/cdns3/cdns3-ep0.c
+++ b/drivers/usb/cdns3/cdns3-ep0.c
@@ -251,6 +251,9 @@ static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
 		return cdns3_ep0_delegate_req(priv_dev, ctrl);
 	case USB_RECIP_ENDPOINT:
 		index = cdns3_ep_addr_to_index(le16_to_cpu(ctrl->wIndex));
+		if (index >= CDNS3_ENDPOINTS_MAX_COUNT ||
+		    !priv_dev->eps[index])
+			return -EINVAL;
 		priv_ep = priv_dev->eps[index];
 
 		/* check if endpoint is stalled or stall is pending */
@@ -368,6 +371,8 @@ static int cdns3_ep0_feature_handle_endpoint(struct cdns3_device *priv_dev,
 		return 0;
 
 	index = cdns3_ep_addr_to_index(le16_to_cpu(ctrl->wIndex));
+	if (index >= CDNS3_ENDPOINTS_MAX_COUNT || !priv_dev->eps[index])
+		return -EINVAL;
 	priv_ep = priv_dev->eps[index];
 
 	cdns3_select_ep(priv_dev, le16_to_cpu(ctrl->wIndex));
-- 
2.50.1

