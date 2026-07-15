Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3BA3B8BBB
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784095996; cv=none; b=lYQoMGHD8imaFGTB9hE4uqGAwF5kax+KRuTtbRKSGbaghO2G26mPJ66h6ZlpUhIT95SYfGO4ObjGOr16DJON1m0shtXBmGSOjpew0lwMk65bVk/n2qBAIshJ+InTQ6l+VMgNDGieVHXMZB5Xe469YJl/lTiCdLMI0lMdCS4b3gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784095996; c=relaxed/simple;
	bh=dLTH2DxeQ7XK0Lw7Aa491qF5OKnbXnCHfdT/3l/AhQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGThcJrjMonHpSk4vZGoR1trpIFOA6yYD7mHH+bnpjPLHTu2oKQWd2a5tAkmMWL7OfT2d92GO7UmEmfe6ai6HHLMxSm0dVzcT1cEBQzlkjHffKhNVqCGL9MYdqvH1VMGrvFSRB9uv1d2G4MoQZ0vJz7sx0pn3+LCOMA6PpVE6qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vneqqpSU; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vneqqpSU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784095991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VPEUFTzVk8RYAlWSMk2Q2P7BxFqxwtqJBCiSB6u+y/A=;
	b=vneqqpSUQqPujTEYl45vle3Zwt9EE5DDw+p0pF/rrjvfdByXgJcgBDsRu+1j47Exdm1idd
	r1MRBh7AuLIebqLdGX8C3L0PbxxsU1dEZSorAL7PY3N3rX398daovbf3rdrrlgpbjBtBTK
	jawNIr0HNY2TTiBN+KS8A2mRJgHnkJk=
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
Subject: [PATCH iwl-net v1 2/2] iavf: fix QoS capabilities memory leak
Date: Wed, 15 Jul 2026 14:11:31 +0800
Message-ID: <20260715061131.34420-3-xuanqiang.luo@linux.dev>
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

Commit 4c1a457cb8b0 ("iavf: add support to exchange qos capabilities")
allocates adapter->qos_caps during probe, but iavf_remove() does not
free it. This leaks the allocation whenever an iavf device is removed.

Free adapter->qos_caps in iavf_remove().

Fixes: 4c1a457cb8b0 ("iavf: add support to exchange qos capabilities")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 29b8403a066bc..c7f69a9040588 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5589,6 +5589,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	iounmap(hw->hw_addr);
 	pci_release_regions(pdev);
 	kfree(adapter->vf_res);
+	kfree(adapter->qos_caps);
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 	/* If we got removed before an up/down sequence, we've got a filter
 	 * hanging out there that we need to get rid of.
-- 
2.43.0
