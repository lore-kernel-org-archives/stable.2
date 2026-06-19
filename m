Received: from forwardcorp1a.mail.yandex.net (forwardcorp1a.mail.yandex.net [178.154.239.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00857313E17;
	Fri, 19 Jun 2026 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881494; cv=none; b=GNA2l1GftfszY1dodFSKSP7SyHvBKqLPsXVdPCYFOTjls53qaVuB+llWN5fdmqDBZmNODXk59ao97CmYXd2DJQ36yd43tJlq31Kbowa7+zUIfpYUCAVXC1MpishkOa3TRjxef8lUQ9l1qoA69yRGBWgJFPKw/VfNXw0XW0v9I4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881494; c=relaxed/simple;
	bh=TWLATS5ZQTlG9+7vcA0bsAeTbyVif3LOHRTzhU5WJH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rDvFigr5HEWyE5kcekp3bLLsELq/M4c6l4RyFQmYw8D08Cr67MAi3UBu4AJXNmSsLTFVnggvr3st4molVmAfj+NIXMRS0FWHnoYQetO0oGUhypZPKcf91fgih6GAU2QNoDAEhsjCYTFxZtDQtLqzepneeLPA0hIJ9eoOchbJp78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=epzHP0mq; arc=none smtp.client-ip=178.154.239.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="epzHP0mq"
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
	by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 65D41C099E;
	Fri, 19 Jun 2026 18:02:40 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6bf:8080:13e::1:2f])
	by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA id 62V9QE9ZUa60-RgHMGHrO;
	Fri, 19 Jun 2026 18:02:39 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1781881359;
	bh=p2EI4qq2PUmOIQektlZBD1XXkzPURDv3LDgsNp3yuqs=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=epzHP0mqhcPQJQ/7g9b/dliQQF5/lDBMpffB8WlmhqbEKKWJQMIM9lVW7cIU9J6V6
	 BkCQirC9mvKbb+afxjzLVumZT4fqPcZ6FuhERFl50TPLak8dLyl/3hPYZrWg2Pap2V
	 EUMQbYHSZJ1OdW1Ti0923XvKGOPHIV/3Ft+wywn8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	Kirti Wankhede <kwankhede@nvidia.com>,
	Yan Zhao <yan.y.zhao@intel.com>,
	Nikolay Kuratov <kniv@yandex-team.ru>,
	Jiacheng Shi <billsjc@sjtu.edu.cn>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH 5.10 5.15] vfio/iommu_type1: replace kfree with kvfree
Date: Fri, 19 Jun 2026 18:02:06 +0300
Message-Id: <20260619150206.1719815-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiacheng Shi <billsjc@sjtu.edu.cn>

From: Jiacheng Shi <billsjc@sjtu.edu.cn>

commit 2bed2ced40c97b8540ff38df0149e8ecb2bf4c65 upstream.

Variables allocated by kvzalloc should not be freed by kfree.
Because they may be allocated by vmalloc.
So we replace kfree with kvfree here.

Fixes: d6a4c185660c ("vfio iommu: Implementation of ioctl for dirty pages tracking")
Signed-off-by: Jiacheng Shi <billsjc@sjtu.edu.cn>
Link: https://lore.kernel.org/r/20211212091600.2560-1-billsjc@sjtu.edu.cn
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
 drivers/vfio/vfio_iommu_type1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index f17490ab238f..9394aa9444c1 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -256,7 +256,7 @@ static int vfio_dma_bitmap_alloc(struct vfio_dma *dma, size_t pgsize)
 
 static void vfio_dma_bitmap_free(struct vfio_dma *dma)
 {
-	kfree(dma->bitmap);
+	kvfree(dma->bitmap);
 	dma->bitmap = NULL;
 }
 
-- 
2.34.1

