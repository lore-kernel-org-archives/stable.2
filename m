Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE914ADD85;
	Wed, 29 Jul 2026 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338601; cv=none; b=hk+Kyozh6nhnF0yrWxB8YY1UFxAOqhM3QeGXCfxOOJU+v9s0VfF/dbArQMHeF+nEZ/klxTWJ+Ofefu4XV2DrjDcn7/1P9Y2WQscGVAnYVPSD1wkz4sBkW/NBYYGhLu0Zdu8dXdu1ZoUEjF820UaZZdgrsLfGSjxC7oWDLObifEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338601; c=relaxed/simple;
	bh=QOMUaOb2h1jtcbXz+sSplXhF1rm3W0B20GRsAM1hRwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OfUK/qxnB3F+422LdNl7OPVqw4BPiidKsH24czJAfuPdhjtYR3okrfnKgqMnPKmE+CxUHC6LiyHRwRX26unKSP9dOfPxgBmOwLuiUfHJHL45Sw+pEes2QXGqrAVTkCkeHPpPx6inFzWZcV9F4e0j137obD1o12jGDyIEDmIiZY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=cKaW/cwn; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=CCZVpF8G; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="cKaW/cwn";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="CCZVpF8G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338597; bh=QOMUaOb2h1jtcbXz+sSplXhF1rm3W0B20GRsAM1hRwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cKaW/cwnPu/qU/SSddL81Zji9wNYCcb/fHXLCemPD3UQOcUUSI+JJaGjFpSxvcWn/
	 8TsoUkCLE6rIw+HQewfo+1xwgVf4pT1phkXhZk2mv+7taClP0vxUFKUUlpIB7Jn9yp
	 5/RIUmiCElpN8I5vdLr2IauZDM1D34bWPP6C8shvRqHQ32VQ+PQZ+N0ZOsrACuAz6z
	 CaUmIXI0utQNxeMhkS/oq9Yx0Pr3cnyefrrCHtCu+LQHhMCUJmov/MDdveGmKhy13k
	 U/KS64jjru+Yu7ay4Ux7EEse+BAvYAgUBHs3VhBowS6WDRO+uzGX+qKgooPkTu5OQe
	 Ildrr59/K37Pg==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 5CFEB42546; Wed, 29 Jul 2026 16:23:17 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338595; bh=QOMUaOb2h1jtcbXz+sSplXhF1rm3W0B20GRsAM1hRwA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CCZVpF8GeRiRJTkRoQbP28wHSUjYIi0gcpAii33WmRP8n6FA7Vor6q2m/09VlziA8
	 x6Iet3+24xPwEe6uu8izXHseDivbyjSzGG9HvXJEdSD3GO+AacBaw8tW3GqU64PbhB
	 +vj1H9GqyaCW4KiAxMw1liVAKX181MiSG4mD0qmK/N+rEFawrrgmG4iTXZ45GlkZjT
	 +CuJVTCRaja2NI9YjBvNwvz4T86GYpMEXtLX4Cml4TFl5jzVRevadz4UVRIjydezua
	 lCXfARkA9uxUAKsJ9k+C7xJ8yaPhmYEZUpZdVeOjVls5qTfRrkOGGp2/2RHqw92GYg
	 se3qfObyDnQkA==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id F34774252A;
	Wed, 29 Jul 2026 16:23:14 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guoxiong Yan <yanguoxiong@huawei.com>,
	Zhangfei Gao <zhangfei.gao@linaro.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/15] media: ir-hix5hd2: Ensure rdev is setup before interrupts are enabled
Date: Wed, 29 Jul 2026 16:22:48 +0100
Message-ID: <b8b3a9bcaaae0c46c81cb40310cd5599decf488c.1785338381.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1785338381.git.sean@mess.org>
References: <cover.1785338381.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once the interrupt handler is enabled, priv->rdev can be used. Ensure
it is setup correctly so there is no race condition.

Fixes: a84fcdaa9058 ("[media] rc: Introduce hix5hd2 IR transmitter driver")
Signed-off-by: Sean Young <sean@mess.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/ir-hix5hd2.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/ir-hix5hd2.c b/drivers/media/rc/ir-hix5hd2.c
index 1b061e4a3dcf..aa3de4d57a58 100644
--- a/drivers/media/rc/ir-hix5hd2.c
+++ b/drivers/media/rc/ir-hix5hd2.c
@@ -316,6 +316,9 @@ static int hix5hd2_ir_probe(struct platform_device *pdev)
 	if (ret < 0)
 		goto clkerr;
 
+	priv->rdev = rdev;
+	priv->dev = dev;
+
 	if (devm_request_irq(dev, priv->irq, hix5hd2_ir_rx_interrupt,
 			     0, pdev->name, priv) < 0) {
 		dev_err(dev, "IRQ %d register failed\n", priv->irq);
@@ -323,8 +326,6 @@ static int hix5hd2_ir_probe(struct platform_device *pdev)
 		goto regerr;
 	}
 
-	priv->rdev = rdev;
-	priv->dev = dev;
 	platform_set_drvdata(pdev, priv);
 
 	return ret;
-- 
2.55.0

