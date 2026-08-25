Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100E13DD846
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 10:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787655488; cv=none; b=PU0TKEf7P2t6au8TDwWsfT5itStsIvto/ZOeQWWxl1vS0vQyPw2GVe7DfXGnyMwfYVyrM977r7Zw3Lqj/mMeQUbrZShWUJGrL7oGO+yKsBfAc8p4y5GSZ4t/nlj/uvko93vY58PoEe4eXAsBx7cSDCVEfm4eBKhJGmj/P97TLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787655488; c=relaxed/simple;
	bh=FPYe1crnsYHtn0U7WPNaYM9b5z0ifdW88rHUuc4KNhA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1FrH+rvL84UmOex+mwgT1QCmZkxvNSbZdU83ray/fK8qro94hNyKQSREe0JicdLsFK6NJ2vDTDNLiOxghLniqWWYqNtMQJ1q3eiLd3H5fqWhW/eTVs4Qj17f8JPixOpBmpEbTeZiHzcVxxd+jFrGx3G5vN5eNs1bry6FVefbn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7tUavtM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7tUavtM"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-39652a6e963so459948a91.0
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 03:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787655486; x=1788260286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ac16pfv2Rj18iPUVLOrADWTqxfqfViLMohr3+8pP5Us=;
        b=a7tUavtMS4NC1dzrg0HvxlNwLmjBJ0abt5zAmYDoVQqzMsB8fQyR+/JDF5r0zZlS6y
         ESq7RrFXVSTCSuLEMBnM6njhGpNi6gAzlOuDOl1DB1vsBau1/1ZLfvz289cwNmdDH90F
         vVn2+0zQ+tKou7b8BLFnflcIBHOYwOTL+3BfTRWZ7ZhRyEDzfOFKYz4flS12prMJjWiG
         J/VWU3AoIvcU+hd+dIv1izO4YuKqmesxtZNHCedLby9Wo+WRyCDsKJS0QAYOt8jMSh9N
         p48bWGuwgA6Nh6crUkvCxRtfPLS2juRJgXejgc5cwcCyuTMIX7aFjY20pDWW8QPZfrYB
         NQJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787655486; x=1788260286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ac16pfv2Rj18iPUVLOrADWTqxfqfViLMohr3+8pP5Us=;
        b=Gy8t6uTny+0JJR/7zgnZZIEW7b/tFA7nHgE1NlaS5Nw8HalcILMJIK9w8LJCCXIxhB
         8vLaU84e0eHNgNP1p8DUNpLei9vpksIySI7g0EWHtkMIAQgeX7S+f73hi4Fdv1rB2NiK
         uH2PAopuUw6b5hyO9T+pKKTi1l7JlYqIxD7x3EcxNyR2DksEpFNWNB/KYPJySbEW4+w6
         ALB2sZVmTrO+r7/Z5CVniBlZvIMMqcjlOiIBAVha4KKhnpnjraQoRCJ3lvzJ4N4a8fYc
         XyeSUx/EjW83BOuFoY0ZL1PMWZoHU7vp/PZO+1HhKHhK0vzjjhMLoXPQJwqWm/kvckYM
         An1w==
X-Forwarded-Encrypted: i=1; AHgh+Rp+Mps0jSMbjzJjH7SASTBvU44m0zgwMcEbLv/t77ivn0bvyhdlZBwRJ+8ELfC3FAyjZITeH2g=@vger.kernel.org
X-Gm-Message-State: AFuF++mfznPFkTjGHUQQN6bpTkbLZnx7wZgTRxDOANIoiQRJuYviM6vT
	fiwzSC0gXKEXIh3Y42c2IusNCcdukTun9sAstl8F4PzBZPU0zHBdBtsI4rLp0vi2
X-Gm-Gg: AR+sD10pADLH+LotDwuD0TcTDi1BLhPfesNpVsDryGiHjaHhymUBYtiCOZ5TJ0HNLhh
	9NlP8oZaJod8FJJULRAt3yXrNKO5zybVxAW1R/29EJ/6azebtXVRmeLdO2uzBULU4YEMqCmX19m
	+XXmg1noN7jW1rK+iQOdPsZQWMYszejLQXo0XvuKNnkobKCt3Y9g7pte86fY6rroWsLw2yLmMDx
	omP1I+jqKRZFEzEM28XZvIwFasHurCN7zWAw0VAPhukL92EDe3I2NM4S9KRXqPtyuQ54+vWlaT6
	TjQktPggecXY/0+ABieF6hNPYB1lgXSHml0cGz2A8+RnaZ5j6pEuPXHgZjO8UJ67Iqd/AWXH2tD
	t3nLs6sSdIs2GxZxk5t1DpfTMzEhs4TzpOwyXuMUl934XPLIBeeWuNSlYa+ZaQXVVz073eJUEN4
	CQf9rkAo9qydDLaxfkLKChNPx2FM57MyCbt8y5GGaHyv5Eo9yvPaqhFtSLr8eoyDXn1NvS8OBpK
	j2+7KokZsjAPNqdH3+DrL1kjU/awUkizg==
X-Received: by 2002:a17:90b:39a3:b0:36b:de66:92c3 with SMTP id 98e67ed59e1d1-39645a565e4mr7275293a91.10.1787655486061;
        Tue, 25 Aug 2026 03:58:06 -0700 (PDT)
Received: from localhost ([2409:40c4:101c:e5a9:a28f:e499:1b07:43b3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141860fe08csm53644630c88.8.2026.08.25.03.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 03:58:05 -0700 (PDT)
From: Lovekesh Solanki <lovekeshsolanki00@gmail.com>
To: jjy600901@snu.ac.kr
Cc: brauner@kernel.org,
	eulgyukim@snu.ac.kr,
	gregkh@linuxfoundation.org,
	jack@suse.cz,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	mjguzik@gmail.com,
	stern@rowland.harvard.edu,
	viro@zeniv.linux.org.uk,
	Lovekesh Solanki <lovekeshsolanki00@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] USB: gadget: fix NULL pointer dereference in gadget_dev_ioctl()
Date: Tue, 25 Aug 2026 16:28:01 +0530
Message-ID: <20260825105801.319997-1-lovekeshsolanki00@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824113510.1141236-1-jjy600901@snu.ac.kr>
References: <20260824113510.1141236-1-jjy600901@snu.ac.kr>
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

