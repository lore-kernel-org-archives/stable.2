Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F46D4E3EC8
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788449988; cv=none; b=oiOggJG7YgimI+WQjzRySSlD3oTGqvb2p2JH6UXmkqNpcJiKilFzTYvKgJFot9leXMUMmxQ4Mce0KYC9PeJ/u9kSTV+wNy8cnKIg7zmJNIgXQr7JBNQtUdyNC7CAckTxIUEk3rFiOq1jP0nDAvZa0NpwRzrpHE7Xqehf8OwsozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788449988; c=relaxed/simple;
	bh=Mso0Ct2JFOuHfDNhE/YU24FLdB2GnyFz225xA80zZsU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qbUDkngWV0lwuGofzukbLidH4bK1qmYoB7fPS+s00rWjQfWvrIdXn/i2fdjda5Zq3pFcZtLHDqOzjBghvKAV86AVwBULi8EppMR0w0ZauU1/t06v6n9+Dq/DADnxLD/TRvJohIb0+4qTtbArUZvgSF7hgKzhIuKeeo23GFJZsGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oYsj6vJI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oYsj6vJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF5B1F000E9;
	Thu,  3 Sep 2026 15:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788449987;
	bh=Sq+GDjYrkH4F/ifj4A24Alj+JGjIoZ/IX5RqThe56aE=;
	h=Subject:To:Cc:From:Date;
	b=oYsj6vJIGX89IVB9cZumgDMQVT5nhPnWB/RTkqXAsxhzuSDFBibeWEZ9tpFKVyhZl
	 vJp2noulW53bvhZD+gRqQsOMrDW1rtebdra+ANd/CoYlRSRZD2NRYrYzoOX4+UfT9Y
	 eHvYSmVcbZQVHrRmAR30OjjQsy42sfrb8n3A6R1E=
Subject: FAILED: patch "[PATCH] mfd: sm501: Fix potential memory leaks during remove" failed to apply to 6.1-stable tree
To: nihaal@cse.iitm.ac.in,lee@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 17:12:51 +0200
Message-ID: <2026090351-runway-afraid-7fc2@gregkh>
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
git cherry-pick -x 83feedd9d83c0c5199f98c72df0a6196b4aefb4d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090351-runway-afraid-7fc2@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 83feedd9d83c0c5199f98c72df0a6196b4aefb4d Mon Sep 17 00:00:00 2001
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Date: Mon, 20 Jul 2026 17:08:32 +0530
Subject: [PATCH] mfd: sm501: Fix potential memory leaks during remove

The memory allocated for struct sm501_devdata in sm501_pci_probe() and
sm501_plat_probe() is not freed by the corresponding remove functions
sm501_pci_remove() and sm501_plat_remove(). Fix that by adding a call to
kfree().

Fixes: b6d6454fdb66 ("[PATCH] mfd: SM501 core driver")
Cc: stable@vger.kernel.org
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Link: https://patch.msgid.link/20260720113836.73133-1-nihaal@cse.iitm.ac.in
Signed-off-by: Lee Jones <lee@kernel.org>

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index b5bda477ebfc..77888965d91e 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1627,6 +1627,7 @@ static void sm501_pci_remove(struct pci_dev *dev)
 	release_mem_region(sm->io_res->start, 0x100);
 
 	pci_disable_device(dev);
+	kfree(sm);
 }
 
 static void sm501_plat_remove(struct platform_device *dev)
@@ -1637,6 +1638,7 @@ static void sm501_plat_remove(struct platform_device *dev)
 	iounmap(sm->regs);
 
 	release_mem_region(sm->io_res->start, 0x100);
+	kfree(sm);
 }
 
 static const struct pci_device_id sm501_pci_tbl[] = {

