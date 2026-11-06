Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793972684;
	b=lXnjhgXAwg77K2pg0aIRK4YDH4QFXPdfwC2K5+4QrDvIDB7se7vo1Xatuqceffa/24C+
	 /pbOiqQGyDSPYase+pMEoIS6iYHdSAPsIsk2dninA42YTYHsCDeuhUPg4uf/GvQOmQmxv
	 ZyaFUgEMxduE3icfhd9K2BIZDjjOEsCbZXBOogiWPUvQPUKMgNVwB56F7Td4ahLVm/e3x
	 PgQd4tRDzL77igVzZMDjok9WN4uUSR30Zfy6G2rBkz8f4MyKJkHFpO+qmhkJ9ez1N44SL
	 Fzb5yfUekdc3Slm3eaWT3jW11W5aSe3F+c8JPKhLTSJ8H+XDChSI5NBv11bXSWWvkaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972684;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=3aiWoJyoj47vxzUtInABSlrx48HXt8yxdTO+XR8WueA=;
	b=oXvK37PnEwsYDnTFYwgOQqBbnzTLrP3CwxC1Mhz4XSUUC5LjBUlwQNL5oL9ZUfuzMQey
	 BRae9PRvQGfpYi3nXwDcr9LNXfddj7o0mkn7dl5Slq8hittNFlN1keUbvSFQm5eQ5bIN5
	 7kbWXgYVAakPHSf6fKCdac8SQ7FvV2JyT9RDkeyEJwK2tVDsze2ffCIk5Q+BnzNIJ7W9e
	 WuRdWH8XKxcmN1gqSRD1CEUF01C7AVIX14+OoLaYOF8eOvplhKekWhTFcPG0xMPUJVL5t
	 /PhcuVoBAK/n3xS5qR3v/PXrgCHSs3R2ScxU0Fb9jvLSdbLwChxOPWyipWf3aCMql5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lmNtehmK;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CC4606EE92;
	Fri,  6 Nov 2026 13:44:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2CC4606EE92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lmNtehmK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793972684; x=1825508684;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x7BvifrTv8VEW0FbDwYC1KCgZFCRCkTZa/DG9DMNxHE=;
  b=lmNtehmKrvj+rROtmR5+eiboVqfEIXCfo/EAAsMdH3ugadhvvJ2eg6ly
   7BOYIZ7vybpY8Wka8cA8HEUHSoJL4R+obdR2d+eMFnPjBWCCFd7WLnJNO
   8DlMeR0IK/VD5dyKHObDTqBj0Pq1Y8sxLNamJPZOpnvwB1daZpwGFbUkf
   TNqogMuVnRzvoAREjbhPZKHJSTtWW/L9+czZwtwg779BcklJXudMV5Gxd
   wg6e9AWpIfSiaWXAbhwmuS6SB59/d3jfQhCcz2DIdve3qxAwr9AZvbGz2
   HMZgtMt+NBPpkj289uzuRPeA8AFXqVC8B8+084JFsSjfkTrUtEX56jU+W
   g==;
X-CSE-ConnectionGUID: dEUVGwjyQsevG705ETkmrg==
X-CSE-MsgGUID: 4XS/UDJbQ7uz2Dk/pNEOtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2686087"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2686087"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:44:43 -0800
X-CSE-ConnectionGUID: pcQsxNrrSKC8kpQOIT6RIg==
X-CSE-MsgGUID: KgxtFAYISdOBo4eUwBi49A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7327654"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.104])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 05:44:39 -0800
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
Subject: [PATCH v5 05/14] PCI: Prevent zero align from reaching __ffs64()
Date: Fri,  6 Nov 2026 15:43:26 +0200
Message-ID: <20261106134341.39493-6-ilpo.jarvinen@linux.intel.com>
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

The bridge window sizing algorithm calculates order from alignment
using __ffs64(). __ffs*() is undefined for zero input.

pci_resource_alignment() & resource_alignment() have a number potential
ways ways to return 0, in fact, resource_alignment() intentionally does
that if neither SIZEALIGN nor STARTALIGN is set.

Thus, ensure zero align is always properly dealt with in
pbus_size_mem(). pdev_sort_resources() already has a similar check for
values returned from pci_resource_alignment() (though it is not using
__ffs*()).

Cc: stable@vger.kernel.org
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index f4358322f766..9d167e7773a1 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1309,6 +1309,8 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 				continue;
 
 			align = pci_resource_alignment(dev, r);
+			if (!align)
+				goto bad_alignment;
 			/*
 			 * aligns[0] is for 1MB (since bridge memory
 			 * windows are always at least 1MB aligned), so
@@ -1317,6 +1319,7 @@ static void pbus_size_mem(struct pci_bus *bus, struct resource *b_res,
 			 */
 			order = max_t(int, __ffs64(align) - __ffs(SZ_1M), 0);
 			if (order >= ARRAY_SIZE(aligns)) {
+bad_alignment:
 				pci_warn(dev, "%s %pR: disabling; bad alignment %#llx\n",
 					 r_name, r, (unsigned long long) align);
 				r->flags = 0;
-- 
2.47.3

