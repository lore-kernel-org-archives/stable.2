Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807634;
	b=P8hFKNzgQl2I1/Ew8QcwNLftTMlKQLXoeg/+7WkV8+dYN0cookcpUqteTkJRIp9qJ3RD
	 Db0UcIhR0vkUgfVx1toCoXS91D0ttg/tCK6X1yxqRxCCxQ+QlFfYETh++zPTCwYyiit0V
	 RzOdhi8JAutbjYPc8BSlBz/dtKl+VTtxrgN88rsQmwQPIjNv2PO+ilOQPyVqBm4eRRWvM
	 KpxUes+6QgqAcc8KYVy9bbDDsKUJHSEWzBrsyUA0fEzSdGR/ofXX3MgXPJzr6br+w6tVi
	 QhgWvWH65Zklhe9j8c/ZTT2N2jPoVplxiPOgyT5JLSnLFbWXK2qRDHCizrqZrdPG0Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807634;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FI3q+LQKOc1craXslqsXJTBzW5k4okKBPIXzUkvJAO0=;
	b=JHju8yGTGgMLWermygARqrmjfD7WxGC83zIP+O7VOoeC1PFlYTTaUJjktSdCu5MIJeg/
	 z7oeI0erVPHlKWphbs3SymDJLfqJa1Om/9SqZxiE29IgC0e9P2F5h8xJ6EOV7Aowdco5t
	 XFZM5wD/Vr1+R8Z9dmmRjWcmLWzO/plyLAGZiWbAfsqk7W1CvM3hpqKtRDErK1uRPM7uh
	 vI6JHU58dE/mAoKuUqIJsc3DzjI0h9tWcen1mrHGtIFXvUPZEkfPxJPGG3lqGcGruf3Dl
	 vKbmjx/5+YXT7W06LM4Esa9aNsQzPT+EEZzwr1KE3457gBeSy/XF289CO1MCxTKPpHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mxLPNcxk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DCC606A31E;
	Fri, 27 Nov 2026 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mxLPNcxk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629841F00897;
	Fri, 27 Nov 2026 19:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795807633;
	bh=FI3q+LQKOc1craXslqsXJTBzW5k4okKBPIXzUkvJAO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mxLPNcxkmvH8alhbHNnND8F8znuJD5aQ3SDpHdTUxpIMGWzG9s8qaTGqn8TSi8JUv
	 we1KOe4673pBmQxUd4GTJ2HqhKzCEOihWNe4jLkWmQ8NKv+2Mp8K1fjYo7UV9dHAWA
	 A8/MzINzMcB7Ln7vERBAgJEevejI125H85yWmfaRPWhH/bxtxVVfNffhqzz6BxftR2
	 jU+hv8YF28gq0U4HMnw7U8gpdPRGWbcP/jiyuna3zy8N4KuOx1df+CqyKGkoYfvtr0
	 L4xezs50jyfeXl3CBSsJrYqoRnKCpFvYl2vNGT6H1vUdNEhUbADv4rxIB9CbTkGZJ/
	 HIkhfh1vkqmGA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Rosen Penev <rosenp@gmail.com>,
	Timo Alho <talho@nvidia.com>,
	linux-clk@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 06/10] clk: tegra: bpmp: Skip ERR_PTR entries in tegra_bpmp_clk_of_xlate()
Date: Fri, 27 Nov 2026 19:25:30 +0000
Message-ID: <20261127192620.3443537-7-lee@kernel.org>
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

tegra_bpmp_register_clocks_one() intentionally stores ERR_PTR values in
bpmp->clocks[i] when registering a clock fails.  However,
tegra_bpmp_clk_of_xlate() only checks for NULL before dereferencing
clk->id, crashing on any failed clock slot.

Use IS_ERR_OR_NULL() when skipping unpopulated clock entries.

Fixes: 2db12b15c6f3 ("clk: tegra: Register clocks from root to leaf")
Closes: https://sashiko.dev/#/bug/linux-3d54138a-c3d2-4466-952a-f7e44259adfe
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/tegra/clk-bpmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index e4b4f3eec777..7cbdd7797623 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -657,7 +657,7 @@ static struct clk_hw *tegra_bpmp_clk_of_xlate(struct of_phandle_args *clkspec,
 	for (i = 0; i < bpmp->num_clocks; i++) {
 		struct tegra_bpmp_clk *clk = bpmp->clocks[i];
 
-		if (!clk)
+		if (IS_ERR_OR_NULL(clk))
 			continue;
 
 		if (clk->id == id)
-- 
2.56.1.839.g22a8290db9-goog

