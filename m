Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C148C33DEE5
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 06:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095992; cv=none; b=aIXWYXIkriatzTIui63cEcRmr8gooQx/RWnZoHAb1FZQyXOAKysDZISek0hv1g7u+/B7aCbULCjVx2BWLkPu1tYTbKglY78hMyHtaixtesic07vrcAELwMUPtkzoTOWV9P+a+6Z5Go6xy35oxbicWwKLCvHwauxPDoEhiTyof2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095992; c=relaxed/simple;
	bh=Nv2g73dT9Ca/Dmbupn785gM4E5jzpax/qHLKPGVllpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyNV6byqh8Tf+JkDNZr+Ix5Blw4EzXcypuqjP8d0gr81Yt0ppGh8FqhFdPp0yRdumQ2CM7Cg0gHfw7JFst9X0Kr2jk0ZNSJ37ll5yuRQ48SnR779j7xrOC8HeKZsTJS9eMeudzwyicJarCasiTrfX9m2mqMAP2h4MQk/hZInptA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vJeKyWE3; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vJeKyWE3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784095987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GNA34ZVAFe+Zjxs6F20dktajo1LonGeHCUW7GzDGnsw=;
	b=vJeKyWE34SQhoigJZ0mLJv5fiWh7HpHFQ8s33lvfIDYX+wGgjskEcqf9MP6XM+7EWLVGJ2
	wOBZ5Qn7OPKAyiqfAlfER98FEMYYk28wEqZuVvwXdlvQpgGmv0FzvH7Dxv1FZfGmpsVYyT
	mFucntdU6STRSdwENCfNuh2IIQcm1+0=
From: xuanqiang.luo@linux.dev
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Mitch Williams <mitch.a.williams@intel.com>,
	Greg Rose <gregory.v.rose@intel.com>,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	netdev@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH iwl-net v1 1/2] iavf: fix ASQ command buffer leak on init failure
Date: Wed, 15 Jul 2026 14:11:30 +0800
Message-ID: <20260715061131.34420-2-xuanqiang.luo@linux.dev>
In-Reply-To: <20260715061131.34420-1-xuanqiang.luo@linux.dev>
References: <20260715061131.34420-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

iavf_alloc_adminq_asq_ring() allocates cmd_buf before the remaining ASQ
resources. If iavf_alloc_asq_bufs() or iavf_config_asq_regs() fails, the
unwind path elides cmd_buf while freeing the other allocations.

The ASQ count is not set until initialization succeeds, so the shutdown
path cannot reclaim the buffer. Free cmd_buf in the common unwind path.

Fixes: d358aa9a7a2d ("i40evf: init code and hardware support")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/iavf/iavf_adminq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.c b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
index 6937b7dd44cbb..82a32f8e78c12 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_adminq.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
@@ -346,6 +346,7 @@ static enum iavf_status iavf_init_asq(struct iavf_hw *hw)
 	iavf_free_virt_mem(hw, &hw->aq.asq.dma_head);
 
 init_adminq_free_rings:
+	iavf_free_virt_mem(hw, &hw->aq.asq.cmd_buf);
 	iavf_free_adminq_asq(hw);
 
 init_adminq_exit:
-- 
2.43.0
