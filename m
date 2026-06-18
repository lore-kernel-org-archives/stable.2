Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034AF2EBBB7;
	Thu, 18 Jun 2026 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781794182; cv=none; b=FeEjgA7bIJTLn3BKGtdYVOTNWM1IXf9NHqf9M5zc2M3oPeERUIC6JjNFnrEHw3RBYP6eMces6thlUAtOQZ0a81scje+Y8uO9SquChao8PrcBoAw101l4RVWh6IrQ96MFq9AZs29889bLWsLXiaVzuO6eN1Xgtiv/vH9aIybIFuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781794182; c=relaxed/simple;
	bh=QgJNHeiYaIukuDIx//YrXzaH2VMJ/SoiFdexdcjQz4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o2mPB4BzLeG08q4YDBIjpwrQzTxSYzbgOODIB04VI4mmVz7JYb4/R1XlEXUgt6GJM8aPowqaC4hWW6LTU2rNB8Cu3eqvixwml97864GNSnyG61R1oJ2LoUIDrcgzVL1Qz4z+vC4nrKr6n6XcGWs95yyikBlGv7FX48/vpNAddkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7V0X977; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7V0X977"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781794181; x=1813330181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QgJNHeiYaIukuDIx//YrXzaH2VMJ/SoiFdexdcjQz4E=;
  b=V7V0X977FNsBCXlC/LuM0AsM1XTjlvRUrvl84T3V95EuzMgZSjYpXJMi
   3Gfo8fMufgkioLfk+socVo9waoRNLUDKBUzWqSs6nYzxfIC3ipCBB4uJE
   4+Q8r+hho70obqJmh1NW9xOb/zZuz55WEROSJJgpu2lZRRCLPBc5Py2W0
   JMRaaQ5HAOLmjLEcv7y5OR2A1RfHKNEU7mdhRxTpGawRoPV5D68AWfmpo
   n2VK9UZti+L2A0Te9sT5kwNjOqp+FN3ZooNtp0gExjocDHtNCUclmdmv0
   d+6ljFvidGEQusGXuOns1nF46EoIFGdGjRVxhgJg58NDVver4MfPNT+Wt
   Q==;
X-CSE-ConnectionGUID: Pmsi02WKQyeQTYM/Jf7ZSw==
X-CSE-MsgGUID: 3J62mtAHTdqC+Fa1PhLlsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="93230413"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="93230413"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 07:49:41 -0700
X-CSE-ConnectionGUID: O0H2Jj3KS2uYJbxsyqpGMA==
X-CSE-MsgGUID: XvnTkluPSKedUtCcZnpClA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248449729"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 18 Jun 2026 07:49:39 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id F350498; Thu, 18 Jun 2026 16:49:37 +0200 (CEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Andi Shyti <andi.shyti@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v1 1/1] i2c: mpc: Fix timeout calculations
Date: Thu, 18 Jun 2026 16:49:34 +0200
Message-ID: <20260618144934.3249950-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ON the first glance the harmless cleanup of the driver does nothing bad.
However, as the operator precedence list states the '*' (multiplication)
and '/' division operators have order 5 with left-to-right associativity
the *= has order 17 and associativity right-to-left. It wouldn't not be
a problem to replace

	foo = foo * HZ / 1000000;

with

	foo *= HZ / 1000000;

if HZ constant is in Hertz. The problem is that in the Linux kernel HZ is
defined in jiffy units, which is order of magnitude smaller than a million.
That's why operator precedence has a crucial role here. Fix the regression
by reverting pre-optimized calculations.

Fixes: be40a3ae719f ("i2c: mpc: Use of_property_read_u32 instead of of_get_property")
Cc: stable@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-mpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-mpc.c b/drivers/i2c/busses/i2c-mpc.c
index 28c5c5c1fb7a..a21fa45bd64c 100644
--- a/drivers/i2c/busses/i2c-mpc.c
+++ b/drivers/i2c/busses/i2c-mpc.c
@@ -844,7 +844,7 @@ static int fsl_i2c_probe(struct platform_device *op)
 					      "fsl,timeout", &mpc_ops.timeout);
 
 	if (!result) {
-		mpc_ops.timeout *= HZ / 1000000;
+		mpc_ops.timeout = mpc_ops.timeout * HZ / 1000000;
 		if (mpc_ops.timeout < 5)
 			mpc_ops.timeout = 5;
 	} else {
-- 
2.50.1

