Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46B33242D4
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 02:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784083565; cv=none; b=PfOe0OfIT+rik5imiwhClRbEJHhAodwYTlrqDt5cwAE8eozo+uQhW/4u/AaYJUjSOowQr4fCbNdRbrruUiweRb7skZ132dxAQhWKq8ujl9N9EKZiXNi8+pGwzMQGKiQuyvKy5AH/Xl8ybj8/KuEkEIw3yLduJk5VYSjAwjnb0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784083565; c=relaxed/simple;
	bh=qBWp+d31sDbpQRFFUmUORFrYymMGLY+3vymxpjUw2Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foyJEo+Z6jdoxw4t5MOnxXZNKUSRdQ3NAmuEit4vOaoKFZJjpt1maWKu64ZovgUaq/MKiUFK8rJ9/tWfIK1SH4oKDjaWSOAdX3mM3tRVGQ39Nj/8U3RXCUWSyxpGKKkCCZToRGwNlDtHeusz7VSIInw1arwu9tZ0h2w4kZYJnmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcZU8Flw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcZU8Flw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0E9C1F00A3D;
	Wed, 15 Jul 2026 02:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784083564;
	bh=QcFoAwNnOqAH9eJwsewOcSUrVDByx5uiWVDrrJFTE1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KcZU8FlwFJ1rL+4EMeSK2xwRf5sgQgVioLf9U2fIQKwJTj84yAcUqLEsjjJD/JuAz
	 esbIfLM+j6l/JBzNk9oG98Tj1yXC5qJ5hUvIIb4h5T5hoym+6AZ0ZA05IsaIzhAdtH
	 DXqX8rufxnYoQLEI2fv8eS9qfHPHu46NwLo8VyhLPsdgNRhLA7jsm8PZa1M8wKuBXW
	 Q5z/SYkpQ8Kwjnf/LeZdxDJky1Bcwyi//RWHaFroY+FF/I1iRc9w1h+GJSL50vcBFw
	 QeNaYdk0KAAZigPEBWoTVlkpce6v9mj9z5Hgp+9pqR7n8DJhF+NEM0W/VmdFoc+wt+
	 QTpjFD9IGAT+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/6] PCI: Add kerneldoc for pci_resize_resource()
Date: Tue, 14 Jul 2026 22:45:57 -0400
Message-ID: <20260715024559.106836-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715024559.106836-1-sashal@kernel.org>
References: <2026071309-opal-shaking-a4ea@gregkh>
 <20260715024559.106836-1-sashal@kernel.org>
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
index 98d909fa83d4ac..fe627ce40e3ca4 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -427,6 +427,26 @@ void pci_release_resource(struct pci_dev *dev, int resno)
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

