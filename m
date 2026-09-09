Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5490B388E74
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 19:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788980494; cv=none; b=sPhFI3SxEzex+4fed+FnZ1sFe586zP7ph3fKwlZIY5B43hp/SBRhmd/KNnp7E91kPFBrhdIRh2R16RESM9TEdD927pEDa9iBZqKMTw/uyxJkJ/YCwdCg5U4G4ycfbMAH56Gm/33Mxph4Ps5GHzYcYsdFycgAYp5F2lwWByot8cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788980494; c=relaxed/simple;
	bh=mYOCicJS49q+Xj+7H+2M4vFBn0fsGAsI+PbBWgMB9Xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fyk2qMRMKnYakKuqkP7VxwxHk7R5t2/bg7F67RvhyFOLCHtx9vm5SDPwjzvkmOVAp7O1DUelTHZUKgXOiSu5BHLJRqvNOGelWaGKjm/szGOwb9vU5/tJfYQigFldiq/iBvLOj4rbODJwPBHlx3ssNwIlLvTSOAG4luLs/TsLAfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAL2TPOM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAL2TPOM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40EF01F00893;
	Wed,  9 Sep 2026 19:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788980493;
	bh=onSZa23ge087mys+z1Ue5vQlVUfkumnwSxJuiqEmry0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bAL2TPOMzmiyT3Gu+TRo2X47727/cF9VKnptqKba0Cm02gxHKN6YPpXAiAF4hy8KK
	 G4OKeNu2wXGiNIEMI3blvbRf0akRufYtfjt2Mgq2SJJY/05Zi71IFMzTi7M1AJEbjN
	 yVaWCOM3ze69Jn5RE3rJ4r9WYHvFn2IWsqXoU+F3JBJVF3wsTmbOcDE1mzH2MYP4RD
	 NIGjezdlSm8vanoA4bXrpg5hfV1nceYGfNL9uNaHs2GrwIMKpIgV7jx6n6MYyyc52m
	 0U3jKTRL3b5anheeT+j004U69hDfPEHTD4kj7GXd4FaMA1Kl+1/vFmIBYtkzGWLuyX
	 eEHnDi7ki5wJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] PCI/AER: Update statistics before ratelimiting
Date: Wed,  9 Sep 2026 15:01:26 -0400
Message-ID: <20260909190129.3511451-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909190129.3511451-1-sashal@kernel.org>
References: <2026090327-figurine-worst-aeee@gregkh>
 <20260909190129.3511451-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

[ Upstream commit 88a7765e62b9e4c79c7ca2c7b749ae04f54a5668 ]

There are two AER logging entry points:

  - aer_print_error() is used by DPC (dpc_process_error()) and native AER
    handling (aer_process_err_devices()).

  - pci_print_aer() is used by GHES (aer_recover_work_func()) and CXL
    (cxl_handle_rdport_errors())

Both use __aer_print_error() to print the AER error bits.  Previously
__aer_print_error() also incremented the AER statistics via
pci_dev_aer_stats_incr().

Call pci_dev_aer_stats_incr() early in the entry points instead of in
__aer_print_error() so we update the statistics even if the actual printing
of error bits is rate limited by a future change.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Link: https://patch.msgid.link/20250522232339.1525671-11-helgaas@kernel.org
Stable-dep-of: a8bf2dd750de ("PCI/AER: Emit TLP Log only for unmasked errors")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/pcie/aer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 3ab7d97fc8966..097686c204488 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -700,7 +700,6 @@ static void __aer_print_error(struct pci_dev *dev,
 		pci_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
 				info->first_error == i ? " (First)" : "");
 	}
-	pci_dev_aer_stats_incr(dev, info);
 }
 
 void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
@@ -709,6 +708,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
 	int id = ((dev->bus->number << 8) | dev->devfn);
 	const char *level;
 
+	pci_dev_aer_stats_incr(dev, info);
+
 	if (!info->status) {
 		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
 			aer_error_severity_string[info->severity]);
@@ -788,6 +789,8 @@ void cper_print_aer(struct pci_dev *dev, int aer_severity,
 	info.status = status;
 	info.mask = mask;
 
+	pci_dev_aer_stats_incr(dev, &info);
+
 	layer = AER_GET_LAYER_ERROR(aer_severity, status);
 	agent = AER_GET_AGENT(aer_severity, status);
 
-- 
2.53.0

