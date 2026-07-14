Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1407427FB4
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784060538; cv=none; b=a96NGdyWXK7j9WwEEr2Aq+hipES3QcWX+mFPTgv6RW8Tr6EQsqiTfDXiIxHA6HKbGR2nx75TUJy0ej3zMuqLw0s4agsGlZc/go31lRFCHLjIBtkYlFpiObVKt+dB2IBr1qkzl//Kj/dXpa5Qy5zCXwlgAGNWdR0eXU7Cw+xzOug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784060538; c=relaxed/simple;
	bh=4qtL0ez3hyrpM2ABej3N5hPK1bXfn9+2cpvfKZbLuTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r1//OYkjkZNubMG23ysmOkey7ygv2hkKlltIrfgJbNEuA5nm1lF13gPKaQ+Ld37DGvMw7WBXkbQ/S/aC2qJ0ajjT/Ul027jJx/+FZfYEJ/AitAQgx6ulKn/fSv11VpB+7yh33apPAB+fSytiBISmVJ223z/QYDdp5C0X2+/W0YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=3wtQYsN7; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="3wtQYsN7"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A9041A47FE;
	Tue, 14 Jul 2026 22:14:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1784060046; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=FbHrFT3aPOIRk2G2iDaIAzJcsRnUxYpIE1B26zLqdvs=;
	b=3wtQYsN7VJ1WRWzmPblt5yts6xFJNnZFV/J+trD/CTYf+ntlOAVUrXDPUoUALb79eZw4sj
	dGV4qEwxA4pNSPRBPCNZv6x7vpHTsFeH98/vVgRJj1s7PvPt80yYY26QEaBihHgdmVXVd3
	jADDInXrEjXRLPc18setVSzNV/763ec3/89V+IyERXCxvb8KgJ8o1VTw9Gxg1l2QDYLq+w
	Y6Ty40J2B7K/8JS5hBJt7a5lmEEMB0jq8HoPtEfSSn/atKyIKL8yJH1IjjbP3pIh+5jfgz
	h60xO9FZ2GSVquY02+jywc75BCRk7i6MuNRH9DHrjfgtAdBW7BC5yjCEHQDkSA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	roger.pau@citrix.com,
	phil@raspberrypi.com,
	linux-nvme@lists.infradead.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH 6.18.y] nvme-pci: DMA unmap the correct regions in nvme_free_sgls
Date: Tue, 14 Jul 2026 22:13:42 +0200
Message-ID: <20260714201342.1347823-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Roger Pau Monne <roger.pau@citrix.com>

commit a54afbc8a2138f8c2490510cf26cde188d480c43 upstream.

The call to nvme_free_sgls() in nvme_unmap_data() has the sg_list and sge
parameters swapped.  This wasn't noticed by the compiler because both share
the same type.  On a Xen PV hardware domain, and possibly any other
architectures that takes that path, this leads to corruption of the NVMe
contents.

Fixes: f0887e2a52d4 ("nvme-pci: create common sgl unmapping helper")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[nb: drop the attrs parameter added in 6.19 by commit 61d43b1731e0
 ("nvme-pci: migrate to dma_map_phys instead of map_page"), which is
 not in 6.18.y]
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
This hits 6.18 too: besides the known Xen PV issue, the missing fix
leads to corrupted data on NVMe disks with SGL support on BCM2712
(Raspberry Pi 5).

Reported and diagnosed in https://github.com/raspberrypi/linux/issues/7496
Backported by Phil Elwell in https://github.com/raspberrypi/linux/pull/7500

 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5e36a5926fe0..8c66fd23a143 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -761,8 +761,8 @@ static void nvme_unmap_data(struct request *req)
 
 	if (!blk_rq_dma_unmap(req, dma_dev, &iod->dma_state, iod->total_len)) {
 		if (nvme_pci_cmd_use_sgl(&iod->cmd))
-			nvme_free_sgls(req, iod->descriptors[0],
-				       &iod->cmd.common.dptr.sgl);
+			nvme_free_sgls(req, &iod->cmd.common.dptr.sgl,
+				       iod->descriptors[0]);
 		else
 			nvme_free_prps(req);
 	}
-- 
2.53.0

