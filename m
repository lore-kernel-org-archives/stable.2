Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644F94DA539;
	Wed, 29 Jul 2026 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785338601; cv=none; b=d41wuqyN920Fvz7nmwhqjy7eSYOUq/fdMQGO3oQaiFrWqLE6aUPOzGWxzoOhx4dMAAbTz3CRUGnv15qySusjHIAXf8WGsNMRj5LUBWI6VTmN2iZUNOkbkE91j6TQQE5YjcVetl2ceHs6Q3FI2kwLoqYn6ic1yDl28RDhk/jBJRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785338601; c=relaxed/simple;
	bh=FPiMPTsDBCeuqi1jdZxuahf+2WmJa1g7FWViFCkj4rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jt5x4ttrRWG7mlJyIY6qF2ROwZ75zeH1EbjXeTddyM+HZ8hnbx7OlUf5v911ASUD/IQMPltLJzOr2VqTYhDQdmp2sq3BcGEv7Bt1jgEco8waHAMf7JGmMpsex7O03C6I/YispQhjKsdINBy8o+YY/3ny+cvW4VbBpJE6XQcR8ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=eReFLul8; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=rvE8Jx7x; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="eReFLul8";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="rvE8Jx7x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338597; bh=FPiMPTsDBCeuqi1jdZxuahf+2WmJa1g7FWViFCkj4rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eReFLul8B2kOZXsexH7egjpRuwCRnx/BYZkX8+Arn5G3j9nFDlO7zuzE5SdbH1VNK
	 cRTDiaiDscAEiLC/bUJcm5axUtyk35tGSBhpewj+puXSk/qBml0zCu4q8uYy5o0+om
	 aakqz+gAh0v1+VgJMQBuxDJbrfl1BSJ/vWd43zOFDAvJDXt3oWbLLQ1jLyD2BioxZI
	 0wgdyR0HZ1E1JIgaGJoihAWnNjSOezSGsM/yYO/XAmvxh49tKeV4dfExb95sPozY3h
	 F4ty90KO/HRkCkW9BqJy6mzE1t3Y+ERyEONTDtqfO63jas6/iqnQNMk2896YqI0+OJ
	 Coc0WDdsrvsTQ==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 960EB4253A; Wed, 29 Jul 2026 16:23:17 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1785338594; bh=FPiMPTsDBCeuqi1jdZxuahf+2WmJa1g7FWViFCkj4rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvE8Jx7xyv7RiQhCG/2iOmLSJjWCCdefVMdqfv6WpBjPv2cxziv5TxyYE44wlWcSF
	 w9E4c4DFyGL2te9FWQK8odw9Vu1LyGZEb8uwAr+bDiEXHco77VgzwhHAoI0do/HDMv
	 cy+8tJfYW9VxroJpqK/OxBq03gFbs7aizfMbiEpkIRXi9mkshlfNw66AlEkc6wK6sH
	 kZQXziHhv62AouUMiAeQrW/9gPtYjlM1ETN0aTOZqknli0HNwFyg9t0Wbj944nEJBx
	 kCZG50X15KUCzxL0bg5WPsFQeGewFdjyd9xOg+Ezv5N1WDfSdukp4S7o8aaMvElpP5
	 nSG/gTffLzTOA==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 5079D4254E;
	Wed, 29 Jul 2026 16:23:14 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>
Cc: stable@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 09/15] media: meson-ir-tx: Ensure probe error is propagated
Date: Wed, 29 Jul 2026 16:22:47 +0100
Message-ID: <205ba0a9ed3b3235b0029bcdf279f74eaea16f86.1785338381.git.sean@mess.org>
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

devm_clk_get_enabled() may return -EPROBE_DEFER which needs to be
propagated else the probe will not be deferred, it will fail instead.

Fixes: 49be1c78d575 ("media: rc: introduce Meson IR TX driver")
Signed-off-by: Sean Young <sean@mess.org>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Cc: stable@vger.kernel.org
---
 drivers/media/rc/meson-ir-tx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/meson-ir-tx.c b/drivers/media/rc/meson-ir-tx.c
index abb107d19e8c..174d5135e1bb 100644
--- a/drivers/media/rc/meson-ir-tx.c
+++ b/drivers/media/rc/meson-ir-tx.c
@@ -290,7 +290,7 @@ static int meson_irtx_mod_clock_probe(struct meson_irtx *ir,
 
 	clock = devm_clk_get_enabled(ir->dev, "xtal");
 	if (IS_ERR(clock))
-		return -ENODEV;
+		return PTR_ERR(clock);
 
 	*clk_nr = IRB_MOD_XTAL3_CLK;
 	ir->clk_rate = clk_get_rate(clock) / 3;
@@ -324,7 +324,7 @@ static int meson_irtx_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -ENODEV;
+		return irq;
 
 	ir->dev = dev;
 	ir->carrier = MIRTX_DEFAULT_CARRIER;
-- 
2.55.0

