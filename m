Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087F443E9C8
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687041; cv=none; b=at4ycNYqgHpHnNMwPwvt+cSGt0Uxj1LlLHv6XoM4KcTqCtk9qA0rnF1JQP7nUyBsoSyj0fsa40Vl2LIzpLdy/lpFG4dV1nlmHz1IhY3EKNz6YprAPXYjKJ2MMORArsqvdW821/V8Yimu8u5ixqVrAJxF2gwDDcI1Xz4GhOPre+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687041; c=relaxed/simple;
	bh=C66hMKYXJN6Wt9g/lP8A/PepHy+sIK7qSfN7hPPZFEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgN9jZLNq40w4IgrmXRdVKZQHBA+WA5WhnB7r3mycFeErBAumAgEX74s/fCvGhc9jz6rLjEiM1F9Lcn6fHPKHqIxKh49MPSTKZ3NQoCBf46OlleaPHRdRZaRcSxS21VK2AivqdFTeEUOJfkGOtRj9zIEJPAkuSmIvjIWvvGP5gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayIUmMus; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayIUmMus"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC13D1F00893;
	Fri,  5 Jun 2026 19:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780687033;
	bh=cBNd6c7Wctbh6iyxyY/rD8ZmOEkt5R4D0epNYidlk+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ayIUmMusOxJVOa4Lzkg5GtVFJ3tmoloUl2NR52Gyc+7SE9T3bYHkle9j68sNNVrdz
	 zppF0Xe74lLUBehZip5Mv7gbbjKlQMo+yIbahlHUiM1SCenEWPrqoqdg06n88sNtUF
	 BXSrtSBGfz//3qrPSxkrpg3OINpBDXlm+ARKG9VaTQ9NYGHY24xQ2TpI5MvtENhBH+
	 4qV66O1yHzM5UiksSsnxnD3Lxl4MSv1WS9Be2vrsApZBAh1jOa9GedeoJISETeL110
	 OYmjLuD7Oil+PAFjpuo8SbSS/IrkfTmQUGVOs3ypMWbfND8+h5HfkBeYwRNMCxf8K9
	 1C3U7ikzKi5GQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Keeping <john@metanate.com>,
	Lee Jones <lee@kernel.org>,
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] usb: gadget: f_hid: tidy error handling in hidg_alloc
Date: Fri,  5 Jun 2026 15:17:10 -0400
Message-ID: <20260605191711.2132578-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060452-vastness-hulk-8040@gregkh>
References: <2026060452-vastness-hulk-8040@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: John Keeping <john@metanate.com>

[ Upstream commit 944fe915d00d3cb1bacb1e77cabfb6dc82e6f8b8 ]

Unify error handling at the end of the function, reducing the risk of
missing something on one of the error paths.

Moving the increment of opts->refcnt later means there is no need to
decrement it on the error path and is safe as this is guarded by
opts->lock which is held for this entire section.

Tested-by: Lee Jones <lee@kernel.org>
Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Reviewed-by: Lee Jones <lee@kernel.org>
Signed-off-by: John Keeping <john@metanate.com>
Link: https://lore.kernel.org/r/20221122123523.3068034-4-john@metanate.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 4f88d65def6f ("usb: gadget: f_hid: fix device reference leak in hidg_alloc()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_hid.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index de00785fa183df..d44eb06d5a0a43 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1265,7 +1265,6 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	opts = container_of(fi, struct f_hid_opts, func_inst);
 
 	mutex_lock(&opts->lock);
-	++opts->refcnt;
 
 	spin_lock_init(&hidg->write_spinlock);
 	spin_lock_init(&hidg->read_spinlock);
@@ -1278,11 +1277,8 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->dev.class = hidg_class;
 	hidg->dev.devt = MKDEV(major, opts->minor);
 	ret = dev_set_name(&hidg->dev, "hidg%d", opts->minor);
-	if (ret) {
-		--opts->refcnt;
-		mutex_unlock(&opts->lock);
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		goto err_unlock;
 
 	hidg->bInterfaceSubClass = opts->subclass;
 	hidg->bInterfaceProtocol = opts->protocol;
@@ -1293,14 +1289,13 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 					    opts->report_desc_length,
 					    GFP_KERNEL);
 		if (!hidg->report_desc) {
-			put_device(&hidg->dev);
-			--opts->refcnt;
-			mutex_unlock(&opts->lock);
-			return ERR_PTR(-ENOMEM);
+			ret = -ENOMEM;
+			goto err_put_device;
 		}
 	}
 	hidg->use_out_ep = !opts->no_out_endpoint;
 
+	++opts->refcnt;
 	mutex_unlock(&opts->lock);
 
 	hidg->func.name    = "hid";
@@ -1315,6 +1310,12 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->qlen	   = 4;
 
 	return &hidg->func;
+
+err_put_device:
+	put_device(&hidg->dev);
+err_unlock:
+	mutex_unlock(&opts->lock);
+	return ERR_PTR(ret);
 }
 
 DECLARE_USB_FUNCTION_INIT(hid, hidg_alloc_inst, hidg_alloc);
-- 
2.53.0

