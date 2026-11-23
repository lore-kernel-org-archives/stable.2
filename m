Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454552;
	b=A6eNZkaxmQahz5zxRps7OAiXvTTdRwhQ/681d38t85pJBeYugz9JbVuEjakUUYdISl+/
	 ct1r9cMSKwgOzUJrXKeq+OSJ3MYjzVW2mCa4PYpwdgcTc3IfLZ6r2aVgdLLmpaZBStkWD
	 06MBfx6oxmm6Fcg1xbXJvwF9QHz2kT+CNcT2Skqpmk8WHHlOfZ+c6ZqxgNRZ6hldRl1+1
	 y0deLcOgUKm8HDe1lr/qN0xe8FGLKUCSuyXRlDBv7tmnZgWAaQpEoj4+WfRlD7yPxa9D+
	 3BUGECEa0p34z/FrvYnW8QonuT8O/diFdfZt2OxxYOY2U1KQEBceGCMlg3T5Ye/Wf+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454552;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=R4qvVaogBx4Zjf6QOGG8yQdtjuPAVQH+Dr+P8xaLQb0=;
	b=Kf9z7Dua3j4Su5aY+tQTbEg2tZ0/rWiEza+DMwSDfNhJs67lMUkNGPd0UI9hC9tPwKcu
	 9vtHwIAahlCphi/2c/1YlPhHyX0mV8QMtE3CiLo7Eso5Sz7/GgV/ZFFmQTgorPHfXdPnL
	 6AR8ma12ois5aAZQd0B+kK8Dba3GHzR2KgzO20GG6+QpOtUo1W5yZg+4pqY0OaYrZD7q0
	 kqnEO6hgIRz6nD7FVW+Q8fXKVGpg0XwHB81pTvlRZlnYjxoVbRjw32q+ODjLJrbhvtGBb
	 ebsbEJsOx5gEbVZK0+VjJJ//JqjIfdTJU1qKzxkAwYPdSwSedtiM7KthM5a8+0FhoCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9ne85SY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A1606A33C;
	Mon, 23 Nov 2026 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H9ne85SY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2CF81F000E6;
	Mon, 23 Nov 2026 17:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795454552;
	bh=R4qvVaogBx4Zjf6QOGG8yQdtjuPAVQH+Dr+P8xaLQb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H9ne85SYIIFKSD/71YeWjgga4nghJ7QJ7jg+llf/w2qwek9nMwqW9QaQMonmZJgCM
	 d8X+HQQjvbLu4BaqZzdpEGIszuX/S2zmISD/rR5J9gzRc4MLgIDqOtP10gE1DLC2Dn
	 ap/pyoEQ+fkZK8cb/PgTFvxwt5iAPRC5r+VGu1n4ePQXjXtlluaXwqqikIUGwr7VkJ
	 yd5r73y0uHmIA09X2lnKauppqrFFZaTGF/26Pgxg3xDRhLufrpUy38BSs55BxzJWZy
	 wwWB0x5rOwtUew7/RbXmXOzWfQqR2IwglOWOYG2ezTvK34j1pizpMVHgIaKHB/+yOY
	 vi52lC49K2dnA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Peng Fan <peng.fan@nxp.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	linux-remoteproc@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 06/10] remoteproc: imx_rproc: Register SCU cleanup after resource acquisition
Date: Mon, 23 Nov 2026 17:20:50 +0000
Message-ID: <20261123172140.3547896-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.809.ga0b61035b5-goog
In-Reply-To: <20261123172140.3547896-1-lee@kernel.org>
References: <20261123172140.3547896-1-lee@kernel.org>
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

imx_rproc_scu_api_detect_mode() registers the imx_rproc_put_scu()
devres cleanup action before attaching power domains or registering the
SCU partition reboot notifier and enabling its interrupt group.  If
imx_sc_rm_get_resource_owner() or imx_scu_irq_register_notifier() fails,
imx_rproc_put_scu() runs during failure unwind and unregisters an
unregistered notifier block while disabling an unconfigured interrupt
bit.  Worse, if imx_scu_irq_group_enable() fails, the error path
explicitly unregisters priv->rproc_nb and devres subsequently invokes
imx_rproc_put_scu() to unregister the same notifier block a second time.

Defer devm_add_action_or_reset() until power-domain attachment or SCU
notifier and interrupt setup have completed.

Fixes: 9b2451658afa ("remoteproc: imx_rproc: Use devm_add_action_or_reset() for scu cleanup")
Closes: https://sashiko.dev/#/bug/linux-1230a154-7627-4ce2-96f3-d0033709ba4e
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/remoteproc/imx_rproc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index a77a3342e1ed..9ff2cd50acb6 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -1083,10 +1083,6 @@ static int imx_rproc_scu_api_detect_mode(struct rproc *rproc)
 	else
 		priv->core_index = 0;
 
-	ret = devm_add_action_or_reset(dev, imx_rproc_put_scu, priv);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to add action for put scu\n");
-
 	/*
 	 * If Mcore resource is not owned by Acore partition, It is kicked by ROM,
 	 * and Linux could only do IPC with Mcore and nothing else.
@@ -1095,7 +1091,11 @@ static int imx_rproc_scu_api_detect_mode(struct rproc *rproc)
 		if (of_property_read_u32(dev->of_node, "fsl,entry-address", &priv->entry))
 			return -EINVAL;
 
-		return imx_rproc_attach_pd(priv);
+		ret = imx_rproc_attach_pd(priv);
+		if (ret)
+			return ret;
+
+		goto add_scu_action;
 	}
 
 	priv->rproc->state = RPROC_DETACHED;
@@ -1126,6 +1126,11 @@ static int imx_rproc_scu_api_detect_mode(struct rproc *rproc)
 		return ret;
 	}
 
+add_scu_action:
+	ret = devm_add_action_or_reset(dev, imx_rproc_put_scu, priv);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add action for put scu\n");
+
 	return 0;
 }
 
-- 
2.56.1.750.gf70dc682cf-goog

