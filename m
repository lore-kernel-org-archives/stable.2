Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AAA3890E0
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 16:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044999; cv=none; b=VIJ51WfGMM1J0UrQOw23Ztv3ufbjO+HuqM/cpjfWEsmc5AJnNXGuJ425A3nPJJFDheR95v1AaecP19jK/kqd/og96n0TyTaWgOfuxqx7nIMsYTF2V4phizhaSJW1vrJUclrMhrdp0t1rcudSCqo+C3JWrvK0rt2l/UcFaMJ5dRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044999; c=relaxed/simple;
	bh=pl43eLdtLTOWabdWe15SfHykiW/0YdsfBLg6nxcmOik=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=MkkAnChzscgTaqV9fuuQwcBcsDFXumO70llfUCWgF8KImhm36E2Q38oUbHsKr0DpydgYVElOQWi3PUeKndBtwz+X8VinmdKOtoilAS44FMvDrAA34kERGIYu3lvBGWLIlmxXZgg7l491FUEeL25vj7JE7iXL5t3FjtfX4Ips4aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NjtS0MuC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NjtS0MuC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE721F000E9;
	Tue, 14 Jul 2026 16:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784044998;
	bh=0rvcIAKKftIzkSst2LNG2RqfI4cKZ/Gi4r+SJ0OYbOU=;
	h=Subject:To:Cc:From:Date;
	b=NjtS0MuC7eNqQvco3u0l959Zm30PKUTzuUyZ7XGrhuZxmxoi0ZSr/lwh0goSbbcyL
	 o63OsgoVuOuBXUDS/5KHyqNaddRq5yVD+B96dl85etREZnmEBaJkNI21C5Wc8bjLEN
	 u7dR+XfvZTH6ECa4asds3P3yjW/CVH38TS6R34gM=
Subject: FAILED: patch "[PATCH] usb: gadget: f_printer: take kref only for successful open" failed to apply to 6.1-stable tree
To: raoxu@uniontech.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 14 Jul 2026 18:03:12 +0200
Message-ID: <2026071412-chop-overreach-6861@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 30adce93d5c4a5a1ec29d9249e3fdfcc391d406b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071412-chop-overreach-6861@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 30adce93d5c4a5a1ec29d9249e3fdfcc391d406b Mon Sep 17 00:00:00 2001
From: Xu Rao <raoxu@uniontech.com>
Date: Fri, 26 Jun 2026 14:46:17 +0800
Subject: [PATCH] usb: gadget: f_printer: take kref only for successful open

printer_open() returns -EBUSY when the character device is already
open, but it increments dev->kref regardless of the return value. VFS
does not call ->release() for a failed open, so every rejected second
open permanently leaks one reference.

Move kref_get() into the successful-open branch.

Fixes: e8d5f92b8d30 ("usb: gadget: function: printer: fix use-after-free in __lock_acquire")
Cc: stable <stable@kernel.org>
Signed-off-by: Xu Rao <raoxu@uniontech.com>
Link: https://patch.msgid.link/80295742B820DA9B+20260626064617.4090626-1-raoxu@uniontech.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index e4f7828ae75d..837f753d0cae 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -363,12 +363,11 @@ printer_open(struct inode *inode, struct file *fd)
 		ret = 0;
 		/* Change the printer status to show that it's on-line. */
 		dev->printer_status |= PRINTER_SELECTED;
+		kref_get(&dev->kref);
 	}
 
 	spin_unlock_irqrestore(&dev->lock, flags);
 
-	kref_get(&dev->kref);
-
 	return ret;
 }
 

