Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7123AE6E6
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133150; cv=none; b=N5zd3cIfwGY896o0YyanTS5Fb59me7OlVHrcDaJo/0VjgsojmfS+z6lxcGLJo9q2mixg/f6TY5asxkfUY/QgMgArnlnqANis9IoaTewwBQz0hlHnLro86uBmvqH4UJeQsklk7UpbVZOnvE3x3LhinymTif9FfHWV/YYKlyUg23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133150; c=relaxed/simple;
	bh=cVLqm49OVUnlyTOiFyiMpK7BklkguM3f9/DMUEvc9MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ScdlNahlTKVRUXDZ3PphYKuUigYWo+sqZG6uEbjqmco6rhGNQmHLsLxzQ3Q9FCOl4BQx+Y6JH0JhVsYEhihaHGdC4FocG51GyD9DXgjO7nhShNmFQ+YEsgAmFeZQ0igCkO/sAj+jGvPTStpY/zKnKp4y6rDH9W4NGgh+QlNFS8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrN/nZ7u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrN/nZ7u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DA51F000E9;
	Wed, 15 Jul 2026 16:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784133148;
	bh=y+9Gybg0clEhzNsBRpzoK0MBhAQIDoHQkN0//Ezgc7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HrN/nZ7uG/Ns9r4MVjntFUW9yuEvh9UD56Coib5beeHPuSribP5zHaPfs7uLIg0L1
	 Q4o441WY9O6Yvkp/4caj1EUcMlwneycxh7tyYFIiwXvan5zN+RuF7Jh9GNvoONbi6+
	 3u2l0xFLLueKKJZ3pR7JhRv65f2Tnz5CkWz+5H1KqaQ5ZsBSRigoAhyzF1OuNHkVXO
	 EUemHJmydJ/0U/Xj+2lbywzxWfcu+oV1E8cPmchwicpFhh2pJccxOmAhbC83plZ2Bt
	 MCVRJuHSj7UtBW3kGxn17+xTqacbhVKLsaZrzkzg1+1tXXSRH552LlzWiwD1vDCaee
	 evk/C1ajjwYNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/6] PCI: Add kerneldoc for pci_resize_resource()
Date: Wed, 15 Jul 2026 12:32:21 -0400
Message-ID: <20260715163223.952417-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715163223.952417-1-sashal@kernel.org>
References: <2026071318-kettle-cringe-5d1a@gregkh>
 <20260715163223.952417-1-sashal@kernel.org>
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
index 9561365c95b37f..aa66e85a3a4715 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -422,6 +422,26 @@ void pci_release_resource(struct pci_dev *dev, int resno)
 }
 EXPORT_SYMBOL(pci_release_resource);
 
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

