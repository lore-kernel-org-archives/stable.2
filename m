Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F17C4E3255;
	Tue, 22 Sep 2026 06:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059271; cv=none; b=mAWtbl11JyCS9o7WhIlA9HyCgIon7hjuZ5IFXfxe9eE5USOutOdyAkHlMjbF/Mjklu77UujguHZrC/8mMse8MnrUcJCYqvPR4gGyQxBwk6eqibD4ciHeEXZFJ0grLqGBLOUz2yc76GrV5S6g3DqPC4IwX2G155ONK9kX+WHrv74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059271; c=relaxed/simple;
	bh=HSlIB00zlAKExp+E2zdfVN3TYexmAhVIq7IKquu+sSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J8R15ms4+4xcdi0XWdsFkiPog58oCX9f6h3o0WaKFh7TVS/MaYmkHqqXsYXVSgECbALcqVRL6gV7Zoft9Y6ET7Xvmod5vO3Q3SkPZuw5z95K9/mkWpgQdSpYDebNv5sPkanmxm3gD7YF/RoA3bF+oRx7BmmVqJAN+dVavs5DAX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VF3LEpLJ; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VF3LEpLJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790059270; x=1821595270;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSlIB00zlAKExp+E2zdfVN3TYexmAhVIq7IKquu+sSg=;
  b=VF3LEpLJFupzv6bsyV/zWaRSl/ZYfiwV/EgHSvLJ46IZYaD7P/ni9AYB
   Wq28nYz2E3sjUfWEnP3hJ7h7EyvTFJsU2PrPOmOk7QiNKaU3XXHRpWbJS
   y5YBjcKXmkdWyB9PpdzlH5ryccDim4VYNPOG/auUORsTXMRAA/VVnneAU
   +UMZqjULtwpWc7Q8TgoNnmAfrygQ3K8Yns+T9/7g4Hepj5rrk55+hP4OU
   sP+Zp5YkKD3Ab3i8t0PW4HU8oLm7nGbxIuLACqnBoeETSlMggM5/j/t2F
   Yw12cyvCQYMTNuM6hsEZHSDRvRwkRvV19QUYVP4s4FDFrg4d+WnTQpMrZ
   w==;
X-CSE-ConnectionGUID: vZpF7pnCQX+sbl+tR5mlXg==
X-CSE-MsgGUID: V4vtE7eYT9KfZ+Wv6KyHgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1139873"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="1139873"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:41:10 -0700
X-CSE-ConnectionGUID: qnsPsrjMTOyxnu61G4lUiQ==
X-CSE-MsgGUID: g2fnVmMGTQaa8IxPTlQLmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="3987119"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa012.fm.intel.com with ESMTP; 21 Sep 2026 23:41:08 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 2/3] Bluetooth: btintel_pcie: fix plen overflow in btintel_pcie_recv_frame()
Date: Tue, 22 Sep 2026 12:10:21 +0530
Message-ID: <5abc920bcef2e456c1fda1bb1a1e34dcfc3ee738.1790053452.git.chandrashekar.devegowda@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790053452.git.chandrashekar.devegowda@intel.com>
References: <cover.1790053452.git.chandrashekar.devegowda@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <20260922064021.XIyZtGIrkxMIM3zBt93Anotl7xlF72pbDM-3JE-Sfzg@z>

plen is u16 and computed as HDR_SIZE + dlen. For ACL/ISO frames dlen
is a 16-bit field, so a value >= 0xFFFC wraps the sum, bypassing the
"skb->len < plen" check and letting skb_trim() truncate the packet.

Widen plen to u32 so the addition cannot wrap.

Fixes: c2b636b3f788 ("Bluetooth: btintel_pcie: Add support for PCIe transport")
Cc: stable@vger.kernel.org
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel_pcie.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
index 444cc50174fb..734ff8f6363f 100644
--- a/drivers/bluetooth/btintel_pcie.c
+++ b/drivers/bluetooth/btintel_pcie.c
@@ -2163,7 +2163,7 @@ static int btintel_pcie_recv_frame(struct btintel_pcie_data *data,
 {
 	int ret;
 	u8 pkt_type;
-	u16 plen;
+	u32 plen;
 	u32 pcie_pkt_type;
 	void *pdata;
 	struct hci_dev *hdev = data->hdev;
-- 
2.43.0

