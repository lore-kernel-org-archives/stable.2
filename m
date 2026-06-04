Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970991474CC
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570083; cv=none; b=qRjIhtn3wMWp+s+q+Nq3ejz8xxeQHrmZrhKE3UVXvIZrLd8qZULxNRr/fhEeQxm7pYERrciS117w62s0P0DQjOAF9p3esDOO5Et6x2kFADK3KMqj3MrBkG2D0WYDDbxuGVZ8tW0xqy+pBPXSZ+Ku6NVSvtS3iV7tGvnHHwBev/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570083; c=relaxed/simple;
	bh=+0JW/LmFbtR+NuXX7A898WMkvRsHmz1rfDHGIk1skng=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UL6H+3JQpal4M70QJpsYbrbsp5kWcqFo5Gx+dDXnd0VmsRt3Hq1CMN53tkMK0iZX8S4riXWChwSkLJjO+joVcCnJJ4ZSZRY1ZwVmttFs3ztJ3FaSwt/yNCaaBhNk1IIs9sRkUeHUPZ+MCzK5hiciZSzNRKrs+dS8njwQFN/q+48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UioDdD26; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UioDdD26"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D48FF1F00893;
	Thu,  4 Jun 2026 10:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780570082;
	bh=PCAurPLDSYgBh/fLDl4oI45H/HhNi+DuYuNQQu+RgU4=;
	h=Subject:To:Cc:From:Date;
	b=UioDdD263bA1natunQMHUZP/aCQDOzJm251bPiJL4i9z9x1Rgudx4z1++BsWO8E6s
	 1JBnaZrcihDrmGALoy3uc4cbMipAs0FfeZwiMY4FlAu6pt7m37koUoPyDu3nS9EJwe
	 xw8/8EubkearFNdbXOh/inD+S5Ho+LhFqt/FewYI=
Subject: FAILED: patch "[PATCH] usb: gadget: f_hid: fix device reference leak in hidg_alloc()" failed to apply to 5.10-stable tree
To: lgs201920130244@gmail.com,gregkh@linuxfoundation.org,johan@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:46:54 +0200
Message-ID: <2026060453-blazer-sublet-0c66@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 4f88d65def6f3c90121601b4f62a4c967f3063a6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060453-blazer-sublet-0c66@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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

