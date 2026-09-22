Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA593C1F4F;
	Tue, 22 Sep 2026 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790059267; cv=none; b=Ug1bv4Zwy7x9df5LfJn1APhQ64w80OaWh1cn5wabK17+vQDqWqDMlVzlQTTwOdPMLi56T8SxU6hGskr7R3uJeSJd3ytxf4K+L71a+nAoH1Abk3ZosL3PIz6h5p2Aw36yyteE9LfKrsNEbUsSyX+ZsjQNVqwMcKW9FCBY6Mk4wB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790059267; c=relaxed/simple;
	bh=6IR+ihr8+lcxk06JrZypdtztydEDuahF88MIzzFTlPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NMX64qAsW3Yfuh//Rl6e/Fxac2Fu1/fA5KyAiwGiLO6QvcFOVzN6YvvPSPdq3r9Pf1vVH7QkZ5OeD7wXxICPtd6wPE4Gj0KaXRC12KhgcuALia0sNdy73e1ZYcb31R/WtjZAQZqGevtxC/CTJkdx1MQneHmjRDY50/4/u/Zve1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZcwHqdAk; arc=none smtp.client-ip=192.198.163.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZcwHqdAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790059267; x=1821595267;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6IR+ihr8+lcxk06JrZypdtztydEDuahF88MIzzFTlPY=;
  b=ZcwHqdAkzH0D3f5SLEKE4LSLwpwwgK8A17Ux9J9cxqI3P7pMZDsqmfR4
   hrFHtRYWtkZVrZIiD3SLCXLLzoN+HgZAQkPdL975VuImwW3rnvgRGKyUw
   slexjeLb3VtKBmlV3noNHYu+jd+j3UH94vmdVTbYU36M5kdtmcGz12D9Q
   a3qelIXL5ebzJeGAwSODg+DJhfirytIuWh7Ycq2KVafwxtyLDcr0FD6n9
   IrHhZNdkMXfyAnJdTnSjB8hsAW21SDz7nmYWVqo8zvU4ou+WsdIKNBzRW
   jbtjZPtaPzBIRlXQP5KBeXFQtEQRlTJ76eill8Nf7+WR2jcmmoki6wzAH
   Q==;
X-CSE-ConnectionGUID: RcFjPpxrRR+AX3OVvqDn8g==
X-CSE-MsgGUID: 78xh+izDSZ+TRhkAfjoi+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1139870"
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="1139870"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2026 23:41:07 -0700
X-CSE-ConnectionGUID: pHOQCKOlTV2Cbyrk/1A3Ig==
X-CSE-MsgGUID: ywEIszRHSketx3FCBcdZdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,116,1787036400"; 
   d="scan'208";a="3987104"
Received: from weba0957.iind.intel.com (HELO WEBA0932.iind.intel.com) ([10.224.186.34])
  by fmviesa012.fm.intel.com with ESMTP; 21 Sep 2026 23:41:05 -0700
From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: chethan.tumkur.narayan@intel.com,
	kiran.k@intel.com,
	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/3] Bluetooth: btintel: fix buffer over-read in btintel_hw_error()
Date: Tue, 22 Sep 2026 12:10:20 +0530
Message-ID: <b484c13e104eab61a42e319dd858bce971a8a8ab.1790053452.git.chandrashekar.devegowda@intel.com>
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
Message-ID: <20260922064020.LsKdcx5UpE9dTQq_YHCm8KDXHQXTIhCNFeAeZfGGmfY@z>

The "Exception info %s" print uses skb->data + 1, but the 12-byte
payload is not guaranteed to be NUL-terminated and can be read past
its end.

Bound the print with "%.*s" and skb->len - 1.

Fixes: 973bb97e5aee ("Bluetooth: btintel: Add generic function for handling hardware errors")
Cc: stable@vger.kernel.org
Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
---
 drivers/bluetooth/btintel.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5e6d1ddc99c6..12bf795db84e 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -290,7 +290,8 @@ void btintel_hw_error(struct hci_dev *hdev, u8 code)
 		goto unlock;
 	}
 
-	bt_dev_err(hdev, "Exception info %s", (char *)(skb->data + 1));
+	bt_dev_err(hdev, "Exception info %.*s", (int)(skb->len - 1),
+		   (char *)(skb->data + 1));
 
 	kfree_skb(skb);
 
-- 
2.43.0

