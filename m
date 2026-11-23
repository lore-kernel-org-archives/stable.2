Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452547;
	b=k9GHX9KyPAkmGrja4vcesguq0HXvHItmPcjU0aqw80Fa22OzgDgxikyyvadM3sBsZnU4
	 zJoI3b73yQlISye0vTeSja7qe7/PP/bRH26w0anUnW+mV9d1k8K/9CDbDbf6VzsGnd6rg
	 cJYpCuJ6Mge/hhzyp7C9wwt9wJnakVxlc131OoMPJJXTsrVx0BNkr36/1CGdA9FhWu9h8
	 KbmKxL1pxTzWmPxrzFhcT8Tp01FHfryASIgaFYmGXwQ//u8v8KN+I9pI77WM1iwVyMfmb
	 KrMQmNvrb/KnJtZmMjlMUIs5r3BLir5uztU+CulS/Qu6mNVXJCSV8p4R0BeqQya80fA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452547;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=apULIBVfF11sV6vYsTGwYxkSOIFhWMfQwI58pA8i77k=;
	b=l2OjsNvBWZ3Vi3oLXX4niAHmYMvpizBHL1I/RqraOx5UatQvBAynWUTQ09IapLuL4O9g
	 zhaeE8d0Sk5jeG2dyjt83Oe852hC3ruXGjEN5OJc1VO12nCRa44f1RMfh++dXRTfOTQEm
	 /Vyt5OsIEnxkonl3ZlTQ0V+JY67dLzhGq3DP4gzrAcsyrifQJUKESMxHlGnrCHh60EaZa
	 a3RkIc2tdyroDaIL9hcmhBUDVIXTuBcjzmFAG7I6qcQuOGMseJHaYS6Av5Msnumt8vD7b
	 U9wvcTWqvweq8Yp2xSPEsOBWoM8+Di+6u4uQWYKsjkcflK1WUWRdJP/FpYvlIhdHwoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XK+oRuQm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CE1606A336;
	Mon, 23 Nov 2026 16:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XK+oRuQm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DEF1F000C6;
	Mon, 23 Nov 2026 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795452546;
	bh=apULIBVfF11sV6vYsTGwYxkSOIFhWMfQwI58pA8i77k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XK+oRuQmSQXj0ipiwZXiNBR7QIwI/w2+COd1Y90LCJkrbZm+dcxP3xJA7W81MWKLO
	 3A3DQxKsWuH9Z8bSA/g4ywHYNdxmTDX5DK9GzRImJ6zmCGWE7N1YwtfM22Uit3/lKn
	 bqCOjqPVlQsnGIt2wccwwDEPLeN0KIV1VJMGxNi6r8yZvcJlTUjLN2uvLHNXKbu/Vp
	 SG2uMnDiT/7fJNB4aGjVZKJzjGzC1KPlZApEKDkC6aAl/snNIAhl+xZw/Xoh9/kYX9
	 mb4dIGXv+qBQvEZjhQnUYVMtWft4Mg+DfsQ+WkRbBhzUPgWKY2YTAmbIqKTVtfZNbP
	 jnsr5ECenkYzA==
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
Subject: [PATCH 03/10] clk: tegra: bpmp: Bound num_parents by MRQ_CLK_MAX_PARENTS
Date: Mon, 23 Nov 2026 16:47:36 +0000
Message-ID: <20261123164834.3330320-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123164834.3330320-1-lee@kernel.org>
References: <20261123164834.3330320-1-lee@kernel.org>
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

Both cmd_clk_get_all_info_response and tegra_bpmp_clk_info size their
parents arrays to MRQ_CLK_MAX_PARENTS (16), whereas response.num_parents
is an 8-bit unsigned integer received from BPMP firmware.

tegra_bpmp_clk_get_info() copies response.num_parents entries from the
stack response into the heap info structure without checking against
MRQ_CLK_MAX_PARENTS, and the caller only checks against U8_MAX after the
copy has already overflowed both arrays.

Validate that response.num_parents does not exceed MRQ_CLK_MAX_PARENTS
before copying parent IDs, and drop the redundant U8_MAX check.

Fixes: ca6f2796eef7 ("clk: tegra: Add BPMP clock driver")
Closes: https://sashiko.dev/#/bug/linux-785615f3-ab51-451a-b58c-fe29c7f09bfe
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/tegra/clk-bpmp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/tegra/clk-bpmp.c b/drivers/clk/tegra/clk-bpmp.c
index 0bb28f96274f..3649324e2e1f 100644
--- a/drivers/clk/tegra/clk-bpmp.c
+++ b/drivers/clk/tegra/clk-bpmp.c
@@ -376,6 +376,13 @@ static int tegra_bpmp_clk_get_info(struct tegra_bpmp *bpmp, unsigned int id,
 			return -E2BIG;
 	}
 
+	if (response.num_parents > MRQ_CLK_MAX_PARENTS) {
+		dev_err(bpmp->dev,
+			"clock %u has too many parents (%u, max: %u)\n",
+			id, response.num_parents, MRQ_CLK_MAX_PARENTS);
+		return -EINVAL;
+	}
+
 	info->num_parents = response.num_parents;
 
 	for (i = 0; i < info->num_parents; i++)
@@ -453,13 +460,6 @@ static int tegra_bpmp_probe_clocks(struct tegra_bpmp *bpmp,
 		if (err < 0)
 			continue;
 
-		if (info->num_parents >= U8_MAX) {
-			dev_err(bpmp->dev,
-				"clock %u has too many parents (%u, max: %u)\n",
-				id, info->num_parents, U8_MAX);
-			continue;
-		}
-
 		/* clock not exposed by BPMP */
 		if (info->name[0] == '\0') {
 			holes++;
-- 
2.56.1.750.gf70dc682cf-goog

