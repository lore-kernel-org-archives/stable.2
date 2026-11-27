Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807609;
	b=XZ2/lXnwpouLyntrumFrOVmObHHj+xWbTBmNATNpHcdUdULD9nWFfdYlp/kmVg7r8uB+
	 ahoQQId4mYSqqgK4KbfQ/ssyJ0cShe2COh73X7OcJuMOl8J0nKbMmVszu8uGH0WNzduvH
	 W1QTRSaGgyh0pLOdmKSh77QDsQ+6WzeELflsyDSf4z+Qw3LJmb+zJrNTj2fBoknypqznx
	 FmHRLvuK1pluf6/7B3l1Aww4zwahniOgWbL3LQhOpyqR+Y8YKEhxJAg5pnddBUTuwKDXi
	 dpVtTYhMjvul0c3rlwSEaOSyJCsO4uaUzivVskv2p8JnlPO6LdvQtMnvv3CndbVN1og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807609;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=KmTpXtcBDYylw4bMy1QUBNJm5SIaR/wj97xpmFq2FM8=;
	b=UM2I7VP9d+7EoNT96PTcEFp/kjft0amigbjVgDl4kZiRM8O+6Bc925nUS8yKggNPTK64
	 A9AIQAfLkUhCXxS7zZr2v4ASkKkdACmaoALtk0vT0jBzgg+NHCs93GgZJF9lm+95vYvDm
	 KZduR7wYrUt9ZSSunkOmKYclcVsuQpQjm+WIaDPFvXcpjs5GkBBqkcgPtgezhu5O5ukOz
	 RokuJxQvZPCBn81YAM4U99+puiLsK+iNomrULOjVY9RfkoHJz6OCITyXlr7oa4TCPGlLt
	 bA94839HotkLnXEYHcennQ6OrYF9JHRI+rRckVkO2KPNUskI622u0lQVhk5MKc9NdwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="C4aTX/Kr";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F98606A31E;
	Fri, 27 Nov 2026 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4aTX/Kr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2B81F000C1;
	Fri, 27 Nov 2026 19:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795807608;
	bh=KmTpXtcBDYylw4bMy1QUBNJm5SIaR/wj97xpmFq2FM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C4aTX/KrS4lo0vrHheYzFPjTK8WwaqoFGm4RAe0sQJbWokgj5kmF1pprLmVo2IRal
	 HWvD2VNFZc9u+uMgqG1F4RpOmKq+j/xYCH1NSqR1dYMVILIanpmGeJ/wSYMD0rsppc
	 coDdARL5pgsdz2Z4d/gKhhLKtakJzPTnvjKe4LJzVKIHFgzf5NVSGJWDgm6jNQriZ9
	 xTxJFODMCh42wcLXcgwqukdEd/LYbebgQtEQf2QHW4aWa+A7ZXWWTu5CHaH3m/dLCG
	 W/qiElqFHPjEtyFAdlE3rzGsVVYUJ6fNKqrXBXi/+/AUYSgBlM+HIlel7RlUzs88Db
	 XkUkwoVanOFCQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Emil Renner Berthing <kernel@esmil.dk>,
	Hal Feng <hal.feng@starfivetech.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Xingyu Wu <xingyu.wu@starfivetech.com>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/10] clk: starfive: jh7110-sys: Use devres for PLL0 clock and notifier
Date: Fri, 27 Nov 2026 19:25:27 +0000
Message-ID: <20261127192620.3443537-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127192620.3443537-1-lee@kernel.org>
References: <20261127192620.3443537-1-lee@kernel.org>
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

jh7110_syscrg_probe() allocates priv with devm_kzalloc_flex() but
acquires pll0_out with clk_get() and registers &priv->pll_clk_nb with
unmanaged clk_notifier_register().  If any subsequent step in probe
fails, devres frees priv while the notifier stays registered on
pll0_out, resulting in a use-after-free on the next rate change and a
leaked clock reference.

Use devm_clk_get() and devm_clk_notifier_register() so both the notifier
and clock reference are released automatically in LIFO order before priv
is freed.

Fixes: 538d5477b252 ("clk: starfive: jh7110-sys: Add notifier for PLL0 clock")
Closes: https://sashiko.dev/#/bug/linux-43575972-eb4c-4bf9-8cfe-cef64199b7e2
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/starfive/clk-starfive-jh7110-sys.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/starfive/clk-starfive-jh7110-sys.c b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
index 44766b094b60..02ecf32fffdc 100644
--- a/drivers/clk/starfive/clk-starfive-jh7110-sys.c
+++ b/drivers/clk/starfive/clk-starfive-jh7110-sys.c
@@ -422,7 +422,7 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 		return PTR_ERR(priv->base);
 
 	/* Use fixed factor clocks if can not get the PLL clocks from DTS */
-	pllclk = clk_get(priv->dev, "pll0_out");
+	pllclk = devm_clk_get(priv->dev, "pll0_out");
 	if (IS_ERR(pllclk)) {
 		/* 24MHz -> 1000.0MHz */
 		priv->pll[0] = devm_clk_hw_register_fixed_factor(priv->dev, "pll0_out",
@@ -431,7 +431,8 @@ static int __init jh7110_syscrg_probe(struct platform_device *pdev)
 			return PTR_ERR(priv->pll[0]);
 	} else {
 		priv->pll_clk_nb.notifier_call = jh7110_pll0_clk_notifier_cb;
-		ret = clk_notifier_register(pllclk, &priv->pll_clk_nb);
+		ret = devm_clk_notifier_register(priv->dev, pllclk,
+						 &priv->pll_clk_nb);
 		if (ret)
 			return ret;
 		priv->pll[0] = NULL;
-- 
2.56.1.839.g22a8290db9-goog

