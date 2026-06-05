Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E443AD52F
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 18:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780684287; cv=none; b=MQmJxLJ47eHCE3mjtpQK/isugL4q/jIdj7QM4Eql+IlUoxHZR6JsQSJyiyGfcuVpfbqAlmlDhHRdp61/UrXaPcu/biId4Z0XXkUZ3gNOwrWTyA627qh/QiCaGzcskrO02V2GvK6efQlpTVuveI8S+kB50YhwHFlljttbIf2N/7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780684287; c=relaxed/simple;
	bh=/zNE462HEDnY/cdsRKI27fmrIkvax2pveyaS+KJ07nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjUH3gq7QMwCP7sEzLYrpn1b/+1BEYqppNIy63JArV0b/9qSJJrG7zzznmHI26EvVsXC8qmaNyEl2xtrQ57UxKZ+gfM23sy6rwyeQ+D7p+0JMyutGj9UgXPcdnnvptLg5IF0pvZ7DeJIR+oH/S7PdUwsK6MvEr0CNQFgJ8sQs+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idWvzcF7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idWvzcF7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DBCE1F00898;
	Fri,  5 Jun 2026 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780684283;
	bh=npVYegX7+MM07seg6bXkRlwaLd7s4yajymGzelIlyNU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=idWvzcF7Nak5prwRGW8vtDVWtKFTxNI+cvcVcVpYv89wVC5i7edlo0qIt6AHsO+SP
	 N99KwwuS4wxDchY+sxTCwWly0K1kzT71joqpw5ILJWZgX6gFFKMT/S+aQl/fGAKa8R
	 cdhSnlr6H8la4Xl2zQhx2qA/Yq/8b1aPaPn9sOi12AkZg79riQXxznMoefGeibHnDR
	 lT2gBM/RBLx2HmtCARCS5g997Iijgi/WNhxpJf/Pya7FUrCL5J/4JhlFvzyuVQHkFx
	 T4ywO01UGoNRS92LhuXsWaaCNXHpdav1z3u03nsRQMf/Zhptc6s494d9v7h4sXLmbZ
	 Uow+snn4xk+VQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: musb: omap2430: Fix use-after-free in omap2430_probe()
Date: Fri,  5 Jun 2026 14:31:21 -0400
Message-ID: <20260605183121.2054969-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060438-crispy-channel-2856@gregkh>
References: <2026060438-crispy-channel-2856@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit e194ce048f5a6c549b3a23a8c568c6470f40f772 ]

In omap2430_probe(), of_node_put(np) is called prematurely before the
last access to np, leading to a use-after-free if the node's reference
count drops to zero. Move the of_node_put() calls after the last use of
np in both the success and error paths.

Fixes: ffbe2feac59b ("usb: musb: omap2430: Fix probe regression for missing resources")
Cc: stable <stable@kernel.org>
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260409101104.480623-1-vulab@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/musb/omap2430.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index b4dd0747aee1b1..bf62bd88c4bcd6 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -340,7 +340,6 @@ static int omap2430_probe(struct platform_device *pdev)
 	} else {
 		device_set_of_node_from_dev(&musb->dev, &pdev->dev);
 	}
-	of_node_put(np);
 
 	glue->dev			= &pdev->dev;
 	glue->musb			= musb;
@@ -458,6 +457,7 @@ static int omap2430_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to register musb device\n");
 		goto err3;
 	}
+	of_node_put(np);
 
 	return 0;
 
@@ -467,6 +467,7 @@ static int omap2430_probe(struct platform_device *pdev)
 	if (!IS_ERR(glue->control_otghs))
 		put_device(glue->control_otghs);
 err2:
+	of_node_put(np);
 	platform_device_put(musb);
 
 err0:
-- 
2.53.0

