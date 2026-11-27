Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795807596;
	b=BTUbRxlSzCPwMNApB67gyDLezbURx1dl/iSNfmINviVOhkr3Je9TGD+AfoTLje65xPM2
	 eM7iEnN2SZu2hfMhksjvLDNILLHmKmPGPIEAYa2ZV8/I0PkxFkVlRguSFB1/DEuhFkpBx
	 DaWiOn88+MXGCqpHgdXzWbBWAERgEYTfzrzaA6+npP2WARdOwShqGzvkw2kx410jSOAXf
	 yotqEOWiC+nKb2Fp/0kI9oy+ppFYhNUIHT9VcZpJhC3bK3MYOrTxwriCmuDgLANu4YBAS
	 58ls/zZvF0sSRcs2uO9CQ5uZBRCWAflq9lvo50fzKsq7jCLWefi+XrSAXTkKdmVeBFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795807596;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7vWduZwDmwvfW+iMUHUwW2mnE7TrHVtarqLJYlNgyVM=;
	b=KX4ldV0Uu/9yPaTIfmqswg13JWEpHSKZ+yIfLajE28MCfW0kagyFaUxM4jKi9Zsmg3A1
	 rm8PTpjtHcGaNhRQSq7O4mW9Br0E/QBH/spSi1TZJhNhCssmm24lDeYBDnWZygQ4e/1Fy
	 uPt6RBNAFesBjC9utS0RqsOgwsOGSTfCahid/lNXD7LS0AGyUfa6YO0q2tJN0dfPFX9DF
	 eZMr8JEPtL3tJ5zhqnusIKUdy3/WbOSS3VTTIfwbBXeJ+pHRDCayomEZtMt1+TT1XoRFj
	 E16qmRv2pjnGwNZD5qkO32dut+mQd+KON0NvtJo2uIZ7VtF1QFurADdJkLoNlSVUfRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQMEIvHd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63845606A327;
	Fri, 27 Nov 2026 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HQMEIvHd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1F11F0089B;
	Fri, 27 Nov 2026 19:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795807595;
	bh=7vWduZwDmwvfW+iMUHUwW2mnE7TrHVtarqLJYlNgyVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HQMEIvHdMCU1a73sPOyJVsUVOlIRaCg6gGHL2vIWp7wfosLLqKuXffG9jXuBaN9WU
	 TZIIe+qh5wdD70LJLdqe4UTw5SP47vhr2af6vGpgah9ltF+C/fmZEEPJFt5tTFeJDQ
	 v4vres0ZLVolzd6niLe4RNHRrFiNBJXKfYvys0/nZpqhj/Xh5Z3T6EtobxEZPdSnWG
	 7Y7nzU3Hvdu6PjPjKQm1ZZZ7gmyjy8PKoUe6+LyVsPH535CGYcxyes4FpV8bZ+4TXz
	 r4zXgbHe9p76Yf9iY4LEe/6fCmman9tFsoLzRk4ETfsIkyjBNUQLdE8zOllm6FEXMb
	 oIKANGFSqKMCw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Tero Kristo <kristo@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney+clk@redhat.com>,
	Jerome Brunet <jbrunet+clk@baylibre.com>,
	Tony Lindgren <tony@atomide.com>,
	Michael Turquette <mturquette@linaro.org>,
	linux-omap@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 01/10] clk: ti: fapll: Fix output clock array allocation and bounds check
Date: Fri, 27 Nov 2026 19:25:25 +0000
Message-ID: <20261127192620.3443537-2-lee@kernel.org>
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

ti_fapll_setup() allocates fd->outputs.clks as
sizeof(struct clk *) * MAX_FAPLL_OUTPUTS + 1, adding a single byte
rather than an extra pointer slot for the 1-based child synthesisers
stored at indices 1..MAX_FAPLL_OUTPUTS.  It also reads output_instance
into a signed int via of_property_read_u32_index() and indexes
fd->outputs.clks[output_instance] without bounds validation, allowing
out-of-bounds heap writes.

Allocate MAX_FAPLL_OUTPUTS + 1 pointer slots with kzalloc_objs(), store
output_instance as u32, and skip entries exceeding MAX_FAPLL_OUTPUTS.

Fixes: 163152cbbe32 ("clk: ti: Add support for FAPLL on dm816x")
Closes: https://sashiko.dev/#/bug/linux-48a97add-8ee5-49f5-b05c-925006d9ec42
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/clk/ti/fapll.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/fapll.c b/drivers/clk/ti/fapll.c
index 7d6a4dd4fc8c..d5e95e6489cd 100644
--- a/drivers/clk/ti/fapll.c
+++ b/drivers/clk/ti/fapll.c
@@ -549,9 +549,8 @@ static void __init ti_fapll_setup(struct device_node *node)
 	if (!fd)
 		return;
 
-	fd->outputs.clks = kzalloc(sizeof(struct clk *) *
-				   MAX_FAPLL_OUTPUTS + 1,
-				   GFP_KERNEL);
+	fd->outputs.clks = kzalloc_objs(*fd->outputs.clks,
+					MAX_FAPLL_OUTPUTS + 1);
 	if (!fd->outputs.clks)
 		goto free;
 
@@ -614,7 +613,7 @@ static void __init ti_fapll_setup(struct device_node *node)
 		const char *output_name;
 		void __iomem *freq, *div;
 		struct clk *synth_clk;
-		int output_instance;
+		u32 output_instance;
 		u32 v;
 
 		if (of_property_read_string_index(node, "clock-output-names",
@@ -625,6 +624,12 @@ static void __init ti_fapll_setup(struct device_node *node)
 					       &output_instance))
 			output_instance = i;
 
+		if (output_instance > MAX_FAPLL_OUTPUTS) {
+			pr_err("%pOFn invalid output_instance %u\n",
+			       node, output_instance);
+			continue;
+		}
+
 		freq = fd->base + (output_instance * 8);
 		div = freq + 4;
 
-- 
2.56.1.839.g22a8290db9-goog

