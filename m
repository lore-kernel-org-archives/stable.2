Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5256472527
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789129795; cv=none; b=i4P8AAYo1/q8HXcz1BBWtNs5AtlKtHgBWV8XqsfSuC6h9CbtgJCcBipq83lNB0KP1Wf36uKMg3lnHhG5qfSbosuHaeKNkb3aWUUkNE1IvX11+Y3NqJDIOJmUKsWBitSWmnGOiTVkThfaC9tnDki14gxzC2LZlLZ2aLkft3KplbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789129795; c=relaxed/simple;
	bh=Vew0BYeeHJCE5J6Zr7/fZEOUTuVIB1s1aObe1RlFD4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fvnc1PoDH8sx/Nv0F/PfzbMm8gZKsdSlD1ReZXZN5qDtpOzoxyODM41/u1X2E7/Gu5gzi5WOz5U8X9kDHM+iPUJbpyuZj3FtSFu75Kaa2HdqOrRwm6cXQAWLkHyfkrHFAo03oj0cRLE1T9RUSKwfiHDttLZRui8YL7LbYw70NGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5UH+PF+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5UH+PF+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF61F1F00899;
	Fri, 11 Sep 2026 12:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789129792;
	bh=ex8URQs4OOo2r2ABmKC3RxvlLqlB+f6dzRQr4M1GY7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S5UH+PF+9A3BSpzEG5bbUzWzWXjA09o5YaY9AJyllsops56PGzFfB9v1h76kgd0S2
	 it2tBXM5I1Ugf9P47l0rmUlMoWtKx+qEZKT/RP8BnFix1nnNanDAOKqOoAPyij81l0
	 zrb/sohAMs3jMTRI6QpM5y7/izthpZzx7eFD7lAHRDmO+2U3V2xLmUMG3NStwvfavH
	 l/23yVgKvoM15robM6ONDaaXcw3HtMbGN8Zc1Zi1cTrQpJFWqS9S/9zFXd7uDXI1a7
	 cZ1x+Pn6f/hfk4BEHpWmh53jLHACc1QZh8rCy7pwIFbuoDJnC0iLHrOTBEeu4S/czb
	 LZzIG+uF9VxZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>,
	Sean Young <sean@mess.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] media: rc: sunxi-cir: Unregister rc device on probe failure
Date: Fri, 11 Sep 2026 08:29:49 -0400
Message-ID: <20260911122949.555717-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911122949.555717-1-sashal@kernel.org>
References: <2026090910-petal-cupcake-2b81@gregkh>
 <20260911122949.555717-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Myeonghun Pak <mhun512@gmail.com>

[ Upstream commit 479aa6fa8c50f1052f1451326ef7d4d586d340c3 ]

After rc_register_device() succeeds, later probe failures must undo the
registration with rc_unregister_device(). The current error path jumps to
the allocation cleanup label and only calls rc_free_device(), leaving the
rc device registration and resources created by rc_register_device()
behind.

Add a registered-device unwind label for the IRQ lookup, IRQ request, and
hardware initialization failure paths. Keep rc_free_device() for failures
before rc_register_device() succeeds.

Fixes: b4e3e59fb59c ("[media] rc: add sunxi-ir driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Signed-off-by: Sean Young <sean@mess.org>
[ adapted cleanup for missing sunxi_ir_hw_init() and rc_unregister_device() implicitly freeing the device. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/rc/sunxi-cir.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/media/rc/sunxi-cir.c b/drivers/media/rc/sunxi-cir.c
index 7a67e79d637a3..2c8960365b9e7 100644
--- a/drivers/media/rc/sunxi-cir.c
+++ b/drivers/media/rc/sunxi-cir.c
@@ -259,13 +259,13 @@ static int sunxi_ir_probe(struct platform_device *pdev)
 	ir->irq = platform_get_irq(pdev, 0);
 	if (ir->irq < 0) {
 		ret = ir->irq;
-		goto exit_free_dev;
+		goto exit_unregister_dev;
 	}
 
 	ret = devm_request_irq(dev, ir->irq, sunxi_ir_irq, 0, SUNXI_IR_DEV, ir);
 	if (ret) {
 		dev_err(dev, "failed request irq\n");
-		goto exit_free_dev;
+		goto exit_unregister_dev;
 	}
 
 	/* Enable CIR Mode */
@@ -296,6 +296,10 @@ static int sunxi_ir_probe(struct platform_device *pdev)
 	dev_info(dev, "initialized sunXi IR driver\n");
 	return 0;
 
+exit_unregister_dev:
+	rc_unregister_device(ir->rc);
+	goto exit_clkdisable_clk;
+
 exit_free_dev:
 	rc_free_device(ir->rc);
 exit_clkdisable_clk:
-- 
2.53.0

