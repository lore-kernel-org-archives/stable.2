Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA9C4071DA
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688784; cv=none; b=i4WKuXCefFsASrZCdpufKKK1FDp194fVdKC+TYGbfbu9sSDKO5TatJYYSGbFLIK3S7SBOO4ZyVJRaTp1Ym6nt9RjYIl0449XYgha1SDnMbAVxrKT6ByfrhBAk6ABWzT6/Q8hZZ3k/dh463Bna8wx/+0lA0TKEbOpOdMDIqMzbc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688784; c=relaxed/simple;
	bh=juA2EE58bLUhd2WNVJIT12vILU48D7xVyZX5RFyugUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t//bciU7bCzZ20jbrkzc2KWHXf2M8UYkb5poK+CyI2QcBqIAEDCMLBrSgKMtYdVbrMFNeAx+kuNvyh8F5dWkWmva/Acezc044DYwVfu4d0Sj5SIfRHnG1fmgtQs6PG/MMbW5PZhrx/EdbQxgAUAB9LqEtk5m9WjEv4n5m5hDAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oCTHnnAp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oCTHnnAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E2E1F00898;
	Fri,  5 Jun 2026 19:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688783;
	bh=Pz8373CDM6BMKIOuXDtjlsFeeiT5wm9LlLpP3KQW4fE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oCTHnnApQodouvrNX9iHNDovPmOlsUCzLfqkyUUk/wxplv1HT//o8xR7W3m279D62
	 bTX0Kpt/c1yczsoojgbUX69GKcZhX+xHtT6PmgJPCV0YUEeIDfV7JooMETBldl/kXn
	 tsTJeVtInA1WfyPC1aHZjEs7yOmkFbO5mb8Ca7ZD8wg/KazXPWrHERKd/DgLvf8iat
	 lmpZ2X/cA0Y/+wkdHugi05lTPEy3DTGDPUYf2hRbVmjjXhQuEnYhBN94De1ZKkZhMh
	 07Ab/KMnyKc/P4V/jFk+EIJ91dFAqPBa/59WN+zqgdra/McTfaUpPpuM/ubv4fd7Qc
	 +lMKkGuszxq4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable <stable@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] usb: gadget: f_hid: fix device reference leak in hidg_alloc()
Date: Fri,  5 Jun 2026 15:46:20 -0400
Message-ID: <20260605194620.2186017-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605194620.2186017-1-sashal@kernel.org>
References: <2026060453-blazer-sublet-0c66@gregkh>
 <20260605194620.2186017-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 4f88d65def6f3c90121601b4f62a4c967f3063a6 ]

hidg_alloc() initializes hidg->dev with device_initialize() before
calling dev_set_name(). If dev_set_name() fails, the function currently
jumps to err_unlock and returns without calling put_device().

This leaves the device reference unbalanced and prevents hidg_release()
from being called. Calling put_device() here is also safe, since
hidg_release() only frees resources owned by hidg.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Route the dev_set_name() failure path through err_put_device so the
device reference is dropped properly.

Fixes: 89ff3dfac604 ("usb: gadget: f_hid: fix f_hidg lifetime vs cdev")
Cc: stable <stable@kernel.org>
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Johan Hovold johan@kernel.org
Link: https://patch.msgid.link/20260413142119.2977716-1-lgs201920130244@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_hid.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index 7c5916caf61b30..d5ff9f06c68622 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1278,7 +1278,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->dev.devt = MKDEV(major, opts->minor);
 	ret = dev_set_name(&hidg->dev, "hidg%d", opts->minor);
 	if (ret)
-		goto err_unlock;
+		goto err_put_device;
 
 	hidg->bInterfaceSubClass = opts->subclass;
 	hidg->bInterfaceProtocol = opts->protocol;
@@ -1313,7 +1313,6 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 
 err_put_device:
 	put_device(&hidg->dev);
-err_unlock:
 	mutex_unlock(&opts->lock);
 	return ERR_PTR(ret);
 }
-- 
2.53.0

