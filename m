Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793811204;
	b=aGgWlTeP5Wo6PpgUrWVbWw6WwxAE18uzt9EMqxKjYQLWK7/Otdmg3s/vrWy2ygM2ixVJ
	 WSBw41/PaB43qwmhEL8T9ZlxKtyKQ5qxjnN1Cgh8xzCz5UZIn8R1mn1c9iU/CW9SsD8Iy
	 eDi7chsIvMKTsz++3Md4OWHQ57D0W33htSOgWY3qEa/GNvAXvwRq4uuLQIbLS6vO1MzLN
	 nQngXTZ/d1WR8ePhvD/RLhRlUsSTbA4HZBzYA5S9K3FqmonYhjIhOgMTH5i0VefYEWXof
	 0t9I+IDqCjeaJYtDKclzxpWTk3ej0Ibae/LJS1KxZMmn/5hnbkYMQyeUpWCGqKYVXIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793811204;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=UQ1bDXYKGYdl2Og2jD+uXrW+t00qIxcQlDDGCIWN6fs=;
	b=S1KYZiUkTH7XaL356A0H5vH1YWriWbh+6BjviZosrIFuCTZJb9AMYnUkoMrtL89tYSPI
	 p68u/Z6XHtgVX77TifxLK2eb63fRWTgSPWogi0zSfB/sEWjJJsXS+W5HtBJy3YnFOMtL5
	 qJ6/4KIopg7rIaT4MJVW+Eyf24FWG5wrs71dD6pNsiqrxOKb1kOtTedNOSfFs1MMhHh81
	 zMWuSBzeTo7ZKJ5pzNsrX5hD72QjoF8oKG5vOEy/N/DW+HlAbrwmtjQ99mvsS6IU6VRDm
	 MoCEqREhWzxPrwegcf1xSe+cR0CWUxQn1ZGw9xYwAA4QSSjz1exZImF2/cNu7zTwZ8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NfMVOP+W;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE94C606D83E;
	Wed,  4 Nov 2026 16:53:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE94C606D83E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NfMVOP+W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793811203; x=1825347203;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=d/n2sCxEobfdrct2quWj6oFiwwBQ5P4rZozc4rIP7Xg=;
  b=NfMVOP+WDrBJ7nmgbpQG5+3XcEqQ2mdGTwV0zfV8E8NFqwTuT+55sZOi
   6DS1AeqcZUhNzUdvhMWdvc5Pw6U9Uk5bjuINrQtSjY86EPHHKTbAzVs10
   YRyPP50OT/Tt+FEDJetAzd00RSQopW6hENKVMm9gKcfPt8YOwytin1+eu
   BAte0R2fgd15ffuubGW9njyokpBO+rgQOjPovNAVC+G/SyFB+Ah5hJ784
   SBqx/ClK0M8rfAO/lf48+ijxtSd2BSdrHm5XTlYXYkOVTydV6bp0WzaJX
   AmEhKWI2LgAI1r011dxO8u/Em9TUOB6LrpIdY98IIm7SeEBEAl5B+Etkx
   w==;
X-CSE-ConnectionGUID: 5L10r3jAR5S44wbh4OdvFw==
X-CSE-MsgGUID: oWvfOwmCThaqEtMzB22AVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2570439"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2570439"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2026 08:53:23 -0800
X-CSE-ConnectionGUID: NDo/dX6MRd6MKYnEtEiXrQ==
X-CSE-MsgGUID: VEuzpK/CSRGIwueXMXEulg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7087603"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa008.fm.intel.com with ESMTP; 04 Nov 2026 08:53:23 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	bentiss@kernel.org
Cc: linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	simeon@maryasin.name,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: hid-sensors: fix fractional part for unit exponents -7 and -8
Date: Wed,  4 Nov 2026 08:53:19 -0800
Message-ID: <20261104165319.1890851-1-srinivas.pandruvada@linux.intel.com>
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
v2:
- Fix __udivdi3 link error on 32-bit by using a 32-bit divisor
- Address Andy's comment:
Keep no % divisor in a temporary variable next to no / divisor

 drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
index 9e7c26e37880..d44091faf122 100644
--- a/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
+++ b/drivers/iio/common/hid-sensors/hid-sensor-attributes.c
@@ -96,9 +96,14 @@ static void simple_div(int dividend, int divisor, int *whole, int *micro_frac)
 static void split_micro_fraction(unsigned int no, int exp, int *val1, int *val2)
 {
 	int divisor = int_pow(10, exp);
+	unsigned int rem;
 
 	*val1 = no / divisor;
-	*val2 = no % divisor * int_pow(10, 6 - exp);
+	rem = no % divisor;
+	if (exp > 6)
+		*val2 = rem / (unsigned int)int_pow(10, exp - 6);
+	else
+		*val2 = rem * int_pow(10, 6 - exp);
 }
 
 /*
-- 
2.56.0

