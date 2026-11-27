Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807602;
	b=oKWEO4d8oFhb6KOxh7Y36CEt3ZVok31R5ooJfL5xI5VlS++vhvZtObJXJwivZzNAduV4
	 mnrKJqxjnpp6jqk8j8Ioykhc5Bxk3WmfPO8fkEW9GphAyG0UPxmyNB1uXzBCl30ryYTHc
	 ZLKeh/8PFKNbI3BnatMjwta1FnnYGZhEKZdfZDTnG/tS3jjF7Cv2ZoxH2Y7CpCr3UUCSl
	 PuCao/sgMvg0UXKVmL6HyE65qx6xJm9G1hCJaLRE6vBPrFUKUAEcpNkDTTYD0McZiaXnO
	 0pFggKjWjn0pu7M4Zvgz56Nvhl+K8EMF41x9L6+8zGZYdECGKD/ZqFXIW598hficGug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807602;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2llvgPYmVf20EPpNRj/Z/PCJFuVrum95xaqaF5A+NNQ=;
	b=1Zl7pj2ADYcSejp85G0XLU3XfOjudO8qFYw0/8ln/P6teZhI0AWbvDOkWf6IFQpdMKsG
	 QPu/0oh413uhJT6TV+V6reedTyK+8NH2Y9tDFL1BwvCqbZsnbVUSswgN/BYG8BKRM/Pns
	 sjSmNvfg7Dgydm2tzM68h5liJ4PmSEABBMYuw1koJWLFOfzg8TDvoZsX2R/8CwvzE/aB8
	 Et1TdIM2qDur/bN+ke6DCJDsgVkREsEH9pe6OH34NSFK5R23b5UQfgbLTUovD5cKe+Cfh
	 tA127IrErU/4UXWEEJ8jcNQuqPKa/Tdcys64lWljpGDLZCAewwokmXkDDC/yufRoBFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiyhOXJL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B003B606A321;
	Fri, 27 Nov 2026 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NiyhOXJL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94F8A1F00925;
	Fri, 27 Nov 2026 19:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795807602;
	bh=2llvgPYmVf20EPpNRj/Z/PCJFuVrum95xaqaF5A+NNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NiyhOXJL0GHweYlETjzAnV1SkhN/Jge4+z/z5KT8bKwFD/lzH//gGJe/SlhwMb2pR
	 lft/ZAkUY/4ZQsPiBe0DO3EgQu3l84IJ0fWcjiyPzRHU51+uz5NIu52+OxwB5I58OD
	 Yvx4MS2Cu1lYdD3XvYq80k4Q4LBM/aAI8LRTUeSJpHxLA+rJeu6+pUVkE96j1hyHGE
	 abBd5OMxYVG1Rg/+Q6CxyH2ktQWnxIVogcRps/bzo7gBsA/4Val5UqAHk/nSz2rHYg
	 7QQQbLGCTQ4AmYhnebUbkqfjYkFd+V2FSwO9KfH/vZwdNYkcQWvgVefvnUq1j5ejBP
	 xZZ3wCLUx4+fQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Rosen Penev <rosenp@gmail.com>,
	linux-clk@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 02/10] clk: tegra: bpmp: Drop manual clock unregister on provider failure
Date: Fri, 27 Nov 2026 19:25:26 +0000
Message-ID: <20261127192620.3443537-3-lee@kernel.org>
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

tegra_bpmp_clk_register() registers every clock with
devm_clk_hw_register(), and tegra_bpmp_register_clocks_one() records
ERR_PTR values in bpmp->clocks[i] whenever an individual clock fails to
register.  If of_clk_add_hw_provider() fails,
tegra_bpmp_unregister_clocks() unconditionally dereferences
bpmp->clocks[i] and calls clk_hw_unregister(), crashing on any error
pointer and double-unregistering clocks when devres subsequently unwinds
on probe failure.

Remove tegra_bpmp_unregister_clocks() and rely on devres to unregister
the clocks cleanly.

Fixes: ca6f2796eef7 ("clk: tegra: Add BPMP clock driver")
Closes: https://sashiko.dev/#/bug/linux-e3e9ccfe-87c7-4de5-b6bb-9b6968df7cc4
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/tegra/clk-bpmp.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index 3649324e2e1f..e4b4f3eec777 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -648,14 +648,6 @@ static int tegra_bpmp_register_clocks(struct tegra_bpmp *bpmp,
 	return 0;
 }
 
-static void tegra_bpmp_unregister_clocks(struct tegra_bpmp *bpmp)
-{
-	unsigned int i;
-
-	for (i = 0; i < bpmp->num_clocks; i++)
-		clk_hw_unregister(&bpmp->clocks[i]->hw);
-}
-
 static struct clk_hw *tegra_bpmp_clk_of_xlate(struct of_phandle_args *clkspec,
 					      void *data)
 {
@@ -696,10 +688,6 @@ int tegra_bpmp_init_clocks(struct tegra_bpmp *bpmp)
 	err = of_clk_add_hw_provider(bpmp->dev->of_node,
 				     tegra_bpmp_clk_of_xlate,
 				     bpmp);
-	if (err < 0) {
-		tegra_bpmp_unregister_clocks(bpmp);
-		goto free;
-	}
 
 free:
 	kfree(clocks);
-- 
2.56.1.839.g22a8290db9-goog

