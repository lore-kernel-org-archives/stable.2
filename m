Received: from out28-122.mail.aliyun.com (out28-122.mail.aliyun.com [115.124.28.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE0F3B0584;
	Thu, 17 Sep 2026 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633155; cv=none; b=jTzdZuqKrSUOyp1xF5K2apVcRxEwbQfXunTAsmbhmlAqfhO4rw2g0nD3/CKgu8C71grqqDlQhi3jsTYn/2gwjU0dCAaZ8V60MnDvlZM3B02zoF8uudQKCCcIAMRFQTzavR1IY3UmmiRLmHAsrSLr2oOEZ4kZFJ2nHW9tQEiLClY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633155; c=relaxed/simple;
	bh=EVSX76OzB+diEYCs/nJX3q5v7Kwcdgu4DpKF5WvGx7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AiEvkmIwpPw+vnHIBHESzZlTas7A71AdVoMtKqLxHj6cfYSyJhhvYxcAGuiPVVB0Qca2XaWMSstAgRkC5sqQjLpTlfxI+5H7jcE29t6/heMPPtUAOGzArzE3mxLtklJtdtfQ2FZNq21um8Cgjaahr6Y9xehqcwCFMZTGexLdFKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=OXyeW1Xh; arc=none smtp.client-ip=115.124.28.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="OXyeW1Xh"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789633142; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=nOivH+tpyHEQbs/5d8ymLlzakpf9GHeFHzNCZfiL+A0=;
	b=OXyeW1Xh5dTLcLUJ5kCNrBgKyB3rUGCSpyt2cZGyW3tYo50rXKmFcp72Lq0Dq/n+O/JvfdsS2oKpPHhopAqWs3BYwt9PYllBXEPbgepPAI7xw4L3elhLwgQQMYbRo6Fwvj5ex5G0cYIJ34ih77SUg+axtTW0+y8RmSiA12qRgZY=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.3915794|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0144512-0.00147129-0.984078;FP=674923788358001744|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045220102;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.jFl7ePB_1789633140;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jFl7ePB_1789633140 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 16:19:01 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: justinpopo6@gmail.com,
	alcooperx@gmail.com,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	liuwb@xiaopeng.com,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH] usb: gadget: bdc: validate endpoint index in ep0 handlers
Date: Thu, 17 Sep 2026 16:18:58 +0800
Message-ID: <20260917081859.190561-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ep0_handle_status() and ep0_handle_feature() derive an endpoint index
from the host-supplied wIndex field:

    epnum = wIndex & USB_ENDPOINT_NUMBER_MASK;  /* 0 .. 15 */
    epnum = epnum * 2 + 1;                      /* up to 31 */
    ep = bdc->bdc_ep_array[epnum];

bdc_ep_array[] is allocated with bdc->num_eps entries (typically 10-16
depending on the hardware).  A malicious USB host can set wIndex to a
value that produces an epnum beyond num_eps, causing an out-of-bounds
read of a stale or uninitialized pointer, followed by a dereference.

Add a bounds check before the array access in both functions, matching
the same pattern already used in bdc_sr_xsf() since commit a402532ab855
("usb: gadget: bdc: validate status-report endpoint indices").

Fixes: efed421a94e6 ("usb: gadget: Add Broadcom BDC UDC driver")
Cc: stable@vger.kernel.org
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/gadget/udc/bdc/bdc_ep.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.c b/drivers/usb/gadget/udc/bdc/bdc_ep.c
index a7a22e5ec..e5c203b9a 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_ep.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.c
@@ -1286,6 +1286,10 @@ static int ep0_handle_feature(struct bdc *bdc,
 			return 0;
 		}
 		dev_dbg(bdc->dev, "epnum=%d\n", epnum);
+		if (epnum >= bdc->num_eps) {
+			dev_err(bdc->dev, "Invalid ep index %d\n", epnum);
+			return -EINVAL;
+		}
 		ep = bdc->bdc_ep_array[epnum];
 		if (!ep)
 			return -EINVAL;
@@ -1352,6 +1356,10 @@ static int ep0_handle_status(struct bdc *bdc,
 			epnum = 1; /* EP0 */
 		}
 
+		if (epnum >= bdc->num_eps) {
+			dev_err(bdc->dev, "Invalid ep index %d\n", epnum);
+			return -EINVAL;
+		}
 		ep = bdc->bdc_ep_array[epnum];
 		if (!ep) {
 			dev_err(bdc->dev, "ISSUE, GET_STATUS for invalid EP ?");
-- 
2.50.1

