Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D304A480DCF
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059371; cv=none; b=Zu/y/YBT5Uoj2/NzUal332XSOuqkFj1dr3ywIMaG5UuzeJJuQoSwuNzGq0nHaOhrYvM375UzIyeN2nfMS/wsMBXUt28oyWu7f+Ic3AD6+gcKWwbxz20ciUY2Qp/6M8t+RzgdXLLicktpbCe5grw1JMRNVyUKPQGA7Zw0xScb/WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059371; c=relaxed/simple;
	bh=Gog+Llv3jCum092w+3P+E/mGDSL9Cjz5LA6xd1oWjbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mq334kdpMl10K5C4veKw4Ci6gb5rTzHk60W+SGvTkbjAnfYnJYoTDctum0T0lqtEmTKDT+cTn0+XfRN2yqAeif5WFkNzYOOuYOBodzFrgbPcvgiPuXxLg4u2G7yK2y+TS/YIxrbIDPzsmE+KK9khuwkSTrMU8z/dZ49jFvR8hyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuwFBegg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuwFBegg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9091D1F00A3E;
	Tue, 14 Jul 2026 20:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059363;
	bh=z8Zp3khKuE26jzeR4y5orXUV2UiXrwtdSf/CKGFeqP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JuwFBeggyGw0ZDd7MIpE3wXCeGblUN8fRRdrqaGUD81VW4KDzUCn0LzkNM/RH9liW
	 TeZ4xJbC8VV9x49aHkyJ9elNHawZtVN8YkUg4EiIyefCUVyGOMb0DS0hkx70TJjguG
	 z54R/3izPU78n4Z9pwDuZo7wA8kSJtqeoYrRMJZzPKx3eDhavSyOo9/x50h65B/FdZ
	 J1nFGTFshBeHXBvZqsjtQr0CllmIkHpAMN/0JPFUIDESyucum7yZFCVeRSSnkrEapy
	 P9OJ0JGJPPTZS7n0nMCczBzTKmCOvmlsub0s1ckX8/4cWWD3j84BEMB1UxdHrEmwZ0
	 NI6cQL5GQQ6eg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 6/8] PCI: Add kerneldoc for pci_resize_resource()
Date: Tue, 14 Jul 2026 16:02:34 -0400
Message-ID: <20260714200236.3153778-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714200236.3153778-1-sashal@kernel.org>
References: <2026071350-unfold-lather-d66a@gregkh>
 <20260714200236.3153778-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit d787018e2dfdc4c1331538e7a8717690d1b7c9b3 ]

As pci_resize_resource() is meant to be used also outside of PCI core,
document the interface with kerneldoc.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org> # AVA, AMD GPU
Link: https://patch.msgid.link/20251113162628.5946-8-ilpo.jarvinen@linux.intel.com
Stable-dep-of: ee7471fe968d ("PCI: Skip Resizable BAR restore on read error")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/setup-res.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 25a64358feea96..92a5af115cd63f 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -457,6 +457,26 @@ void pci_resize_resource_set_size(struct pci_dev *dev, int resno, int size)
 	resource_set_size(res, res_size);
 }
 
+/**
+ * pci_resize_resource - reconfigure a Resizable BAR and resources
+ * @dev: the PCI device
+ * @resno: index of the BAR to be resized
+ * @size: new size as defined in the spec (0=1MB, 31=128TB)
+ * @exclude_bars: a mask of BARs that should not be released
+ *
+ * Reconfigure @resno to @size and re-run resource assignment algorithm
+ * with the new size.
+ *
+ * Prior to resize, release @dev resources that share a bridge window with
+ * @resno.  This unpins the bridge window resource to allow changing it.
+ *
+ * The caller may prevent releasing a particular BAR by providing
+ * @exclude_bars mask, but this may result in the resize operation failing
+ * due to insufficient space.
+ *
+ * Return: 0 on success, or negative on error. In case of an error, the
+ *         resources are restored to their original places.
+ */
 int pci_resize_resource(struct pci_dev *dev, int resno, int size,
 			int exclude_bars)
 {
-- 
2.53.0

