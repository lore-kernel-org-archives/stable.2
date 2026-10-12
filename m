Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AA34908CE
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 14:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817110; cv=none; b=gme4Jx4lFKHR0jO10kkUUZbGC4Ec0REReTz/UCjOv7Foh+yN4llVby1IrExztsnnxnvFRXSwHBTyYx350pRXGFBfiDtcWKSkoNGpdAYhGijrrIpbyLrY2dF3G2RIiASz0wjxv20toeL4JmgRj5FBMZgXRW3sxd6AMDC/4eV/vGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817110; c=relaxed/simple;
	bh=776JTmLMz+2b8r0PU+jWTHBB4Ljm3+VAVJn2LP0mKvc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qcW/CghHzKebxjqP8rjX7Rb3FuRZI4i3+rlj79zjo0jP5rPRNK44UWlM2nBdqOQjGYWMAnoSdW2pejkbi+ffvElvf6obZ1mZuwyjTS3943b2u2WKsZUezZh2vh+Jtf96nXM4m9SQyk2o2i0QgGZ2ZSSOAulbBubl9jvUdN6iwv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ud4YBkr8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ud4YBkr8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CEC21F0089B;
	Mon, 12 Oct 2026 14:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791817109;
	bh=h4+Wmkv96OAehuXKGp3ErH0XM+ASZmv+0XMyBrI2Vo8=;
	h=Subject:To:Cc:From:Date;
	b=ud4YBkr8xQavFktxtaaFhV62ICFAy4affA0/IT9bfGhPb6g8ByFTLz1sBBYyw/DOT
	 VUSqbwMG050W/sB10ipjzEZ8dkdcYIquVS/+hW/rzxZtRC7SXUx+KMJea/1kAWm13J
	 sRaV4xKtWXfRnDLNgnRUPxvqa9oOXb81k7wBoNdA=
Subject: FAILED: patch "[PATCH] pmdomain: imx8m-blk-ctrl: Serialize power on/off across" failed to apply to 6.1-stable tree
To: ming.qian@oss.nxp.com,Frank.Li@nxp.com,ulfh@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 16:58:34 +0200
Message-ID: <2026101234-smile-observant-e7bb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 51c2db3ef0cb89a49ab7f47a40efd5d5b074ce8d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101234-smile-observant-e7bb@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 51c2db3ef0cb89a49ab7f47a40efd5d5b074ce8d Mon Sep 17 00:00:00 2001
From: Ming Qian <ming.qian@oss.nxp.com>
Date: Mon, 21 Sep 2026 19:03:34 +0900
Subject: [PATCH] pmdomain: imx8m-blk-ctrl: Serialize power on/off across
 sibling domains

On i.MX8MP the VPU blk-ctrl exposes G1, G2 and VC8000E as three separate
genpds, each serialized only by its own genpd lock, so their power_on and
power_off callbacks can run concurrently on SMP.

The sequences are not independent: they share the VPUMIX bus domain, the
VPU_NOC and the ADB400 handshake. On power up the GPC cannot ack-verify
the ADB400 handshake - the ack only completes once blk-ctrl sets the bus
clk-en bit - so it just waits a fixed delay instead of polling hskack. A
sibling transition landing inside another domain's reset window disturbs
that shared clock and handshake timing, the victim's reset does not take
effect, and its block registers read back all zeros: the decoder times
out or the encoder fails its format check.

Serialize the blk-ctrl reset sequence with a per-blk-ctrl mutex; the
driver deliberately avoids a genpd hierarchy, so the genpd core gives no
cross-sibling serialization.

Fixes: a1a5f15f7f6c ("soc: imx: imx8m-blk-ctrl: add i.MX8MP VPU blk ctrl")
Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulfh@kernel.org>

diff --git a/drivers/pmdomain/imx/imx8m-blk-ctrl.c b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
index 479789009c7f..f8105e87ea3c 100644
--- a/drivers/pmdomain/imx/imx8m-blk-ctrl.c
+++ b/drivers/pmdomain/imx/imx8m-blk-ctrl.c
@@ -15,6 +15,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/clk.h>
+#include <linux/mutex.h>
 
 #include <dt-bindings/power/imx8mm-power.h>
 #include <dt-bindings/power/imx8mn-power.h>
@@ -34,6 +35,12 @@ struct imx8m_blk_ctrl {
 	struct regmap *regmap;
 	struct imx8m_blk_ctrl_domain *domains;
 	struct genpd_onecell_data onecell_data;
+	/*
+	 * Serializes the blk-ctrl reset/clock sequence across sibling domains;
+	 * their transitions interact through the shared VPUMIX bus domain,
+	 * VPU_NOC and the not-ack-verified ADB400 handshake (ERR050531).
+	 */
+	struct mutex power_lock;
 };
 
 struct imx8m_blk_ctrl_domain_data {
@@ -98,6 +105,8 @@ static int imx8m_blk_ctrl_power_on(struct generic_pm_domain *genpd)
 	struct imx8m_blk_ctrl *bc = domain->bc;
 	int ret;
 
+	guard(mutex)(&bc->power_lock);
+
 	/* make sure bus domain is awake */
 	ret = pm_runtime_get_sync(bc->bus_power_dev);
 	if (ret < 0) {
@@ -164,6 +173,8 @@ static int imx8m_blk_ctrl_power_off(struct generic_pm_domain *genpd)
 	const struct imx8m_blk_ctrl_domain_data *data = domain->data;
 	struct imx8m_blk_ctrl *bc = domain->bc;
 
+	guard(mutex)(&bc->power_lock);
+
 	/* put devices into reset and disable clocks */
 	if (data->mipi_phy_rst_mask)
 		regmap_clear_bits(bc->regmap, BLK_MIPI_RESET_DIV, data->mipi_phy_rst_mask);
@@ -202,6 +213,10 @@ static int imx8m_blk_ctrl_probe(struct platform_device *pdev)
 
 	bc->dev = dev;
 
+	ret = devm_mutex_init(dev, &bc->power_lock);
+	if (ret)
+		return ret;
+
 	bc_data = of_device_get_match_data(dev);
 
 	base = devm_platform_ioremap_resource(pdev, 0);

