Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 64AA43B6C1D;
	Tue, 22 Sep 2026 04:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790049649; cv=none; b=XkfnCXu2Y6g41h+chLnMrVgcn3T4AaGHB62gGXUjUL3WhOEHtDB58QWpEOeq3ec0mJEs+qVmYqUcuG6vTCU4/07YgKHLjbO9mCgox8iUWkA+10Je7zYo0KCRAZdeBJbI1nXF7JUSa/DVokksIZ9ts5XDR+gpqddyvmVwhCPaCGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790049649; c=relaxed/simple;
	bh=M7vy4D7c8GYyVU9w0y9qtpb5ZCLTfXeqT1VgsjIdZ9Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gCQcDo1jKNRhRmAgruTgrbUq+kZTPAB4nCPi+w5UV9Bg5hVAdcyZ+oeMxV35ahFRu6+oskyKQaM9eGLZCWRkkMX2GcA+jjEIk3ENb4SGwqoiSaibQAyAVLgVTt9wTzYtU8PmFxE1CcEvTxv1xkpQZMctpll3gYuPxUY1sg8tB1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b=GAFCuLys; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baidu.com header.i=@baidu.com header.b="GAFCuLys"
X-MD-Sfrom: lirongqing@baidu.com
X-MD-SrcIP: 172.31.50.47
From: lirongqing <lirongqing@baidu.com>
To: Alex Williamson <alex@shazbot.org>, Matt Evans <mattev@meta.com>, Kevin
 Tian <kevin.tian@intel.com>, Li RongQing <lirongqing@baidu.com>, Kees Cook
	<kees@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Ramesh Thomas
	<ramesh.thomas@intel.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>
Subject: [PATCH] vfio/pci: Restore 8-byte ioeventfd support
Date: Tue, 22 Sep 2026 12:00:13 +0800
Message-ID: <20260922040013.2188-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc11.internal.baidu.com (172.31.3.21) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=baidu.com;
	s=selector1; t=1790049633;
	bh=nFgUwR7Fc7HYf6AorOFSE+VR2rSra8ayYhrTFAZOWU8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type;
	b=GAFCuLysrbBqWJJ5XUMY52620d7O5PggGrUvDH7j7tzaxcR8sQNlT6OCgqOVgWG8g
	 6DucLlpwEyzHd2PLWlix8asDCjTLVKlPIZDxdqExQEbfWhrVmJUjnMg8OMQ1LcKbgq
	 9KbzRhSEF2PiTORTy8ZtB6bOtYKs5DSosG+7i1LcPkuh5rDfygc19OU0gc3F6jVH0T
	 WAKikB+/ZMOnJaalWL6AfV4ssYzfko7cWynLJH7EybUHbFGTJOoxZxWMwIvyjS63bo
	 2tbWIoNkMw6DA2znOflszQL1HaxEz22HCuqWzJ8h9LSTUpw3vG0Jd3LAb44LAnWsLt
	 x3sD0sYyLIPPA==

From: Li RongQing <lirongqing@baidu.com>

Commit b44a06bd28f2 ("vfio/pci: Remove #ifdef iowrite64 and #ifdef
ioread64") inadvertently converted a conditional 8-byte rejection
into an unconditional one.

Originally, 'count == 8' was rejected only if iowrite64 was undefined
(#ifndef iowrite64). When iowrite64 became globally available via generic
fallbacks, this rejection became dead code, allowing 8-byte ioeventfds.
However, b44a06bd28f2 removed the #ifndef wrappers but left the nested
'if (count == 8) return -EINVAL;' intact, breaking all 8-byte
registrations.

Drop the unconditional check to restore 8-byte ioeventfd support,
matching the original intent.

Fixes: b44a06bd28f2 ("vfio/pci: Remove #ifdef iowrite64 and #ifdef ioread64")
Cc: stable@vger.kernel.org
Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/vfio/pci/vfio_pci_rdwr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_rdwr.c b/drivers/vfio/pci/vfio_pci_rdwr.c
index 7f14dd4..df88480 100644
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -423,9 +423,6 @@ int vfio_pci_ioeventfd(struct vfio_pci_core_device *vdev, loff_t offset,
 	      pos >= vdev->msix_offset + vdev->msix_size))
 		return -EINVAL;
 
-	if (count == 8)
-		return -EINVAL;
-
 	io = vfio_pci_core_get_iomap(vdev, bar);
 	if (IS_ERR(io))
 		return PTR_ERR(io);
-- 
2.9.4

