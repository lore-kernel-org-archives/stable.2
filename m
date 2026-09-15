Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A8347F3DB;
	Tue, 15 Sep 2026 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461735; cv=none; b=imLuuUY2M1gUAuyORWB/z0TRMUUXHBSMQDj8jTlh8hwABwIkdqRj8PJawi85jJ5zvL9TgZ3AxOJbDRLpLpnnSU5jO48BABaLzvY3j26TluVNaJFD/9T5YO+4lUlZ3uAPYCItB9pZvu2SX6Egz3VnkA8LDj7z66QLR9Y6S/GCbks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461735; c=relaxed/simple;
	bh=7xr9fV35wkpbEG8vb7jhU0pm3GhxiOo8E0GjQBmR/Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uhO+BaRXJeGHutYYPhFLubibOtHJT3uGU8H88TMvQ53UzIqpUSKsHAfwv65ZwnPZL7txCDq0Gb/3+mSYyonZmPktsVIlFm4eWI/7Szb5RALiiOEO/2amM7LqqptZuQXabDmXuzx1fiCFk55pmdf+zOkjrcIQaM2g5xJUioodiSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RD/6cYSI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RD/6cYSI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510691F00893;
	Tue, 15 Sep 2026 08:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789461732;
	bh=uAhUh57+k9wtUJ4p0cX1YRy5WdPv5wRBmzNr5pOCGzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RD/6cYSIuI4eESkGyLjgPbm6J+fUdewl8YBrHQ3Y1aT7J03KKuP/nEqkB2TPKfRQ8
	 aIesG80a2a2bPh/vWL9F5Osj/+ZXG6/az9kKxNX5mWxhLX9cfHm3AWy3eehmYOXZsl
	 pHdxTwOYS4Ch/SMDtwYRNnfnqwd3qtI72sm0qxl7QxgrtvwUXn44ICu7jWN6P9rKlY
	 LOXiDzAAFTf1V8vT0GDpY4qgzV0GK1vsYFEiIPYmznGPOCHhuziurQwDcx1jsw6jPr
	 Nt97yTs6K/syUW1R4bY+cJgev3Nz9GiSvcajV883WjHKcUFaZQN+JEaiRWB3Y33EfV
	 l+zsSHQpjbTzg==
From: Niklas Cassel <cassel@kernel.org>
To: Patrice Chotard <patrice.chotard@foss.st.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Alexandre Torgue <alexandre.torgue@st.com>,
	Lee Jones <lee@kernel.org>,
	Tejun Heo <tj@kernel.org>
Cc: Brian Norris <computersforpeace@gmail.com>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-ide@vger.kernel.org
Subject: [PATCH v5 1/6] ata: ahci_st: Do not ignore errors when getting the reset controls
Date: Tue, 15 Sep 2026 10:41:27 +0200
Message-ID: <20260915084127.692494-9-cassel@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260915084127.692494-8-cassel@kernel.org>
References: <20260915084127.692494-8-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2948; i=cassel@kernel.org; h=from:subject; bh=7xr9fV35wkpbEG8vb7jhU0pm3GhxiOo8E0GjQBmR/Bw=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGLJWsuz5XH162x6LC5H/A331Fnxo3CWedlyuwfyQrWLRt AcfeQQiOkpZGMS4GGTFFFl8f7jsL+52n3Jc8Y4NzBxWJpAhDFycAjCRrxoM/z0vnmv+Pju3bYkU lyXXw3NLgt8/iLnmIc6l5WK6vHtnvhEjw51bIY+TL5Td3TYz4E1xra7t7rVuZld4b5j5yJ6rmr3 0HSsA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

st_ahci_probe_resets() treats any error from devm_reset_control_get() as
"reset control not defined" and continues with a NULL reset control:

	drv_data->pwr = devm_reset_control_get(dev, "pwr-dwn");
	if (IS_ERR(drv_data->pwr)) {
		dev_info(dev, "power reset control not defined\n");
		drv_data->pwr = NULL;
	}

This also swallows -EPROBE_DEFER, which is returned when the reset
controller providing the reset has not been probed yet. probe() then
continues as if the device tree did not specify any reset, so the resets
of the SATA IP are never deasserted, and st_ahci_configure_oob() and
ahci_platform_init_host() access the MMIO of an IP which is still held in
reset and powered down, which can result in an external abort.

The resets are optional in the binding, as they are not part of its
required properties, so use devm_reset_control_get_optional(), which
returns NULL if the reset is not specified in the device tree, and
propagate all other errors.

Note that an absent reset is now indicated by a NULL reset control
instead of an error, so the "reset control not defined" messages are
dropped.

Fixes: 76884cb2f7da ("ahci: st: Add support for ST's SATA IP")
Cc: stable@vger.kernel.org
Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/ata/ahci_st.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/drivers/ata/ahci_st.c b/drivers/ata/ahci_st.c
index 4336c8a6e208..819269a022ef 100644
--- a/drivers/ata/ahci_st.c
+++ b/drivers/ata/ahci_st.c
@@ -104,23 +104,20 @@ static int st_ahci_probe_resets(struct ahci_host_priv *hpriv,
 {
 	struct st_ahci_drv_data *drv_data = hpriv->plat_data;
 
-	drv_data->pwr = devm_reset_control_get(dev, "pwr-dwn");
-	if (IS_ERR(drv_data->pwr)) {
-		dev_info(dev, "power reset control not defined\n");
-		drv_data->pwr = NULL;
-	}
-
-	drv_data->sw_rst = devm_reset_control_get(dev, "sw-rst");
-	if (IS_ERR(drv_data->sw_rst)) {
-		dev_info(dev, "soft reset control not defined\n");
-		drv_data->sw_rst = NULL;
-	}
-
-	drv_data->pwr_rst = devm_reset_control_get(dev, "pwr-rst");
-	if (IS_ERR(drv_data->pwr_rst)) {
-		dev_dbg(dev, "power soft reset control not defined\n");
-		drv_data->pwr_rst = NULL;
-	}
+	drv_data->pwr = devm_reset_control_get_optional(dev, "pwr-dwn");
+	if (IS_ERR(drv_data->pwr))
+		return dev_err_probe(dev, PTR_ERR(drv_data->pwr),
+				     "failed to get pwr-dwn reset\n");
+
+	drv_data->sw_rst = devm_reset_control_get_optional(dev, "sw-rst");
+	if (IS_ERR(drv_data->sw_rst))
+		return dev_err_probe(dev, PTR_ERR(drv_data->sw_rst),
+				     "failed to get sw-rst reset\n");
+
+	drv_data->pwr_rst = devm_reset_control_get_optional(dev, "pwr-rst");
+	if (IS_ERR(drv_data->pwr_rst))
+		return dev_err_probe(dev, PTR_ERR(drv_data->pwr_rst),
+				     "failed to get pwr-rst reset\n");
 
 	return st_ahci_deassert_resets(hpriv, dev);
 }
-- 
2.55.0

