Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358CE3AAF4D;
	Sun,  9 Aug 2026 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786264204; cv=none; b=NQWGVNaKa6gKGu1Wo24C1V9yXV5bWFd8ZKA3EsfIfModcNNtQoHUXzxT7qEySBSQKCs/h5UFBlAhkzzKsUwDX+N0KobmHsSd6aePStYYI+YrrRtl9uCOgPQE0CLpHphGB/IEYMRH3o+JykwL3HJB1gM+c84Ii7T/8rDvdV9+tVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786264204; c=relaxed/simple;
	bh=Hq4dm8oGSphT2VpNbT//Mlf0/8NlWQ2KNxf+P7n1GNE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mT8z7CRTSU7xi8QZoBL2trfL6WfylfePNKOLb2/jP32kVMhmyYU5zCaQ25RfqYlUgjpHM3eyC8GyU3Lw8P1k7UBffj62vDEE9qluWgG0QiLv+FqcPY98ihz8ulZYG3BZYNUUXL31dwD8RupTeQa/YA+l9kUmgbdXsidbt+Zq4Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=dKtXMfRv; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="dKtXMfRv"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 494c176e5;
	Sun, 9 Aug 2026 16:29:55 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: dpenkler@gmail.com
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: [PATCH] gpib: ni_usb: unlock transfer mutexes before free
Date: Sun,  9 Aug 2026 16:29:38 +0800
Message-Id: <20260809082938.3589141-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fe5a492f703a1kunmc0ef65477a8d3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTxkYVkJPSUpNHR9CSUsfHlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=dKtXMfRv5XuOW1kvtVDu6MsBnIc2Yb3bBPEOCPpJTVMslqWtOvC9Q67R1/0kwaAsbHZhSPZKXUg0gonhU9WUGGIQlSBGJn+lVBttLrxsMW6GYcj2MXFKuONv3yrYhjh3ZAZnrwUCZXJXV1YanMBqznpitCIJjL4UKllLHbikPmk=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=yZLwOwxOkBrozACtFQn0gk478lx6sIa668gfj/PFUnE=;
	h=date:mime-version:subject:message-id:from;

ni_usb_detach() takes the bulk, control, and interrupt transfer mutexes
before cleaning up the URBs. It then frees ni_priv without releasing them.
Since the mutexes are embedded in ni_priv, freeing the object while they
are held triggers lockdep's "held lock freed!" warning and leaves lockdep's
held-lock state referencing freed memory.

Release the mutexes in reverse acquisition order before freeing ni_priv.
Keep the existing acquisition order and URB cleanup ordering unchanged.

This issue was identified by static analysis and manually confirmed by
tracing the detach path in v7.1.5 and current mainline. A source-level
lifetime check verified that all three transfer mutexes are released before
the private object is freed after this change. The existing GPIB core
detach/lifetime synchronization is not changed by this patch.

Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB driver")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/gpib/ni_usb/ni_usb_gpib.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpib/ni_usb/ni_usb_gpib.c b/drivers/gpib/ni_usb/ni_usb_gpib.c
index 28de1d543ad6..5368076c35e3 100644
--- a/drivers/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/gpib/ni_usb/ni_usb_gpib.c
@@ -2377,6 +2377,9 @@ static void ni_usb_detach(struct gpib_board *board)
 		mutex_lock(&ni_priv->control_transfer_lock);
 		mutex_lock(&ni_priv->interrupt_transfer_lock);
 		ni_usb_cleanup_urbs(ni_priv);
+		mutex_unlock(&ni_priv->interrupt_transfer_lock);
+		mutex_unlock(&ni_priv->control_transfer_lock);
+		mutex_unlock(&ni_priv->bulk_transfer_lock);
 		ni_usb_free_private(ni_priv);
 	}
 	mutex_unlock(&ni_usb_hotplug_lock);
-- 
2.34.1
