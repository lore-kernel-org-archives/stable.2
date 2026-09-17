Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A8B4CC261;
	Thu, 17 Sep 2026 12:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648314; cv=none; b=oFOr1RG5NY3eENw5hAZojHrANIFNAMCBj17UOiZw5XbOGqSzsjjUMg31pMyxwoESOStaVtQ+fdn89JhNY0YpzyiegnUXxo5K+LCBXL9IFgmscvvQ3298ohmuwlIw2/A4XbUJuykdTvoyAtD2o2U3jKf1rwAiQCl3RC0Zj85/5JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648314; c=relaxed/simple;
	bh=Z5iZs8Pmj7lrUrQ6Qx7AwYNRB05di3seUz+6zm3qvp8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PH2UIFQxCvYFVYo5Bo7P69Qr7aQLp7P5JnBdbWRpw/viKd2ZyJeZ4KvggqYCzziYeAdQjsRyJHOM6f6XQ52PmLNzvslXBoErq/35z4AAdrCex41AWWWuREb2kb1zlQV5Hz1Ru6SxOtjhPnggrN5lD5b09hmzgJGG7R92wLiXvZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=Mv+sxfUf; arc=none smtp.client-ip=115.124.28.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="Mv+sxfUf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789648297; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=P5lw9hhVO/HWDptR38l1sHYaWyT1zdds3SbCv75Wjq4=;
	b=Mv+sxfUfNN2GgBiyfYZUU8isKaq1Kn3pzY1sWcqSz+G84unNDI7yx2oy0hqjLGcOuY5YegL79KSky8eB5XEzz7gmB2lCK7ScZkz3HhO/TP2dzhwUWfOCuiUmBMgRfd5oEqJLLJZWrImiNLxRjDalHHaVQHGYzdVo2E+bqrCRxFk=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07765399|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0194029-0.00114363-0.979454;FP=12020485485498140115|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037028158;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jFyaSJF_1789648295;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jFyaSJF_1789648295 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 20:31:36 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	liuwb@xiaopeng.com,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH] usb: gadget: fsl_udc: validate pipe index in ch9getstatus()
Date: Thu, 17 Sep 2026 20:31:33 +0800
Message-ID: <20260917123133.3760392-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ch9getstatus() uses get_pipe_by_windex() to compute a pipe index from
the host-supplied wIndex field and then passes it to get_ep_by_pipe()
to index the udc->eps[] array.  get_pipe_by_windex() can return up to
31, but udc->eps[] is allocated with udc->max_ep entries (typically
8-16 depending on the hardware).

The SET/CLEAR_FEATURE handler in the same function already checks
'pipe >= udc->max_ep' (line 1431) before indexing, but the GET_STATUS
path omits this check, allowing an out-of-bounds access.

Add the same pipe >= max_ep guard to the GET_STATUS endpoint path,
matching the existing check in the feature handler.

Fixes: b504882df105 ("USB: add Freescale high-speed USB SOC device controller driver")
Cc: stable@vger.kernel.org
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/gadget/udc/fsl_udc_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index 20392409a..ed70cc650 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -1344,8 +1344,12 @@ static void ch9getstatus(struct fsl_udc *udc, u8 request_type, u16 value,
 	} else if ((request_type & USB_RECIP_MASK) == USB_RECIP_ENDPOINT) {
 		/* Get endpoint status */
 		struct fsl_ep *target_ep;
+		int pipe = get_pipe_by_windex(index);
 
-		target_ep = get_ep_by_pipe(udc, get_pipe_by_windex(index));
+		if (pipe >= udc->max_ep)
+			goto stall;
+
+		target_ep = get_ep_by_pipe(udc, pipe);
 
 		/* stall if endpoint doesn't exist */
 		if (!target_ep->ep.desc)
-- 
2.50.1

