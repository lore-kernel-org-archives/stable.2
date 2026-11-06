Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972676;
	b=Rm+KAfwkERAVpnV+kNqPM5ryESfWLW7AzZSvm0ggzyJVfN7UcGI3vEdlZmPF6fh88U9S
	 OvJOQmdjv3aITZM2M53kqlGZMX+YQm4VPq0erpLiVHJRd8yhPVMlKSi2HonxClWKUi8jn
	 A4faupXNXKT4JalYzIk0MB7I8NK23Ni/H/jtf4vPeUVHp1sO6ltftgMqZk3tTUOe30ryh
	 aWJFFovsiNbC+JJtvrLFxY6AnFI5NO/Nd99D4s70Z3dDGC4uNQ2esLGI1X4uG1AFOSfT4
	 3eyxnrYw5Tq2LP4oNO5nuSoQAJxcefV9xahBmbGLG8SjYPZm9uuRwOJtelIb33TetrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972676;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=SqVG4ZAeLlMvPLPBfve3R0HMnPP7/lEjpVLFceWTjMY=;
	b=GttQzTqOxtCZIZcQoS9oAeBwuYjRgy5czzxTu9tOYEqnzP4wN5boebD+rgdBMZGmR5CB
	 P0gjPTaueqmYGQKVVYl2hvDDn0HQQYrAXfdkUP1olylABB9SNfUmRgHR7Z0Dwuh6g32AB
	 XZtnuXS2rc6SKRvTvOIPGhoH5DjpqesZRYZvxvuzeeCiSgLNICgaKJEeE8rNpc6jq7F1h
	 Mu825H0sEtZrv3LcInZTwpIerSxV2bMUlSYV72sBD20tRujDCZSk5hAnsjedqk9xu4glj
	 XjsqCpfACmVEZq+51iXBooTOuKuKTs8VCMZW1Vx2RP4hRkllG74vWYbWtoIIcQdU1ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cZIMoOKw;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A731D606A326;
	Fri,  6 Nov 2026 13:44:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A731D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cZIMoOKw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793972675; x=1825508675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nF9wezEP1NFe9viI53rw8/eVMQYComRtS+ha2hgptd0=;
  b=cZIMoOKwjfPaxLjgu6v6nZrTUKHWpV6MRIhbByVZcAqEySPplA2nIxlP
   s4WO7bSSasOS5PulSWNvWorzUwya2L/ez3N4egnIwrXsBedm4o/IcQ2zo
   FHIgsVE6eDTxQMoXGN7SZzSCQIxNPrnGxtPk8kzsbVK40Crn6ywZj1cvN
   9hxbmrlrLW55HednFYvgxipon18YIeNYIFrjysreeGFNZDLhxL30d4Vat
   oFLuLfo7b54wUtC2kzyahUJUi9fkO+K6U+ZsfWY5iK3sLQUu4lkmOfzqp
   K68G+4je2aR2grsKNLwaQiXxzjxlIl6gMFdC0huyV1snzj4PqjiikbjZk
   g==;
X-CSE-ConnectionGUID: MNp1rMWfRHmYyWXuDKSQUA==
X-CSE-MsgGUID: Kq3qRL7aSuytmXCBDlFyYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2686071"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2686071"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:44:35 -0800
X-CSE-ConnectionGUID: c2zLsm59QTOu9mLg8846rg==
X-CSE-MsgGUID: n6Sv0LQSQvCPVg6nH2GZSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7327641"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:44:31 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Maciej Grochowski <Maciej.Grochowski@sony.com>,
	Geramy Loveless <gloveless@jqluv.com>,
	Eric Auger <eauger@redhat.com>,
	Alexey Fomenko <alexey.fomenko@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Mesih Kilinc <Mesih.Kilinc@sony.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v5 04/14] PCI: Use __ffs64() for resource_size_t typed align
Date: Fri,  6 Nov 2026 15:43:25 +0200
Message-ID: <20261106134341.39493-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
References: <20261106134341.39493-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__ffs() inputs unsigned long. With some 32-bit configurations
resource_size_t can be 64 bits wide while unsigned long is only 32 bits
wide.

To prevent value truncation, convert __ffs() to __ffs64() when the
input is resource_size_t.

In practice >=4GB resource align is required for the problem to
manifest itself which might not be present on systems running 32-bit
kernels so the problem has not been noticed.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 0c27cec83c0d..f4358322f766 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1315,7 +1315,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 			 * keep "order" from being negative for smaller
 			 * resources.
 			 */
-			order = max_t(int, __ffs(align) - __ffs(SZ_1M), 0);
+			order = max_t(int, __ffs64(align) - __ffs(SZ_1M), 0);
 			if (order >= ARRAY_SIZE(aligns)) {
 				pci_warn(dev, "%s %pR: disabling; bad alignment %#llx\n",
 					 r_name, r, (unsigned long long) align);
-- 
2.47.3

