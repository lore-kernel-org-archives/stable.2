Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9950550B404;
	Thu, 15 Oct 2026 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058099; cv=none; b=RTT5VBb49Y2mxCAHwyUQQ04SUiX1TW6Yp/inps6i+7lIAqJmwZcmcFY3VmdvvsOLr2ScU9voraIH8Q9oqi/pq/uEqfBA4/kVBFud8OwUoGz8L2SUwwyn48gc8+JSBDjMwTSie019m41VwgghnfsQZte1riRmWvtiRoRLkuj+9w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058099; c=relaxed/simple;
	bh=qOjZ4xnXvlm/VqR2BtcMv9QpsxHum1cDjdFMkANlqZQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QaE8o04wjxqLf/fss63eJ6DQLzJup/D3XMVbDMFu83+xlfkOeTVafaPn+JQZWd5rZ553dVIj0HXXxAR6nCZd800QnWbOj3XX/b1G+nlN2lEyYselFxQ4s5NjxdqBBxJpGz8+7cxr0lKOvRaIaBv8hjCMgShYSagbKd9qGxVMOxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H86TXMuq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H0c/dZHB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H86TXMuq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H0c/dZHB"
Date: Thu, 15 Oct 2026 09:54:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792058093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kshXa+dqde9HPdpfgSRA8y1wIPjKRmHWXItsWVH/XRY=;
	b=H86TXMuqzG99qdiLoGbhl5quR8MCPAT9l+gepqx+hjfWF06FOtLYLn+ojqxkh2brWE95kh
	LajRRXvDDeypf+SyrpoNl1f7k/GVs+THkDFc18/40hnttPbb2BatD8oWdEMqI54kLFX5js
	pBSC39JglGZrtNoYoShSDcVZ6qDMOrHanXoc8ml6kfUkt48YlwjBKCC/pYcjUVd4O5IrGu
	5jKyA98uIW0MQr44boRL30LgPWR0VA50byLVp0gziHzQubfjnnOCntOEEPFgOiNuQEW8Tx
	f75RPFmTgRFzb3WPIhpoP+634CviNiuiF6+XZJoFz6oX8Tpef2Nd4WxCHMADUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792058093;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kshXa+dqde9HPdpfgSRA8y1wIPjKRmHWXItsWVH/XRY=;
	b=H0c/dZHB8t0sHigms44MICKS1s8Qo8cgOYf69cNS5MH4IPGkz7WWsTLTIXsAtqrAOCe90l
	3BGGYY5+ve35lkBQ==
From: "tip-bot2 for Wentao Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/mchp-eic: Fix clock reference leak in
 mchp_eic_probe()
Cc: Wentao Liang <vulab@iscas.ac.cn>, Thomas Gleixner <tglx@kernel.org>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260916190349.2094401-1-vulab@iscas.ac.cn>
References: <20260916190349.2094401-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179205809224.2666988.15825587733834287898.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     af9c707eb065a7d48eb92dc15acdb4346acf5db0
Gitweb:        https://git.kernel.org/tip/af9c707eb065a7d48eb92dc15acdb4346ac=
f5db0
Author:        Wentao Liang <vulab@iscas.ac.cn>
AuthorDate:    Wed, 16 Sep 2026 19:03:49=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Thu, 15 Oct 2026 11:50:47 +02:00

irqchip/mchp-eic: Fix clock reference leak in mchp_eic_probe()

of_clk_get_by_name() returns the clock with an elevated reference count
that mchp_eic_probe() keeps for the lifetime of the driver, but none of
the probe error paths drops it, so the reference is leaked whenever
probe fails after the clock has been obtained.

Put the reference in the error cleanup.  The clk_prepare_enable()
failure path must jump there directly as it cannot call
clk_disable_unprepare() on a clock that was never enabled.

Fixes: 00fa3461c86d ("irqchip/mchp-eic: Add support for the Microchip EIC")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260916190349.2094401-1-vulab@iscas.ac.cn
---
 drivers/irqchip/irq-mchp-eic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mchp-eic.c b/drivers/irqchip/irq-mchp-eic.c
index be007d3..5250e6b 100644
--- a/drivers/irqchip/irq-mchp-eic.c
+++ b/drivers/irqchip/irq-mchp-eic.c
@@ -233,7 +233,7 @@ static int mchp_eic_probe(struct platform_device *pdev, s=
truct device_node *pare
=20
 	ret =3D clk_prepare_enable(eic->clk);
 	if (ret)
-		goto unmap;
+		goto clk_put;
=20
 	for (i =3D 0; i < MCHP_EIC_NIRQ; i++) {
 		struct of_phandle_args irq;
@@ -270,6 +270,8 @@ static int mchp_eic_probe(struct platform_device *pdev, s=
truct device_node *pare
=20
 clk_unprepare:
 	clk_disable_unprepare(eic->clk);
+clk_put:
+	clk_put(eic->clk);
 unmap:
 	iounmap(eic->base);
 free:
