Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101251474CC
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570080; cv=none; b=Rrxz9SjYgXgi29lRLEguTV8f+jddYEL9NKyDywjjWIqGjMswVEP5t4oD+zNninZ8Rl1GGDfSKhb9WCGZ7kBbL8jDBL7dhK0sZx/6YB6FfgTSUNWeEx7quVQSFP+PsYV1/gt744qnkT7hAcCQeiXS9WoVbD6/bmFxef1JiHP3Pxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570080; c=relaxed/simple;
	bh=cGUa2NrW4o13lTK5PV+RR67Y090uKN/CleGtutXHblY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LOaGGiUi8BcjhI8YVuTeJG0dgtKIb2cIf67vdHIPvNkd2eKUFeZCh8TvCaQmTiVLfvc0fUapcyAF64kxGdJchYsQlelsbGVNKitTvruypqmWu5D7DVfWzX/9NYcij14SHOA956Cjb5TEY3z58jq+b0JiD1gnlIqtAoKmsvD18vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FhAVSa/c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FhAVSa/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D191F00893;
	Thu,  4 Jun 2026 10:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780570079;
	bh=0K0su3/lkCIqJD9lQmZAS7cw0bdzZfqspPJYnLladN4=;
	h=Subject:To:Cc:From:Date;
	b=FhAVSa/c7icVNY98v1JXlH26DG23t16TxF1VJ0s91L/3+t7XDP2kwGMJbX0eg0cl/
	 10E1yRLxPk2ZKHsSSW0nh1eGlcdnjB5QYTuSdMjLSJML48mUHhlOv4YV5Y4fj3P9mT
	 kw2DULvj4G5NfXYPg/7MJMQH5TIe8dNE5mehZ7+g=
Subject: FAILED: patch "[PATCH] usb: gadget: f_hid: fix device reference leak in hidg_alloc()" failed to apply to 5.15-stable tree
To: lgs201920130244@gmail.com,gregkh@linuxfoundation.org,johan@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:46:53 +0200
Message-ID: <2026060453-cape-pavestone-2366@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 4f88d65def6f3c90121601b4f62a4c967f3063a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060453-cape-pavestone-2366@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4f88d65def6f3c90121601b4f62a4c967f3063a6 Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 13 Apr 2026 22:21:19 +0800
Subject: [PATCH] usb: gadget: f_hid: fix device reference leak in hidg_alloc()

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

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index c5a12a6760ea..3c6b43d06a6d 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1622,7 +1622,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->dev.devt = MKDEV(major, opts->minor);
 	ret = dev_set_name(&hidg->dev, "hidg%d", opts->minor);
 	if (ret)
-		goto err_unlock;
+		goto err_put_device;
 
 	hidg->bInterfaceSubClass = opts->subclass;
 	hidg->bInterfaceProtocol = opts->protocol;
@@ -1659,7 +1659,6 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 
 err_put_device:
 	put_device(&hidg->dev);
-err_unlock:
 	mutex_unlock(&opts->lock);
 	return ERR_PTR(ret);
 }

