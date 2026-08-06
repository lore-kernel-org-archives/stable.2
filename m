Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768BF423E99;
	Thu,  6 Aug 2026 08:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786006200; cv=none; b=RnIS0EnHVABetRR67nf1LTM2vX30vSAb64dW+ab2xvBWbWmTcD9VEZVLl1StbkGC/psfnCY6MlD1eK05n8MbDcXunC++DnAUZqMa0MkBH4wFNXcOlTMn25XLrxebYa+xRg4F0R0qurlt5YXTt2g0csPI6p7jt7+teTDRTFqR8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786006200; c=relaxed/simple;
	bh=aZroyt9K0iuG8zVuxckOiH3jEZBLfNmurCBEyRHSmT4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNxMkZ/UJplF4aeDzIm7cAtLU26661cFxvi5fo16fcAZ7t5DeQFMB5mJLxmKpE4Nd6t0wZ9rlHl5auXF/E+NLWlIQBFsLTHfzTHWFy3lOxqhFMQaaU9ynQzcTVy7oQwqX8h+lXbvR4G34/JV8CCJvf+PJ0RLMUSmHLXxa4vEtBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=F10jUFN0; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="F10jUFN0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786006172;
	bh=wjPmTnSArAPqCoUtaY9wMsdppF2oEATIChgQ90sT7xU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=F10jUFN0pyhhBhPmRIBhE4mgE9Hy4K3uIRHIzVx55DrlvPVSrvx7aexqfaVP1VxyH
	 9h5/KO08MC8H4dddwqqpuwQzWTjIJ+ZdI7tnPSufPfdfXYA0/j2cMrp3onbpG1GVHr
	 8N1IzRx8BNVphSj7uCcXWv8IDqYou3x2LO04PVsg=
X-QQ-mid: esmtpsz18t1786006156t841e7935
X-QQ-Originating-IP: dVuuawglrlJ5/dbW5ikVyiSPd51urYURz5h7S9TZhFs=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 06 Aug 2026 16:49:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 11157330722287486695
EX-QQ-RecipientCnt: 6
From: raoxu <raoxu@uniontech.com>
To: mathias.nyman@intel.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] usb: xhci: disable the correct slot on alloc_dev failure
Date: Thu,  6 Aug 2026 16:49:09 +0800
Message-ID: <6C94F1F35FF16E76+20260806084909.2959131-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NYG9n5uPxz1WZy1JF5j+GS9/KGS0qhT7YPi1DFhOOFEx0ek13FqKgYmn
	GP04WTMu7xqm5FgYDv+OzOMBBmne+LpKKLqdLaw9n0lc+FXUdqZ+NWv2QgcqhYOxajDj4WU
	0i91lYvDESfpyrU4CpIIr8VO2M28SCE4CmPSrhi5RwTFCZYiw/ziAbBzrcQtqS2AsdSJyql
	PWD2hzzO0b5sdmk/nxnBlxJPAJp5y1EpHUa1/AXBFswx5uIPzxHbH2jBDdL33aL8x32gi3Y
	3xwYfLL8sFsKZ+ktR+DF6MB5D425cWZVxLK4+UK4+FtCEblV+GvWgE5mLRvYdtL6xD8hbZz
	eheg2yBTMwOZSdLrHFMjdp+1BxmniSgmmkKvRrZMxdB2IgHxGuvWMvG6Wee487e6Evsi7oL
	ZveBM5nYoKO9Y794alRbakrWNcjNY+Ceg9CLa34sk3f6Hofl2sJpyGDtcfMrZzvX2dgBHj1
	8w7NOTZhGxEkW5CgvobhqupGPXPsP37/in9E0acC839CkS6e+o1uCn83Mk0L0LmDRXrI0tM
	Nj/3LFwC6KLd06C9qpf6AgbanpkAYbQ8dZDSbNfOHIFIsv9XvMxRNPT92s7oD3CTo8VrstS
	nvzWfehOIQjW4eP5p5ig4RM6XdN7uSuZy5L2kwn3li6idKkf6uSTOc2wYJ+f5+B4W1M8xwb
	mjB8Puh5QNTip3RsjcfsTkelXNnm8TPqAYFHQbVLMktMK3ypDwCdW8/oXpqGt/t1NzjDJEW
	pJQ8enSwFejKwxzHH+S8XevmWZWM0hgA621cvjmO+dTY95Jnpy0A/+dqDpAdV3HcEjw5bb9
	vEgTgYEVZiPt3KpWRxBlk/dWThAO1dbU2FMMrW/eX19qnAnRdLXX812v8Cif5zAZixy1tBC
	DqwZGWg/AVqKhFZ/nQde0Il8P0eFevmfDA/P5m/p/aetKxaA06oDMyXVlmCvLm4thAAdEL8
	Y1q4Y57mUWyk0YPu+LLLMlknWA6OwWruKh1IgaYGdEUE+jZLsKIPitDH/ewwbYpd5/QkzvZ
	P3KtjlZxIL/9d60NXFgFFZSQeSHmf4YQv8dZha1aYRMyXGYIY7uAt6SfRr4FSlKMyTiebDY
	nAzStU/A6LS4cxGJ/vpEWw=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

xhci_alloc_dev() stores the Slot ID returned by the Enable Slot command
in the local slot_id variable.  udev->slot_id is updated only after
xhci_alloc_virt_device() succeeds.

If endpoint resource reservation or virtual device allocation fails
before that update, the error path passes udev->slot_id to
xhci_disable_and_free_slot().  During initial enumeration this is slot 0.
When reallocating a device whose virtual device is missing or belongs to
another usb_device, udev->slot_id may contain a stale Slot ID.
The newly enabled slot can therefore remain active, or the wrong slot can
be disabled.

Pass slot_id, which identifies the slot enabled by this invocation.
xhci_disable_and_free_slot() already handles a missing xhci->devs entry.

Fixes: 3ffbba9511b4 ("USB: xhci: Allocate and address USB devices")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/usb/host/xhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 091c82ca8ee2..dd8c12380e0c 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4298,7 +4298,7 @@ int xhci_alloc_dev(struct usb_hcd *hcd, struct usb_device *udev)
 	return 1;

 disable_slot:
-	xhci_disable_and_free_slot(xhci, udev->slot_id);
+	xhci_disable_and_free_slot(xhci, slot_id);

 	return 0;
 }
--
2.50.1

