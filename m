Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB03D3F58CA
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787654768; cv=none; b=drmS0NQb1mqHmmg5y2SOP/pAJfmxtKFvtQyOzTj3NMqLH/WhKId8lFtIDZ3cWtOZX/bzjWrU3EtYUwNzvyAzBI6JDmlijHpIWw4dNWWLG4PFxx6mZ+JmXjzmTLQDBuhc6jG2IuSgW4+ZXinVj1qjkMSV0h+CtqT4gNhXQgyzgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787654768; c=relaxed/simple;
	bh=FPYe1crnsYHtn0U7WPNaYM9b5z0ifdW88rHUuc4KNhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NN9GaBUpBj09zuyij8Q1682ayU9dk0BNzak1SI8D2qmrvnzGbC80aJSBAvL4QxiWtSIzWMym8bdM9uZBmijukGncsSNLvqIv1JslfdlMMKxz0UATUG9R1JqNDP31QXBJk7eRWl9//+YRP7dXt/sE5g4sC6Y8CJUycCBABhuzTwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuUwDybL; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuUwDybL"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d530328efbso39532135ad.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787654766; x=1788259566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ac16pfv2Rj18iPUVLOrADWTqxfqfViLMohr3+8pP5Us=;
        b=PuUwDybLEjuh5FNODCn48CdyAFNEix2EFjWpfm4XZvNQawtOYGOHszdX8/Sb8Pu1wQ
         jD+3FSjXeTb5q39ffyloFP2ppAy0jQa7rU1FkH1PgpwUN5x8asG8TBtp2r9rYd8+VbWf
         Mt3q0HCR2IBDu3r7uu7fnjZRl2S9GKTDSiaQ6s+bLCS39QSEoFm96HJqjVoDNdJjDCtl
         4Y7RFgsJ4MTNQqefHbSRfdaCudX1cZI38FBvQ+fLdarzns4cCfsPECFu93bG4Yo4C9t3
         WXwRBHIgvYFlrZw0TAquDb/7qqT2zlV+rf0XJKA9GxYdZm50EdiQzd1GcxygO4H3Ydhp
         B3Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787654766; x=1788259566;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ac16pfv2Rj18iPUVLOrADWTqxfqfViLMohr3+8pP5Us=;
        b=kPSHszle624lDW4huR4wrI4BO2uWNwcOClSlUyikpAintODfPdF+lBeGp4Kbvo/gZX
         0GoP19RvbMJNnAgfiIvtD+k7NlFDiPAuteuXmgX3klMxhBnbRpemqN5H9SmnpYUDohTX
         ZWjjRoStub5qbrFZfn7PJZNswYJ6ftsxJFJDQ9QIngXUC2o9M0RxrciuaBHefm1syeEx
         nW8XxwB8S0rYHAUTuzneEF0EDCdMLsIDffxZiBomTHSDeSYHBLVjzX6hpsCU3rvkFtvg
         K1L7R6LrTtpN64RG+jaXxJayGDm1VuSH335B9P0qT+yVmH3rczykm5aRC5jlWuobR3vf
         pigw==
X-Forwarded-Encrypted: i=1; AHgh+RoAIDRNGoLO+6b5n5c313bg9QnwfbwikALkttLqirJ/01GykTkA0gvJYvMQw5Vw+tKwxQTzZrQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mmQjWQmcdm7VXr/556QHOy+aENqfRzufzc37yNeas1WvJvvLDl
	KYx0D8aar5aM6CFDgwp6jnUDWuTqzF48nN8j165/dAvOEDUM0cDzofGs
X-Gm-Gg: AR+sD101wuGC3bnIatPBQg0S9/ytVk1erlIa9zy9YbqJjMio2bGdgDGIU8+VL3nMFRq
	jTJI+p6dfE/soUbylMopn4DkWCEUAtc1EaivJek4LZ0E1JvWTyCK2AKea4IXtvBiIM3lk2+6fur
	MxGAlitI1sI8yC77uqNdn6qPdm/DjSSNUqoQ0DGRgQ3mHhjHcVP90qUSBUOrttBy9aJMlHqGdNm
	1cB5v+jFu6SypZ2NqsOCCGsGhwQFJjwobjINhQZnr9TsW8rH+nV3Nrzocn/6WKg0qoit6HUBIok
	CmaR2da560VWGwjR8B2ULm0OfW13Yzsl7+C1NoZggk8uAndjgX4j9JI9WIMNpOIBZi67oJiUvvX
	U+10W0CPJ8Mu/KyN4ynd193TPhqFGtqi/YPGAD9BMzT3uRNCFyMyDHO/aRqyuiIz7689rfPUuZ/
	Ea0YEfXjenYx30DfbdS1tYYWqJHzTdWWs9hmjCp1q8ppu2NeZnssh8Oo8DV8eSaN7m5c/+8OJEL
	eyHZ58bR9QdO6IJ5H2X5fLC7yYWDurivQ==
X-Received: by 2002:a17:902:ec87:b0:2cf:8131:75e8 with SMTP id d9443c01a7336-2d64b11893amr525939445ad.13.1787654765892;
        Tue, 25 Aug 2026 03:46:05 -0700 (PDT)
Received: from localhost ([2409:40c4:101c:e5a9:a28f:e499:1b07:43b3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f90cb8e3sm51146610eec.12.2026.08.25.03.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:46:05 -0700 (PDT)
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: jjy600901@snu.ac.kr
Cc: brauner@kernel.org,
	eulgyukim@snu.ac.kr,
	gregkh@linuxfoundation.org,
	jack@suse.cz,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	stern@rowland.harvard.edu,
	viro@zeniv.linux.org.uk,
	Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] USB: gadget: fix NULL pointer dereference in gadget_dev_ioctl()
Date: Tue, 25 Aug 2026 16:16:01 +0530
Message-ID: <20260825104601.315401-1-lovekeshsolanki00@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824160022.2378192-1-jjy600901@snu.ac.kr>
References: <20260824160022.2378192-1-jjy600901@snu.ac.kr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gadget_dev_ioctl() reads dev->gadget outside the dev->lock, while
gadgetfs_bind() writes it without holding the lock. A concurrent
bind can update dev->gadget and dev->state under the lock while the
ioctl thread holds a stale NULL copy, causing a NULL pointer
dereference at offset 0x28 (gadget->ops->ioctl).

Read dev->gadget inside the locked region, before the state check,
so the state and gadget pointer are always consistent.

Cc: stable@vger.kernel.org
Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Link: https://lore.kernel.org/all/20260824160022.2378192-1-jjy600901@snu.ac.kr/
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Link: https://lore.kernel.org/all/20260824160022.2378192-1-jjy600901@snu.ac.kr/
Signed-off-by: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
---
 drivers/usb/gadget/legacy/inode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index d87a8ab51510..e9f7d7c1a6a3 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1251,14 +1251,15 @@ ep0_poll (struct file *fd, poll_table *wait)
 static long gadget_dev_ioctl (struct file *fd, unsigned code, unsigned long value)
 {
 	struct dev_data		*dev = fd->private_data;
-	struct usb_gadget	*gadget = dev->gadget;
+	struct usb_gadget	*gadget;
 	long ret = -ENOTTY;
 
 	spin_lock_irq(&dev->lock);
+	gadget = dev->gadget;
 	if (dev->state == STATE_DEV_OPENED ||
 			dev->state == STATE_DEV_UNBOUND) {
 		/* Not bound to a UDC */
-	} else if (gadget->ops->ioctl) {
+	} else if (gadget && gadget->ops->ioctl) {
 		++dev->udc_usage;
 		spin_unlock_irq(&dev->lock);
 
-- 
2.55.0

