Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E947E4C2265;
	Thu, 17 Sep 2026 10:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641131; cv=none; b=qtKMm/IECFlDU449QaElNPnskEMrJ6qKeqJMkWuYQMg/csbCukK4Xn78RnPhJPwwUEA9ZUKW4QRsxr4QwNeVbMMHh9QWwCSQ9AIUDlEzJljcoNySB1cCVH/MrCoVFRHvJhWcx7sHlYh13gF8MSpYGUfqmJsfOv9qbr9OB29Rf5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641131; c=relaxed/simple;
	bh=J7IzSTzcbAW8tUvAwlOLox/7EhQXlW6N5S0aFC2A/Ac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HYJCKl8GCxzz3ULF5h62j0E5emjbBEEnC+4E1F/dcL4ecLW6/1/rDsMkyCREyLpg1VGUaWAYPneH//1dDAv/MV3IEIYdOvXbSLner+V9MuL82DIYWI3xYkcMYUYq6rqbhA9mOhhNhTboyG+w/+FC7rZMYMig1jYZRiJLkOt6J64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=E2037CIk; arc=none smtp.client-ip=115.124.28.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="E2037CIk"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789641109; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=igroM6/Wnnesnam1veBe3z7L7Uq9BdvzbgCjNVnLJOc=;
	b=E2037CIkuQO1IGQ+44lZOpjVTPo/gzPPYXjxnKW5f870J7tNyMbi/1i0zc1QQD0wlTtaxmqdkD0FQTmnzCZebhKBmOcO8gUEnQ6uOakIC+81wmwUUVPcDewIldEyApYbJmOCjGqFeWXjoPNqo7UI9MvXCKdh0pV4jLRfIIUrNFg=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2691761|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00108014-0.00179103-0.997129;FP=10402610938895811888|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037021217;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jFxIJ2U_1789641107;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jFxIJ2U_1789641107 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 18:31:48 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: peter.chen@kernel.org,
	pawell@cadence.com
Cc: rogerq@kernel.org,
	gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	liuwb@xiaopeng.com,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH] usb: cdns3: validate endpoint index from setup packet
Date: Thu, 17 Sep 2026 18:31:45 +0800
Message-ID: <20260917103145.3047850-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cdns3_ep_addr_to_index() computes (ep_addr & 0x7F) + 16 for IN
endpoints.  wIndex is supplied by the USB host, so ep_addr & 0x7F can
be up to 127, giving an index up to 143.  The eps[] array has only
CDNS3_ENDPOINTS_MAX_COUNT (32) entries.

Both cdns3_ep0_handle_status() (GET_STATUS) and
cdns3_ep0_feature_handle_endpoint() (SET/CLEAR_FEATURE) pass the
unvalidated index straight into priv_dev->eps[index] and then
dereference the result.

This is the same class of vulnerability that was fixed in renesas_usb3
by commit ee0d382feb44 (CVE-2026-31615).

Add a bounds check against CDNS3_ENDPOINTS_MAX_COUNT in both functions.

Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Cc: stable@vger.kernel.org
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/cdns3/cdns3-ep0.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/cdns3/cdns3-ep0.c b/drivers/usb/cdns3/cdns3-ep0.c
index e29989d57..76642eaaf 100644
--- a/drivers/usb/cdns3/cdns3-ep0.c
+++ b/drivers/usb/cdns3/cdns3-ep0.c
@@ -251,6 +251,8 @@ static int cdns3_req_ep0_get_status(struct cdns3_device *priv_dev,
 		return cdns3_ep0_delegate_req(priv_dev, ctrl);
 	case USB_RECIP_ENDPOINT:
 		index = cdns3_ep_addr_to_index(le16_to_cpu(ctrl->wIndex));
+		if (index >= CDNS3_ENDPOINTS_MAX_COUNT)
+			return -EINVAL;
 		priv_ep = priv_dev->eps[index];
 
 		/* check if endpoint is stalled or stall is pending */
@@ -368,6 +370,8 @@ static int cdns3_ep0_feature_handle_endpoint(struct cdns3_device *priv_dev,
 		return 0;
 
 	index = cdns3_ep_addr_to_index(le16_to_cpu(ctrl->wIndex));
+	if (index >= CDNS3_ENDPOINTS_MAX_COUNT)
+		return -EINVAL;
 	priv_ep = priv_dev->eps[index];
 
 	cdns3_select_ep(priv_dev, le16_to_cpu(ctrl->wIndex));
-- 
2.50.1

