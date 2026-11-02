Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793658193;
	b=hF0L4Vx5XAOEFMIQN2OKwn8fpF1js95gbjosqXa1JLf/qEpHmEj+tyS+6nTxDQPRmu8C
	 gFk5B5FAa7XTG2lPUiMDguNhztMnLOIJnZ4IIwTP4bOsbCLScd/SXoHjIwBCfOwE9UQdk
	 xVG2bWwmCldFkhldnIIKif8KQ/j4ArIVJHh2E2Qp9/AoaaTMPOsahrT9GEl4qgrpmB2bA
	 ZnjvLgVevyuk52CqkhSFjho0/g7YCMpoOSIgs7Urb86TJyfugJxC2jloOUCKG6+lNyfpp
	 X53oaCrIZlXBTkfWlt1nm7IsXPeoQRY0cQQg23c5CJyLpYVaXlRt1pHANt3T77IjloA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793658193;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=H0fIDV3Nj+gM4Edp2oSC2psv1bmpnCT/Fc3I24teA4c=;
	b=Ysmjp6+6kG0e6Ss6fQb5+wW6LbDceMpsMMnvEzgxPkVJ/5k5174xr1/Sp/xFK73yiQ7T
	 WIIVAhPE7PW9z4HtpyKg4UXbCnL3AUoukThokBEFcPch+DpSLaIs8a2xHfPOTMZKrX9UO
	 ATdx0TiD2e3mT3IeZ5aB5Jx12xImwDa9aBmfxJKXKlmDzKAgSNKHQ3+B6XlztN+i2hkOr
	 eMwTp64wbwAHpCrXG1a45AaTXKdP6ObfT9Ius4Fuj6jjMsZUu7DN3Y67p2dTnsHc4nwva
	 RTW6/NbZ0174vgAc6elK1pCfFPluAA2PAphwxK0Sd2X6QUeA54+BDNv5131nglR3ucg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="ZoJtnA/h";
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79A1606A326;
	Mon,  2 Nov 2026 22:23:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D79A1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZoJtnA/h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793658192; x=1825194192;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9SOeMDMX0YgL2P8IH4L+GiLgePxa2YkFP+cCXrs3kOc=;
  b=ZoJtnA/heye7t91H32zwtJHsqgiV5XOKdhAcZoK3/z5wHvGl0z3FYKmg
   RZDJZW6WeiBohIQuFzpn2QITWe/dvq8nPCbQu85v0oktGVK0OvQV6+vnR
   asxoY8Z+se3jN7mvEjNb3p6d55MuwUpkx4br0YvbeENwBMzWAfSM5hq/q
   KToAUYE1YHLFh6cFA+OuRnhhrx/ibEz8KMKRIWXjqUZNwPz6Z21v6/Jav
   Cmj+tfbzkYEJ6QvB5jyL9Pe8WJOZZld8PenyYmB0nIlNkYiAI5Sqk12AV
   dAfz6LMixCqWIZLOYAehu5JQc67F3V7Jccu7gZz2oRzKrSfgAYlc2iu66
   g==;
X-CSE-ConnectionGUID: 4NB1ca2NT1qpAbmBX/XSpQ==
X-CSE-MsgGUID: QufR/RJSSOCOz25NV5T3Hg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2361388"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2361388"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:23:12 -0800
X-CSE-ConnectionGUID: 2Udwf8xnSsWiKUtX8wkfnw==
X-CSE-MsgGUID: ZD7A0aG0QPWCv26dj3HGrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6775987"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa010.fm.intel.com with ESMTP; 02 Nov 2026 14:23:10 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jic23@kernel.org,
	andy@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: hid-sensors: fix fractional part for unit exponents -7 and -8
Date: Mon,  2 Nov 2026 14:23:08 -0800
Message-ID: <20261102222309.439895-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.55.0
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

split_micro_fraction() scales the remainder to micro units by
multiplying it by 10^(6 - exp). The unit exponent of a HID field goes
down to -8, so exp can be 7 or 8 here. Then the argument of int_pow()
is negative, which the unsigned parameter turns into a huge power of
ten: 0 modulo 2^64. As a result, the fractional part of a value read
from the hysteresis attributes is always reported as 0.

Divide by 10^(exp - 6) in these two cases. This matches the reverse
conversion in convert_to_vtf_format().

Fixes: 73c6768b710a ("iio: hid-sensors: Common attribute and trigger")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 9e7c26e37880..0e6ea5373434 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -98,7 +98,10 @@ static void split_micro_fraction(unsigned int no, int exp, int *val1, int *val2)
 	int divisor = int_pow(10, exp);
 
 	*val1 = no / divisor;
-	*val2 = no % divisor * int_pow(10, 6 - exp);
+	if (exp > 6)
+		*val2 = no % divisor / int_pow(10, exp - 6);
+	else
+		*val2 = no % divisor * int_pow(10, 6 - exp);
 }
 
 /*
-- 
2.56.0

