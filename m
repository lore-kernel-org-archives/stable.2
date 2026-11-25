Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648207;
	b=rrMA4AWWzCTPPR+zd5ImeEpztFdlKXWjIf4M8NpLHhZFqgswkYxLDDb2nSSTnr4s8fyF
	 EV5kedkiGairaKNJXE7BfGioue3GH2CPMkMJ1JP/QdD7sLdJkjSdqLfk9icsqEvGWWdCz
	 1OJD2aH2acu3D6OY6Mb6tv6FP9f7+tvnhy3v9xEy/hErpl7BKgMSfr5aeHq6QY2cZtZME
	 hbtjpAUXEmuXFOYTatBdoJrvSJAWMyVUTL/pBfqnlDYb/uBmKbOVITJFuX2wovuVmjFZU
	 8rUfU74zCAvUK7GSw15eGBdlPZkZ9elNMaiNFndelfvMUHR11mcsmz1t0GznNHeucHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648207;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=4YzMCKbk1cYbKbWntsU/48LDpJeK2LIKRm0a3SbPemw=;
	b=AexPwF6EnrWTfBBGEdb0QQGM6QILRO5BQVQiXndkjzxaozTzYoR7pl+GhL6ULPQ18gso
	 T/UxQvka+4iC4eeuFL5E0Vta4uvGZlKe+wK7AKElfqmZfGPiZeLn/qjVx1b7sGbrVJY4K
	 1SWppp7PEddq1WiThYU6PAp6UNZZkg1EIQOvIZvwFnLYGVwWwKtQjXe15KxUuCtQGG7TL
	 KzHxpc8Hrg5KUr0Vgr8ItXwA+dWan+tkKSW+u/Xs1abGxkn1rDrk/15Kx6jUlgki7jpIi
	 mcOORQwNOnUv0HRjgbAhhAi96Xx69r6vYeIi1CQWDhd7vxnP4UUAbFlOHhNZdbpfrPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q1RGcxx9;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CF8606A31E;
	Wed, 25 Nov 2026 23:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60CF8606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Q1RGcxx9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648207; x=1827184207;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cz+sDZ9qDfvxJjsd0/fLKyYqYPzsuCkjZP6s/wo8egU=;
  b=Q1RGcxx998wcahhsNtmTk0EdTAZPLmYkkK6+bmPPv5YYAfYFmv/CFvep
   HDEM8rVDVZ32zTCzZ+pKbj9P9u2Q6MgS56cONVK2FtZY1Eg5lLwLrUlkL
   Lp59O7nFX9bxtJwY3v88GdTLgH4z6kd0/29/NEnJP+o0DXBSaaG85cCQd
   i3J8DRECI2XqhQJlnLUvDOGKoOzb0ADAJwOnpXi1CvEDeU9u5jc0wz3yX
   R5nJ6oHqEU4YKyuKjVzGqhR6fj6M/KYQgXdmuKBJEuiJ05gtfng43oGGp
   ONeOqonJePQwLN0gcIR5ctXgH2pWWnExX7ScW5OecSXPdn4hS/QmDh8LZ
   g==;
X-CSE-ConnectionGUID: bWGmoPLLQeuhdv8TwMudsQ==
X-CSE-MsgGUID: f3FFJmV1RY2MHtxj+Pz/8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4537917"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4537917"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:10:06 -0800
X-CSE-ConnectionGUID: MapZj/8LRNqNTkxJ5pL8KA==
X-CSE-MsgGUID: eG68Sv4NRoysG2SIGwqU5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11866141"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:10:01 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	David Matlack <dmatlack@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 02/17] alpha/PCI: Convert to pci_bus_size_and_assign_resources()
Date: Thu, 26 Nov 2026 01:09:01 +0200
Message-ID: <20261125230925.2441-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
References: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
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

To serialize bridge window sizing and resource assignment, PCI core
needs to hold locks across both phases. Alpha nautilus PCI code calls
pci_bus_size_bridges() and pci_bus_assign_resources() separately
because it needs to do special resource alignment and setup after the
window sizes have been calculated. At least the former would seem to
belong to some existing __weak pcibios_*() hook but the latter might
need yet another pcibios_*() hook just for this single use.

The nautilus code runs during init, so nothing is likely to race with
it. Converting it is mainly about consolidating the sizing and
assignment entrypoints of PCI core, which eventually allows removing
pci_bus_assign_resources().

Instead of trying to do a complex rework of the code, which is risky
without the ability to test on the hardware, simply convert
pci_bus_assign_resources() to pci_bus_size_and_assign_resources(). This
adds a small bit of extra work by performing the sizing step again. The
Irongate PCI memory window is a host bridge window and not a device
resource, so the resource assignment algorithm does not move or release
it, and sizing does not change it either once it has been registered.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Acked-by: Magnus Lindholm <linmag7@gmail.com>
Cc: stable@vger.kernel.org
---
 arch/alpha/kernel/sys_nautilus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/sys_nautilus.c b/arch/alpha/kernel/sys_nautilus.c
index 13b79960b4b9..23a74fd4a83f 100644
--- a/arch/alpha/kernel/sys_nautilus.c
+++ b/arch/alpha/kernel/sys_nautilus.c
@@ -263,7 +263,7 @@ nautilus_init_pci(void)
 	if ((IRONGATE0->dev_vendor >> 16) > 0x7006)	/* Albacore? */
 		IRONGATE0->pci_mem = pci_mem;
 
-	pci_bus_assign_resources(bus);
+	pci_bus_size_and_assign_resources(bus);
 	pci_bus_add_devices(bus);
 }
 
-- 
2.47.3

