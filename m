Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.219.36.190
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794402293;
	b=JWjO2qFEDy0oFUeWYxtJxU4E8EndYLKS1uIt8YZ0/7yKgKlsCkupvt3qaMCpzrAySfxO
	 IK9ipqh240RaPtHdheDQb7xikOq422dMAMTxk3e/qQnBQXsUfvl6lDkvWkwyYsmTwyX8F
	 NrjQR2HU1xHR4Vhh/E5EbnPd8K8Q5InX0hl2wM57VzK7olAwghExzd5m7zEMm8AXVWzA/
	 oDamPTbJrTFKi8vLI5uqlu9AFWRn8Bs7dFhG+Uk5a3XjiOawpli4B2RfL36d4C1FQ0cUL
	 hcFgbq/9Ih7JhLseet3VQJSem2F5VhhbiFWU1a5ly7iT9AbhdXa5pavhBugHXiox0yQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794402293;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6G+pw+teY+QNpHzmCsxDpYnI0ruF/BglJQxzs6UK3iM=;
	b=bz0AUj4Bl1Y74Rblir5B60Zn1HyIJxtBwd0kikM4kO5hYpGevoy4UHC64YDf58nmoPxO
	 qYvI+Hdc27/PKhOSWyfoCaZ+MMQzULOj9cOxsQdNrVkOGRpI8Utks7kEQSWdN8u0krMvP
	 vp7JKxdoeeInirj6BgS5NEqX7MNtCd1+2nszuu6RVOuZJVwMf1yeMaIrmL7c3rdXAKvcm
	 zQCgSevDQmFa7waolXYOljgg5dyJsJr7tCb829qpwqAXnuUj9hV3YyVMfRxrmltZBkMlF
	 3H6WW+FTAJkWsNxQNVXZ7ou3SthQSC5V4CLKQ0YNYX5GqBN0qoapiH4TjY2xia85r2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=alpinelinux.org;
	spf=pass smtp.mailfrom=alpinelinux.org;
	dkim=pass header.d=alpinelinux.org header.i=@alpinelinux.org header.a=rsa-sha256 header.s=smtp header.b=PLiO8SMG;
	arc=none smtp.remote-ip=213.219.36.190
Received: from gbr-app-1.alpinelinux.org (gbr-app-1.alpinelinux.org [213.219.36.190])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCB9606A324;
	Wed, 11 Nov 2026 13:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCCB9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpinelinux.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=alpinelinux.org header.i=@alpinelinux.org header.a=rsa-sha256 header.s=smtp header.b=PLiO8SMG
Received: from ncopa-desktop.lan (unknown [IPv6:2001:4646:fb05:0:3161:925b:8dfd:3d53])
	(Authenticated sender: ncopa@alpinelinux.org)
	by gbr-app-1.alpinelinux.org (Postfix) with ESMTPSA id 953BE224165;
	Wed, 11 Nov 2026 13:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpinelinux.org;
	s=smtp; t=1794402285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6G+pw+teY+QNpHzmCsxDpYnI0ruF/BglJQxzs6UK3iM=;
	b=PLiO8SMGdBF6l+7TgGcRi1TW3dgupmrEEJVoZVmuBxqEXnsIbBBgAwDgODz1mjNSj8mYk7
	+CVDm0M+kt45YbVugTpYaBGanJLbsO1BAQWFNl+oCVbx2Ec6x2OHCmdTyB/lUvSR0TWEdB
	QnuLnNW2msULPT0JiE/xD9aL4IBU70U=
From: Natanael Copa <ncopa@alpinelinux.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	=?UTF-8?q?Milan=20P=20=2E=20Stani=C4=87?= <mps@arvanta.net>,
	Natanael Copa <ncopa@alpinelinux.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@kernel.org>,
	Troy Mitchell <troy.mitchell@linux.spacemit.com>,
	Shuwei Wu <shuwei.wu@mailbox.org>,
	Aurelien Jarno <aurelien@aurel32.net>,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH] cpufreq: dt: Set the initial OPP to apply its voltage constraints
Date: Wed, 11 Nov 2026 14:04:26 +0100
Message-ID: <20261111130430.10359-1-ncopa@alpinelinux.org>
X-Mailer: git-send-email 2.56.1
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

The cpufreq core skips requests for the current frequency, so a policy
has no voltage constraint on its supply until its first frequency
change. Another policy sharing the supply can then lower the voltage
too far.

On the SpacemiT K1, both clusters share one supply and boot at 1.6 GHz.
When policy0 scales down, the supply drops to 0.95 V while policy4
still runs at 1.6 GHz, causing random crashes during boot.

Set the OPP for the current clock rate of all CPUs before registering
the driver.

Fixes: 3b9c34556fc1 ("riscv: dts: spacemit: Add cpu scaling for K1 SoC")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Assisted-by: Claude:claude-fable-5-2
Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
---
Reproducer, booted with cpufreq.default_governor=performance:

  # echo 614400 > /sys/devices/system/cpu/cpufreq/policy0/scaling_max_freq

buck1 drops to 950000 uV while policy4 is still at 1600000 kHz, which
crashed my board within seconds.

Tested on a Banana Pi BPI-F3 with v7.3.3 and v7.4-rc2. Without the
patch, v7.3.3 crashed on every boot with schedutil (three). With the
patch, the reproducer keeps buck1 at 1050000 uV, and five boots with
schedutil were clean on each kernel. Not tested on other SoCs.

Other OPP users that never set their current OPP have the same gap. If
you would rather fix this in the OPP core, I can rework it.

Found and fixed with the help of an AI assistant (Claude). I reviewed
and tested the result.

 drivers/cpufreq/cpufreq-dt.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index eb15650f99bf..2646dda10aac 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -153,6 +153,30 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.suspend = cpufreq_generic_suspend,
 };
 
+/*
+ * Set the OPP for the current clock rate, so that its voltage constraints
+ * apply before any policy can change frequency. Otherwise another policy
+ * sharing the supply could lower the voltage below what this one needs.
+ */
+static void dt_cpufreq_set_initial_opp(struct device *cpu_dev)
+{
+	struct clk *clk = clk_get(cpu_dev, NULL);
+	unsigned long rate;
+	int ret;
+
+	if (IS_ERR(clk))
+		return;
+
+	rate = clk_get_rate(clk);
+	clk_put(clk);
+	if (!rate)
+		return;
+
+	ret = dev_pm_opp_set_rate(cpu_dev, rate);
+	if (ret)
+		dev_warn(cpu_dev, "failed to set initial OPP: %d\n", ret);
+}
+
 static int dt_cpufreq_early_init(struct device *dev, int cpu)
 {
 	struct private_data *priv;
@@ -251,6 +275,8 @@ static int dt_cpufreq_early_init(struct device *dev, int cpu)
 		goto out;
 	}
 
+	dt_cpufreq_set_initial_opp(cpu_dev);
+
 	list_add(&priv->node, &priv_list);
 	return 0;
 

base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
-- 
2.56.1

