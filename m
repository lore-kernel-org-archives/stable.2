Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D92C9D
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074682; cv=none; b=g/GTo3BDL4lmPwsjO6wZdr6kx3kmAvcQlRnvObpOD7RmnsWpgpkQx6dGM8A7caYxVJ1e7Yr75c5HG+4v3puz7wfn/a6IPU/D0lOd2HFGnLn9roLk84uunfyxyXhEBqDzUa0h+MHAMVe7oi7DVWjDpQgA+x1XeV06dpTcfXPjd2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074682; c=relaxed/simple;
	bh=qBWp+d31sDbpQRFFUmUORFrYymMGLY+3vymxpjUw2Ek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5R8j/t4bt6AhllNWoGsKuEdiox5qSxwof7TwhUxTe6YFaGoWc7iy5V28niy3nu4o9pcXhFA5n7T01nvn6OIRidWWO7BcXr2R5FcP1pMOXrE3U0xgrupzYwo60f6V3J2NSzTuOl3jvzuX2QMmNLabMcGY1QATkHPN+qYlmLb1Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jycrWBMJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jycrWBMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C99A1F00A3A;
	Wed, 15 Jul 2026 00:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074680;
	bh=QcFoAwNnOqAH9eJwsewOcSUrVDByx5uiWVDrrJFTE1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jycrWBMJNWu5CRU5vaPeWGQDMvDbx8+yuPCibbK8YSmPYuRqwhesMC12g160lqajw
	 eHaFz5CApAkpnazpdEV7tNV4RMSeI8J/cAfJ9VhxUtTZv409jw8aYIg5BQ4cvSoqXt
	 x7wn/czOyyA07gxZ6YZfhLpZouWJlT9+46F0EtvteGZi8ybqGuMN++TawtBLxKnR5b
	 1qronMjo5I/hdxI7fPrX/DjHo0XIhRFWvb2LCFiO71UAT24HvxM7ZeWI38mzoaZ7P5
	 EcLPnxMSkfUsLVNUKF/Xed5eX9dBEWS2atioixSfDerUmSAW18peZc0Rgk8QnVMReu
	 FhOC79C9rwUcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/6] PCI: Add kerneldoc for pci_resize_resource()
Date: Tue, 14 Jul 2026 20:17:54 -0400
Message-ID: <20260715001756.3783927-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715001756.3783927-1-sashal@kernel.org>
References: <2026071305-gulp-reenter-fa22@gregkh>
 <20260715001756.3783927-1-sashal@kernel.org>
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

