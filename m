Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9F848D89A
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301130; cv=none; b=Z6T7kh6dztDgiCwnuFxGvLS2LwjKwaW+oKifFb56aXabx9FY1uO7FxDbreEK94Fxb3ran1aoYfBl/+BMj3aPwp0FgxWpOKlhoPKDZWucnr/ZV7zECb9dsYNyHOt7DI3p8RWeaal8S9Gv5KithZyCdIJpXQodDI5TVxvSf2/HTCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301130; c=relaxed/simple;
	bh=6Nq1q7LaiCZpsOp9br2r1L/MpxF9waCD0glP2a0A810=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmCFuyKY2cF51GduJ9yDionGohp1yueSjTQ7LGUY4ncSTgenX5KuE0fXJpaCkOdBMMfKSAKwPDZMG78CmDMnrvQxoixWmCBM69eD/WbJEvo1n9kp46xvTAU1gef2+851kgwDftF12jVoqTLwvSu24VGBo/Ggomvs4BJDKHwvB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJrD1Pkc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJrD1Pkc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FD51F0089B;
	Tue,  6 Oct 2026 15:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791301128;
	bh=YaytfLnkP5AuoRzBNtPoUu05ZyzTCAn6dBLelVG1Jbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PJrD1Pkcz2YbaWAPIEOSy0X2VCWET2gjC46XROJh2i5lmewY8nwoIeO6arPaHlEal
	 v1MPcbsav+xaB1ehx+my/lxz6AlxwnxeoppKV5YUk1nZbr/nJ+3GWkBJ2LBvp+Bga+
	 fQ9dAlWxCtafpEU3l+eS3awWmUeH6I5CEVVPWSuTaFKQdIzeXODVi9u5jYfjMr5TLU
	 yFtz+B5RlHUKaKtoxlU98Zx+uP797dQgwvd2IzDHIxD5vkn3j2sUI/Jb31pB6Dl0Hn
	 ss29WMaqrfN1gHVudwtL52Pf40RZA4trxgtcElKxTaZoX2fE20QzM74zxPhEXD7mjC
	 JhKeO5no498gA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guixin Liu <kanie@linux.alibaba.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] nvme-multipath: set BLK_FEAT_ZONED only after the zone info is known
Date: Tue,  6 Oct 2026 11:38:45 -0400
Message-ID: <20261006153822.759729-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100505-trimester-quilt-e671@gregkh>
References: <2026100505-trimester-quilt-e671@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guixin Liu <kanie@linux.alibaba.com>

[ Upstream commit 4a5e49ba0abb8b4328d6318c9aef0c0121f95507 ]

The namespace head is marked zoned at allocation time based only on the
command set identifier.  If the zone info query reports a zero zone size,
the path namespace is registered without zoned limits while the head
still advertises the zoned capability with a zone size of zero, and
reporting zones or writing to the head then shifts by ilog2(0).

Drop the zoned feature from the head allocation and let the head limits
refresh stack it in from the path namespace instead.

Fixes: 28982ad73d6a ("nvme: set BLK_FEAT_ZONED for ZNS multipath disks")
Fixes: 3838e80fcfb3 ("nvme: skip the zoned limits update if the zone info query failed")
Cc: stable@vger.kernel.org
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
[ sashal: Adjusted context for the feature list lacking BLK_FEAT_PCI_P2PDMA. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index b1104798c7887..c2ab518e4470c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -754,8 +754,6 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	lim.dma_alignment = 3;
 	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT |
 		BLK_FEAT_POLL | BLK_FEAT_ATOMIC_WRITES;
-	if (head->ids.csi == NVME_CSI_ZNS)
-		lim.features |= BLK_FEAT_ZONED;
 
 	head->disk = blk_alloc_disk(&lim, ctrl->numa_node);
 	if (IS_ERR(head->disk))
-- 
2.53.0

