Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182476;
	b=NN8KtWvQ1djWc1lfRhdS9+iRpDiiuuUbSmyL2OIbN/JDEDnGPguu1mTZgovuj1PStm84
	 audS7QWgfwZJ67zbLx4uthR0yYVrNXlkAsAkeDBTkUSaSQ/OQ29KhkbPsKrFDy57YYx08
	 7Ny+UcZccg7enyQrWk+TpId+iCju4AhUZa/JgppfUXIZ5Cc8g53cK+aE2bdowT3iK2woy
	 6DZcB0FNa8mc347lQXpJfMNFrDXZmCNGym8oH6NRp8Kpml4Z5nGSmKLkXjy1T7Uwa8+Kl
	 gIrSTB/Tp64/PoBbGRCJXbptJd2eRu1vZuAIgVeJh5/g8kM1PNr+2rJifL2rP1Yl4Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182476;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=4YzMCKbk1cYbKbWntsU/48LDpJeK2LIKRm0a3SbPemw=;
	b=rFjCsHm5I3Iirtsbi9fgFxv2JebzxIXIKsDnO7oDJK6W8EdCBGlLgP1h7P6RRC7jEW8l
	 t4oqwf7AGbDqiu90onxHBOPDJeNfdHgBD6LyCnD7GRd2Yr7SIW4PN0yQqWF8LPKsTP+1a
	 clcd4xZKAiwYfWOh6J2GuT2Nw6MkArURvzglbmKnDdrMS4cUS7Y9aK6pQXOnH6wqjL44g
	 5/Zw5KVzN68qShfBbDBAvCKsWDmZrCbwWeRNRYxFL2DGtVALUD+KiHTEceuHZk+Cd0Aqq
	 GEdaOw3B6ITi4WNdsYhEwdiEHzoKhtUlH4utQzClTL8+i/trEHpCTH5gCNb2UY67kvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UXIXT++8;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B5606A320;
	Fri, 20 Nov 2026 13:47:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD4B5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UXIXT++8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795182476; x=1826718476;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cz+sDZ9qDfvxJjsd0/fLKyYqYPzsuCkjZP6s/wo8egU=;
  b=UXIXT++8hTMX+kwkry1w7MEQfPMQfLM9PIse+86XsniwWyUdbPZTRhgA
   51SSVDGQvhueXpeds4Z3/nU9PiP9DcNDYCv+SSPKs4SZPSzAjn6iSepSJ
   IBZZglIpuCv04hWt1anDWPIIgH/N+/Joy+XOYpoANSfEtP31ZO/EykHiq
   7r1BLbB//13aPDcQibBfEHjeQ6lEz8jZnUaIcotg4Hpy5w4Gja9uaUq2B
   dHQStIHvI3GXi+IxsKcmwm1CJkqjGBnO4f9RLNuuQ6ayKrcNA+swLHkK2
   OnNZX5VZ8a9VLu/0XzbS91liDGJdiuUIt/TBkHy49wlvqxq8BMHF0uLR1
   g==;
X-CSE-ConnectionGUID: k/d/5MhRQNi47zPwIM5MVQ==
X-CSE-MsgGUID: nrp59SXWSMGBLi9IWjvrMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3955099"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3955099"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:47:56 -0800
X-CSE-ConnectionGUID: UZuhm2T4SBSahwZbmdPwdA==
X-CSE-MsgGUID: z8rfypk+S9WSnco4O4amBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10971316"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:47:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 02/16] alpha/PCI: Convert to pci_bus_size_and_assign_resources()
Date: Fri, 20 Nov 2026 15:46:57 +0200
Message-ID: <20261120134716.3027-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
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

