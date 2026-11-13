Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794530774;
	b=4KCB9Un5vJizsWbvDPLkqwR9MZhuy1K8vXAmOGO0QJiFhPVC+o/71gYGEMbespp4Oi+N
	 xZog2DsIGnnoPYWO9CdYZmkDBHkICH3PbUa/0I16RZynIyDy9Yh6HpfxL63DWwkGqzXCp
	 vUu4A5axrNavHOVy25Ja95qUgkbwtycaMWqoRSivAp99aOS4vWZL3z317NSMMEL7dQ8Y8
	 LEMlCxs52joYd9h/3xHJBoKBVyhYh3mvlGTVuYKdo4WeErxRCFBGqOuIq3CGpwpl85kcr
	 9q22SsyTMyKWxUxxhfCUm+zBH91wVQMJWES7pqJuHQtYtHvvhTmlvTWmFQhpUvO28FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794530774;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I8mSshGpx2AHXeoquqR7LIvMNup8y18J1R6//+znhG8=;
	b=uFNbytlMmzYVB4DRsHOFAlHBIemWJu57QgXuozg/mfVJOHYu2e/dhP6cdlki5OV7bImd
	 NOYfQHq6xJ6vzW6e/kq5PfNIV44StZIL7jcfgRLY8hkXVxDzExTU+RRKBnCuFLDhudbD0
	 pkrtdirL70ZalX/i7oUKfR/vtfFAfs/hThutzj0ZImt9PlvPXee6egYisEe8PKTrqO5Kv
	 AT7MNf7qzpwOJQiyRBCPN4mThF44y5MsAkc8+zGpV9FLMgKE/F0xaXZIr7O1d5w5aDnJH
	 VyZ1hEk1MAt4PpCqXzW1mJD0TV/fup4SX6gh7NXM5tFri06Hsjrh1C38uYO9zvcQueQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BZ2h4QJn;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3F606A33D;
	Fri, 13 Nov 2026 00:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8AD3F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=BZ2h4QJn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794530773; x=1826066773;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9mF/uL0eov56MZMw73OmMJmkpD4B2LdC8Tn4XrECHpM=;
  b=BZ2h4QJn5Nd329P9PiyN3+L/a3DDbHrSFB/3piNZvT9A1PMeld/Q7uCv
   uJnLFH/eMTo3OKcsRk4i0xc7kVvreWSCLg7UHcclgrreFfd/J+8QSuBti
   Kqa8K5TqyOOiSLU05fC3efy0geSqGYBJNvqXE6g0iw9/Mw7kIMz3wG0QJ
   GRXgQPtjS5ex3Oh0PAJgeQL92q8l69leyO1HM2rvrjkYPdOE/Jqe2xmAG
   g3oybadd1bXLGov4N7TkcmVkA5Y5cIhLdzC4Ha9AH+11SPh6YNRHbtl7y
   Aa2N+isIkEpRkiFN6Mf6d/d1NlBUVFgBMdZ/rt0GMcgj7azEC/K7vNtEv
   Q==;
X-CSE-ConnectionGUID: WWtaYov6QGSWri3S6isSUA==
X-CSE-MsgGUID: AhEQzxNcRk+1ikQutwThGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3361680"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3361680"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 16:46:13 -0800
X-CSE-ConnectionGUID: yF1f8DB2RrO1xJP/OfngOQ==
X-CSE-MsgGUID: o0d0L5woSA6ln7e6jRcQrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="8724620"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 12 Nov 2026 16:46:13 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Xuanqiang Luo <luoxuanqiang@kylinos.cn>,
	anthony.l.nguyen@intel.com,
	mheib@redhat.com,
	fballuch@redhat.com,
	aleksandr.loktionov@intel.com,
	jiri@resnulli.us,
	stable@vger.kernel.org,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Subject: [PATCH net 4/6] iavf: fix QoS capabilities memory leak
Date: Thu, 12 Nov 2026 16:45:58 -0800
Message-ID: <20261113004602.129864-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261113004602.129864-1-anthony.l.nguyen@intel.com>
References: <20261113004602.129864-1-anthony.l.nguyen@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Commit 4c1a457cb8b0 ("iavf: add support to exchange qos capabilities")
allocates adapter->qos_caps during probe, but iavf_remove() does not
free it. This leaks the allocation whenever an iavf device is removed.

Free adapter->qos_caps in iavf_remove().

Fixes: 4c1a457cb8b0 ("iavf: add support to exchange qos capabilities")
Cc: stable@vger.kernel.org
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
index 2f8a80a11336..4de3ea8525b3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_main.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
@@ -5638,6 +5638,7 @@ static void iavf_remove(struct pci_dev *pdev)
 	iounmap(hw->hw_addr);
 	pci_release_regions(pdev);
 	kfree(adapter->vf_res);
+	kfree(adapter->qos_caps);
 	spin_lock_bh(&adapter->mac_vlan_list_lock);
 	/* If we got removed before an up/down sequence, we've got a filter
 	 * hanging out there that we need to get rid of.
-- 
2.47.1

