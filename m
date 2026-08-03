Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB1E3C063F;
	Mon,  3 Aug 2026 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748401; cv=none; b=UV10A/I8nhxosF/75ChFzKavT/2kNV+HKAZ/saZf6ZxdviI8shwTpfag5O6Oof6vgFX3A16+BSfCQXSFs5GtrneVEY7UN1RqKLOjX2qLfH2VkECkm9o2k84I0Uotj0GQ4/RmznEcRFz9SRGaGKHaCr1EecW/XuRavPCaUj3YmzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748401; c=relaxed/simple;
	bh=f2yd3L/pZHye4maJGKlhelS8yD0Euk9e+/q+UEv6M1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bgj5FJuOSkBrugvg2gkpDre8bXCsb4joEmK8HYJEjAS4NZHJmqfEKesW696eQenN8FZafp88CLAaj7cZVWQkPckBWG8PotoltJXBhRvqHzQmMNIyDoO+vXl4JVFyA1J6X3v/F8V5Ysf08McJ7gNAMwkqJ09zcjgeEFsTFKh7SLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=mDdklVje; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="mDdklVje"
Received: from mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net [IPv6:2a02:6b8:c11:2281:0:640:870e:0])
	by forward103b.mail.yandex.net (postfix) with ESMTPS id 53FC1C009E;
	Mon, 03 Aug 2026 12:13:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net (smtp) with ESMTPSA id 1Dfnu4md9a60-HZ5ya4WP;
	Mon, 03 Aug 2026 12:13:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1785748382; bh=ooDqqQeTj1ixxIS+VW69uRjljBAoaoYzB0zEO6r51Y4=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=mDdklVjeTdzPyKGfGuuwtMe3LszcJtAJ+gNPj4MT/3fc+h6xe6hJ4iwABSI3uQzlL
	 IqjKW4g10hgj8bTJcBPJdrzuVOQqdXlmmPfZhjS7Bywu9irkAVwJK71kEmlQL1s+4n
	 KKUgd46KxRMWCNwopYEAZYANB2HcebSMzwt9AfP8=
Authentication-Results: mail-nwsmtp-smtp-production-main-89.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>,
	linux-usb@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+6aa97991da41499aa852@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: fix device data management error in gadgetfs_bind()
Date: Mon,  3 Aug 2026 12:12:58 +0300
Message-ID: <20260803091258.85969-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In 'gadgetfs_bind()', 'get_dev()' on appropriate 'struct dev_data'
instance should be performed immediately after the pointer is stored.
Otherwise an attempt to handle -ENOMEM later will issue an unbalanced
'put_dev()' in 'gadgetfs_unbind()', thus leading to UAF errors.

Reported-by: syzbot+6aa97991da41499aa852@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6aa97991da41499aa852
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 drivers/usb/gadget/legacy/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index d87a8ab51510..a86a1c68903e 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1681,6 +1681,7 @@ static int gadgetfs_bind(struct usb_gadget *gadget,
 	set_gadget_data (gadget, dev);
 	dev->gadget = gadget;
 	gadget->ep0->driver_data = dev;
+	get_dev(dev);
 
 	/* preallocate control response and buffer */
 	dev->req = usb_ep_alloc_request (gadget->ep0, GFP_KERNEL);
@@ -1696,7 +1697,6 @@ static int gadgetfs_bind(struct usb_gadget *gadget,
 	spin_lock_irq(&dev->lock);
 	dev->state = STATE_DEV_UNCONNECTED;
 	spin_unlock_irq(&dev->lock);
-	get_dev (dev);
 	return 0;
 
 enomem:
-- 
2.55.0

