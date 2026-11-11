Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794439115;
	b=efIgu+BrzGYEFMeWAGRkcSropsAvvKofhNVUupYuWrPgKLy2N3qNHufzJ4b8czxar748
	 6mism/GepW5r3CxVsAq9h1/NQTxUza5oEm3b1owmA1Iof2Ayb07t37hC4OYbIAgLNkX8h
	 JiNsMqFJgkQeKkKTSTrR+87CrLKp34Ql5r8mowXTignBrn9HUoH35qx/Qv7qsJP13IAA4
	 MwDnvFHKj8TsYPLVtoB+5b3UmTl0Km5SZ/He1ZtTDEKDCa0OlpXey1PDoypFVjzhgceEI
	 pksFDB1RqjS7iOaDQ0Oh//Egk/xtFUwPswxI1Q36YbY4IgRQv8BoG9M3OT7376McEew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794439115;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=crtwROz52pGFHoGHkH8tO1tzRG48ER3yvRfjc6liNNk=;
	b=Ic3dy4ZJUyJC/44OicYD8N7AgHmUbY/h9meQtUzbHLoCIF4TVcKtMmLgIJjLSl3OE1vr
	 4c7hoqfVs3wBddISYVwMScbYLH2kB7XAQ2p3iVCbr2NReOxjtDsBFyeT9j6FM0BsQzF9h
	 oq7hKiwk5WgS9PtkOW1FqyxyF6lOfSEUfq8Q62vMQ1VIvvEkehye3NIb6n2mDsmXxxYhW
	 oFYc5rwm66PXJplym0Twmg+W8gJTsVRq45mTvrVXRMJg6XpxrqsCOOAFTuH34vn6xwkkm
	 ZqKJvpRrLSXIWmN9nPzy33Jm/nXZQugq9Spx/jwS7HTruxJr6hvknsa5TAoIzs/AsQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UbGoFeEW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95213606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UbGoFeEW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B1F1F00A06;
	Wed, 11 Nov 2026 23:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794439115;
	bh=crtwROz52pGFHoGHkH8tO1tzRG48ER3yvRfjc6liNNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UbGoFeEWO/JT4FjOn67FvlEPBBtnMmjRRNRUkTVthKUh6h/08kqO4FqEwkn/LP9Rf
	 KaYilxz28iPRQWQU4qflWEijrPCyMP2KF7qV30MVWhM1e0e7Ljm3RvydvGSjmOg2mP
	 KljA8xG/rNuSOkocM39TlOvFsaFTxAljIY0SSHE/cIhKl0dnvmV978squ7xamXA78M
	 czUF5u/NBqTukxkGdsRdvbwxg9gOjb6at3a1ACTFAW5/TSL8ph1EDcH3jfZ2GEQDSs
	 EQYxmb6lX9GcQ4GOdva85Wiq3nadE2MjSpnyVuadcF+XWlW6eXcosCQvMsEYHh350A
	 rQtCWqhQg9JOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guixin Liu <kanie@linux.alibaba.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] cxl/pci: Use the Device GPF DVSEC for restricted endpoints
Date: Wed, 11 Nov 2026 18:18:33 -0500
Message-ID: <20261111231816.391123-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051002-failed-6.18-d2654fa0d841@kernel.org>
References: <20261107051002-failed-6.18-d2654fa0d841@kernel.org>
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

From: Guixin Liu <kanie@linux.alibaba.com>

[ Upstream commit d2654fa0d841fa36ffa76577f83a2810d643ae19 ]

cxl_gpf_get_dvsec() picks between the Port and the Device GPF DVSEC
from the PCIe type of the given device, and only a plain endpoint
counts as a device. A restricted CXL device is an endpoint too, but
it falls into the port case and is probed for the Port GPF DVSEC
instead of the Device GPF DVSEC.

On an RCD, dirty shutdown tracking therefore never arms: the DVSEC
lookup in cxl_nvdimm_arm_dirty_shutdown_tracking() fails, the dirty
shutdown count stays invalid, and the warning complains about a
missing Port GPF DVSEC on a device.

Treat restricted endpoints as devices.

Fixes: 36aace15d9bd ("cxl/pci: Drop the parameter is_port of cxl_gpf_get_dvsec()")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Link: https://patch.msgid.link/20261008034619.28059-2-kanie@linux.alibaba.com
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
[ sashal: Replaced the unavailable is_cxl_restricted() helper call with the equivalent pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END comparison. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/core/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 48c1f3854b799..d2ee7d853f1fd 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -819,7 +819,8 @@ u16 cxl_gpf_get_dvsec(struct device *dev)
 		return 0;
 
 	pdev = to_pci_dev(dev);
-	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT)
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT ||
+	    pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END)
 		is_port = false;
 
 	dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
-- 
2.53.0

