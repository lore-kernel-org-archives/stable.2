Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492A247C0FD;
	Mon, 19 Oct 2026 06:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792392697; cv=none; b=MZrTupvCv3BDQX1fT0C7xLXjBz/qqahRtWF4v62xPIuLTa2wD0Ud+5TjZ1lXlk+BjEmAmIm59CsMgrTcGOYNe8jV+8RCSNytUr3gGhFjYuOlJxdjBZHQkwoNC4Uljr+tWXsK6mQWKjp+XcwXrjYdyS9Pn+1mYnJqG4XFf2Deu2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792392697; c=relaxed/simple;
	bh=qxQmdp87TLNqxUO21Mzmr7NFYe66kT6uB7KfN/vckvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qr5/GAYl946QowO4xDDtRfLTrN6vMP3o3uJAeu1xnq6Ln9XQDrO7anj/RMEz14CulFxfRZmoythThOZRLQPl/fhqHgyxT5ShuAHlcK3gb77kvOGvdeQ02C62hkOqnipWpWL5Gi4Hy5sOqoCv7kRgMDBzd99H+8/dX+n/0o6y6ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRfco/bI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRfco/bI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10201F000C5;
	Mon, 19 Oct 2026 06:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792392695;
	bh=rI5RrFchGyd1mI7QuRLeEAz7J1hM0abQKn3OpJsQTCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XRfco/bI/i2kzP62pJLVEHavMh8LxmNlkFAlYVAK+nYqObKYJXTjSE7KomhhSP0ed
	 F7ViZshHNawT+gRWvt9p8k5UDpB25HZ3mrh1LwoOsdGAsIWkiRf1ZRsjf+/kCkmt0A
	 sh0EWNtBKu9hKZiL9/jwzENF43UZEqb2vcR1MXFe0zNH03USrsDe3WYZlDu9Fg/6vp
	 f+7J3hzav/mj9WBlR1xhjZVSnnrkR8zRJDfmhCHwtUu4NzUiY509c/tZja3GzUn3dL
	 oQi8UG7a8vDXvu72qY5aHEltXZn1Wiwr8P0Qt8eUv1YKk2lAJChjlWkvMUcSLOFxpn
	 4Q98cnB7hSvIQ==
From: Claudiu Beznea <claudiu.beznea@kernel.org>
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 03/14] PCI: rzg3s-host: Don't mix goto-based unwinding and cleanup helpers
Date: Mon, 19 Oct 2026 09:50:14 +0300
Message-ID: <20261019065025.2146539-4-claudiu.beznea@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
References: <20261019065025.2146539-1-claudiu.beznea@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

rzg3s_pcie_probe() releases the sysc_np OF node through the
__free(device_node) annotation, while the rest of the function uses
goto-based unwinding. According to cleanup.h, the two styles should
not be mixed within a function, as this makes the ownership semantics
hard to follow. Drop the annotation and call of_node_put() explicitly
on the exit paths instead.

Fixes: 7ef502fb35b2 ("PCI: Add Renesas RZ/G3S host controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- none, this patch is new

 drivers/pci/controller/pcie-rzg3s-host.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
index 0ef49bb5ab1a..bee3e46d025f 100644
--- a/drivers/pci/controller/pcie-rzg3s-host.c
+++ b/drivers/pci/controller/pcie-rzg3s-host.c
@@ -1822,9 +1822,8 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	struct pci_host_bridge *bridge;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct device_node *sysc_np __free(device_node) =
-		of_parse_phandle(np, "renesas,sysc", 0);
 	struct rzg3s_pcie_host *host;
+	struct device_node *sysc_np;
 	struct rzg3s_sysc *sysc;
 	int ret;
 
@@ -1859,7 +1858,14 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	sysc_np = of_parse_phandle(np, "renesas,sysc", 0);
+	if (!sysc_np) {
+		ret = -ENODEV;
+		goto port_refclk_put;
+	}
+
 	sysc->regmap = syscon_node_to_regmap(sysc_np);
+	of_node_put(sysc_np);
 	if (IS_ERR(sysc->regmap)) {
 		ret = PTR_ERR(sysc->regmap);
 		goto port_refclk_put;
-- 
2.43.0

