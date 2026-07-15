Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFFB3C9ED5
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 11:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114184; cv=none; b=tn3GzVJtFDMyHHrbdV9gUYXecALK02FVgAg9NL6NSN5AyzwhxBe5xsJpp4kScMSKA+cPUc9C2N8OscfZZ9XkZ0Gw0VpkWlKbLosqvV2sgYqJa1fOT+dtqQRL6JvhMnI3NL/pDAP+5uyqAEM93auQ1oVLLiD/kULh4dp8/w6H4Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114184; c=relaxed/simple;
	bh=cVLqm49OVUnlyTOiFyiMpK7BklkguM3f9/DMUEvc9MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mrKeDJ5z1/BDGlal0snuw9jd9Tt8ktRb0os0GBOpi6si/t/upISdbxpKc0F+43OHVC57sxidoSoPatZUS2yNox0EA9meT9jdGFh/W2nyAzTXpu70U/XfTDzuUTOAn152XUKKJxTlNv4vvpPXvnrA/De89+Q8TzI2LMwIM3ftX/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I8XQzWYC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I8XQzWYC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71631F00A3E;
	Wed, 15 Jul 2026 11:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784114183;
	bh=y+9Gybg0clEhzNsBRpzoK0MBhAQIDoHQkN0//Ezgc7E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I8XQzWYC2UBGZXjuNJGpuOGAW0Of51hAAW08wp2jTIeBwyFxbK9myOWTW9tsRuKGs
	 v94j/7sWq9yRmtJFnQxr96wSW+PTYDrUqu4eZRssJ6zmLRMuOMmxRzZwiI34GCl0e4
	 c+jWgV1nKUTYlnRFDJOesIZcsJWvWHAzEu/5seZkY03EE+2AUUxPjkMVyGxyxA79oG
	 5HeTI9U1EE6gqIhUokMjdp7wuDa1yqO4Azd1EBY+lT1+P+W4BFCcwbopnW6ZEl1okQ
	 xPQDGOzY5kdMnTgZouNheOsMTjnuMFHgNnp2uv95/Jbthqx+z1TBUXaoVzZvZKEyPw
	 Gcm43XiYlpo8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/6] PCI: Add kerneldoc for pci_resize_resource()
Date: Wed, 15 Jul 2026 07:16:16 -0400
Message-ID: <20260715111618.647249-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715111618.647249-1-sashal@kernel.org>
References: <2026071314-tableware-flashback-79cc@gregkh>
 <20260715111618.647249-1-sashal@kernel.org>
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

