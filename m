Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3077367288
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 06:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059063; cv=none; b=bQ9g1dQufqQ1mhNOEj0blfQQgOV/xvssspe7RHzhVAtY+JRoMFeRQdxFyH6UDqL1L0hMZTTxTxR4sLqXZsPsHK2gQILJd2kn7BUXgE+GtR53BQMf04pvyj7K1LB51+lXijjHe5mdW8Ri7iQqD94PiMI67HPQH+YE5LJBAFFTTLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059063; c=relaxed/simple;
	bh=HSlIB00zlAKExp+E2zdfVN3TYexmAhVIq7IKquu+sSg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnVYRKfGJoODPfIcWdpN/dU6rCRXFIuesq0+f5ckMMeD/ernEIVWMsHX7gGbpDi8tEdRlXwkeeF1s+TEPSC91SQKa+Wp0C2euXOY6ab9xQj3pzZOiwENr1m5EDJi+J7zw+/oEFoZJQkpjNtFc/i2zDfWrfOhW7GacHKA6tYemC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SwsdrwH6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SwsdrwH6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790059062; x=1821595062;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HSlIB00zlAKExp+E2zdfVN3TYexmAhVIq7IKquu+sSg=;
  b=SwsdrwH6aUsfoxndJNAUwzLFB8CubnpLw39v7lEdnIwXzqtdrjHDoihB
   nDmHiPKEO6oaMItweQhHHuCPZwrP43Y8+8u14NCPDxhNEunpZEV5hGfZC
   ZjHPQhiFG2RALNgMeTWVasP+RRgibY1zm1RHQg8OO9V8NVy5Dsgndlmvv
   dtgIm97zdWB25TV4c/DkwYy4M6SoklwedFRwJ8bXzUx5pNWwBdkjHWD3e
   xXKGP/zyCo6XwIU7MA4NsTiXsifCN4gALfWrQvEdvGTUZfG40ncx6GZC9
   +Hz4/xzD9Ql2UCpvaA1Kg1mwzbX5pn5+EPd2fwaP4jbj2wj1z63QDZ/Dv
   g==;
X-CSE-ConnectionGUID: PBJUbBhwQ+mHyeENQDW/kQ==
X-CSE-MsgGUID: mkM6L8NsQ8mXKLDG1rrBjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="93135657"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="93135657"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:37:41 -0700
X-CSE-ConnectionGUID: u00VA86BT6+j1zmWwR00pg==
X-CSE-MsgGUID: 8JwrB4zjSAKZ8RuoH+riEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="271541873"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa006.fm.intel.com with ESMTP; 21 Sep 2026 23:37:40 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: chandrashekar.devegowda@intel.com
Cc: kiran.k@intel.com,
	stable@vger.kernel.org
Subject: [PATCH v1 2/3] Bluetooth: btintel_pcie: fix plen overflow in btintel_pcie_recv_frame()
Date: Tue, 22 Sep 2026 12:06:48 +0530
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

