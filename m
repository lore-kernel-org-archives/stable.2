Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584850;
	b=E5QT79qGcIcdf64hO/yXGp8O3u+2TzaZtdZMcQiGJc87psLRqaVD4jGJdcqF48yHvYak
	 5NVOrxImRjx+CQWxn9nmJCvc7WKLiNQbgIhhArVEjR7y1Zgoy6JJRgvhHIKOmSeoCyD8A
	 UdyJh3ZxCca/2pltq5hRoTj1D+dKsl/8S2WIOX3tLt1soyfvA4X4ZivtND4vvQNX1Yuh1
	 h15IS2VaxjIjmu+33BAGcwq74WtQFA+gcQ02KnikhOX3bfY4JVvh8cEmzuyjWap/CE18l
	 Zsgpz2AqKBJ4Yfefjc1WEFDl9qaEiTZt/LZ7ab1RvAtfklPmnkHVWgRGvAgO2gp8k9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584850;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OZqz5yeBmL53cHzDaWfzVxHSA2dziWp4hpaxPF32V3g=;
	b=naQcQyh2HaL+ulDtvK+0d18GWSbn4WbOGXnRciSgVd4ewwCFM6/1dZVS7EjJ+weIjFM2
	 qSbrSd/rJdxhPe8l5NglbFpU1YZfxv5HgYb3jPU5/gTGax5H2T5rwQP1yM7PemMBu5MS2
	 jskmoZIa+L+YcdXsjSyG5E9pNc4O6K/AFVo0yWxmviJFrwE0T9Co44R5HfXhonKt1RV7U
	 /svP4jJmixaWl/QAGy/EwkMnDxKIhlvEVU52T5yMc93sxeyQ9dHpSH63b51ehnPWhBLYv
	 Vq11r4je7VZyMQp+LCKnMKnlQDQSeRjun7xYmzGIx4Ej50rZYW79/wQjk/DWQkyO3kA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jD1zZLzd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5BE606A319;
	Wed, 21 Oct 2026 12:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jD1zZLzd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3271F000C8;
	Wed, 21 Oct 2026 12:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584849;
	bh=OZqz5yeBmL53cHzDaWfzVxHSA2dziWp4hpaxPF32V3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jD1zZLzdGZ/DuQZg6SLawjA6I20wi1EQs4zVjZoCPAdOQAEQ3lnVnYUVInIbEwgks
	 /3eDNzYd31zBhJhN8MEC4IhP+OJS2/xNExTMPbySyWy6CdzNLd04REuPpgPNPHUa7I
	 So1TO75Ons0y4o5NZB5zFfwTxkqiTfxVicfleQrhLSUOv+x+xYLjSNkeEE7ifgNVmW
	 8Lh+mU5NniOQef4cejtq/nyuNq6egnxA4+nJl1NFY4XRglPOx5+4Hr+lBRsNVLPnqN
	 gr1khhayyG394OYoF9tFXY3idYhCe65rhOyNQ1scUHvpHdj9Vzim8Ar8myylyJs1Dg
	 9SowjAnsriG4A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Chong Qiao <qiaochong@loongson.cn>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Corey Minyard <corey@minyard.net>,
	Huacai Chen <chenhuacai@kernel.org>,
	mfd@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 02/28] mfd: ls2kbmc: Unregister GPIO GSI via devm_add_action_or_reset()
Date: Wed, 21 Oct 2026 12:09:24 +0000
Message-ID: <20261021121245.3111563-2-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021121245.3111563-1-lee@kernel.org>
References: <20261021121245.3111563-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ls2k_bmc_init() unconditionally calls acpi_unregister_gsi() immediately
after requesting the GPIO interrupt via devm_request_irq().  This
prematurely disposes of the active IRQ mapping while the interrupt
handler remains registered, breaking the GPIO watchdog interrupt and
causing a use-after-free when devres later frees the disposed IRQ
descriptor on probe failure or device unbind.

Register a devm_add_action_or_reset() callback before devm_request_irq()
so that acpi_unregister_gsi() is invoked only after devres has freed the
interrupt.

Fixes: d952bba3fbb5 ("mfd: ls2kbmc: Add Loongson-2K BMC reset function support")
Closes: https://sashiko.dev/#/bug/linux-cab8bfb6-4077-46f3-a173-ac2e2042cf66
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/mfd/ls2k-bmc-core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/ls2k-bmc-core.c b/drivers/mfd/ls2k-bmc-core.c
index 408056bfb2fe..23c774a09842 100644
--- a/drivers/mfd/ls2k-bmc-core.c
+++ b/drivers/mfd/ls2k-bmc-core.c
@@ -363,6 +363,11 @@ static void ls2k_bmc_save_pci_data(struct pci_dev *pdev, struct ls2k_bmc_ddata *
 	pci_read_config_dword(pdev, PCI_INTERRUPT_LINE, &ddata->bmc_pci_data.interrupt_line);
 }
 
+static void ls2k_bmc_unregister_gsi(void *data)
+{
+	acpi_unregister_gsi(LS2K_BMC_RESET_GPIO_GSI);
+}
+
 static int ls2k_bmc_init(struct ls2k_bmc_ddata *ddata)
 {
 	struct pci_dev *pdev = to_pci_dev(ddata->dev);
@@ -412,12 +417,15 @@ static int ls2k_bmc_init(struct ls2k_bmc_ddata *ddata)
 	if (gpio_irq < 0)
 		return gpio_irq;
 
+	ret = devm_add_action_or_reset(ddata->dev, ls2k_bmc_unregister_gsi, NULL);
+	if (ret)
+		return ret;
+
 	ret = devm_request_irq(ddata->dev, gpio_irq, ls2k_bmc_interrupt,
 			       IRQF_SHARED | IRQF_TRIGGER_FALLING, "ls2kbmc gpio", ddata);
 	if (ret)
 		dev_err(ddata->dev, "Failed to request LS2KBMC GPIO IRQ %d.\n", gpio_irq);
 
-	acpi_unregister_gsi(LS2K_BMC_RESET_GPIO_GSI);
 	return ret;
 }
 
-- 
2.56.0.218.g1ec904b173-goog

