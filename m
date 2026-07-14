Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F299DF76
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 06:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011272; cv=none; b=XWfRQw+iG4S0tzMGIiHWNnw42coij1SYXu8gjFCn97WRPN5Uiqabo6eGuJMqHtdfj+4lmUG9QnOvLEJPb4tWc678WchNR0zX3HfnQogv4eR8vTU9kQFcGxfqocjzFcemnPeL37vt52AofPL59xgM2gnCUq2FnMMj2fJe+IiFVwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011272; c=relaxed/simple;
	bh=6lyQRXk18+WT1H4J1CXUAaPIS2gpTnwnEN3m9wrS7yA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gpFlLuQS+G3TTWQXIosiVQlLfjlUSNxJ7Kh62QjSCS1mjFZIhv9d7OVSDeMw015bJ9Rj7/m5z/Dj7liKorFadSkI7tbrL1C3x5cAEhp709eLNRwZQqzyAVWTM9kQP+OkJhgWNS36D7aVwkXCd+X1Uio2crQC7zsRGXbibYlhnC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pd9eBGIO; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pd9eBGIO"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784011269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9x4DvNuH+C01RfbWzeGiOhrWxg912eJrBFFwtdhEQP8=;
	b=pd9eBGIOrIfwNQ6qzTN6LRyVyiIqOBiW8O3vTY2F64eYmxRBU7Ayr/UIFH11UL2NzRrPVc
	KdX49WQjcJHPPKxSlraoRAqBegvJ/+cXgZNWDQf9bfVBYAaMLEuRUiJOs4RDyGIZVlQ79J
	aZQQH+6f+AoBUq50qOcJS+e1taCGKIw=
From: xuanqiang.luo@linux.dev
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	sridhar.samudrala@intel.com,
	wojciech.drewek@intel.com,
	piotr.raczynski@intel.com,
	michal.swiatkowski@linux.intel.com,
	jacob.e.keller@intel.com,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v1] ice: fix use-after-free in dynamic port cleanup
Date: Tue, 14 Jul 2026 14:39:37 +0800
Message-ID: <20260714063937.26325-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

ice_dealloc_dynamic_port() uses dyn_port->vsi->idx to erase the dynamic
port from pf->dyn_ports. However, it frees the VSI before reading the
index for the erase, resulting in a use-after-free.

Follow the reverse of the allocation order in ice_alloc_dynamic_port()
by erasing the xarray entry before freeing the VSI.

Fixes: eda69d654c7e ("ice: add basic devlink subfunctions support")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/ice/devlink/port.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/devlink/port.c b/drivers/net/ethernet/intel/ice/devlink/port.c
index 2a2e56777f9f7..3ede246490027 100644
--- a/drivers/net/ethernet/intel/ice/devlink/port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/port.c
@@ -590,8 +590,8 @@ static void ice_dealloc_dynamic_port(struct ice_dynamic_port *dyn_port)
 
 	xa_erase(&pf->sf_nums, devlink_port->attrs.pci_sf.sf);
 	ice_eswitch_detach_sf(pf, dyn_port);
-	ice_vsi_free(dyn_port->vsi);
 	xa_erase(&pf->dyn_ports, dyn_port->vsi->idx);
+	ice_vsi_free(dyn_port->vsi);
 	kfree(dyn_port);
 }
 
-- 
2.43.0

