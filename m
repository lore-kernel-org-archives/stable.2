Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048583;
	b=ix/Fv1NZ8Ac/O1aHs+qOgW7qQdUB8PteEGQdIgg54buTXTJSekMfkvnpXRWv0lHHSR8b
	 FJAPpf1MITaeVlwGDS+f4X0EzF90ytn0NK0WHVNh+Ebv3Zs1qa0lyBjzs+4zxjR0r1NCA
	 x5eE35TUQJmL0icDXk3NH+nT9VdjaEeMC/q8YYii+Shg82DmQnlb/prVgeuD0zuKXEiGj
	 tyr/f8k2Z2jvpaseZT4EO3aliBHmxWLp8SUVGZiWdwMl939l0NJ56mgNvNvRj/osU1LsI
	 LsM1PYQFXf9Nlod6O9L3GEtXmbcT/3VMz69H2lKBSzySCh91LmDJRjk5VlSHJXbgLAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048583;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KNDn+s/TRMpt8bknOeYPaxty1mrXcoEio/VatznRpK0=;
	b=t6VB6+eGKw5dYMUJ8iSbDvJg4RISEtHqAgX4Li1LAugyV9eUV4oNDipib79j22xYr5XX
	 XJjKa27sXcEyfbHmT1L5MXTmhNcPvVRUH9C6YT2SpgrX04Y6E0ugZ/LuCOsBkdDBRvY+6
	 jXI5kClk15BFCkDQPkrC63+fnBnAs/rLKZwHZWk7r1vkwYNtT25EGyJ71kI+DZVq1GP/M
	 DSUvEYvdRiwb2YUHBqTQBptGzvYxd3+jnC59d5rFtMawBr/lrNYWDSzo4N8WOOMGl0mqu
	 DzA/KhcooKONFpF4Eg5rjSS8MTRCakCyTsS/6h5/ymGex7b8KagWeYERVyGSvTSBSoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfrNhza9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679AD606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VfrNhza9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9D01F008A1;
	Sat,  7 Nov 2026 10:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048583;
	bh=KNDn+s/TRMpt8bknOeYPaxty1mrXcoEio/VatznRpK0=;
	h=From:To:Cc:Subject:Date;
	b=VfrNhza9bV4gJDJajyXuNPKprqNlKPmblJVb5h81lECQKULypxOlHQoS+D6mrolHC
	 dI2/KPGqvedLNwX8mVB7QyR3AwpK4Gt7dEpoFqIToO6HVdF7ASuRf9iSf3yUdGysid
	 Gg0QQn3TkpbRjrGAa1LJp9EyKBOqiQQLhhZQ+h5IOpHNKso/jMZ4FJRopzmvZ0JF4Q
	 MGQN4S5QAJzHYaqNPPjPTITfLOLejhjSlQfld/sKEqB9Y8pds64XoD4+wgaCAcDPgK
	 6I+YHPh1qangPyWtI+c1Kc/LoLSaBAqgJSEcIOYYHUOLUKENDxKnfj27nL1kShKf7x
	 WyosTbKwAhV2g==
From: Sasha Levin <sashal@kernel.org>
To: lgs201920130244@gmail.com,
	tglx@kernel.org,
	frank.li@nxp.com,
	radu@rendec.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] irqchip/imx-intmux: Fix runtime PM teardown on remove" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:49:41 -0500
Message-ID: <20261107054940-failed-6.1-b167c1a30e9e@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b167c1a30e9e020e4c5e102c7a555943742c024b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054940-failed-6.1-b167c1a30e9e@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b167c1a30e9e020e4c5e102c7a555943742c024b Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 14 Sep 2026 21:42:11 +0800
Subject: [PATCH] irqchip/imx-intmux: Fix runtime PM teardown on remove

imx_intmux_probe() enables the IPG clock and then drops its runtime PM
reference with pm_runtime_put(). With CONFIG_PM enabled, the runtime
suspend callback disables the IPG clock. With CONFIG_PM disabled, the
clock remains enabled after probe.

imx_intmux_remove() accesses the CHANIER registers without first making
sure that the device is runtime active. The device may therefore be
runtime suspended with the IPG clock disabled when these registers are
accessed. In addition, the remove path only calls pm_runtime_disable()
and does not balance the clock enable when CONFIG_PM is disabled.

Resume the device and acquire a runtime PM reference before accessing
the registers. If resume fails, skip the register accesses but still
tear down the chained handlers and IRQ domains. Disable runtime PM
afterwards, drop the acquired reference without triggering another
runtime suspend, and explicitly disable the IPG clock.

This keeps the clock enabled while the hardware registers are accessed
and balances the clk_prepare_enable() performed during probe for both
CONFIG_PM configurations.

This issue was found by manual code inspection.

Fixes: bb403111e017 ("irqchip/imx-intmux: Implement intmux runtime power management")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Radu Rendec <radu@rendec.net>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260914134211.1734163-1-lgs201920130244@gmail.com
---
 drivers/irqchip/irq-imx-intmux.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-imx-intmux.c b/drivers/irqchip/irq-imx-intmux.c
index 47c2681d138a0..de2a8f98f6255 100644
--- a/drivers/irqchip/irq-imx-intmux.c
+++ b/drivers/irqchip/irq-imx-intmux.c
@@ -288,12 +288,16 @@ static int imx_intmux_probe(struct platform_device *pdev)
 static void imx_intmux_remove(struct platform_device *pdev)
 {
 	struct intmux_data *data = platform_get_drvdata(pdev);
-	int i;
+	int i, ret;
+
+	ret = pm_runtime_resume_and_get(&pdev->dev);
+	if (ret < 0)
+		dev_warn(&pdev->dev, "failed to resume device: %d\n", ret);
 
 	for (i = 0; i < data->channum; i++) {
 		/* disable all interrupt sources of this channel */
-		writel_relaxed(0, data->regs + CHANIER(i));
-
+		if (ret >= 0)
+			writel_relaxed(0, data->regs + CHANIER(i));
 		irq_set_chained_handler_and_data(data->irqchip_data[i].irq,
 						 NULL, NULL);
 
@@ -301,6 +305,11 @@ static void imx_intmux_remove(struct platform_device *pdev)
 	}
 
 	pm_runtime_disable(&pdev->dev);
+	if (ret >= 0) {
+		pm_runtime_put_noidle(&pdev->dev);
+		clk_disable_unprepare(data->ipg_clk);
+		pm_runtime_set_suspended(&pdev->dev);
+	}
 }
 
 #ifdef CONFIG_PM
-- 
2.53.0




